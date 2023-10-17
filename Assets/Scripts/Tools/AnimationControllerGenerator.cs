//using UnityEngine;
//using UnityEditor;
//using System.Collections.Generic;
//using UnityEditor.Animations;
//using System;
//using System.Text;
//using UnityEngine.Networking;
//using System.Threading.Tasks;
//using System.Runtime.CompilerServices;
//using System.Linq;

//public class AnimationControllerGenerator : EditorWindow
//{
//	private string prompt;
//	private string folderToAnimations;
//	private string folderToSaveController;
//	private List<UserVariables> userVariablesList = new List<UserVariables>();
//	private Vector2 scrollPosition;
//	public static string apiKey = "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";
//	public static string model = "gpt-3.5-turbo";

//	public static int delay = 22;
//	public static bool first = true;

//	[MenuItem("Tools/Animation Controller Generator")]
//	public static void ShowWindow()
//	{
//		GetWindow(typeof(AnimationControllerGenerator), false, "Animation Controller Generator");
//	}

//	private void OnGUI()
//	{
//		GUILayout.Label("Animation Controller Generator", EditorStyles.boldLabel);

//		prompt = EditorGUILayout.TextField("Prompt:", prompt);
//		apiKey = "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";//EditorGUILayout.TextField("OpenAI API Key:", apiKey);
//		model = "gpt-4";//EditorGUILayout.TextField("GPT Model:", model);
//		delay = EditorGUILayout.IntField("Delay:", delay);
//		folderToAnimations = EditorGUILayout.TextField("Animations Folder Path:", folderToAnimations);

//		// Add a flexible space between the fields
//		GUILayout.FlexibleSpace();

//		scrollPosition = EditorGUILayout.BeginScrollView(scrollPosition);
//		List<UserVariables> itemsToRemove = new List<UserVariables>();

//		for (int i = 0; i < userVariablesList.Count; i++)
//		{
//			EditorGUILayout.BeginHorizontal();
//			userVariablesList[i].variableName = EditorGUILayout.TextField("Variable Name:", userVariablesList[i].variableName);
//			userVariablesList[i].variableType = (VariableType)EditorGUILayout.EnumPopup("Variable Type:", userVariablesList[i].variableType);
//			if (GUILayout.Button("Remove"))
//			{
//				itemsToRemove.Add(userVariablesList[i]);
//			}
//			EditorGUILayout.EndHorizontal();
//		}

//		foreach (var item in itemsToRemove)
//		{
//			userVariablesList.Remove(item);
//		}

//		if (GUILayout.Button("Add Variable"))
//		{
//			userVariablesList.Add(new UserVariables());
//		}
//		EditorGUILayout.EndScrollView();


//		folderToSaveController = EditorGUILayout.TextField("Save Controller To:", folderToSaveController);

//		if (GUILayout.Button("Generate"))
//		{
//			GenerateAnimationController();
//		}
//	}

//	private async void GenerateAnimationController()
//	{
//		AnimationClip[] clips = GetAnimationClips();
//		if (clips == null || clips.Length == 0)
//		{
//			Debug.LogError("No animation clips found. Make sure the path is correct.");
//			return;
//		}

//		AnimatorController controller = AnimatorController.CreateAnimatorControllerAtPath(folderToSaveController);

//		// Integrate user variables
//		foreach (var variable in userVariablesList)
//		{
//			switch (variable.variableType)
//			{
//				case VariableType.Float:
//					controller.AddParameter(variable.variableName, AnimatorControllerParameterType.Float);
//					break;
//				case VariableType.Trigger:
//					controller.AddParameter(variable.variableName, AnimatorControllerParameterType.Trigger);
//					break;
//				case VariableType.Int:
//					controller.AddParameter(variable.variableName, AnimatorControllerParameterType.Int);
//					break;
//				case VariableType.Bool:
//					controller.AddParameter(variable.variableName, AnimatorControllerParameterType.Bool);
//					break;
//			}
//		}

//		// Only focusing on the Base Layer
//		AnimatorControllerLayer baseLayer = controller.layers[0];

//		// Gather the names of all animations
//		List<string> animationNames = clips.Select(clip => clip.name).ToList();

//		// Ask GPT to categorize the animations into blend trees based on the user's prompt
//		Dictionary<string, List<string>> blendTreeCategorization = await GetBlendTreeCategorizationFromGPT(animationNames);

//		// Create blend trees based on GPT's categorization
//		foreach (var category in blendTreeCategorization)
//		{
//			var blendTreeName = category.Key;
//			var animationsInBlendTree = category.Value;

//			var blendTree = new BlendTree();
//			ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0, ScriptableObject.CreateInstance<DoCreateBlendTree>(), $"New {blendTreeName}.blendtree", null, null);
//			string path = AssetDatabase.GetAssetPath(Selection.activeObject);
//			AssetDatabase.CreateAsset(blendTree, path);

//			foreach (var animationName in animationsInBlendTree)
//			{
//				var anim = clips.FirstOrDefault(clip => clip.name == animationName);
//				if (anim != null)
//				{
//					// Add each animation to the blend tree
//					blendTree.AddChild(anim);
//				}
//			}
//			baseLayer.stateMachine.AddMotion(blendTree);
//		}

//		// Fetch transitions using GPT (this remains unchanged)
//		List<string> transitions = await GetTransitionsForState("Base Layer");
//		foreach (string transitionName in transitions)
//		{
//			var fromState = baseLayer.stateMachine.FindState(transitionName.Split(' ')[0]);
//			var toState = baseLayer.stateMachine.FindState(transitionName.Split(' ')[2]);
//			if (fromState != null && toState != null)
//			{
//				fromState.AddTransition(toState);
//			}
//		}
//	}

//	private async Task<Dictionary<string, List<string>>> GetBlendTreeCategorizationFromGPT(List<string> animationNames)
//	{
//		var promptBuilder = new StringBuilder($"Given the context '{prompt}' and the following animation names: ");
//		promptBuilder.AppendLine(string.Join(", ", animationNames));
//		promptBuilder.AppendLine("How should these animations be categorized into blend trees?");

//		var (response, _) = await API.GetCompletionFromOpenAI(promptBuilder.ToString(), model, 0.5f);

//		// Here, we assume GPT returns a response like:
//		// WalkingBlendTree: Walk Forward, Walk Backward, ...
//		// RunningBlendTree: Run Forward, Run Backward, ...
//		// And so on...
//		Dictionary<string, List<string>> categorization = new Dictionary<string, List<string>>();
//		var lines = response.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.RemoveEmptyEntries);
//		foreach (var line in lines)
//		{
//			var parts = line.Split(':');
//			if (parts.Length == 2)
//			{
//				var blendTreeName = parts[0].Trim();
//				var animations = parts[1].Split(',').Select(s => s.Trim()).ToList();
//				categorization[blendTreeName] = animations;
//			}
//		}
//		return categorization;
//	}

//	private List<string> ParseLayers(string layersResponse)
//	{
//		if (layersResponse != null)
//		{
//			return new List<string>(layersResponse.Split('\n'));
//		}
//		else
//		{
//			Debug.LogError("Failed to create/parse layer list.");
//		}
//		return new List<string>();
//	}

//	private async Task<List<string>> GetStatesForLayer(string layerName)
//	{
//		var (response, progress) = await API.GetCompletionFromOpenAI($"Given the layer named '{layerName}' and the overall context '{prompt}', please list the necessary states for this layer in a Unity Animation Controller. Each state name should be concise, in camel case (e.g., IdleState), and not contain any special characters.", model, 0.5f);

//		string stateResponse = response;

//		if (string.IsNullOrEmpty(stateResponse))
//		{
//			Debug.LogWarning($"Failed to retrieve states for layer: {layerName}. Defaulting to no states.");
//			return new List<string>();
//		}

//		return ParseStates(stateResponse);
//	}

//	private async Task<List<string>> GetTransitionsForState(string stateName)
//	{
//		var (response, progress) = await API.GetCompletionFromOpenAI($"Given the state '{stateName}' and the overall description '{prompt}', which transitions should be incorporated for this state in a Unity Animation Controller?\r\n", model, 0.5f);

//		if (string.IsNullOrEmpty(response))
//		{
//			Debug.LogWarning($"Failed to retrieve transitions for state: {stateName}. Defaulting to no transitions.");
//			return new List<string>();
//		}

//		return ParseTransitions(response);
//	}

//	private async Task<Dictionary<string, object>> GetTransitionSettings(string transitionName)
//	{
//		var (response, progress) = await API.GetCompletionFromOpenAI($"For the transition labeled '{transitionName}' and based on the context '{prompt}', could you suggest appropriate settings? Please present them in the format \"settingName1: value1, settingName2: value2, ...\".\r\n", model, 0.5f);
//		string settingsResponse = response;
//		if (string.IsNullOrEmpty(settingsResponse))
//		{
//			Debug.LogWarning($"Failed to retrieve settings for transition: {transitionName}. Defaulting to default settings.");
//			return new Dictionary<string, object>();
//		}
//		return ParseTransitionSettings(settingsResponse);
//	}

//	private List<string> ParseStates(string stateResponse)
//	{
//		List<string> stateList = new List<string>();

//		if (stateResponse != null && stateResponse != "")
//		{
//			string[] lines = stateResponse.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
//			foreach (var line in lines)
//			{
//				// Splitting by underscores to get the state name
//				var parts = line.Split('_');
//				if (parts.Length > 1)
//				{
//					// Add the trimmed state name to the list
//					stateList.Add(parts[1].Trim());
//				}
//			}
//		}

//		return stateList;
//	}

//	private List<string> ParseTransitions(string transitionsResponse)
//	{
//		// Assuming GPT returns comma separated transition names
//		if (transitionsResponse != null && transitionsResponse != "")
//		{
//			return new List<string>(transitionsResponse.Split(','));
//		}
//		return new List<string>();
//	}

//	private Dictionary<string, object> ParseTransitionSettings(string settingsResponse)
//	{
//		// Assuming GPT returns settings in format: "setting1=value1, setting2=value2, ..."
//		Dictionary<string, object> settings = new Dictionary<string, object>();
//		string[] keyValuePairs = settingsResponse.Split(',');
//		foreach (string pair in keyValuePairs)
//		{
//			string[] kv = pair.Split('=');
//			if (kv.Length == 2)
//			{
//				settings[kv[0].Trim()] = kv[1].Trim(); // You might want to cast these to proper data types
//			}
//		}
//		return settings;
//	}

//	private AnimationClip[] GetAnimationClips()
//	{
//		if (string.IsNullOrEmpty(folderToAnimations)) return null;

//		List<AnimationClip> clips = new List<AnimationClip>();
//		SearchDirectoryForAnimationClips(folderToAnimations, clips);
//		return clips.ToArray();
//	}

//	private void SearchDirectoryForAnimationClips(string directory, List<AnimationClip> clips)
//	{
//		// Load animation clips from the current directory
//		string[] assetPaths = AssetDatabase.FindAssets("t:AnimationClip", new string[] { directory });

//		foreach (string assetPath in assetPaths)
//		{
//			AnimationClip clip = AssetDatabase.LoadAssetAtPath<AnimationClip>(AssetDatabase.GUIDToAssetPath(assetPath));
//			if (clip != null)
//			{
//				clips.Add(clip);
//			}
//		}

//		// Recursively check subdirectories
//		foreach (string subdirectory in System.IO.Directory.GetDirectories(directory))
//		{
//			SearchDirectoryForAnimationClips(subdirectory, clips);
//		}
//	}

//	private void AssignAnimationToState(AnimatorState state, AnimationClip[] clips, string animationName)
//	{
//		foreach (var clip in clips)
//		{
//			if (clip.name == animationName)
//			{
//				state.motion = clip;
//				return;
//			}
//		}
//		Debug.LogWarning($"No animation found for state: {animationName}");
//	}

//	private void ApplyTransitionSettings(AnimatorStateTransition transition, Dictionary<string, object> settings)
//	{
//		foreach (var setting in settings)
//		{
//			switch (setting.Key)
//			{
//				case "duration":
//					transition.duration = Convert.ToSingle(setting.Value);
//					break;
//				case "offset":
//					transition.offset = Convert.ToSingle(setting.Value);
//					break;
//				case "exitTime":
//					transition.exitTime = Convert.ToSingle(setting.Value);
//					break;
//				case "hasExitTime":
//					transition.hasExitTime = Convert.ToBoolean(setting.Value);
//					break;
//				case "hasFixedDuration":
//					transition.hasFixedDuration = Convert.ToBoolean(setting.Value);
//					break;
//				case "orderedInterruption":
//					transition.orderedInterruption = Convert.ToBoolean(setting.Value);
//					break;
//				case "canTransitionToSelf":
//					transition.canTransitionToSelf = Convert.ToBoolean(setting.Value);
//					break;
//				default:
//					Debug.LogWarning($"Unknown transition setting: {setting.Key}");
//					break;
//			}
//		}
//	}

//}

//[Serializable]
//public class UserVariables
//{
//	public string variableName;
//	public VariableType variableType;
//}

//public enum VariableType
//{
//	Float,
//	Trigger,
//	Int,
//	Bool
//}

//public static class UnityWebRequestExtensions
//{
//	public static UnityWebRequestAwaiter GetAwaiter(this UnityWebRequestAsyncOperation asyncOp)
//	{
//		return new UnityWebRequestAwaiter(asyncOp);
//	}
//}

//public class UnityWebRequestAwaiter : INotifyCompletion
//{
//	private UnityWebRequestAsyncOperation _asyncOp;
//	private System.Action _continuation;

//	public UnityWebRequestAwaiter(UnityWebRequestAsyncOperation asyncOp)
//	{
//		_asyncOp = asyncOp;
//		asyncOp.completed += OnRequestCompleted;
//	}

//	public bool IsCompleted => _asyncOp.isDone;

//	public void OnCompleted(System.Action continuation)
//	{
//		_continuation = continuation;
//	}

//	public void GetResult() { }

//	private void OnRequestCompleted(AsyncOperation op)
//	{
//		_continuation?.Invoke();
//	}
//}

//public static class TaskExtensions
//{
//	public static async Task Until(this UnityWebRequestAsyncOperation operation, Func<bool> predicate)
//	{
//		while (!operation.isDone)
//		{
//			if (predicate.Invoke())
//				break;

//			await Task.Yield();
//		}
//	}
//}

//public class API
//{
//	private static int requestsCompleted = 0;
//	public static int totalRequests = 14;
//	private static bool firstRq = true;

//	[Serializable]
//	public class Payload
//	{
//		public string model;
//		public float temperature;
//		public int max_tokens = 4000;  // default value, can adjust as needed
//		public Message[] messages;
//	}

//	[Serializable]
//	public class Message
//	{
//		public string role;
//		public string content;
//	}

//	[Serializable]
//	public class Response
//	{
//		public Choice[] choices;
//	}

//	[Serializable]
//	public class Choice
//	{
//		public Message message;
//	}

//	public static async Task<(string response, float progress)> GetCompletionFromOpenAI(string prompt, string model, float temperature)
//	{
//		//totalRequests++;
//		//Debug.Log("Total Request Count: " + totalRequests);

//		string url = "https://api.openai.com/v1/chat/completions";

//		Message msg = new Message
//		{
//			content = prompt,
//			role = "user"
//		};

//		Payload payload = new Payload
//		{
//			model = model,
//			temperature = temperature,
//			max_tokens = 4000,
//			messages = new Message[] { msg }
//		};

//		string jsonPayload = JsonUtility.ToJson(payload);
//		byte[] bodyRaw = Encoding.UTF8.GetBytes(jsonPayload);
//		//Debug.Log(jsonPayload);
//		if (AnimationControllerGenerator.first)
//		{
//			AnimationControllerGenerator.first = false;
//		}
//		else
//		{
//			int delayTimeInMilliseconds = 22500;  // 25 second for rate limit (10000 tokens per minute)
//			await Task.Delay(delayTimeInMilliseconds);
//		}
		
//		using (UnityWebRequest request = new UnityWebRequest(url, "POST"))
//		{
//			Debug.Log($"Generating animation controller: {(requestsCompleted / totalRequests)}%");
//			requestsCompleted++;

//			request.uploadHandler = new UploadHandlerRaw(bodyRaw);
//			request.downloadHandler = new DownloadHandlerBuffer();
//			request.SetRequestHeader("Authorization", $"Bearer {AnimationControllerGenerator.apiKey}");
//			request.SetRequestHeader("Content-Type", "application/json");

//			float progress = 0f;
//			await request.SendWebRequest().Until(() =>
//			{
//				progress = request.downloadProgress;
//				return false; // Return false to keep the Until loop running until SendWebRequest completes.
//			});

//			if (request.result != UnityWebRequest.Result.Success)
//			{
//				Debug.LogError($"Request failed: {request.error}");
//				Debug.LogError($"Detailed error: {request.downloadHandler.text}");
//				return (null, progress);
//			}

//			string jsonResponse = request.downloadHandler.text;

//			Response parsedResponse = JsonUtility.FromJson<Response>(jsonResponse);

//			// Extract the message content
//			string messageContent = parsedResponse.choices[0].message.content;


//			if ((requestsCompleted / totalRequests) == 100)
//			{
//				Debug.Log("Animation controller successfully generated!");
//			}

//			Debug.Log("Message received: " + messageContent);

//			return (messageContent, progress);
//		}
//	}
//}