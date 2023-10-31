using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Items;

public class Lantern : Item
{
    [Header("Lantern"), SerializeField]
    private bool lightOn = false;
    [SerializeField]
    private MeshRenderer meshRenderer;
    [SerializeField]
    private Material onMaterial;
    [SerializeField]
    private Material offMaterial;

	protected override void OnAddToInventory()
	{
        Debug.Log($"Successfully added {ItemName} to inventory!");
	}

	protected override void OnUse(int i)
    {
		Debug.Log($"OnUse({i}) has been triggered on " + ItemName);

		if (i == 0)
        {
			TriggerLight();
        }
    }

    void TriggerLight()
    {
        if (lightOn)
        {
            lightOn = false;
        }
        else
        {
			lightOn = true;
		}

		if (lightOn)
        {
            meshRenderer.material = onMaterial;
        }
        else
        {
			meshRenderer.material = offMaterial;
		}
	}
}
