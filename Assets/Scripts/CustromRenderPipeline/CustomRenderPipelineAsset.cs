using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

public class CustomRenderPipelineAsset : RenderPipelineAsset, ISerializationCallbackReceiver
{
    protected override RenderPipeline CreatePipeline()
    {
        return new CustomRenderPipeline(this);
    }

    public void OnBeforeSerialize()
    {
        //throw new System.NotImplementedException();
    }

    public void OnAfterDeserialize()
    {
        //throw new System.NotImplementedException();
    }

    [MenuItem("Assets/Create/Rendering/Custom Render Pipeline")]
    public static void CreateCustomRenderPipeline()
    {
        var instance = CreateInstance<CustomRenderPipelineAsset>();
        AssetDatabase.CreateAsset(instance, "Assets/CustomRenderPipeline.asset");
    }
}
