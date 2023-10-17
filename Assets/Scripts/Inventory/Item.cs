using Player;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Item", menuName = "Items/Create Player Item", order = 1)]
public class Item : ScriptableObject
{
	#region Inspector Values
	[SerializeField]
    private string _name;
    [SerializeField]
    private string _id;
    [SerializeField]
    private GameObject _gameObject;
    [SerializeField]
    private string[] usageButtons;
	#endregion

	#region Code variables
	public string itemName
    {
        get
        {
            name = _name;
            return _name;
        }
    }
	public string id
	{
		get
		{
			return _id;
		}
	}
    private GameObject instantiatedGameobject = null;
    public GameObject gameObject
    {
        get
        {
            if (instantiatedGameobject)
            {
                return instantiatedGameobject;
            }
            else
            {
                instantiatedGameobject = Instantiate(_gameObject );
				return instantiatedGameobject;
			}
		}
    }
    public bool canUse { get; internal set; }
	#endregion

	// OnAddedToInventory is called when the player adds this item to their inventory
	protected virtual void OnAddedToInventory(Inventory inventory)
	{
        // TODO: Instantiate the gameobject model
	}

	// OnEquip is called when the player equips the item
	protected virtual void OnEquip()
    {
        
    }

	// Update is called once per frame
	protected virtual void Update()
    {
        
    }

    // Use is called when the one of the usage buttons has been triggered
    protected virtual void Use()
    {

    }


    protected virtual void OnUnequip()
    {

    }
}
