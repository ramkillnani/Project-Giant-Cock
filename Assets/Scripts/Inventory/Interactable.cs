using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;
using Player;
using EVP;
using Items;
using System.Web.Mvc;

public class Interactable : MonoBehaviour
{
	public InteractType type;

	[SerializeField, Tooltip("Useful for picking up items")]
	private bool autoInteract = false;

	//private float interactDisableTime = 1;
	//private bool canInteract = true;

	[HideInInspector]
	public VehicleManager connectedVm = null;
	[HideInInspector]
	public Door connectedDoor = null;
	[HideInInspector]
	public Item connectedItem = null;

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

		string dbg = $"Failed to interact with {gameObject.name}. ";

		if (type == InteractType.Vehicle)
		{
			connectedVm = GetComponent<VehicleManager>();

			if (connectedVm == null)
			{
				Debug.LogWarning(dbg + "Please check if \"VehicleStandardInput.cs\" is attached.");
			}
		}
		else if (type == InteractType.Item)
		{
			connectedItem = GetComponent<Item>();

			if (connectedItem == null)
			{
				Debug.LogWarning(dbg + "Please check if \"Item.cs\" is attached.");
			}
		}
		else if (type == InteractType.Door)
		{
			connectedDoor = GetComponent<Door>();

			if (connectedDoor == null)
			{
				Debug.LogWarning(dbg + "Please check if \"Door.cs\" is attached.");
			}
		}
	}

	public void Interact(PlayerController controller)
	{
		Debug.Log("Player has interacted with an object");

		string dbg = $"Failed to interact with {gameObject.name}. ";
		if (type == InteractType.Vehicle)
		{
			var inp = connectedVm;

			if (inp != null && inp.GetSpeed < 30 && inp.GetSpeed > -30)
			{
				VehicleInteraction(controller, inp);
			}
			else
			{
				Debug.LogWarning(dbg + "Please check if \"VehicleStandardInput.cs\" is attached.");
			}
		}
		else if (type == InteractType.Item)
		{
			var itm = connectedItem;

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
			var inp = connectedDoor;
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

	void VehicleInteraction(PlayerController controller, VehicleManager vehicleManager)
	{
		controller.OnVehicleInteraction(vehicleManager);
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
