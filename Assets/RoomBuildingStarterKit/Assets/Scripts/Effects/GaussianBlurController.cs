namespace RoomBuildingStarterKit.Effect
{
    using RoomBuildingStarterKit.Common;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    /// <summary>
    /// The GaussianBlur post processing effect controller.
    /// </summary>
    public class GaussianBlurController : Singleton<GaussianBlurController>
    {
        /// <summary>
        /// The is bluring or not.
        /// </summary>
        [HideInInspector]
        public bool IsBluring = false;

        /// <summary>
        /// The blur value.
        /// </summary>
        [HideInInspector]
        public float Blur = 2.3f;

        /// <summary>
        /// The post processing effect volume
        /// </summary>
        private Volume volume;

        /// <summary>
        /// The depth of field.
        /// </summary>
        private DepthOfField depthOfField;

        /// <summary>
        /// The animator.
        /// </summary>
        public Animator Animator { get; set; }

        /// <summary>
        /// Executes when instantiates gameObject.
        /// </summary>
        protected override void AwakeInternal()
        {
            this.Animator = this.GetComponent<Animator>();

            this.volume = this.GetComponent<Volume>();
            this.volume.profile.TryGet(out this.depthOfField);
        }

        /// <summary>
        /// Executes each frame.
        /// </summary>
        private void Update()
        {
            if (this.IsBluring)
            {
                this.depthOfField.focusDistance.value = this.Blur;
            }
        }
    }
}