// Written by Peter Thompson
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;

// TODO: Add LocalPlayer, AiPlayer and NetworkedPlayer classes

// Today: Setup item holding for first person, cull out character if camera is in first person
namespace Player
{
	[RequireComponent(typeof(Rigidbody))]
	public class PlayerController : MonoBehaviour
	{
		public static PlayerController localPlayer = null;

		#region Assorted variables
		// Class that holds animation variables related to the player
		public Animations animations;
		// Class that holds the control variables
		public Controls controls;
		// Class which handles the player's current inventory items
		public Inventory inventory;
		// Class that holds the camera movement related variables
		public Look look;
		// Class that holds the player 3D model variables
		public Models models;
		// Class that holds the movement related variables
		public Movement movement;
		// Class that holds physics based variables
		public Physics physics;
		// Class that holds variables which control how the player controller acts
		public Settings settings;
		// Class that holds variables which handles player sounds
		public Sound sound;
		// Class that holds variables to control camera & character transitions (such as transitioning from first person to third person, or entering a vehicle ect.)
		public Transitions transitions;
		// Placeholder
		public Networking networking;
		// Class that holds references to GUI elements
		public UI ui;
		#endregion

		private void Awake()
		{
			if (settings.singleInstance)
			{
				localPlayer = this;
			}
		}

		void Init()
		{
			animations.Start(this);
			controls.Start(this);
			inventory.Start(this);
			look.Start(this);
			models.Start(this);
			movement.Start(this);
			physics.Start(this);
			settings.Start(this);
			sound.Start(this);
			transitions.Start(this);
			ui.Start(this);
		}

		private void Start()
		{
			Init();

			if (physics.playerBody == null)
			{
				physics.playerBody = GetComponent<Rigidbody>();
			}

			physics.playerTransform = transform;

			// Lock the cursor to the center of the screen
			Cursor.lockState = CursorLockMode.Locked;

			// Apply player model
			ApplyPlayerModel(models.selectedPlayerIndex);

			// Apply animations
			ApplyAnimationClips();

			// Setup Cinemachine
			SetupCamera();

			
		}

		private void Update()
		{
			Rotate();
			Move();
			Jump();
			CameraBobbing();
			HandleMovementType();
			CheckSubmersion();
			UpdateAnimationValues();

			// Apply a new player model manually
			if (models.applyModel)
			{
				models.applyModel = false;
				ApplyPlayerModel(models.selectedPlayerIndex);
			}
		}

		private void FixedUpdate()
		{
			ProcessPhysics();
		}

		void SetupCamera()
		{
			look.cinemachineCamera.GetCinemachineComponent<CinemachinePOV>().m_HorizontalAxis.m_MaxSpeed = look.cameraSensitivity;
			look.cinemachineCamera.GetCinemachineComponent<CinemachinePOV>().m_VerticalAxis.m_MaxSpeed = look.cameraSensitivity;
			look.cinemachineBob = look.cinemachineCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		}

		void ProcessPhysics()
		{
			float speed = movement.walkSpeed;  // Default to walking speed

			switch (movement.type)
			{
				case Movement.MovementType.Running:
					speed = movement.runSpeed;
					break;
				case Movement.MovementType.Crouching:
					speed = movement.crouchSpeed;
					break;
				case Movement.MovementType.Climbing:
					speed = movement.climbSpeed;
					break;
				case Movement.MovementType.Swimming:
					speed = movement.swimSpeed;
					break;
			}

			Vector3 move = physics.moveDirection * speed * Time.fixedDeltaTime;
			physics.playerBody.MovePosition(physics.playerBody.position + move);
		}


		void Rotate()
		{
			// Handle player rotation
			float mouseX = Input.GetAxis("Mouse X") * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);
			float mouseY = Input.GetAxis("Mouse Y") * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);

			physics.xRotation -= mouseY;
			physics.xRotation = Mathf.Clamp(physics.xRotation, -90f, 90f);

			//Camera camera = look.camera;
			//if (camera != null)
			//{
			//	camera.transform.localRotation = Quaternion.Euler(physics.xRotation, 0f, 0f);
			//}

			Transform go = look.cameraPivot;
			if (go != null)
			{
				go.localRotation = Quaternion.Euler(physics.xRotation, 0f, 0f);
			}

			transform.Rotate(Vector3.up * mouseX);
		}

		void Move()
		{
			float moveForwardBackward = Input.GetAxis("Vertical");
			float moveLeftRight = Input.GetAxis("Horizontal");

			Vector3 desiredMoveDirection = transform.right * moveLeftRight + transform.forward * moveForwardBackward;

			// Normalize the movement vector if its magnitude > 1 to prevent faster diagonal movement
			if (desiredMoveDirection.magnitude > 1f)
				desiredMoveDirection.Normalize();

			// Smoothing movement
			physics.moveDirection = Vector3.Lerp(physics.moveDirection, desiredMoveDirection, movement.walkSpeed * Time.deltaTime);
		}


		void Jump()
		{
			// Handle jumping
			if (Input.GetButtonDown("Jump") && physics.isGrounded)
			{
				physics.playerBody.velocity = new Vector3(physics.playerBody.velocity.x, movement.jumpHeight * movement.jumpHeightConversion, physics.playerBody.velocity.z);
			}
			physics.drawGizmos = true;
		}

		void CameraBobbing()
		{
			if (animations.cameraBob)
			{
				if ((Input.GetAxis("Vertical") != 0 || Input.GetAxis("Horizontal") != 0) && physics.isGrounded)
				{
					look.cinemachineBob.m_FrequencyGain = look.bobFrequency;
					look.cinemachineBob.m_AmplitudeGain = Mathf.Lerp(look.cinemachineBob.m_AmplitudeGain, look.bobAmplitude, Time.deltaTime * look.cameraSmoothing);
				}
				else
				{
					look.cinemachineBob.m_AmplitudeGain = Mathf.Lerp(look.cinemachineBob.m_AmplitudeGain, 0f, Time.deltaTime * look.cameraSmoothing);
				}
			}
		}


		void HandleMovementType()
		{
			// Movement type should be changed to something like this:
			// Walking
			// Swimming
			// Driving

			// From each of these can have their own sub-types such as:
			// Walking {Walking, Running, Falling, Climbing, ect}

			// Crouch
			if (movement.type != Movement.MovementType.Climbing)
			{
				if (movement.type != Movement.MovementType.Swimming)
				{
					if (Input.GetButtonDown("Crouch"))
					{
						if (movement.type == Movement.MovementType.Crouching)
						{
							movement.type = Movement.MovementType.Walking;
						}
						else
						{
							movement.type = Movement.MovementType.Crouching;
						}
					}
				}
			}

			// Run
			if (Input.GetButtonDown("Sprint"))
			{
				if (movement.type != Movement.MovementType.Climbing)
				{
					if (movement.type != Movement.MovementType.Swimming)
					{
						movement.type = Movement.MovementType.Running;
					}
				}
			}
			else
			{
				if (movement.type == Movement.MovementType.Running)
				{
					movement.type = Movement.MovementType.Walking;
				}
			}
		}

		void CheckSubmersion()
		{
			if (physics.submergePoint != null)
			{
				bool isSubmerged = UnityEngine.Physics.Raycast(physics.submergePoint.position, Vector3.up, 0.1f, physics.groundMask);
				if (isSubmerged)
				{
					movement.walkSpeed *= movement.submergedSpeedMultiplier;
					movement.runSpeed *= movement.submergedSpeedMultiplier;
				}
			}
		}

		void OnDrawGizmosSelected()
		{
			// Draw the ray in red
			Gizmos.color = Color.red;
			Gizmos.DrawLine(physics.rayOrigin, physics.rayOrigin + (Vector3.down * physics.rayDistance));
		}

		void ApplyPlayerModel(int index)
		{
			// Remove old model
			for (int i = 0; i < models.modelTransform.childCount; i++)
			{
				var child = models.modelTransform.GetChild(i);

				//if (child != boneRoot)
				//{
				//	Destroy(child.gameObject);
				//}

				Destroy(child.gameObject);
			}

			GameObject playerModel = Instantiate(models.playerModels[index].prefab, models.modelTransform);
			Animator animator = playerModel.GetComponent<Animator>();
			if (!animator)
			{
				playerModel.AddComponent(typeof(Animator));
				animator = playerModel.GetComponent<Animator>();
			}

			animator.runtimeAnimatorController = animations.animationController;
			animator.avatar = animations.avatar;
			animator.applyRootMotion = false;
			animations.animator = animator;
		}

		void ApplyAnimationClips()
		{
			AnimatorOverrideController aoc = animations.animator.runtimeAnimatorController as AnimatorOverrideController;

			if (aoc != null)
			{
				// Idle
				aoc["Idle"] = animations.animationClips.idling.idle;
				aoc["Crouching Idle"] = animations.animationClips.idling.crouchIdle;

				// Jogging
				aoc["Jog Forward"] = animations.animationClips.walking.forward;
				aoc["Jog Backward"] = animations.animationClips.walking.backward;
				aoc["Jog Strafe Left"] = animations.animationClips.walking.left;
				aoc["Jog Strafe Right"] = animations.animationClips.walking.right;

				// Running
				aoc["Run Forward"] = animations.animationClips.running.forward;
				aoc["Left Strafe"] = animations.animationClips.running.left;
				aoc["Right Strafe"] = animations.animationClips.running.right;

				// Crouching
				aoc["Crouched Walking"] = animations.animationClips.crouching.forward;
				aoc["Crouched Walking Backwards"] = animations.animationClips.crouching.backward;
				aoc["Crouched Sneaking Left"] = animations.animationClips.crouching.left;
				aoc["Crouched Sneaking Right"] = animations.animationClips.crouching.left;

				// Climbing

				// Swimming

			}

		}

		void UpdateAnimationValues()
		{
			animations.animator.SetFloat("Horizontal", Input.GetAxis("Horizontal"));
			animations.animator.SetFloat("Vertical", Input.GetAxis("Vertical"));
			animations.animator.SetInteger("Movement Type", (int)movement.type);

		}
	}

	[Serializable]
	internal class PlayerKey
	{
		[SerializeField]
		internal GameObject prefab;
		[SerializeField]
		internal GameObject[] skinnedGameObjects
		{
			get
			{
				List<GameObject> ob = new List<GameObject>();
				for (int i = 0; i < prefab.transform.childCount; i++)
				{
					if (prefab.transform.GetChild(i).TryGetComponent(out SkinnedMeshRenderer a))
					{
						ob.Add(a.gameObject);
					}
				}

				return ob.ToArray();
			}
		}
	}

	#region Public Variable Classes
	[Serializable]
	public class Animations
	{
		private PlayerController controller;

		#region Inspector Variables
		public bool cameraBob = true;
		[Tooltip("Uses IK to allow the player's animation to dynamically change it's animation based off of the environment \n" +
			" (will prevent holding items clipping walls and feet clipping ground).")]
		public bool reactToEnvironment = true;
		[SerializeField]
		internal Animator animator;
		[SerializeField]
		internal RuntimeAnimatorController animationController;
		[SerializeField]
		internal Avatar avatar;
		[Space, SerializeField]
		internal Clips animationClips;
		#endregion

		[Serializable]
		internal class Clips
		{
			[SerializeField]
			internal Idling idling;
			[SerializeField]
			internal Walking walking;
			[SerializeField]
			internal Running running;
			[SerializeField]
			internal Crouching crouching;
			[SerializeField]
			internal Climbing climbing;
			[SerializeField]
			internal Swimming swimming;

			private const string tooltip = "Make sure the animation is set to humanoid (generic and legacy animations will freeze the character). This can be set on the model that the animation clip came from, but not on an animation clip itself.";

			[Serializable]
			internal class Idling
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip idle;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip crouchIdle;
			}

			[Serializable]
			internal class Walking
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip forward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip backward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip left;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip right;
			}

			[Serializable]
			internal class Running
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip forward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip left;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip right;
			}

			[Serializable]
			internal class Crouching
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip forward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip backward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip left;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip right;
			}

			[Serializable]
			internal class Climbing
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip climbUp;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip climbDown;
			}

			[Serializable]
			internal class Swimming
			{
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip forward;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip left;
				[SerializeField, Tooltip(tooltip)]
				internal AnimationClip right;
			}
		}

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
			controller.StartCoroutine(UpdateAnimationValues());
		}

		IEnumerator UpdateAnimationValues()
		{
			animator.SetBool("isMoving", controller.physics.isMoving);
			float fr = 1 / controller.settings.performance.animationVariableUpdateRate;
			if (Time.deltaTime > fr)
			{
				yield return new WaitForSeconds(Time.deltaTime);
			}
			else
			{
				yield return new WaitForSeconds(1 / controller.settings.performance.animationVariableUpdateRate);
			}
		}
	}

	[Serializable]
	public class Controls
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		internal float axisDeadZone = 0.005f;
		#endregion

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}

		internal Vector2 input
		{
			get
			{
				float x = Input.GetAxis("Horizontal");
				float y = Input.GetAxis("Vertical");

				return new Vector2(x, y);
			}
		}

		internal Vector2 mouse
		{
			get
			{
				float x = Input.GetAxis("Mouse X") * controller.look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);
				float y = Input.GetAxis("Mouse Y") * controller.look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);

				return new Vector2(x, y);
			}
		}
	}

	[Serializable]
	public class Inventory
	{
		private PlayerController controller;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Look
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		public CinemachineVirtualCamera cinemachineCamera;
		[SerializeField]
		internal Camera camera;
		[SerializeField]
		internal Transform cameraPivot;
		public float cameraBobSpeed = 1;
		public float cameraSensitivity = 5;
		public float cameraSmoothing = 1;
		public float cameraBobbingSensitivity = 2f;

		public float bobFrequency = 2.0f;
		public float bobAmplitude = 0.5f;

		[SerializeField]
		internal ParticleSystem cameraEffects;
		#endregion

		internal CinemachineBasicMultiChannelPerlin cinemachineBob;

		internal float bobbingTimer = 0;
		internal float bobSmoothing = 0;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Models
	{
		private PlayerController controller;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}

		#region Inspector Variables
		[SerializeField]
		internal int selectedPlayerIndex = 0;
		[SerializeField]
		internal PlayerKey[] playerModels;
		[SerializeField]
		internal bool applyModel = false;
		[SerializeField, Space]
		internal Transform modelTransform;
		#endregion
	}

	[Serializable]
	public class Movement
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		internal float crouchSpeed = 2;
		[SerializeField]
		internal float walkSpeed = 4;
		[SerializeField]
		internal float runSpeed = 7.5f;
		[SerializeField]
		internal float jumpHeight = 1f;
		[SerializeField]
		internal float climbSpeed = 2;
		[SerializeField]
		internal float swimSpeed = 2;

		// Slows the player down if player is in water
		[SerializeField]
		internal float submergedSpeedMultiplier = 0.5f;
		#endregion

		internal float jumpHeightConversion = 4f;
		internal enum MovementType { Walking = 0, Running = 1, Crouching = 2, Climbing = 3, Swimming = 4 }
		internal MovementType type = MovementType.Walking;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Networking
	{
		// Leaving this here as an empty placeholder for future projects
	}

	[Serializable]
	public class Physics
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		internal float groundCheckDistance = 0.1f;
		[SerializeField]
		internal Rigidbody playerBody;
		[SerializeField]
		internal Collider playerCollider;
		// Assign a layer mask to specify what layers should be considered as ground
		[SerializeField]
		internal LayerMask groundMask;
		[SerializeField]
		internal Transform submergePoint;
		#endregion

		// Check rigidbody velocity in case outside factor's is moving character
		public bool isMoving
		{
			get
			{
				Debug.Log("Player velocity: " + playerBody.velocity.sqrMagnitude);
				if (playerBody.velocity.sqrMagnitude > 0.05f)
				{
					return true;
				}
				else
				{
					return false;
				}

				// If player is moved by input
				//if (input.x > axisDeadZone || input.x < -axisDeadZone || input.y > axisDeadZone || input.y < -axisDeadZone)
				//{
				//	return true;
				//}
				//else
				//{
				//	return false;
				//}
			}
		}

		internal Transform playerTransform;
		[SerializeField]
		internal bool drawGizmos = false;

		internal Vector3 moveDirection;

		internal Vector3 rayOrigin;
		internal float rayDistance;
		public bool isGrounded
		{
			get
			{
				Vector3 sphereStart = playerTransform.position + (Vector3.up * 0.05f);
				return UnityEngine.Physics.CheckSphere(sphereStart, groundCheckDistance, groundMask);
			}
		}


		internal float xRotation = 0f;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Settings
	{
		private PlayerController controller;

		[SerializeField]
		internal bool singleInstance = true;

		[SerializeField]
		internal PlayType playType;

		internal enum PlayType { FirstPerson, ThirdPerson }

		public Performance performance;

		[Serializable]
		public class Performance
		{
			public int animationVariableUpdateRate = 30;
		}

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Sound
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		internal AudioClip[] footstepsGrass;
		[SerializeField]
		internal AudioClip[] footstepsDirt;
		[SerializeField]
		internal AudioClip[] footstepsWood;
		[SerializeField]
		internal AudioClip[] footstepsMetal;
		[SerializeField]
		internal AudioClip[] footstepsGravel;

		public AudioSource audio;
		#endregion

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Transitions
	{
		private PlayerController controller;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class UI
	{
		private PlayerController controller;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}
	#endregion
}
