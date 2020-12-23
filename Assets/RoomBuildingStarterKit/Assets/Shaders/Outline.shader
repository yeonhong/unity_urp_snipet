Shader "RoomBuildingStarterKit/Outline/Outline"
{
	HLSLINCLUDE

	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

	#pragma vertex Vert

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskTex);
	SAMPLER(sampler_MaskTex);

	float2 _MainTex_TexelSize;

	int _OutlineWidth;
	float _OutlineWeight;
	float4 _OutlineColor;
	float _GaussWeights[32];

	struct Attributes
	{
		uint vertexID : SV_VertexID;
	};

	struct Varyings
	{
		float4 position : SV_POSITION;
		float2 uv : TEXCOORD0;
	};

	float GetOutlineWeight(float2 uv, float2 offset)
	{
		float weight = 0;
		for (int i = -_OutlineWidth; i <= _OutlineWidth; ++i)
		{
			weight += _MainTex.Sample(sampler_MainTex, uv + i * offset).r * _GaussWeights[abs(i)];
		}

		return weight;
	}

	Varyings Vert(Attributes i)
	{
		Varyings o;
		o.position = GetFullScreenTriangleVertexPosition(i.vertexID);
		o.uv = GetFullScreenTriangleTexCoord(i.vertexID);

		return o;
	}

	ENDHLSL

	SubShader
	{
		Tags 
		{
			"RenderPipeline" = "UniversalPipeline" 
		}

		Cull Off
		ZWrite Off
		ZTest Always
		Lighting Off

		Pass
		{
			HLSLPROGRAM

			#pragma fragment FragHorizontal

			float4 FragHorizontal(Varyings i) : SV_Target
			{
				float weight = GetOutlineWeight(i.uv, float2(_MainTex_TexelSize.x, 0));
				return float4(weight, weight, weight, 1);
			}

			ENDHLSL
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			HLSLPROGRAM

			#pragma fragment FragVertical

			float4 FragVertical(Varyings i) : SV_Target
			{
				float weight = GetOutlineWeight(i.uv, float2(0, _MainTex_TexelSize.y));
				float a = (_MaskTex.Sample(sampler_MaskTex, i.uv).r > 0 ? 0 : _OutlineColor.a);
				return float4(_OutlineColor.rgb, saturate(a * weight * _OutlineWeight));
			}

			ENDHLSL
		}
	}
}

