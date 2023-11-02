// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LightingBox/Terrain/Terrain 6-Layers"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		_SplatMap1("SplatMap1", 2D) = "white" {}
		_SplatMap2("SplatMap2", 2D) = "white" {}
		_AlbedoMaps("AlbedoMaps", 2DArray) = "white" {}
		_Smoothness_1("Smoothness_1", Range( 0 , 1)) = 0.5
		_Smoothness_2("Smoothness_2", Range( 0 , 1)) = 0.5
		_Smoothness_3("Smoothness_3", Range( 0 , 1)) = 0.5
		_Smoothness_4("Smoothness_4", Range( 0 , 1)) = 0.5
		_Smoothness_5("Smoothness_5", Range( 0 , 1)) = 0.5
		_Smoothness_6("Smoothness_6", Range( 0 , 1)) = 0.5
		_Specular_Color_1("Specular_Color_1", Color) = (0,0,0,0)
		_Specular_Color_2("Specular_Color_2", Color) = (0,0,0,0)
		_Specular_Color_3("Specular_Color_3", Color) = (0,0,0,0)
		_Specular_Color_4("Specular_Color_4", Color) = (0,0,0,0)
		_Specular_Color_5("Specular_Color_5", Color) = (0,0,0,0)
		_Specular_Color_6("Specular_Color_6", Color) = (0,0,0,0)
		_UV_4("UV_4", Vector) = (30,30,0,0)
		_UV_0("UV_0", Vector) = (30,30,0,0)
		_Normal_Scale_1("Normal_Scale_1", Range( 0 , 1)) = 1
		_UV_5("UV_5", Vector) = (30,30,0,0)
		_UV_1("UV_1", Vector) = (30,30,0,0)
		_Normal_Scale_2("Normal_Scale_2", Range( 0 , 1)) = 1
		_UV_2("UV_2", Vector) = (30,30,0,0)
		_Normal_Scale_3("Normal_Scale_3", Range( 0 , 1)) = 1
		_UV_3("UV_3", Vector) = (30,30,0,0)
		_Normal_Scale_4("Normal_Scale_4", Range( 0 , 1)) = 1
		_Normal_Scale_5("Normal_Scale_5", Range( 0 , 1)) = 1
		_Normal_Scale_6("Normal_Scale_6", Range( 0 , 1)) = 0
		_Displacement_1("Displacement_1", Range( 0 , 3)) = 0
		_Displacement_2("Displacement_2", Range( 0 , 3)) = 0
		_Displacement_3("Displacement_3", Range( 0 , 3)) = 0
		_Displacement_4("Displacement_4", Range( 0 , 3)) = 0
		_Displacement_5("Displacement_5", Range( 0 , 3)) = 0
		_Displacement_6("Displacement_6", Range( 0 , 3)) = 0
		[HideInInspector]_TerrainHolesTexture("Holes", 2D) = "white" {}
		_AlphaClipThreshold("AlphaClipThreshold", Range( 0 , 1)) = 0.8350586
		_GlobalOffset("GlobalOffset", Float) = 0
		_Layer_1_Offset("Layer_1_Offset", Range( -1.5 , 1.5)) = 0
		_Layer_2_Offset("Layer_2_Offset", Range( -1.5 , 1.5)) = 0
		_Layer_3_Offset("Layer_3_Offset", Range( -1.5 , 1.5)) = 0
		_Layer_5_Offset("Layer_5_Offset", Range( -1.5 , 1.5)) = 0
		_Layer_4_Offset("Layer_4_Offset", Range( -1.5 , 1.5)) = 0
		_Layer_6_Offset("Layer_6_Offset", Range( -1.5 , 1.5)) = 0
		_TrailPower("TrailPower", Float) = -1
		_TrailRenderTexOld("TrailRenderTexOld", 2D) = "white" {}
		_Layer_1TrailMultiplier("Layer_1 Trail Multiplier", Float) = 0
		_Layer_2TrailMultiplier("Layer_2 Trail Multiplier", Float) = 0
		_Layer_3TrailMultiplier("Layer_3 Trail Multiplier", Float) = 0
		_Layer_4TrailMultiplier("Layer_4 Trail Multiplier", Float) = 0
		_Layer_5TrailMultiplier("Layer_5 Trail Multiplier", Float) = 0
		_Layer_6TrailMultiplier("Layer_6 Trail Multiplier", Float) = 0
		_Layer_1TrailNormalStrength("Layer_1 Trail Normal Strength", Float) = 0
		_Layer_2TrailNormalStrength("Layer_2 Trail Normal Strength", Float) = 0
		_Layer_3TrailNormalStrength("Layer_3 Trail Normal Strength", Float) = 0
		_Layer_4TrailNormalStrength("Layer_4 Trail Normal Strength", Float) = 0
		_Layer_5TrailNormalStrength("Layer_5 Trail Normal Strength", Float) = 0
		_Layer_6TrailNormalStrength("Layer_6 Trail Normal Strength", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 16
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" }

		Cull Back
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 3.0
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
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
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _CLUSTERED_RENDERING

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ DEBUG_DISPLAY

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			float3 PerturbNormal107_g76( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g73( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g77( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g74( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g78( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g75( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord8.xy = v.texcoord.xy;
				o.ase_normal = v.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif
				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( v.normalOS, v.tangentOS );

				o.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x );
				o.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y );
				o.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z );

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );

				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#else
					half fogFactor = 0;
				#endif

				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 uv_SplatMap1 = IN.ase_texcoord8.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D( _SplatMap1, sampler_SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = IN.ase_texcoord8.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar563 = tex2DNode515;
				float4 weightedBlend563 = ( weightedBlendVar563.x*tex2DArrayNode486 + weightedBlendVar563.y*tex2DArrayNode481 + weightedBlendVar563.z*tex2DArrayNode484 + weightedBlendVar563.w*tex2DArrayNode470 );
				float2 uv_SplatMap2 = IN.ase_texcoord8.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D( _SplatMap2, sampler_SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 weightedBlendVar543 = tex2DNode510;
				float4 weightedBlend543 = ( weightedBlendVar543.x*tex2DArrayNode482 + weightedBlendVar543.y*tex2DArrayNode488 + weightedBlendVar543.z*float4( 0,0,0,0 ) + weightedBlendVar543.w*float4( 0,0,0,0 ) );
				
				float3 unpack557 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack557.z = lerp( 1, unpack557.z, saturate(_Normal_Scale_1) );
				float3 surf_pos107_g76 = WorldPosition;
				float3 surf_norm107_g76 = WorldNormal;
				float2 uv_TrailRenderTexOld = IN.ase_texcoord8.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld ) * _TrailPower ) * float4( IN.ase_normal , 0.0 ) ).rgb);
				float height107_g76 = ( _Layer_1TrailMultiplier * grayscale479 );
				float scale107_g76 = _Layer_1TrailNormalStrength;
				float3 localPerturbNormal107_g76 = PerturbNormal107_g76( surf_pos107_g76 , surf_norm107_g76 , height107_g76 , scale107_g76 );
				float3 unpack568 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack568.z = lerp( 1, unpack568.z, saturate(_Normal_Scale_2) );
				float3 surf_pos107_g73 = WorldPosition;
				float3 surf_norm107_g73 = WorldNormal;
				float height107_g73 = ( _Layer_2TrailMultiplier * grayscale479 );
				float scale107_g73 = _Layer_2TrailNormalStrength;
				float3 localPerturbNormal107_g73 = PerturbNormal107_g73( surf_pos107_g73 , surf_norm107_g73 , height107_g73 , scale107_g73 );
				float3 unpack584 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack584.z = lerp( 1, unpack584.z, saturate(_Normal_Scale_3) );
				float3 surf_pos107_g77 = WorldPosition;
				float3 surf_norm107_g77 = WorldNormal;
				float height107_g77 = ( _Layer_3TrailMultiplier * grayscale479 );
				float scale107_g77 = _Layer_3TrailNormalStrength;
				float3 localPerturbNormal107_g77 = PerturbNormal107_g77( surf_pos107_g77 , surf_norm107_g77 , height107_g77 , scale107_g77 );
				float3 unpack549 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack549.z = lerp( 1, unpack549.z, saturate(_Normal_Scale_4) );
				float3 surf_pos107_g74 = WorldPosition;
				float3 surf_norm107_g74 = WorldNormal;
				float height107_g74 = ( _Layer_4TrailMultiplier * grayscale479 );
				float scale107_g74 = _Layer_4TrailNormalStrength;
				float3 localPerturbNormal107_g74 = PerturbNormal107_g74( surf_pos107_g74 , surf_norm107_g74 , height107_g74 , scale107_g74 );
				float4 weightedBlendVar607 = tex2DNode515;
				float3 weightedBlend607 = ( weightedBlendVar607.x*( unpack557 + localPerturbNormal107_g76 ) + weightedBlendVar607.y*( unpack568 + localPerturbNormal107_g73 ) + weightedBlendVar607.z*( unpack584 + localPerturbNormal107_g77 ) + weightedBlendVar607.w*( unpack549 + localPerturbNormal107_g74 ) );
				float3 unpack612 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack612.z = lerp( 1, unpack612.z, saturate(_Normal_Scale_5) );
				float3 surf_pos107_g78 = WorldPosition;
				float3 surf_norm107_g78 = WorldNormal;
				float height107_g78 = ( _Layer_5TrailMultiplier * grayscale479 );
				float scale107_g78 = _Layer_5TrailNormalStrength;
				float3 localPerturbNormal107_g78 = PerturbNormal107_g78( surf_pos107_g78 , surf_norm107_g78 , height107_g78 , scale107_g78 );
				float3 unpack545 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack545.z = lerp( 1, unpack545.z, saturate(_Normal_Scale_6) );
				float3 surf_pos107_g75 = WorldPosition;
				float3 surf_norm107_g75 = WorldNormal;
				float height107_g75 = ( _Layer_6TrailMultiplier * grayscale479 );
				float scale107_g75 = _Layer_6TrailNormalStrength;
				float3 localPerturbNormal107_g75 = PerturbNormal107_g75( surf_pos107_g75 , surf_norm107_g75 , height107_g75 , scale107_g75 );
				float4 weightedBlendVar537 = tex2DNode510;
				float3 weightedBlend537 = ( weightedBlendVar537.x*( unpack612 + localPerturbNormal107_g78 ) + weightedBlendVar537.y*( unpack545 + localPerturbNormal107_g75 ) + weightedBlendVar537.z*float3( 0,0,0 ) + weightedBlendVar537.w*float3( 0,0,0 ) );
				
				float4 weightedBlendVar620 = tex2DNode515;
				float4 weightedBlend620 = ( weightedBlendVar620.x*( _Specular_Color_1 * tex2DArrayNode486.g ) + weightedBlendVar620.y*( _Specular_Color_2 * tex2DArrayNode481.g ) + weightedBlendVar620.z*( _Specular_Color_3 * tex2DArrayNode484.g ) + weightedBlendVar620.w*( _Specular_Color_4 * tex2DArrayNode470.g ) );
				float4 weightedBlendVar621 = tex2DNode510;
				float4 weightedBlend621 = ( weightedBlendVar621.x*( _Specular_Color_5 * tex2DArrayNode482.g ) + weightedBlendVar621.y*( _Specular_Color_6 * tex2DArrayNode488.g ) + weightedBlendVar621.z*float4( 0,0,0,0 ) + weightedBlendVar621.w*float4( 0,0,0,0 ) );
				
				float4 weightedBlendVar587 = tex2DNode515;
				float weightedBlend587 = ( weightedBlendVar587.x*( _Smoothness_1 * tex2DArrayNode486.r ) + weightedBlendVar587.y*( _Smoothness_2 * tex2DArrayNode481.r ) + weightedBlendVar587.z*( _Smoothness_3 * tex2DArrayNode484.r ) + weightedBlendVar587.w*( _Smoothness_4 * tex2DArrayNode470.r ) );
				float4 weightedBlendVar582 = tex2DNode510;
				float weightedBlend582 = ( weightedBlendVar582.x*( _Smoothness_5 * tex2DArrayNode482.r ) + weightedBlendVar582.y*( _Smoothness_6 * tex2DArrayNode488.r ) + weightedBlendVar582.z*0.0 + weightedBlendVar582.w*0.0 );
				
				float2 uv_TerrainHolesTexture = IN.ase_texcoord8.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float3 BaseColor = ( weightedBlend563 + weightedBlend543 ).rgb;
				float3 Normal = ( weightedBlend607 + weightedBlend537 );
				float3 Emission = 0;
				float3 Specular = ( weightedBlend620 + weightedBlend621 ).rgb;
				float Metallic = 0;
				float Smoothness = ( weightedBlend587 + weightedBlend582 );
				float Occlusion = 1;
				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent, WorldBiTangent, WorldNormal));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					inputData.shadowCoord = ShadowCoords;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
				#else
					inputData.shadowCoord = float4(0, 0, 0, 0);
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif
					inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(IN.positionCS, surfaceData, inputData);
				#endif

				half4 color = UniversalFragmentPBR( inputData, surfaceData);

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += BaseColor * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += BaseColor * transmission;
						}
					#endif
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

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += BaseColor * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += BaseColor * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif				
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			float3 _LightDirection;
			float3 _LightPosition;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = positionWS;
				#endif

				float3 normalWS = TransformObjectToWorldDir(v.normalOS);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_TerrainHolesTexture = IN.ase_texcoord3.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_TerrainHolesTexture = IN.ase_texcoord3.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#pragma shader_feature EDITOR_VISUALIZATION

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef EDITOR_VISUALIZATION
					float4 VizUV : TEXCOORD2;
					float4 LightCoord : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.texcoord0.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.texcoord0.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.texcoord0.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.texcoord0.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord4.xy = v.texcoord0.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = positionWS;
				#endif

				o.positionCS = MetaVertexPosition( v.positionOS, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );

				#ifdef EDITOR_VISUALIZATION
					float2 VizUV = 0;
					float4 LightCoord = 0;
					UnityEditorVizData(v.positionOS.xyz, v.texcoord0.xy, v.texcoord1.xy, v.texcoord2.xy, VizUV, LightCoord);
					o.VizUV = float4(VizUV, 0, 0);
					o.LightCoord = LightCoord;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.texcoord0 = v.texcoord0;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.texcoord0 = patch[0].texcoord0 * bary.x + patch[1].texcoord0 * bary.y + patch[2].texcoord0 * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_SplatMap1 = IN.ase_texcoord4.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D( _SplatMap1, sampler_SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = IN.ase_texcoord4.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar563 = tex2DNode515;
				float4 weightedBlend563 = ( weightedBlendVar563.x*tex2DArrayNode486 + weightedBlendVar563.y*tex2DArrayNode481 + weightedBlendVar563.z*tex2DArrayNode484 + weightedBlendVar563.w*tex2DArrayNode470 );
				float2 uv_SplatMap2 = IN.ase_texcoord4.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D( _SplatMap2, sampler_SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 weightedBlendVar543 = tex2DNode510;
				float4 weightedBlend543 = ( weightedBlendVar543.x*tex2DArrayNode482 + weightedBlendVar543.y*tex2DArrayNode488 + weightedBlendVar543.z*float4( 0,0,0,0 ) + weightedBlendVar543.w*float4( 0,0,0,0 ) );
				
				float2 uv_TerrainHolesTexture = IN.ase_texcoord4.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float3 BaseColor = ( weightedBlend563 + weightedBlend543 ).rgb;
				float3 Emission = 0;
				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = IN.VizUV.xy;
					metaInput.LightCoord = IN.LightCoord;
				#endif

				return UnityMetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_SplatMap1 = IN.ase_texcoord2.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D( _SplatMap1, sampler_SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = IN.ase_texcoord2.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar563 = tex2DNode515;
				float4 weightedBlend563 = ( weightedBlendVar563.x*tex2DArrayNode486 + weightedBlendVar563.y*tex2DArrayNode481 + weightedBlendVar563.z*tex2DArrayNode484 + weightedBlendVar563.w*tex2DArrayNode470 );
				float2 uv_SplatMap2 = IN.ase_texcoord2.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D( _SplatMap2, sampler_SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 weightedBlendVar543 = tex2DNode510;
				float4 weightedBlend543 = ( weightedBlendVar543.x*tex2DArrayNode482 + weightedBlendVar543.y*tex2DArrayNode488 + weightedBlendVar543.z*float4( 0,0,0,0 ) + weightedBlendVar543.w*float4( 0,0,0,0 ) );
				
				float2 uv_TerrainHolesTexture = IN.ase_texcoord2.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float3 BaseColor = ( weightedBlend563 + weightedBlend543 ).rgb;
				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;

				half4 color = half4(BaseColor, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
				float4 worldTangent : TEXCOORD2;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD3;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD4;
				#endif
				float4 ase_texcoord5 : TEXCOORD5;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			float3 PerturbNormal107_g76( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g73( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g77( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g74( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g78( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g75( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				o.ase_normal = v.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				float3 normalWS = TransformObjectToWorldNormal( v.normalOS );
				float4 tangentWS = float4( TransformObjectToWorldDir( v.tangentOS.xyz ), v.tangentOS.w );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				o.worldNormal = normalWS;
				o.worldTangent = tangentWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float3 WorldNormal = IN.worldNormal;
				float4 WorldTangent = IN.worldTangent;

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_SplatMap1 = IN.ase_texcoord5.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D( _SplatMap1, sampler_SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = IN.ase_texcoord5.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float3 unpack557 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack557.z = lerp( 1, unpack557.z, saturate(_Normal_Scale_1) );
				float3 surf_pos107_g76 = WorldPosition;
				float3 surf_norm107_g76 = WorldNormal;
				float2 uv_TrailRenderTexOld = IN.ase_texcoord5.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld ) * _TrailPower ) * float4( IN.ase_normal , 0.0 ) ).rgb);
				float height107_g76 = ( _Layer_1TrailMultiplier * grayscale479 );
				float scale107_g76 = _Layer_1TrailNormalStrength;
				float3 localPerturbNormal107_g76 = PerturbNormal107_g76( surf_pos107_g76 , surf_norm107_g76 , height107_g76 , scale107_g76 );
				float3 unpack568 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack568.z = lerp( 1, unpack568.z, saturate(_Normal_Scale_2) );
				float3 surf_pos107_g73 = WorldPosition;
				float3 surf_norm107_g73 = WorldNormal;
				float height107_g73 = ( _Layer_2TrailMultiplier * grayscale479 );
				float scale107_g73 = _Layer_2TrailNormalStrength;
				float3 localPerturbNormal107_g73 = PerturbNormal107_g73( surf_pos107_g73 , surf_norm107_g73 , height107_g73 , scale107_g73 );
				float3 unpack584 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack584.z = lerp( 1, unpack584.z, saturate(_Normal_Scale_3) );
				float3 surf_pos107_g77 = WorldPosition;
				float3 surf_norm107_g77 = WorldNormal;
				float height107_g77 = ( _Layer_3TrailMultiplier * grayscale479 );
				float scale107_g77 = _Layer_3TrailNormalStrength;
				float3 localPerturbNormal107_g77 = PerturbNormal107_g77( surf_pos107_g77 , surf_norm107_g77 , height107_g77 , scale107_g77 );
				float3 unpack549 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack549.z = lerp( 1, unpack549.z, saturate(_Normal_Scale_4) );
				float3 surf_pos107_g74 = WorldPosition;
				float3 surf_norm107_g74 = WorldNormal;
				float height107_g74 = ( _Layer_4TrailMultiplier * grayscale479 );
				float scale107_g74 = _Layer_4TrailNormalStrength;
				float3 localPerturbNormal107_g74 = PerturbNormal107_g74( surf_pos107_g74 , surf_norm107_g74 , height107_g74 , scale107_g74 );
				float4 weightedBlendVar607 = tex2DNode515;
				float3 weightedBlend607 = ( weightedBlendVar607.x*( unpack557 + localPerturbNormal107_g76 ) + weightedBlendVar607.y*( unpack568 + localPerturbNormal107_g73 ) + weightedBlendVar607.z*( unpack584 + localPerturbNormal107_g77 ) + weightedBlendVar607.w*( unpack549 + localPerturbNormal107_g74 ) );
				float2 uv_SplatMap2 = IN.ase_texcoord5.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D( _SplatMap2, sampler_SplatMap2, uv_SplatMap2 );
				float3 unpack612 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack612.z = lerp( 1, unpack612.z, saturate(_Normal_Scale_5) );
				float3 surf_pos107_g78 = WorldPosition;
				float3 surf_norm107_g78 = WorldNormal;
				float height107_g78 = ( _Layer_5TrailMultiplier * grayscale479 );
				float scale107_g78 = _Layer_5TrailNormalStrength;
				float3 localPerturbNormal107_g78 = PerturbNormal107_g78( surf_pos107_g78 , surf_norm107_g78 , height107_g78 , scale107_g78 );
				float3 unpack545 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack545.z = lerp( 1, unpack545.z, saturate(_Normal_Scale_6) );
				float3 surf_pos107_g75 = WorldPosition;
				float3 surf_norm107_g75 = WorldNormal;
				float height107_g75 = ( _Layer_6TrailMultiplier * grayscale479 );
				float scale107_g75 = _Layer_6TrailNormalStrength;
				float3 localPerturbNormal107_g75 = PerturbNormal107_g75( surf_pos107_g75 , surf_norm107_g75 , height107_g75 , scale107_g75 );
				float4 weightedBlendVar537 = tex2DNode510;
				float3 weightedBlend537 = ( weightedBlendVar537.x*( unpack612 + localPerturbNormal107_g78 ) + weightedBlendVar537.y*( unpack545 + localPerturbNormal107_g75 ) + weightedBlendVar537.z*float3( 0,0,0 ) + weightedBlendVar537.w*float3( 0,0,0 ) );
				
				float2 uv_TerrainHolesTexture = IN.ase_texcoord5.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float3 Normal = ( weightedBlend607 + weightedBlend537 );
				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;
				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(WorldNormal);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					return half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float crossSign = (WorldTangent.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
							float3 bitangent = crossSign * cross(WorldNormal.xyz, WorldTangent.xyz);
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent.xyz, bitangent, WorldNormal.xyz));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = WorldNormal;
					#endif
					return half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define _SPECULAR_SETUP 1
			#pragma shader_feature_local_fragment _SPECULAR_SETUP
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float3 PerturbNormal107_g76( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g73( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g77( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g74( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g78( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			float3 PerturbNormal107_g75( float3 surf_pos, float3 surf_norm, float height, float scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord8.xy = v.texcoord.xy;
				o.ase_normal = v.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;
				v.tangentOS = v.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( v.normalOS, v.tangentOS );

				o.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH(normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz);
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord.xy;
					o.lightmapUVOrVertexSH.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );

				o.fogFactorAndVertexLight = half4(0, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			FragmentOutput frag ( VertexOutput IN
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#else
					ShadowCoords = float4(0, 0, 0, 0);
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 uv_SplatMap1 = IN.ase_texcoord8.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D( _SplatMap1, sampler_SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = IN.ase_texcoord8.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar563 = tex2DNode515;
				float4 weightedBlend563 = ( weightedBlendVar563.x*tex2DArrayNode486 + weightedBlendVar563.y*tex2DArrayNode481 + weightedBlendVar563.z*tex2DArrayNode484 + weightedBlendVar563.w*tex2DArrayNode470 );
				float2 uv_SplatMap2 = IN.ase_texcoord8.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D( _SplatMap2, sampler_SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 weightedBlendVar543 = tex2DNode510;
				float4 weightedBlend543 = ( weightedBlendVar543.x*tex2DArrayNode482 + weightedBlendVar543.y*tex2DArrayNode488 + weightedBlendVar543.z*float4( 0,0,0,0 ) + weightedBlendVar543.w*float4( 0,0,0,0 ) );
				
				float3 unpack557 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack557.z = lerp( 1, unpack557.z, saturate(_Normal_Scale_1) );
				float3 surf_pos107_g76 = WorldPosition;
				float3 surf_norm107_g76 = WorldNormal;
				float2 uv_TrailRenderTexOld = IN.ase_texcoord8.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld ) * _TrailPower ) * float4( IN.ase_normal , 0.0 ) ).rgb);
				float height107_g76 = ( _Layer_1TrailMultiplier * grayscale479 );
				float scale107_g76 = _Layer_1TrailNormalStrength;
				float3 localPerturbNormal107_g76 = PerturbNormal107_g76( surf_pos107_g76 , surf_norm107_g76 , height107_g76 , scale107_g76 );
				float3 unpack568 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack568.z = lerp( 1, unpack568.z, saturate(_Normal_Scale_2) );
				float3 surf_pos107_g73 = WorldPosition;
				float3 surf_norm107_g73 = WorldNormal;
				float height107_g73 = ( _Layer_2TrailMultiplier * grayscale479 );
				float scale107_g73 = _Layer_2TrailNormalStrength;
				float3 localPerturbNormal107_g73 = PerturbNormal107_g73( surf_pos107_g73 , surf_norm107_g73 , height107_g73 , scale107_g73 );
				float3 unpack584 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack584.z = lerp( 1, unpack584.z, saturate(_Normal_Scale_3) );
				float3 surf_pos107_g77 = WorldPosition;
				float3 surf_norm107_g77 = WorldNormal;
				float height107_g77 = ( _Layer_3TrailMultiplier * grayscale479 );
				float scale107_g77 = _Layer_3TrailNormalStrength;
				float3 localPerturbNormal107_g77 = PerturbNormal107_g77( surf_pos107_g77 , surf_norm107_g77 , height107_g77 , scale107_g77 );
				float3 unpack549 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack549.z = lerp( 1, unpack549.z, saturate(_Normal_Scale_4) );
				float3 surf_pos107_g74 = WorldPosition;
				float3 surf_norm107_g74 = WorldNormal;
				float height107_g74 = ( _Layer_4TrailMultiplier * grayscale479 );
				float scale107_g74 = _Layer_4TrailNormalStrength;
				float3 localPerturbNormal107_g74 = PerturbNormal107_g74( surf_pos107_g74 , surf_norm107_g74 , height107_g74 , scale107_g74 );
				float4 weightedBlendVar607 = tex2DNode515;
				float3 weightedBlend607 = ( weightedBlendVar607.x*( unpack557 + localPerturbNormal107_g76 ) + weightedBlendVar607.y*( unpack568 + localPerturbNormal107_g73 ) + weightedBlendVar607.z*( unpack584 + localPerturbNormal107_g77 ) + weightedBlendVar607.w*( unpack549 + localPerturbNormal107_g74 ) );
				float3 unpack612 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack612.z = lerp( 1, unpack612.z, saturate(_Normal_Scale_5) );
				float3 surf_pos107_g78 = WorldPosition;
				float3 surf_norm107_g78 = WorldNormal;
				float height107_g78 = ( _Layer_5TrailMultiplier * grayscale479 );
				float scale107_g78 = _Layer_5TrailNormalStrength;
				float3 localPerturbNormal107_g78 = PerturbNormal107_g78( surf_pos107_g78 , surf_norm107_g78 , height107_g78 , scale107_g78 );
				float3 unpack545 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack545.z = lerp( 1, unpack545.z, saturate(_Normal_Scale_6) );
				float3 surf_pos107_g75 = WorldPosition;
				float3 surf_norm107_g75 = WorldNormal;
				float height107_g75 = ( _Layer_6TrailMultiplier * grayscale479 );
				float scale107_g75 = _Layer_6TrailNormalStrength;
				float3 localPerturbNormal107_g75 = PerturbNormal107_g75( surf_pos107_g75 , surf_norm107_g75 , height107_g75 , scale107_g75 );
				float4 weightedBlendVar537 = tex2DNode510;
				float3 weightedBlend537 = ( weightedBlendVar537.x*( unpack612 + localPerturbNormal107_g78 ) + weightedBlendVar537.y*( unpack545 + localPerturbNormal107_g75 ) + weightedBlendVar537.z*float3( 0,0,0 ) + weightedBlendVar537.w*float3( 0,0,0 ) );
				
				float4 weightedBlendVar620 = tex2DNode515;
				float4 weightedBlend620 = ( weightedBlendVar620.x*( _Specular_Color_1 * tex2DArrayNode486.g ) + weightedBlendVar620.y*( _Specular_Color_2 * tex2DArrayNode481.g ) + weightedBlendVar620.z*( _Specular_Color_3 * tex2DArrayNode484.g ) + weightedBlendVar620.w*( _Specular_Color_4 * tex2DArrayNode470.g ) );
				float4 weightedBlendVar621 = tex2DNode510;
				float4 weightedBlend621 = ( weightedBlendVar621.x*( _Specular_Color_5 * tex2DArrayNode482.g ) + weightedBlendVar621.y*( _Specular_Color_6 * tex2DArrayNode488.g ) + weightedBlendVar621.z*float4( 0,0,0,0 ) + weightedBlendVar621.w*float4( 0,0,0,0 ) );
				
				float4 weightedBlendVar587 = tex2DNode515;
				float weightedBlend587 = ( weightedBlendVar587.x*( _Smoothness_1 * tex2DArrayNode486.r ) + weightedBlendVar587.y*( _Smoothness_2 * tex2DArrayNode481.r ) + weightedBlendVar587.z*( _Smoothness_3 * tex2DArrayNode484.r ) + weightedBlendVar587.w*( _Smoothness_4 * tex2DArrayNode470.r ) );
				float4 weightedBlendVar582 = tex2DNode510;
				float weightedBlend582 = ( weightedBlendVar582.x*( _Smoothness_5 * tex2DArrayNode482.r ) + weightedBlendVar582.y*( _Smoothness_6 * tex2DArrayNode488.r ) + weightedBlendVar582.z*0.0 + weightedBlendVar582.w*0.0 );
				
				float2 uv_TerrainHolesTexture = IN.ase_texcoord8.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				float3 BaseColor = ( weightedBlend563 + weightedBlend543 ).rgb;
				float3 Normal = ( weightedBlend607 + weightedBlend537 );
				float3 Emission = 0;
				float3 Specular = ( weightedBlend620 + weightedBlend621 ).rgb;
				float Metallic = 0;
				float Smoothness = ( weightedBlend587 + weightedBlend582 );
				float Occlusion = 1;
				float Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				float AlphaClipThreshold = _AlphaClipThreshold;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = IN.positionCS;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = WorldNormal;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( WorldViewDirection );

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#else
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
					#else
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(IN.positionCS,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData
				(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SCENESELECTIONPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				o.positionCS = TransformWorldToHClip(positionWS);

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_TerrainHolesTexture = IN.ase_texcoord.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				surfaceDescription.Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				surfaceDescription.AlphaClipThreshold = _AlphaClipThreshold;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SPECULAR_SETUP 1
			#define ASE_TESSELLATION 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120106
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

		    #define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _SplatMap2_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_1;
			float4 _TrailRenderTexOld_ST;
			float4 _Specular_Color_2;
			float4 _Specular_Color_3;
			float4 _Specular_Color_4;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_5;
			float4 _Specular_Color_6;
			float2 _UV_3;
			float2 _UV_2;
			float2 _UV_1;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_0;
			float _Smoothness_1;
			float _Layer_3TrailNormalStrength;
			float _Normal_Scale_4;
			float _Smoothness_6;
			float _Layer_4TrailNormalStrength;
			float _Normal_Scale_5;
			float _Layer_5TrailNormalStrength;
			float _Layer_6TrailNormalStrength;
			float _Smoothness_5;
			float _Smoothness_4;
			float _Smoothness_3;
			float _Smoothness_2;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Layer_2TrailNormalStrength;
			float _Displacement_5;
			float _Layer_1TrailNormalStrength;
			float _Layer_5_Offset;
			float _Layer_5TrailMultiplier;
			float _TrailPower;
			float _Layer_6_Offset;
			float _Layer_6TrailMultiplier;
			float _Layer_1_Offset;
			float _Layer_1TrailMultiplier;
			float _Layer_2_Offset;
			float _Layer_2TrailMultiplier;
			float _Normal_Scale_2;
			float _Layer_3_Offset;
			float _Layer_4_Offset;
			float _Layer_4TrailMultiplier;
			float _Displacement_1;
			float _Displacement_2;
			float _Displacement_3;
			float _Displacement_4;
			float _Displacement_6;
			float _GlobalOffset;
			float _Normal_Scale_1;
			float _Layer_3TrailMultiplier;
			float _AlphaClipThreshold;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_SplatMap2);
			SAMPLER(sampler_SplatMap2);
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			TEXTURE2D(_TrailRenderTexOld);
			SAMPLER(sampler_TrailRenderTexOld);
			TEXTURE2D(_SplatMap1);
			SAMPLER(sampler_SplatMap1);
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_SplatMap2 = v.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode510 = SAMPLE_TEXTURE2D_LOD( _SplatMap2, sampler_SplatMap2, uv_SplatMap2, 0.0 );
				float2 uv_AlbedoMaps = v.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode482 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float2 uv_TrailRenderTexOld = v.ase_texcoord.xy * _TrailRenderTexOld_ST.xy + _TrailRenderTexOld_ST.zw;
				float grayscale479 = Luminance(( ( SAMPLE_TEXTURE2D_LOD( _TrailRenderTexOld, sampler_TrailRenderTexOld, uv_TrailRenderTexOld, 0.0 ) * _TrailPower ) * float4( v.normalOS , 0.0 ) ).rgb);
				float4 tex2DArrayNode488 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 weightedBlendVar518 = tex2DNode510;
				float weightedBlend518 = ( weightedBlendVar518.x*( ( _Layer_5_Offset + tex2DArrayNode482.a ) + ( _Layer_5TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.y*( ( _Layer_6_Offset + tex2DArrayNode488.a ) + ( _Layer_6TrailMultiplier * grayscale479 ) ) + weightedBlendVar518.z*0.0 + weightedBlendVar518.w*0.0 );
				float2 uv_SplatMap1 = v.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode515 = SAMPLE_TEXTURE2D_LOD( _SplatMap1, sampler_SplatMap1, uv_SplatMap1, 0.0 );
				float4 tex2DArrayNode486 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode481 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode484 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode470 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar517 = tex2DNode515;
				float weightedBlend517 = ( weightedBlendVar517.x*( ( _Layer_1_Offset + tex2DArrayNode486.a ) + ( _Layer_1TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.y*( ( _Layer_2_Offset + tex2DArrayNode481.a ) + ( _Layer_2TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.z*( ( _Layer_3_Offset + tex2DArrayNode484.a ) + ( _Layer_3TrailMultiplier * grayscale479 ) ) + weightedBlendVar517.w*( ( _Layer_4_Offset + tex2DArrayNode470.a ) + ( _Layer_4TrailMultiplier * grayscale479 ) ) );
				float4 weightedBlendVar519 = tex2DNode515;
				float weightedBlend519 = ( weightedBlendVar519.x*_Displacement_1 + weightedBlendVar519.y*_Displacement_2 + weightedBlendVar519.z*_Displacement_3 + weightedBlendVar519.w*_Displacement_4 );
				float4 weightedBlendVar516 = tex2DNode510;
				float weightedBlend516 = ( weightedBlendVar516.x*_Displacement_5 + weightedBlendVar516.y*_Displacement_6 + weightedBlendVar516.z*0.0 + weightedBlendVar516.w*0.0 );
				float3 break525 = ( ( ( weightedBlend518 + weightedBlend517 ) * ( weightedBlend519 + weightedBlend516 ) ) * v.normalOS );
				float3 appendResult530 = (float3(break525.x , ( _GlobalOffset + break525.y ) , break525.z));
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( appendResult530 + float3( 0,0,0 ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );
				o.positionCS = TransformWorldToHClip(positionWS);

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
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
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_TerrainHolesTexture = IN.ase_texcoord.xy * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				

				surfaceDescription.Alpha = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				surfaceDescription.AlphaClipThreshold = _AlphaClipThreshold;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
						clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}
		
	}
	
	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback "Hidden/InternalErrorShader"
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;447;-4764.466,-476.3674;Inherit;False;1500.728;1727.471;Albedo;14;488;486;484;482;481;470;469;468;467;466;464;462;458;450;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;448;-4668.123,2679.832;Inherit;False;1312.486;696.8069;TireTracks;18;501;499;498;496;494;489;483;480;479;477;475;474;473;465;459;453;452;451;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;450;-4743.75,-419.4474;Float;True;Property;_AlbedoMaps;AlbedoMaps;2;0;Create;True;0;0;0;False;0;False;None;73d9b046cdd7442419b4bac5d6e7f15f;False;white;LockedToTexture2DArray;Texture2DArray;-1;0;2;SAMPLER2DARRAY;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;452;-4606.26,2739.944;Inherit;True;Property;_TrailRenderTexOld;TrailRenderTexOld;43;0;Create;True;0;0;0;False;0;False;-1;None;b5da14fe5b66ce04fa9d943ef642bf7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;451;-4536.021,2971.368;Inherit;False;Property;_TrailPower;TrailPower;42;0;Create;True;0;0;0;False;0;False;-1;-23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;453;-4275.994,3071.744;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;460;-8581.444,-217.9724;Float;False;Property;_UV_4;UV_4;15;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;459;-4263.022,2925.94;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;454;-8594.834,-816.6655;Float;False;Property;_UV_0;UV_0;16;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;461;-8578.881,-68.13439;Float;False;Property;_UV_5;UV_5;18;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;455;-8586.467,-368.7844;Float;False;Property;_UV_3;UV_3;23;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;457;-8586.467,-516.7455;Float;False;Property;_UV_2;UV_2;21;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;458;-4575.307,290.0605;Inherit;False;0;-1;2;3;2;SAMPLER2DARRAY;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;456;-8586.469,-672.6315;Float;False;Property;_UV_1;UV_1;19;0;Create;True;0;0;0;False;0;False;30,30;300,300;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;467;-3985.437,594.1285;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;469;-4032.823,391.355;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;462;-4014.626,-211.4065;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;466;-4028.866,-359.7195;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;464;-4010.892,-10.51842;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;463;-3368.259,1396.367;Inherit;False;1906.894;1329.876;Per Layer Vertex Offsets;21;521;518;517;512;509;508;506;505;503;497;495;493;492;491;490;487;485;478;476;472;471;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;468;-4017.644,183.0706;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;465;-4119.301,2939.219;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;473;-3746.164,2742.467;Inherit;False;Property;_Layer_1TrailMultiplier;Layer_1 Trail Multiplier;44;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;484;-3698.887,-19.41747;Inherit;True;Property;_TextureArray2;Texture Array 2;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;2;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;482;-3694.277,411.4836;Inherit;True;Property;_TextureArray10;Texture Array 10;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;4;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;474;-3755.054,3220.763;Inherit;False;Property;_Layer_6TrailMultiplier;Layer_6 Trail Multiplier;49;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;471;-3251.314,2110.571;Inherit;False;Property;_Layer_6_Offset;Layer_6_Offset;41;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;472;-3253.313,1998.646;Inherit;False;Property;_Layer_5_Offset;Layer_5_Offset;39;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;483;-3749.089,2835.011;Inherit;False;Property;_Layer_2TrailMultiplier;Layer_2 Trail Multiplier;45;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;488;-3684.542,595.0173;Inherit;True;Property;_TextureArray11;Texture Array 11;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;5;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;485;-3247.736,1497.163;Inherit;False;Property;_Layer_1_Offset;Layer_1_Offset;36;0;Create;True;0;0;0;False;0;False;0;-0.11;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;476;-3252.712,1635.881;Inherit;False;Property;_Layer_2_Offset;Layer_2_Offset;37;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;487;-3249.39,1758.898;Inherit;False;Property;_Layer_3_Offset;Layer_3_Offset;38;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;475;-3749.089,3121.344;Inherit;False;Property;_Layer_5TrailMultiplier;Layer_5 Trail Multiplier;48;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;470;-3700.062,186.6765;Inherit;True;Property;_TextureArray3;Texture Array 3;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;3;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;477;-3751.078,3017.946;Inherit;False;Property;_Layer_4TrailMultiplier;Layer_4 Trail Multiplier;47;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;486;-3719.649,-452.8214;Inherit;True;Property;_AlbedoArray;AlbedoArray;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;479;-3994.387,2937.034;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;478;-3246.39,1885.898;Inherit;False;Property;_Layer_4_Offset;Layer_4_Offset;40;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;481;-3710.11,-236.8844;Inherit;True;Property;_TextureArray1;Texture Array 1;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;1;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;480;-3745.111,2926.479;Inherit;False;Property;_Layer_3TrailMultiplier;Layer_3 Trail Multiplier;46;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;496;-3511.738,3229.107;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;491;-2898.425,1596.576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;497;-2891.405,1481.915;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;495;-2893.745,1870.357;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;494;-3502.847,2750.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;500;-342.5054,1891.553;Inherit;False;1271.142;776.9246;Displacement;12;524;523;522;520;519;516;514;513;511;507;504;502;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;493;-2889.065,1713.576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;492;-2898.668,2095.03;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;498;-3501.797,2934.821;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;501;-3505.773,2843.354;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;490;-2900.667,1983.104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;499;-3505.773,3129.686;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;489;-3507.761,3026.288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;512;-2395.423,2129.124;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;510;-8632.43,828.9604;Inherit;True;Property;_SplatMap2;SplatMap2;1;0;Create;True;0;0;0;False;0;False;-1;None;36f704705ae4fd248a10856f2851bf76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;504;-300.2935,2069.159;Float;False;Property;_Displacement_3;Displacement_3;29;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;502;-300.2925,2373.091;Float;False;Property;_Displacement_5;Displacement_5;31;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;514;-296.9082,1989.628;Float;False;Property;_Displacement_2;Displacement_2;28;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;513;-306.9453,2148.283;Float;False;Property;_Displacement_4;Displacement_4;30;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;507;-299.7983,2443.885;Float;False;Property;_Displacement_6;Displacement_6;32;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;511;-297.4541,1910.636;Float;False;Property;_Displacement_1;Displacement_1;27;0;Create;True;0;0;0;False;0;False;0;0.26;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;515;-8639.119,614.7137;Inherit;True;Property;_SplatMap1;SplatMap1;0;0;Create;True;0;0;0;False;0;False;-1;None;36f704705ae4fd248a10856f2851bf76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;503;-2393.148,2222.414;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;508;-2390.872,2399.898;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;505;-2393.148,2493.191;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;509;-2394.237,2029.299;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;506;-2395.423,2311.156;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;517;-1908.361,1449.57;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;516;85.68729,2316.839;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;519;90.93143,2088.03;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;518;-1901.724,1683.695;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;520;290.7383,2205.307;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;521;-1634.612,1562.235;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;522;523.9873,2213.224;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;523;508.8032,1943.712;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;524;759.6372,2002.451;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;525;747.1433,1342.045;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;526;674.8914,1131.096;Inherit;False;Property;_GlobalOffset;GlobalOffset;35;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;527;-153.8535,724.6747;Inherit;False;574.5013;345.7709;Holes;3;575;550;529;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;528;920.5593,1131.923;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;530;1129.166,1218.135;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;529;-133.9678,769.2942;Inherit;True;Property;_TerrainHolesTexture;Holes;33;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;533;-6467.191,1633.393;Inherit;False;889.2822;1491.483;Specular;14;621;620;618;605;603;590;588;581;571;569;554;548;539;536;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;531;-4606.088,-1672.365;Inherit;False;1068.033;924.5947;Comment;14;623;619;617;608;600;589;587;582;577;573;546;542;541;534;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;532;-6602.976,-3395.349;Inherit;False;1820.084;1642.141;Comment;18;624;616;612;611;610;609;602;601;592;584;578;570;568;557;551;549;547;545;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;551;-5482.866,-2462.547;Float;False;Property;_Normal_Scale_5;Normal_Scale_5;25;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-3487.533,4196.468;Inherit;False;Property;_Layer_4TrailNormalStrength;Layer_4 Trail Normal Strength;53;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;611;-5746.466,-3122.494;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;615;1056.411,908.7999;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;609;-5750.166,-2929.71;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;581;-6414.192,2186.302;Float;False;Property;_Specular_Color_4;Specular_Color_4;12;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;601;-5481.713,-2850.015;Float;False;Property;_Normal_Scale_3;Normal_Scale_3;22;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;624;-5744.527,-3314.877;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;570;-5483.855,-2267.875;Float;False;Property;_Normal_Scale_6;Normal_Scale_6;26;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;613;-3478.849,3801.997;Inherit;False;Property;_Layer_2TrailNormalStrength;Layer_2 Trail Normal Strength;51;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;538;-3483.363,4571.417;Inherit;False;Property;_Layer_6TrailNormalStrength;Layer_6 Trail Normal Strength;55;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;540;-3355.692,4281.218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;602;-5489.789,-2663.129;Float;False;Property;_Normal_Scale_4;Normal_Scale_4;24;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;592;-5486.375,-3041.121;Float;False;Property;_Normal_Scale_2;Normal_Scale_2;20;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;610;-5751.37,-2353.161;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;547;-5752.61,-2738.463;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SummedBlendNode;543;-2541.72,370.8816;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;607;-3956.514,-3003.116;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;621;-5796.176,2615.643;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;568;-5125.942,-3151.209;Inherit;True;Property;_TextureArray0;Texture Array 0;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;9;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;622;-3355.934,3522.342;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;541;-4150.938,-1426.844;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;569;-6417.192,2025.3;Float;False;Property;_Specular_Color_3;Specular_Color_3;11;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;550;4.105209,975.0831;Inherit;False;Property;_AlphaClipThreshold;AlphaClipThreshold;34;0;Create;True;0;0;0;False;0;False;0.8350586;0.8350586;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;612;-5135.535,-2570.871;Inherit;True;Property;_TextureArray6;Texture Array 6;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;12;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;554;-6055.055,2034.362;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;600;-4543.138,-1166.327;Float;False;Property;_Smoothness_5;Smoothness_5;7;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;617;-4150.81,-1296.444;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;616;-5748.154,-2540.417;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;579;-3482.905,3620.569;Inherit;False;Property;_Layer_1TrailNormalStrength;Layer_1 Trail Normal Strength;50;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;573;-4535.795,-1072.173;Float;False;Property;_Smoothness_6;Smoothness_6;8;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;558;-3199.383,3718.677;Inherit;False;Normal From Height;-1;;73;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;584;-5123.973,-2956.525;Inherit;True;Property;_TextureArray4;Texture Array 4;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;10;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;574;-3209.856,4113.147;Inherit;False;Normal From Height;-1;;74;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;608;-4548.745,-1414.246;Float;False;Property;_Smoothness_3;Smoothness_3;5;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;546;-4548.745,-1518.248;Float;False;Property;_Smoothness_2;Smoothness_2;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;567;-3360.722,3902.156;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;590;-6403.868,2590.484;Float;False;Property;_Specular_Color_6;Specular_Color_6;14;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;534;-4143.67,-1180.244;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;588;-6066.497,1725.583;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;605;-6057.999,2414.244;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;578;-5489.401,-3230.687;Float;False;Property;_Normal_Scale_1;Normal_Scale_1;17;0;Create;True;0;0;0;False;0;False;1;0.208;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;563;-2551.108,60.13161;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;576;-3359.827,4098.698;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;536;-6416.192,1865.3;Float;False;Property;_Specular_Color_2;Specular_Color_2;10;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;623;-4157.939,-1622.365;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;619;-4157.939,-1522.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;589;-4548.745,-1319.248;Float;False;Property;_Smoothness_4;Smoothness_4;6;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;577;-4556.088,-1612.401;Float;False;Property;_Smoothness_1;Smoothness_1;3;0;Create;True;0;0;0;False;0;False;0.5;1.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;542;-4144.988,-1076.149;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;560;-3203.894,4488.097;Inherit;False;Normal From Height;-1;;75;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;539;-6065.921,1871.658;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;537;-3870.24,-2481.554;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;564;-4267.195,-3446.406;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;606;-3951.988,-2157.429;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;535;-3353.866,4473.648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;572;-1666.694,509.7296;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;552;-3204.285,3519.396;Inherit;False;Normal From Height;-1;;76;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;556;-4215.81,-3254.325;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;566;-4240.915,-3351.963;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;545;-5140.232,-2380.7;Inherit;True;Property;_TextureArray7;Texture Array 7;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;13;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;618;-6051.421,2600.305;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;557;-5125.659,-3350.745;Inherit;True;Property;_NormallArray;NormallArray;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;8;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;591;-3490.219,3999.926;Inherit;False;Property;_Layer_3TrailNormalStrength;Layer_3 Trail Normal Strength;52;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;555;-3210.752,3916.604;Inherit;False;Normal From Height;-1;;77;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;620;-5792.053,1950.807;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;544;-3485.189,4378.988;Inherit;False;Property;_Layer_5TrailNormalStrength;Layer_5 Trail Normal Strength;54;0;Create;True;0;0;0;False;0;False;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;582;-3747.26,-1092.378;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;625;-1667.147,350.7375;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;585;-3205.721,4295.667;Inherit;False;Normal From Height;-1;;78;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;561;-4304.778,-3538.082;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;575;93.21733,769.7809;Inherit;True;Property;_TextureSample0;Texture Sample 0;35;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;571;-6401.296,2420.178;Float;False;Property;_Specular_Color_5;Specular_Color_5;13;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;583;-3407.629,-1235.813;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;548;-6057.721,2190.52;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;604;-3985.463,-2252.274;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;587;-3746.52,-1519.571;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;586;-2928.532,-2635.738;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;549;-5127.868,-2768.906;Inherit;True;Property;_TextureArray5;Texture Array 5;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;486;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;11;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;559;-3349.352,3704.227;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;603;-6415.36,1691.294;Float;False;Property;_Specular_Color_1;Specular_Color_1;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;632;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;634;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;633;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;631;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;635;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;629;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;626;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;627;1306.969,441.6699;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;LightingBox/Terrain/Terrain 6-Layers;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;40;Workflow;0;637905289015237368;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;0;0;Transmission;0;637905312169610098;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;  Use Shadow Threshold;0;637905312055071971;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;0;637905308842537518;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;DOTS Instancing;0;637905309801880762;Tessellation;1;637905303903258407;  Phong;0;637905309251857409;  Strength;1,False,;637905308994237527;  Type;1;637905303935758968;  Tess;10,False,;0;  Min;30,False,;637905304002664495;  Max;100,False,;637905304022973021;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;637905312303009536;Clear Coat;0;637905312349431669;0;10;False;True;True;True;True;True;True;True;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;628;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;630;1306.969,441.6699;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;459;0;452;0
WireConnection;459;1;451;0
WireConnection;458;2;450;0
WireConnection;467;0;458;0
WireConnection;467;1;461;0
WireConnection;469;0;458;0
WireConnection;469;1;460;0
WireConnection;462;0;458;0
WireConnection;462;1;456;0
WireConnection;466;0;458;0
WireConnection;466;1;454;0
WireConnection;464;0;458;0
WireConnection;464;1;457;0
WireConnection;468;0;458;0
WireConnection;468;1;455;0
WireConnection;465;0;459;0
WireConnection;465;1;453;0
WireConnection;484;1;464;0
WireConnection;482;1;469;0
WireConnection;488;1;467;0
WireConnection;470;1;468;0
WireConnection;486;0;450;0
WireConnection;486;1;466;0
WireConnection;479;0;465;0
WireConnection;481;1;462;0
WireConnection;496;0;474;0
WireConnection;496;1;479;0
WireConnection;491;0;476;0
WireConnection;491;1;481;4
WireConnection;497;0;485;0
WireConnection;497;1;486;4
WireConnection;495;0;478;0
WireConnection;495;1;470;4
WireConnection;494;0;473;0
WireConnection;494;1;479;0
WireConnection;493;0;487;0
WireConnection;493;1;484;4
WireConnection;492;0;471;0
WireConnection;492;1;488;4
WireConnection;498;0;480;0
WireConnection;498;1;479;0
WireConnection;501;0;483;0
WireConnection;501;1;479;0
WireConnection;490;0;472;0
WireConnection;490;1;482;4
WireConnection;499;0;475;0
WireConnection;499;1;479;0
WireConnection;489;0;477;0
WireConnection;489;1;479;0
WireConnection;512;0;491;0
WireConnection;512;1;501;0
WireConnection;503;0;493;0
WireConnection;503;1;498;0
WireConnection;508;0;490;0
WireConnection;508;1;499;0
WireConnection;505;0;492;0
WireConnection;505;1;496;0
WireConnection;509;0;497;0
WireConnection;509;1;494;0
WireConnection;506;0;495;0
WireConnection;506;1;489;0
WireConnection;517;0;515;0
WireConnection;517;1;509;0
WireConnection;517;2;512;0
WireConnection;517;3;503;0
WireConnection;517;4;506;0
WireConnection;516;0;510;0
WireConnection;516;1;502;0
WireConnection;516;2;507;0
WireConnection;519;0;515;0
WireConnection;519;1;511;0
WireConnection;519;2;514;0
WireConnection;519;3;504;0
WireConnection;519;4;513;0
WireConnection;518;0;510;0
WireConnection;518;1;508;0
WireConnection;518;2;505;0
WireConnection;520;0;519;0
WireConnection;520;1;516;0
WireConnection;521;0;518;0
WireConnection;521;1;517;0
WireConnection;523;0;521;0
WireConnection;523;1;520;0
WireConnection;524;0;523;0
WireConnection;524;1;522;0
WireConnection;525;0;524;0
WireConnection;528;0;526;0
WireConnection;528;1;525;1
WireConnection;530;0;525;0
WireConnection;530;1;528;0
WireConnection;530;2;525;2
WireConnection;611;0;458;0
WireConnection;611;1;456;0
WireConnection;615;0;530;0
WireConnection;609;0;458;0
WireConnection;609;1;457;0
WireConnection;624;0;458;0
WireConnection;624;1;454;0
WireConnection;540;0;475;0
WireConnection;540;1;479;0
WireConnection;610;0;458;0
WireConnection;610;1;461;0
WireConnection;547;0;458;0
WireConnection;547;1;455;0
WireConnection;543;0;510;0
WireConnection;543;1;482;0
WireConnection;543;2;488;0
WireConnection;607;0;515;0
WireConnection;607;1;561;0
WireConnection;607;2;564;0
WireConnection;607;3;566;0
WireConnection;607;4;556;0
WireConnection;621;0;510;0
WireConnection;621;1;605;0
WireConnection;621;2;618;0
WireConnection;568;1;611;0
WireConnection;568;5;592;0
WireConnection;622;0;473;0
WireConnection;622;1;479;0
WireConnection;541;0;608;0
WireConnection;541;1;484;1
WireConnection;612;1;616;0
WireConnection;612;5;551;0
WireConnection;554;0;569;0
WireConnection;554;1;484;2
WireConnection;617;0;589;0
WireConnection;617;1;470;1
WireConnection;616;0;458;0
WireConnection;616;1;460;0
WireConnection;558;20;559;0
WireConnection;558;110;613;0
WireConnection;584;1;609;0
WireConnection;584;5;601;0
WireConnection;574;20;576;0
WireConnection;574;110;553;0
WireConnection;567;0;480;0
WireConnection;567;1;479;0
WireConnection;534;0;600;0
WireConnection;534;1;482;1
WireConnection;588;0;603;0
WireConnection;588;1;486;2
WireConnection;605;0;571;0
WireConnection;605;1;482;2
WireConnection;563;0;515;0
WireConnection;563;1;486;0
WireConnection;563;2;481;0
WireConnection;563;3;484;0
WireConnection;563;4;470;0
WireConnection;576;0;477;0
WireConnection;576;1;479;0
WireConnection;623;0;577;0
WireConnection;623;1;486;1
WireConnection;619;0;546;0
WireConnection;619;1;481;1
WireConnection;542;0;573;0
WireConnection;542;1;488;1
WireConnection;560;20;535;0
WireConnection;560;110;538;0
WireConnection;539;0;536;0
WireConnection;539;1;481;2
WireConnection;537;0;510;0
WireConnection;537;1;604;0
WireConnection;537;2;606;0
WireConnection;564;0;568;0
WireConnection;564;1;558;0
WireConnection;606;0;545;0
WireConnection;606;1;560;0
WireConnection;535;0;474;0
WireConnection;535;1;479;0
WireConnection;572;0;620;0
WireConnection;572;1;621;0
WireConnection;552;20;622;0
WireConnection;552;110;579;0
WireConnection;556;0;549;0
WireConnection;556;1;574;0
WireConnection;566;0;584;0
WireConnection;566;1;555;0
WireConnection;545;1;610;0
WireConnection;545;5;570;0
WireConnection;618;0;590;0
WireConnection;618;1;488;2
WireConnection;557;1;624;0
WireConnection;557;5;578;0
WireConnection;555;20;567;0
WireConnection;555;110;591;0
WireConnection;620;0;515;0
WireConnection;620;1;588;0
WireConnection;620;2;539;0
WireConnection;620;3;554;0
WireConnection;620;4;548;0
WireConnection;582;0;510;0
WireConnection;582;1;534;0
WireConnection;582;2;542;0
WireConnection;625;0;563;0
WireConnection;625;1;543;0
WireConnection;585;20;540;0
WireConnection;585;110;544;0
WireConnection;561;0;557;0
WireConnection;561;1;552;0
WireConnection;575;0;529;0
WireConnection;583;0;587;0
WireConnection;583;1;582;0
WireConnection;548;0;581;0
WireConnection;548;1;470;2
WireConnection;604;0;612;0
WireConnection;604;1;585;0
WireConnection;587;0;515;0
WireConnection;587;1;623;0
WireConnection;587;2;619;0
WireConnection;587;3;541;0
WireConnection;587;4;617;0
WireConnection;586;0;607;0
WireConnection;586;1;537;0
WireConnection;549;1;547;0
WireConnection;549;5;602;0
WireConnection;559;0;483;0
WireConnection;559;1;479;0
WireConnection;627;0;625;0
WireConnection;627;1;586;0
WireConnection;627;9;572;0
WireConnection;627;4;583;0
WireConnection;627;6;575;0
WireConnection;627;7;550;0
WireConnection;627;8;615;0
ASEEND*/
//CHKSM=9AB77C6070F1839A6CE3283D8CEDCCAF2CE78F74