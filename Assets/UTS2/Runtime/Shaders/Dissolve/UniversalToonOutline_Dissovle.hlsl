//UTS2/UniversalToon
//v.2.2.0
//nobuyuki@unity3d.com
//toshiyui@unity3d.com (universal RP)
//https://github.com/unity3d-jp/UnityChanToonShaderVer2_Project
//(C)Unity Technologies Japan/UCL
// 2018/08/23 N.Kobayashi (Unity Technologies Japan)
// カメラオフセット付きアウトライン（BaseColorライトカラー反映修正版）
// 2017/06/05 PS4対応版
// Ver.2.0.4.3
// 2018/02/05 Outline Tex対応版
// #pragma multi_compile _IS_OUTLINE_CLIPPING_NO _IS_OUTLINE_CLIPPING_YES 
// _IS_OUTLINE_CLIPPING_YESは、Clippigマスクを使用するシェーダーでのみ使用できる. OutlineのブレンドモードにBlend SrcAlpha OneMinusSrcAlphaを追加すること.
//

uniform float4 _LightColor0;
//uniform float4 _BaseColor;
//v.2.0.7.5
uniform float _Unlit_Intensity;
uniform fixed _Is_Filter_LightColor;
uniform fixed _Is_LightColor_Outline;
//v.2.0.5
uniform float4 _Color;
uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
uniform float _Outline_Width;
uniform float _Outline_MaxWidth;
uniform float _Farthest_Distance;
uniform float _Nearest_Distance;
uniform sampler2D _Outline_Sampler; uniform float4 _Outline_Sampler_ST;
uniform float4 _Outline_Color;
uniform fixed _Is_BlendBaseColor;
uniform fixed _Is_OutlineSizeFix;
uniform float _Offset_Z;
//v2.0.4
uniform sampler2D _OutlineTex; uniform float4 _OutlineTex_ST;
uniform fixed _Is_OutlineTex;
//Baked Normal Texture for Outline
uniform sampler2D _BakedNormal; uniform float4 _BakedNormal_ST;
uniform fixed _Is_BakedNormal;

uniform float _ZOverDrawMode;

struct VertexInput {
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float2 texcoord0 : TEXCOORD0;
};

struct VertexOutput {
	float4 pos : SV_POSITION;
	float2 uv0 : TEXCOORD0;
	float3 normalDir : TEXCOORD1;
	float3 tangentDir : TEXCOORD2;
	float3 bitangentDir : TEXCOORD3;
	float4 posWorld : TEXCOORD4;
	ADVANCED_DISSOLVE_DATA(5)
};

VertexOutput vert(VertexInput v) {
	VertexOutput o = (VertexOutput)0;
	o.uv0 = v.texcoord0;
	float4 objPos = mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
	float2 Set_UV0 = o.uv0;
	float4 _Outline_Sampler_var = tex2Dlod(_Outline_Sampler, float4(TRANSFORM_TEX(Set_UV0, _Outline_Sampler), 0.0, 0));
	//v.2.0.4.3 baked Normal Texture for Outline
	o.normalDir = UnityObjectToWorldNormal(v.normal);
	o.tangentDir = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
	o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
	o.posWorld = mul(unity_ObjectToWorld, v.vertex);
	float3x3 tangentTransform = float3x3(o.tangentDir, o.bitangentDir, o.normalDir);
	//UnpackNormal()が使えないので、以下で展開。使うテクスチャはBump指定をしないこと.
	float4 _BakedNormal_var = (tex2Dlod(_BakedNormal, float4(TRANSFORM_TEX(Set_UV0, _BakedNormal), 0.0, 0)) * 2 - 1);
	float3 _BakedNormalDir = normalize(mul(_BakedNormal_var.rgb, tangentTransform));

	//ここまで.
	float Set_Outline_Width = (_Outline_Width * 0.001 * 
		smoothstep(_Farthest_Distance, 
			_Nearest_Distance, 
			distance(objPos.rgb, _WorldSpaceCameraPos)
		)*_Outline_Sampler_var.rgb).r;
	Set_Outline_Width *= (1.0f - _ZOverDrawMode);

	//v.2.0.7.5
	float4 _ClipCameraPos = mul(UNITY_MATRIX_VP, float4(_WorldSpaceCameraPos.xyz, 1));

	//v.2.0.7
#if defined(UNITY_REVERSED_Z)
	//v.2.0.4.2 (DX)
	_Offset_Z = _Offset_Z * -0.01;
#else
	//OpenGL
	_Offset_Z = _Offset_Z * 0.01;
#endif

	//v2.0.4
#ifdef _OUTLINE_NML
	//v.2.0.4.3 baked Normal Texture for Outline
	//o.pos = UnityObjectToClipPos(
	//	lerp(	float4(v.vertex.xyz + v.normal * Set_Outline_Width, 1), 
	//			float4(v.vertex.xyz + _BakedNormalDir * Set_Outline_Width, 1), 
	//			_Is_BakedNormal)
	//		);
	o.pos = perspectiveRemoval(
		lerp(float4(v.vertex.xyz + v.normal * Set_Outline_Width, 1),
			float4(v.vertex.xyz + _BakedNormalDir * Set_Outline_Width, 1),
			_Is_BakedNormal)
		);
#elif _OUTLINE_MAX
	//o.pos = UnityObjectToClipPos(v.vertex);
	o.pos = perspectiveRemoval(v.vertex);

	float outlineWidth = _Outline_Width * o.pos.w;
	outlineWidth = min(outlineWidth, _Outline_MaxWidth) * _Outline_Sampler_var.r;

	float3 clipNormal = mul((float3x3)UNITY_MATRIX_MVP, lerp(v.normal, _BakedNormalDir, _Is_BakedNormal)).xyz;
	float2 offset = normalize(clipNormal.xy) / _ScreenParams.xy * outlineWidth;
	o.pos.xy += offset;
#elif _OUTLINE_POS
	Set_Outline_Width = Set_Outline_Width * 2;
	float signVar = dot(normalize(v.vertex), normalize(v.normal)) < 0 ? -1 : 1;
	//o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + signVar * normalize(v.vertex) * Set_Outline_Width, 1));
	o.pos = perspectiveRemoval(float4(v.vertex.xyz + signVar * normalize(v.vertex) * Set_Outline_Width, 1));
#endif
	//v.2.0.7.5
	o.pos.z = o.pos.z + _Offset_Z * _ClipCameraPos.z;

#ifdef _IS_OUTLINE_CLIPPING_YES
	float3 positionWS = TransformObjectToWorld(v.vertex);
	float4 positionCS = TransformWorldToHClip(positionWS);
	ADVANCED_DISSOLVE_INIT_DATA(positionCS, v.texcoord0.xy, v.texcoord0.xy, o);
#endif
	return o;
}

float4 frag(VertexOutput i) : SV_Target{
	//v.2.0.5
	if (_ZOverDrawMode > 0.99f) {
		return float4(1.0f, 1.0f, 1.0f, 1.0f);  // but nothing should be drawn except Z value as colormask is set to 0
	}
	_Color = _BaseColor;
	float4 objPos = mul(unity_ObjectToWorld, float4(0,0,0,1));
	//v.2.0.7.5
	half3 ambientSkyColor = unity_AmbientSky.rgb > 0.05 ? unity_AmbientSky.rgb*_Unlit_Intensity : half3(0.05,0.05,0.05)*_Unlit_Intensity;
	float3 lightColor = _LightColor0.rgb > 0.05 ? _LightColor0.rgb : ambientSkyColor.rgb;
	float lightColorIntensity = (0.299*lightColor.r + 0.587*lightColor.g + 0.114*lightColor.b);
	lightColor = lightColorIntensity < 1 ? lightColor : lightColor / lightColorIntensity;
	lightColor = lerp(half3(1.0,1.0,1.0), lightColor, _Is_LightColor_Outline);
	float2 Set_UV0 = i.uv0;
	float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(Set_UV0, _MainTex));
	float3 Set_BaseColor = _BaseColor.rgb*_MainTex_var.rgb;
	float3 _Is_BlendBaseColor_var = lerp(_Outline_Color.rgb*lightColor, (_Outline_Color.rgb*Set_BaseColor*Set_BaseColor*lightColor), _Is_BlendBaseColor);
	//
	float3 _OutlineTex_var = tex2D(_OutlineTex,TRANSFORM_TEX(Set_UV0, _OutlineTex));

	//v.2.0.7.5
#ifdef _IS_OUTLINE_CLIPPING_NO
	float3 Set_Outline_Color = lerp(_Is_BlendBaseColor_var, _OutlineTex_var.rgb*_Outline_Color.rgb*lightColor, _Is_OutlineTex);
	return float4(Set_Outline_Color,1.0);
	
#elif _IS_OUTLINE_CLIPPING_YES
	float4 dissolaveAlpha = AdvancedDissolveGetAlpha(i.uv0.xy, i.posWorld.xyz, i.normalDir, i.dissolveUV);
	DoDissolveClip(dissolaveAlpha);
	float3 dissolveAlbedo = 0;
	float3 dissolveEmission = 0;
	float dissolveBlend = DoDissolveAlbedoEmission(dissolaveAlpha, dissolveAlbedo, dissolveEmission, i.uv0.xy, 1);

	float3 Set_Outline_Color = lerp(_OutlineTex_var.rgb*_Outline_Color.rgb*lightColor, dissolveAlbedo, dissolveBlend);
	return float4(Set_Outline_Color, 1.0);
#endif
}
// UCTS_Outline.cginc ここまで.
