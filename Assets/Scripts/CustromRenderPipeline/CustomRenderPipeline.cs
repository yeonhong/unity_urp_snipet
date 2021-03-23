using UnityEngine;
using UnityEngine.Rendering;

public class CustomRenderPipeline : RenderPipeline
{
    public CustomRenderPipeline(CustomRenderPipelineAsset asset)
    {

    }

    protected override void Render(ScriptableRenderContext context, Camera[] cameras)
    {
        for (int i = 0; i < cameras.Length; i++)
        {
            var camera = cameras[i];

            // 컬링 처리.
            camera.TryGetCullingParameters(false, out var cullingParams);
            var cullingResults = context.Cull(ref cullingParams);

            // 카메라 속성 설정
            context.SetupCameraProperties(camera);

            // 화면 
            var cmd = new CommandBuffer();
            cmd.ClearRenderTarget(true, true, Color.red);
            context.ExecuteCommandBuffer(cmd);
            cmd.Release();

            // 라이트 방향 설정
            VisibleLight light = cullingResults.visibleLights[0];
            Vector3 lightDir = -light.localToWorldMatrix.GetColumn(2);

            cmd = new CommandBuffer();
            cmd.SetGlobalVector("_LightDir", new Vector4(lightDir.x, lightDir.y, lightDir.z, 0.0f));
            context.ExecuteCommandBuffer(cmd);
            cmd.Release();

            // 그릴 대상 설정
            var sortSettings = new SortingSettings(camera) { criteria = SortingCriteria.CommonOpaque, };
            var drawSettings = new DrawingSettings(new ShaderTagId("ForwardBase"), sortSettings);
            var filteringSettings = new FilteringSettings(RenderQueueRange.opaque);

            // 화면에 보이는 객체들 그리기
            context.DrawRenderers(cullingResults, ref drawSettings, ref filteringSettings);

            // 하늘 그리기
            context.DrawSkybox(camera);
			
            // 렌더링 커맨드 GPU에 전송
            context.Submit();
        }
    }
}
