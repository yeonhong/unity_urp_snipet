using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// https://alexanderameye.github.io/outlineshader.html
/*
 * 특별히 아웃라인을 위한 코드라기보다 설정된 material의 로직으로 blit해주는 코드.
 */
public class OutlineFeature : ScriptableRendererFeature
{
	private class OutlinePass : ScriptableRenderPass
	{
		private const string CommandBufferName = "_OutlinePass";
		private RenderTargetIdentifier source { get; set; }
		private RenderTargetHandle destination { get; set; }
		public Material outlineMaterial = null;
		private RenderTargetHandle temporaryColorTexture;

		public void Setup(RenderTargetIdentifier source, RenderTargetHandle destination) {
			this.source = source;
			this.destination = destination;
		}

		public OutlinePass(Material outlineMaterial) {
			this.outlineMaterial = outlineMaterial;
		}

		public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor) {
		}

		public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
			CommandBuffer cmd = CommandBufferPool.Get(CommandBufferName);

			RenderTextureDescriptor opaqueDescriptor = renderingData.cameraData.cameraTargetDescriptor;
			opaqueDescriptor.depthBufferBits = 0;

			cmd.GetTemporaryRT(temporaryColorTexture.id, opaqueDescriptor, FilterMode.Point);
			Blit(cmd, source, temporaryColorTexture.Identifier(), outlineMaterial, 0);
			Blit(cmd, temporaryColorTexture.Identifier(), source);

			context.ExecuteCommandBuffer(cmd);
			CommandBufferPool.Release(cmd);
		}

		public override void FrameCleanup(CommandBuffer cmd) {
			cmd.ReleaseTemporaryRT(temporaryColorTexture.id);
		}
	}

	[System.Serializable]
	public class OutlineSettings
	{
		public Material outlineMaterial = null;
	}

	public OutlineSettings settings = new OutlineSettings();
	private OutlinePass outlinePass;

	public override void Create() {
		outlinePass = new OutlinePass(settings.outlineMaterial);
		outlinePass.renderPassEvent = RenderPassEvent.AfterRenderingTransparents; // pass event.
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
		if (settings.outlineMaterial == null) {
			Debug.LogWarningFormat("Missing Outline Material");
			return;
		}
		outlinePass.Setup(renderer.cameraColorTarget, RenderTargetHandle.CameraTarget);
		renderer.EnqueuePass(outlinePass);
	}
}

