using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EVP;
using Player;
using System;

public class VehicleManager : MonoBehaviour
{
	[HideInInspector]
	public VehicleController vehicleController;
	[HideInInspector]
	public VehicleStandardInput input;

	public VehicleSeat[] vehicleSeats;

	public VehicleSeat GetSeatFromPlayer(PlayerController controller)
	{
		for (int i = 0; i < vehicleSeats.Length; i++)
		{
			if (vehicleSeats[i].seatedPlayer == controller)
			{
				return vehicleSeats[i];
			}
		}

		return null;
	}

	public float GetSpeed
	{
		get
		{
			return vehicleController.speed;
		}
	}

	/// <summary>
	/// Check if the vehicle seat capacity is full.
	/// </summary>
	public bool VehicleFull
	{
		get
		{
			if (vehicleSeats != null && vehicleSeats.Length > 0)
			{
				for (int i = 0; i < vehicleSeats.Length; i++)
				{
					if (vehicleSeats[i].seatedPlayer == null)
					{
						return false;
					}
				}

				return true;
			}
			else
			{
				return true;
			}
		}
	}

	public VehicleSeat GetDriverSeat
	{
		get
		{
			if (vehicleSeats != null && vehicleSeats.Length > 0)
			{
				for (int i = 0; i < vehicleSeats.Length; i++)
				{
					if (vehicleSeats[i].isDriver)
					{
						if (vehicleSeats[i].seatedPlayer == null)
						{
							return vehicleSeats[i];
						}
					}
				}

				return null;
			}
			else
			{
				return null;
			}
		}
	}

	private void Awake()
	{
		vehicleController = GetComponent<VehicleController>();
		input = GetComponent<VehicleStandardInput>();
	}
}

[Serializable]
public class VehicleSeat
{
	// Sides to play seperate open animations
	public enum Side { Left, Right }
	public Side doorSide = Side.Left;

	public bool isDriver = false;

	public Transform door;
	public Transform doorHandle;
	[Tooltip("The position the player will walk to, to be able to open the vehicle's door.")]
	public Transform movePosition;
	public Transform playerParent;

	[HideInInspector]
	public PlayerController seatedPlayer = null;
}
