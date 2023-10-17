// Written by Peter Thompson
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;
using UnityEngine.InputSystem;
using Unity.VisualScripting;
using UnityEngine.UIElements.Experimental;
using System.Web.Mvc;

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
			Init();
		}

		private void OnEnable()
		{
			controls.OnEnable();
		}

		private void OnDisable()
		{
			controls.OnDisable();
		}

		void Init()
		{
			controls.Awake(this);
		}

		void LateInit()
		{
			animations.Start(this);
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
			LateInit();

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
			//ApplyAnimationClips();

			// Start retrieving animation values
			StartCoroutine(UpdateAnimationVariables());

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
			float mouseX = controls.HorizontalLook * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);
			float mouseY = controls.VerticalLook * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);

			physics.xRotation -= mouseY;
			physics.xRotation = Mathf.Clamp(physics.xRotation, -90f, 90f);

			Transform go = look.cameraPivot;
			if (go != null)
			{
				go.localRotation = Quaternion.Euler(physics.xRotation, 0f, 0f);
			}

			transform.Rotate(Vector3.up * mouseX);
		}

		void Move()
		{
			float moveForwardBackward = controls.VerticalMove;
			float moveLeftRight = controls.HorizontalMove;

			Vector3 desiredMoveDirection = transform.right * moveLeftRight + transform.forward * moveForwardBackward;

			// Normalize the movement vector if its magnitude > 1 to prevent faster diagonal movement
			if (desiredMoveDirection.magnitude > 1f)
				desiredMoveDirection.Normalize();

			// Smoothing movement
			physics.moveDirection = Vector3.Lerp(physics.moveDirection, desiredMoveDirection, movement.smoothing * Time.deltaTime);
		}

		void Jump()
		{
			// Handle jumping
			if (controls.Jump && physics.isGrounded)
			{
				physics.playerBody.velocity = new Vector3(physics.playerBody.velocity.x, movement.jumpHeight * movement.jumpHeightConversion, physics.playerBody.velocity.z);
			}
		}

		void CameraBobbing()
		{
			if (animations.cameraBob)
			{
				if (physics.isMoving && physics.isGrounded)
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
			// If the player is in the air, don't change the movement type
			if (!physics.isGrounded) return;

			if (controls.Crouch)
			{
				movement.type = Movement.MovementType.Crouching;
			}
			else if (controls.Run && (controls.VerticalMove > 0 || controls.HorizontalMove != 0))
			{
				movement.type = Movement.MovementType.Running;
			}
			else
			{
				movement.type = Movement.MovementType.Walking;
			}

			// TODO: Implement conditions for Climbing and Swimming when those mechanics are added
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
			if (models.modelTransform.childCount > 0)
			{
				for (int i = 0; i < models.modelTransform.childCount; i++)
				{
					var child = models.modelTransform.GetChild(i);

					//if (child != boneRoot)
					//{
					//	Destroy(child.gameObject);
					//}

					Destroy(child.gameObject);
				}
			}

			GameObject playerModel = Instantiate(models.playerModels[index].prefab, models.modelTransform);
			Animator animator = playerModel.GetComponent<Animator>();
			if (!animator)
			{
				playerModel.AddComponent(typeof(Animator));
				animator = playerModel.GetComponent<Animator>();
			}

			// This works correctly. It is becoming null after this gets called, likely in ApplyAnimationClips
			animator.runtimeAnimatorController = animations.animationController;
			animator.avatar = animations.avatar;
			animator.applyRootMotion = true;
			animations.animator = animator;
		}

		void ApplyAnimationClips()
		{
			AnimatorOverrideController aoc = animations.animator.runtimeAnimatorController as AnimatorOverrideController;
			Debug.Log(aoc.name + "Override controller created.");
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
			Debug.Log("Applying override controller...");
			animations.animator.runtimeAnimatorController = aoc;
			if (animations.animator.runtimeAnimatorController == aoc)
			{
				Debug.Log(animations.animator.runtimeAnimatorController.name + "override applied successfully!");
			}
		}

		// Due to the nature of using "get" for the movement variables,
		// calling these variables multiple times can cause a performance drop.
		// Due to this, I have implemented an animation update rate to call
		// these variables less
		IEnumerator UpdateAnimationVariables()
		{
			while (true)
			{
				if (animations.animator != null)
				{
					UpdateAnimationValues();
				}
				else
				{
					Debug.Log("Player animator is null!");
				}
				yield return new WaitForSeconds(1 / settings.performance.animationVariableUpdateRate);
			}
		}

		private void UpdateAnimationValues()
		{
			animations.animator.SetInteger("Movement Type", (int)movement.type);
			animations.animator.SetFloat("Horizontal", controls.HorizontalMove);
			animations.animator.SetFloat("Vertical", controls.VerticalMove);
			animations.animator.SetBool("isGrounded", physics.isGrounded);
			animations.animator.SetBool("isMoving", physics.isMoving);
			// Using "jumpReset" instead of "Jump" to check if jump was pressed between the frames
			// that this method was not called in (because this method is running at a different
			// frame rate set in settings.performace)
			if (controls.jumpReset)
			{
				controls.jumpReset = false;
				animations.animator.SetTrigger("Jump");
			}
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
		internal Animator animator;

		#region Inspector Variables
		public bool cameraBob = true;
		[Tooltip("Uses IK to allow the player's animation to dynamically change it's animation based off of the environment \n" +
			" (will prevent holding items clipping walls and feet clipping ground).")]
		public bool reactToEnvironment = true;
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
		}
	}

	[Serializable]
	public class Controls
	{
		private PlayerController controller;

		public float HorizontalMove
		{
			get
			{
#if ENABLE_INPUT_SYSTEM
				return movementAction.ReadValue<Vector2>().x;
#else
				return Input.GetAxis("Horizontal");
#endif
			}
		}

		public float VerticalMove
		{
			get
			{
#if ENABLE_INPUT_SYSTEM
				return movementAction.ReadValue<Vector2>().y;
#else
				return Input.GetAxis("Vertical");
#endif
			}
		}

		public bool jumpReset;

		public bool Jump
		{
			get
			{

#if ENABLE_INPUT_SYSTEM
				if (jumpAction.triggered)
				{
					jumpReset = true;
				}
				return jumpAction.triggered;
#else
				if (Input.GetButtonDown("Jump"))
				{
					jumpReset = true;
				}
				return Input.GetButtonDown("Jump");
#endif
			}
		}

		private bool triggerRun = false;

		public bool Run
		{
			get
			{
				if (!runTrigger)
				{
#if ENABLE_INPUT_SYSTEM

					return sprintAction.ReadValue<float>() > holdThreshold;
#else
					return Input.GetButton("Sprint");
#endif
				}
				else
				{
#if ENABLE_INPUT_SYSTEM
					if (sprintAction.triggered)
					{
						triggerRun = !triggerRun;
						triggerCrouch = !triggerRun;
					}

#else
					if (Input.GetButtonDown("Sprint"))
					{
						triggerRun = !triggerRun;
					}
#endif
					return triggerRun;
				}
			}
		}

		private bool triggerCrouch = false;
		public bool Crouch
		{
			get
			{
				if (!crouchTrigger)
				{
#if ENABLE_INPUT_SYSTEM

					return crouchAction.ReadValue<float>() > holdThreshold;
#else
					return Input.GetButton("Crouch");
#endif
				}
				else
				{
#if ENABLE_INPUT_SYSTEM
					if (crouchAction.triggered)
					{
						triggerCrouch = !triggerCrouch;
						triggerRun = !triggerCrouch;
					}

#else
					if (Input.GetButtonDown("Crouch"))
					{
						triggerCrouch = !triggerCrouch;
						triggerRun = !triggerCrouch;
					}
#endif
					return triggerCrouch;
				}
			}
		}

		public float HorizontalLook
		{
			get
			{
#if ENABLE_INPUT_SYSTEM
				return mouseAction.ReadValue<Vector2>().x;
#else
				return Input.GetAxis("Mouse X")
#endif
			}
		}

		public float VerticalLook
		{
			get
			{
#if ENABLE_INPUT_SYSTEM
				return mouseAction.ReadValue<Vector2>().y;
#else
				return Input.GetAxis("Mouse Y")
#endif
			}
		}

		public bool Interact
		{
			get
			{
#if ENABLE_INPUT_SYSTEM
				return interactAction.triggered;
#else
				return Input.GetButtonDown("Interact");
#endif
			}
		}

		// Avoid using this on items as the "Use" event will trigger item methods
		public bool Use
		{
			get
			{
#if ENABLE_INPUT_SYSTEM

				return useAction.ReadValue<float>() > holdThreshold;
#else
				return Input.GetButton("Fire");
#endif
			}
		}

		// Avoid using this on items as the "Aim" event will trigger item methods
		public bool Aim
		{
			get
			{
#if ENABLE_INPUT_SYSTEM

				return aimAction.ReadValue<float>() > holdThreshold;
#else
				return Input.GetButton("Aim");
#endif
			}
		}

		public PlayerInput input { get; private set; }

		private InputAction movementAction;
		private InputAction mouseAction;

		private InputAction sprintAction;
		private InputAction crouchAction;

		private InputAction jumpAction;
		private InputAction interactAction;
		private InputAction useAction; // Use items (shoot, turn torch light on/off, ect)
		private InputAction aimAction; // Use items secondary (aim, change torch colour, ect)

#region Editor Variables
		[SerializeField]
		internal float holdThreshold = 0.4f;
		[SerializeField, Tooltip("Whether run needs to be held to stay running.")]
		internal bool runTrigger = false;
		[SerializeField, Tooltip("Whether crouch needs to be held to stay running.")]
		internal bool crouchTrigger = true;
#endregion

		internal void OnEnable()
		{

		}

		internal void OnDisable()
		{

		}

		internal void Awake(PlayerController controller)
		{
			this.controller = controller;

			InitControls();

		}

		private void InitControls()
		{
#if ENABLE_INPUT_SYSTEM
			input = controller.GetComponent<PlayerInput>();

			// Capture input actions
			movementAction = input.actions["Move"];
			mouseAction = input.actions["Look"];
			sprintAction = input.actions["Run"];
			jumpAction = input.actions["Jump"];
			crouchAction = input.actions["Crouch"];
			interactAction = input.actions["Interact"];
			useAction = input.actions["Use"];
#endif
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

		// Fake friction. Can use to simulate friction, however this smoothes the input axis rather than rigidbody itself.
		[SerializeField]
		internal float smoothing = 10;

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

		public bool isMoving
		{
			get
			{
				return controller.controls.VerticalMove != 0 || controller.controls.HorizontalMove != 0;
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
