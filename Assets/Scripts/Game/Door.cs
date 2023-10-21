using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Player;

public class Door : MonoBehaviour
{
    private bool opened = false;

    [SerializeField]
    private Transform pivot;
    [SerializeField]
    private AnimationCurve openCloseSpeed = new AnimationCurve(new Keyframe(0, 0, 0, 0), new Keyframe(1, 1, 0, 0));

	public void Interact(PlayerController controller)
    {
        if (opened)
        {
            Close();
        }
        else
        {
            Open(controller);
        }
    }

	void Open(PlayerController controller)
	{
		Vector3 playerToDoor = transform.position - controller.transform.position;
		float rotationDirection = Vector3.Dot(transform.forward, playerToDoor) > 0 ? 1f : -1f;
		float rotationAmount = 90f * rotationDirection; // Assuming 90 degrees rotation
		StartCoroutine(RotateDoor(rotationAmount));
	}

	void Close()
	{
		float rotationDirection = opened ? 1f : -1f;
		float rotationAmount = 90f * rotationDirection; // Assuming 90 degrees rotation
		StartCoroutine(RotateDoor(-rotationAmount));
	}

	IEnumerator RotateDoor(float rotationAmount)
	{
		float elapsedTime = 0f;
		float duration = 1f; // Adjust as needed
		Quaternion startRotation = transform.rotation;
		Quaternion targetRotation = Quaternion.Euler(transform.eulerAngles + new Vector3(0, rotationAmount, 0));

		while (elapsedTime < duration)
		{
			elapsedTime += Time.deltaTime;
			float t = openCloseSpeed.Evaluate(elapsedTime / duration);
			transform.rotation = Quaternion.Slerp(startRotation, targetRotation, t);
			yield return null;
		}

		transform.rotation = targetRotation;
		opened = !opened;
	}
}
