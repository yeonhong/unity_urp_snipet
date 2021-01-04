using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

// 출처 : https://blog.naver.com/mnpshino/221633602003

// LWRP라서 적용이 안되..

[ExecuteInEditMode]
[Serializable]
[PostProcess(typeof(ShapeRenderer), PostProcessEvent.AfterStack, "Custom/Shape")]
public sealed class Shape : PostProcessEffectSettings
{
	[Range(0f, 1f), Tooltip("Step Value")]
	public FloatParameter stepValue = new FloatParameter { value = 0.5f };

	[Range(1f, 100f), Tooltip("Pattern Scale")]
	public FloatParameter patternScale = new FloatParameter { value = 10f };

	[Range(0f, 1f), Tooltip("RGB Split Value")]
	public FloatParameter rgbSplit = new FloatParameter { value = 0.5f };

	public TextureParameter patternTex = new TextureParameter { };

}

public sealed class ShapeRenderer : PostProcessEffectRenderer<Shape>
{
	public override void Render(PostProcessRenderContext context) {
		
	}
}
