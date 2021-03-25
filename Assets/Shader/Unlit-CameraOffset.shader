Shader "Unlit/CameraOffset"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		[HideInInspector] _CameraOffset ("Camera Offset", Float) = 0
	}
		SubShader
	{
		Tags {
			"RenderPipeline" = "UniversalPipeline" 
			"RenderType" = "Transparent" 
			"Queue" = "Transparent"
		}

		Blend One One

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma shader_feature CAMOFFSET_ON

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			half _CameraOffset;

			v2f vert(appdata v)
			{
				v2f o;
				
			#ifdef CAMOFFSET_ON
				// vertex 위치를 카메라방향으로 offset처리.
				float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
				half3 viewDir = normalize(_WorldSpaceCameraPos - worldPos);
				worldPos.xyz += viewDir * _CameraOffset;
				o.vertex = mul(UNITY_MATRIX_VP, worldPos);
			#else
				o.vertex = UnityObjectToClipPos(v.vertex);
			#endif

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
	CustomEditor "UnlitCameraOffsetEditor"
}