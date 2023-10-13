using UnityEngine;
using Player;

[CreateAssetMenu(menuName = "Data/Create Player Model Database", fileName = "PlayerModelDatabase", order = 0)]
public class PlayerModels : ScriptableObject
{
    [SerializeField]
    internal PlayerKey[] playerModels;
}
