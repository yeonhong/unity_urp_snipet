Shader "Universal Render Pipeline/Perspective2Ortho"
{
	Properties
	{ }

	SubShader
	{
		Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalRenderPipeline" }

		Pass
		{
		HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"            

			struct Attributes
			{
				float4 position : POSITION;
			};

			struct Varyings
			{
				float4 pos : SV_POSITION;
				float4 cpos : TEXCOORD1;
			};

			Varyings vert(Attributes IN)
			{
				Varyings o;
				float4 pos;
				
				float orthoWidth = unity_OrthoParams.x;
				float orthoHeight = unity_OrthoParams.y;
				float nearPlane = _ProjectionParams.y;
				float farPlane = _ProjectionParams.z;

				float width = _ScreenParams.x;
				float height = _ScreenParams.y;
				float aspect = width / height;

				float4x4 m = UNITY_MATRIX_P;

				float halfFov = atan2(1, aspect * m[0].x);

				float top = tan(halfFov) * nearPlane;
				float bottom = -top;
				float right = (top * aspect);
				float left = -right;

				float otop = orthoHeight;
				float obottom = -otop;
				float oright = orthoWidth;
				float oleft = -oright;

				float op00 = 2 / (oright - oleft);
				float op11 = -2 / (otop - obottom);
				float op22 = 1 / (farPlane - nearPlane);
				float op23 = farPlane / (farPlane - nearPlane);

				// DirectX를 사용하는 윈도우 환경에서의 투영 행렬
				float p00 = (2 * nearPlane) / (right - left);
				float p11 = -(2 * nearPlane) / (top - bottom);
				float p22 = -farPlane / (farPlane - nearPlane);
				float p23 = -(farPlane * nearPlane) / (farPlane - nearPlane);

				float4x4 projectionMatrix;
				projectionMatrix[0] = float4(p00, 0, 0, 0);
				projectionMatrix[1] = float4(0, p11, 0, 0);
				projectionMatrix[2] = float4(0, 0, p22, p23);
				projectionMatrix[3] = float4(0, 0, -1, 0);

				float4x4 projectionMatrixOrtho;
				projectionMatrixOrtho[0] = float4(op00, 0, 0, 0);
				projectionMatrixOrtho[1] = float4(0, op11, 0, 0);
				projectionMatrixOrtho[2] = float4(0, 0, op22, op23);
				projectionMatrixOrtho[3] = float4(0, 0, 0, 1);

				pos = mul(unity_ObjectToWorld, IN.position);
				pos = mul(UNITY_MATRIX_V, pos);
				pos = mul(UNITY_MATRIX_P, pos);
				//pos.w =;

				float4 pos2 = IN.position;
				pos = mul(unity_ObjectToWorld, pos2);
				pos = mul(UNITY_MATRIX_V, pos);

				pos.x /= pos.w;
				pos.y /= pos.w;
				//pos2.y /= pos.w;

				pos = mul(UNITY_MATRIX_P, pos);

				o.pos = pos;
				
				
			//https://www.sysnet.pe.kr/2/0/11695
			//https://reshade.me/forum/shader-presentation/3916-distortion-correction-conformal-perspective
			//http://www.cse.psu.edu/~rtc12/CSE486/lecture16.pdf
			//https://docs.opencv.org/master/d9/dab/tutorial_homography.html
			//https://mathematica.stackexchange.com/questions/121822/application-of-the-projection-matrix-removing-perspective-distortion

				o.cpos = mul(unity_ObjectToWorld, IN.position);
				return o;
			}

			half4 frag(Varyings v) : SV_Target
			{
				half4 customColor;
				customColor = half4(v.cpos.x, v.cpos.y, v.cpos.z, v.cpos.w);
				return customColor;
			}
		ENDHLSL
		}
	}
}