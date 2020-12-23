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
    public class DoorFurnitureEntity : WallFurnitureEntity
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="DoorFurnitureEntity"/> class.
        /// </summary>
        /// <param name="inRoomFloorEntity">The inside room floor entity.</param>
        /// <param name="outRoomFloorEntity">The outside room floor entity.</param>
        /// <param name="direction">The door direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="position">The position.</param>
        /// <param name="rotation">The rotation.</param>
        [JsonConstructor]
        public DoorFurnitureEntity(FloorEntity inRoomFloorEntity, FloorEntity outRoomFloorEntity, short direction, FurnitureType furnitureType, CustomVector3 position, CustomVector3 rotation) : base(inRoomFloorEntity, direction, furnitureType, position, rotation)
        {
            this.InRoomFloorEntity = inRoomFloorEntity;
            this.OutRoomFloorEntity = outRoomFloorEntity;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="DoorFurnitureEntity"/> class.
        /// </summary>
        /// <param name="inRoomfloorEntity">The inside room floor entity.</param>
        /// <param name="outRoomFloorEntity">The outside room floor entity.</param>
        /// <param name="direction">The door direction.</param>
        /// <param name="furnitureType">The furniture type.</param>
        /// <param name="furniture">The furniture gameObject.</param>
        public DoorFurnitureEntity(FloorEntity inRoomFloorEntity, FloorEntity outRoomFloorEntity, short direction, FurnitureType furnitureType, GameObject furniture) : base(inRoomFloorEntity, direction, furnitureType, furniture)
        {
            this.InRoomFloorEntity = inRoomFloorEntity;
            this.OutRoomFloorEntity = outRoomFloorEntity;
        }

        /// <summary>
        /// Gets or sets the inside room floor entity.
        /// </summary>
        [JsonProperty]
        public FloorEntity InRoomFloorEntity { get; set; }

        /// <summary>
        /// Gets or sets the outside room floor entity.
        /// </summary>
        [JsonProperty]
        public FloorEntity OutRoomFloorEntity { get; set; }
    }
}