using Player;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Items
{
	public class Item : MonoBehaviour
	{
		#region Inspector Values
		[Header("Inventory Data")]
		[SerializeField]
		private int _id;
		[SerializeField]
		private Sprite _icon;

		[Header("Visability"), Tooltip("This is the gameobject that will be enabled when the item is dropped and not held by a player." +
			" This GameObject should be a child of this GameObject.")]
		public GameObject droppedGameobject;
		[Tooltip("This is the gameobject that will be enabled and shown in first person view when the item is held by a player." +
			" This GameObject should be a child of this GameObject.")]
		public GameObject firstPersonGameObject;
		[Tooltip("This is the gameobject that will be enabled and shown in first person view when the item is held by a player." +
			" This GameObject should be a child of this GameObject.")]
		public GameObject thirdPersonGameObject;

		[SerializeField]
		private bool droppedRotationPhysics = false;

		[Header("Other"), SerializeField]
		private ItemSound _sound = new ItemSound();
		public Controls controls = new Controls();

		private Rigidbody droppedRigidbody;
		private BoxCollider droppedCollider;

		[Serializable]
		public class Controls
		{
			[SerializeField, Tooltip("Each usage button created will automatically link the actions to each Use method (usageButtons[0] - Use(0), usageButtons[1] - Use(1), ect...).")]
			internal InputAction[] usageButtons;
		}
		#endregion

		#region Code Parameters
		public ItemSound Sound
		{
			get
			{
				return _sound;
			}
		}

		public string ItemName
		{
			get
			{
				return name;
			}
		}
		public int Id
		{
			get
			{
				return _id;
			}
		}

		#endregion

		private protected PlayerController controller;

		void BindButtons(bool add)
		{
			if (controls.usageButtons != null && controls.usageButtons.Length != 0)
			{
				for (int i = 0; i < controls.usageButtons.Length; i++)
				{
					if (add)
					{
						controls.usageButtons[i].performed += ctx => Use(i - 1);
						controls.usageButtons[i].Enable();
					}
					else
					{
						controls.usageButtons[i].performed -= ctx => Use(i - 1);
						controls.usageButtons[i].Disable();
						controls.usageButtons[i].Dispose();
					}
				}
			}
			else
			{
				Debug.LogWarning("No usage input bindings have been set for the " + ItemName + " item. If that is the behaviour you want, ignore this message nerd.");
			}
		}

		private void OnEnable()
		{
			for (int i = 0; i < controls.usageButtons.Length; i++)
			{
				if (controller == null)
				{
					BindButtons(false);
				}
				else
				{
					BindButtons(true);
				}
			}
		}

		private void OnDisable()
		{
			for (int i = 0; i < controls.usageButtons.Length; i++)
			{
				BindButtons(false);
			}
		}

		#region Call from player script
		public void AddToInventory(PlayerController controller)
		{
			this.controller = controller;
			if (Sound.OnAddToInventory.clips != null && Sound.OnAddToInventory.clips.Length > 0)
			{
				PlaySound(Sound.OnAddToInventory);
			}

			// TODO: Disable colliders and remove rigidbody

			// TODO: Attach to player hand

			// Disable Physics
			EnablePhysics(false);

			// TODO: Remove this when Equip functionality is finished
			BindButtons(true);

			OnAddToInventory();
		}

		public void RemoveFromInventory()
		{
			for (int i = 0; i < controls.usageButtons.Length; i++)
			{
				controls.usageButtons[i].Dispose();
			}

			if (Sound.OnAddToInventory.clips != null && Sound.OnAddToInventory.clips.Length > 0)
			{
				PlaySound(Sound.OnAddToInventory);
			}

			// TODO: Enable colliders and add rigidbody with correct data (so save rigidbody properties as variables)

			// TODO: Remove this when Equip functionality is finished
			BindButtons(false);

			OnRemoveFromInventory();

			controller = null;

			// Enable Physics
			EnablePhysics(true);
		}

		public void Equip()
		{
			PlaySound(Sound.OnEquip);

			BindButtons(true);

			OnEquip();
		}

		public void Unequip()
		{
			PlaySound(Sound.OnUnequip);

			OnUnequip();

			BindButtons(false);
		}

		// Run logic that will run on all items here so we don't need to use "base" at the start of every method
		public void Use(int i)
		{
			if (i < Sound.OnUse.Length)
			{
				PlaySound(Sound.OnUse[i]);
			}

			// TODO: Encapsulated this with - If animation is not playing
			OnUse(i);
		}

		void CheckPhysics()
		{
			if (droppedRigidbody == null)
			{
				if (gameObject.GetComponent<Rigidbody>() != null)
				{
					droppedRigidbody = gameObject.GetComponent<Rigidbody>();
				}
				else
				{
					droppedRigidbody = gameObject.AddComponent<Rigidbody>();
				}
			}

			if (droppedCollider == null)
			{
				if (gameObject.GetComponent<BoxCollider>() != null)
				{
					droppedCollider = gameObject.GetComponent<BoxCollider>();
				}
				else
				{
					droppedCollider = gameObject.AddComponent<BoxCollider>();
					droppedCollider.size = new Vector3(0.25f, 0.25f, 0.25f);
				}
			}
		}

		void EnablePhysics(bool start)
		{
			if (start)
			{
				CheckPhysics();

				if (droppedRotationPhysics)
				{
					droppedRigidbody.freezeRotation = true;
				}

				droppedRigidbody.isKinematic = false;
				droppedCollider.enabled = true;
				
				// TODO: Force rigidbody to sleep until item is dropped
			}
			else
			{
				CheckPhysics();

				droppedRigidbody.isKinematic = true;
				droppedCollider.enabled = false;
			}
		}
		#endregion

		/// <summary>
		/// OnAddToInventory is called when this item is added to the player's inventory.
		/// </summary>
		protected virtual void OnAddToInventory()
		{

		}

		// Could make an interface for these???
		/// <summary>
		/// OnRemovedFromInventory is called when this item is removed from the player's inventory.
		/// </summary>
		protected virtual void OnRemoveFromInventory()
		{

		}

		/// <summary>
		/// OnEquip is called when the player has equipped the item.
		/// </summary>
		protected virtual void OnEquip()
		{

		}

		/// <summary>
		/// OnUse is called when one of the use buttons has been used.
		/// </summary>
		/// <param name="i"></param>
		protected virtual void OnUse(int buttonIndex)
		{
			
		}

		// OnEquip is called when the player unequips the item
		protected virtual void OnUnequip()
		{
			PlaySound(Sound.OnUnequip);
		}

		void DetermineAndPlayAudio(SoundCollection audio)
		{
			if (audio.audioPlayType == AudioPlayType.InOrder)
			{
				// TODO: Play audio here

				if (audio.iteration < audio.clips.Length - 1)
				{
					audio.iteration++;
				}
				else
				{
					audio.iteration = 0;
				}
			}
			else
			{
				int randomSelection = UnityEngine.Random.Range(0, audio.clips.Length);

				// TODO: Play random audio here
			}
		}

		private void PlaySound(SoundCollection audio)
		{
			if (audio == null)
			{
				Debug.LogWarning($"{ItemName} item Sound collection is null.");
			}
			else
			{
				for (int i = 0; i < Sound.OnUse.Length; i++)
				{
					if (audio == Sound.OnUse[i])
					{
						DetermineAndPlayAudio(audio);
						return;
					}
				}

				if (audio == Sound.OnEquip)
				{
					DetermineAndPlayAudio(audio);
				}
				else if (audio == Sound.OnUnequip)
				{
					DetermineAndPlayAudio(audio);
				}
				else if (audio == Sound.OnAddToInventory)
				{
					DetermineAndPlayAudio(audio);
				}
			}
		}
	}

	[Serializable]
	public class ItemSound
	{
		[SerializeField]
		internal SoundCollection OnAddToInventory = new SoundCollection();
		[SerializeField]
		internal SoundCollection OnRemoveFromInventory = new SoundCollection();

		[SerializeField]
		internal SoundCollection OnEquip = new SoundCollection();
		[SerializeField]
		internal SoundCollection OnUnequip = new SoundCollection();

		[SerializeField]
		internal SoundCollection[] OnUse = new SoundCollection[10];
	}

	[Serializable]
	internal class SoundCollection
	{
		[SerializeField]
		internal AudioPlayType audioPlayType;
		[SerializeField]
		internal AudioClip[] clips;
		internal int iteration;
	}

	/// <summary>
	/// Random: Selects a random Sound from the array and plays it.
	/// InOrder: Plays each Sound in order from the array.
	/// </summary>
	internal enum AudioPlayType { Random, InOrder }
}