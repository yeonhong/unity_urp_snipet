//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Universal Render Pipeline/NiloToon/NiloToon_Character Sticker(Multiply)" {
Properties {
_BaseMap ("_BaseMap (Albedo) (Default White)", 2D) = "white" { }
_BaseColor ("_BaseColor (Default White)", Color) = (1,1,1,1)
[Toggle(OVERRIDE_ALPHA)] _OverrideAlpha ("_OverrideAlpha (Default Off)", Float) = 0
_OverrideAlphaMap ("_OverrideAlphaMap (Default White)", 2D) = "white" { }
[Header(Polygon Face Culling)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("_Cull (Default Off)", Float) = 0
[Header(ZOffset)] _ZOffset ("_ZOffset (Default 0)", Range(-1, 1)) = -0.1
_CharacterBoundCenterPosWS ("_CharacterBoundCenterPosWS", Vector) = (0,0,0,1)
_DitherOpacity ("_DitherOpacity", Range(0, 1)) = 0

_PerspectiveRemovalAmount ("_PerspectiveRemovalAmount", Range(0, 1)) = 0
_PerspectiveRemovalRadius ("_PerspectiveRemovalRadius", Float) = 1
_HeadBonePositionWS ("_HeadBonePositionWS", Vector) = (0,0,0,1)
_PerspectiveRemovalStartHeight ("_PerspectiveRemovalStartHeight", Float) = 0
_PerspectiveRemovalEndHeight ("_PerspectiveRemovalEndHeight", Float) = 1

_MainTex ("BaseMap", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "AlphaTest+1" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "AlphaTest+1" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Transparent" }
  Blend DstColor Zero, DstColor Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 19390
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));

    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;

    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    
	u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    
	// u_xlat12
	u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
    
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;

    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat2 = u_xlat3;
    u_xlat6.xz = abs(u_xlat2.ww) * u_xlat2.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat2.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
	
	// u_xlat18
	u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;

    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;

    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat2.xy;
    
	
	gl_Position.xy = u_xlat2.xy
    gl_Position.zw = u_xlat2.zw;







    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec3 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlatb5.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    if(!u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb5.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat15 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat15 = (-_ZOffset) / u_xlat15;
        u_xlat15 = u_xlat15 * -2.0 + u_xlat2.z;
        u_xlat16 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat3 = abs(u_xlat2.w) + _ZOffset;
        u_xlat16 = max(u_xlat16, u_xlat3);
        u_xlat3 = (-u_xlat16) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat3 = u_xlat2.w * u_xlat3;
        u_xlat16 = u_xlat3 / u_xlat16;
        u_xlat2.z = (u_xlatb5.x) ? u_xlat15 : u_xlat16;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb5.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb5.x = u_xlatb5.x || u_xlatb5.y;
    if(!u_xlatb5.x){
        u_xlat5.xyz = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x / _PerspectiveRemovalRadius;
        u_xlat5.x = (-u_xlat5.x) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x * _PerspectiveRemovalAmount;
        u_xlat5.x = u_xlat16_4 * u_xlat5.x;
        u_xlat10.x = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat10.x;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat10.x;
        u_xlat0.x = u_xlat10.x + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat10.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xz = u_xlat10.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = u_xlat5.xx * u_xlat0.xz + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = 0.0;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat2 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.xz = abs(u_xlat2.ww) * u_xlat2.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat2.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat2.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec3 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlatb5.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    if(!u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb5.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat15 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat15 = (-_ZOffset) / u_xlat15;
        u_xlat15 = u_xlat15 * -2.0 + u_xlat2.z;
        u_xlat16 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat3 = abs(u_xlat2.w) + _ZOffset;
        u_xlat16 = max(u_xlat16, u_xlat3);
        u_xlat3 = (-u_xlat16) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat3 = u_xlat2.w * u_xlat3;
        u_xlat16 = u_xlat3 / u_xlat16;
        u_xlat2.z = (u_xlatb5.x) ? u_xlat15 : u_xlat16;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb5.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb5.x = u_xlatb5.x || u_xlatb5.y;
    if(!u_xlatb5.x){
        u_xlat5.xyz = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x / _PerspectiveRemovalRadius;
        u_xlat5.x = (-u_xlat5.x) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x * _PerspectiveRemovalAmount;
        u_xlat5.x = u_xlat16_4 * u_xlat5.x;
        u_xlat10.x = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat10.x;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat10.x;
        u_xlat0.x = u_xlat10.x + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat10.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xz = u_xlat10.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = u_xlat5.xx * u_xlat0.xz + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = 0.0;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat2 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.xz = abs(u_xlat2.ww) * u_xlat2.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat2.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat2.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec3 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlatb5.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    if(!u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb5.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat15 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat15 = (-_ZOffset) / u_xlat15;
        u_xlat15 = u_xlat15 * -2.0 + u_xlat2.z;
        u_xlat16 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat3 = abs(u_xlat2.w) + _ZOffset;
        u_xlat16 = max(u_xlat16, u_xlat3);
        u_xlat3 = (-u_xlat16) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat3 = u_xlat2.w * u_xlat3;
        u_xlat16 = u_xlat3 / u_xlat16;
        u_xlat2.z = (u_xlatb5.x) ? u_xlat15 : u_xlat16;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb5.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb5.x = u_xlatb5.x || u_xlatb5.y;
    if(!u_xlatb5.x){
        u_xlat5.xyz = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x / _PerspectiveRemovalRadius;
        u_xlat5.x = (-u_xlat5.x) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x * _PerspectiveRemovalAmount;
        u_xlat5.x = u_xlat16_4 * u_xlat5.x;
        u_xlat10.x = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat10.x;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat10.x;
        u_xlat0.x = u_xlat10.x + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat10.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xz = u_xlat10.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = u_xlat5.xx * u_xlat0.xz + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = 0.0;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat2 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.xz = abs(u_xlat2.ww) * u_xlat2.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat2.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat2.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec3 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlatb5.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    if(!u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb5.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat15 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat15 = (-_ZOffset) / u_xlat15;
        u_xlat15 = u_xlat15 * -2.0 + u_xlat2.z;
        u_xlat16 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat3 = abs(u_xlat2.w) + _ZOffset;
        u_xlat16 = max(u_xlat16, u_xlat3);
        u_xlat3 = (-u_xlat16) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat3 = u_xlat2.w * u_xlat3;
        u_xlat16 = u_xlat3 / u_xlat16;
        u_xlat2.z = (u_xlatb5.x) ? u_xlat15 : u_xlat16;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb5.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb5.x = u_xlatb5.x || u_xlatb5.y;
    if(!u_xlatb5.x){
        u_xlat5.xyz = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x / _PerspectiveRemovalRadius;
        u_xlat5.x = (-u_xlat5.x) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x * _PerspectiveRemovalAmount;
        u_xlat5.x = u_xlat16_4 * u_xlat5.x;
        u_xlat10.x = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat10.x;
        u_xlat10.x = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat10.x;
        u_xlat0.x = u_xlat10.x + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat10.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xz = u_xlat10.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = u_xlat5.xx * u_xlat0.xz + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = 0.0;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.x;
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_1.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_1.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.x;
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_1.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_1.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.x;
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.x;
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.x;
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_1 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.x;
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_1 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bvec2 u_xlatb6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[1].z * _HeadBonePositionWS.y;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * _HeadBonePositionWS.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * _HeadBonePositionWS.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
    u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = abs(u_xlat2.w) + _ZOffset;
    u_xlat6.x = max(u_xlat12, u_xlat6.x);
    u_xlat12 = (-u_xlat6.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat12 = u_xlat2.w * u_xlat12;
    u_xlat3.z = u_xlat12 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
    u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat12 = (-_ZOffset) / u_xlat12;
    u_xlat4.z = u_xlat12 * -2.0 + u_xlat2.z;
    u_xlat4.xyw = u_xlat2.xyw;
    u_xlat3.xyw = u_xlat4.xyw;
    u_xlat3 = (u_xlatb6.x) ? u_xlat4 : u_xlat3;
    u_xlatb6.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonZOffset)).xy;
    u_xlat3 = (u_xlatb6.x) ? u_xlat2 : u_xlat3;
    u_xlat6.x = u_xlat2.z * unity_FogParams.x;
    vs_TEXCOORD1 = u_xlat6.x;
    u_xlat6.xz = abs(u_xlat3.ww) * u_xlat3.xy;
    u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat3.xy);
    u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
    u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
    u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
    u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
    u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
    u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * u_xlat16_5;
    u_xlat0.xy = vec2(u_xlat18) * u_xlat0.xy + u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb18 = unity_OrthoParams.w==1.0;
#endif
    u_xlatb12 = u_xlatb18 || u_xlatb6.y;
    gl_Position.xy = (bool(u_xlatb12)) ? u_xlat3.xy : u_xlat0.xy;
    gl_Position.zw = u_xlat3.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es
#extension GL_OVR_multiview2 : require

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_FogParams;
uniform 	float _GlobalShouldDisableNiloToonZOffset;
uniform 	float _GlobalShouldDisableNiloToonPerspectiveRemoval;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_LightmapIndex;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityStereoViewBuffer {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoMatrixInvVP[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
	UNITY_UNIFORM vec3 unity_StereoWorldSpaceCameraPos[2];
	UNITY_UNIFORM vec4 unity_StereoScaleOffset[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform UnityStereoEyeIndices {
#endif
	UNITY_UNIFORM vec4 unity_StereoEyeIndices[2];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(num_views = 2) in;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
vec4 u_xlat0;
int u_xlati0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
    u_xlat5 = u_xlat2.z * unity_FogParams.x;
    u_xlatb10.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval, _GlobalShouldDisableNiloToonZOffset, _GlobalShouldDisableNiloToonPerspectiveRemoval)).xy;
    if(!u_xlatb10.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w));
#else
        u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_OrthoParams.w);
#endif
        u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
        u_xlat16 = (-_ZOffset) / u_xlat16;
        u_xlat16 = u_xlat16 * -2.0 + u_xlat2.z;
        u_xlat3 = _ProjectionParams.y + 5.96046448e-08;
        u_xlat8 = abs(u_xlat2.w) + _ZOffset;
        u_xlat3 = max(u_xlat8, u_xlat3);
        u_xlat8 = (-u_xlat3) * hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 2)].z + hlslcc_mtx4x4unity_StereoMatrixP[(u_xlati0 + 3)].z;
        u_xlat8 = u_xlat2.w * u_xlat8;
        u_xlat3 = u_xlat8 / u_xlat3;
        u_xlat2.z = (u_xlatb10.x) ? u_xlat16 : u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(unity_OrthoParams.w==1.0);
#else
    u_xlatb10.x = unity_OrthoParams.w==1.0;
#endif
    u_xlatb10.x = u_xlatb10.x || u_xlatb10.y;
    if(!u_xlatb10.x){
        u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
        u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat10 = sqrt(u_xlat10);
        u_xlat10 = u_xlat10 / _PerspectiveRemovalRadius;
        u_xlat10 = (-u_xlat10) + _PerspectiveRemovalRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
        u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
        u_xlat16_9 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
        u_xlat16_4 = u_xlat16_4 / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
        u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
        u_xlat10 = u_xlat10 * _PerspectiveRemovalAmount;
        u_xlat10 = u_xlat16_4 * u_xlat10;
        u_xlat15 = _HeadBonePositionWS.y * hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 1)].z;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[u_xlati0].z * _HeadBonePositionWS.x + u_xlat15;
        u_xlat15 = hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 2)].z * _HeadBonePositionWS.z + u_xlat15;
        u_xlat0.x = u_xlat15 + hlslcc_mtx4x4unity_StereoMatrixV[(u_xlati0 + 3)].z;
        u_xlat1.xy = abs(u_xlat2.ww) * u_xlat2.xy;
        u_xlat0.x = float(1.0) / float(abs(u_xlat0.x));
        u_xlat0.xw = u_xlat1.xy * u_xlat0.xx + (-u_xlat2.xy);
        u_xlat2.xy = vec2(u_xlat10) * u_xlat0.xw + u_xlat2.xy;
    }
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    gl_Position = u_xlat2;
    vs_TEXCOORD1 = u_xlat5;
    u_xlatu0 = gl_ViewID_OVR;
    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_1.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_1.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_1.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_1.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_1 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_1 = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_0.w * _BaseColor.w;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "STEREO_MULTIVIEW_ON" "_NILOTOON_FORCE_MINIMUM_SHADER" }
Local Keywords { "OVERRIDE_ALPHA" "_NILOTOON_DITHER_FADEOUT" }
"#ifdef VERTEX
#version 300 es

out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out highp float vs_BLENDWEIGHT0;
void main()
{
    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
    phase0_Output0_1.xyw = vec3(0.0, 0.0, 0.0);
    phase0_Output0_1.z = 0.0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
vs_BLENDWEIGHT0 = phase0_Output0_1.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM float _PerspectiveRemovalAmount;
	UNITY_UNIFORM float _PerspectiveRemovalRadius;
	UNITY_UNIFORM vec3 _HeadBonePositionWS;
	UNITY_UNIFORM float _PerspectiveRemovalStartHeight;
	UNITY_UNIFORM float _PerspectiveRemovalEndHeight;
	UNITY_UNIFORM float _DitherOpacity;
	UNITY_UNIFORM float _ZOffset;
	UNITY_UNIFORM mediump float _FadeoutByBaseMapAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _OverrideAlphaMap;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
vec4 TempArray0[16];
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    TempArray0[0].x = 0.0588235296;
    TempArray0[1].x = 0.529411793;
    TempArray0[2].x = 0.176470593;
    TempArray0[3].x = 0.647058845;
    TempArray0[4].x = 0.764705896;
    TempArray0[5].x = 0.294117659;
    TempArray0[6].x = 0.882352948;
    TempArray0[7].x = 0.411764711;
    TempArray0[8].x = 0.235294119;
    TempArray0[9].x = 0.70588237;
    TempArray0[10].x = 0.117647059;
    TempArray0[11].x = 0.588235319;
    TempArray0[12].x = 0.941176474;
    TempArray0[13].x = 0.470588237;
    TempArray0[14].x = 0.823529422;
    TempArray0[15].x = 0.352941185;
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlati0 = int(int_bitfieldInsert(0,int(u_xlatu0.x),2,2) );
    u_xlati0 = int(int_bitfieldInsert(u_xlati0,int(u_xlatu0.y),0,2) );
    u_xlat0 = TempArray0[u_xlati0].x;
    u_xlat0 = (-u_xlat0) + _DitherOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat16_0.x = texture(_OverrideAlphaMap, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat16_0.x * _BaseColor.w;
    u_xlat16_3.x = vs_TEXCOORD1 * (-vs_TEXCOORD1);
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_1 = u_xlat16_3.x * u_xlat16_1;
    u_xlat16_0.xyz = texture(_BaseMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _BaseColor.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}