Shader "RoomBuildingStarterKit/Outline/RenderImage"
{
	SubShader
	{
		Tags
		{
			"RenderPipeline" = "UniversalPipeline"
		}

		Cull Off
		ZWrite Off
		ZTest LEqual
		Lighting Off
		 
		Pass
		{
			HLSLPROGRAM

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

			#pragma vertex Vert
			#pragma fragment Frag

			struct Attributes
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Varyings
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			Varyings Vert(Attributes i)
			{
				Varyings o;
				o.position = TransformObjectToHClip(i.vertex.xyz);
				o.uv = i.uv;
				return o;
			}

			float4 Frag(Varyings i) : SV_Target
			{
				return float4(1, 1, 1, 1);
			}

			ENDHLSL
		}
	}
}