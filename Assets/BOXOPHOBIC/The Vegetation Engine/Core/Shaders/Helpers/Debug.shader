// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug"
{
	Properties
	{
		[StyledBanner(Debug)]_Banner("Banner", Float) = 0
		_IsVertexShader("_IsVertexShader", Float) = 0
		_IsSimpleShader("_IsSimpleShader", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 0
		_IsStandardShader("_IsStandardShader", Float) = 0
		_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 0
		_IsPropShader("_IsPropShader", Float) = 0
		_IsBarkShader("_IsBarkShader", Float) = 0
		_IsImpostorShader("_IsImpostorShader", Float) = 0
		_IsCoreShader("_IsCoreShader", Float) = 0
		_IsPlantShader("_IsPlantShader", Float) = 0
		[NoScaleOffset]_MainNormalTex("_MainNormalTex", 2D) = "black" {}
		[NoScaleOffset]_EmissiveTex("_EmissiveTex", 2D) = "black" {}
		[NoScaleOffset]_SecondMaskTex("_SecondMaskTex", 2D) = "black" {}
		[NoScaleOffset]_SecondNormalTex("_SecondNormalTex", 2D) = "black" {}
		[NoScaleOffset]_SecondAlbedoTex("_SecondAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainAlbedoTex("_MainAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainMaskTex("_MainMaskTex", 2D) = "black" {}
		_RenderClip("_RenderClip", Float) = 0
		_IsElementShader("_IsElementShader", Float) = 0
		_IsHelperShader("_IsHelperShader", Float) = 0
		_Cutoff("_Cutoff", Float) = 0
		_DetailMode("_DetailMode", Float) = 0
		_EmissiveCat("_EmissiveCat", Float) = 0
		[HDR]_EmissiveColor("_EmissiveColor", Color) = (0,0,0,0)
		[HideInInspector][Enum(Single Pivot,0,Baked Pivots,1)]_VertexPivotMode("_VertexPivotMode", Float) = 0
		_IsBlanketShader("_IsBlanketShader", Float) = 0
		_IsPolygonalShader("_IsPolygonalShader", Float) = 0
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 40
		[IntRange]_MotionVariation_10("Primary Speed", Range( 0 , 40)) = 40
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("Enable Dynamic Support", Float) = 0
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[Enum(UV 0,0,Baked,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		_IsIdentifier("_IsIdentifier", Float) = 0
		_IsCollected("_IsCollected", Float) = 0
		_IsLiteShader("_IsLiteShader", Float) = 0
		_IsCustomShader("_IsCustomShader", Float) = 0
		[StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0)]_Message("Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
		//[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		//[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		
		Blend Off
		

		CGINCLUDE
		#pragma target 5.0

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend One Zero

			CGPROGRAM
			#define ASE_NO_AMBIENT 1
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
				#define UNITY_PASS_FORWARDBASE
			#endif
			#include "HLSLSupport.cginc"
			#ifndef UNITY_INSTANCED_LOD_FADE
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#ifndef UNITY_INSTANCED_SH
				#define UNITY_INSTANCED_SH
			#endif
			#ifndef UNITY_INSTANCED_LIGHTMAPSTS
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"

			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				#if defined(LIGHTMAP_ON) || (!defined(LIGHTMAP_ON) && SHADER_TARGET >= 30)
					float4 lmap : TEXCOORD0;
				#endif
				#if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
					half3 sh : TEXCOORD1;
				#endif
				#if defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS) && UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHTING_COORDS(2,3)
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_SHADOW_COORDS(2)
					#else
						SHADOW_COORDS(2)
					#endif
				#endif
				#ifdef ASE_FOG
					UNITY_FOG_COORDS(4)
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD8;
				#endif
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_color : COLOR;
				float4 ase_texcoord12 : TEXCOORD12;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform half _IsTVEShader;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsCollected;
			uniform float _IsBarkShader;
			uniform float _IsPlantShader;
			uniform float _IsPropShader;
			uniform float _IsCoreShader;
			uniform float _IsBlanketShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsLiteShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform float _IsCustomShader;
			uniform float _IsIdentifier;
			uniform half TVE_DEBUG_Index;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
			uniform half4 _MainUVs;
			SamplerState sampler_MainAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
			SamplerState sampler_MainNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
			SamplerState sampler_MainMaskTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			SamplerState sampler_SecondAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
			SamplerState sampler_SecondNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
			SamplerState sampler_SecondMaskTex;
			uniform float _DetailMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
			uniform half4 _EmissiveUVs;
			SamplerState sampler_EmissiveTex;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform float4 _MainAlbedoTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
			SamplerState samplerTVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
			uniform float _MotionScale_10;
			uniform half TVE_NoiseTexTilling;
			uniform half4 TVE_MotionParams;
			uniform half4 TVE_TimeParams;
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexPivotMode;
			uniform half _VertexDynamicMode;
			SamplerState sampler_Linear_Repeat;
			uniform half TVE_DEBUG_Layer;
			uniform float TVE_ColorsUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			SamplerState sampler_Linear_Clamp;
			uniform half4 TVE_ColorsParams;
			uniform float TVE_ExtrasUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_ExtrasParams;
			uniform float TVE_MotionUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform float TVE_VertexUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform half4 TVE_VertexParams;
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;


			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float Debug_Index464_g91519 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g91525 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91525 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g91543 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91543 = v.normal;
				float3 ifLocalVar40_g91556 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91556 = v.tangent.xyz;
				float ifLocalVar40_g91540 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91540 = saturate( v.tangent.w );
				float ifLocalVar40_g91640 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91640 = v.ase_color.r;
				float ifLocalVar40_g91641 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91641 = v.ase_color.g;
				float ifLocalVar40_g91642 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91642 = v.ase_color.b;
				float ifLocalVar40_g91643 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91643 = v.ase_color.a;
				float3 appendResult1147_g91519 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g91650 = 0;
				if( Debug_Index464_g91519 == 9.0 )
				ifLocalVar40_g91650 = appendResult1147_g91519;
				float3 appendResult1148_g91519 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g91651 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91651 = appendResult1148_g91519;
				float3 appendResult1149_g91519 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g91652 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91652 = appendResult1149_g91519;
				half3 Input_Position167_g91644 = float3( 0,0,0 );
				float dotResult156_g91644 = dot( (Input_Position167_g91644).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91644 = 0.0;
				float Postion_Random162_g91644 = ( sin( dotResult156_g91644 ) * ( 1.0 - Input_DynamicMode120_g91644 ) );
				half Input_Variation124_g91644 = v.ase_color.r;
				half ObjectData20_g91646 = frac( ( Postion_Random162_g91644 + Input_Variation124_g91644 ) );
				half WorldData19_g91646 = Input_Variation124_g91644;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91646 = WorldData19_g91646;
				#else
				float staticSwitch14_g91646 = ObjectData20_g91646;
				#endif
				float temp_output_112_0_g91644 = staticSwitch14_g91646;
				float clampResult171_g91644 = clamp( temp_output_112_0_g91644 , 0.01 , 0.99 );
				float ifLocalVar40_g91653 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91653 = clampResult171_g91644;
				float ifLocalVar40_g91654 = 0;
				if( Debug_Index464_g91519 == 13.0 )
				ifLocalVar40_g91654 = v.ase_color.g;
				float ifLocalVar40_g91655 = 0;
				if( Debug_Index464_g91519 == 14.0 )
				ifLocalVar40_g91655 = v.ase_color.b;
				float ifLocalVar40_g91656 = 0;
				if( Debug_Index464_g91519 == 15.0 )
				ifLocalVar40_g91656 = v.ase_color.a;
				half3 Input_Position167_g91661 = float3( 0,0,0 );
				float dotResult156_g91661 = dot( (Input_Position167_g91661).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91661 = 0.0;
				float Postion_Random162_g91661 = ( sin( dotResult156_g91661 ) * ( 1.0 - Input_DynamicMode120_g91661 ) );
				half Input_Variation124_g91661 = v.ase_color.r;
				half ObjectData20_g91663 = frac( ( Postion_Random162_g91661 + Input_Variation124_g91661 ) );
				half WorldData19_g91663 = Input_Variation124_g91661;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91663 = WorldData19_g91663;
				#else
				float staticSwitch14_g91663 = ObjectData20_g91663;
				#endif
				float temp_output_112_0_g91661 = staticSwitch14_g91663;
				float clampResult171_g91661 = clamp( temp_output_112_0_g91661 , 0.01 , 0.99 );
				float temp_output_1451_19_g91519 = clampResult171_g91661;
				float3 temp_cast_0 = (temp_output_1451_19_g91519).xxx;
				float3 hsvTorgb260_g91519 = HSVToRGB( float3(temp_output_1451_19_g91519,1.0,1.0) );
				float3 gammaToLinear266_g91519 = GammaToLinearSpace( hsvTorgb260_g91519 );
				float _IsBarkShader347_g91519 = _IsBarkShader;
				float _IsPlantShader360_g91519 = _IsPlantShader;
				float _IsAnyVegetationShader362_g91519 = saturate( ( _IsBarkShader347_g91519 + _IsPlantShader360_g91519 ) );
				float3 lerpResult290_g91519 = lerp( temp_cast_0 , gammaToLinear266_g91519 , _IsAnyVegetationShader362_g91519);
				float3 ifLocalVar40_g91657 = 0;
				if( Debug_Index464_g91519 == 16.0 )
				ifLocalVar40_g91657 = lerpResult290_g91519;
				float enc1154_g91519 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g91519 = DecodeFloatToVector2( enc1154_g91519 );
				float2 break1155_g91519 = localDecodeFloatToVector21154_g91519;
				float ifLocalVar40_g91658 = 0;
				if( Debug_Index464_g91519 == 17.0 )
				ifLocalVar40_g91658 = break1155_g91519.x;
				float ifLocalVar40_g91659 = 0;
				if( Debug_Index464_g91519 == 18.0 )
				ifLocalVar40_g91659 = break1155_g91519.y;
				float3 appendResult60_g91649 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g91660 = 0;
				if( Debug_Index464_g91519 == 19.0 )
				ifLocalVar40_g91660 = appendResult60_g91649;
				float3 vertexToFrag328_g91519 = ( ( ifLocalVar40_g91525 + ifLocalVar40_g91543 + ifLocalVar40_g91556 + ifLocalVar40_g91540 ) + ( ifLocalVar40_g91640 + ifLocalVar40_g91641 + ifLocalVar40_g91642 + ifLocalVar40_g91643 ) + ( ifLocalVar40_g91650 + ifLocalVar40_g91651 + ifLocalVar40_g91652 ) + ( ifLocalVar40_g91653 + ifLocalVar40_g91654 + ifLocalVar40_g91655 + ifLocalVar40_g91656 ) + ( ifLocalVar40_g91657 + ifLocalVar40_g91658 + ifLocalVar40_g91659 + ifLocalVar40_g91660 ) );
				o.ase_texcoord12.xyz = vertexToFrag328_g91519;
				
				o.ase_texcoord9 = v.ase_texcoord;
				o.ase_texcoord10 = v.texcoord1.xyzw;
				o.ase_texcoord11 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord12.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
				o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				#ifdef LIGHTMAP_ON
				o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, worldPos, worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif

				#if UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
					#else
						TRANSFER_SHADOW(o);
					#endif
				#endif

				#ifdef ASE_FOG
					UNITY_TRANSFER_FOG(o,o.pos);
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
					o.screenPos = ComputeScreenPos(o.pos);
				#endif
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			fixed4 frag (v2f IN , bool ase_vface : SV_IsFrontFace
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
				) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				#else
					half atten = 1;
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				float Debug_Type367_g91519 = TVE_DEBUG_Type;
				float4 color690_g91519 = IsGammaSpace() ? float4(0.25,0.25,0.25,0) : float4(0.05087609,0.05087609,0.05087609,0);
				float4 Shading_Inactive1492_g91519 = color690_g91519;
				float4 color646_g91519 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1359_g91519 = IsGammaSpace() ? float4(0,0.8683633,0.8862745,1) : float4(0,0.7262539,0.7605246,1);
				float _IsCollected1458_g91519 = _IsCollected;
				float4 lerpResult1360_g91519 = lerp( color646_g91519 , color1359_g91519 , _IsCollected1458_g91519);
				float _IsTVEShader647_g91519 = _IsTVEShader;
				float4 lerpResult1494_g91519 = lerp( Shading_Inactive1492_g91519 , lerpResult1360_g91519 , _IsTVEShader647_g91519);
				float dotResult1472_g91519 = dot( WorldNormal , worldViewDir );
				float temp_output_1526_0_g91519 = ( 1.0 - saturate( dotResult1472_g91519 ) );
				float Shading_Fresnel1469_g91519 = (( 1.0 - ( temp_output_1526_0_g91519 * temp_output_1526_0_g91519 ) )*0.3 + 0.7);
				float4 Output_Converted717_g91519 = ( lerpResult1494_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91703 = 0;
				if( Debug_Type367_g91519 == 0.0 )
				ifLocalVar40_g91703 = Output_Converted717_g91519;
				float4 color466_g91519 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g91519 = _IsBarkShader;
				float4 color472_g91519 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsPlantShader360_g91519 = _IsPlantShader;
				float4 color478_g91519 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g91519 = _IsPropShader;
				float4 lerpResult1502_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color466_g91519 * _IsBarkShader347_g91519 ) + ( color472_g91519 * _IsPlantShader360_g91519 ) + ( color478_g91519 * _IsPropShader346_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Shader445_g91519 = ( lerpResult1502_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91704 = 0;
				if( Debug_Type367_g91519 == 1.0 )
				ifLocalVar40_g91704 = Output_Shader445_g91519;
				float4 color1529_g91519 = IsGammaSpace() ? float4(0.9254902,0.7960784,0.4156863,1) : float4(0.8387991,0.5972018,0.1441285,1);
				float _IsCoreShader1551_g91519 = _IsCoreShader;
				float4 color1539_g91519 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsBlanketShader1554_g91519 = _IsBlanketShader;
				float4 color1542_g91519 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g91519 = _IsImpostorShader;
				float4 color1544_g91519 = IsGammaSpace() ? float4(0.3254902,0.6117647,0.8117647,0) : float4(0.08650047,0.3324516,0.6239604,0);
				float _IsPolygonalShader1112_g91519 = _IsPolygonalShader;
				float4 color1649_g91519 = IsGammaSpace() ? float4(0.6,0.6,0.6,0) : float4(0.3185468,0.3185468,0.3185468,0);
				float _IsLiteShader1648_g91519 = _IsLiteShader;
				float4 lerpResult1535_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color1529_g91519 * _IsCoreShader1551_g91519 ) + ( color1539_g91519 * _IsBlanketShader1554_g91519 ) + ( color1542_g91519 * _IsImpostorShader1110_g91519 ) + ( color1544_g91519 * _IsPolygonalShader1112_g91519 ) + ( color1649_g91519 * _IsLiteShader1648_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Scope1531_g91519 = ( lerpResult1535_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91705 = 0;
				if( Debug_Type367_g91519 == 2.0 )
				ifLocalVar40_g91705 = Output_Scope1531_g91519;
				float4 color529_g91519 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g91519 = _IsVertexShader;
				float4 color544_g91519 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g91519 = _IsSimpleShader;
				float4 color521_g91519 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g91519 = _IsStandardShader;
				float4 color1121_g91519 = IsGammaSpace() ? float4(0.9716981,0.88463,0.1787558,0) : float4(0.9368213,0.7573396,0.02686729,0);
				float _IsSubsurfaceShader548_g91519 = _IsSubsurfaceShader;
				float4 lerpResult1507_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color529_g91519 * _IsVertexShader1158_g91519 ) + ( color544_g91519 * _IsSimpleShader359_g91519 ) + ( color521_g91519 * _IsStandardShader344_g91519 ) + ( color1121_g91519 * _IsSubsurfaceShader548_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Lighting525_g91519 = ( lerpResult1507_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91706 = 0;
				if( Debug_Type367_g91519 == 3.0 )
				ifLocalVar40_g91706 = Output_Lighting525_g91519;
				float4 color1559_g91519 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1563_g91519 = IsGammaSpace() ? float4(0.3053578,0.8867924,0.5362216,0) : float4(0.0759199,0.7615293,0.2491121,0);
				float _IsCustomShader1570_g91519 = _IsCustomShader;
				float4 lerpResult1561_g91519 = lerp( color1559_g91519 , color1563_g91519 , _IsCustomShader1570_g91519);
				float4 lerpResult1566_g91519 = lerp( Shading_Inactive1492_g91519 , lerpResult1561_g91519 , _IsTVEShader647_g91519);
				float4 Output_Custom1560_g91519 = ( lerpResult1566_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91707 = 0;
				if( Debug_Type367_g91519 == 4.0 )
				ifLocalVar40_g91707 = Output_Custom1560_g91519;
				float3 hsvTorgb1452_g91519 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
				float3 gammaToLinear1453_g91519 = GammaToLinearSpace( hsvTorgb1452_g91519 );
				float4 lerpResult1512_g91519 = lerp( Shading_Inactive1492_g91519 , float4( gammaToLinear1453_g91519 , 0.0 ) , _IsTVEShader647_g91519);
				float4 Output_Sharing1355_g91519 = lerpResult1512_g91519;
				float4 ifLocalVar40_g91708 = 0;
				if( Debug_Type367_g91519 == 5.0 )
				ifLocalVar40_g91708 = Output_Sharing1355_g91519;
				float Debug_Index464_g91519 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g91519 = ( ( IN.ase_texcoord9.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g91519 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g91519 );
				float3 appendResult637_g91519 = (float3(tex2DNode586_g91519.r , tex2DNode586_g91519.g , tex2DNode586_g91519.b));
				float3 ifLocalVar40_g91542 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91542 = appendResult637_g91519;
				float ifLocalVar40_g91547 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91547 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g91519 ).a;
				float4 tex2DNode604_g91519 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g91519 );
				float3 appendResult876_g91519 = (float3(tex2DNode604_g91519.a , tex2DNode604_g91519.g , 1.0));
				float3 gammaToLinear878_g91519 = GammaToLinearSpace( appendResult876_g91519 );
				float3 ifLocalVar40_g91577 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91577 = gammaToLinear878_g91519;
				float ifLocalVar40_g91528 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91528 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).r;
				float ifLocalVar40_g91610 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91610 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).g;
				float ifLocalVar40_g91548 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91548 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).b;
				float ifLocalVar40_g91526 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91526 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).a;
				float2 appendResult1251_g91519 = (float2(IN.ase_texcoord10.z , IN.ase_texcoord10.w));
				float2 Mesh_DetailCoord1254_g91519 = appendResult1251_g91519;
				float2 lerpResult1231_g91519 = lerp( IN.ase_texcoord9.xy , Mesh_DetailCoord1254_g91519 , _DetailCoordMode);
				half2 Second_UVs1234_g91519 = ( ( lerpResult1231_g91519 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g91519 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g91519 );
				float3 appendResult839_g91519 = (float3(tex2DNode854_g91519.r , tex2DNode854_g91519.g , tex2DNode854_g91519.b));
				float3 ifLocalVar40_g91539 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91539 = appendResult839_g91519;
				float ifLocalVar40_g91555 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91555 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g91519 ).a;
				float4 tex2DNode841_g91519 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Second_UVs1234_g91519 );
				float3 appendResult880_g91519 = (float3(tex2DNode841_g91519.a , tex2DNode841_g91519.g , 1.0));
				float3 gammaToLinear879_g91519 = GammaToLinearSpace( appendResult880_g91519 );
				float3 ifLocalVar40_g91598 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91598 = gammaToLinear879_g91519;
				float ifLocalVar40_g91578 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91578 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).r;
				float ifLocalVar40_g91546 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91546 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).g;
				float ifLocalVar40_g91590 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91590 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).b;
				float ifLocalVar40_g91597 = 0;
				if( Debug_Index464_g91519 == 13.0 )
				ifLocalVar40_g91597 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).a;
				half2 Emissive_UVs1245_g91519 = ( ( IN.ase_texcoord9.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g91519 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g91519 );
				float ifLocalVar40_g91545 = 0;
				if( Debug_Index464_g91519 == 14.0 )
				ifLocalVar40_g91545 = tex2DNode858_g91519.r;
				float Debug_Min721_g91519 = TVE_DEBUG_Min;
				float temp_output_7_0_g91584 = Debug_Min721_g91519;
				float4 temp_cast_3 = (temp_output_7_0_g91584).xxxx;
				float Debug_Max723_g91519 = TVE_DEBUG_Max;
				float temp_output_10_0_g91584 = ( Debug_Max723_g91519 - temp_output_7_0_g91584 );
				float4 Output_Maps561_g91519 = saturate( ( ( ( float4( ( ( ifLocalVar40_g91542 + ifLocalVar40_g91547 + ifLocalVar40_g91577 ) + ( ifLocalVar40_g91528 + ifLocalVar40_g91610 + ifLocalVar40_g91548 + ifLocalVar40_g91526 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g91539 + ifLocalVar40_g91555 + ifLocalVar40_g91598 ) + ( ifLocalVar40_g91578 + ifLocalVar40_g91546 + ifLocalVar40_g91590 + ifLocalVar40_g91597 ) ) * _DetailMode ) , 0.0 ) + ( ( ifLocalVar40_g91545 * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( temp_output_10_0_g91584 + 0.0001 ) ) );
				float4 ifLocalVar40_g91709 = 0;
				if( Debug_Type367_g91519 == 6.0 )
				ifLocalVar40_g91709 = Output_Maps561_g91519;
				float Resolution44_g91628 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g91628 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91628 = 0;
				if( Resolution44_g91628 <= 256.0 )
				ifLocalVar61_g91628 = color62_g91628;
				float4 color55_g91628 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91628 = 0;
				if( Resolution44_g91628 == 512.0 )
				ifLocalVar56_g91628 = color55_g91628;
				float4 color42_g91628 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91628 = 0;
				if( Resolution44_g91628 == 1024.0 )
				ifLocalVar40_g91628 = color42_g91628;
				float4 color48_g91628 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91628 = 0;
				if( Resolution44_g91628 == 2048.0 )
				ifLocalVar47_g91628 = color48_g91628;
				float4 color51_g91628 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91628 = 0;
				if( Resolution44_g91628 >= 4096.0 )
				ifLocalVar52_g91628 = color51_g91628;
				float4 ifLocalVar40_g91614 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91614 = ( ifLocalVar61_g91628 + ifLocalVar56_g91628 + ifLocalVar40_g91628 + ifLocalVar47_g91628 + ifLocalVar52_g91628 );
				float Resolution44_g91627 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g91627 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91627 = 0;
				if( Resolution44_g91627 <= 256.0 )
				ifLocalVar61_g91627 = color62_g91627;
				float4 color55_g91627 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91627 = 0;
				if( Resolution44_g91627 == 512.0 )
				ifLocalVar56_g91627 = color55_g91627;
				float4 color42_g91627 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91627 = 0;
				if( Resolution44_g91627 == 1024.0 )
				ifLocalVar40_g91627 = color42_g91627;
				float4 color48_g91627 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91627 = 0;
				if( Resolution44_g91627 == 2048.0 )
				ifLocalVar47_g91627 = color48_g91627;
				float4 color51_g91627 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91627 = 0;
				if( Resolution44_g91627 >= 4096.0 )
				ifLocalVar52_g91627 = color51_g91627;
				float4 ifLocalVar40_g91612 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91612 = ( ifLocalVar61_g91627 + ifLocalVar56_g91627 + ifLocalVar40_g91627 + ifLocalVar47_g91627 + ifLocalVar52_g91627 );
				float Resolution44_g91626 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g91626 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91626 = 0;
				if( Resolution44_g91626 <= 256.0 )
				ifLocalVar61_g91626 = color62_g91626;
				float4 color55_g91626 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91626 = 0;
				if( Resolution44_g91626 == 512.0 )
				ifLocalVar56_g91626 = color55_g91626;
				float4 color42_g91626 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91626 = 0;
				if( Resolution44_g91626 == 1024.0 )
				ifLocalVar40_g91626 = color42_g91626;
				float4 color48_g91626 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91626 = 0;
				if( Resolution44_g91626 == 2048.0 )
				ifLocalVar47_g91626 = color48_g91626;
				float4 color51_g91626 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91626 = 0;
				if( Resolution44_g91626 >= 4096.0 )
				ifLocalVar52_g91626 = color51_g91626;
				float4 ifLocalVar40_g91613 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91613 = ( ifLocalVar61_g91626 + ifLocalVar56_g91626 + ifLocalVar40_g91626 + ifLocalVar47_g91626 + ifLocalVar52_g91626 );
				float Resolution44_g91633 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g91633 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91633 = 0;
				if( Resolution44_g91633 <= 256.0 )
				ifLocalVar61_g91633 = color62_g91633;
				float4 color55_g91633 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91633 = 0;
				if( Resolution44_g91633 == 512.0 )
				ifLocalVar56_g91633 = color55_g91633;
				float4 color42_g91633 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91633 = 0;
				if( Resolution44_g91633 == 1024.0 )
				ifLocalVar40_g91633 = color42_g91633;
				float4 color48_g91633 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91633 = 0;
				if( Resolution44_g91633 == 2048.0 )
				ifLocalVar47_g91633 = color48_g91633;
				float4 color51_g91633 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91633 = 0;
				if( Resolution44_g91633 >= 4096.0 )
				ifLocalVar52_g91633 = color51_g91633;
				float4 ifLocalVar40_g91620 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91620 = ( ifLocalVar61_g91633 + ifLocalVar56_g91633 + ifLocalVar40_g91633 + ifLocalVar47_g91633 + ifLocalVar52_g91633 );
				float Resolution44_g91632 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g91632 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91632 = 0;
				if( Resolution44_g91632 <= 256.0 )
				ifLocalVar61_g91632 = color62_g91632;
				float4 color55_g91632 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91632 = 0;
				if( Resolution44_g91632 == 512.0 )
				ifLocalVar56_g91632 = color55_g91632;
				float4 color42_g91632 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91632 = 0;
				if( Resolution44_g91632 == 1024.0 )
				ifLocalVar40_g91632 = color42_g91632;
				float4 color48_g91632 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91632 = 0;
				if( Resolution44_g91632 == 2048.0 )
				ifLocalVar47_g91632 = color48_g91632;
				float4 color51_g91632 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91632 = 0;
				if( Resolution44_g91632 >= 4096.0 )
				ifLocalVar52_g91632 = color51_g91632;
				float4 ifLocalVar40_g91618 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91618 = ( ifLocalVar61_g91632 + ifLocalVar56_g91632 + ifLocalVar40_g91632 + ifLocalVar47_g91632 + ifLocalVar52_g91632 );
				float Resolution44_g91634 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g91634 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91634 = 0;
				if( Resolution44_g91634 <= 256.0 )
				ifLocalVar61_g91634 = color62_g91634;
				float4 color55_g91634 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91634 = 0;
				if( Resolution44_g91634 == 512.0 )
				ifLocalVar56_g91634 = color55_g91634;
				float4 color42_g91634 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91634 = 0;
				if( Resolution44_g91634 == 1024.0 )
				ifLocalVar40_g91634 = color42_g91634;
				float4 color48_g91634 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91634 = 0;
				if( Resolution44_g91634 == 2048.0 )
				ifLocalVar47_g91634 = color48_g91634;
				float4 color51_g91634 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91634 = 0;
				if( Resolution44_g91634 >= 4096.0 )
				ifLocalVar52_g91634 = color51_g91634;
				float4 ifLocalVar40_g91619 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91619 = ( ifLocalVar61_g91634 + ifLocalVar56_g91634 + ifLocalVar40_g91634 + ifLocalVar47_g91634 + ifLocalVar52_g91634 );
				float Resolution44_g91631 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g91631 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91631 = 0;
				if( Resolution44_g91631 <= 256.0 )
				ifLocalVar61_g91631 = color62_g91631;
				float4 color55_g91631 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91631 = 0;
				if( Resolution44_g91631 == 512.0 )
				ifLocalVar56_g91631 = color55_g91631;
				float4 color42_g91631 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91631 = 0;
				if( Resolution44_g91631 == 1024.0 )
				ifLocalVar40_g91631 = color42_g91631;
				float4 color48_g91631 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91631 = 0;
				if( Resolution44_g91631 == 2048.0 )
				ifLocalVar47_g91631 = color48_g91631;
				float4 color51_g91631 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91631 = 0;
				if( Resolution44_g91631 >= 4096.0 )
				ifLocalVar52_g91631 = color51_g91631;
				float4 ifLocalVar40_g91621 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91621 = ( ifLocalVar61_g91631 + ifLocalVar56_g91631 + ifLocalVar40_g91631 + ifLocalVar47_g91631 + ifLocalVar52_g91631 );
				float4 Output_Resolution737_g91519 = ( ( ifLocalVar40_g91614 + ifLocalVar40_g91612 + ifLocalVar40_g91613 ) + ( ifLocalVar40_g91620 + ifLocalVar40_g91618 + ifLocalVar40_g91619 ) + ifLocalVar40_g91621 );
				float4 ifLocalVar40_g91710 = 0;
				if( Debug_Type367_g91519 == 7.0 )
				ifLocalVar40_g91710 = Output_Resolution737_g91519;
				float2 uv_MainAlbedoTex = IN.ase_texcoord9.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float2 UVs72_g91639 = Main_UVs1219_g91519;
				float Resolution44_g91639 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91639 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91639 * ( Resolution44_g91639 / 8.0 ) ) );
				float4 lerpResult78_g91639 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g91639 , tex2DNode77_g91639.a);
				float4 ifLocalVar40_g91617 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91617 = lerpResult78_g91639;
				float2 uv_MainNormalTex = IN.ase_texcoord9.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g91630 = Main_UVs1219_g91519;
				float Resolution44_g91630 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g91630 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91630 * ( Resolution44_g91630 / 8.0 ) ) );
				float4 lerpResult78_g91630 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g91630 , tex2DNode77_g91630.a);
				float4 ifLocalVar40_g91615 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91615 = lerpResult78_g91630;
				float2 uv_MainMaskTex = IN.ase_texcoord9.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g91629 = Main_UVs1219_g91519;
				float Resolution44_g91629 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g91629 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91629 * ( Resolution44_g91629 / 8.0 ) ) );
				float4 lerpResult78_g91629 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g91629 , tex2DNode77_g91629.a);
				float4 ifLocalVar40_g91616 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91616 = lerpResult78_g91629;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord9.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g91637 = Second_UVs1234_g91519;
				float Resolution44_g91637 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91637 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91637 * ( Resolution44_g91637 / 8.0 ) ) );
				float4 lerpResult78_g91637 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g91637 , tex2DNode77_g91637.a);
				float4 ifLocalVar40_g91624 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91624 = lerpResult78_g91637;
				float2 uv_SecondMaskTex = IN.ase_texcoord9.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g91636 = Second_UVs1234_g91519;
				float Resolution44_g91636 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g91636 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91636 * ( Resolution44_g91636 / 8.0 ) ) );
				float4 lerpResult78_g91636 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g91636 , tex2DNode77_g91636.a);
				float4 ifLocalVar40_g91622 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91622 = lerpResult78_g91636;
				float2 UVs72_g91638 = Second_UVs1234_g91519;
				float Resolution44_g91638 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91638 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91638 * ( Resolution44_g91638 / 8.0 ) ) );
				float4 lerpResult78_g91638 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g91638 , tex2DNode77_g91638.a);
				float4 ifLocalVar40_g91623 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91623 = lerpResult78_g91638;
				float2 uv_EmissiveTex = IN.ase_texcoord9.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g91635 = Emissive_UVs1245_g91519;
				float Resolution44_g91635 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g91635 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91635 * ( Resolution44_g91635 / 8.0 ) ) );
				float4 lerpResult78_g91635 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g91635 , tex2DNode77_g91635.a);
				float4 ifLocalVar40_g91625 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91625 = lerpResult78_g91635;
				float4 Output_MipLevel1284_g91519 = ( ( ifLocalVar40_g91617 + ifLocalVar40_g91615 + ifLocalVar40_g91616 ) + ( ifLocalVar40_g91624 + ifLocalVar40_g91622 + ifLocalVar40_g91623 ) + ifLocalVar40_g91625 );
				float4 ifLocalVar40_g91711 = 0;
				if( Debug_Type367_g91519 == 8.0 )
				ifLocalVar40_g91711 = Output_MipLevel1284_g91519;
				float3 WorldPosition893_g91519 = worldPos;
				half3 Input_Position419_g91667 = WorldPosition893_g91519;
				float Input_MotionScale287_g91667 = ( _MotionScale_10 + 0.2 );
				half NoiseTex_Tilling735_g91667 = TVE_NoiseTexTilling;
				float2 temp_output_597_0_g91667 = (( Input_Position419_g91667 * Input_MotionScale287_g91667 * NoiseTex_Tilling735_g91667 * 0.0075 )).xz;
				float2 temp_output_447_0_g91671 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g91519 = temp_output_447_0_g91671;
				half2 Input_DirectionWS423_g91667 = Wind_DirectionWS1031_g91519;
				float lerpResult128_g91668 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Input_MotionSpeed62_g91667 = _MotionSpeed_10;
				half Input_MotionVariation284_g91667 = _MotionVariation_10;
				float4x4 break19_g91674 = unity_ObjectToWorld;
				float3 appendResult20_g91674 = (float3(break19_g91674[ 0 ][ 3 ] , break19_g91674[ 1 ][ 3 ] , break19_g91674[ 2 ][ 3 ]));
				float3 appendResult60_g91673 = (float3(IN.ase_texcoord11.x , IN.ase_texcoord11.z , IN.ase_texcoord11.y));
				float3 temp_output_122_0_g91674 = ( appendResult60_g91673 * _VertexPivotMode );
				float3 PivotsOnly105_g91674 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g91674 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g91676 = ( appendResult20_g91674 + PivotsOnly105_g91674 );
				half3 WorldData19_g91676 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g91676 = WorldData19_g91676;
				#else
				float3 staticSwitch14_g91676 = ObjectData20_g91676;
				#endif
				float3 temp_output_114_0_g91674 = staticSwitch14_g91676;
				half3 ObjectData20_g91666 = temp_output_114_0_g91674;
				half3 WorldData19_g91666 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g91666 = WorldData19_g91666;
				#else
				float3 staticSwitch14_g91666 = ObjectData20_g91666;
				#endif
				float3 ObjectPosition890_g91519 = staticSwitch14_g91666;
				half3 Input_Position167_g91683 = ObjectPosition890_g91519;
				float dotResult156_g91683 = dot( (Input_Position167_g91683).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91683 = _VertexDynamicMode;
				float Postion_Random162_g91683 = ( sin( dotResult156_g91683 ) * ( 1.0 - Input_DynamicMode120_g91683 ) );
				half Input_Variation124_g91683 = IN.ase_color.r;
				half ObjectData20_g91685 = frac( ( Postion_Random162_g91683 + Input_Variation124_g91683 ) );
				half WorldData19_g91685 = Input_Variation124_g91683;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91685 = WorldData19_g91685;
				#else
				float staticSwitch14_g91685 = ObjectData20_g91685;
				#endif
				float temp_output_112_0_g91683 = staticSwitch14_g91685;
				float clampResult171_g91683 = clamp( temp_output_112_0_g91683 , 0.01 , 0.99 );
				half Global_MeshVariation1176_g91519 = clampResult171_g91683;
				half Input_GlobalMeshVariation569_g91667 = Global_MeshVariation1176_g91519;
				float temp_output_630_0_g91667 = ( ( ( lerpResult128_g91668 * Input_MotionSpeed62_g91667 ) + ( Input_MotionVariation284_g91667 * Input_GlobalMeshVariation569_g91667 ) ) * 0.03 );
				float temp_output_607_0_g91667 = frac( temp_output_630_0_g91667 );
				float4 lerpResult590_g91667 = lerp( SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g91667 + ( -Input_DirectionWS423_g91667 * temp_output_607_0_g91667 ) ) ) , SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g91667 + ( -Input_DirectionWS423_g91667 * frac( ( temp_output_630_0_g91667 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g91667 - 0.5 ) ) / 0.5 ));
				half4 Noise_Complex703_g91667 = lerpResult590_g91667;
				float2 temp_output_645_0_g91667 = ((Noise_Complex703_g91667).rg*2.0 + -1.0);
				float2 break650_g91667 = temp_output_645_0_g91667;
				float3 appendResult649_g91667 = (float3(break650_g91667.x , 0.0 , break650_g91667.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
				half2 Motion_Noise915_g91519 = (( mul( unity_WorldToObject, float4( appendResult649_g91667 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				float3 appendResult1180_g91519 = (float3(Motion_Noise915_g91519 , 0.0));
				float3 ifLocalVar40_g91529 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91529 = appendResult1180_g91519;
				float Debug_Layer885_g91519 = TVE_DEBUG_Layer;
				float temp_output_82_0_g91572 = Debug_Layer885_g91519;
				float temp_output_19_0_g91576 = TVE_ColorsUsage[(int)temp_output_82_0_g91572];
				float4 temp_output_91_19_g91572 = TVE_ColorsCoords;
				half2 UV94_g91572 = ( (temp_output_91_19_g91572).zw + ( (temp_output_91_19_g91572).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode83_g91572 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g91572,temp_output_82_0_g91572), 0.0 );
				float4 temp_output_17_0_g91576 = tex2DArrayNode83_g91572;
				float4 temp_output_92_86_g91572 = TVE_ColorsParams;
				float4 temp_output_3_0_g91576 = temp_output_92_86_g91572;
				float4 ifLocalVar18_g91576 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91576 >= 0.5 )
				ifLocalVar18_g91576 = temp_output_17_0_g91576;
				else
				ifLocalVar18_g91576 = temp_output_3_0_g91576;
				float4 lerpResult22_g91576 = lerp( temp_output_3_0_g91576 , temp_output_17_0_g91576 , temp_output_19_0_g91576);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91576 = lerpResult22_g91576;
				#else
				float4 staticSwitch24_g91576 = ifLocalVar18_g91576;
				#endif
				float3 ifLocalVar40_g91544 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91544 = (staticSwitch24_g91576).rgb;
				float temp_output_82_0_g91557 = Debug_Layer885_g91519;
				float temp_output_19_0_g91561 = TVE_ColorsUsage[(int)temp_output_82_0_g91557];
				float4 temp_output_91_19_g91557 = TVE_ColorsCoords;
				half2 UV94_g91557 = ( (temp_output_91_19_g91557).zw + ( (temp_output_91_19_g91557).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode83_g91557 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g91557,temp_output_82_0_g91557), 0.0 );
				float4 temp_output_17_0_g91561 = tex2DArrayNode83_g91557;
				float4 temp_output_92_86_g91557 = TVE_ColorsParams;
				float4 temp_output_3_0_g91561 = temp_output_92_86_g91557;
				float4 ifLocalVar18_g91561 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91561 >= 0.5 )
				ifLocalVar18_g91561 = temp_output_17_0_g91561;
				else
				ifLocalVar18_g91561 = temp_output_3_0_g91561;
				float4 lerpResult22_g91561 = lerp( temp_output_3_0_g91561 , temp_output_17_0_g91561 , temp_output_19_0_g91561);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91561 = lerpResult22_g91561;
				#else
				float4 staticSwitch24_g91561 = ifLocalVar18_g91561;
				#endif
				float ifLocalVar40_g91554 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91554 = saturate( (staticSwitch24_g91561).a );
				float temp_output_84_0_g91567 = Debug_Layer885_g91519;
				float temp_output_19_0_g91571 = TVE_ExtrasUsage[(int)temp_output_84_0_g91567];
				float4 temp_output_93_19_g91567 = TVE_ExtrasCoords;
				half2 UV96_g91567 = ( (temp_output_93_19_g91567).zw + ( (temp_output_93_19_g91567).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91567 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91567,temp_output_84_0_g91567), 0.0 );
				float4 temp_output_17_0_g91571 = tex2DArrayNode48_g91567;
				float4 temp_output_94_85_g91567 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91571 = temp_output_94_85_g91567;
				float4 ifLocalVar18_g91571 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91571 >= 0.5 )
				ifLocalVar18_g91571 = temp_output_17_0_g91571;
				else
				ifLocalVar18_g91571 = temp_output_3_0_g91571;
				float4 lerpResult22_g91571 = lerp( temp_output_3_0_g91571 , temp_output_17_0_g91571 , temp_output_19_0_g91571);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91571 = lerpResult22_g91571;
				#else
				float4 staticSwitch24_g91571 = ifLocalVar18_g91571;
				#endif
				float ifLocalVar40_g91537 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91537 = (staticSwitch24_g91571).r;
				float temp_output_84_0_g91520 = Debug_Layer885_g91519;
				float temp_output_19_0_g91524 = TVE_ExtrasUsage[(int)temp_output_84_0_g91520];
				float4 temp_output_93_19_g91520 = TVE_ExtrasCoords;
				half2 UV96_g91520 = ( (temp_output_93_19_g91520).zw + ( (temp_output_93_19_g91520).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91520 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91520,temp_output_84_0_g91520), 0.0 );
				float4 temp_output_17_0_g91524 = tex2DArrayNode48_g91520;
				float4 temp_output_94_85_g91520 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91524 = temp_output_94_85_g91520;
				float4 ifLocalVar18_g91524 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91524 >= 0.5 )
				ifLocalVar18_g91524 = temp_output_17_0_g91524;
				else
				ifLocalVar18_g91524 = temp_output_3_0_g91524;
				float4 lerpResult22_g91524 = lerp( temp_output_3_0_g91524 , temp_output_17_0_g91524 , temp_output_19_0_g91524);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91524 = lerpResult22_g91524;
				#else
				float4 staticSwitch24_g91524 = ifLocalVar18_g91524;
				#endif
				float ifLocalVar40_g91609 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91609 = (staticSwitch24_g91524).g;
				float temp_output_84_0_g91579 = Debug_Layer885_g91519;
				float temp_output_19_0_g91583 = TVE_ExtrasUsage[(int)temp_output_84_0_g91579];
				float4 temp_output_93_19_g91579 = TVE_ExtrasCoords;
				half2 UV96_g91579 = ( (temp_output_93_19_g91579).zw + ( (temp_output_93_19_g91579).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91579 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91579,temp_output_84_0_g91579), 0.0 );
				float4 temp_output_17_0_g91583 = tex2DArrayNode48_g91579;
				float4 temp_output_94_85_g91579 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91583 = temp_output_94_85_g91579;
				float4 ifLocalVar18_g91583 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91583 >= 0.5 )
				ifLocalVar18_g91583 = temp_output_17_0_g91583;
				else
				ifLocalVar18_g91583 = temp_output_3_0_g91583;
				float4 lerpResult22_g91583 = lerp( temp_output_3_0_g91583 , temp_output_17_0_g91583 , temp_output_19_0_g91583);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91583 = lerpResult22_g91583;
				#else
				float4 staticSwitch24_g91583 = ifLocalVar18_g91583;
				#endif
				float ifLocalVar40_g91538 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91538 = (staticSwitch24_g91583).b;
				float temp_output_84_0_g91599 = Debug_Layer885_g91519;
				float temp_output_19_0_g91603 = TVE_ExtrasUsage[(int)temp_output_84_0_g91599];
				float4 temp_output_93_19_g91599 = TVE_ExtrasCoords;
				half2 UV96_g91599 = ( (temp_output_93_19_g91599).zw + ( (temp_output_93_19_g91599).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91599 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91599,temp_output_84_0_g91599), 0.0 );
				float4 temp_output_17_0_g91603 = tex2DArrayNode48_g91599;
				float4 temp_output_94_85_g91599 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91603 = temp_output_94_85_g91599;
				float4 ifLocalVar18_g91603 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91603 >= 0.5 )
				ifLocalVar18_g91603 = temp_output_17_0_g91603;
				else
				ifLocalVar18_g91603 = temp_output_3_0_g91603;
				float4 lerpResult22_g91603 = lerp( temp_output_3_0_g91603 , temp_output_17_0_g91603 , temp_output_19_0_g91603);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91603 = lerpResult22_g91603;
				#else
				float4 staticSwitch24_g91603 = ifLocalVar18_g91603;
				#endif
				float ifLocalVar40_g91531 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91531 = saturate( (staticSwitch24_g91603).a );
				float temp_output_84_0_g91562 = Debug_Layer885_g91519;
				float temp_output_19_0_g91566 = TVE_MotionUsage[(int)temp_output_84_0_g91562];
				float4 temp_output_91_19_g91562 = TVE_MotionCoords;
				half2 UV94_g91562 = ( (temp_output_91_19_g91562).zw + ( (temp_output_91_19_g91562).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91562 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91562,temp_output_84_0_g91562), 0.0 );
				float4 temp_output_17_0_g91566 = tex2DArrayNode50_g91562;
				float4 temp_output_112_19_g91562 = TVE_MotionParams;
				float4 temp_output_3_0_g91566 = temp_output_112_19_g91562;
				float4 ifLocalVar18_g91566 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91566 >= 0.5 )
				ifLocalVar18_g91566 = temp_output_17_0_g91566;
				else
				ifLocalVar18_g91566 = temp_output_3_0_g91566;
				float4 lerpResult22_g91566 = lerp( temp_output_3_0_g91566 , temp_output_17_0_g91566 , temp_output_19_0_g91566);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91566 = lerpResult22_g91566;
				#else
				float4 staticSwitch24_g91566 = ifLocalVar18_g91566;
				#endif
				float3 appendResult1012_g91519 = (float3((staticSwitch24_g91566).rg , 0.0));
				float3 ifLocalVar40_g91527 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91527 = appendResult1012_g91519;
				float temp_output_84_0_g91585 = Debug_Layer885_g91519;
				float temp_output_19_0_g91589 = TVE_MotionUsage[(int)temp_output_84_0_g91585];
				float4 temp_output_91_19_g91585 = TVE_MotionCoords;
				half2 UV94_g91585 = ( (temp_output_91_19_g91585).zw + ( (temp_output_91_19_g91585).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91585 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91585,temp_output_84_0_g91585), 0.0 );
				float4 temp_output_17_0_g91589 = tex2DArrayNode50_g91585;
				float4 temp_output_112_19_g91585 = TVE_MotionParams;
				float4 temp_output_3_0_g91589 = temp_output_112_19_g91585;
				float4 ifLocalVar18_g91589 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91589 >= 0.5 )
				ifLocalVar18_g91589 = temp_output_17_0_g91589;
				else
				ifLocalVar18_g91589 = temp_output_3_0_g91589;
				float4 lerpResult22_g91589 = lerp( temp_output_3_0_g91589 , temp_output_17_0_g91589 , temp_output_19_0_g91589);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91589 = lerpResult22_g91589;
				#else
				float4 staticSwitch24_g91589 = ifLocalVar18_g91589;
				#endif
				float ifLocalVar40_g91541 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91541 = (staticSwitch24_g91589).b;
				float temp_output_84_0_g91591 = Debug_Layer885_g91519;
				float temp_output_19_0_g91595 = TVE_MotionUsage[(int)temp_output_84_0_g91591];
				float4 temp_output_91_19_g91591 = TVE_MotionCoords;
				half2 UV94_g91591 = ( (temp_output_91_19_g91591).zw + ( (temp_output_91_19_g91591).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91591 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91591,temp_output_84_0_g91591), 0.0 );
				float4 temp_output_17_0_g91595 = tex2DArrayNode50_g91591;
				float4 temp_output_112_19_g91591 = TVE_MotionParams;
				float4 temp_output_3_0_g91595 = temp_output_112_19_g91591;
				float4 ifLocalVar18_g91595 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91595 >= 0.5 )
				ifLocalVar18_g91595 = temp_output_17_0_g91595;
				else
				ifLocalVar18_g91595 = temp_output_3_0_g91595;
				float4 lerpResult22_g91595 = lerp( temp_output_3_0_g91595 , temp_output_17_0_g91595 , temp_output_19_0_g91595);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91595 = lerpResult22_g91595;
				#else
				float4 staticSwitch24_g91595 = ifLocalVar18_g91595;
				#endif
				float ifLocalVar40_g91596 = 0;
				if( Debug_Index464_g91519 == 9.0 )
				ifLocalVar40_g91596 = saturate( (staticSwitch24_g91595).a );
				float temp_output_84_0_g91549 = Debug_Layer885_g91519;
				float temp_output_19_0_g91553 = TVE_VertexUsage[(int)temp_output_84_0_g91549];
				float4 temp_output_94_19_g91549 = TVE_VertexCoords;
				half2 UV97_g91549 = ( (temp_output_94_19_g91549).zw + ( (temp_output_94_19_g91549).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91549,temp_output_84_0_g91549), 0.0 );
				float4 temp_output_17_0_g91553 = tex2DArrayNode50_g91549;
				float4 temp_output_111_19_g91549 = TVE_VertexParams;
				float4 temp_output_3_0_g91553 = temp_output_111_19_g91549;
				float4 ifLocalVar18_g91553 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91553 >= 0.5 )
				ifLocalVar18_g91553 = temp_output_17_0_g91553;
				else
				ifLocalVar18_g91553 = temp_output_3_0_g91553;
				float4 lerpResult22_g91553 = lerp( temp_output_3_0_g91553 , temp_output_17_0_g91553 , temp_output_19_0_g91553);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91553 = lerpResult22_g91553;
				#else
				float4 staticSwitch24_g91553 = ifLocalVar18_g91553;
				#endif
				float3 appendResult1013_g91519 = (float3((staticSwitch24_g91553).rg , 0.0));
				float3 ifLocalVar40_g91715 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91715 = appendResult1013_g91519;
				float temp_output_84_0_g91532 = Debug_Layer885_g91519;
				float temp_output_19_0_g91536 = TVE_VertexUsage[(int)temp_output_84_0_g91532];
				float4 temp_output_94_19_g91532 = TVE_VertexCoords;
				half2 UV97_g91532 = ( (temp_output_94_19_g91532).zw + ( (temp_output_94_19_g91532).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91532 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91532,temp_output_84_0_g91532), 0.0 );
				float4 temp_output_17_0_g91536 = tex2DArrayNode50_g91532;
				float4 temp_output_111_19_g91532 = TVE_VertexParams;
				float4 temp_output_3_0_g91536 = temp_output_111_19_g91532;
				float4 ifLocalVar18_g91536 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91536 >= 0.5 )
				ifLocalVar18_g91536 = temp_output_17_0_g91536;
				else
				ifLocalVar18_g91536 = temp_output_3_0_g91536;
				float4 lerpResult22_g91536 = lerp( temp_output_3_0_g91536 , temp_output_17_0_g91536 , temp_output_19_0_g91536);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91536 = lerpResult22_g91536;
				#else
				float4 staticSwitch24_g91536 = ifLocalVar18_g91536;
				#endif
				float ifLocalVar40_g91689 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91689 = saturate( (staticSwitch24_g91536).b );
				float temp_output_84_0_g91604 = Debug_Layer885_g91519;
				float temp_output_19_0_g91608 = TVE_VertexUsage[(int)temp_output_84_0_g91604];
				float4 temp_output_94_19_g91604 = TVE_VertexCoords;
				half2 UV97_g91604 = ( (temp_output_94_19_g91604).zw + ( (temp_output_94_19_g91604).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91604 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91604,temp_output_84_0_g91604), 0.0 );
				float4 temp_output_17_0_g91608 = tex2DArrayNode50_g91604;
				float4 temp_output_111_19_g91604 = TVE_VertexParams;
				float4 temp_output_3_0_g91608 = temp_output_111_19_g91604;
				float4 ifLocalVar18_g91608 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91608 >= 0.5 )
				ifLocalVar18_g91608 = temp_output_17_0_g91608;
				else
				ifLocalVar18_g91608 = temp_output_3_0_g91608;
				float4 lerpResult22_g91608 = lerp( temp_output_3_0_g91608 , temp_output_17_0_g91608 , temp_output_19_0_g91608);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91608 = lerpResult22_g91608;
				#else
				float4 staticSwitch24_g91608 = ifLocalVar18_g91608;
				#endif
				float ifLocalVar40_g91690 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91690 = saturate( (staticSwitch24_g91608).a );
				float temp_output_7_0_g91611 = Debug_Min721_g91519;
				float3 temp_cast_44 = (temp_output_7_0_g91611).xxx;
				float temp_output_10_0_g91611 = ( Debug_Max723_g91519 - temp_output_7_0_g91611 );
				float3 Output_Globals888_g91519 = saturate( ( ( ( ifLocalVar40_g91529 + ( ifLocalVar40_g91544 + ifLocalVar40_g91554 ) + ( ifLocalVar40_g91537 + ifLocalVar40_g91609 + ifLocalVar40_g91538 + ifLocalVar40_g91531 ) + ( ifLocalVar40_g91527 + ifLocalVar40_g91541 + ifLocalVar40_g91596 ) + ( ifLocalVar40_g91715 + ifLocalVar40_g91689 + ifLocalVar40_g91690 ) ) - temp_cast_44 ) / ( temp_output_10_0_g91611 + 0.0001 ) ) );
				float3 ifLocalVar40_g91712 = 0;
				if( Debug_Type367_g91519 == 9.0 )
				ifLocalVar40_g91712 = Output_Globals888_g91519;
				float4 temp_output_35_0_g91695 = TVE_ColorsCoords;
				float temp_output_7_0_g91696 = 1.0;
				float2 temp_cast_46 = (temp_output_7_0_g91696).xx;
				float temp_output_10_0_g91696 = ( 1.0 - temp_output_7_0_g91696 );
				float2 temp_output_1583_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91695).zw + ( (temp_output_35_0_g91695).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_46 ) / temp_output_10_0_g91696 ) );
				float2 temp_output_1582_0_g91519 = ( temp_output_1583_0_g91519 * temp_output_1583_0_g91519 );
				float3 ifLocalVar40_g91716 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91716 = ( ( 1.0 - saturate( ( (temp_output_1582_0_g91519).x + (temp_output_1582_0_g91519).y ) ) ) * float3(0.5,0,0) );
				float4 temp_output_35_0_g91697 = TVE_ExtrasCoords;
				float temp_output_7_0_g91698 = 1.0;
				float2 temp_cast_47 = (temp_output_7_0_g91698).xx;
				float temp_output_10_0_g91698 = ( 1.0 - temp_output_7_0_g91698 );
				float2 temp_output_1602_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91697).zw + ( (temp_output_35_0_g91697).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_47 ) / temp_output_10_0_g91698 ) );
				float2 temp_output_1595_0_g91519 = ( temp_output_1602_0_g91519 * temp_output_1602_0_g91519 );
				float3 ifLocalVar40_g91717 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91717 = ( ( 1.0 - saturate( ( (temp_output_1595_0_g91519).x + (temp_output_1595_0_g91519).y ) ) ) * float3(0,0.5,0) );
				float4 temp_output_35_0_g91699 = TVE_MotionCoords;
				float temp_output_7_0_g91700 = 1.0;
				float2 temp_cast_48 = (temp_output_7_0_g91700).xx;
				float temp_output_10_0_g91700 = ( 1.0 - temp_output_7_0_g91700 );
				float2 temp_output_1615_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91699).zw + ( (temp_output_35_0_g91699).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_48 ) / temp_output_10_0_g91700 ) );
				float2 temp_output_1609_0_g91519 = ( temp_output_1615_0_g91519 * temp_output_1615_0_g91519 );
				float3 ifLocalVar40_g91718 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91718 = ( ( 1.0 - saturate( ( (temp_output_1609_0_g91519).x + (temp_output_1609_0_g91519).y ) ) ) * float3(0,0,1) );
				float4 temp_output_35_0_g91701 = TVE_VertexCoords;
				float temp_output_7_0_g91702 = 1.0;
				float2 temp_cast_49 = (temp_output_7_0_g91702).xx;
				float temp_output_10_0_g91702 = ( 1.0 - temp_output_7_0_g91702 );
				float2 temp_output_1628_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91701).zw + ( (temp_output_35_0_g91701).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_49 ) / temp_output_10_0_g91702 ) );
				float2 temp_output_1622_0_g91519 = ( temp_output_1628_0_g91519 * temp_output_1628_0_g91519 );
				float3 ifLocalVar40_g91719 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91719 = ( ( 1.0 - saturate( ( (temp_output_1622_0_g91519).x + (temp_output_1622_0_g91519).y ) ) ) * float3(0.5,0.5,0.5) );
				float3 Output_Volume1591_g91519 = saturate( ( ifLocalVar40_g91716 + ifLocalVar40_g91717 + ifLocalVar40_g91718 + ifLocalVar40_g91719 ) );
				float3 ifLocalVar40_g91713 = 0;
				if( Debug_Type367_g91519 == 10.0 )
				ifLocalVar40_g91713 = Output_Volume1591_g91519;
				float3 vertexToFrag328_g91519 = IN.ase_texcoord12.xyz;
				float4 color1016_g91519 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g91519 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g91519 = (((ase_vface>0)?(color1016_g91519):(color1017_g91519)));
				float3 ifLocalVar40_g91530 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91530 = (switchResult1015_g91519).rgb;
				float temp_output_7_0_g91688 = Debug_Min721_g91519;
				float3 temp_cast_51 = (temp_output_7_0_g91688).xxx;
				float temp_output_10_0_g91688 = ( Debug_Max723_g91519 - temp_output_7_0_g91688 );
				float Debug_Filter322_g91519 = TVE_DEBUG_Filter;
				float lerpResult1524_g91519 = lerp( 1.0 , _IsTVEShader647_g91519 , Debug_Filter322_g91519);
				float4 lerpResult1517_g91519 = lerp( Shading_Inactive1492_g91519 , float4( saturate( ( ( ( vertexToFrag328_g91519 + ifLocalVar40_g91530 ) - temp_cast_51 ) / ( temp_output_10_0_g91688 + 0.0001 ) ) ) , 0.0 ) , lerpResult1524_g91519);
				float4 Output_Mesh316_g91519 = lerpResult1517_g91519;
				float4 ifLocalVar40_g91714 = 0;
				if( Debug_Type367_g91519 == 11.0 )
				ifLocalVar40_g91714 = Output_Mesh316_g91519;
				float Debug_Clip623_g91519 = TVE_DEBUG_Clip;
				float lerpResult622_g91519 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g91519 * _RenderClip ));
				clip( lerpResult622_g91519 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = ( ( ifLocalVar40_g91703 + ifLocalVar40_g91704 + ifLocalVar40_g91705 + ifLocalVar40_g91706 + ifLocalVar40_g91707 + ifLocalVar40_g91708 ) + ( ifLocalVar40_g91709 + ifLocalVar40_g91710 + ifLocalVar40_g91711 ) + ( float4( ifLocalVar40_g91712 , 0.0 ) + float4( ifLocalVar40_g91713 , 0.0 ) + ifLocalVar40_g91714 ) ).rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed4 c = 0;
				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI(o, giInput, gi);
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					c += LightingStandardSpecular (o, worldViewDir, gi);
				#else
					c += LightingStandard( o, worldViewDir, gi );
				#endif

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;
					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
					c.rgb += o.Albedo * transmission;
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 lightDir = gi.light.dir + o.Normal * normal;
					half transVdotL = pow( saturate( dot( worldViewDir, -lightDir ) ), scattering );
					half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
					c.rgb += o.Albedo * translucency * strength;
				}
				#endif

				//#ifdef ASE_REFRACTION
				//	float4 projScreenPos = ScreenPos / ScreenPos.w;
				//	float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
				//	projScreenPos.xy += refractionOffset.xy;
				//	float3 refraction = UNITY_SAMPLE_SCREENSPACE_TEXTURE( _GrabTexture, projScreenPos ) * RefractionColor;
				//	color.rgb = lerp( refraction, color.rgb, color.a );
				//	color.a = 1;
				//#endif

				c.rgb += o.Emission;

				#ifdef ASE_FOG
					UNITY_APPLY_FOG(IN.fogCoord, c);
				#endif
				return c;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
			#define ASE_NO_AMBIENT 1
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma multi_compile_prepassfinal
			#ifndef UNITY_PASS_DEFERRED
				#define UNITY_PASS_DEFERRED
			#endif
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"

			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				float4 lmap : TEXCOORD2;
				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						half3 sh : TEXCOORD3;
					#endif
				#else
					#ifdef DIRLIGHTMAP_OFF
						float4 lmapFadePos : TEXCOORD4;
					#endif
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_color : COLOR;
				float4 ase_texcoord11 : TEXCOORD11;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef LIGHTMAP_ON
			float4 unity_LightmapFade;
			#endif
			fixed4 unity_Ambient;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform half _IsTVEShader;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsCollected;
			uniform float _IsBarkShader;
			uniform float _IsPlantShader;
			uniform float _IsPropShader;
			uniform float _IsCoreShader;
			uniform float _IsBlanketShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsLiteShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform float _IsCustomShader;
			uniform float _IsIdentifier;
			uniform half TVE_DEBUG_Index;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
			uniform half4 _MainUVs;
			SamplerState sampler_MainAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
			SamplerState sampler_MainNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
			SamplerState sampler_MainMaskTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			SamplerState sampler_SecondAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
			SamplerState sampler_SecondNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
			SamplerState sampler_SecondMaskTex;
			uniform float _DetailMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
			uniform half4 _EmissiveUVs;
			SamplerState sampler_EmissiveTex;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform float4 _MainAlbedoTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
			SamplerState samplerTVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
			uniform float _MotionScale_10;
			uniform half TVE_NoiseTexTilling;
			uniform half4 TVE_MotionParams;
			uniform half4 TVE_TimeParams;
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexPivotMode;
			uniform half _VertexDynamicMode;
			SamplerState sampler_Linear_Repeat;
			uniform half TVE_DEBUG_Layer;
			uniform float TVE_ColorsUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			SamplerState sampler_Linear_Clamp;
			uniform half4 TVE_ColorsParams;
			uniform float TVE_ExtrasUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_ExtrasParams;
			uniform float TVE_MotionUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform float TVE_VertexUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform half4 TVE_VertexParams;
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;


			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float Debug_Index464_g91519 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g91525 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91525 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g91543 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91543 = v.normal;
				float3 ifLocalVar40_g91556 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91556 = v.tangent.xyz;
				float ifLocalVar40_g91540 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91540 = saturate( v.tangent.w );
				float ifLocalVar40_g91640 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91640 = v.ase_color.r;
				float ifLocalVar40_g91641 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91641 = v.ase_color.g;
				float ifLocalVar40_g91642 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91642 = v.ase_color.b;
				float ifLocalVar40_g91643 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91643 = v.ase_color.a;
				float3 appendResult1147_g91519 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g91650 = 0;
				if( Debug_Index464_g91519 == 9.0 )
				ifLocalVar40_g91650 = appendResult1147_g91519;
				float3 appendResult1148_g91519 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g91651 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91651 = appendResult1148_g91519;
				float3 appendResult1149_g91519 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g91652 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91652 = appendResult1149_g91519;
				half3 Input_Position167_g91644 = float3( 0,0,0 );
				float dotResult156_g91644 = dot( (Input_Position167_g91644).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91644 = 0.0;
				float Postion_Random162_g91644 = ( sin( dotResult156_g91644 ) * ( 1.0 - Input_DynamicMode120_g91644 ) );
				half Input_Variation124_g91644 = v.ase_color.r;
				half ObjectData20_g91646 = frac( ( Postion_Random162_g91644 + Input_Variation124_g91644 ) );
				half WorldData19_g91646 = Input_Variation124_g91644;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91646 = WorldData19_g91646;
				#else
				float staticSwitch14_g91646 = ObjectData20_g91646;
				#endif
				float temp_output_112_0_g91644 = staticSwitch14_g91646;
				float clampResult171_g91644 = clamp( temp_output_112_0_g91644 , 0.01 , 0.99 );
				float ifLocalVar40_g91653 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91653 = clampResult171_g91644;
				float ifLocalVar40_g91654 = 0;
				if( Debug_Index464_g91519 == 13.0 )
				ifLocalVar40_g91654 = v.ase_color.g;
				float ifLocalVar40_g91655 = 0;
				if( Debug_Index464_g91519 == 14.0 )
				ifLocalVar40_g91655 = v.ase_color.b;
				float ifLocalVar40_g91656 = 0;
				if( Debug_Index464_g91519 == 15.0 )
				ifLocalVar40_g91656 = v.ase_color.a;
				half3 Input_Position167_g91661 = float3( 0,0,0 );
				float dotResult156_g91661 = dot( (Input_Position167_g91661).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91661 = 0.0;
				float Postion_Random162_g91661 = ( sin( dotResult156_g91661 ) * ( 1.0 - Input_DynamicMode120_g91661 ) );
				half Input_Variation124_g91661 = v.ase_color.r;
				half ObjectData20_g91663 = frac( ( Postion_Random162_g91661 + Input_Variation124_g91661 ) );
				half WorldData19_g91663 = Input_Variation124_g91661;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91663 = WorldData19_g91663;
				#else
				float staticSwitch14_g91663 = ObjectData20_g91663;
				#endif
				float temp_output_112_0_g91661 = staticSwitch14_g91663;
				float clampResult171_g91661 = clamp( temp_output_112_0_g91661 , 0.01 , 0.99 );
				float temp_output_1451_19_g91519 = clampResult171_g91661;
				float3 temp_cast_0 = (temp_output_1451_19_g91519).xxx;
				float3 hsvTorgb260_g91519 = HSVToRGB( float3(temp_output_1451_19_g91519,1.0,1.0) );
				float3 gammaToLinear266_g91519 = GammaToLinearSpace( hsvTorgb260_g91519 );
				float _IsBarkShader347_g91519 = _IsBarkShader;
				float _IsPlantShader360_g91519 = _IsPlantShader;
				float _IsAnyVegetationShader362_g91519 = saturate( ( _IsBarkShader347_g91519 + _IsPlantShader360_g91519 ) );
				float3 lerpResult290_g91519 = lerp( temp_cast_0 , gammaToLinear266_g91519 , _IsAnyVegetationShader362_g91519);
				float3 ifLocalVar40_g91657 = 0;
				if( Debug_Index464_g91519 == 16.0 )
				ifLocalVar40_g91657 = lerpResult290_g91519;
				float enc1154_g91519 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g91519 = DecodeFloatToVector2( enc1154_g91519 );
				float2 break1155_g91519 = localDecodeFloatToVector21154_g91519;
				float ifLocalVar40_g91658 = 0;
				if( Debug_Index464_g91519 == 17.0 )
				ifLocalVar40_g91658 = break1155_g91519.x;
				float ifLocalVar40_g91659 = 0;
				if( Debug_Index464_g91519 == 18.0 )
				ifLocalVar40_g91659 = break1155_g91519.y;
				float3 appendResult60_g91649 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g91660 = 0;
				if( Debug_Index464_g91519 == 19.0 )
				ifLocalVar40_g91660 = appendResult60_g91649;
				float3 vertexToFrag328_g91519 = ( ( ifLocalVar40_g91525 + ifLocalVar40_g91543 + ifLocalVar40_g91556 + ifLocalVar40_g91540 ) + ( ifLocalVar40_g91640 + ifLocalVar40_g91641 + ifLocalVar40_g91642 + ifLocalVar40_g91643 ) + ( ifLocalVar40_g91650 + ifLocalVar40_g91651 + ifLocalVar40_g91652 ) + ( ifLocalVar40_g91653 + ifLocalVar40_g91654 + ifLocalVar40_g91655 + ifLocalVar40_g91656 ) + ( ifLocalVar40_g91657 + ifLocalVar40_g91658 + ifLocalVar40_g91659 + ifLocalVar40_g91660 ) );
				o.ase_texcoord11.xyz = vertexToFrag328_g91519;
				
				o.ase_texcoord8 = v.ase_texcoord;
				o.ase_texcoord9 = v.texcoord1.xyzw;
				o.ase_texcoord10 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord11.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
					o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#else
					o.lmap.zw = 0;
				#endif
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#ifdef DIRLIGHTMAP_OFF
						o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
						o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
					#endif
				#else
					o.lmap.xy = 0;
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag (v2f IN , bool ase_vface : SV_IsFrontFace
				, out half4 outGBuffer0 : SV_Target0
				, out half4 outGBuffer1 : SV_Target1
				, out half4 outGBuffer2 : SV_Target2
				, out half4 outEmission : SV_Target3
				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
				, out half4 outShadowMask : SV_Target4
				#endif
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
			)
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				half atten = 1;

				float Debug_Type367_g91519 = TVE_DEBUG_Type;
				float4 color690_g91519 = IsGammaSpace() ? float4(0.25,0.25,0.25,0) : float4(0.05087609,0.05087609,0.05087609,0);
				float4 Shading_Inactive1492_g91519 = color690_g91519;
				float4 color646_g91519 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1359_g91519 = IsGammaSpace() ? float4(0,0.8683633,0.8862745,1) : float4(0,0.7262539,0.7605246,1);
				float _IsCollected1458_g91519 = _IsCollected;
				float4 lerpResult1360_g91519 = lerp( color646_g91519 , color1359_g91519 , _IsCollected1458_g91519);
				float _IsTVEShader647_g91519 = _IsTVEShader;
				float4 lerpResult1494_g91519 = lerp( Shading_Inactive1492_g91519 , lerpResult1360_g91519 , _IsTVEShader647_g91519);
				float dotResult1472_g91519 = dot( WorldNormal , worldViewDir );
				float temp_output_1526_0_g91519 = ( 1.0 - saturate( dotResult1472_g91519 ) );
				float Shading_Fresnel1469_g91519 = (( 1.0 - ( temp_output_1526_0_g91519 * temp_output_1526_0_g91519 ) )*0.3 + 0.7);
				float4 Output_Converted717_g91519 = ( lerpResult1494_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91703 = 0;
				if( Debug_Type367_g91519 == 0.0 )
				ifLocalVar40_g91703 = Output_Converted717_g91519;
				float4 color466_g91519 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g91519 = _IsBarkShader;
				float4 color472_g91519 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsPlantShader360_g91519 = _IsPlantShader;
				float4 color478_g91519 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g91519 = _IsPropShader;
				float4 lerpResult1502_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color466_g91519 * _IsBarkShader347_g91519 ) + ( color472_g91519 * _IsPlantShader360_g91519 ) + ( color478_g91519 * _IsPropShader346_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Shader445_g91519 = ( lerpResult1502_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91704 = 0;
				if( Debug_Type367_g91519 == 1.0 )
				ifLocalVar40_g91704 = Output_Shader445_g91519;
				float4 color1529_g91519 = IsGammaSpace() ? float4(0.9254902,0.7960784,0.4156863,1) : float4(0.8387991,0.5972018,0.1441285,1);
				float _IsCoreShader1551_g91519 = _IsCoreShader;
				float4 color1539_g91519 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsBlanketShader1554_g91519 = _IsBlanketShader;
				float4 color1542_g91519 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g91519 = _IsImpostorShader;
				float4 color1544_g91519 = IsGammaSpace() ? float4(0.3254902,0.6117647,0.8117647,0) : float4(0.08650047,0.3324516,0.6239604,0);
				float _IsPolygonalShader1112_g91519 = _IsPolygonalShader;
				float4 color1649_g91519 = IsGammaSpace() ? float4(0.6,0.6,0.6,0) : float4(0.3185468,0.3185468,0.3185468,0);
				float _IsLiteShader1648_g91519 = _IsLiteShader;
				float4 lerpResult1535_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color1529_g91519 * _IsCoreShader1551_g91519 ) + ( color1539_g91519 * _IsBlanketShader1554_g91519 ) + ( color1542_g91519 * _IsImpostorShader1110_g91519 ) + ( color1544_g91519 * _IsPolygonalShader1112_g91519 ) + ( color1649_g91519 * _IsLiteShader1648_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Scope1531_g91519 = ( lerpResult1535_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91705 = 0;
				if( Debug_Type367_g91519 == 2.0 )
				ifLocalVar40_g91705 = Output_Scope1531_g91519;
				float4 color529_g91519 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g91519 = _IsVertexShader;
				float4 color544_g91519 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g91519 = _IsSimpleShader;
				float4 color521_g91519 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g91519 = _IsStandardShader;
				float4 color1121_g91519 = IsGammaSpace() ? float4(0.9716981,0.88463,0.1787558,0) : float4(0.9368213,0.7573396,0.02686729,0);
				float _IsSubsurfaceShader548_g91519 = _IsSubsurfaceShader;
				float4 lerpResult1507_g91519 = lerp( Shading_Inactive1492_g91519 , ( ( color529_g91519 * _IsVertexShader1158_g91519 ) + ( color544_g91519 * _IsSimpleShader359_g91519 ) + ( color521_g91519 * _IsStandardShader344_g91519 ) + ( color1121_g91519 * _IsSubsurfaceShader548_g91519 ) ) , _IsTVEShader647_g91519);
				float4 Output_Lighting525_g91519 = ( lerpResult1507_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91706 = 0;
				if( Debug_Type367_g91519 == 3.0 )
				ifLocalVar40_g91706 = Output_Lighting525_g91519;
				float4 color1559_g91519 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1563_g91519 = IsGammaSpace() ? float4(0.3053578,0.8867924,0.5362216,0) : float4(0.0759199,0.7615293,0.2491121,0);
				float _IsCustomShader1570_g91519 = _IsCustomShader;
				float4 lerpResult1561_g91519 = lerp( color1559_g91519 , color1563_g91519 , _IsCustomShader1570_g91519);
				float4 lerpResult1566_g91519 = lerp( Shading_Inactive1492_g91519 , lerpResult1561_g91519 , _IsTVEShader647_g91519);
				float4 Output_Custom1560_g91519 = ( lerpResult1566_g91519 * Shading_Fresnel1469_g91519 );
				float4 ifLocalVar40_g91707 = 0;
				if( Debug_Type367_g91519 == 4.0 )
				ifLocalVar40_g91707 = Output_Custom1560_g91519;
				float3 hsvTorgb1452_g91519 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
				float3 gammaToLinear1453_g91519 = GammaToLinearSpace( hsvTorgb1452_g91519 );
				float4 lerpResult1512_g91519 = lerp( Shading_Inactive1492_g91519 , float4( gammaToLinear1453_g91519 , 0.0 ) , _IsTVEShader647_g91519);
				float4 Output_Sharing1355_g91519 = lerpResult1512_g91519;
				float4 ifLocalVar40_g91708 = 0;
				if( Debug_Type367_g91519 == 5.0 )
				ifLocalVar40_g91708 = Output_Sharing1355_g91519;
				float Debug_Index464_g91519 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g91519 = ( ( IN.ase_texcoord8.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g91519 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g91519 );
				float3 appendResult637_g91519 = (float3(tex2DNode586_g91519.r , tex2DNode586_g91519.g , tex2DNode586_g91519.b));
				float3 ifLocalVar40_g91542 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91542 = appendResult637_g91519;
				float ifLocalVar40_g91547 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91547 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g91519 ).a;
				float4 tex2DNode604_g91519 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g91519 );
				float3 appendResult876_g91519 = (float3(tex2DNode604_g91519.a , tex2DNode604_g91519.g , 1.0));
				float3 gammaToLinear878_g91519 = GammaToLinearSpace( appendResult876_g91519 );
				float3 ifLocalVar40_g91577 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91577 = gammaToLinear878_g91519;
				float ifLocalVar40_g91528 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91528 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).r;
				float ifLocalVar40_g91610 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91610 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).g;
				float ifLocalVar40_g91548 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91548 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).b;
				float ifLocalVar40_g91526 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91526 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g91519 ).a;
				float2 appendResult1251_g91519 = (float2(IN.ase_texcoord9.z , IN.ase_texcoord9.w));
				float2 Mesh_DetailCoord1254_g91519 = appendResult1251_g91519;
				float2 lerpResult1231_g91519 = lerp( IN.ase_texcoord8.xy , Mesh_DetailCoord1254_g91519 , _DetailCoordMode);
				half2 Second_UVs1234_g91519 = ( ( lerpResult1231_g91519 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g91519 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g91519 );
				float3 appendResult839_g91519 = (float3(tex2DNode854_g91519.r , tex2DNode854_g91519.g , tex2DNode854_g91519.b));
				float3 ifLocalVar40_g91539 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91539 = appendResult839_g91519;
				float ifLocalVar40_g91555 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91555 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g91519 ).a;
				float4 tex2DNode841_g91519 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Second_UVs1234_g91519 );
				float3 appendResult880_g91519 = (float3(tex2DNode841_g91519.a , tex2DNode841_g91519.g , 1.0));
				float3 gammaToLinear879_g91519 = GammaToLinearSpace( appendResult880_g91519 );
				float3 ifLocalVar40_g91598 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91598 = gammaToLinear879_g91519;
				float ifLocalVar40_g91578 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91578 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).r;
				float ifLocalVar40_g91546 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91546 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).g;
				float ifLocalVar40_g91590 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91590 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).b;
				float ifLocalVar40_g91597 = 0;
				if( Debug_Index464_g91519 == 13.0 )
				ifLocalVar40_g91597 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g91519 ).a;
				half2 Emissive_UVs1245_g91519 = ( ( IN.ase_texcoord8.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g91519 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g91519 );
				float ifLocalVar40_g91545 = 0;
				if( Debug_Index464_g91519 == 14.0 )
				ifLocalVar40_g91545 = tex2DNode858_g91519.r;
				float Debug_Min721_g91519 = TVE_DEBUG_Min;
				float temp_output_7_0_g91584 = Debug_Min721_g91519;
				float4 temp_cast_3 = (temp_output_7_0_g91584).xxxx;
				float Debug_Max723_g91519 = TVE_DEBUG_Max;
				float temp_output_10_0_g91584 = ( Debug_Max723_g91519 - temp_output_7_0_g91584 );
				float4 Output_Maps561_g91519 = saturate( ( ( ( float4( ( ( ifLocalVar40_g91542 + ifLocalVar40_g91547 + ifLocalVar40_g91577 ) + ( ifLocalVar40_g91528 + ifLocalVar40_g91610 + ifLocalVar40_g91548 + ifLocalVar40_g91526 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g91539 + ifLocalVar40_g91555 + ifLocalVar40_g91598 ) + ( ifLocalVar40_g91578 + ifLocalVar40_g91546 + ifLocalVar40_g91590 + ifLocalVar40_g91597 ) ) * _DetailMode ) , 0.0 ) + ( ( ifLocalVar40_g91545 * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( temp_output_10_0_g91584 + 0.0001 ) ) );
				float4 ifLocalVar40_g91709 = 0;
				if( Debug_Type367_g91519 == 6.0 )
				ifLocalVar40_g91709 = Output_Maps561_g91519;
				float Resolution44_g91628 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g91628 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91628 = 0;
				if( Resolution44_g91628 <= 256.0 )
				ifLocalVar61_g91628 = color62_g91628;
				float4 color55_g91628 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91628 = 0;
				if( Resolution44_g91628 == 512.0 )
				ifLocalVar56_g91628 = color55_g91628;
				float4 color42_g91628 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91628 = 0;
				if( Resolution44_g91628 == 1024.0 )
				ifLocalVar40_g91628 = color42_g91628;
				float4 color48_g91628 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91628 = 0;
				if( Resolution44_g91628 == 2048.0 )
				ifLocalVar47_g91628 = color48_g91628;
				float4 color51_g91628 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91628 = 0;
				if( Resolution44_g91628 >= 4096.0 )
				ifLocalVar52_g91628 = color51_g91628;
				float4 ifLocalVar40_g91614 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91614 = ( ifLocalVar61_g91628 + ifLocalVar56_g91628 + ifLocalVar40_g91628 + ifLocalVar47_g91628 + ifLocalVar52_g91628 );
				float Resolution44_g91627 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g91627 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91627 = 0;
				if( Resolution44_g91627 <= 256.0 )
				ifLocalVar61_g91627 = color62_g91627;
				float4 color55_g91627 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91627 = 0;
				if( Resolution44_g91627 == 512.0 )
				ifLocalVar56_g91627 = color55_g91627;
				float4 color42_g91627 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91627 = 0;
				if( Resolution44_g91627 == 1024.0 )
				ifLocalVar40_g91627 = color42_g91627;
				float4 color48_g91627 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91627 = 0;
				if( Resolution44_g91627 == 2048.0 )
				ifLocalVar47_g91627 = color48_g91627;
				float4 color51_g91627 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91627 = 0;
				if( Resolution44_g91627 >= 4096.0 )
				ifLocalVar52_g91627 = color51_g91627;
				float4 ifLocalVar40_g91612 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91612 = ( ifLocalVar61_g91627 + ifLocalVar56_g91627 + ifLocalVar40_g91627 + ifLocalVar47_g91627 + ifLocalVar52_g91627 );
				float Resolution44_g91626 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g91626 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91626 = 0;
				if( Resolution44_g91626 <= 256.0 )
				ifLocalVar61_g91626 = color62_g91626;
				float4 color55_g91626 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91626 = 0;
				if( Resolution44_g91626 == 512.0 )
				ifLocalVar56_g91626 = color55_g91626;
				float4 color42_g91626 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91626 = 0;
				if( Resolution44_g91626 == 1024.0 )
				ifLocalVar40_g91626 = color42_g91626;
				float4 color48_g91626 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91626 = 0;
				if( Resolution44_g91626 == 2048.0 )
				ifLocalVar47_g91626 = color48_g91626;
				float4 color51_g91626 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91626 = 0;
				if( Resolution44_g91626 >= 4096.0 )
				ifLocalVar52_g91626 = color51_g91626;
				float4 ifLocalVar40_g91613 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91613 = ( ifLocalVar61_g91626 + ifLocalVar56_g91626 + ifLocalVar40_g91626 + ifLocalVar47_g91626 + ifLocalVar52_g91626 );
				float Resolution44_g91633 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g91633 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91633 = 0;
				if( Resolution44_g91633 <= 256.0 )
				ifLocalVar61_g91633 = color62_g91633;
				float4 color55_g91633 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91633 = 0;
				if( Resolution44_g91633 == 512.0 )
				ifLocalVar56_g91633 = color55_g91633;
				float4 color42_g91633 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91633 = 0;
				if( Resolution44_g91633 == 1024.0 )
				ifLocalVar40_g91633 = color42_g91633;
				float4 color48_g91633 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91633 = 0;
				if( Resolution44_g91633 == 2048.0 )
				ifLocalVar47_g91633 = color48_g91633;
				float4 color51_g91633 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91633 = 0;
				if( Resolution44_g91633 >= 4096.0 )
				ifLocalVar52_g91633 = color51_g91633;
				float4 ifLocalVar40_g91620 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91620 = ( ifLocalVar61_g91633 + ifLocalVar56_g91633 + ifLocalVar40_g91633 + ifLocalVar47_g91633 + ifLocalVar52_g91633 );
				float Resolution44_g91632 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g91632 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91632 = 0;
				if( Resolution44_g91632 <= 256.0 )
				ifLocalVar61_g91632 = color62_g91632;
				float4 color55_g91632 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91632 = 0;
				if( Resolution44_g91632 == 512.0 )
				ifLocalVar56_g91632 = color55_g91632;
				float4 color42_g91632 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91632 = 0;
				if( Resolution44_g91632 == 1024.0 )
				ifLocalVar40_g91632 = color42_g91632;
				float4 color48_g91632 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91632 = 0;
				if( Resolution44_g91632 == 2048.0 )
				ifLocalVar47_g91632 = color48_g91632;
				float4 color51_g91632 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91632 = 0;
				if( Resolution44_g91632 >= 4096.0 )
				ifLocalVar52_g91632 = color51_g91632;
				float4 ifLocalVar40_g91618 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91618 = ( ifLocalVar61_g91632 + ifLocalVar56_g91632 + ifLocalVar40_g91632 + ifLocalVar47_g91632 + ifLocalVar52_g91632 );
				float Resolution44_g91634 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g91634 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91634 = 0;
				if( Resolution44_g91634 <= 256.0 )
				ifLocalVar61_g91634 = color62_g91634;
				float4 color55_g91634 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91634 = 0;
				if( Resolution44_g91634 == 512.0 )
				ifLocalVar56_g91634 = color55_g91634;
				float4 color42_g91634 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91634 = 0;
				if( Resolution44_g91634 == 1024.0 )
				ifLocalVar40_g91634 = color42_g91634;
				float4 color48_g91634 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91634 = 0;
				if( Resolution44_g91634 == 2048.0 )
				ifLocalVar47_g91634 = color48_g91634;
				float4 color51_g91634 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91634 = 0;
				if( Resolution44_g91634 >= 4096.0 )
				ifLocalVar52_g91634 = color51_g91634;
				float4 ifLocalVar40_g91619 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91619 = ( ifLocalVar61_g91634 + ifLocalVar56_g91634 + ifLocalVar40_g91634 + ifLocalVar47_g91634 + ifLocalVar52_g91634 );
				float Resolution44_g91631 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g91631 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g91631 = 0;
				if( Resolution44_g91631 <= 256.0 )
				ifLocalVar61_g91631 = color62_g91631;
				float4 color55_g91631 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g91631 = 0;
				if( Resolution44_g91631 == 512.0 )
				ifLocalVar56_g91631 = color55_g91631;
				float4 color42_g91631 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g91631 = 0;
				if( Resolution44_g91631 == 1024.0 )
				ifLocalVar40_g91631 = color42_g91631;
				float4 color48_g91631 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g91631 = 0;
				if( Resolution44_g91631 == 2048.0 )
				ifLocalVar47_g91631 = color48_g91631;
				float4 color51_g91631 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g91631 = 0;
				if( Resolution44_g91631 >= 4096.0 )
				ifLocalVar52_g91631 = color51_g91631;
				float4 ifLocalVar40_g91621 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91621 = ( ifLocalVar61_g91631 + ifLocalVar56_g91631 + ifLocalVar40_g91631 + ifLocalVar47_g91631 + ifLocalVar52_g91631 );
				float4 Output_Resolution737_g91519 = ( ( ifLocalVar40_g91614 + ifLocalVar40_g91612 + ifLocalVar40_g91613 ) + ( ifLocalVar40_g91620 + ifLocalVar40_g91618 + ifLocalVar40_g91619 ) + ifLocalVar40_g91621 );
				float4 ifLocalVar40_g91710 = 0;
				if( Debug_Type367_g91519 == 7.0 )
				ifLocalVar40_g91710 = Output_Resolution737_g91519;
				float2 uv_MainAlbedoTex = IN.ase_texcoord8.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float2 UVs72_g91639 = Main_UVs1219_g91519;
				float Resolution44_g91639 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91639 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91639 * ( Resolution44_g91639 / 8.0 ) ) );
				float4 lerpResult78_g91639 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g91639 , tex2DNode77_g91639.a);
				float4 ifLocalVar40_g91617 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91617 = lerpResult78_g91639;
				float2 uv_MainNormalTex = IN.ase_texcoord8.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g91630 = Main_UVs1219_g91519;
				float Resolution44_g91630 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g91630 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91630 * ( Resolution44_g91630 / 8.0 ) ) );
				float4 lerpResult78_g91630 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g91630 , tex2DNode77_g91630.a);
				float4 ifLocalVar40_g91615 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91615 = lerpResult78_g91630;
				float2 uv_MainMaskTex = IN.ase_texcoord8.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g91629 = Main_UVs1219_g91519;
				float Resolution44_g91629 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g91629 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91629 * ( Resolution44_g91629 / 8.0 ) ) );
				float4 lerpResult78_g91629 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g91629 , tex2DNode77_g91629.a);
				float4 ifLocalVar40_g91616 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91616 = lerpResult78_g91629;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord8.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g91637 = Second_UVs1234_g91519;
				float Resolution44_g91637 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91637 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91637 * ( Resolution44_g91637 / 8.0 ) ) );
				float4 lerpResult78_g91637 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g91637 , tex2DNode77_g91637.a);
				float4 ifLocalVar40_g91624 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91624 = lerpResult78_g91637;
				float2 uv_SecondMaskTex = IN.ase_texcoord8.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g91636 = Second_UVs1234_g91519;
				float Resolution44_g91636 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g91636 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91636 * ( Resolution44_g91636 / 8.0 ) ) );
				float4 lerpResult78_g91636 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g91636 , tex2DNode77_g91636.a);
				float4 ifLocalVar40_g91622 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91622 = lerpResult78_g91636;
				float2 UVs72_g91638 = Second_UVs1234_g91519;
				float Resolution44_g91638 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g91638 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91638 * ( Resolution44_g91638 / 8.0 ) ) );
				float4 lerpResult78_g91638 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g91638 , tex2DNode77_g91638.a);
				float4 ifLocalVar40_g91623 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91623 = lerpResult78_g91638;
				float2 uv_EmissiveTex = IN.ase_texcoord8.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g91635 = Emissive_UVs1245_g91519;
				float Resolution44_g91635 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g91635 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g91635 * ( Resolution44_g91635 / 8.0 ) ) );
				float4 lerpResult78_g91635 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g91635 , tex2DNode77_g91635.a);
				float4 ifLocalVar40_g91625 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91625 = lerpResult78_g91635;
				float4 Output_MipLevel1284_g91519 = ( ( ifLocalVar40_g91617 + ifLocalVar40_g91615 + ifLocalVar40_g91616 ) + ( ifLocalVar40_g91624 + ifLocalVar40_g91622 + ifLocalVar40_g91623 ) + ifLocalVar40_g91625 );
				float4 ifLocalVar40_g91711 = 0;
				if( Debug_Type367_g91519 == 8.0 )
				ifLocalVar40_g91711 = Output_MipLevel1284_g91519;
				float3 WorldPosition893_g91519 = worldPos;
				half3 Input_Position419_g91667 = WorldPosition893_g91519;
				float Input_MotionScale287_g91667 = ( _MotionScale_10 + 0.2 );
				half NoiseTex_Tilling735_g91667 = TVE_NoiseTexTilling;
				float2 temp_output_597_0_g91667 = (( Input_Position419_g91667 * Input_MotionScale287_g91667 * NoiseTex_Tilling735_g91667 * 0.0075 )).xz;
				float2 temp_output_447_0_g91671 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g91519 = temp_output_447_0_g91671;
				half2 Input_DirectionWS423_g91667 = Wind_DirectionWS1031_g91519;
				float lerpResult128_g91668 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Input_MotionSpeed62_g91667 = _MotionSpeed_10;
				half Input_MotionVariation284_g91667 = _MotionVariation_10;
				float4x4 break19_g91674 = unity_ObjectToWorld;
				float3 appendResult20_g91674 = (float3(break19_g91674[ 0 ][ 3 ] , break19_g91674[ 1 ][ 3 ] , break19_g91674[ 2 ][ 3 ]));
				float3 appendResult60_g91673 = (float3(IN.ase_texcoord10.x , IN.ase_texcoord10.z , IN.ase_texcoord10.y));
				float3 temp_output_122_0_g91674 = ( appendResult60_g91673 * _VertexPivotMode );
				float3 PivotsOnly105_g91674 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g91674 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g91676 = ( appendResult20_g91674 + PivotsOnly105_g91674 );
				half3 WorldData19_g91676 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g91676 = WorldData19_g91676;
				#else
				float3 staticSwitch14_g91676 = ObjectData20_g91676;
				#endif
				float3 temp_output_114_0_g91674 = staticSwitch14_g91676;
				half3 ObjectData20_g91666 = temp_output_114_0_g91674;
				half3 WorldData19_g91666 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g91666 = WorldData19_g91666;
				#else
				float3 staticSwitch14_g91666 = ObjectData20_g91666;
				#endif
				float3 ObjectPosition890_g91519 = staticSwitch14_g91666;
				half3 Input_Position167_g91683 = ObjectPosition890_g91519;
				float dotResult156_g91683 = dot( (Input_Position167_g91683).xz , float2( 12.9898,78.233 ) );
				half Input_DynamicMode120_g91683 = _VertexDynamicMode;
				float Postion_Random162_g91683 = ( sin( dotResult156_g91683 ) * ( 1.0 - Input_DynamicMode120_g91683 ) );
				half Input_Variation124_g91683 = IN.ase_color.r;
				half ObjectData20_g91685 = frac( ( Postion_Random162_g91683 + Input_Variation124_g91683 ) );
				half WorldData19_g91685 = Input_Variation124_g91683;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g91685 = WorldData19_g91685;
				#else
				float staticSwitch14_g91685 = ObjectData20_g91685;
				#endif
				float temp_output_112_0_g91683 = staticSwitch14_g91685;
				float clampResult171_g91683 = clamp( temp_output_112_0_g91683 , 0.01 , 0.99 );
				half Global_MeshVariation1176_g91519 = clampResult171_g91683;
				half Input_GlobalMeshVariation569_g91667 = Global_MeshVariation1176_g91519;
				float temp_output_630_0_g91667 = ( ( ( lerpResult128_g91668 * Input_MotionSpeed62_g91667 ) + ( Input_MotionVariation284_g91667 * Input_GlobalMeshVariation569_g91667 ) ) * 0.03 );
				float temp_output_607_0_g91667 = frac( temp_output_630_0_g91667 );
				float4 lerpResult590_g91667 = lerp( SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g91667 + ( -Input_DirectionWS423_g91667 * temp_output_607_0_g91667 ) ) ) , SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g91667 + ( -Input_DirectionWS423_g91667 * frac( ( temp_output_630_0_g91667 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g91667 - 0.5 ) ) / 0.5 ));
				half4 Noise_Complex703_g91667 = lerpResult590_g91667;
				float2 temp_output_645_0_g91667 = ((Noise_Complex703_g91667).rg*2.0 + -1.0);
				float2 break650_g91667 = temp_output_645_0_g91667;
				float3 appendResult649_g91667 = (float3(break650_g91667.x , 0.0 , break650_g91667.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
				half2 Motion_Noise915_g91519 = (( mul( unity_WorldToObject, float4( appendResult649_g91667 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				float3 appendResult1180_g91519 = (float3(Motion_Noise915_g91519 , 0.0));
				float3 ifLocalVar40_g91529 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91529 = appendResult1180_g91519;
				float Debug_Layer885_g91519 = TVE_DEBUG_Layer;
				float temp_output_82_0_g91572 = Debug_Layer885_g91519;
				float temp_output_19_0_g91576 = TVE_ColorsUsage[(int)temp_output_82_0_g91572];
				float4 temp_output_91_19_g91572 = TVE_ColorsCoords;
				half2 UV94_g91572 = ( (temp_output_91_19_g91572).zw + ( (temp_output_91_19_g91572).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode83_g91572 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g91572,temp_output_82_0_g91572), 0.0 );
				float4 temp_output_17_0_g91576 = tex2DArrayNode83_g91572;
				float4 temp_output_92_86_g91572 = TVE_ColorsParams;
				float4 temp_output_3_0_g91576 = temp_output_92_86_g91572;
				float4 ifLocalVar18_g91576 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91576 >= 0.5 )
				ifLocalVar18_g91576 = temp_output_17_0_g91576;
				else
				ifLocalVar18_g91576 = temp_output_3_0_g91576;
				float4 lerpResult22_g91576 = lerp( temp_output_3_0_g91576 , temp_output_17_0_g91576 , temp_output_19_0_g91576);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91576 = lerpResult22_g91576;
				#else
				float4 staticSwitch24_g91576 = ifLocalVar18_g91576;
				#endif
				float3 ifLocalVar40_g91544 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91544 = (staticSwitch24_g91576).rgb;
				float temp_output_82_0_g91557 = Debug_Layer885_g91519;
				float temp_output_19_0_g91561 = TVE_ColorsUsage[(int)temp_output_82_0_g91557];
				float4 temp_output_91_19_g91557 = TVE_ColorsCoords;
				half2 UV94_g91557 = ( (temp_output_91_19_g91557).zw + ( (temp_output_91_19_g91557).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode83_g91557 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g91557,temp_output_82_0_g91557), 0.0 );
				float4 temp_output_17_0_g91561 = tex2DArrayNode83_g91557;
				float4 temp_output_92_86_g91557 = TVE_ColorsParams;
				float4 temp_output_3_0_g91561 = temp_output_92_86_g91557;
				float4 ifLocalVar18_g91561 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91561 >= 0.5 )
				ifLocalVar18_g91561 = temp_output_17_0_g91561;
				else
				ifLocalVar18_g91561 = temp_output_3_0_g91561;
				float4 lerpResult22_g91561 = lerp( temp_output_3_0_g91561 , temp_output_17_0_g91561 , temp_output_19_0_g91561);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91561 = lerpResult22_g91561;
				#else
				float4 staticSwitch24_g91561 = ifLocalVar18_g91561;
				#endif
				float ifLocalVar40_g91554 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91554 = saturate( (staticSwitch24_g91561).a );
				float temp_output_84_0_g91567 = Debug_Layer885_g91519;
				float temp_output_19_0_g91571 = TVE_ExtrasUsage[(int)temp_output_84_0_g91567];
				float4 temp_output_93_19_g91567 = TVE_ExtrasCoords;
				half2 UV96_g91567 = ( (temp_output_93_19_g91567).zw + ( (temp_output_93_19_g91567).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91567 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91567,temp_output_84_0_g91567), 0.0 );
				float4 temp_output_17_0_g91571 = tex2DArrayNode48_g91567;
				float4 temp_output_94_85_g91567 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91571 = temp_output_94_85_g91567;
				float4 ifLocalVar18_g91571 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91571 >= 0.5 )
				ifLocalVar18_g91571 = temp_output_17_0_g91571;
				else
				ifLocalVar18_g91571 = temp_output_3_0_g91571;
				float4 lerpResult22_g91571 = lerp( temp_output_3_0_g91571 , temp_output_17_0_g91571 , temp_output_19_0_g91571);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91571 = lerpResult22_g91571;
				#else
				float4 staticSwitch24_g91571 = ifLocalVar18_g91571;
				#endif
				float ifLocalVar40_g91537 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91537 = (staticSwitch24_g91571).r;
				float temp_output_84_0_g91520 = Debug_Layer885_g91519;
				float temp_output_19_0_g91524 = TVE_ExtrasUsage[(int)temp_output_84_0_g91520];
				float4 temp_output_93_19_g91520 = TVE_ExtrasCoords;
				half2 UV96_g91520 = ( (temp_output_93_19_g91520).zw + ( (temp_output_93_19_g91520).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91520 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91520,temp_output_84_0_g91520), 0.0 );
				float4 temp_output_17_0_g91524 = tex2DArrayNode48_g91520;
				float4 temp_output_94_85_g91520 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91524 = temp_output_94_85_g91520;
				float4 ifLocalVar18_g91524 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91524 >= 0.5 )
				ifLocalVar18_g91524 = temp_output_17_0_g91524;
				else
				ifLocalVar18_g91524 = temp_output_3_0_g91524;
				float4 lerpResult22_g91524 = lerp( temp_output_3_0_g91524 , temp_output_17_0_g91524 , temp_output_19_0_g91524);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91524 = lerpResult22_g91524;
				#else
				float4 staticSwitch24_g91524 = ifLocalVar18_g91524;
				#endif
				float ifLocalVar40_g91609 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91609 = (staticSwitch24_g91524).g;
				float temp_output_84_0_g91579 = Debug_Layer885_g91519;
				float temp_output_19_0_g91583 = TVE_ExtrasUsage[(int)temp_output_84_0_g91579];
				float4 temp_output_93_19_g91579 = TVE_ExtrasCoords;
				half2 UV96_g91579 = ( (temp_output_93_19_g91579).zw + ( (temp_output_93_19_g91579).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91579 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91579,temp_output_84_0_g91579), 0.0 );
				float4 temp_output_17_0_g91583 = tex2DArrayNode48_g91579;
				float4 temp_output_94_85_g91579 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91583 = temp_output_94_85_g91579;
				float4 ifLocalVar18_g91583 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91583 >= 0.5 )
				ifLocalVar18_g91583 = temp_output_17_0_g91583;
				else
				ifLocalVar18_g91583 = temp_output_3_0_g91583;
				float4 lerpResult22_g91583 = lerp( temp_output_3_0_g91583 , temp_output_17_0_g91583 , temp_output_19_0_g91583);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91583 = lerpResult22_g91583;
				#else
				float4 staticSwitch24_g91583 = ifLocalVar18_g91583;
				#endif
				float ifLocalVar40_g91538 = 0;
				if( Debug_Index464_g91519 == 5.0 )
				ifLocalVar40_g91538 = (staticSwitch24_g91583).b;
				float temp_output_84_0_g91599 = Debug_Layer885_g91519;
				float temp_output_19_0_g91603 = TVE_ExtrasUsage[(int)temp_output_84_0_g91599];
				float4 temp_output_93_19_g91599 = TVE_ExtrasCoords;
				half2 UV96_g91599 = ( (temp_output_93_19_g91599).zw + ( (temp_output_93_19_g91599).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode48_g91599 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g91599,temp_output_84_0_g91599), 0.0 );
				float4 temp_output_17_0_g91603 = tex2DArrayNode48_g91599;
				float4 temp_output_94_85_g91599 = TVE_ExtrasParams;
				float4 temp_output_3_0_g91603 = temp_output_94_85_g91599;
				float4 ifLocalVar18_g91603 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91603 >= 0.5 )
				ifLocalVar18_g91603 = temp_output_17_0_g91603;
				else
				ifLocalVar18_g91603 = temp_output_3_0_g91603;
				float4 lerpResult22_g91603 = lerp( temp_output_3_0_g91603 , temp_output_17_0_g91603 , temp_output_19_0_g91603);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91603 = lerpResult22_g91603;
				#else
				float4 staticSwitch24_g91603 = ifLocalVar18_g91603;
				#endif
				float ifLocalVar40_g91531 = 0;
				if( Debug_Index464_g91519 == 6.0 )
				ifLocalVar40_g91531 = saturate( (staticSwitch24_g91603).a );
				float temp_output_84_0_g91562 = Debug_Layer885_g91519;
				float temp_output_19_0_g91566 = TVE_MotionUsage[(int)temp_output_84_0_g91562];
				float4 temp_output_91_19_g91562 = TVE_MotionCoords;
				half2 UV94_g91562 = ( (temp_output_91_19_g91562).zw + ( (temp_output_91_19_g91562).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91562 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91562,temp_output_84_0_g91562), 0.0 );
				float4 temp_output_17_0_g91566 = tex2DArrayNode50_g91562;
				float4 temp_output_112_19_g91562 = TVE_MotionParams;
				float4 temp_output_3_0_g91566 = temp_output_112_19_g91562;
				float4 ifLocalVar18_g91566 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91566 >= 0.5 )
				ifLocalVar18_g91566 = temp_output_17_0_g91566;
				else
				ifLocalVar18_g91566 = temp_output_3_0_g91566;
				float4 lerpResult22_g91566 = lerp( temp_output_3_0_g91566 , temp_output_17_0_g91566 , temp_output_19_0_g91566);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91566 = lerpResult22_g91566;
				#else
				float4 staticSwitch24_g91566 = ifLocalVar18_g91566;
				#endif
				float3 appendResult1012_g91519 = (float3((staticSwitch24_g91566).rg , 0.0));
				float3 ifLocalVar40_g91527 = 0;
				if( Debug_Index464_g91519 == 7.0 )
				ifLocalVar40_g91527 = appendResult1012_g91519;
				float temp_output_84_0_g91585 = Debug_Layer885_g91519;
				float temp_output_19_0_g91589 = TVE_MotionUsage[(int)temp_output_84_0_g91585];
				float4 temp_output_91_19_g91585 = TVE_MotionCoords;
				half2 UV94_g91585 = ( (temp_output_91_19_g91585).zw + ( (temp_output_91_19_g91585).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91585 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91585,temp_output_84_0_g91585), 0.0 );
				float4 temp_output_17_0_g91589 = tex2DArrayNode50_g91585;
				float4 temp_output_112_19_g91585 = TVE_MotionParams;
				float4 temp_output_3_0_g91589 = temp_output_112_19_g91585;
				float4 ifLocalVar18_g91589 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91589 >= 0.5 )
				ifLocalVar18_g91589 = temp_output_17_0_g91589;
				else
				ifLocalVar18_g91589 = temp_output_3_0_g91589;
				float4 lerpResult22_g91589 = lerp( temp_output_3_0_g91589 , temp_output_17_0_g91589 , temp_output_19_0_g91589);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91589 = lerpResult22_g91589;
				#else
				float4 staticSwitch24_g91589 = ifLocalVar18_g91589;
				#endif
				float ifLocalVar40_g91541 = 0;
				if( Debug_Index464_g91519 == 8.0 )
				ifLocalVar40_g91541 = (staticSwitch24_g91589).b;
				float temp_output_84_0_g91591 = Debug_Layer885_g91519;
				float temp_output_19_0_g91595 = TVE_MotionUsage[(int)temp_output_84_0_g91591];
				float4 temp_output_91_19_g91591 = TVE_MotionCoords;
				half2 UV94_g91591 = ( (temp_output_91_19_g91591).zw + ( (temp_output_91_19_g91591).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91591 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g91591,temp_output_84_0_g91591), 0.0 );
				float4 temp_output_17_0_g91595 = tex2DArrayNode50_g91591;
				float4 temp_output_112_19_g91591 = TVE_MotionParams;
				float4 temp_output_3_0_g91595 = temp_output_112_19_g91591;
				float4 ifLocalVar18_g91595 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91595 >= 0.5 )
				ifLocalVar18_g91595 = temp_output_17_0_g91595;
				else
				ifLocalVar18_g91595 = temp_output_3_0_g91595;
				float4 lerpResult22_g91595 = lerp( temp_output_3_0_g91595 , temp_output_17_0_g91595 , temp_output_19_0_g91595);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91595 = lerpResult22_g91595;
				#else
				float4 staticSwitch24_g91595 = ifLocalVar18_g91595;
				#endif
				float ifLocalVar40_g91596 = 0;
				if( Debug_Index464_g91519 == 9.0 )
				ifLocalVar40_g91596 = saturate( (staticSwitch24_g91595).a );
				float temp_output_84_0_g91549 = Debug_Layer885_g91519;
				float temp_output_19_0_g91553 = TVE_VertexUsage[(int)temp_output_84_0_g91549];
				float4 temp_output_94_19_g91549 = TVE_VertexCoords;
				half2 UV97_g91549 = ( (temp_output_94_19_g91549).zw + ( (temp_output_94_19_g91549).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91549,temp_output_84_0_g91549), 0.0 );
				float4 temp_output_17_0_g91553 = tex2DArrayNode50_g91549;
				float4 temp_output_111_19_g91549 = TVE_VertexParams;
				float4 temp_output_3_0_g91553 = temp_output_111_19_g91549;
				float4 ifLocalVar18_g91553 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91553 >= 0.5 )
				ifLocalVar18_g91553 = temp_output_17_0_g91553;
				else
				ifLocalVar18_g91553 = temp_output_3_0_g91553;
				float4 lerpResult22_g91553 = lerp( temp_output_3_0_g91553 , temp_output_17_0_g91553 , temp_output_19_0_g91553);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91553 = lerpResult22_g91553;
				#else
				float4 staticSwitch24_g91553 = ifLocalVar18_g91553;
				#endif
				float3 appendResult1013_g91519 = (float3((staticSwitch24_g91553).rg , 0.0));
				float3 ifLocalVar40_g91715 = 0;
				if( Debug_Index464_g91519 == 10.0 )
				ifLocalVar40_g91715 = appendResult1013_g91519;
				float temp_output_84_0_g91532 = Debug_Layer885_g91519;
				float temp_output_19_0_g91536 = TVE_VertexUsage[(int)temp_output_84_0_g91532];
				float4 temp_output_94_19_g91532 = TVE_VertexCoords;
				half2 UV97_g91532 = ( (temp_output_94_19_g91532).zw + ( (temp_output_94_19_g91532).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91532 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91532,temp_output_84_0_g91532), 0.0 );
				float4 temp_output_17_0_g91536 = tex2DArrayNode50_g91532;
				float4 temp_output_111_19_g91532 = TVE_VertexParams;
				float4 temp_output_3_0_g91536 = temp_output_111_19_g91532;
				float4 ifLocalVar18_g91536 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91536 >= 0.5 )
				ifLocalVar18_g91536 = temp_output_17_0_g91536;
				else
				ifLocalVar18_g91536 = temp_output_3_0_g91536;
				float4 lerpResult22_g91536 = lerp( temp_output_3_0_g91536 , temp_output_17_0_g91536 , temp_output_19_0_g91536);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91536 = lerpResult22_g91536;
				#else
				float4 staticSwitch24_g91536 = ifLocalVar18_g91536;
				#endif
				float ifLocalVar40_g91689 = 0;
				if( Debug_Index464_g91519 == 11.0 )
				ifLocalVar40_g91689 = saturate( (staticSwitch24_g91536).b );
				float temp_output_84_0_g91604 = Debug_Layer885_g91519;
				float temp_output_19_0_g91608 = TVE_VertexUsage[(int)temp_output_84_0_g91604];
				float4 temp_output_94_19_g91604 = TVE_VertexCoords;
				half2 UV97_g91604 = ( (temp_output_94_19_g91604).zw + ( (temp_output_94_19_g91604).xy * (WorldPosition893_g91519).xz ) );
				float4 tex2DArrayNode50_g91604 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g91604,temp_output_84_0_g91604), 0.0 );
				float4 temp_output_17_0_g91608 = tex2DArrayNode50_g91604;
				float4 temp_output_111_19_g91604 = TVE_VertexParams;
				float4 temp_output_3_0_g91608 = temp_output_111_19_g91604;
				float4 ifLocalVar18_g91608 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g91608 >= 0.5 )
				ifLocalVar18_g91608 = temp_output_17_0_g91608;
				else
				ifLocalVar18_g91608 = temp_output_3_0_g91608;
				float4 lerpResult22_g91608 = lerp( temp_output_3_0_g91608 , temp_output_17_0_g91608 , temp_output_19_0_g91608);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g91608 = lerpResult22_g91608;
				#else
				float4 staticSwitch24_g91608 = ifLocalVar18_g91608;
				#endif
				float ifLocalVar40_g91690 = 0;
				if( Debug_Index464_g91519 == 12.0 )
				ifLocalVar40_g91690 = saturate( (staticSwitch24_g91608).a );
				float temp_output_7_0_g91611 = Debug_Min721_g91519;
				float3 temp_cast_44 = (temp_output_7_0_g91611).xxx;
				float temp_output_10_0_g91611 = ( Debug_Max723_g91519 - temp_output_7_0_g91611 );
				float3 Output_Globals888_g91519 = saturate( ( ( ( ifLocalVar40_g91529 + ( ifLocalVar40_g91544 + ifLocalVar40_g91554 ) + ( ifLocalVar40_g91537 + ifLocalVar40_g91609 + ifLocalVar40_g91538 + ifLocalVar40_g91531 ) + ( ifLocalVar40_g91527 + ifLocalVar40_g91541 + ifLocalVar40_g91596 ) + ( ifLocalVar40_g91715 + ifLocalVar40_g91689 + ifLocalVar40_g91690 ) ) - temp_cast_44 ) / ( temp_output_10_0_g91611 + 0.0001 ) ) );
				float3 ifLocalVar40_g91712 = 0;
				if( Debug_Type367_g91519 == 9.0 )
				ifLocalVar40_g91712 = Output_Globals888_g91519;
				float4 temp_output_35_0_g91695 = TVE_ColorsCoords;
				float temp_output_7_0_g91696 = 1.0;
				float2 temp_cast_46 = (temp_output_7_0_g91696).xx;
				float temp_output_10_0_g91696 = ( 1.0 - temp_output_7_0_g91696 );
				float2 temp_output_1583_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91695).zw + ( (temp_output_35_0_g91695).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_46 ) / temp_output_10_0_g91696 ) );
				float2 temp_output_1582_0_g91519 = ( temp_output_1583_0_g91519 * temp_output_1583_0_g91519 );
				float3 ifLocalVar40_g91716 = 0;
				if( Debug_Index464_g91519 == 0.0 )
				ifLocalVar40_g91716 = ( ( 1.0 - saturate( ( (temp_output_1582_0_g91519).x + (temp_output_1582_0_g91519).y ) ) ) * float3(0.5,0,0) );
				float4 temp_output_35_0_g91697 = TVE_ExtrasCoords;
				float temp_output_7_0_g91698 = 1.0;
				float2 temp_cast_47 = (temp_output_7_0_g91698).xx;
				float temp_output_10_0_g91698 = ( 1.0 - temp_output_7_0_g91698 );
				float2 temp_output_1602_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91697).zw + ( (temp_output_35_0_g91697).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_47 ) / temp_output_10_0_g91698 ) );
				float2 temp_output_1595_0_g91519 = ( temp_output_1602_0_g91519 * temp_output_1602_0_g91519 );
				float3 ifLocalVar40_g91717 = 0;
				if( Debug_Index464_g91519 == 1.0 )
				ifLocalVar40_g91717 = ( ( 1.0 - saturate( ( (temp_output_1595_0_g91519).x + (temp_output_1595_0_g91519).y ) ) ) * float3(0,0.5,0) );
				float4 temp_output_35_0_g91699 = TVE_MotionCoords;
				float temp_output_7_0_g91700 = 1.0;
				float2 temp_cast_48 = (temp_output_7_0_g91700).xx;
				float temp_output_10_0_g91700 = ( 1.0 - temp_output_7_0_g91700 );
				float2 temp_output_1615_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91699).zw + ( (temp_output_35_0_g91699).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_48 ) / temp_output_10_0_g91700 ) );
				float2 temp_output_1609_0_g91519 = ( temp_output_1615_0_g91519 * temp_output_1615_0_g91519 );
				float3 ifLocalVar40_g91718 = 0;
				if( Debug_Index464_g91519 == 2.0 )
				ifLocalVar40_g91718 = ( ( 1.0 - saturate( ( (temp_output_1609_0_g91519).x + (temp_output_1609_0_g91519).y ) ) ) * float3(0,0,1) );
				float4 temp_output_35_0_g91701 = TVE_VertexCoords;
				float temp_output_7_0_g91702 = 1.0;
				float2 temp_cast_49 = (temp_output_7_0_g91702).xx;
				float temp_output_10_0_g91702 = ( 1.0 - temp_output_7_0_g91702 );
				float2 temp_output_1628_0_g91519 = saturate( ( ( abs( (( (temp_output_35_0_g91701).zw + ( (temp_output_35_0_g91701).xy * (worldPos).xz ) )*2.0 + -1.0) ) - temp_cast_49 ) / temp_output_10_0_g91702 ) );
				float2 temp_output_1622_0_g91519 = ( temp_output_1628_0_g91519 * temp_output_1628_0_g91519 );
				float3 ifLocalVar40_g91719 = 0;
				if( Debug_Index464_g91519 == 3.0 )
				ifLocalVar40_g91719 = ( ( 1.0 - saturate( ( (temp_output_1622_0_g91519).x + (temp_output_1622_0_g91519).y ) ) ) * float3(0.5,0.5,0.5) );
				float3 Output_Volume1591_g91519 = saturate( ( ifLocalVar40_g91716 + ifLocalVar40_g91717 + ifLocalVar40_g91718 + ifLocalVar40_g91719 ) );
				float3 ifLocalVar40_g91713 = 0;
				if( Debug_Type367_g91519 == 10.0 )
				ifLocalVar40_g91713 = Output_Volume1591_g91519;
				float3 vertexToFrag328_g91519 = IN.ase_texcoord11.xyz;
				float4 color1016_g91519 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g91519 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g91519 = (((ase_vface>0)?(color1016_g91519):(color1017_g91519)));
				float3 ifLocalVar40_g91530 = 0;
				if( Debug_Index464_g91519 == 4.0 )
				ifLocalVar40_g91530 = (switchResult1015_g91519).rgb;
				float temp_output_7_0_g91688 = Debug_Min721_g91519;
				float3 temp_cast_51 = (temp_output_7_0_g91688).xxx;
				float temp_output_10_0_g91688 = ( Debug_Max723_g91519 - temp_output_7_0_g91688 );
				float Debug_Filter322_g91519 = TVE_DEBUG_Filter;
				float lerpResult1524_g91519 = lerp( 1.0 , _IsTVEShader647_g91519 , Debug_Filter322_g91519);
				float4 lerpResult1517_g91519 = lerp( Shading_Inactive1492_g91519 , float4( saturate( ( ( ( vertexToFrag328_g91519 + ifLocalVar40_g91530 ) - temp_cast_51 ) / ( temp_output_10_0_g91688 + 0.0001 ) ) ) , 0.0 ) , lerpResult1524_g91519);
				float4 Output_Mesh316_g91519 = lerpResult1517_g91519;
				float4 ifLocalVar40_g91714 = 0;
				if( Debug_Type367_g91519 == 11.0 )
				ifLocalVar40_g91714 = Output_Mesh316_g91519;
				float Debug_Clip623_g91519 = TVE_DEBUG_Clip;
				float lerpResult622_g91519 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g91519 * _RenderClip ));
				clip( lerpResult622_g91519 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = ( ( ifLocalVar40_g91703 + ifLocalVar40_g91704 + ifLocalVar40_g91705 + ifLocalVar40_g91706 + ifLocalVar40_g91707 + ifLocalVar40_g91708 ) + ( ifLocalVar40_g91709 + ifLocalVar40_g91710 + ifLocalVar40_g91711 ) + ( float4( ifLocalVar40_g91712 , 0.0 ) + float4( ifLocalVar40_g91713 , 0.0 ) + ifLocalVar40_g91714 ) ).rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = 0;
				gi.light.dir = half3(0,1,0);

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI( o, giInput, gi );
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					outEmission = LightingStandardSpecular_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#else
					outEmission = LightingStandard_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#endif

				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, float3(0, 0, 0));
				#endif
				#ifndef UNITY_HDR_ON
					outEmission.rgb = exp2(-outEmission.rgb);
				#endif
			}
			ENDCG
		}

	
	}
	
	
	Dependency "LightMode"="ForwardBase"

	Fallback Off
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.RangedFloatNode;2155;-1792,-5248;Half;False;Global;TVE_DEBUG_Layer;TVE_DEBUG_Layer;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2013;-1792,-5312;Half;False;Global;TVE_DEBUG_Index;TVE_DEBUG_Index;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1908;-1792,-5376;Half;False;Global;TVE_DEBUG_Type;TVE_DEBUG_Type;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1878;-1792,-5632;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Debug);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1931;-1408,-5632;Half;False;Property;_DebugCategory;[ Debug Category ];98;0;Create;True;0;0;0;False;1;StyledCategory(Debug Settings, 5, 10);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1881;-1600,-5632;Half;False;Property;_Message;Message;99;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2109;-896,-5376;Float;False;True;-1;2;;0;4;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;18;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True=DisableBatching;True;7;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;1;LightMode=ForwardBase;0;Standard;40;Workflow,InvertActionOnDeselection;1;0;Surface;0;0;  Blend;0;0;  Refraction Model;0;0;  Dither Shadows;1;0;Two Sided;0;638071577106831206;Deferred Pass;1;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;0;  Use Shadow Threshold;0;0;Receive Shadows;0;0;GPU Instancing;0;638141543866713469;LOD CrossFade;0;0;Built-in Fog;0;0;Ambient Light;0;0;Meta Pass;0;0;Add Pass;0;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Fwd Specular Highlights Toggle;0;0;Fwd Reflections Toggle;0;0;Disable Batching;1;0;Vertex Position,InvertActionOnDeselection;1;0;0;6;False;True;False;True;False;False;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2112;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2113;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;True;1;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2110;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;True;1;LightMode=ForwardAdd;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2108;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;True;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;-1;59;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;LightMode=ForwardBase;=;=;=;=;=;=;=;=;=;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2111;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;True;2;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.FunctionNode;2203;-896,-5632;Inherit;False;Compile All Shaders;-1;;73162;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2069;-1792,-5056;Half;False;Global;TVE_DEBUG_Min;TVE_DEBUG_Min;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1953;-1792,-5184;Half;False;Global;TVE_DEBUG_Filter;TVE_DEBUG_Filter;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2032;-1792,-5120;Half;False;Global;TVE_DEBUG_Clip;TVE_DEBUG_Clip;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2070;-1792,-4992;Half;False;Global;TVE_DEBUG_Max;TVE_DEBUG_Max;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2327;-1408,-5376;Inherit;False;Tool Debug;1;;91519;d48cde928c5068141abea1713047719b;1,1236,0;7;336;FLOAT;0;False;465;FLOAT;0;False;884;FLOAT;0;False;337;FLOAT;0;False;624;FLOAT;0;False;720;FLOAT;0;False;722;FLOAT;0;False;1;COLOR;338
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2109;2;2327;338
WireConnection;2327;336;1908;0
WireConnection;2327;465;2013;0
WireConnection;2327;884;2155;0
WireConnection;2327;337;1953;0
WireConnection;2327;624;2032;0
WireConnection;2327;720;2069;0
WireConnection;2327;722;2070;0
ASEEND*/
//CHKSM=39B34342C74AF796784F1BD9EA3D8AAFBADC0139