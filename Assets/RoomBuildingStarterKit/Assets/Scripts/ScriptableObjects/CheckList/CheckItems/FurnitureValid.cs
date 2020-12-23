namespace RoomBuildingStarterKit.Common
{
    using RoomBuildingStarterKit.BuildSystem;
    using System;
    using System.Linq;
    using UnityEngine;

    /// <summary>
    /// The FurnitureValid class is used to make sure furnitures put in the correct position.
    /// </summary>
    [Serializable]
    [CreateAssetMenu(fileName = "FurnitureValid", menuName = "CheckList/CheckItems/FurnitureValid", order = 1)]
    public class FurnitureValid : BluePrintCheckItemBase
    {
        /// <summary>
        /// Setups ui.
        /// </summary>
        protected override void SetupUI()
        {
            this.uiText = UIText.CHECKLIST_FURNITURE_VALID;
        }

        /// <summary>
        /// Prepares the check item before validate.
        /// </summary>
        protected override void Prepare()
        {
            this.officeFloorCollection.Resize(this.BluePrint.FoundationManager.OfficeFloorCollection);
            this.officeFloorCollection.Reset(this.validateOffsetFloorEntities);
        }

        /// <summary>
        /// Validates the check item.
        /// </summary>
        /// <returns>The validate result.</returns>
        protected override bool Validate()
        {
            bool result = true;
            this.BluePrint.BluePrintFurnitureEntities.ForEach(f =>
            {
                var isBuildable = f.FloorEntities.All(ff => this.officeFloorCollection.GetOfficeFloor(this.pendingTransformAndRotate(ff)) != null && !ff.OccupiedDoorEntities.Any());
                f.Furniture.GetComponent<FurnitureController>().SetBuildableState(isBuildable);
                f.CantBuildRealRoom = !isBuildable;
                result &= isBuildable;
            });

            return result;
        }
    }
}