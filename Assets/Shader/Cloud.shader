Shader "Cloud"
{
	Properties
	{
		Vector1_C43045C31("Scroll Speed", Float) = 1
		Color_1B7A81D3("Color1", Color) = (0.6320754, 0.6320754, 0.6320754, 1)
		Color_F94E7E21("Color2", Color) = (0.2830189, 0.2830189, 0.2830189, 1)
		Vector1_2D7119D0("Cloud Cover", Float) = 0
		Vector1_63B3518A("Additional Falloff", Float) = 0.5
		Vector1_C323827("Density", Float) = 3
	}
		SubShader
	{
		Tags
		{
			"RenderPipeline" = "UniversalPipeline"
			"RenderType" = "Transparent"
			"Queue" = "Transparent+0"
		}

		Pass
		{
			Name "Pass"
			Tags
			{
		// LightMode: <None>
	}

	// Render State
	Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
	Cull Back
	ZTest LEqual
	ZWrite On
		// ColorMask: <None>


		HLSLPROGRAM
		#pragma vertex vert
		#pragma fragment frag

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		// Pragmas
		#pragma prefer_hlslcc gles
		#pragma exclude_renderers d3d11_9x
		#pragma target 2.0
		#pragma multi_compile_fog
		#pragma multi_compile_instancing

		// Keywords
		#pragma multi_compile _ LIGHTMAP_ON
		#pragma multi_compile _ DIRLIGHTMAP_COMBINED
		#pragma shader_feature _ _SAMPLE_GI
		// GraphKeywords: <None>

		// Defines
		#define _SURFACE_TYPE_TRANSPARENT 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define VARYINGS_NEED_POSITION_WS 
		#define FEATURES_GRAPH_VERTEX
		#define SHADERPASS_UNLIT
		#define REQUIRE_DEPTH_TEXTURE

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
		#include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"

		// --------------------------------------------------
		// Graph

		// Graph Properties
		CBUFFER_START(UnityPerMaterial)
		float Vector1_C43045C31;
		float4 Color_1B7A81D3;
		float4 Color_F94E7E21;
		float Vector1_2D7119D0;
		float Vector1_63B3518A;
		float Vector1_C323827;
		CBUFFER_END

			// Graph Functions

			void Unity_Multiply_float(float A, float B, out float Out)
			{
				Out = A * B;
			}

			void Unity_Add_float2(float2 A, float2 B, out float2 Out)
			{
				Out = A + B;
			}


			float2 Unity_GradientNoise_Dir_float(float2 p)
			{
				// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
				p = p % 289;
				float x = (34 * p.x + 1) * p.x % 289 + p.y;
				x = (34 * x + 1) * x % 289;
				x = frac(x / 41) * 2 - 1;
				return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
			}

			void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
			{
				float2 p = UV * Scale;
				float2 ip = floor(p);
				float2 fp = frac(p);
				float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
				float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
				float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
				float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
				fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
				Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
			}


			inline float Unity_SimpleNoise_RandomValue_float(float2 uv)
			{
				return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
			}

			inline float Unity_SimpleNnoise_Interpolate_float(float a, float b, float t)
			{
				return (1.0 - t)*a + (t*b);
			}


			inline float Unity_SimpleNoise_ValueNoise_float(float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac(uv);
				f = f * f * (3.0 - 2.0 * f);

				uv = abs(frac(uv) - 0.5);
				float2 c0 = i + float2(0.0, 0.0);
				float2 c1 = i + float2(1.0, 0.0);
				float2 c2 = i + float2(0.0, 1.0);
				float2 c3 = i + float2(1.0, 1.0);
				float r0 = Unity_SimpleNoise_RandomValue_float(c0);
				float r1 = Unity_SimpleNoise_RandomValue_float(c1);
				float r2 = Unity_SimpleNoise_RandomValue_float(c2);
				float r3 = Unity_SimpleNoise_RandomValue_float(c3);

				float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
				float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
				float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
				return t;
			}
			void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
			{
				float t = 0.0;

				float freq = pow(2.0, float(0));
				float amp = pow(0.5, float(3 - 0));
				t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3 - 1));
				t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3 - 2));
				t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

				Out = t;
			}

			void Unity_Add_float(float A, float B, out float Out)
			{
				Out = A + B;
			}

			void Unity_Subtract_float(float A, float B, out float Out)
			{
				Out = A - B;
			}

			void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
			{
				Out = A * B;
			}

			void Unity_Saturate_float(float In, out float Out)
			{
				Out = saturate(In);
			}

			void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
			{
				Out = lerp(A, B, T);
			}

			void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
			{
				Out = smoothstep(Edge1, Edge2, In);
			}

			void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
			{
				Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
			}

			// Graph Vertex
			struct VertexDescriptionInputs
			{
				float3 ObjectSpaceNormal;
				float3 WorldSpaceNormal;
				float3 ObjectSpaceTangent;
				float3 WorldSpaceTangent;
				float3 ObjectSpaceBiTangent;
				float3 WorldSpaceBiTangent;
				float3 WorldSpacePosition;
				float3 TimeParameters;
			};

			struct VertexDescription
			{
				float3 VertexPosition;
				float3 VertexNormal;
				float3 VertexTangent;
			};

			VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
			{
				VertexDescription description = (VertexDescription)0;
				float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
				float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
				float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
				float _Split_77F42B22_A_4 = 0;
				float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
				float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
				float _Multiply_2EC20C29_Out_2;
				Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
				float _Multiply_887480D4_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
				float2 _Add_CA088AA7_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
				float _GradientNoise_ABBE52C6_Out_2;
				Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
				float _Multiply_86857696_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
				float2 _Add_898F10D0_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
				float _SimpleNoise_9BFE6773_Out_2;
				Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
				float _Add_B44A8947_Out_2;
				Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
				float _Multiply_1EAB72CA_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
				float2 _Add_B6E83F99_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
				float _SimpleNoise_E0E3BAC2_Out_2;
				Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
				float _Multiply_5C6AB400_Out_2;
				Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
				float _Subtract_86797563_Out_2;
				Unity_Subtract_float(_Multiply_5C6AB400_Out_2, 0.5, _Subtract_86797563_Out_2);
				float3 _Vector3_3AF234B5_Out_0 = float3(0, _Subtract_86797563_Out_2, 0);
				float3 _Multiply_B67BCD5E_Out_2;
				Unity_Multiply_float(_Vector3_3AF234B5_Out_0, float3(length(float3(UNITY_MATRIX_M[0].x, UNITY_MATRIX_M[1].x, UNITY_MATRIX_M[2].x)),
										 length(float3(UNITY_MATRIX_M[0].y, UNITY_MATRIX_M[1].y, UNITY_MATRIX_M[2].y)),
										 length(float3(UNITY_MATRIX_M[0].z, UNITY_MATRIX_M[1].z, UNITY_MATRIX_M[2].z))), _Multiply_B67BCD5E_Out_2);
				float2 _Add_10C8DA6_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_B67BCD5E_Out_2.xy), _Add_10C8DA6_Out_2);
				float3 _Transform_DA55A1C8_Out_1 = TransformWorldToObject((float3(_Add_10C8DA6_Out_2, 0.0)).xyz);
				description.VertexPosition = _Transform_DA55A1C8_Out_1;
				description.VertexNormal = IN.ObjectSpaceNormal;
				description.VertexTangent = IN.ObjectSpaceTangent;
				return description;
			}

			// Graph Pixel
			struct SurfaceDescriptionInputs
			{
				float3 WorldSpacePosition;
				float4 ScreenPosition;
				float3 TimeParameters;
			};

			struct SurfaceDescription
			{
				float3 Color;
				float Alpha;
				float AlphaClipThreshold;
			};

			SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
			{
				SurfaceDescription surface = (SurfaceDescription)0;
				float4 _Property_34F9390A_Out_0 = Color_1B7A81D3;
				float4 _Property_DD7006F7_Out_0 = Color_F94E7E21;
				float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
				float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
				float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
				float _Split_77F42B22_A_4 = 0;
				float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
				float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
				float _Multiply_2EC20C29_Out_2;
				Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
				float _Multiply_887480D4_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
				float2 _Add_CA088AA7_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
				float _GradientNoise_ABBE52C6_Out_2;
				Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
				float _Multiply_86857696_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
				float2 _Add_898F10D0_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
				float _SimpleNoise_9BFE6773_Out_2;
				Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
				float _Add_B44A8947_Out_2;
				Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
				float _Multiply_1EAB72CA_Out_2;
				Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
				float2 _Add_B6E83F99_Out_2;
				Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
				float _SimpleNoise_E0E3BAC2_Out_2;
				Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
				float _Multiply_5C6AB400_Out_2;
				Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
				float _Saturate_97343F23_Out_1;
				Unity_Saturate_float(_Multiply_5C6AB400_Out_2, _Saturate_97343F23_Out_1);
				float4 _Lerp_FF3A9F85_Out_3;
				Unity_Lerp_float4(_Property_34F9390A_Out_0, _Property_DD7006F7_Out_0, (_Saturate_97343F23_Out_1.xxxx), _Lerp_FF3A9F85_Out_3);
				float _Property_D0C45364_Out_0 = Vector1_2D7119D0;
				float _Multiply_8606B226_Out_2;
				Unity_Multiply_float(_Property_D0C45364_Out_0, 2, _Multiply_8606B226_Out_2);
				float _Property_2281F01A_Out_0 = Vector1_63B3518A;
				float _Add_4FA81F0F_Out_2;
				Unity_Add_float(_Multiply_8606B226_Out_2, _Property_2281F01A_Out_0, _Add_4FA81F0F_Out_2);
				float _Smoothstep_7A3533A6_Out_3;
				Unity_Smoothstep_float(_Property_D0C45364_Out_0, _Add_4FA81F0F_Out_2, _Multiply_5C6AB400_Out_2, _Smoothstep_7A3533A6_Out_3);
				float _SceneDepth_46BFC419_Out_1;
				Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_46BFC419_Out_1);
				float4 _ScreenPosition_20DB3E3F_Out_0 = IN.ScreenPosition;
				float _Split_291E3A82_R_1 = _ScreenPosition_20DB3E3F_Out_0[0];
				float _Split_291E3A82_G_2 = _ScreenPosition_20DB3E3F_Out_0[1];
				float _Split_291E3A82_B_3 = _ScreenPosition_20DB3E3F_Out_0[2];
				float _Split_291E3A82_A_4 = _ScreenPosition_20DB3E3F_Out_0[3];
				float _Subtract_545CBAB3_Out_2;
				Unity_Subtract_float(_SceneDepth_46BFC419_Out_1, _Split_291E3A82_A_4, _Subtract_545CBAB3_Out_2);
				float _Property_695798BA_Out_0 = Vector1_C323827;
				float _Multiply_F76165E2_Out_2;
				Unity_Multiply_float(_Subtract_545CBAB3_Out_2, _Property_695798BA_Out_0, _Multiply_F76165E2_Out_2);
				float _Saturate_B558114C_Out_1;
				Unity_Saturate_float(_Multiply_F76165E2_Out_2, _Saturate_B558114C_Out_1);
				float _Multiply_927552DF_Out_2;
				Unity_Multiply_float(_Smoothstep_7A3533A6_Out_3, _Saturate_B558114C_Out_1, _Multiply_927552DF_Out_2);
				surface.Color = (_Lerp_FF3A9F85_Out_3.xyz);
				surface.Alpha = _Multiply_927552DF_Out_2;
				surface.AlphaClipThreshold = 0;
				return surface;
			}

			// --------------------------------------------------
			// Structs and Packing

			// Generated Type: Attributes
			struct Attributes
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				#if UNITY_ANY_INSTANCING_ENABLED
				uint instanceID : INSTANCEID_SEMANTIC;
				#endif
			};

			// Generated Type: Varyings
			struct Varyings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS;
				#if UNITY_ANY_INSTANCING_ENABLED
				uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
				#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
				uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
				#endif
				#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
				uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
				#endif
				#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			// Generated Type: PackedVaryings
			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
				uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
				float3 interp00 : TEXCOORD0;
				#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
				uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
				#endif
				#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
				uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
				#endif
				#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			// Packed Type: Varyings
			PackedVaryings PackVaryings(Varyings input)
			{
				PackedVaryings output = (PackedVaryings)0;
				output.positionCS = input.positionCS;
				output.interp00.xyz = input.positionWS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
				output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
				#endif
				#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
				output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
				#endif
				#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
				output.cullFace = input.cullFace;
				#endif
				return output;
			}

			// Unpacked Type: Varyings
			Varyings UnpackVaryings(PackedVaryings input)
			{
				Varyings output = (Varyings)0;
				output.positionCS = input.positionCS;
				output.positionWS = input.interp00.xyz;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
				output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
				#endif
				#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
				output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
				#endif
				#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
				output.cullFace = input.cullFace;
				#endif
				return output;
			}

			// --------------------------------------------------
			// Build Graph Inputs

			VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
			{
				VertexDescriptionInputs output;
				ZERO_INITIALIZE(VertexDescriptionInputs, output);

				output.ObjectSpaceNormal = input.normalOS;
				output.WorldSpaceNormal = TransformObjectToWorldNormal(input.normalOS);
				output.ObjectSpaceTangent = input.tangentOS;
				output.WorldSpaceTangent = TransformObjectToWorldDir(input.tangentOS.xyz);
				output.ObjectSpaceBiTangent = normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
				output.WorldSpaceBiTangent = TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
				output.WorldSpacePosition = TransformObjectToWorld(input.positionOS);
				output.TimeParameters = _TimeParameters.xyz;

				return output;
			}

			SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
			{
				SurfaceDescriptionInputs output;
				ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





				output.WorldSpacePosition = input.positionWS;
				output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
				output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
			#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
			#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
			#else
			#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
			#endif
			#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

				return output;
			}


			// --------------------------------------------------
			// Main

			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"

			ENDHLSL
		}

		Pass
		{
			Name "ShadowCaster"
			Tags
			{
				"LightMode" = "ShadowCaster"
			}

				// Render State
				Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
				Cull Back
				ZTest LEqual
				ZWrite On
				// ColorMask: <None>


				HLSLPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				// Debug
				// <None>

				// --------------------------------------------------
				// Pass

				// Pragmas
				#pragma prefer_hlslcc gles
				#pragma exclude_renderers d3d11_9x
				#pragma target 2.0
				#pragma multi_compile_instancing

				// Keywords
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				// GraphKeywords: <None>

				// Defines
				#define _SURFACE_TYPE_TRANSPARENT 1
				#define ATTRIBUTES_NEED_NORMAL
				#define ATTRIBUTES_NEED_TANGENT
				#define VARYINGS_NEED_POSITION_WS 
				#define FEATURES_GRAPH_VERTEX
				#define SHADERPASS_SHADOWCASTER
				#define REQUIRE_DEPTH_TEXTURE

				// Includes
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
				#include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"

				// --------------------------------------------------
				// Graph

				// Graph Properties
				CBUFFER_START(UnityPerMaterial)
				float Vector1_C43045C31;
				float4 Color_1B7A81D3;
				float4 Color_F94E7E21;
				float Vector1_2D7119D0;
				float Vector1_63B3518A;
				float Vector1_C323827;
				CBUFFER_END

					// Graph Functions

					void Unity_Multiply_float(float A, float B, out float Out)
					{
						Out = A * B;
					}

					void Unity_Add_float2(float2 A, float2 B, out float2 Out)
					{
						Out = A + B;
					}


					float2 Unity_GradientNoise_Dir_float(float2 p)
					{
						// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
						p = p % 289;
						float x = (34 * p.x + 1) * p.x % 289 + p.y;
						x = (34 * x + 1) * x % 289;
						x = frac(x / 41) * 2 - 1;
						return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
					}

					void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
					{
						float2 p = UV * Scale;
						float2 ip = floor(p);
						float2 fp = frac(p);
						float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
						float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
						float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
						float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
						fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
						Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
					}


					inline float Unity_SimpleNoise_RandomValue_float(float2 uv)
					{
						return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
					}

					inline float Unity_SimpleNnoise_Interpolate_float(float a, float b, float t)
					{
						return (1.0 - t)*a + (t*b);
					}


					inline float Unity_SimpleNoise_ValueNoise_float(float2 uv)
					{
						float2 i = floor(uv);
						float2 f = frac(uv);
						f = f * f * (3.0 - 2.0 * f);

						uv = abs(frac(uv) - 0.5);
						float2 c0 = i + float2(0.0, 0.0);
						float2 c1 = i + float2(1.0, 0.0);
						float2 c2 = i + float2(0.0, 1.0);
						float2 c3 = i + float2(1.0, 1.0);
						float r0 = Unity_SimpleNoise_RandomValue_float(c0);
						float r1 = Unity_SimpleNoise_RandomValue_float(c1);
						float r2 = Unity_SimpleNoise_RandomValue_float(c2);
						float r3 = Unity_SimpleNoise_RandomValue_float(c3);

						float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
						float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
						float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
						return t;
					}
					void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
					{
						float t = 0.0;

						float freq = pow(2.0, float(0));
						float amp = pow(0.5, float(3 - 0));
						t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

						freq = pow(2.0, float(1));
						amp = pow(0.5, float(3 - 1));
						t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

						freq = pow(2.0, float(2));
						amp = pow(0.5, float(3 - 2));
						t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

						Out = t;
					}

					void Unity_Add_float(float A, float B, out float Out)
					{
						Out = A + B;
					}

					void Unity_Subtract_float(float A, float B, out float Out)
					{
						Out = A - B;
					}

					void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
					{
						Out = A * B;
					}

					void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
					{
						Out = smoothstep(Edge1, Edge2, In);
					}

					void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
					{
						Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
					}

					void Unity_Saturate_float(float In, out float Out)
					{
						Out = saturate(In);
					}

					// Graph Vertex
					struct VertexDescriptionInputs
					{
						float3 ObjectSpaceNormal;
						float3 WorldSpaceNormal;
						float3 ObjectSpaceTangent;
						float3 WorldSpaceTangent;
						float3 ObjectSpaceBiTangent;
						float3 WorldSpaceBiTangent;
						float3 WorldSpacePosition;
						float3 TimeParameters;
					};

					struct VertexDescription
					{
						float3 VertexPosition;
						float3 VertexNormal;
						float3 VertexTangent;
					};

					VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
					{
						VertexDescription description = (VertexDescription)0;
						float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
						float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
						float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
						float _Split_77F42B22_A_4 = 0;
						float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
						float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
						float _Multiply_2EC20C29_Out_2;
						Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
						float _Multiply_887480D4_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
						float2 _Add_CA088AA7_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
						float _GradientNoise_ABBE52C6_Out_2;
						Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
						float _Multiply_86857696_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
						float2 _Add_898F10D0_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
						float _SimpleNoise_9BFE6773_Out_2;
						Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
						float _Add_B44A8947_Out_2;
						Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
						float _Multiply_1EAB72CA_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
						float2 _Add_B6E83F99_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
						float _SimpleNoise_E0E3BAC2_Out_2;
						Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
						float _Multiply_5C6AB400_Out_2;
						Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
						float _Subtract_86797563_Out_2;
						Unity_Subtract_float(_Multiply_5C6AB400_Out_2, 0.5, _Subtract_86797563_Out_2);
						float3 _Vector3_3AF234B5_Out_0 = float3(0, _Subtract_86797563_Out_2, 0);
						float3 _Multiply_B67BCD5E_Out_2;
						Unity_Multiply_float(_Vector3_3AF234B5_Out_0, float3(length(float3(UNITY_MATRIX_M[0].x, UNITY_MATRIX_M[1].x, UNITY_MATRIX_M[2].x)),
												 length(float3(UNITY_MATRIX_M[0].y, UNITY_MATRIX_M[1].y, UNITY_MATRIX_M[2].y)),
												 length(float3(UNITY_MATRIX_M[0].z, UNITY_MATRIX_M[1].z, UNITY_MATRIX_M[2].z))), _Multiply_B67BCD5E_Out_2);
						float2 _Add_10C8DA6_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_B67BCD5E_Out_2.xy), _Add_10C8DA6_Out_2);
						float3 _Transform_DA55A1C8_Out_1 = TransformWorldToObject((float3(_Add_10C8DA6_Out_2, 0.0)).xyz);
						description.VertexPosition = _Transform_DA55A1C8_Out_1;
						description.VertexNormal = IN.ObjectSpaceNormal;
						description.VertexTangent = IN.ObjectSpaceTangent;
						return description;
					}

					// Graph Pixel
					struct SurfaceDescriptionInputs
					{
						float3 WorldSpacePosition;
						float4 ScreenPosition;
						float3 TimeParameters;
					};

					struct SurfaceDescription
					{
						float Alpha;
						float AlphaClipThreshold;
					};

					SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
					{
						SurfaceDescription surface = (SurfaceDescription)0;
						float _Property_D0C45364_Out_0 = Vector1_2D7119D0;
						float _Multiply_8606B226_Out_2;
						Unity_Multiply_float(_Property_D0C45364_Out_0, 2, _Multiply_8606B226_Out_2);
						float _Property_2281F01A_Out_0 = Vector1_63B3518A;
						float _Add_4FA81F0F_Out_2;
						Unity_Add_float(_Multiply_8606B226_Out_2, _Property_2281F01A_Out_0, _Add_4FA81F0F_Out_2);
						float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
						float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
						float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
						float _Split_77F42B22_A_4 = 0;
						float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
						float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
						float _Multiply_2EC20C29_Out_2;
						Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
						float _Multiply_887480D4_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
						float2 _Add_CA088AA7_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
						float _GradientNoise_ABBE52C6_Out_2;
						Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
						float _Multiply_86857696_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
						float2 _Add_898F10D0_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
						float _SimpleNoise_9BFE6773_Out_2;
						Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
						float _Add_B44A8947_Out_2;
						Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
						float _Multiply_1EAB72CA_Out_2;
						Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
						float2 _Add_B6E83F99_Out_2;
						Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
						float _SimpleNoise_E0E3BAC2_Out_2;
						Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
						float _Multiply_5C6AB400_Out_2;
						Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
						float _Smoothstep_7A3533A6_Out_3;
						Unity_Smoothstep_float(_Property_D0C45364_Out_0, _Add_4FA81F0F_Out_2, _Multiply_5C6AB400_Out_2, _Smoothstep_7A3533A6_Out_3);
						float _SceneDepth_46BFC419_Out_1;
						Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_46BFC419_Out_1);
						float4 _ScreenPosition_20DB3E3F_Out_0 = IN.ScreenPosition;
						float _Split_291E3A82_R_1 = _ScreenPosition_20DB3E3F_Out_0[0];
						float _Split_291E3A82_G_2 = _ScreenPosition_20DB3E3F_Out_0[1];
						float _Split_291E3A82_B_3 = _ScreenPosition_20DB3E3F_Out_0[2];
						float _Split_291E3A82_A_4 = _ScreenPosition_20DB3E3F_Out_0[3];
						float _Subtract_545CBAB3_Out_2;
						Unity_Subtract_float(_SceneDepth_46BFC419_Out_1, _Split_291E3A82_A_4, _Subtract_545CBAB3_Out_2);
						float _Property_695798BA_Out_0 = Vector1_C323827;
						float _Multiply_F76165E2_Out_2;
						Unity_Multiply_float(_Subtract_545CBAB3_Out_2, _Property_695798BA_Out_0, _Multiply_F76165E2_Out_2);
						float _Saturate_B558114C_Out_1;
						Unity_Saturate_float(_Multiply_F76165E2_Out_2, _Saturate_B558114C_Out_1);
						float _Multiply_927552DF_Out_2;
						Unity_Multiply_float(_Smoothstep_7A3533A6_Out_3, _Saturate_B558114C_Out_1, _Multiply_927552DF_Out_2);
						surface.Alpha = _Multiply_927552DF_Out_2;
						surface.AlphaClipThreshold = 0;
						return surface;
					}

					// --------------------------------------------------
					// Structs and Packing

					// Generated Type: Attributes
					struct Attributes
					{
						float3 positionOS : POSITION;
						float3 normalOS : NORMAL;
						float4 tangentOS : TANGENT;
						#if UNITY_ANY_INSTANCING_ENABLED
						uint instanceID : INSTANCEID_SEMANTIC;
						#endif
					};

					// Generated Type: Varyings
					struct Varyings
					{
						float4 positionCS : SV_POSITION;
						float3 positionWS;
						#if UNITY_ANY_INSTANCING_ENABLED
						uint instanceID : CUSTOM_INSTANCE_ID;
						#endif
						#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
						uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
						#endif
						#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
						uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
						#endif
						#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
						FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
						#endif
					};

					// Generated Type: PackedVaryings
					struct PackedVaryings
					{
						float4 positionCS : SV_POSITION;
						#if UNITY_ANY_INSTANCING_ENABLED
						uint instanceID : CUSTOM_INSTANCE_ID;
						#endif
						float3 interp00 : TEXCOORD0;
						#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
						uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
						#endif
						#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
						uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
						#endif
						#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
						FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
						#endif
					};

					// Packed Type: Varyings
					PackedVaryings PackVaryings(Varyings input)
					{
						PackedVaryings output = (PackedVaryings)0;
						output.positionCS = input.positionCS;
						output.interp00.xyz = input.positionWS;
						#if UNITY_ANY_INSTANCING_ENABLED
						output.instanceID = input.instanceID;
						#endif
						#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
						output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
						#endif
						#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
						output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
						#endif
						#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
						output.cullFace = input.cullFace;
						#endif
						return output;
					}

					// Unpacked Type: Varyings
					Varyings UnpackVaryings(PackedVaryings input)
					{
						Varyings output = (Varyings)0;
						output.positionCS = input.positionCS;
						output.positionWS = input.interp00.xyz;
						#if UNITY_ANY_INSTANCING_ENABLED
						output.instanceID = input.instanceID;
						#endif
						#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
						output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
						#endif
						#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
						output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
						#endif
						#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
						output.cullFace = input.cullFace;
						#endif
						return output;
					}

					// --------------------------------------------------
					// Build Graph Inputs

					VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
					{
						VertexDescriptionInputs output;
						ZERO_INITIALIZE(VertexDescriptionInputs, output);

						output.ObjectSpaceNormal = input.normalOS;
						output.WorldSpaceNormal = TransformObjectToWorldNormal(input.normalOS);
						output.ObjectSpaceTangent = input.tangentOS;
						output.WorldSpaceTangent = TransformObjectToWorldDir(input.tangentOS.xyz);
						output.ObjectSpaceBiTangent = normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
						output.WorldSpaceBiTangent = TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
						output.WorldSpacePosition = TransformObjectToWorld(input.positionOS);
						output.TimeParameters = _TimeParameters.xyz;

						return output;
					}

					SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
					{
						SurfaceDescriptionInputs output;
						ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





						output.WorldSpacePosition = input.positionWS;
						output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
						output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
					#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
					#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
					#else
					#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
					#endif
					#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

						return output;
					}


					// --------------------------------------------------
					// Main

					#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
					#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

					ENDHLSL
				}

				Pass
				{
					Name "DepthOnly"
					Tags
					{
						"LightMode" = "DepthOnly"
					}

						// Render State
						Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
						Cull Back
						ZTest LEqual
						ZWrite On
						ColorMask 0


						HLSLPROGRAM
						#pragma vertex vert
						#pragma fragment frag

						// Debug
						// <None>

						// --------------------------------------------------
						// Pass

						// Pragmas
						#pragma prefer_hlslcc gles
						#pragma exclude_renderers d3d11_9x
						#pragma target 2.0
						#pragma multi_compile_instancing

						// Keywords
						// PassKeywords: <None>
						// GraphKeywords: <None>

						// Defines
						#define _SURFACE_TYPE_TRANSPARENT 1
						#define ATTRIBUTES_NEED_NORMAL
						#define ATTRIBUTES_NEED_TANGENT
						#define VARYINGS_NEED_POSITION_WS 
						#define FEATURES_GRAPH_VERTEX
						#define SHADERPASS_DEPTHONLY
						#define REQUIRE_DEPTH_TEXTURE

						// Includes
						#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
						#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
						#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
						#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
						#include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"

						// --------------------------------------------------
						// Graph

						// Graph Properties
						CBUFFER_START(UnityPerMaterial)
						float Vector1_C43045C31;
						float4 Color_1B7A81D3;
						float4 Color_F94E7E21;
						float Vector1_2D7119D0;
						float Vector1_63B3518A;
						float Vector1_C323827;
						CBUFFER_END

							// Graph Functions

							void Unity_Multiply_float(float A, float B, out float Out)
							{
								Out = A * B;
							}

							void Unity_Add_float2(float2 A, float2 B, out float2 Out)
							{
								Out = A + B;
							}


							float2 Unity_GradientNoise_Dir_float(float2 p)
							{
								// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
								p = p % 289;
								float x = (34 * p.x + 1) * p.x % 289 + p.y;
								x = (34 * x + 1) * x % 289;
								x = frac(x / 41) * 2 - 1;
								return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
							}

							void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
							{
								float2 p = UV * Scale;
								float2 ip = floor(p);
								float2 fp = frac(p);
								float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
								float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
								float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
								float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
								fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
								Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
							}


							inline float Unity_SimpleNoise_RandomValue_float(float2 uv)
							{
								return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
							}

							inline float Unity_SimpleNnoise_Interpolate_float(float a, float b, float t)
							{
								return (1.0 - t)*a + (t*b);
							}


							inline float Unity_SimpleNoise_ValueNoise_float(float2 uv)
							{
								float2 i = floor(uv);
								float2 f = frac(uv);
								f = f * f * (3.0 - 2.0 * f);

								uv = abs(frac(uv) - 0.5);
								float2 c0 = i + float2(0.0, 0.0);
								float2 c1 = i + float2(1.0, 0.0);
								float2 c2 = i + float2(0.0, 1.0);
								float2 c3 = i + float2(1.0, 1.0);
								float r0 = Unity_SimpleNoise_RandomValue_float(c0);
								float r1 = Unity_SimpleNoise_RandomValue_float(c1);
								float r2 = Unity_SimpleNoise_RandomValue_float(c2);
								float r3 = Unity_SimpleNoise_RandomValue_float(c3);

								float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
								float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
								float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
								return t;
							}
							void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
							{
								float t = 0.0;

								float freq = pow(2.0, float(0));
								float amp = pow(0.5, float(3 - 0));
								t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

								freq = pow(2.0, float(1));
								amp = pow(0.5, float(3 - 1));
								t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

								freq = pow(2.0, float(2));
								amp = pow(0.5, float(3 - 2));
								t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale / freq, UV.y*Scale / freq))*amp;

								Out = t;
							}

							void Unity_Add_float(float A, float B, out float Out)
							{
								Out = A + B;
							}

							void Unity_Subtract_float(float A, float B, out float Out)
							{
								Out = A - B;
							}

							void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
							{
								Out = A * B;
							}

							void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
							{
								Out = smoothstep(Edge1, Edge2, In);
							}

							void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
							{
								Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
							}

							void Unity_Saturate_float(float In, out float Out)
							{
								Out = saturate(In);
							}

							// Graph Vertex
							struct VertexDescriptionInputs
							{
								float3 ObjectSpaceNormal;
								float3 WorldSpaceNormal;
								float3 ObjectSpaceTangent;
								float3 WorldSpaceTangent;
								float3 ObjectSpaceBiTangent;
								float3 WorldSpaceBiTangent;
								float3 WorldSpacePosition;
								float3 TimeParameters;
							};

							struct VertexDescription
							{
								float3 VertexPosition;
								float3 VertexNormal;
								float3 VertexTangent;
							};

							VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
							{
								VertexDescription description = (VertexDescription)0;
								float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
								float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
								float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
								float _Split_77F42B22_A_4 = 0;
								float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
								float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
								float _Multiply_2EC20C29_Out_2;
								Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
								float _Multiply_887480D4_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
								float2 _Add_CA088AA7_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
								float _GradientNoise_ABBE52C6_Out_2;
								Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
								float _Multiply_86857696_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
								float2 _Add_898F10D0_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
								float _SimpleNoise_9BFE6773_Out_2;
								Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
								float _Add_B44A8947_Out_2;
								Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
								float _Multiply_1EAB72CA_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
								float2 _Add_B6E83F99_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
								float _SimpleNoise_E0E3BAC2_Out_2;
								Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
								float _Multiply_5C6AB400_Out_2;
								Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
								float _Subtract_86797563_Out_2;
								Unity_Subtract_float(_Multiply_5C6AB400_Out_2, 0.5, _Subtract_86797563_Out_2);
								float3 _Vector3_3AF234B5_Out_0 = float3(0, _Subtract_86797563_Out_2, 0);
								float3 _Multiply_B67BCD5E_Out_2;
								Unity_Multiply_float(_Vector3_3AF234B5_Out_0, float3(length(float3(UNITY_MATRIX_M[0].x, UNITY_MATRIX_M[1].x, UNITY_MATRIX_M[2].x)),
														 length(float3(UNITY_MATRIX_M[0].y, UNITY_MATRIX_M[1].y, UNITY_MATRIX_M[2].y)),
														 length(float3(UNITY_MATRIX_M[0].z, UNITY_MATRIX_M[1].z, UNITY_MATRIX_M[2].z))), _Multiply_B67BCD5E_Out_2);
								float2 _Add_10C8DA6_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_B67BCD5E_Out_2.xy), _Add_10C8DA6_Out_2);
								float3 _Transform_DA55A1C8_Out_1 = TransformWorldToObject((float3(_Add_10C8DA6_Out_2, 0.0)).xyz);
								description.VertexPosition = _Transform_DA55A1C8_Out_1;
								description.VertexNormal = IN.ObjectSpaceNormal;
								description.VertexTangent = IN.ObjectSpaceTangent;
								return description;
							}

							// Graph Pixel
							struct SurfaceDescriptionInputs
							{
								float3 WorldSpacePosition;
								float4 ScreenPosition;
								float3 TimeParameters;
							};

							struct SurfaceDescription
							{
								float Alpha;
								float AlphaClipThreshold;
							};

							SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
							{
								SurfaceDescription surface = (SurfaceDescription)0;
								float _Property_D0C45364_Out_0 = Vector1_2D7119D0;
								float _Multiply_8606B226_Out_2;
								Unity_Multiply_float(_Property_D0C45364_Out_0, 2, _Multiply_8606B226_Out_2);
								float _Property_2281F01A_Out_0 = Vector1_63B3518A;
								float _Add_4FA81F0F_Out_2;
								Unity_Add_float(_Multiply_8606B226_Out_2, _Property_2281F01A_Out_0, _Add_4FA81F0F_Out_2);
								float _Split_77F42B22_R_1 = IN.WorldSpacePosition[0];
								float _Split_77F42B22_G_2 = IN.WorldSpacePosition[1];
								float _Split_77F42B22_B_3 = IN.WorldSpacePosition[2];
								float _Split_77F42B22_A_4 = 0;
								float2 _Vector2_256BEC5E_Out_0 = float2(_Split_77F42B22_R_1, _Split_77F42B22_B_3);
								float _Property_6D92A4E8_Out_0 = Vector1_C43045C31;
								float _Multiply_2EC20C29_Out_2;
								Unity_Multiply_float(IN.TimeParameters.x, _Property_6D92A4E8_Out_0, _Multiply_2EC20C29_Out_2);
								float _Multiply_887480D4_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 0.5, _Multiply_887480D4_Out_2);
								float2 _Add_CA088AA7_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_887480D4_Out_2.xx), _Add_CA088AA7_Out_2);
								float _GradientNoise_ABBE52C6_Out_2;
								Unity_GradientNoise_float(_Add_CA088AA7_Out_2, 0.1, _GradientNoise_ABBE52C6_Out_2);
								float _Multiply_86857696_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_86857696_Out_2);
								float2 _Add_898F10D0_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_86857696_Out_2.xx), _Add_898F10D0_Out_2);
								float _SimpleNoise_9BFE6773_Out_2;
								Unity_SimpleNoise_float(_Add_898F10D0_Out_2, 1, _SimpleNoise_9BFE6773_Out_2);
								float _Add_B44A8947_Out_2;
								Unity_Add_float(_GradientNoise_ABBE52C6_Out_2, _SimpleNoise_9BFE6773_Out_2, _Add_B44A8947_Out_2);
								float _Multiply_1EAB72CA_Out_2;
								Unity_Multiply_float(_Multiply_2EC20C29_Out_2, 1, _Multiply_1EAB72CA_Out_2);
								float2 _Add_B6E83F99_Out_2;
								Unity_Add_float2(_Vector2_256BEC5E_Out_0, (_Multiply_1EAB72CA_Out_2.xx), _Add_B6E83F99_Out_2);
								float _SimpleNoise_E0E3BAC2_Out_2;
								Unity_SimpleNoise_float(_Add_B6E83F99_Out_2, 0.5, _SimpleNoise_E0E3BAC2_Out_2);
								float _Multiply_5C6AB400_Out_2;
								Unity_Multiply_float(_Add_B44A8947_Out_2, _SimpleNoise_E0E3BAC2_Out_2, _Multiply_5C6AB400_Out_2);
								float _Smoothstep_7A3533A6_Out_3;
								Unity_Smoothstep_float(_Property_D0C45364_Out_0, _Add_4FA81F0F_Out_2, _Multiply_5C6AB400_Out_2, _Smoothstep_7A3533A6_Out_3);
								float _SceneDepth_46BFC419_Out_1;
								Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_46BFC419_Out_1);
								float4 _ScreenPosition_20DB3E3F_Out_0 = IN.ScreenPosition;
								float _Split_291E3A82_R_1 = _ScreenPosition_20DB3E3F_Out_0[0];
								float _Split_291E3A82_G_2 = _ScreenPosition_20DB3E3F_Out_0[1];
								float _Split_291E3A82_B_3 = _ScreenPosition_20DB3E3F_Out_0[2];
								float _Split_291E3A82_A_4 = _ScreenPosition_20DB3E3F_Out_0[3];
								float _Subtract_545CBAB3_Out_2;
								Unity_Subtract_float(_SceneDepth_46BFC419_Out_1, _Split_291E3A82_A_4, _Subtract_545CBAB3_Out_2);
								float _Property_695798BA_Out_0 = Vector1_C323827;
								float _Multiply_F76165E2_Out_2;
								Unity_Multiply_float(_Subtract_545CBAB3_Out_2, _Property_695798BA_Out_0, _Multiply_F76165E2_Out_2);
								float _Saturate_B558114C_Out_1;
								Unity_Saturate_float(_Multiply_F76165E2_Out_2, _Saturate_B558114C_Out_1);
								float _Multiply_927552DF_Out_2;
								Unity_Multiply_float(_Smoothstep_7A3533A6_Out_3, _Saturate_B558114C_Out_1, _Multiply_927552DF_Out_2);
								surface.Alpha = _Multiply_927552DF_Out_2;
								surface.AlphaClipThreshold = 0;
								return surface;
							}

							// --------------------------------------------------
							// Structs and Packing

							// Generated Type: Attributes
							struct Attributes
							{
								float3 positionOS : POSITION;
								float3 normalOS : NORMAL;
								float4 tangentOS : TANGENT;
								#if UNITY_ANY_INSTANCING_ENABLED
								uint instanceID : INSTANCEID_SEMANTIC;
								#endif
							};

							// Generated Type: Varyings
							struct Varyings
							{
								float4 positionCS : SV_POSITION;
								float3 positionWS;
								#if UNITY_ANY_INSTANCING_ENABLED
								uint instanceID : CUSTOM_INSTANCE_ID;
								#endif
								#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
								uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
								#endif
								#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
								uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
								#endif
								#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
								FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
								#endif
							};

							// Generated Type: PackedVaryings
							struct PackedVaryings
							{
								float4 positionCS : SV_POSITION;
								#if UNITY_ANY_INSTANCING_ENABLED
								uint instanceID : CUSTOM_INSTANCE_ID;
								#endif
								float3 interp00 : TEXCOORD0;
								#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
								uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
								#endif
								#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
								uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
								#endif
								#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
								FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
								#endif
							};

							// Packed Type: Varyings
							PackedVaryings PackVaryings(Varyings input)
							{
								PackedVaryings output = (PackedVaryings)0;
								output.positionCS = input.positionCS;
								output.interp00.xyz = input.positionWS;
								#if UNITY_ANY_INSTANCING_ENABLED
								output.instanceID = input.instanceID;
								#endif
								#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
								output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
								#endif
								#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
								output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
								#endif
								#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
								output.cullFace = input.cullFace;
								#endif
								return output;
							}

							// Unpacked Type: Varyings
							Varyings UnpackVaryings(PackedVaryings input)
							{
								Varyings output = (Varyings)0;
								output.positionCS = input.positionCS;
								output.positionWS = input.interp00.xyz;
								#if UNITY_ANY_INSTANCING_ENABLED
								output.instanceID = input.instanceID;
								#endif
								#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
								output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
								#endif
								#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
								output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
								#endif
								#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
								output.cullFace = input.cullFace;
								#endif
								return output;
							}

							// --------------------------------------------------
							// Build Graph Inputs

							VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
							{
								VertexDescriptionInputs output;
								ZERO_INITIALIZE(VertexDescriptionInputs, output);

								output.ObjectSpaceNormal = input.normalOS;
								output.WorldSpaceNormal = TransformObjectToWorldNormal(input.normalOS);
								output.ObjectSpaceTangent = input.tangentOS;
								output.WorldSpaceTangent = TransformObjectToWorldDir(input.tangentOS.xyz);
								output.ObjectSpaceBiTangent = normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
								output.WorldSpaceBiTangent = TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
								output.WorldSpacePosition = TransformObjectToWorld(input.positionOS);
								output.TimeParameters = _TimeParameters.xyz;

								return output;
							}

							SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
							{
								SurfaceDescriptionInputs output;
								ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





								output.WorldSpacePosition = input.positionWS;
								output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
								output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
							#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
							#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
							#else
							#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
							#endif
							#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

								return output;
							}


							// --------------------------------------------------
							// Main

							#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
							#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

							ENDHLSL
						}

	}
		FallBack "Hidden/Shader Graph/FallbackError"
}
