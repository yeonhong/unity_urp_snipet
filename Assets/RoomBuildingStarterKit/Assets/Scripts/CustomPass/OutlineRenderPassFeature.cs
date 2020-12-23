namespace RoomBuildingStarterKit.URP
{
    using RoomBuildingStarterKit.Helpers;
    using System;
    using UnityEngine;
    using UnityEngine.Rendering;
    using UnityEngine.Rendering.Universal;

    /// <summary>
    /// The OutlineRenderPassFeature class used to render outline in universal render pipeline.
    /// </summary>
    public class OutlineRenderPassFeature : ScriptableRendererFeature
    {
        /// <summary>
        /// The outline render pass class.
        /// </summary>
        private class OutlinePass : ScriptableRenderPass
        {
            /// <summary>
            /// The outline settings.
            /// </summary>
            private OutlineSettings settings;

            /// <summary>
            /// The scriptable renderer.
            /// </summary>
            private ScriptableRenderer renderer;

            /// <summary>
            /// The full screen triangle mesh.
            /// </summary>
            private Mesh fullScreenTriangleMesh;

            /// <summary>
            /// The shader tag id.
            /// </summary>
            private ShaderTagId shaderTagId = new ShaderTagId("UniversalForward");

            /// <summary>
            /// The renderer filter settings.
            /// </summary>
            private FilteringSettings filterSettings;

            /// <summary>
            /// The renderer drawing settings.
            /// </summary>
            private DrawingSettings drawingSettings;

            /// <summary>
            /// The renderer state block.
            /// </summary>
            private RenderStateBlock renderStateBlock;

            /// <summary>
            /// The outline shader main texture id.
            /// </summary>
            private int mainTexId = Shader.PropertyToID("_MainTex");

            /// <summary>
            /// The outline shader mask texture id.
            /// </summary>
            private int maskTexId = Shader.PropertyToID("_MaskTex");

            /// <summary>
            /// The temp texture id.
            /// </summary>
            private int tmpTexId = Shader.PropertyToID("_TmpTex");

            /// <summary>
            /// The gauss weights id.
            /// </summary>
            private int gaussWeightId = Shader.PropertyToID("_GaussWeights");

            /// <summary>
            /// The outline material property block.
            /// </summary>
            private MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();

            /// <summary>
            /// Initializes a new instance of the <see cref="OutlinePass"/> class.
            /// </summary>
            /// <param name="settings">The outline settings.</param>
            public OutlinePass(OutlineSettings settings)
            {
                this.settings = settings;

                this.filterSettings = new FilteringSettings(RenderQueueRange.all, this.settings.OutlineLayerMask);
                this.renderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

                this.materialPropertyBlock.SetFloat(Shader.PropertyToID("_OutlineWidth"), this.settings.OutlineWidth);
                this.materialPropertyBlock.SetFloat(Shader.PropertyToID("_OutlineWeight"), this.settings.OutlineWeight);

                this.fullScreenTriangleMesh = new Mesh()
                {
                    name = "Outline-FullScreenTriangle",
                    hideFlags = HideFlags.HideAndDontSave,
                    vertices = new Vector3[] { new Vector3(-1, -1, 0), new Vector3(3, -1, 0), new Vector3(-1, 3, 0) },
                    triangles = new int[] { 0, 1, 2 }
                };

                this.fullScreenTriangleMesh.UploadMeshData(true);
            }

            /// <summary>
            /// Setups the outline pass.
            /// </summary>
            /// <param name="renderer"></param>
            /// <param name="renderingData"></param>
            public void Setup(ScriptableRenderer renderer, ref RenderingData renderingData)
            {
                this.renderer = renderer;

                this.drawingSettings = CreateDrawingSettings(this.shaderTagId, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
                drawingSettings.overrideMaterial = this.settings.RenderMaterial;
            }

            // This method is called before executing the render pass.
            // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
            // When empty this render pass will render to the active camera render target.
            // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
            // The render pipeline will ensure target setup and clearing happens in an performance manner.
            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
            {
                cmd.GetTemporaryRT(this.maskTexId, cameraTextureDescriptor, FilterMode.Bilinear);
                cmd.GetTemporaryRT(this.tmpTexId, cameraTextureDescriptor, FilterMode.Bilinear);
            }

            // Here you can implement the rendering logic.
            // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
            // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
            // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                var cmd = CommandBufferPool.Get("_OutlineRenderPass");

                cmd.SetRenderTarget(maskTexId);
                cmd.ClearRenderTarget(false, true, Color.clear);

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filterSettings, ref renderStateBlock);

                cmd.SetGlobalFloatArray(this.gaussWeightId, GaussSamplesHelper.GetGaussSamples(this.settings.OutlineWidth));

                if (OutlinePostEffect.inst != null)
                {
                    this.settings.OutlineColor.a = OutlinePostEffect.inst.OutlineAlpha;
                }

                this.materialPropertyBlock.SetColor(Shader.PropertyToID("_OutlineColor"), this.settings.OutlineColor);

                cmd.SetRenderTarget(tmpTexId);
                cmd.SetGlobalTexture(mainTexId, maskTexId);
                cmd.DrawMesh(this.fullScreenTriangleMesh, Matrix4x4.identity, this.settings.OutlineMaterial, 0, 0, this.materialPropertyBlock);

                cmd.SetRenderTarget(this.renderer.cameraColorTarget);
                cmd.SetGlobalTexture(mainTexId, tmpTexId);
                cmd.DrawMesh(this.fullScreenTriangleMesh, Matrix4x4.identity, this.settings.OutlineMaterial, 0, 1, this.materialPropertyBlock);

                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }

            /// Cleanup any allocated resources that were created during the execution of this render pass.
            public override void FrameCleanup(CommandBuffer cmd)
            {
                cmd.ReleaseTemporaryRT(this.maskTexId);
                cmd.ReleaseTemporaryRT(this.tmpTexId);
            }
        }

        /// <summary>
        /// The outline settings class.
        /// </summary>
        [Serializable]
        public class OutlineSettings
        {
            /// <summary>
            /// The outline width.
            /// </summary>
            [Range(1, 16)]
            public int OutlineWidth = 10;

            /// <summary>
            /// The outline weight.
            /// </summary>
            [Range(1f, 20f)]
            public float OutlineWeight = 6f;

            /// <summary>
            /// The outline layer mask.
            /// </summary>
            public LayerMask OutlineLayerMask;

            /// <summary>
            /// The outline color.
            /// </summary>
            public Color OutlineColor = Color.white;

            /// <summary>
            /// The render image material.
            /// </summary>
            public Material RenderMaterial;

            /// <summary>
            /// The outline material.
            /// </summary>
            public Material OutlineMaterial;

            /// <summary>
            /// The render pass event.
            /// </summary>
            public RenderPassEvent RenderPassEvent = RenderPassEvent.AfterRenderingSkybox;
        }

        /// <summary>
        /// The outline settings.
        /// </summary>
        public OutlineSettings Settings;

        /// <summary>
        /// The outline render pass.
        /// </summary>
        private OutlinePass outlinePass;

        /// <summary>
        /// Creates outline pass.
        /// </summary>
        public override void Create()
        {
            outlinePass = new OutlinePass(this.Settings);

            // Configures where the render pass should be injected.
            outlinePass.renderPassEvent = RenderPassEvent.AfterRenderingSkybox;
        }

        // Here you can inject one or multiple render passes in the renderer.
        // This method is called when setting up the renderer once per-camera.
        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            outlinePass.Setup(renderer, ref renderingData);
            renderer.EnqueuePass(outlinePass);
        }
    }
}