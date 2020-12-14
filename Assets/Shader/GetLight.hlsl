#ifndef MYHLSLINCLUDE_INCLUDED
#define MYHLSLINCLUDE_INCLUDED

void GetLight_float(out float3 lightDir, out float3 lightColor) {
	#if SHADERGRAPH_PREVIEW // preview������ default
		lightDir = half3(0.5f, 0.5f, 0.0f);
		lightColor = 1;
	#else
		Light light = GetMainLight();
		lightDir = light.direction;
		lightColor = light.color;
	#endif
}

/**
* worldPos : ���� �ȼ� ������

* lightDir : ���� ����Ʈ ���� ����
* lightColor0 : ���� ����Ʈ �÷�
* distanceAtten : �ø�����ũ�� ���� �ø��Ǹ� 1, �ƴϸ� 0 (NoȮ��)
* shadowAtten : Cast Shadow ��
**/
void CustomLight_half(float3 worldPos, out half3 lightDir, out half3 lightColor0, out half distanceAtten, out half shadowAtten)
{
#if SHADERGRAPH_PREVIEW			//! ���̴� �׷��� �����信�� ���̴� ���
	lightDir = half3(0.5, 0.5, 0);
	lightColor0 = 1;
	distanceAtten = 1;
	shadowAtten = 1;
#else

#if SHADOWS_SCREEN	//! Screen Space Shadow ����Ҷ� (NoȮ��)
	half4 clipPos = TransformWorldToHClip(worldPos);
	half4 shadowCoord = ComputeScreenPos(clipPos);
#else
	half4 shadowCoord = TransformWorldToShadowCoord(worldPos);	//! ���� ������ǥ�� �׸��� ���� ��ǥ�� ��ȯ�ϴ� �Լ� (NoȮ��)
#endif

	Light mainLight = GetMainLight();			//! Lighting.hlsl �Լ��� ����Ʈ ���� �� ������ ������ ����ü ����
	lightDir = normalize(mainLight.direction);	//! ���� ����Ʈ ����
	lightColor0 = mainLight.color;				//! ���� ����Ʈ Į��

	distanceAtten = mainLight.distanceAttenuation;	//! �ø�����ũ�� ���� �ø��Ǹ� 1, �ƴϸ� 0 (NoȮ��), ����Ʈ�� ��Ȳ���� �ٸ�
	//shadowAtten = mainLight.shadowAttenuation;	//! < error
	ShadowSamplingData shadowSamplingData = GetMainLightShadowSamplingData();	//! ������ ���谪
	half4 shadowParams = GetMainLightShadowParams();
	shadowAtten = SampleShadowmap(TEXTURE2D_ARGS(_MainLightShadowmapTexture, sampler_MainLightShadowmapTexture), TransformWorldToShadowCoord(worldPos), shadowSamplingData, shadowParams, false);
#endif
}
#endif