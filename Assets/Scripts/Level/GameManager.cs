using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EVP;
using Player;

public class GameManager : Singleton<GameManager>
{
	[SerializeField]
	private VehicleManager vehicle;
	[SerializeField]
	private PlayerController player;
	[Space]
	[SerializeField]
	private float carStartvelocity = 75;
	private bool yeahnah = false;
	private bool done = false;
	
	private void Update()
	{
		if (yeahnah)
		{
			if (!done)
			{
				ApplyPlayerToVehicle();
			}
		}
		else
		{
			yeahnah = true;
		}
	}

	public void ApplyPlayerToVehicle()
	{
		done = true;
		vehicle.vehicleController.cachedRigidbody.velocity = new Vector3(0, 0, carStartvelocity);
		player.OnVehicleEnter(vehicle);
	}
}
