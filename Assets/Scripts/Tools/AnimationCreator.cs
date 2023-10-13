using System.Collections.Generic;
using System.Collections;
using UnityEngine;
using System.Text.RegularExpressions;
using UnityEditor.Animations;
using UnityEngine.Events;
using System.Security.Cryptography;

[ExecuteInEditMode]
public class AnimationCreator : MonoBehaviour
{
	[SerializeField]
	private bool createAnimator = false;
	[SerializeField]
	private string input;

	private void Update()
	{
		if (createAnimator)
		{
			createAnimator = false;

			Dictionary<string, string> parameters = ParseParameters(input);
			StateMachine sm = ParseStateMachine(input);

			//StartCoroutine(SaveAnimator(sm, Application.dataPath, parameters));
		}
	}

	IEnumerator SaveAnimator(StateMachine sm, string dataPath, Dictionary<string, string> parameters)
	{
		yield return new WaitForSeconds(1);

		CreateAndSaveAnimatorController(sm, dataPath, parameters);
		yield break;
	}

	public enum BlendType
	{
		Simple1D,
		Simple2D,
		Freeform2D,
		FreeformCartesian2D,
		Direct
	}

	public class AnimationClip
	{
		public string Name { get; set; }

		public AnimationClip(string name)
		{
			Name = name;
		}
	}

	public class BlendTree
	{
		public string Name { get; set; }
		public BlendType Type { get; set; }
		public List<object> Children { get; set; } // This can be another BlendTree or an AnimationClip

		public BlendTree(string name, BlendType type)
		{
			Name = name;
			Type = type;
			Children = new List<object>();
		}
	}

	public class StateMachine
	{
		public string Name { get; set; }
		public List<object> Children { get; set; } // This can be a BlendTree, StateMachine or an AnimationClip

		public StateMachine(string name)
		{
			Name = name;
			Children = new List<object>();
		}
	}

	public StateMachine ParseStateMachine(string input)
	{
		int currentIndex = 0;

		StateMachine ParseSM()
		{
			Match match = Regex.Match(input.Substring(currentIndex), @"(.+)\(StateMachine\)\s*{");
			if (!match.Success) return null;

			currentIndex += match.Length;
			StateMachine sm = new StateMachine(match.Groups[1].Value.Trim());

			while (input[currentIndex] != '}')
			{
				if (Regex.IsMatch(input.Substring(currentIndex), @"(.+)\(StateMachine\)"))
				{
					sm.Children.Add(ParseSM());
				}
				else if (Regex.IsMatch(input.Substring(currentIndex), @"(.+)\(BlendTree:(.+)\)"))
				{
					sm.Children.Add(ParseBT());
				}
				else
				{
					sm.Children.Add(ParseAC());
				}
			}
			Debug.Log("State machine parsed successfully!");

			currentIndex++; // Skip the closing brace '}'
			return sm;
		}

		BlendTree ParseBT()
		{
			Match match = Regex.Match(input.Substring(currentIndex), @"(.+)\(BlendTree:(.+)\)\s*{");
			if (!match.Success) return null;

			currentIndex += match.Length;
			Debug.Log(match.Groups[2].Value.Trim() + ". Expected result: " + BlendType.FreeformCartesian2D);
			BlendType type = (BlendType)System.Enum.Parse(typeof(BlendType), match.Groups[2].Value.Trim());
			BlendTree bt = new BlendTree(match.Groups[1].Value.Trim(), type);

			while (input[currentIndex] != '}')
			{
				if (Regex.IsMatch(input.Substring(currentIndex), @"(.+)\(BlendTree:(.+)\)"))
				{
					bt.Children.Add(ParseBT());
				}
				else
				{
					bt.Children.Add(ParseAC());
				}
			}

			currentIndex++; // Skip the closing brace '}'
			return bt;
		}

		AnimationClip ParseAC()
		{
			Match match = Regex.Match(input.Substring(currentIndex), @"(.+)\(AnimationClip\),?");
			if (!match.Success) return null;

			currentIndex += match.Length;
			return new AnimationClip(match.Groups[1].Value.Trim());
		}

		return ParseSM();
	}

	public void CreateAndSaveAnimatorController(StateMachine sm, string path, Dictionary<string, string> parameters)
	{
		AnimatorController controller = AnimatorController.CreateAnimatorControllerAtPath(path);

		foreach (var param in parameters)
		{
			switch (param.Value.ToLower())
			{
				case "float":
					controller.AddParameter(param.Key, AnimatorControllerParameterType.Float);
					break;
				case "int":
					controller.AddParameter(param.Key, AnimatorControllerParameterType.Int);
					break;
				case "bool":
					controller.AddParameter(param.Key, AnimatorControllerParameterType.Bool);
					break;
				case "trigger":
					controller.AddParameter(param.Key, AnimatorControllerParameterType.Trigger);
					break;
				default:
					Debug.LogWarning($"Unknown parameter type '{param.Value}' for parameter '{param.Key}'.");
					break;
			}
		}

		AddStateMachineToController(controller.layers[0].stateMachine, sm);

		Debug.Log("Animator parsed successfully! Attempting to save...");

		UnityEditor.AssetDatabase.SaveAssets();

		Debug.Log("Animator saved successfully!");
	}


	private void AddStateMachineToController(AnimatorStateMachine asm, StateMachine sm)
	{
		foreach (var child in sm.Children)
		{
			if (child is AnimationClip clip)
			{
				AnimatorState state = asm.AddState(clip.Name);
				// Assign the actual Unity AnimationClip to the state if you have it.
			}
			else if (child is BlendTree bt)
			{
				UnityEditor.Animations.BlendTree unityBlendTree = new UnityEditor.Animations.BlendTree();
				AnimatorState blendTreeState = asm.AddState(bt.Name, new Vector2(300, 0)); // Position for visualization in the Animator window
				blendTreeState.motion = unityBlendTree;

				SetupBlendTree(unityBlendTree, bt);
			}
			// Handle nested state machines similarly if required.
		}
	}

	private void SetupBlendTree(UnityEditor.Animations.BlendTree unityBlendTree, BlendTree parsedBlendTree)
	{
		unityBlendTree.blendType = ConvertToUnityBlendType(parsedBlendTree.Type);
		unityBlendTree.blendParameter = "ParameterName"; // This should be set according to your needs

		foreach (var child in parsedBlendTree.Children)
		{
			if (child is AnimationClip clip)
			{
				// Assign the actual Unity AnimationClip to the blend tree's child motion.
				ChildMotion motion = new ChildMotion();
				motion.motion = null; // Assign your Unity AnimationClip here
				unityBlendTree.AddChild(motion.motion);
			}
			else if (child is BlendTree nestedBlendTree)
			{
				// Create a new Unity BlendTree for the nested blend tree
				UnityEditor.Animations.BlendTree unityNestedBlendTree = new UnityEditor.Animations.BlendTree();

				// Setup the nested blend tree recursively
				SetupBlendTree(unityNestedBlendTree, nestedBlendTree);

				// Add the nested blend tree to the parent blend tree
				ChildMotion nestedMotion = new ChildMotion();
				nestedMotion.motion = unityNestedBlendTree;
				unityBlendTree.AddChild(nestedMotion.motion);
			}
		}
	}

	private BlendTreeType ConvertToUnityBlendType(BlendType blendType)
	{
		switch (blendType)
		{
			case BlendType.Simple1D:
				return BlendTreeType.Simple1D;
			case BlendType.Simple2D:
				return BlendTreeType.SimpleDirectional2D;
			case BlendType.Freeform2D:
				return BlendTreeType.FreeformDirectional2D;
			case BlendType.FreeformCartesian2D:
				return BlendTreeType.FreeformCartesian2D;
			case BlendType.Direct:
				return BlendTreeType.Direct;
			default:
				throw new System.ArgumentException("Invalid BlendType");
		}
	}

	private Dictionary<string, string> ParseParameters(string input)
	{
		Dictionary<string, string> parameters = new Dictionary<string, string>();

		Match match = Regex.Match(input, @"Parameters\s*{\s*((?:.+\(.*\),?\s*)+)}");
		if (match.Success)
		{
			string[] parameterLines = match.Groups[1].Value.Trim().Split('\n');
			foreach (var line in parameterLines)
			{
				Match paramMatch = Regex.Match(line, @"(\w+)\((\w+)\)");
				if (paramMatch.Success)
				{
					parameters.Add(paramMatch.Groups[1].Value, paramMatch.Groups[2].Value);
				}
			}
		}

		Debug.Log("Parameters parsed successfully!");

		return parameters;
	}
}
