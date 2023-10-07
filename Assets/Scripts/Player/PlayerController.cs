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

	// Variables that will be used in runtime
	private Runtime p;
	#endregion

	private class Runtime
	{
		
	}

	private void Start()
	{
		if (physics.playerBody == null)
		{
			physics.playerBody = GetComponent<Rigidbody>();
		}

		// Lock the cursor to the center of the screen
		Cursor.lockState = CursorLockMode.Locked;
	}

	private void Update()
	{

		Rotate();
		Move();
		CameraBobbing();
		HandleCrouch();
		CheckSubmersion();
	}

	private void FixedUpdate()
	{
		ProcessPhysics();
	}

	void ProcessPhysics()
	{
		float speed = (Input.GetKey(KeyCode.LeftShift)) ? movement.runSpeed : movement.walkSpeed;
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

		Camera camera = GetComponentInChildren<Camera>();
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

		// Handle jumping
		if (Input.GetButtonDown("Jump") && physics.isGrounded)
		{
			physics.playerBody.velocity = new Vector3(physics.playerBody.velocity.x, movement.jumpForce, physics.playerBody.velocity.z);
		}

		CheckGrounded();
	}

	private bool CheckGrounded()
	{
		// The ray will be cast from slightly above the bottom of the player to just below the bottom of the player
		Vector3 rayOrigin = transform.position + (Vector3.up * 0.05f);
		float rayDistance = rayOrigin.y + physics.groundCheckDistance;

		// Perform the raycast
		bool hitGround = UnityEngine.Physics.Raycast(rayOrigin, Vector3.down, rayDistance, physics.groundMask);
		return hitGround;
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

	void HandleCrouch()
	{
		if (Input.GetKeyDown(KeyCode.C))
		{
			movement.isCrouching = !movement.isCrouching;
			if (movement.isCrouching)
			{
				transform.localScale = new Vector3(1, 0.5f, 1); // Reduce the player's height
				movement.walkSpeed = movement.crouchSpeed;      // Reduce the walking speed
			}
			else
			{
				transform.localScale = Vector3.one;             // Return to normal height
				movement.walkSpeed = 4;                         // Reset the walking speed
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
		DrawJumpDistance();
	}

	void DrawJumpDistance()
	{
		if (physics.playerCollider == null) return;

		Vector3 rayOrigin = transform.position + (Vector3.up * 0.05f);
		float rayDistance = rayOrigin.y + physics.groundCheckDistance;

		// Draw the ray in red
		Gizmos.color = Color.red;
		Gizmos.DrawLine(rayOrigin, rayOrigin + (Vector3.down * rayDistance));
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
		internal float jumpForce = 10f;
		[SerializeField]
		internal float climbSpeed = 2;

		// Slows the player down if player is in water
		[SerializeField]
		internal float submergedSpeedMultiplier = 0.5f;
		#endregion

		internal bool isCrouching = false;
	}

	[Serializable]
	public class Look
	{
		#region Inspector Variables
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
		#endregion
		[SerializeField]
		internal AnimationCurve bobbingAnimation;
	}

	[Serializable]
	public class Models
	{
		#region Inspector Variables
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

		internal Vector3 moveDirection;
		public bool isGrounded;
		internal float xRotation = 0f;
	}
	#endregion
}
