namespace RoomBuildingStarterKit.BuildSystem
{
    using RoomBuildingStarterKit.Common;
    using RoomBuildingStarterKit.VisualizeDictionary.Implementations;
    using System.Collections.Generic;
    using UnityEngine;

    /// <summary>
    /// The GlobalFurnitureManager class.
    /// </summary>
    public class GlobalFurnitureManager : Singleton<GlobalFurnitureManager>
    {
        /// <summary>
        /// The furniture opaque material.
        /// </summary>
        public Material FurnitureOpaqueMaterial;

        /// <summary>
        /// The furniture transparent material.
        /// </summary>
        public Material FurnitureTransparentMaterial;

        /// <summary>
        /// The furniture type to prefab mapping.
        /// </summary>
        public FurnitureTypeToPrefabMapping FurnitureTypeToPrefabMapping;

        /// <summary>
        /// Gets the furniture gameObject instance Id to furniture entity dictionary.
        /// </summary>
        public Dictionary<int?, FurnitureEntityBase> FurnitureGoToFurnitureEntityMaps { get; } = new Dictionary<int?, FurnitureEntityBase>();

        /// <summary>
        /// Gets the furniture type to prefab mappings.
        /// </summary>
        public FurnitureTypeEnumGameObjectDict FurnitureTypeToPrefabs
        {
            get => this.FurnitureTypeToPrefabMapping.FurnitureTypeEnumGameObjectDict;
        }
    }
}