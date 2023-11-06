using System.Collections;
using System.Collections.Generic;
using UnityEditor.ShaderGraph.Internal;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// TODO (performance): Create a raycast class which we can retrieve values from,
// so we only need to have a single raycast (if the ray's are the
// same such as just checking for objects in front of the player)
// to get data from.

// TODO: Create script that adds a mesh collider using the mesh on the object and assigns its own physics layer to it. This will be used to change the 

public class ImmersionSystem : MonoBehaviour
{
	[SerializeField]
	private Volume volume;
	[SerializeField]
	private VolumeParameter<float> dofParameter;

	[SerializeField]
	private float depthOffset = 0f;
	[SerializeField]
	private float depthDivider = 2f;

	[SerializeField]
	private float timeUntilFocusChange = 0.25f;
	[SerializeField]
	private float smoothing = 7.5f;
	[SerializeField]
	private float minDepth = 5f;
	[SerializeField]
	private float maxDepth = 50f;

	private float curDepth = 0f;
	private float curTimeLookingAtObject = 0f;
	private Transform lastTransformLookAt = null;
	private DepthOfField dof;


	private void Awake()
	{
		volume.profile.TryGet(out dof);
	}

	// Update is called once per frame
	void FixedUpdate()
	{
		DepthOfFieldAdjustments();
	}

	// This applies depth of field camera values for an immersive DOF experience (test)
	void DepthOfFieldAdjustments()
	{
		RaycastHit hit;
		// Does the ray intersect any objects excluding the player layer
		if (Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 100))
		{
			//Debug.Log("Depth: " + hit.distance);
			curTimeLookingAtObject += Time.deltaTime;

			if (lastTransformLookAt == hit.transform)
			{
				if (curTimeLookingAtObject > timeUntilFocusChange)
				{
					Debug.Log("Depth is changing");
					// Focus object
					curDepth = Mathf.Lerp(curDepth, hit.distance, smoothing * Time.fixedDeltaTime);
				}
				else
				{
					// Do nothing

				}
			}
			else
			{
				// Reset timer
				curTimeLookingAtObject = 0;
			}
		}
		else
		{
			curTimeLookingAtObject = 0;
			curDepth = maxDepth;
		}

		// Apply min/max distance
		if (curDepth < minDepth)
		{
			curDepth = minDepth;
		}
		else if (curDepth > maxDepth)
		{
			curDepth = maxDepth;
		}

		lastTransformLookAt = hit.transform;

		//dof.focusDistance.overrideState = true;

		float endValue = (curDepth / depthDivider) + depthOffset;
		Debug.Log("Focus distance: " + endValue);

		// Apply values to dof
		dofParameter.value = endValue;
		dof.focusDistance.SetValue(dofParameter);
	}
}
