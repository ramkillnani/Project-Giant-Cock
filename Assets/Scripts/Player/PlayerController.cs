// Written by Peter Thompson
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;
using UnityEngine.InputSystem;
using Items;
using EVP;
using System.Linq;
using UnityEngine.AI;
using System.Threading;
using System.Net.PeerToPeer.Collaboration;

// Brackets show this - ("What adding this functionality will do for this script/How important it is to finish")
// TODO (Functionality/High): cull out character if camera is in first person
// TODO (Functionality/Medium): Setup item holding for first person
// TODO (Performance/Low): Create private variables which get set from the serialized variables. This will make it harder to
// hack, and increase performance. It will also allow us to create scriptable objects for the player variables
// which will be handy if this player controller is used in future projects.

namespace Player
{
	[RequireComponent(typeof(Rigidbody))]
	public class PlayerController : MonoBehaviour
	{
		public static PlayerController localPlayer = null;

		public enum PlayerType { User, Network }
		public PlayerType playerType = PlayerType.User;

		public enum PlayerState { Movement, Ragdoll, Vehicle }
		public PlayerState state = PlayerState.Movement;

		#region Assorted variables
		public AI ai;
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
		// Placeholder for now
		public Networking networking;
		// Class that holds references to GUI elements
		public UI ui;
		// Class that holds vehicle stuff
		public Vehicles vehicles;
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
			ai.Start(this);
			animations.Start(this);
			inventory.Start(this);
			look.Start(this);
			models.Start(this);
			movement.Start(this);
			physics.Start(this);
			settings.Start(this);
			sound.Start(this);
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

			// Apply custom animations
			//ApplyAnimationClips();

			// Start retrieving animation values
			StartCoroutine(UpdateAnimationVariables());

			if (playerType == PlayerType.User)
			{
				// Setup Cinemachine
				SetupCamera();
			}
		}

		private void Update()
		{
			// If currently being controlled by the player themself
			if (playerType == PlayerType.User)
			{
				if (state == PlayerState.Movement)
				{
					PlayerMovement();
					PlayerFunctionality();
				}
				else if (state == PlayerState.Vehicle)
				{

				}
			}
			// Networked movement
			else
			{

			}

			// Apply a new player model manually
			if (models.applyModel)
			{
				models.applyModel = false;
				ApplyPlayerModel(models.selectedPlayerIndex);
			}
		}

		void PlayerMovement()
		{
			Rotate();
			Move();
			Jump();
			CameraBobbing();
			HandleMovementType();
			CheckSubmersion();
			Slide();
		}

		void PlayerFunctionality()
		{
			Interact();
		}

		private void FixedUpdate()
		{
			if (state == PlayerState.Movement)
			{
				ApplyMovement();
			}
		}

		void SetupCamera()
		{
			look.cinemachineCamera.GetCinemachineComponent<CinemachinePOV>().m_HorizontalAxis.m_MaxSpeed = look.cameraSensitivity;
			look.cinemachineCamera.GetCinemachineComponent<CinemachinePOV>().m_VerticalAxis.m_MaxSpeed = look.cameraSensitivity;
			look.cinemachineBob = look.cinemachineCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		}

		void ApplyMovement()
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

			if (!ai.navMeshAgent.enabled && state == PlayerState.Movement)
			{
				physics.playerBody.MovePosition(physics.playerBody.position + move);

			}
		}

		void Rotate()
		{
			if (state == PlayerState.Movement)
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
			else if (state == PlayerState.Vehicle)
			{
				// Send rotation controls to vehicle camera?
			}
		}

		void Move()
		{
			if (!ai.navMeshAgent.enabled)
			{
				if (state == PlayerState.Movement)
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
			}
		}

		void Jump()
		{
			// Handle jumping
			if (controls.Jump && physics.isGrounded)
			{
				physics.playerBody.velocity = new Vector3(physics.playerBody.velocity.x, movement.jumpHeight * movement.jumpHeightConversion, physics.playerBody.velocity.z);

			}
		}

		void ApplySlideFriction()
		{
			Vector3 horizontalVelocity = new Vector3(physics.playerBody.velocity.x, 0, physics.playerBody.velocity.z);
			horizontalVelocity *= (1 - movement.slideFriction * Time.deltaTime);
			physics.playerBody.velocity = new Vector3(horizontalVelocity.x, physics.playerBody.velocity.y, horizontalVelocity.z);

			// Stop sliding if the speed is too slow
			if (horizontalVelocity.magnitude < 0.5f)
			{
				physics.isSliding = false;
				movement.type = Movement.MovementType.Walking;
			}
		}

		void Slide()
		{
			if (controls.Crouch && movement.type == Movement.MovementType.Running && physics.isGrounded)
			{
				StartSliding();
			}

			if (physics.isSliding)
			{
				ApplySlideFriction();
			}
		}

		void StartSliding()
		{
			physics.isSliding = true;
			movement.type = Movement.MovementType.Sliding;

			// Apply a force in the direction of the player's movement
			Vector3 slideForce = physics.moveDirection.normalized * movement.slideSpeed;
			physics.playerBody.AddForce(slideForce, ForceMode.VelocityChange);
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
			// Draw the jump ray
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(physics.rayOrigin, physics.rayOrigin + (Vector3.down * physics.rayDistance));

			// Draw the interact ray
			Vector3 rayOrigin = look.cameraPivot.transform.position;
			Vector3 rayDirection = look.cameraPivot.transform.forward;
			Gizmos.color = Color.red; // Set the color of the ray to red
			Gizmos.DrawLine(rayOrigin, rayOrigin + rayDirection * settings.interactions.distance);
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


		// Due to the nature of using "get" for the movement variables,
		// calling these variables multiple times can cause a performance drop.
		// Due to this, I have implemented an animation update rate to call
		// these variables less
		IEnumerator UpdateAnimationVariables()
		{
			float waitTime = 1 / settings.performance.animationVariableUpdateRate;

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
				yield return new WaitForSeconds(waitTime);
			}
		}

		private void UpdateAnimationValues()
		{
			float frameTime = Time.deltaTime; //1 / settings.performance.animationVariableUpdateRate;
			float smoothRate = animations.movementSmoothing;

			animations.animator.SetInteger("Movement Type", (int)movement.type);
			animations.animator.SetBool("isGrounded", physics.isGrounded);
			animations.animator.SetBool("isMoving", physics.isMoving);

			// Smooth values to stop instant animation change when opposite axis buttons get pressed
			float horizontal = Mathf.Lerp(animations.animator.GetFloat("Horizontal"), controls.HorizontalMove, smoothRate * frameTime);
			float vertical = Mathf.Lerp(animations.animator.GetFloat("Vertical"), controls.VerticalMove, smoothRate * frameTime);
			animations.animator.SetFloat("Horizontal", horizontal);
			animations.animator.SetFloat("Vertical", vertical);

			// Using "jumpReset" instead of "Jump" to check if jump was pressed between the frames
			// that this method was not called in (because this method is running at a different
			// frame rate set in settings.performace)
			if (controls.jumpReset)
			{
				controls.jumpReset = false;
				animations.animator.SetTrigger("Jump");
			}

			if (vehicles.currentVehicle != null)
			{
				animations.animator.SetBool("IsDriver", vehicles.currentVehicle.GetSeatFromPlayer(this).isDriver);

			}
		}

		// TODO: Set interact timer to limit all interactions to 0.25 seconds
		void Interact()
		{
			// Get the camera's forward direction
			Vector3 rayDirection = look.cameraPivot.transform.forward;

			// Shoot a ray from the camera's position in its forward direction
			RaycastHit hit;
			if (UnityEngine.Physics.Raycast(look.cameraPivot.transform.position, rayDirection, out hit, settings.interactions.distance))
			{
				// Check if the hit object has an Interactable script attached
				Interactable interactable = hit.collider.GetComponent<Interactable>();
				if (interactable != null)
				{
					if (interactable.type == InteractType.Vehicle)
					{
						if (interactable.connectedVm.VehicleFull)
						{
							return; // return if vehicle is full
						}
					}

					Debug.Log("Player can interact with this object");
					ui.interactText.SetActive(true);

					// Check if the Interact control is pressed
					if (controls.Interact)
					{
						// Call interact
						interactable.Interact(this);
					}
				}
				else
				{
					ui.interactText.SetActive(false);
				}
			}
			else
			{
				ui.interactText.SetActive(false);
			}
		}

		public void ApplyRagdoll()
		{
			//if (state == PlayerState.Transitioning)
			//{
			//	state = PlayerState.Ragdoll;
			//}
		}

		#region Interaction Calls


		public void OnItemInteraction(Item item)
		{
			inventory.Add(item);
			AttachItem(item);
			item.AddToInventory(this);
		}

		public void OnDoorInteraction(Door door)
		{

		}
		#endregion

		void AttachItem(Item item)
		{

		}

		public void OnVehicleInteraction(VehicleManager vehicleManager)
		{
			if (state == PlayerState.Movement)
			{
				// Move player towards walk-in point
				SetVehicleWaypoint(vehicleManager);

			}
			else if (state == PlayerState.Vehicle)
			{
				// Exiting vehicle
				//state = PlayerState.Transitioning;
				OnVehicleInteractionExit(vehicleManager);
			}
		}

		void SetVehicleWaypoint(VehicleManager vehicleManager)
		{
			VehicleSeat selectedSeat = null;

			// Check if driver seat is empty
			if (vehicleManager.GetDriverSeat != null)
			{
				selectedSeat = vehicleManager.GetDriverSeat;
			}
			else
			{
				// That means driver seat is taken
				// Check for closest seat available

				Dictionary<VehicleSeat, float> handleDistances = new Dictionary<VehicleSeat, float>();

				for (int i = 0; i < vehicleManager.vehicleSeats.Length; i++)
				{
					// If its not a driver seat, add it
					if (vehicleManager.vehicleSeats[i].isDriver == false)
					{
						handleDistances.Add(vehicleManager.vehicleSeats[i], Vector3.Distance(transform.position, vehicleManager.vehicleSeats[i].doorHandle.position));
					}
				}

				selectedSeat = handleDistances.OrderBy(kvp => kvp.Value).First().Key;
			}

			selectedSeat.seatedPlayer = this;

			// Set destination to the selected vehicle's seat
			ai.EnableAgent(selectedSeat.movePosition);

			LockControls();

			// Check for when destination is reached and update seat destination if needed
			StartCoroutine(CheckVehicleDestinationReached(vehicleManager, selectedSeat));
		}



		IEnumerator CheckVehicleDestinationReached(VehicleManager vehicleManager, VehicleSeat selectedSeat)
		{
			while (true)
			{
				if (state == PlayerState.Movement)
				{
					if (!ai.navMeshAgent.enabled)
					{
						ai.EnableAgent(selectedSeat.movePosition);
					}

					// Update destination position if the car moves
					if (ai.navMeshAgent.destination != selectedSeat.movePosition.position)
					{
						ai.SetDestination(selectedSeat.movePosition);
					}

					if (!ai.navMeshAgent.hasPath && ai.navMeshAgent.enabled && ai.navMeshAgent.velocity.sqrMagnitude == 0f)
					{
						if (Vector3.Distance(selectedSeat.movePosition.position, transform.position) <= ai.stoppingDistance)
						{
							//ai.DisableAgent();
							OnVehicleInteractionEnter(vehicleManager, selectedSeat);

							yield break;
						}
					}
				}
				else
				{
					ai.DisableAgent();
					yield break;
				}


				yield return new WaitForFixedUpdate();
			}
		}

		// Called when control lock gets disabled from an enabled state
		public void OnVehicleInteractCancel()
		{
			StopCoroutine(nameof(CheckVehicleDestinationReached));
			animations.SetState(0);
		}

		private void OnVehicleInteractionEnter(VehicleManager vehicleManager, VehicleSeat seat)
		{
			Debug.Log("Entering vehicle!!");

			ai.DisableAgent();


			StartCoroutine(TurnPlayerTowardsDoor(seat, vehicleManager));
			// Set Layer to driving layer
			animations.SetState(1);

			// Play getting in vehicle animation

			//vehicles.currentVehicle = vehicleManager;

		}

		IEnumerator TurnPlayerTowardsDoor(VehicleSeat seat, VehicleManager vehicleManager)
		{

			while (true)
			{
				if (controls.HorizontalMove == 0 && controls.VerticalMove == 0)
				{
					// Set height to be the same so vertical rotation does not happen
					Vector3 camPos = new Vector3(transform.position.x, 0, transform.position.z);
					Vector3 handlePos = new Vector3(seat.doorHandle.position.x, 0, seat.doorHandle.position.z);
					Vector3 direction = handlePos - camPos;

					// Apply Rotation
					transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(direction), 5 * Time.deltaTime);

					if (Vector3.Distance(transform.rotation.eulerAngles, Quaternion.LookRotation(direction).eulerAngles) < 0.1f)
					{
						Debug.Log("Player should be looking at door handle");
						// Remove this as it should be run from an animation state behaviour
						vehicles.currentVehicle = vehicleManager;
						OnVehicleEnter();
						yield break;
					}

					yield return null;
				}
				else
				{
					Debug.Log("Player look interupted");

					yield break;
				}
			}
		}

		private void OnVehicleInteractionExit(VehicleManager vehicleManager)
		{
			vehicleManager.input.enabled = false;
			vehicleManager.input.player = null;

			// Play getting in vehicle animation

			vehicles.currentVehicle = null;
		}

		// Called from Animation Controller transition
		public void OnVehicleEnter()
		{
			if (vehicles.currentVehicle != null)
			{
				VehicleStandardInput vehicleInput = vehicles.currentVehicle.input;

				vehicleInput.enabled = true;
				vehicleInput.player = this;

				PlacePlayerInCar();
			}
			else
			{
				Debug.LogError("FAILED TO GET CURRENT VEHICLE!");
			}
		}

		// Make sure player animation has played or player will snap into car
		void PlacePlayerInCar()
		{
			Debug.Log("Placing player in car");
			state = PlayerState.Vehicle;
			// Turn off movement collider
			physics.playerCollider.enabled = false;
			// Apply positon
			physics.playerBody.isKinematic = true;
			transform.parent = vehicles.currentVehicle.GetSeatFromPlayer(this).playerParent;
			transform.localPosition = new Vector3(0, vehicles.cameraHeightOffset, 0);
			transform.localRotation = Quaternion.identity;
		}

		public void LockControls()
		{
			controls.controlLock = true;
		}

		public void UnlockControls()
		{
			controls.controlLock = false;
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
	public class AI
	{
		private PlayerController controller;

		internal NavMeshAgent navMeshAgent;
		internal Transform wayPoint;

		[SerializeField]
		internal float stoppingDistance = 0.3f;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
			navMeshAgent = controller.GetComponent<NavMeshAgent>();
			navMeshAgent.enabled = false;
		}

		public void SetDestination(Transform pos)
		{
			navMeshAgent.SetDestination(pos.position);
		}

		internal void EnableAgent(Transform destination)
		{
			controller.physics.playerBody.isKinematic = true;
			navMeshAgent.enabled = true;

			if (navMeshAgent.destination != destination.position)
			{
				navMeshAgent.SetDestination(destination.position);
			}

			Debug.Log("Player AI Enabled!");
		}

		internal void DisableAgent()
		{
			controller.physics.playerBody.isKinematic = false;
			navMeshAgent.ResetPath();
			navMeshAgent.enabled = false;

			Debug.Log("Player AI Disabled!");

		}
	}

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
		public float movementSmoothing = 5;

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

		internal void ApplyAnimationClips()
		{
			AnimatorOverrideController aoc = animator.runtimeAnimatorController as AnimatorOverrideController;
			Debug.Log(aoc.name + "Override controller created.");
			if (aoc != null)
			{
				// Idle
				aoc["Idle"] = animationClips.idling.idle;
				aoc["Crouching Idle"] = animationClips.idling.crouchIdle;

				// Jogging
				aoc["Jog Forward"] = animationClips.walking.forward;
				aoc["Jog Backward"] = animationClips.walking.backward;
				aoc["Jog Strafe Left"] = animationClips.walking.left;
				aoc["Jog Strafe Right"] = animationClips.walking.right;

				// Running
				aoc["Run Forward"] = animationClips.running.forward;
				aoc["Left Strafe"] = animationClips.running.left;
				aoc["Right Strafe"] = animationClips.running.right;

				// Crouching
				aoc["Crouched Walking"] = animationClips.crouching.forward;
				aoc["Crouched Walking Backwards"] = animationClips.crouching.backward;
				aoc["Crouched Sneaking Left"] = animationClips.crouching.left;
				aoc["Crouched Sneaking Right"] = animationClips.crouching.left;

				// Climbing

				// Swimming

			}
			Debug.Log("Applying override controller...");
			animator.runtimeAnimatorController = aoc;
			if (animator.runtimeAnimatorController == aoc)
			{
				Debug.Log(animator.runtimeAnimatorController.name + "override applied successfully!");
			}
		}

		internal void SetState(int e)
		{
			animator.SetInteger("State", e);
		}
	}

	[Serializable]
	public class Controls
	{
		private PlayerController controller;

		[SerializeField]
		private float _controlLockTime = 0.25f;

		private float controlLockTime = 0;
		public bool controlLock = false;

		private bool pressedDuringLock = false;
		private bool pressedDuringLock1 = false;
		public float HorizontalMove
		{
			get
			{
				if (!controlLock)
				{
					if (pressedDuringLock)
					{
						pressedDuringLock = false;
					}

					if (controlLockTime <= 0)
					{
#if ENABLE_INPUT_SYSTEM
						return movementAction.ReadValue<Vector2>().x;
#else
						return Input.GetAxis("Horizontal");
#endif
					}
					else
					{
						return 0;
					}
				}
				else
				{
					if (movementAction.triggered)
					{
						if (!pressedDuringLock)
						{
							pressedDuringLock = true;

							return 0;
						}
						else
						{
							if (!pressedDuringLock1)
							{
								pressedDuringLock1 = true;
								return 0;
							}
							else
							{
								pressedDuringLock = false;
								pressedDuringLock1 = false;
								controlLock = false;
								controller.OnVehicleInteractCancel();

								if (controller.ai.navMeshAgent.enabled)
								{
									controller.ai.DisableAgent();
								}

								return movementAction.ReadValue<Vector2>().x;
							}

						}
					}
					else
					{
						return 0;

					}
				}
			}
		}

		public float VerticalMove
		{
			get
			{
				if (!controlLock)
				{
					if (controlLockTime <= 0)
					{
#if ENABLE_INPUT_SYSTEM
						return movementAction.ReadValue<Vector2>().y;
#else
				return Input.GetAxis("Vertical");
#endif
					}
					else
					{
						return 0;
					}
				}
				else
				{
					// Comment out because it may run twice? (guess - change if wrong)
					//if (movementAction.triggered)
					//{
					//	if (!pressedDuringLock)
					//	{
					//		pressedDuringLock = true;
					//		return 0;
					//	}
					//	else
					//	{
					//		pressedDuringLock = false;
					//		controlLock = false;
					//		controller.OnVehicleInteractCancel();

					//		if (controller.ai.navMeshAgent.enabled)
					//		{
					//			controller.DisableAgent();
					//		}

					//		return movementAction.ReadValue<Vector2>().x;
					//	}
					//}
					return controller.ai.navMeshAgent.velocity.sqrMagnitude;
				}
			}
		}

		internal bool jumpReset;
		public bool Jump
		{
			get
			{
				if (!controlLock)
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
				else
				{
					jumpReset = false;
					return false;
				}
			}
		}

		private bool triggerRun = false;

		public bool Run
		{
			get
			{
				if (!controlLock)
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
				else
				{
					triggerRun = false;
					return false;
				}
			}
		}

		private bool triggerCrouch = false;
		public bool Crouch
		{
			get
			{
				if (!controlLock)
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
				else
				{
					triggerCrouch = false;
					return false;
				}
			}
		}

		public float HorizontalLook
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM
					return mouseAction.ReadValue<Vector2>().x; ;
#else
					return Input.GetAxis("Mouse X");
#endif
				}
				else
				{
					return 0;
				}
			}
		}

		public float VerticalLook
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM
					return mouseAction.ReadValue<Vector2>().y;
#else
				return Input.GetAxis("Mouse Y");
#endif
				}
				else
				{
					return 0;
				}
			}
		}

		public bool interactReset;
		public bool Interact
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM
					interactReset = true;
					return interactAction.triggered;
#else
				interactReset = true;
				return Input.GetButtonDown("Interact");
#endif
				}
				else
				{
					return false;
				}
			}
		}

		public bool Use
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM

					return useAction.triggered;
#else
					return Input.GetButton("Fire");
#endif
				}
				else
				{
					return false;
				}
			}
		}

		public bool Aim
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM

					return aimAction.ReadValue<float>() > holdThreshold;
#else
				return Input.GetButton("Aim");
#endif
				}
				else
				{
					return false;
				}
			}
		}

		public bool DropItem
		{
			get
			{
				if (!controlLock)
				{
#if ENABLE_INPUT_SYSTEM

					return dropAction.triggered;
#else
				return Input.GetButton("Drop Item");
#endif
				}
				else
				{
					return false;
				}
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
		private InputAction dropAction;

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
			dropAction = input.actions["Drop Item"];
#endif
		}

	}

	[Serializable]
	public class Inventory
	{
		private PlayerController controller;

		internal Item curItem;

		internal List<Item> inventory = new List<Item>();

		[SerializeField]
		internal int size = 3;

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}

		internal void Add(Item item)
		{
			if (inventory.Count < size)
			{
				inventory.Add(item);
			}
			else
			{
				Debug.Log("Inventory is maxed out bitch");
			}
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
		[SerializeField]
		internal float slideFriction = 0.5f;  // The friction when sliding. Lower values make the slide last longer.
		[SerializeField]
		internal float slideSpeed = 10f;   // The speed at which the player slides.

		// Fake friction for movement. Can use to simulate friction for movement only, however this smoothes the input axis rather than rigidbody itself.
		[SerializeField]
		internal float smoothing = 10;

		// Slows the player down if player is in water
		[SerializeField]
		internal float submergedSpeedMultiplier = 0.5f;
		#endregion

		internal float jumpHeightConversion = 4f;
		internal enum MovementType { Walking = 0, Running = 1, Crouching = 2, Climbing = 3, Swimming = 4, Sliding = 5 }
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

		internal bool isRagdoll = false;
		internal bool isSliding = false;

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
		public Interactions interactions;

		[Serializable]
		public class Performance
		{
			public int animationVariableUpdateRate = 30;
			public int checkInteractionRate = 20;
		}

		[Serializable]
		public class Interactions
		{
			[SerializeField]
			internal int distance;
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
	public class UI
	{
		private PlayerController controller;

		#region Inspector Variables
		[SerializeField]
		internal GameObject playerUI;
		[SerializeField]
		internal GameObject vehicleUI;
		[SerializeField]
		internal GameObject menuUI;
		[Space]
		[SerializeField]
		internal GameObject interactText;
		#endregion

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}

	[Serializable]
	public class Vehicles
	{
		private PlayerController controller;

		#region Inspector Variables
		public float cameraHeightOffset = -0.4f;
		public VehicleManager currentVehicle;

		[SerializeField]
		internal float transitionTime = 1;
		#endregion

		internal void Start(PlayerController controller)
		{
			this.controller = controller;
		}
	}
	#endregion
}
