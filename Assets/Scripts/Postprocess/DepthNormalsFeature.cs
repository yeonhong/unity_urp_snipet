using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// https://alexanderameye.github.io/outlineshader.html

/*
* 외곽선을 그리려면 해당 오브젝트의 색의 불연속성을 검사한다.
* 불연속성을 찾으려면 color, normal, depth의 정보를 사용하면 가능하다.
* 다만, urp 자체적으로는 color, depth 만 따로 알수 있어서
* normal depth 를 같이 갖는 정보를 얻을 수 있도록 depthNormalsFeature를 만듬.
* _CameraDepthTexture에서 깊이, _CameraDepthNormalsTexture에서 노멀, _CameraColorTexture에서 색상을 얻도록 한다
*/
public class DepthNormalsFeature : ScriptableRendererFeature
{
	class DepthNormalsPass : ScriptableRenderPass
	{
		int kDepthBufferBits = 32;
		private RenderTargetHandle depthAttachmentHandle { get; set; }
		internal RenderTextureDescriptor descriptor { get; private set; }

		private Material depthNormalsMaterial = null;
		private FilteringSettings m_FilteringSettings;
		string m_ProfilerTag = "DepthNormals Prepass";
		ShaderTagId m_ShaderTagId = new ShaderTagId("DepthOnly");

		// 생성자.
		public DepthNormalsPass(RenderQueueRange renderQueueRange, LayerMask layerMask, Material material) {
			m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
			depthNormalsMaterial = material;
		}

		// 초기화.
		public void Setup(RenderTextureDescriptor baseDescriptor, RenderTargetHandle depthAttachmentHandle) {
			this.depthAttachmentHandle = depthAttachmentHandle;
			baseDescriptor.colorFormat = RenderTextureFormat.ARGB32;
			baseDescriptor.depthBufferBits = kDepthBufferBits;
			descriptor = baseDescriptor;
		}

		/*
			이 메서드는 렌더 패스를 실행하기 전에 호출됩니다.
			렌더 타겟과 클리어 상태를 구성하는 데 사용할 수 있습니다. 또한 임시 렌더링 대상 텍스처를 만듭니다.
			비어있는 경우이 렌더 패스는 활성 카메라 렌더 타겟으로 렌더링됩니다.
			CommandBuffer.SetRenderTarget을 호출해서는 안됩니다. 대신 <c>ConfigureTarget</c> 과 <c>ConfigureClear</c>를 호출하십시오.
			렌더 파이프 라인은 타겟 설정 및 삭제가 성능 방식으로 발생하도록합니다.

			This method is called before executing the render pass.
			It can be used to configure render targets and their clear state. Also to create temporary render target textures.
			When empty this render pass will render to the active camera render target.
			You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
			The render pipeline will ensure target setup and clearing happens in an performance manner.
		 */
		public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor) {
			cmd.GetTemporaryRT(depthAttachmentHandle.id, descriptor, FilterMode.Point); // RT == render target
			ConfigureTarget(depthAttachmentHandle.Identifier());
			ConfigureClear(ClearFlag.All, Color.black);
		}

		// Here you can implement the rendering logic.
		// 여기서 렌더링 로직을 구현할 수 있습니다.
		// Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
		// ScriptableRenderContext를 사용하여 그리기 명령을 실행하거나 명령 버퍼를 실행합니다.
		// https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
		// You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
		// ScriptableRenderContext.submit을 호출 할 필요가 없습니다. 렌더링 파이프 라인은 파이프 라인의 특정지점에서 이를 호출합니다.
		public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
			CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);

			using (new ProfilingSample(cmd, m_ProfilerTag)) {
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();

				var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
				var drawSettings = CreateDrawingSettings(m_ShaderTagId, ref renderingData, sortFlags);
				drawSettings.perObjectData = PerObjectData.None;

				ref CameraData cameraData = ref renderingData.cameraData;
				Camera camera = cameraData.camera;
				if (cameraData.isStereoEnabled)
					context.StartMultiEye(camera);

				drawSettings.overrideMaterial = depthNormalsMaterial;

				context.DrawRenderers(renderingData.cullResults, ref drawSettings,
					ref m_FilteringSettings);

				cmd.SetGlobalTexture("_CameraDepthNormalsTexture", depthAttachmentHandle.id);
			}

			context.ExecuteCommandBuffer(cmd);
			CommandBufferPool.Release(cmd);
		}

		// Cleanup any allocated resources that were created during the execution of this render pass.
		// 이 렌더 패스를 실행하는 동안 생성 된 할당 된 리소스를 정리합니다.
		public override void FrameCleanup(CommandBuffer cmd) {
			if (depthAttachmentHandle != RenderTargetHandle.CameraTarget) {
				cmd.ReleaseTemporaryRT(depthAttachmentHandle.id);
				depthAttachmentHandle = RenderTargetHandle.CameraTarget;
			}
		}
	}

	DepthNormalsPass depthNormalsPass;
	RenderTargetHandle depthNormalsTexture;
	Material depthNormalsMaterial;

	// render feature 생성 및 준비.
	public override void Create() {
		// 빌드인 쉐이더에 뎁스노멀 텍스쳐가 있음.. 이 마테리얼 로직으로 생성.
		depthNormalsMaterial = CoreUtils.CreateEngineMaterial("Hidden/Internal-DepthNormalsTexture");
		depthNormalsPass = new DepthNormalsPass(RenderQueueRange.opaque, -1, depthNormalsMaterial);
		depthNormalsPass.renderPassEvent = RenderPassEvent.AfterRenderingPrePasses;
		depthNormalsTexture.Init("_CameraDepthNormalsTexture");
	}

	// 여기서 렌더러에 하나 또는 여러 개의 렌더 패스를 삽입 할 수 있습니다.
	// 이 메서드는 카메라 당 한 번 렌더러를 설정할 때 호출됩니다.
	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
		depthNormalsPass.Setup(renderingData.cameraData.cameraTargetDescriptor, depthNormalsTexture);
		renderer.EnqueuePass(depthNormalsPass);
	}
}

