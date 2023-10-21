using Player;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoInteract : MonoBehaviour
{
	private SphereCollider interactCollider = null;
	internal InteractType type;
	internal Interactable interactable;

	private void Start()
	{
		interactCollider = gameObject.AddComponent<SphereCollider>();

		if (type == InteractType.Door)
		{
			interactCollider.radius = 1;
		}
		else if (type == InteractType.Item)
		{
			interactCollider.radius = 0.5f;
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.transform.root is Transform t && t.CompareTag("Player"))
		{
			interactable.Interact(t.GetComponent<PlayerController>());
		}
	}

	private void OnTriggerExit(Collider other)
	{

	}
}
