namespace RoomBuildingStarterKit.Common
{
    using RoomBuildingStarterKit.BuildSystem;
    using System;
    using System.Linq;
    using UnityEngine;

    /// <summary>
    /// The WindowValid class is used to make sure the window put in the correct position.
    /// </summary>
    [Serializable]
    [CreateAssetMenu(fileName = "WindowValid", menuName = "CheckList/CheckItems/WindowValid", order = 1)]
    public class WindowValid : BluePrintCheckItemBase
    {
        /// <summary>
        /// Setups ui.
        /// </summary>
        protected override void SetupUI()
        {
            this.uiText = UIText.CHECKLIST_WINDOW_VALID;
        }

        /// <summary>
        /// Prepares before validate.
        /// </summary>
        protected override void Prepare()
        {
            this.officeFloorCollection.Resize(this.BluePrint.FoundationManager.OfficeFloorCollection);
            this.officeFloorCollection.Reset(this.validateOffsetFloorEntities);
        }

        /// <summary>
        /// Validates check item.
        /// </summary>
        /// <returns>The validate result.</returns>
        protected override bool Validate()
        {
            bool result = true;
            this.BluePrint.BluePrintWindowFurnitureEntities.ForEach(w =>
            {
                var offsetFloor = this.officeFloorCollection.GetOfficeFloor(this.pendingTransformAndRotate(w.FloorEntity));
                var isBuildable = (offsetFloor != null &&
                                   offsetFloor.FloorEntity.GetOriginalWallByDir(this.pendingRotateFurniture(w.Direction)) == null &&
                                   this.officeFloorCollection.GetOfficeFloorByDir(offsetFloor, this.pendingRotateFurniture(w.Direction)) == null &&
                                   (offsetFloor.FloorEntity.GetWallByDir(this.pendingRotateFurniture(w.Direction))?.IsWindow ?? false) == false) &&
                                   !offsetFloor.FloorEntity.OccupiedDoorEntities.Any(d => this.pendingRotateFurniture(d.Direction) == (this.pendingRotateFurniture(w.Direction) + 2) % 4);

                w.Furniture.GetComponent<FurnitureController>().SetBuildableState(isBuildable);
                w.CantBuildRealRoom = !isBuildable;
                result &= isBuildable;
            });

            return result;
        }
    }
}