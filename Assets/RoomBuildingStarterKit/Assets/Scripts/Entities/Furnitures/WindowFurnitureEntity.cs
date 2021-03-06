﻿namespace RoomBuildingStarterKit.BuildSystem
{
    using Newtonsoft.Json;
    using RoomBuildingStarterKit.Common;
    using RoomBuildingStarterKit.Entity;
    using UnityEngine;

    /// <summary>
    /// The WindowFurnitureEntity class.
    /// </summary>
    public class WindowFurnitureEntity : WallFurnitureEntity
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="WindowFurnitureEntity"/> class.
        /// </summary>
        /// <param name="floorEntity">The floor entity.</param>
        /// <param name="direction">The direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="position">The position.</param>
        /// <param name="rotation">The rotation.</param>
        [JsonConstructor]
        public WindowFurnitureEntity(FloorEntity floorEntity, short direction, FurnitureType furnitureType, CustomVector3 position, CustomVector3 rotation) : base(floorEntity, direction, furnitureType, position, rotation)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WindowFurnitureEntity"/> class.
        /// </summary>
        /// <param name="floorEntity">The floor entity.</param>
        /// <param name="direction">The direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="furniture">The furniture gameObject.</param>
        public WindowFurnitureEntity(FloorEntity floorEntity, short direction, FurnitureType furnitureType, GameObject furniture) : base(floorEntity, direction, furnitureType, furniture)
        {
        }
    }
}