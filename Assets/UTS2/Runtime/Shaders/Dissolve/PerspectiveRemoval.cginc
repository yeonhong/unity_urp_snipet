float _ZOffset;
float _PerspectiveRemovalAmount;
float _PerspectiveRemovalRadius;
float _PerspectiveRemovalStartHeight;
float _PerspectiveRemovalEndHeight;
float4 _HeadBonePositionWS;

float4 perspectiveRemoval(float4 pos) {

	float2 u_xlat0;
	float3 u_xlat6;
	float u_xlat12;
	float4 u_xlat4;
	float4 u_xlat3;
	float u_xlat16_5;

	u_xlat0.x = UNITY_MATRIX_V[1].z * _HeadBonePositionWS.y;
	u_xlat0.x = UNITY_MATRIX_V[0].z * _HeadBonePositionWS.x + u_xlat0.x;
	u_xlat0.x = UNITY_MATRIX_V[2].z * _HeadBonePositionWS.z + u_xlat0.x;
	u_xlat0.x = u_xlat0.x + UNITY_MATRIX_V[3].z;
	u_xlat0.x = 1 / abs(u_xlat0.x);
		
	float4 u_xlat1 = mul(unity_ObjectToWorld, pos.xyz);
	float4 u_xlat2 = TransformObjectToHClip(pos.xyz);

	u_xlat6.x = _ProjectionParams.y + 5.96046448e-08;
	u_xlat12 = abs(u_xlat2.w) + _ZOffset;
	u_xlat6.x = max(u_xlat12, u_xlat6.x);
	u_xlat12 = (-u_xlat6.x) * UNITY_MATRIX_P[2].z + UNITY_MATRIX_P[3].z;
	u_xlat12 = u_xlat2.w * u_xlat12;
	u_xlat3.z = u_xlat12 / u_xlat6.x;

	u_xlat12 = (-_ProjectionParams.y) + _ProjectionParams.z;
	u_xlat12 = (-_ZOffset) / u_xlat12;
	u_xlat2.z = (u_xlat12 * -2.0) + u_xlat2.z;

	u_xlat6.xz = abs(u_xlat2.ww) * u_xlat2.xy;
	u_xlat0.xy = u_xlat6.xz * u_xlat0.xx + (-u_xlat2.xy);

	u_xlat1.xzw = u_xlat1.xyz + (-_HeadBonePositionWS.xyz);
	u_xlat16_5 = u_xlat1.y + (-_PerspectiveRemovalStartHeight);
	float u_xlat18 = dot(u_xlat1.xzw, u_xlat1.xzw);
	u_xlat18 = sqrt(u_xlat18);
	u_xlat18 = u_xlat18 / _PerspectiveRemovalRadius;
	u_xlat18 = (-u_xlat18) + _PerspectiveRemovalRadius;

	u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
	u_xlat18 = u_xlat18 * _PerspectiveRemovalAmount;
	float u_xlat16_11 = (-_PerspectiveRemovalStartHeight) + _PerspectiveRemovalEndHeight;
	u_xlat16_5 = u_xlat16_5 / u_xlat16_11;
	u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
	u_xlat18 = u_xlat18 * u_xlat16_5;
	u_xlat0.xy *= u_xlat18;
	u_xlat0.xy += u_xlat2.xy;

	pos.xy = (unity_OrthoParams.w == 1.0) ? u_xlat2.xy : u_xlat0.xy;
	pos.zw = u_xlat2.zw;
	return pos;
}
