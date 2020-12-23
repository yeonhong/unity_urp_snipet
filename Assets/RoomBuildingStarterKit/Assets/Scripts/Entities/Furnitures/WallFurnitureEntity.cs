namespace RoomBuildingStarterKit.BuildSystem
{
    using Newtonsoft.Json;
    using RoomBuildingStarterKit.Common;
    using RoomBuildingStarterKit.Entity;
    using UnityEngine;

    /// <summary>
    /// The WallFurnitureEntity class.
    /// </summary>
    [JsonObject(MemberSerialization.OptIn)]
    public class WallFurnitureEntity : FurnitureEntityBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="WallFurnitureEntity"/> class.
        /// </summary>
        /// <param name="floorEntity">The floor entity.</param>
        /// <param name="direction">The direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="position">The position.</param>
        /// <param name="rotation">The rotation.</param>
        [JsonConstructor]
        public WallFurnitureEntity(FloorEntity floorEntity, short direction, FurnitureType furnitureType, CustomVector3 position, CustomVector3 rotation) : base(furnitureType, floorEntity, position, rotation, direction)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WallFurnitureEntity"/> class.
        /// </summary>
        /// <param name="floorEntity">The floor entity.</param>
        /// <param name="direction">The direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="furniture">The furniture gameObject.</param>
        public WallFurnitureEntity(FloorEntity floorEntity, short direction, FurnitureType furnitureType, GameObject furniture) : base(furnitureType, furniture, direction, floorEntity)
        {
        }
    }
}