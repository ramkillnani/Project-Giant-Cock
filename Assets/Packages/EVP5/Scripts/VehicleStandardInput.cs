//------------------------------------------------------------------------------------------------
// Edy's Vehicle Physics
// (c) Angel Garcia "Edy" - Oviedo, Spain
// http://www.edy.es
//------------------------------------------------------------------------------------------------
using System;
using UnityEngine;
using UnityEngine.InputSystem;
using Player;

namespace EVP
{
	#region Player Controller Integrated
	public class VehicleStandardInput : MonoBehaviour
	{
		public PlayerController player;

		public VehicleController target;
		[Space]
		public bool continuousForwardAndReverse = true;
		public bool handbrakeOverridesThrottle = false;
		public enum ThrottleAndBrakeInput { SingleAxis, SeparateAxes };
		[Space]
		public ThrottleAndBrakeInput throttleAndBrakeInput = ThrottleAndBrakeInput.SingleAxis;


#if ENABLE_INPUT_SYSTEM
		[SerializeField]
		private InputSys inputSystem = new InputSys();

		[Serializable]
		private class InputSys
		{
			public InputAction steerAxis;
			public InputAction throttleAndBrakeAxis;
			public InputAction throttleAxis;
			public InputAction brakeAxis;
			public InputAction handbrakeAxis;
			public InputAction resetVehicleKey;

			public InputAction ctrl;
		}
#else
			[SerializeField]
			private OldInput oldInput = new OldInput();

			[Serializable]
			private class OldInput
			{
				public string steerAxis = "Horizontal";
				public string throttleAndBrakeAxis = "Vertical";
				public string throttleAxis = "Fire2";
				public string brakeAxis = "Fire3";
				public string handbrakeAxis = "Jump";
				public KeyCode resetVehicleKey = KeyCode.Return;
			}
#endif

		bool m_doReset = false;

		void OnEnable()
		{
#if ENABLE_INPUT_SYSTEM
			inputSystem.steerAxis.Enable();
			inputSystem.throttleAndBrakeAxis.Enable();
			inputSystem.throttleAxis.Enable();
			inputSystem.brakeAxis.Enable();
			inputSystem.handbrakeAxis.Enable();
			inputSystem.resetVehicleKey.Enable();
			inputSystem.ctrl.Enable();
#endif
			// Cache vehicle
			if (target == null)
				target = GetComponent<VehicleController>();
		}


		void OnDisable()
		{
#if ENABLE_INPUT_SYSTEM
			inputSystem.steerAxis.Disable();
			inputSystem.throttleAndBrakeAxis.Disable();
			inputSystem.throttleAxis.Disable();
			inputSystem.brakeAxis.Disable();
			inputSystem.handbrakeAxis.Disable();
			inputSystem.resetVehicleKey.Disable();
			inputSystem.ctrl.Disable();
#endif
			if (target != null)
			{
				target.steerInput = 0.0f;
				target.throttleInput = 0.0f;
				target.brakeInput = 0.0f;
				target.handbrakeInput = 0.0f;
			}
		}


		void Update()
		{
			if (target == null) return;

#if !ENABLE_INPUT_SYSTEM
				if (Input.GetKeyDown(oldInput.resetVehicleKey)) m_doReset = true;
#else
			if (inputSystem.resetVehicleKey.triggered)
			{
				m_doReset = true;
			}
#endif
		}


		void FixedUpdate()
		{
			if (target == null) return;

			// Read the user input

#if !ENABLE_INPUT_SYSTEM
				float steerInput = Mathf.Clamp(Input.GetAxis(oldInput.steerAxis), -1.0f, 1.0f);
				float handbrakeInput = Mathf.Clamp01(Input.GetAxis(oldInput.handbrakeAxis));
#else
			float steerInput = Mathf.Clamp(inputSystem.steerAxis.ReadValue<float>(), -1.0f, 1.0f);
			float handbrakeInput = Mathf.Clamp01(inputSystem.handbrakeAxis.ReadValue<float>());
#endif

			float forwardInput = 0.0f;
			float reverseInput = 0.0f;

			if (throttleAndBrakeInput == ThrottleAndBrakeInput.SeparateAxes)
			{
#if !ENABLE_INPUT_SYSTEM
					forwardInput = Mathf.Clamp01(Input.GetAxis(oldInput.throttleAxis));
					reverseInput = Mathf.Clamp01(Input.GetAxis(oldInput.brakeAxis));
#else
				forwardInput = Mathf.Clamp01(inputSystem.throttleAxis.ReadValue<float>());
				reverseInput = Mathf.Clamp01(inputSystem.brakeAxis.ReadValue<float>());

#endif
			}
			else
			{
#if !ENABLE_INPUT_SYSTEM
					forwardInput = Mathf.Clamp01(Input.GetAxis(oldInput.throttleAndBrakeAxis));
					reverseInput = Mathf.Clamp01(-Input.GetAxis(oldInput.throttleAndBrakeAxis));
#else
				forwardInput = Mathf.Clamp01(inputSystem.throttleAndBrakeAxis.ReadValue<float>());
				reverseInput = Mathf.Clamp01(-inputSystem.throttleAndBrakeAxis.ReadValue<float>());
#endif
			}

			// Translate forward/reverse to vehicle input

			float throttleInput = 0.0f;
			float brakeInput = 0.0f;

			if (continuousForwardAndReverse)
			{
				float minSpeed = 0.1f;
				float minInput = 0.1f;

				if (target.speed > minSpeed)
				{
					throttleInput = forwardInput;
					brakeInput = reverseInput;
				}
				else
				{
					if (reverseInput > minInput)
					{
						throttleInput = -reverseInput;
						brakeInput = 0.0f;
					}
					else if (forwardInput > minInput)
					{
						if (target.speed < -minSpeed)
						{
							throttleInput = 0.0f;
							brakeInput = forwardInput;
						}
						else
						{
							throttleInput = forwardInput;
							brakeInput = 0;
						}
					}
				}
			}
			else
			{
#if ENABLE_INPUT_SYSTEM
				bool reverse = inputSystem.ctrl.ReadValue<float>() > 0;
#else
					bool reverse = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);
#endif
				if (!reverse)
				{
					throttleInput = forwardInput;
					brakeInput = reverseInput;
				}
				else
				{
					throttleInput = -reverseInput;
					brakeInput = 0;
				}
			}

			// Override throttle if specified

			if (handbrakeOverridesThrottle)
			{
				throttleInput *= 1.0f - handbrakeInput;
			}

			// Apply input to vehicle

			target.steerInput = steerInput;
			target.throttleInput = throttleInput;
			target.brakeInput = brakeInput;
			target.handbrakeInput = handbrakeInput;

			// Do a vehicle reset

			if (m_doReset)
			{
				target.ResetVehicle();
				m_doReset = false;
			}
		}
	}
}
		#endregion

		#region OG Vehicle Input
		//	public class VehicleStandardInput : MonoBehaviour
		//	{
		//		public VehicleController target;

		//		public bool continuousForwardAndReverse = true;

		//		public enum ThrottleAndBrakeInput { SingleAxis, SeparateAxes };
		//		public ThrottleAndBrakeInput throttleAndBrakeInput = ThrottleAndBrakeInput.SingleAxis;
		//		public bool handbrakeOverridesThrottle = false;


		//#if ENABLE_INPUT_SYSTEM
		//		[SerializeField]
		//		private InputSystem inputSystem = new InputSystem();

		//		[Serializable]
		//		private class InputSystem
		//		{
		//			public InputAction steerAxis;
		//			public InputAction throttleAndBrakeAxis;
		//			public InputAction throttleAxis;
		//			public InputAction brakeAxis;
		//			public InputAction handbrakeAxis;
		//			public InputAction resetVehicleKey;

		//			public InputAction ctrl;
		//		}
		//#else
		//		[SerializeField]
		//		private OldInput oldInput = new OldInput();

		//		[Serializable]
		//		private class OldInput
		//		{
		//			public string steerAxis = "Horizontal";
		//			public string throttleAndBrakeAxis = "Vertical";
		//			public string throttleAxis = "Fire2";
		//			public string brakeAxis = "Fire3";
		//			public string handbrakeAxis = "Jump";
		//			public KeyCode resetVehicleKey = KeyCode.Return;
		//		}
		//#endif

		//		bool m_doReset = false;

		//		void OnEnable()
		//		{
		//#if ENABLE_INPUT_SYSTEM
		//			inputSystem.steerAxis.Enable();
		//			inputSystem.throttleAndBrakeAxis.Enable();
		//			inputSystem.throttleAxis.Enable();
		//			inputSystem.brakeAxis.Enable();
		//			inputSystem.handbrakeAxis.Enable();
		//			inputSystem.resetVehicleKey.Enable();
		//			inputSystem.ctrl.Enable();
		//#endif
		//			// Cache vehicle
		//			if (target == null)
		//				target = GetComponent<VehicleController>();
		//		}


		//		void OnDisable()
		//		{
		//#if ENABLE_INPUT_SYSTEM
		//			inputSystem.steerAxis.Disable();
		//			inputSystem.throttleAndBrakeAxis.Disable();
		//			inputSystem.throttleAxis.Disable();
		//			inputSystem.brakeAxis.Disable();
		//			inputSystem.handbrakeAxis.Disable();
		//			inputSystem.resetVehicleKey.Disable();
		//			inputSystem.ctrl.Disable();
		//#endif
		//			if (target != null)
		//			{
		//				target.steerInput = 0.0f;
		//				target.throttleInput = 0.0f;
		//				target.brakeInput = 0.0f;
		//				target.handbrakeInput = 0.0f;
		//			}
		//		}


		//		void Update()
		//		{
		//			if (target == null) return;

		//#if !ENABLE_INPUT_SYSTEM
		//			if (Input.GetKeyDown(oldInput.resetVehicleKey)) m_doReset = true;
		//#else
		//			if (inputSystem.resetVehicleKey.triggered)
		//			{
		//				m_doReset = true;
		//			}
		//#endif
		//		}


		//		void FixedUpdate()
		//		{
		//			if (target == null) return;

		//			// Read the user input

		//#if !ENABLE_INPUT_SYSTEM
		//			float steerInput = Mathf.Clamp(Input.GetAxis(oldInput.steerAxis), -1.0f, 1.0f);
		//			float handbrakeInput = Mathf.Clamp01(Input.GetAxis(oldInput.handbrakeAxis));
		//#else
		//			float steerInput = Mathf.Clamp(inputSystem.steerAxis.ReadValue<float>(), -1.0f, 1.0f);
		//			float handbrakeInput = Mathf.Clamp01(inputSystem.handbrakeAxis.ReadValue<float>());
		//#endif

		//			float forwardInput = 0.0f;
		//			float reverseInput = 0.0f;

		//			if (throttleAndBrakeInput == ThrottleAndBrakeInput.SeparateAxes)
		//			{
		//#if !ENABLE_INPUT_SYSTEM
		//				forwardInput = Mathf.Clamp01(Input.GetAxis(oldInput.throttleAxis));
		//				reverseInput = Mathf.Clamp01(Input.GetAxis(oldInput.brakeAxis));
		//#else
		//				forwardInput = Mathf.Clamp01(inputSystem.throttleAxis.ReadValue<float>());
		//				reverseInput = Mathf.Clamp01(inputSystem.brakeAxis.ReadValue<float>());

		//#endif
		//			}
		//			else
		//			{
		//#if !ENABLE_INPUT_SYSTEM
		//				forwardInput = Mathf.Clamp01(Input.GetAxis(oldInput.throttleAndBrakeAxis));
		//				reverseInput = Mathf.Clamp01(-Input.GetAxis(oldInput.throttleAndBrakeAxis));
		//#else
		//				forwardInput = Mathf.Clamp01(inputSystem.throttleAndBrakeAxis.ReadValue<float>());
		//				reverseInput = Mathf.Clamp01(-inputSystem.throttleAndBrakeAxis.ReadValue<float>());
		//#endif
		//			}

		//			// Translate forward/reverse to vehicle input

		//			float throttleInput = 0.0f;
		//			float brakeInput = 0.0f;

		//			if (continuousForwardAndReverse)
		//			{
		//				float minSpeed = 0.1f;
		//				float minInput = 0.1f;

		//				if (target.speed > minSpeed)
		//				{
		//					throttleInput = forwardInput;
		//					brakeInput = reverseInput;
		//				}
		//				else
		//				{
		//					if (reverseInput > minInput)
		//					{
		//						throttleInput = -reverseInput;
		//						brakeInput = 0.0f;
		//					}
		//					else if (forwardInput > minInput)
		//					{
		//						if (target.speed < -minSpeed)
		//						{
		//							throttleInput = 0.0f;
		//							brakeInput = forwardInput;
		//						}
		//						else
		//						{
		//							throttleInput = forwardInput;
		//							brakeInput = 0;
		//						}
		//					}
		//				}
		//			}
		//			else
		//			{
		//#if ENABLE_INPUT_SYSTEM
		//				bool reverse = inputSystem.ctrl.ReadValue<float>() > 0;
		//#else
		//				bool reverse = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);
		//#endif
		//				if (!reverse)
		//				{
		//					throttleInput = forwardInput;
		//					brakeInput = reverseInput;
		//				}
		//				else
		//				{
		//					throttleInput = -reverseInput;
		//					brakeInput = 0;
		//				}
		//			}

		//			// Override throttle if specified

		//			if (handbrakeOverridesThrottle)
		//			{
		//				throttleInput *= 1.0f - handbrakeInput;
		//			}

		//			// Apply input to vehicle

		//			target.steerInput = steerInput;
		//			target.throttleInput = throttleInput;
		//			target.brakeInput = brakeInput;
		//			target.handbrakeInput = handbrakeInput;

		//			// Do a vehicle reset

		//			if (m_doReset)
		//			{
		//				target.ResetVehicle();
		//				m_doReset = false;
		//			}
		//		}
		#endregion

		#region OG Improvement
		/* Code from Tim Korving for better handling the continuous forward
			and reverse mode. To be adapted and tested.

		void HandleVerticalInputModeInterrupt()                                         // Handle Interrupt input mode for forward reverse
			{
			if (m_MoveState == VERTICAL_INPUT_STATE.STATIONARY)
				{
				if (m_ForwardInput >= m_MinInput)                                       // If forward input...
					{
					ChangeVerticalInputState(VERTICAL_INPUT_STATE.FORWARD);
					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
					m_BrakeInput = 0f;                                                  // Release the brakes
					}
				else if (m_ReverseInput >= m_MinInput)                                  // If reverse input...
					{
					ChangeVerticalInputState(VERTICAL_INPUT_STATE.REVERSE);
					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (eek)
					m_BrakeInput = 0f;                                                  // Release the brakes
					}
				else
					{
					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
					}
				}
			else if (m_MoveState == VERTICAL_INPUT_STATE.FORWARD)
				{
				if (m_EVPController.speed >= m_MinSpeed)                                // Currently in forward motion
					{
					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
					m_BrakeInput = m_ReverseInput;                                      // Brake is reverse input
					}
				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
					{
					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
					m_BrakeInput = 0f;
					m_ForwardInput = 0f;
					m_ReverseInput = 0f;
					}
				}
			else if (m_MoveState == VERTICAL_INPUT_STATE.REVERSE)
				{
				if (m_EVPController.speed <= -m_MinSpeed)                               // Currently in backward motion
					{
					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (?)
					m_BrakeInput = m_ForwardInput;                                      // Brake is forward input
					}
				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
					{
					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
					m_BrakeInput = 0f;
					m_ForwardInput = 0f;
					m_ReverseInput = 0f;
					}
				}
			}
		*/

		//	}
	
#endregion

////------------------------------------------------------------------------------------------------
//// Edy's Vehicle Physics
//// (c) Angel Garcia "Edy" - Oviedo, Spain
//// http://www.edy.es
////------------------------------------------------------------------------------------------------

//using UnityEngine;

//namespace EVP
//{

//	public class VehicleStandardInput : MonoBehaviour
//	{
//		public VehicleController target;

//		public bool continuousForwardAndReverse = true;

//		public enum ThrottleAndBrakeInput { SingleAxis, SeparateAxes };
//		public ThrottleAndBrakeInput throttleAndBrakeInput = ThrottleAndBrakeInput.SingleAxis;
//		public bool handbrakeOverridesThrottle = false;

//		[Space(5)]
//		public string steerAxis = "Horizontal";
//		public string throttleAndBrakeAxis = "Vertical";
//		public string throttleAxis = "Fire2";
//		public string brakeAxis = "Fire3";
//		public string handbrakeAxis = "Jump";
//		public KeyCode resetVehicleKey = KeyCode.Return;

//		bool m_doReset = false;


//		void OnEnable()
//		{
//			// Cache vehicle

//			if (target == null)
//				target = GetComponent<VehicleController>();
//		}


//		void OnDisable()
//		{
//			if (target != null)
//			{
//				target.steerInput = 0.0f;
//				target.throttleInput = 0.0f;
//				target.brakeInput = 0.0f;
//				target.handbrakeInput = 0.0f;
//			}
//		}


//		void Update()
//		{
//			if (target == null) return;

//			if (Input.GetKeyDown(resetVehicleKey)) m_doReset = true;
//		}


//		void FixedUpdate()
//		{
//			if (target == null) return;

//			// Read the user input

//			float steerInput = Mathf.Clamp(Input.GetAxis(steerAxis), -1.0f, 1.0f);
//			float handbrakeInput = Mathf.Clamp01(Input.GetAxis(handbrakeAxis));

//			float forwardInput = 0.0f;
//			float reverseInput = 0.0f;

//			if (throttleAndBrakeInput == ThrottleAndBrakeInput.SeparateAxes)
//			{
//				forwardInput = Mathf.Clamp01(Input.GetAxis(throttleAxis));
//				reverseInput = Mathf.Clamp01(Input.GetAxis(brakeAxis));
//			}
//			else
//			{
//				forwardInput = Mathf.Clamp01(Input.GetAxis(throttleAndBrakeAxis));
//				reverseInput = Mathf.Clamp01(-Input.GetAxis(throttleAndBrakeAxis));
//			}

//			// Translate forward/reverse to vehicle input

//			float throttleInput = 0.0f;
//			float brakeInput = 0.0f;

//			if (continuousForwardAndReverse)
//			{
//				float minSpeed = 0.1f;
//				float minInput = 0.1f;

//				if (target.speed > minSpeed)
//				{
//					throttleInput = forwardInput;
//					brakeInput = reverseInput;
//				}
//				else
//				{
//					if (reverseInput > minInput)
//					{
//						throttleInput = -reverseInput;
//						brakeInput = 0.0f;
//					}
//					else if (forwardInput > minInput)
//					{
//						if (target.speed < -minSpeed)
//						{
//							throttleInput = 0.0f;
//							brakeInput = forwardInput;
//						}
//						else
//						{
//							throttleInput = forwardInput;
//							brakeInput = 0;
//						}
//					}
//				}
//			}
//			else
//			{
//				bool reverse = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);

//				if (!reverse)
//				{
//					throttleInput = forwardInput;
//					brakeInput = reverseInput;
//				}
//				else
//				{
//					throttleInput = -reverseInput;
//					brakeInput = 0;
//				}
//			}

//			// Override throttle if specified

//			if (handbrakeOverridesThrottle)
//			{
//				throttleInput *= 1.0f - handbrakeInput;
//			}

//			// Apply input to vehicle

//			target.steerInput = steerInput;
//			target.throttleInput = throttleInput;
//			target.brakeInput = brakeInput;
//			target.handbrakeInput = handbrakeInput;

//			// Do a vehicle reset

//			if (m_doReset)
//			{
//				target.ResetVehicle();
//				m_doReset = false;
//			}
//		}

//		/* Code from Tim Korving for better handling the continuous forward
//			and reverse mode. To be adapted and tested.

//		void HandleVerticalInputModeInterrupt()                                         // Handle Interrupt input mode for forward reverse
//			{
//			if (m_MoveState == VERTICAL_INPUT_STATE.STATIONARY)
//				{
//				if (m_ForwardInput >= m_MinInput)                                       // If forward input...
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.FORWARD);
//					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
//					m_BrakeInput = 0f;                                                  // Release the brakes
//					}
//				else if (m_ReverseInput >= m_MinInput)                                  // If reverse input...
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.REVERSE);
//					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (eek)
//					m_BrakeInput = 0f;                                                  // Release the brakes
//					}
//				else
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					}
//				}
//			else if (m_MoveState == VERTICAL_INPUT_STATE.FORWARD)
//				{
//				if (m_EVPController.speed >= m_MinSpeed)                                // Currently in forward motion
//					{
//					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
//					m_BrakeInput = m_ReverseInput;                                      // Brake is reverse input
//					}
//				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					m_BrakeInput = 0f;
//					m_ForwardInput = 0f;
//					m_ReverseInput = 0f;
//					}
//				}
//			else if (m_MoveState == VERTICAL_INPUT_STATE.REVERSE)
//				{
//				if (m_EVPController.speed <= -m_MinSpeed)                               // Currently in backward motion
//					{
//					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (?)
//					m_BrakeInput = m_ForwardInput;                                      // Brake is forward input
//					}
//				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					m_BrakeInput = 0f;
//					m_ForwardInput = 0f;
//					m_ReverseInput = 0f;
//					}
//				}
//			}
//		*/
//	}
//}//------------------------------------------------------------------------------------------------
//// Edy's Vehicle Physics
//// (c) Angel Garcia "Edy" - Oviedo, Spain
//// http://www.edy.es
////------------------------------------------------------------------------------------------------

//using UnityEngine;

//namespace EVP
//{

//	public class VehicleStandardInput : MonoBehaviour
//	{
//		public VehicleController target;

//		public bool continuousForwardAndReverse = true;

//		public enum ThrottleAndBrakeInput { SingleAxis, SeparateAxes };
//		public ThrottleAndBrakeInput throttleAndBrakeInput = ThrottleAndBrakeInput.SingleAxis;
//		public bool handbrakeOverridesThrottle = false;

//		[Space(5)]
//		public string steerAxis = "Horizontal";
//		public string throttleAndBrakeAxis = "Vertical";
//		public string throttleAxis = "Fire2";
//		public string brakeAxis = "Fire3";
//		public string handbrakeAxis = "Jump";
//		public KeyCode resetVehicleKey = KeyCode.Return;

//		bool m_doReset = false;


//		void OnEnable()
//		{
//			// Cache vehicle

//			if (target == null)
//				target = GetComponent<VehicleController>();
//		}


//		void OnDisable()
//		{
//			if (target != null)
//			{
//				target.steerInput = 0.0f;
//				target.throttleInput = 0.0f;
//				target.brakeInput = 0.0f;
//				target.handbrakeInput = 0.0f;
//			}
//		}


//		void Update()
//		{
//			if (target == null) return;

//			if (Input.GetKeyDown(resetVehicleKey)) m_doReset = true;
//		}


//		void FixedUpdate()
//		{
//			if (target == null) return;

//			// Read the user input

//			float steerInput = Mathf.Clamp(Input.GetAxis(steerAxis), -1.0f, 1.0f);
//			float handbrakeInput = Mathf.Clamp01(Input.GetAxis(handbrakeAxis));

//			float forwardInput = 0.0f;
//			float reverseInput = 0.0f;

//			if (throttleAndBrakeInput == ThrottleAndBrakeInput.SeparateAxes)
//			{
//				forwardInput = Mathf.Clamp01(Input.GetAxis(throttleAxis));
//				reverseInput = Mathf.Clamp01(Input.GetAxis(brakeAxis));
//			}
//			else
//			{
//				forwardInput = Mathf.Clamp01(Input.GetAxis(throttleAndBrakeAxis));
//				reverseInput = Mathf.Clamp01(-Input.GetAxis(throttleAndBrakeAxis));
//			}

//			// Translate forward/reverse to vehicle input

//			float throttleInput = 0.0f;
//			float brakeInput = 0.0f;

//			if (continuousForwardAndReverse)
//			{
//				float minSpeed = 0.1f;
//				float minInput = 0.1f;

//				if (target.speed > minSpeed)
//				{
//					throttleInput = forwardInput;
//					brakeInput = reverseInput;
//				}
//				else
//				{
//					if (reverseInput > minInput)
//					{
//						throttleInput = -reverseInput;
//						brakeInput = 0.0f;
//					}
//					else if (forwardInput > minInput)
//					{
//						if (target.speed < -minSpeed)
//						{
//							throttleInput = 0.0f;
//							brakeInput = forwardInput;
//						}
//						else
//						{
//							throttleInput = forwardInput;
//							brakeInput = 0;
//						}
//					}
//				}
//			}
//			else
//			{
//				bool reverse = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);

//				if (!reverse)
//				{
//					throttleInput = forwardInput;
//					brakeInput = reverseInput;
//				}
//				else
//				{
//					throttleInput = -reverseInput;
//					brakeInput = 0;
//				}
//			}

//			// Override throttle if specified

//			if (handbrakeOverridesThrottle)
//			{
//				throttleInput *= 1.0f - handbrakeInput;
//			}

//			// Apply input to vehicle

//			target.steerInput = steerInput;
//			target.throttleInput = throttleInput;
//			target.brakeInput = brakeInput;
//			target.handbrakeInput = handbrakeInput;

//			// Do a vehicle reset

//			if (m_doReset)
//			{
//				target.ResetVehicle();
//				m_doReset = false;
//			}
//		}

//		/* Code from Tim Korving for better handling the continuous forward
//			and reverse mode. To be adapted and tested.

//		void HandleVerticalInputModeInterrupt()                                         // Handle Interrupt input mode for forward reverse
//			{
//			if (m_MoveState == VERTICAL_INPUT_STATE.STATIONARY)
//				{
//				if (m_ForwardInput >= m_MinInput)                                       // If forward input...
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.FORWARD);
//					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
//					m_BrakeInput = 0f;                                                  // Release the brakes
//					}
//				else if (m_ReverseInput >= m_MinInput)                                  // If reverse input...
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.REVERSE);
//					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (eek)
//					m_BrakeInput = 0f;                                                  // Release the brakes
//					}
//				else
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					}
//				}
//			else if (m_MoveState == VERTICAL_INPUT_STATE.FORWARD)
//				{
//				if (m_EVPController.speed >= m_MinSpeed)                                // Currently in forward motion
//					{
//					m_ThrottleInput = m_ForwardInput;                                   // Throttle is forward input
//					m_BrakeInput = m_ReverseInput;                                      // Brake is reverse input
//					}
//				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					m_BrakeInput = 0f;
//					m_ForwardInput = 0f;
//					m_ReverseInput = 0f;
//					}
//				}
//			else if (m_MoveState == VERTICAL_INPUT_STATE.REVERSE)
//				{
//				if (m_EVPController.speed <= -m_MinSpeed)                               // Currently in backward motion
//					{
//					m_ThrottleInput = -m_ReverseInput;                                  // Throttle is inverse reverse input (?)
//					m_BrakeInput = m_ForwardInput;                                      // Brake is forward input
//					}
//				else if (m_ForwardInput < m_MinInput && m_ReverseInput < m_MinInput)
//					{
//					ChangeVerticalInputState(VERTICAL_INPUT_STATE.STATIONARY);
//					m_BrakeInput = 0f;
//					m_ForwardInput = 0f;
//					m_ReverseInput = 0f;
//					}
//				}
//			}
//		*/
//	}
//}