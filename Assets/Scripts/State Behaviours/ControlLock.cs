using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Player;

public class ControlLock : StateMachineBehaviour
{
	private bool stateEntered = false;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		//animator.transform.root.GetComponent<PlayerController>().LockControls();
		stateEntered = false;
	}

	//public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	//{
	//	animator.transform.root.GetComponent<PlayerController>().UnlockControls();
	//}

	// OnStateEnter is called when a transition starts and the state machine starts to evaluate this state
	//override public void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	//{
	//    
	//}

	// OnStateUpdate is called on each Update frame between OnStateEnter and OnStateExit callbacks
	override public void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (!stateEntered)
		{
			if (stateInfo.normalizedTime >= 0.5f)
			{
				stateEntered = true;
				OnStateTriggered(animator, stateInfo, layerIndex);
			}
		}
	}

	// OnStateExit is called when a transition ends and the state machine finishes evaluating this state
	//override public void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	//{
	//    
	//}

	// OnStateMove is called right after Animator.OnAnimatorMove()
	//override public void OnStateMove(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	//{
	//    // Implement code that processes and affects root motion
	//}

	// OnStateIK is called right after Animator.OnAnimatorIK()
	//override public void OnStateIK(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	//{
	//    // Implement code that sets up animation IK (inverse kinematics)
	//}

	void OnStateTriggered(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{

	}
}
