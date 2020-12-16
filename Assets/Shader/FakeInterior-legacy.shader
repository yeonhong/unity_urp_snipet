Shader "Custom/FakeInterior-legacy"
{
	Properties
	{
		[NoScaleOffset]_MainTex("MainTex",2D) = "white"{}
		_Color("Color", Color) = (1,1,1,1)
		_RoomCube("Albedo (RGB)",CUBE) = "" {}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows 
		#pragma target 3.0

		sampler2D _MainTex;
		samplerCUBE _RoomCube;
		float4 _RoomCube_ST;
		fixed4 _Color;

		struct Input
		{
			float2 uv_MainTex;
			float3 viewDir;
			INTERNAL_DATA
		};

		// psuedo random
		float2 rand2(float co) {
			return frac(sin(co * float2(12.9898, 78.233)) * 43758.5453);
		}

		void surf(Input IN, inout SurfaceOutputStandard o)
		{

			//room UV and index UV 
			float2 roomUV = frac(IN.uv_MainTex*_RoomCube_ST.xy);
			float2 roomIndexUV = floor(IN.uv_MainTex*_RoomCube_ST.xy) + 1;

			// randomize the room
			/*float2 n = (rand2(roomIndexUV.x + roomIndexUV.y * (roomIndexUV.x + 1)) * _RoomCube_ST.xy);
			roomIndexUV += n;*/
			roomIndexUV = frac(roomIndexUV);


			//raytrance box from tangent view dir . aabb 
			float3 viewD = normalize(-IN.viewDir);
			float3 pos = float3(roomUV * 2.0 - 1.0, 1.1 - roomIndexUV.x);
			float3 id = 1.0 / (viewD + 0.00001);
			float3 k = abs(id) - pos * id;
			float kMin = min(min(k.x, k.y),k.z);
			pos += kMin * viewD;

			//Random Room Left and Right riversal 
			pos.x = roomIndexUV > 0.5 ? pos.x : -pos.x;

			//room Tex
			fixed4 room = texCUBE(_RoomCube, pos.xyz);
			//room random color
			room.rgb *= clamp(roomIndexUV.yyx, 0.2, 1);

			//window and outwall texture
			float4 tex = tex2D(_MainTex, roomUV);

			o.Normal = float3(0, 0, 1); //using normal for tangent calculation 
			o.Albedo = tex.rgb;
			o.Smoothness = 1 - tex.a;
			o.Emission = room.rgb * (1 - tex.a);
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
