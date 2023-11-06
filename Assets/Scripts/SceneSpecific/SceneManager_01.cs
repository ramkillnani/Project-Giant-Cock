using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EasyRoads3Dv3;

public class SceneManager_01 : MonoBehaviour
{
    // Step 1: Make car follow checkpoints

    [SerializeField]
    private ERModularBase roadObject;

    [SerializeField] // These will be the ezyroads points
    private Transform[] checkpoints;


	private void Start()
	{
		//checkpoints = new Transform[roadObject.sub];

		//for (int i = 0; i < checkpoints.Length; i++)
		//{
		//	checkpoints[i] = roadObject.connectionObjects[i].transform;
		//}
	}
}
