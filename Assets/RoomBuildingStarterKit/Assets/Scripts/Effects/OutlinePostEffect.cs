namespace RoomBuildingStarterKit
{
    using UnityEngine;
    using RoomBuildingStarterKit.Common.Extensions;
    using RoomBuildingStarterKit.Components;
    using RoomBuildingStarterKit.Common;

    /// <summary>
    /// The outline post effect class used to outline gameObject when mouse hovered on it.
    /// </summary>
    public class OutlinePostEffect : Singleton<OutlinePostEffect>
    {     
        /// <summary>
        /// The outline alpha.
        /// </summary>
        [HideInInspector]
        public float OutlineAlpha = 0f;

        /// <summary>
        /// The alpha change smooth time.
        /// </summary>
        public float AlphaSmoothTime = 0.05f;

        /// <summary>
        /// The alpha smooth change velocity.
        /// </summary>
        private float alphaSmoothChangeVelocity;

        /// <summary>
        /// The selectable object.
        /// </summary>
        private GameObject selectableObject;

        /// <summary>
        /// Changes gameObject hierarchy's layer by name.
        /// </summary>
        /// <param name="obj">The gameObject.</param>
        /// <param name="srcLayerName">The source layer name.</param>
        /// <param name="dstLayerName">The target layer name.</param>
        public void ChangeContinuousHierarchyLayerByName(GameObject obj, string srcLayerName, string dstLayerName)
        {
            if (obj.layer == LayerMask.NameToLayer(srcLayerName))
            {
                obj.layer = LayerMask.NameToLayer(dstLayerName);
                var curTransform = obj.transform;
                int count = curTransform.childCount;
                for (int i = 0; i < count; ++i)
                {
                    var child = curTransform.GetChild(i).gameObject;
                    this.ChangeContinuousHierarchyLayerByName(child, srcLayerName, dstLayerName);
                }
            }
        }

        /// <summary>
        /// Shows the outline.
        /// </summary>
        /// <param name="obj">The gameObject.</param>
        public void ShowOutline(GameObject obj)
        {
            if (InputWrapper.IsBlocking == false)
            {
                this.ChangeContinuousHierarchyLayerByName(obj, "Selectable", "Outline");
                this.OutlineAlpha = 0f;
            }
        }

        /// <summary>
        /// Hides the outline.
        /// </summary>
        /// <param name="obj">The gameObject.</param>
        public void HideOutline(GameObject obj)
        {
            this.ChangeContinuousHierarchyLayerByName(obj, "Outline", "Selectable");
            this.OutlineAlpha = 0f;
        }

        /// <summary>
        /// Updates outline post effect.
        /// </summary>
        private void UpdateOutlineEffect()
        {
            var obj = OfficeMouseEventListener.GetMouseHoveredObjectByLayer(LayerMask.GetMask("Selectable") | LayerMask.GetMask("Outline"));
            if (obj != null && UIMouseEventDetector.CheckMouseEventOnUI() == false)
            {
                var rootObject = obj.GetSameLayerRootObject();
                if (this.selectableObject == null)
                {
                    this.ShowOutline(rootObject);
                }
                else if (this.selectableObject != rootObject)
                {
                    this.HideOutline(this.selectableObject);
                    this.ShowOutline(rootObject);
                }

                this.selectableObject = rootObject;
            }
            else if (this.selectableObject != null)
            {
                this.HideOutline(this.selectableObject);
                this.selectableObject = null;
            }
        }

        /// <summary>
        /// Executes every frame.
        /// </summary>
        private void Update()
        {
            this.UpdateOutlineEffect();
            this.OutlineAlpha = Mathf.SmoothDamp(this.OutlineAlpha, 1.0f, ref this.alphaSmoothChangeVelocity, this.AlphaSmoothTime, float.MaxValue, Time.unscaledDeltaTime);
        }
    }
}