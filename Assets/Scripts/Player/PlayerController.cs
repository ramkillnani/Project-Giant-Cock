using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
	#region Assorted variables
	// Class that holds the movement related variables
	public Movement movement = new Movement();
	// Class that holds the camera movement related variables
	public Look look = new Look();
	// Class that holds animation variables related to the player
	public Animations animations = new Animations();
	// Class that holds the player 3D model variables
	public Models models;
	// Class that holds the control variables
	public Controls controls = new Controls();
	// Class that holds physics based variables
	public Physics physics = new Physics();
	// Class which holds variables which control how the player controller acts
	public Settings settings;

	// Variables that will be used in runtime
	
	#endregion


	private void Start()
	{
		if (physics.playerBody == null)
		{
			physics.playerBody = GetComponent<Rigidbody>();
		}

		// Lock the cursor to the center of the screen
		Cursor.lockState = CursorLockMode.Locked;

		// Apply player model
		ApplyPlayerModel(models.selectedPlayerIndex);

		physics.playerTransform = transform;
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

	void ProcessPhysics()
	{
		float speed = 0;

		if (movement.type == Movement.MovementType.Walking)
		{
			speed = movement.walkSpeed;
		}
		else if (movement.type == Movement.MovementType.Running)
		{
			speed = movement.runSpeed;
		}
		else if (movement.type == Movement.MovementType.Crouching)
		{
			speed = movement.crouchSpeed;
		}
		else if (movement.type == Movement.MovementType.Climbing)
		{
			speed = movement.climbSpeed;
		}
		else if (movement.type == Movement.MovementType.Swimming)
		{
			speed = movement.swimSpeed;
		}

		//float speed = (Input.GetKey(KeyCode.LeftShift)) ? movement.runSpeed : movement.walkSpeed;
		Vector3 move = physics.moveDirection * speed * Time.fixedDeltaTime;

		// Move the player
		physics.playerBody.MovePosition(physics.playerBody.position + move);
	}

	void Rotate()
	{
		// Handle player rotation
		float mouseX = Input.GetAxis("Mouse X") * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);
		float mouseY = Input.GetAxis("Mouse Y") * look.cameraSensitivity * (Time.deltaTime + Time.deltaTime / 2);

		physics.xRotation -= mouseY;
		physics.xRotation = Mathf.Clamp(physics.xRotation, -90f, 90f);

		Camera camera = look.camera;
		if (camera != null)
		{
			camera.transform.localRotation = Quaternion.Euler(physics.xRotation, 0f, 0f);
		}

		transform.Rotate(Vector3.up * mouseX);
	}

	void Move()
	{
		// Handle player movement
		float moveForwardBackward = Input.GetAxis("Vertical");
		float moveLeftRight = Input.GetAxis("Horizontal");

		physics.moveDirection = transform.right * moveLeftRight + transform.forward * moveForwardBackward;


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
				if (look.bobSmoothing < 1)
				{
					look.bobSmoothing += Time.smoothDeltaTime;
				}
				else if (look.bobSmoothing > 1)
				{
					look.bobSmoothing = 1;
				}

				look.bobbingTimer += Time.deltaTime * physics.playerBody.velocity.magnitude * look.cameraBobSpeed;
				float bobbingAmount = look.bobSmoothing * animations.bobbingAnimation.Evaluate(look.bobbingTimer) * look.cameraBobbingSensitivity;
				Camera camera = GetComponentInChildren<Camera>();
				if (camera != null)
				{
					Vector3 localPos = camera.transform.localPosition;
					localPos.y = bobbingAmount;
					camera.transform.localPosition = localPos;
				}
			}
			else
			{
				if (look.bobSmoothing > 0)
				{
					look.bobSmoothing -= Time.smoothDeltaTime;
				}
				else if (look.bobSmoothing < 0)
				{
					look.bobSmoothing = 0;
				}

				look.bobbingTimer -= (int)look.bobbingTimer;
				if (look.bobbingTimer < 0)
				{
					look.bobbingTimer += 1;
				}
				else if (look.bobbingTimer > 1)
				{
					look.bobbingTimer -= 1;
				}
			}
		}
	}

	void HandleMovementType()
	{
		if (Input.GetKeyDown(KeyCode.C) && physics.isGrounded)
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
		Transform boneRoot = animations.rootBone;

		// Remove old model
		for (int i = 0; i < models.modelTransform.childCount; i++)
		{
			var child = models.modelTransform.GetChild(i);
			if (child != boneRoot)
			{
				Destroy(child);
			}
		}

		GameObject[] meshes = models.playerModels[index].skinnedGameObjects;

		// Add new model
		for (int i = 0; i < meshes.Length; i++)
		{
			GameObject newModel = Instantiate(meshes[i], models.modelTransform);
			SkinnedMeshRenderer renderer = newModel.GetComponent<SkinnedMeshRenderer>();
			renderer.rootBone = boneRoot;

			// Handle animator
			Animator newModelAnimator = newModel.GetComponent<Animator>();
			if (newModelAnimator)
			{
				animations.animator.runtimeAnimatorController = newModelAnimator.runtimeAnimatorController;
				animations.animator.avatar = newModelAnimator.avatar;
			}
		}
	}


	void UpdateAnimationValues()
	{
		animations.animator.SetFloat("Horizontal", Input.GetAxis("Horizontal"));
		animations.animator.SetFloat("Vertical", Input.GetAxis("Vertical"));
		animations.animator.SetInteger("Movement Type", (int)movement.type);

	}

	#region Public Variable Classes
	[Serializable]
	public class Movement
	{
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
		internal enum MovementType { Walking = 0, Running = 1, Crouching = 2, Climbing = 3, Swimming = 4}
		internal MovementType type = MovementType.Walking;
	}

	[Serializable]
	public class Look
	{
		#region Inspector Variables
		[SerializeField]
		internal Camera camera;
		[SerializeField]
		internal Transform cameraPivot;
		public float cameraBobSpeed = 1;
		public float cameraSensitivity = 5;
		public float cameraSmoothing = 1;
		public float cameraBobbingSensitivity = 2f;

		#endregion

		internal float bobbingTimer = 0;

		internal float bobSmoothing = 0;
	}

	[Serializable]
	public class Animations
	{
		#region Inspector Variables
		public bool cameraBob = true;
		[SerializeField]
		internal AnimationCurve bobbingAnimation;
		[SerializeField]
		internal Animator animator;
		[SerializeField]
		internal Transform rootBone;
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
	}

	[Serializable]
	public class Models
	{
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
	public class Controls
	{
		#region Inspector Variables
		#endregion
	}

	[Serializable]
	public class Physics
	{
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
				// The ray will be cast from slightly above the bottom of the player to just below the bottom of the player
				rayOrigin = playerTransform.position + (Vector3.up * 0.05f);
				rayDistance = rayOrigin.y + groundCheckDistance;
				
				// Perform the raycast
				return UnityEngine.Physics.Raycast(rayOrigin, Vector3.down, groundCheckDistance, groundMask);
			}
		}

		internal float xRotation = 0f;
	}

	[Serializable]
	public class Sound
	{
		#region Inspector Variables
		[SerializeField]
		internal AudioClip[] footstepsGrass;
		[SerializeField]
		internal AudioClip[] footstepsDirt;
		[SerializeField]
		internal AudioClip[] footstepsWood;

		public AudioSource audio;
		#endregion
	}

	[Serializable]
	public class Settings
	{
		[SerializeField]
		internal bool firstPerson = true;
	}

	[Serializable]
	public class ShitsNGigs
	{
		internal bool superRun; // lmao https://www.mixamo.com/#/?page=1&query=Run&type=Motion%2CMotionPack
	}
	#endregion

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

}
