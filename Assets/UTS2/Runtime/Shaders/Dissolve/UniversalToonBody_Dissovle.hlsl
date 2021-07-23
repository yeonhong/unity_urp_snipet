﻿//UTS2/UniversalToon
//v.2.2.0
//nobuyuki@unity3d.com
//toshiyuki@unity3d.com (Univerasl RP/HDRP)  
//https://github.com/unity3d-jp/UnityChanToonShaderVer2_Project
//(C)Unity Technologies Japan/UCL
//

#if (SHADER_LIBRARY_VERSION_MAJOR ==7 && SHADER_LIBRARY_VERSION_MINOR >= 3) || (SHADER_LIBRARY_VERSION_MAJOR >= 8)


# ifdef _ADDITIONAL_LIGHTS
#  ifndef  REQUIRES_WORLD_SPACE_POS_INTERPOLATOR
#   define REQUIRES_WORLD_SPACE_POS_INTERPOLATOR
#  endif
# endif
#else
# ifdef _MAIN_LIGHT_SHADOWS
//#  if !defined(_MAIN_LIGHT_SHADOWS_CASCADE) 
#   ifndef REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
#    define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
#   endif
//#  endif
# endif
# ifdef _ADDITIONAL_LIGHTS
#  ifndef  REQUIRES_WORLD_SPACE_POS_INTERPOLATOR
#   define REQUIRES_WORLD_SPACE_POS_INTERPOLATOR
#  endif
# endif
#endif

            uniform float _utsTechnique;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
#if UCTS_LWRP
#else
            uniform float4 _BaseColor;
#endif
            //v.2.0.5
            uniform float4 _Color;
            uniform fixed _Use_BaseAs1st;
            uniform fixed _Use_1stAs2nd;
            //
            uniform fixed _Is_LightColor_Base;
            uniform sampler2D _1st_ShadeMap; uniform float4 _1st_ShadeMap_ST;
            uniform float4 _1st_ShadeColor;
            uniform fixed _Is_LightColor_1st_Shade;
            uniform sampler2D _2nd_ShadeMap; uniform float4 _2nd_ShadeMap_ST;
            uniform float4 _2nd_ShadeColor;
            uniform fixed _Is_LightColor_2nd_Shade;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform fixed _Is_NormalMapToBase;
            uniform fixed _Set_SystemShadowsToBase;
            uniform float _Tweak_SystemShadowsLevel;
            uniform float _BaseColor_Step;
            uniform float _BaseShade_Feather;
            uniform sampler2D _Set_1st_ShadePosition; uniform float4 _Set_1st_ShadePosition_ST;
            uniform float _ShadeColor_Step;
            uniform float _1st2nd_Shades_Feather;
            uniform sampler2D _Set_2nd_ShadePosition; uniform float4 _Set_2nd_ShadePosition_ST;

// ShadingGradeMap
#if defined(_SHADINGGRADEMAP)
            uniform sampler2D _ShadingGradeMap; uniform float4 _ShadingGradeMap_ST;
#endif
            //v.2.0.6
            uniform float _Tweak_ShadingGradeMapLevel;
            uniform fixed _BlurLevelSGM;
            //
            uniform float _1st_ShadeColor_Step;
            uniform float _1st_ShadeColor_Feather;
            uniform float _2nd_ShadeColor_Step;
            uniform float _2nd_ShadeColor_Feather;
// ShadingGradeMap

            uniform float4 _HighColor;
            uniform sampler2D _HighColor_Tex; uniform float4 _HighColor_Tex_ST;
            uniform fixed _Is_LightColor_HighColor;
            uniform fixed _Is_NormalMapToHighColor;
            uniform float _HighColor_Power;
            uniform fixed _Is_SpecularToHighColor;
            uniform fixed _Is_BlendAddToHiColor;
            uniform fixed _Is_UseTweakHighColorOnShadow;
            uniform float _TweakHighColorOnShadow;
            uniform sampler2D _Set_HighColorMask; uniform float4 _Set_HighColorMask_ST;
            uniform float _Tweak_HighColorMaskLevel;
            uniform fixed _RimLight;
            uniform float4 _RimLightColor;
            uniform fixed _Is_LightColor_RimLight;
            uniform fixed _Is_NormalMapToRimLight;
            uniform float _RimLight_Power;
            uniform float _RimLight_InsideMask;
            uniform fixed _RimLight_FeatherOff;
            uniform fixed _LightDirection_MaskOn;
            uniform float _Tweak_LightDirection_MaskLevel;
            uniform fixed _Add_Antipodean_RimLight;
            uniform float4 _Ap_RimLightColor;
            uniform fixed _Is_LightColor_Ap_RimLight;
            uniform float _Ap_RimLight_Power;
            uniform fixed _Ap_RimLight_FeatherOff;
            uniform sampler2D _Set_RimLightMask; uniform float4 _Set_RimLightMask_ST;
            uniform float _Tweak_RimLightMaskLevel;
            uniform fixed _MatCap;

            uniform sampler2D _MatCap_Sampler; uniform float4 _MatCap_Sampler_ST;

            uniform float4 _MatCapColor;
            uniform fixed _Is_LightColor_MatCap;
            uniform fixed _Is_BlendAddToMatCap;
            uniform float _Tweak_MatCapUV;
            uniform float _Rotate_MatCapUV;
            uniform fixed _Is_NormalMapForMatCap;
            uniform sampler2D _NormalMapForMatCap; uniform float4 _NormalMapForMatCap_ST;
            uniform float _Rotate_NormalMapForMatCapUV;
            uniform fixed _Is_UseTweakMatCapOnShadow;
            uniform float _TweakMatCapOnShadow;
            //MatcapMask
            uniform sampler2D _Set_MatcapMask; uniform float4 _Set_MatcapMask_ST;
            uniform float _Tweak_MatcapMaskLevel;
            //v.2.0.5
            uniform fixed _Is_Ortho;
            //v.2.0.6
            uniform float _CameraRolling_Stabilizer;
            uniform fixed _BlurLevelMatcap;
            uniform fixed _Inverse_MatcapMask;
#if UCTS_LWRP
#else
            uniform float _BumpScale;
#endif
            uniform float _BumpScaleMatcap;
            //Emissive
            uniform sampler2D _Emissive_Tex; uniform float4 _Emissive_Tex_ST;
            uniform float4 _Emissive_Color;
            //v.2.0.7
            uniform fixed _Is_ViewCoord_Scroll;
            uniform float _Rotate_EmissiveUV;
            uniform float _Base_Speed;
            uniform float _Scroll_EmissiveU;
            uniform float _Scroll_EmissiveV;
            uniform fixed _Is_PingPong_Base;
            uniform float4 _ColorShift;
            uniform float4 _ViewShift;
            uniform float _ColorShift_Speed;
            uniform fixed _Is_ColorShift;
            uniform fixed _Is_ViewShift;
            uniform float3 emissive;
            // 
            uniform float _Unlit_Intensity;
            //v.2.0.5
            uniform fixed _Is_Filter_HiCutPointLightColor;
            uniform fixed _Is_Filter_LightColor;
            //v.2.0.4.4
            uniform float _StepOffset;
            uniform fixed _Is_BLD;
            uniform float _Offset_X_Axis_BLD;
            uniform float _Offset_Y_Axis_BLD;
            uniform fixed _Inverse_Z_Axis_BLD;

			uniform fixed _TransparentEnabled;
			uniform float _Tweak_transparency;

            // RaytracedHardShadow
#define UNITY_PROJ_COORD(a) a
#define UNITY_SAMPLE_SCREEN_SHADOW(tex, uv) tex2Dproj( tex, UNITY_PROJ_COORD(uv) ).r
//            TEXTURE2D_SHADOW(_RaytracedHardShadow);
//            SAMPLER_CMP(sampler__RaytracedHardShadow);
#define TEXTURE2D_SAMPLER2D(textureName, samplerName) Texture2D textureName; SamplerState samplerName
            TEXTURE2D_SAMPLER2D(_RaytracedHardShadow, sampler_RaytracedHardShadow);
//            uniform sampler2D _RaytracedHardShadow;
            float4 _RaytracedHardShadow_TexelSize;
            uniform int UtsUseRaytracingShadow;

            // UV回転をする関数：RotateUV()
            //float2 rotatedUV = RotateUV(i.uv0, (_angular_Verocity*3.141592654), float2(0.5, 0.5), _Time.g);
            float2 RotateUV(float2 _uv, float _radian, float2 _piv, float _time)
            {
                float RotateUV_ang = _radian;
                float RotateUV_cos = cos(_time*RotateUV_ang);
                float RotateUV_sin = sin(_time*RotateUV_ang);
                return (mul(_uv - _piv, float2x2( RotateUV_cos, -RotateUV_sin, RotateUV_sin, RotateUV_cos)) + _piv);
            }
            //
            fixed3 DecodeLightProbe( fixed3 N ){
                return ShadeSH9(float4(N,1));
            }


            inline void InitializeStandardLitSurfaceDataUTS(float2 uv, out SurfaceData outSurfaceData)
            {
                // half4 albedoAlpha = SampleAlbedoAlpha(uv, TEXTURE2D_ARGS(_BaseMap, sampler_BaseMap));
                half4 albedoAlpha = half4(1.0,1.0,1.0,1.0);
 
                outSurfaceData.alpha = Alpha(albedoAlpha.a, _BaseColor, _Cutoff);
            
                half4 specGloss = SampleMetallicSpecGloss(uv, albedoAlpha.a);
                outSurfaceData.albedo = albedoAlpha.rgb * _BaseColor.rgb;
            
            #if _SPECULAR_SETUP
                outSurfaceData.metallic = 1.0h;
                outSurfaceData.specular = specGloss.rgb;
            #else
                outSurfaceData.metallic = specGloss.r;
                outSurfaceData.specular = half3(0.0h, 0.0h, 0.0h);
            #endif
            
                outSurfaceData.smoothness = specGloss.a;
                outSurfaceData.normalTS = SampleNormal(uv, TEXTURE2D_ARGS(_BumpMap, sampler_BumpMap), _BumpScale);
                outSurfaceData.occlusion = SampleOcclusion(uv);
                outSurfaceData.emission = SampleEmission(uv, _EmissionColor.rgb, TEXTURE2D_ARGS(_EmissionMap, sampler_EmissionMap));
            }
            half3 GlobalIlluminationUTS(BRDFData brdfData, half3 bakedGI, half occlusion, half3 normalWS, half3 viewDirectionWS)
            {
                half3 reflectVector = reflect(-viewDirectionWS, normalWS);
                half fresnelTerm = Pow4(1.0 - saturate(dot(normalWS, viewDirectionWS)));

                half3 indirectDiffuse = bakedGI * occlusion;
                half3 indirectSpecular = GlossyEnvironmentReflection(reflectVector, brdfData.perceptualRoughness, occlusion);

                return EnvironmentBRDF(brdfData, indirectDiffuse, indirectSpecular, fresnelTerm);
            }
            uniform float _GI_Intensity;

//v.2.0.4
#if defined(_SHADINGGRADEMAP)

#ifdef _IS_ANGELRING_OFF
//
#elif _IS_ANGELRING_ON
            uniform fixed _AngelRing;

            uniform sampler2D _AngelRing_Sampler; uniform float4 _AngelRing_Sampler_ST;
            uniform float4 _AngelRing_Color;
            uniform fixed _Is_LightColor_AR;
            uniform float _AR_OffsetU;
            uniform float _AR_OffsetV;
            uniform fixed _ARSampler_AlphaOn;

#endif
#endif     //#if defined(_SHADINGGRADEMP)
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;

			#ifdef _IS_ANGELRING_OFF
				float2 lightmapUV   : TEXCOORD1;
			#elif _IS_ANGELRING_ON
				float2 texcoord1 : TEXCOORD1;
				float2 lightmapUV   : TEXCOORD2;
			#endif
				UNITY_VERTEX_INPUT_INSTANCE_ID

			};

			struct VertexOutput {
					float4 pos : SV_POSITION;
					float2 uv0 : TEXCOORD0;
	//v.2.0.4
#ifdef _IS_ANGELRING_OFF
					float4 posWorld : TEXCOORD1;
					float3 normalDir : TEXCOORD2;
					float3 tangentDir : TEXCOORD3;
					float3 bitangentDir : TEXCOORD4;
					
					ADVANCED_DISSOLVE_DATA(5)

					DECLARE_LIGHTMAP_OR_SH(lightmapUV, vertexSH, 6);
					half4 fogFactorAndVertexLight   : TEXCOORD7; // x: fogFactor, yzw: vertex light

				#ifndef _MAIN_LIGHT_SHADOWS
					float4 positionCS               : TEXCOORD8;
					int   mainLightID				: TEXCOORD9;
					//v.2.0.7
					float mirrorFlag : TEXCOORD10;
				#else
					float4 shadowCoord              : TEXCOORD8;
					float4 positionCS               : TEXCOORD9;
					int   mainLightID				: TEXCOORD10;
					//v.2.0.7
					float mirrorFlag : TEXCOORD11;
				#endif
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO

                //
#elif _IS_ANGELRING_ON
					float2 uv1 : TEXCOORD1;
					float4 posWorld : TEXCOORD2;
					float3 normalDir : TEXCOORD3;
					float3 tangentDir : TEXCOORD4;
					float3 bitangentDir : TEXCOORD5;
					
					ADVANCED_DISSOLVE_DATA(6)
					//v.2.0.7
					float mirrorFlag : TEXCOORD7;

					DECLARE_LIGHTMAP_OR_SH(lightmapUV, vertexSH, 8);
					half4 fogFactorAndVertexLight : TEXCOORD9; // x: fogFactor, yzw: vertex light
				# ifndef _MAIN_LIGHT_SHADOWS
					float4 positionCS : TEXCOORD10;
					int   mainLightID : TEXCOORD11;
				# else
					float4 shadowCoord : TEXCOORD10;
					float4 positionCS : TEXCOORD11;
					int   mainLightID : TEXCOORD12;
				# endif
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
#else
					LIGHTING_COORDS(7,8)
					UNITY_FOG_COORDS(9)
#endif
                //

            };
 
            // Abstraction over Light shading data.
            struct UtsLight
            {
                float3   direction;
                float3   color;
                float    distanceAttenuation;
                real    shadowAttenuation;
                int     type;
            };

            ///////////////////////////////////////////////////////////////////////////////
            //                      Light Abstraction                                    //
            /////////////////////////////////////////////////////////////////////////////
            real MainLightRealtimeShadowUTS(float4 shadowCoord, float4 positionCS)
            {
#if !defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                return 1.0h;
#endif
                ShadowSamplingData shadowSamplingData = GetMainLightShadowSamplingData();
                half4 shadowParams = GetMainLightShadowParams();
#if defined(UTS_USE_RAYTRACING_SHADOW)
                float4 screenPos =  ComputeScreenPos(positionCS/ positionCS.w);
                return SAMPLE_TEXTURE2D(_RaytracedHardShadow, sampler_RaytracedHardShadow, screenPos);
#endif 

                return SampleShadowmap(TEXTURE2D_ARGS(_MainLightShadowmapTexture, sampler_MainLightShadowmapTexture), shadowCoord, shadowSamplingData, shadowParams, false);
            }

            real AdditionalLightRealtimeShadowUTS(int lightIndex, float3 positionWS, float4 positionCS)
            {
#if  defined(UTS_USE_RAYTRACING_SHADOW)
                float4 screenPos = ComputeScreenPos(positionCS / positionCS.w);
                return SAMPLE_TEXTURE2D(_RaytracedHardShadow, sampler_RaytracedHardShadow, screenPos);
#endif // UTS_USE_RAYTRACING_SHADOW

#if !defined(ADDITIONAL_LIGHT_CALCULATE_SHADOWS)
                return 1.0h;
#endif

                ShadowSamplingData shadowSamplingData = GetAdditionalLightShadowSamplingData();

#if USE_STRUCTURED_BUFFER_FOR_LIGHT_DATA
                lightIndex = _AdditionalShadowsIndices[lightIndex];

                // We have to branch here as otherwise we would sample buffer with lightIndex == -1.
                // However this should be ok for platforms that store light in SSBO.
                UNITY_BRANCH
                    if (lightIndex < 0)
                        return 1.0;

                float4 shadowCoord = mul(_AdditionalShadowsBuffer[lightIndex].worldToShadowMatrix, float4(positionWS, 1.0));
#else
                float4 shadowCoord = mul(_AdditionalLightsWorldToShadow[lightIndex], float4(positionWS, 1.0));
#endif

                half4 shadowParams = GetAdditionalLightShadowParams(lightIndex);
                return SampleShadowmap(TEXTURE2D_ARGS(_AdditionalLightsShadowmapTexture, sampler_AdditionalLightsShadowmapTexture), shadowCoord, shadowSamplingData, shadowParams, true);
            }



            UtsLight GetMainUtsLight()
            {
                UtsLight light;
                light.direction = _MainLightPosition.xyz;
                // unity_LightData.z is 1 when not culled by the culling mask, otherwise 0.
                light.distanceAttenuation = unity_LightData.z;
#if defined(LIGHTMAP_ON) || defined(_MIXED_LIGHTING_SUBTRACTIVE)
                // unity_ProbesOcclusion.x is the mixed light probe occlusion data
                light.distanceAttenuation *= unity_ProbesOcclusion.x;
#endif
                light.shadowAttenuation = 1.0;
                light.color = _MainLightColor.rgb;
                light.type = _MainLightPosition.w;
                return light;
            }

            UtsLight GetMainUtsLight(float4 shadowCoord, float4 positionCS)
            {
                UtsLight light = GetMainUtsLight();
                light.shadowAttenuation = MainLightRealtimeShadowUTS(shadowCoord, positionCS);
                return light;
            }

            // Fills a light struct given a perObjectLightIndex
            UtsLight GetAdditionalPerObjectUtsLight(int perObjectLightIndex, float3 positionWS,float4 positionCS)
            {
                // Abstraction over Light input constants
#if USE_STRUCTURED_BUFFER_FOR_LIGHT_DATA
                float4 lightPositionWS = _AdditionalLightsBuffer[perObjectLightIndex].position;
                half3 color = _AdditionalLightsBuffer[perObjectLightIndex].color.rgb;
                half4 distanceAndSpotAttenuation = _AdditionalLightsBuffer[perObjectLightIndex].attenuation;
                half4 spotDirection = _AdditionalLightsBuffer[perObjectLightIndex].spotDirection;
                half4 lightOcclusionProbeInfo = _AdditionalLightsBuffer[perObjectLightIndex].occlusionProbeChannels;
#else
                float4 lightPositionWS = _AdditionalLightsPosition[perObjectLightIndex];
                half3 color = _AdditionalLightsColor[perObjectLightIndex].rgb;
                half4 distanceAndSpotAttenuation = _AdditionalLightsAttenuation[perObjectLightIndex];
                half4 spotDirection = _AdditionalLightsSpotDir[perObjectLightIndex];
                half4 lightOcclusionProbeInfo = _AdditionalLightsOcclusionProbes[perObjectLightIndex];
#endif

                // Directional lights store direction in lightPosition.xyz and have .w set to 0.0.
                // This way the following code will work for both directional and punctual lights.
                float3 lightVector = lightPositionWS.xyz - positionWS * lightPositionWS.w;
                float distanceSqr = max(dot(lightVector, lightVector), HALF_MIN);

                half3 lightDirection = half3(lightVector * rsqrt(distanceSqr));
                half attenuation = DistanceAttenuation(distanceSqr, distanceAndSpotAttenuation.xy) * AngleAttenuation(spotDirection.xyz, lightDirection, distanceAndSpotAttenuation.zw);

                UtsLight light;
                light.direction = lightDirection;
                light.distanceAttenuation = attenuation;
                light.shadowAttenuation = AdditionalLightRealtimeShadowUTS(perObjectLightIndex, positionWS, positionCS);
                light.color = color;
                light.type = lightPositionWS.w;

                // In case we're using light probes, we can sample the attenuation from the `unity_ProbesOcclusion`
#if defined(LIGHTMAP_ON) || defined(_MIXED_LIGHTING_SUBTRACTIVE)
                // First find the probe channel from the light.
                // Then sample `unity_ProbesOcclusion` for the baked occlusion.
                // If the light is not baked, the channel is -1, and we need to apply no occlusion.

                // probeChannel is the index in 'unity_ProbesOcclusion' that holds the proper occlusion value.
                int probeChannel = lightOcclusionProbeInfo.x;

                // lightProbeContribution is set to 0 if we are indeed using a probe, otherwise set to 1.
                half lightProbeContribution = lightOcclusionProbeInfo.y;

                half probeOcclusionValue = unity_ProbesOcclusion[probeChannel];
                light.distanceAttenuation *= max(probeOcclusionValue, lightProbeContribution);
#endif

                return light;
            }

            // Fills a light struct given a loop i index. This will convert the i
// index to a perObjectLightIndex
            UtsLight GetAdditionalUtsLight(uint i, float3 positionWS,float4 positionCS)
            {
                int perObjectLightIndex = GetPerObjectLightIndex(i);
                return GetAdditionalPerObjectUtsLight(perObjectLightIndex, positionWS, positionCS);
            }

            half3 GetLightColor(UtsLight light)
            {
                return light.color * light.distanceAttenuation;
            }


#define INIT_UTSLIGHT(utslight) \
            utslight.direction = 0; \
            utslight.color = 0; \
            utslight.distanceAttenuation = 0; \
            utslight.shadowAttenuation = 0; \
            utslight.type = 0


            int DetermineUTS_MainLightIndex(float3 posW, float4 shadowCoord, float4 positionCS)
            {
                UtsLight mainLight;
                INIT_UTSLIGHT(mainLight);

                int mainLightIndex = -2;
                UtsLight nextLight = GetMainUtsLight(shadowCoord, positionCS);
                if (nextLight.distanceAttenuation > mainLight.distanceAttenuation && nextLight.type == 0)
                {
                    mainLight = nextLight;
                    mainLightIndex = -1;
                }
                int lightCount = GetAdditionalLightsCount();
                for (int ii = 0; ii < lightCount; ++ii)
                {
                    nextLight = GetAdditionalUtsLight(ii, posW, positionCS);
                    if (nextLight.distanceAttenuation > mainLight.distanceAttenuation && nextLight.type == 0)
                    {
                        mainLight = nextLight;
                        mainLightIndex = ii;
                    }
                }

                return mainLightIndex;
            }

            UtsLight GetMainUtsLightByID(int index,float3 posW, float4 shadowCoord, float4 positionCS)
            {
                UtsLight mainLight;
                INIT_UTSLIGHT(mainLight);
                if (index == -2)
                {
                    return mainLight;
                }
                if (index == -1)
                {
                    return GetMainUtsLight(shadowCoord, positionCS);
                }
                return GetAdditionalUtsLight(index, posW, positionCS);
            }

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.uv0 = v.texcoord0;
//v.2.0.4
#ifdef _IS_ANGELRING_OFF
//
#elif _IS_ANGELRING_ON
                o.uv1 = v.texcoord1;
#endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);

                //o.pos = UnityObjectToClipPos( v.vertex );
				o.pos = perspectiveRemoval(v.vertex);
                //v.2.0.7 鏡の中判定（右手座標系か、左手座標系かの判定）o.mirrorFlag = -1 なら鏡の中.
                float3 crossFwd = cross(UNITY_MATRIX_V[0], UNITY_MATRIX_V[1]);
                o.mirrorFlag = dot(crossFwd, UNITY_MATRIX_V[2]) < 0 ? 1 : -1;
                //

                float3 positionWS = TransformObjectToWorld(v.vertex);
                float4 positionCS = TransformWorldToHClip(positionWS);
                half3 vertexLight = VertexLighting(o.posWorld, o.normalDir);
                half fogFactor = ComputeFogFactor(positionCS.z);

                OUTPUT_LIGHTMAP_UV(v.lightmapUV, unity_LightmapST, o.lightmapUV);
                OUTPUT_SH(o.normalDir.xyz, o.vertexSH);

                o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				o.positionCS = positionCS;
				

  #if defined(_MAIN_LIGHT_SHADOWS) && !defined(_RECEIVE_SHADOWS_OFF)
    #if SHADOWS_SCREEN
                o.shadowCoord = ComputeScreenPos(positionCS);
    #else
                o.shadowCoord = TransformWorldToShadowCoord(o.posWorld);
    #endif
                o.mainLightID = DetermineUTS_MainLightIndex(o.posWorld, o.shadowCoord, positionCS);
  #else
                o.mainLightID = DetermineUTS_MainLightIndex(o.posWorld, 0, positionCS);
  #endif

			#ifdef _IS_CLIPPING_MODE
				ADVANCED_DISSOLVE_INIT_DATA(positionCS, v.texcoord0.xy, v.lightmapUV.xy, o);
			#endif

                return o;
            }



#if defined(_SHADINGGRADEMAP)
#include "UniversalToonBodyShadingGradeMap_Dissovle.hlsl"
#else //#if defined(_SHADINGGRADEMAP)
#include "UniversalToonBodyDoubleShadeWithFeather_Dissovle.hlsl"
#endif //#if defined(_SHADINGGRADEMAP)

            float4 frag(VertexOutput i, fixed facing : VFACE) : SV_TARGET
            {
#if defined(_SHADINGGRADEMAP)
                    return fragShadingGradeMap(i, facing);
#else
                    return fragDoubleShadeFeather(i, facing);
#endif
            }
