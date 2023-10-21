using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;
using Player;
using EVP;
using Items;

public class Interactable : MonoBehaviour
{
	public InteractType type;

	[SerializeField, Tooltip("Useful for picking up items")]
	private bool autoInteract = false;

	[SerializeField]
	private float interactDisableTime = 1;
	private bool canInteract = true;
	private void Start()
	{
		if (autoInteract)
		{
			if (GetComponentInChildren<AutoInteract>() == null)
			{
				GameObject autoInteractGO = Instantiate(new GameObject(), transform);
				autoInteractGO.name = "AutoInteractObject";
				AutoInteract ai = autoInteractGO.AddComponent<AutoInteract>();

				ai.type = type;
				ai.interactable = this;
			}
			else
			{
				var ai = GetComponentInChildren<AutoInteract>();
				ai.interactable = this;
				ai.type = type;
			}
		}
		else
		{
			var ai = GetComponentInChildren<AutoInteract>();
			if (ai != null)
			{
				Destroy(ai);
			}
		}
	}

	public void Interact(PlayerController controller)
	{
		Debug.Log("Player has interacted with an object");

		string dbg = $"Failed to interact with {gameObject.name}. ";
		if (type == InteractType.Vehicle)
		{
			var inp = GetComponent<VehicleStandardInput>();
			var cont = GetComponent<VehicleController>();

			if (cont == null)
			{
				cont = GetComponentInParent<VehicleController>();
			}
			if (inp == null)
			{
				inp = GetComponentInParent<VehicleStandardInput>();
			}

			if (inp != null && cont != null)
			{
				VehicleInteraction(controller, inp, cont);
			}
			else
			{
				Debug.LogWarning(dbg + "Please check if \"VehicleStandardInput.cs\" is attached.");
			}
		}
		else if (type == InteractType.Item)
		{
			var itm = GetComponent<Item>();
			if (itm != null)
			{
				ItemInteraction(controller, itm);
			}
			else
			{
				Debug.LogWarning(dbg + "Please check if \"Item.cs\" is attached.");
			}
		}
		else if (type == InteractType.Door)
		{
			var inp = GetComponent<Door>();
			if (inp != null)
			{
				DoorInteraction(controller, inp);
			}
			else
			{
				Debug.LogWarning(dbg + "Please check if \"Door.cs\" is attached.");
			}
		}
	}

	void VehicleInteraction(PlayerController controller, VehicleStandardInput vehicleInput, VehicleController vehicleController)
	{
		controller.OnVehicleInteraction(vehicleInput, vehicleController);
	}

	void ItemInteraction(PlayerController controller, Item item)
	{
		controller.OnItemInteraction(item);
	}

	void DoorInteraction(PlayerController controller, Door door)
	{
		controller.OnDoorInteraction(door);
	}
}

public enum InteractType { Vehicle, Item, Door }
