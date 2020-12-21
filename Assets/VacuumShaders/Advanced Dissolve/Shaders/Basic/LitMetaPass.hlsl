#ifndef UNIVERSAL_LIT_META_PASS_INCLUDED
#define UNIVERSAL_LIT_META_PASS_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

struct Attributes
{
    float4 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float2 uv0          : TEXCOORD0;
    float2 uv1          : TEXCOORD1;
    float2 uv2          : TEXCOORD2;
#ifdef _TANGENT_TO_WORLD
    float4 tangentOS     : TANGENT;
#endif
};

struct Varyings
{
    float4 positionCS   : SV_POSITION;
    float2 uv           : TEXCOORD0;

	float3 positionWS               : TEXCOORD2;
    float3 normalWS                  : TEXCOORD3;
    
    ADVANCED_DISSOLVE_DATA(4)
};

Varyings UniversalVertexMeta(Attributes input)
{
    Varyings output;
    output.positionCS = MetaVertexPosition(input.positionOS, input.uv1, input.uv2,
        unity_LightmapST, unity_DynamicLightmapST);
    output.uv = TRANSFORM_TEX(input.uv0, _BaseMap);



	output.positionWS = TransformObjectToWorld(input.positionOS.xyz);
    output.normalWS   = TransformObjectToWorldNormal(input.normalOS);

    ADVANCED_DISSOLVE_INIT_DATA(TransformWorldToHClip(output.positionWS), input.uv0.xy, input.uv1.xy, output)

    #if defined(_DISSOLVEMASK_XYZ_AXIS) || defined(_DISSOLVEMASK_PLANE) || defined(_DISSOLVEMASK_SPHERE) || defined(_DISSOLVEMASK_BOX) || defined(_DISSOLVEMASK_CYLINDER) || defined(_DISSOLVEMASK_CONE)
        output.positionWS += _Dissolve_ObjectWorldPos;
    #endif

    return output;
}

half4 UniversalFragmentMeta(Varyings input) : SV_Target
{

float4 dissolaveAlpha = AdvancedDissolveGetAlpha(input.uv.xy, input.positionWS.xyz, input.normalWS, input.dissolveUV);

float3 dissolveAlbedo = 0;
float3 dissolveEmission = 0;
float dissolveBlend = DoDissolveAlbedoEmission(dissolaveAlpha, dissolveAlbedo, dissolveEmission, input.uv.xy, 1);




    SurfaceData surfaceData;
    InitializeStandardLitSurfaceData(input.uv, surfaceData);

    BRDFData brdfData;
    InitializeBRDFData(surfaceData.albedo, surfaceData.metallic, surfaceData.specular, surfaceData.smoothness, surfaceData.alpha, brdfData);

    MetaInput metaInput;
    metaInput.Albedo = brdfData.diffuse + brdfData.specular * brdfData.roughness * 0.5;
    metaInput.SpecularColor = surfaceData.specular;
    metaInput.Emission = surfaceData.emission;


    metaInput.Albedo = lerp(metaInput.Albedo, dissolveAlbedo, dissolveBlend);
	metaInput.Emission = lerp(metaInput.Emission, dissolveEmission, dissolveBlend);

    
    return MetaFragment(metaInput);
}

//LWRP -> Universal Backwards Compatibility
Varyings LightweightVertexMeta(Attributes input)
{
    return UniversalVertexMeta(input);
}

half4 LightweightFragmentMeta(Varyings input) : SV_Target
{
    return UniversalFragmentMeta(input);
}

#endif
