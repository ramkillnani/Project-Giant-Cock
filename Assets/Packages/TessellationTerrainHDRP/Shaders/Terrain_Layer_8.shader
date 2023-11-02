// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LightingBox/Terrain/Terrain 8-Layers"
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
		_Smoothness_7("Smoothness_7", Range( 0 , 1)) = 0.5
		_Smoothness_8("Smoothness_8", Range( 0 , 1)) = 0.5
		_Specular_Color_1("Specular_Color_1", Color) = (0,0,0,0)
		_UV_4("UV_4", Vector) = (30,30,0,0)
		_UV_0("UV_0", Vector) = (30,30,0,0)
		_Specular_Color_2("Specular_Color_2", Color) = (0,0,0,0)
		_UV_5("UV_5", Vector) = (30,30,0,0)
		_UV_1("UV_1", Vector) = (30,30,0,0)
		_Specular_Color_3("Specular_Color_3", Color) = (0,0,0,0)
		_UV_6("UV_6", Vector) = (30,30,0,0)
		_UV_2("UV_2", Vector) = (30,30,0,0)
		_UV_7("UV_7", Vector) = (30,30,0,0)
		_Specular_Color_4("Specular_Color_4", Color) = (0,0,0,0)
		_UV_3("UV_3", Vector) = (30,30,0,0)
		_Specular_Color_5("Specular_Color_5", Color) = (0,0,0,0)
		_Specular_Color_6("Specular_Color_6", Color) = (0,0,0,0)
		_Specular_Color_7("Specular_Color_7", Color) = (0,0,0,0)
		_Specular_Color_8("Specular_Color_8", Color) = (0,0,0,0)
		_Normal_Scale_1("Normal_Scale_1", Range( 0 , 1)) = 1
		_Normal_Scale_2("Normal_Scale_2", Range( 0 , 1)) = 1
		_Normal_Scale_3("Normal_Scale_3", Range( 0 , 1)) = 1
		_Normal_Scale_4("Normal_Scale_4", Range( 0 , 1)) = 1
		_Normal_Scale_5("Normal_Scale_5", Range( 0 , 1)) = 1
		_Normal_Scale_6("Normal_Scale_6", Range( 0 , 1)) = 0
		_Normal_Scale_7("Normal_Scale_7", Range( 0 , 1)) = 1
		_Normal_Scale_8("Normal_Scale_8", Range( 0 , 1)) = 1
		_Displacement_1("Displacement_1", Range( 0 , 3)) = 0
		_Displacement_2("Displacement_2", Range( 0 , 3)) = 0
		_Displacement_3("Displacement_3", Range( 0 , 3)) = 0
		_Displacement_4("Displacement_4", Range( 0 , 3)) = 0
		_Displacement_5("Displacement_5", Range( 0 , 3)) = 0
		_Displacement_6("Displacement_6", Range( 0 , 3)) = 0
		_Displacement_7("Displacement_7", Range( 0 , 3)) = 0
		[ASEEnd]_Displacement_8("Displacement_8", Range( 0 , 3)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		[HideInInspector] [ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector] [ToggleUI]_SupportDecals("Boolean", Float) = 1
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 6
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 8
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 40
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 40
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 14
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 10
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector] [ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector] [ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector] [ToggleUI] _ReceivesSSRTransparent("Boolean", Float) = 0
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector] [ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector] [ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 1
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Int) = 0
		[HideInInspector] [ToggleUI] _EnableFogOnTransparent("Enable Fog On Transparent", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2
		[HideInInspector] [Enum(Front, 1, Back, 2)] _TransparentCullMode("Transparent Cull Mode", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4
		[HideInInspector] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Float) = 4
		[HideInInspector] [ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector] [ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 0
		[HideInInspector] [ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector] [ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
		[HideInInspector] [Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 16
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
		#pragma multi_compile_instancing
		#pragma instancing_options renderinglayer

		struct GlobalSurfaceDescription // GBuffer Forward META TransparentBackface
		{
			float3 Albedo;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float SpecularOcclusion;
			float DepthOffset;
			//Refraction
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			//SSS/Translucent
			float Thickness;
			float SubsurfaceMask;
			float DiffusionProfile;
			//Anisotropy
			float Anisotropy;
			float3 Tangent;
			//Iridescent
			float IridescenceMask;
			float IridescenceThickness;
			//BakedGI
			float3 BakedGI;
			float3 BakedBackGI;
		};

		struct AlphaSurfaceDescription // ShadowCaster
		{
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float DepthOffset;
		};

		struct SceneSurfaceDescription // SceneSelection
		{
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		struct PrePassSurfaceDescription // DepthPrePass
		{
			float3 Normal;
			float Smoothness;
			float Alpha;
			float AlphaClipThresholdDepthPrepass;
			float DepthOffset;
		};

		struct PostPassSurfaceDescription //DepthPostPass
		{
			float Alpha;
			float AlphaClipThresholdDepthPostpass;
			float DepthOffset;
		};

		struct SmoothSurfaceDescription // MotionVectors DepthOnly
		{
			float3 Normal;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		struct DistortionSurfaceDescription //Distortion
		{
			float Alpha;
			float2 Distortion;
			float DistortionBlur;
			float AlphaClipThreshold;
		};
		
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

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
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
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#if !defined(DEBUG_DISPLAY) && defined(_ALPHATEST_ON)
			#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
			#endif

			#define SHADERPASS SHADERPASS_GBUFFER
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile _ LIGHT_LAYERS

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 interp03 : TEXCOORD3;
				float4 interp04 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			
			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				#if (SHADERPASS == SHADERPASS_DISTORTION)
				builtinData.distortion = surfaceDescription.Distortion;
				builtinData.distortionBlur = surfaceDescription.DistortionBlur;
				#else
				builtinData.distortion = float2(0.0, 0.0);
				builtinData.distortionBlur = 0.0;
				#endif

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				
				outputPackedVaryingsMeshToPS.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord5.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.interp03.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.interp04.xyzw = inputMesh.uv2;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
						)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.interp03.xyzw;
				input.texCoord2 = packedInput.interp04.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				SurfaceData surfaceData;
				BuiltinData builtinData;

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_SplatMap1 = packedInput.ase_texcoord5.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2D( _SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = packedInput.ase_texcoord5.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar66 = tex2DNode9;
				float4 weightedBlend66 = ( weightedBlendVar66.x*tex2DArrayNode10 + weightedBlendVar66.y*tex2DArrayNode11 + weightedBlendVar66.z*tex2DArrayNode14 + weightedBlendVar66.w*tex2DArrayNode17 );
				float2 uv_SplatMap2 = packedInput.ase_texcoord5.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2D( _SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0 );
				float4 tex2DArrayNode174 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),7.0 );
				float4 weightedBlendVar179 = tex2DNode138;
				float4 weightedBlend179 = ( weightedBlendVar179.x*tex2DArrayNode171 + weightedBlendVar179.y*tex2DArrayNode172 + weightedBlendVar179.z*tex2DArrayNode173 + weightedBlendVar179.w*tex2DArrayNode174 );
				
				float3 unpack200 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack200.z = lerp( 1, unpack200.z, saturate(_Normal_Scale_1) );
				float3 unpack94 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack94.z = lerp( 1, unpack94.z, saturate(_Normal_Scale_2) );
				float3 unpack95 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack95.z = lerp( 1, unpack95.z, saturate(_Normal_Scale_3) );
				float3 unpack96 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack96.z = lerp( 1, unpack96.z, saturate(_Normal_Scale_4) );
				float4 weightedBlendVar97 = tex2DNode9;
				float3 weightedBlend97 = ( weightedBlendVar97.x*unpack200 + weightedBlendVar97.y*unpack94 + weightedBlendVar97.z*unpack95 + weightedBlendVar97.w*unpack96 );
				float3 unpack141 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack141.z = lerp( 1, unpack141.z, saturate(_Normal_Scale_5) );
				float3 unpack144 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack144.z = lerp( 1, unpack144.z, saturate(_Normal_Scale_6) );
				float3 unpack147 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),14.0 ), _Normal_Scale_7 );
				unpack147.z = lerp( 1, unpack147.z, saturate(_Normal_Scale_7) );
				float3 unpack150 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),14.0 ), _Normal_Scale_8 );
				unpack150.z = lerp( 1, unpack150.z, saturate(_Normal_Scale_8) );
				float4 weightedBlendVar159 = tex2DNode138;
				float3 weightedBlend159 = ( weightedBlendVar159.x*unpack141 + weightedBlendVar159.y*unpack144 + weightedBlendVar159.z*unpack147 + weightedBlendVar159.w*unpack150 );
				
				float4 weightedBlendVar90 = tex2DNode9;
				float4 weightedBlend90 = ( weightedBlendVar90.x*( _Specular_Color_1 * tex2DArrayNode10.g ) + weightedBlendVar90.y*( _Specular_Color_2 * tex2DArrayNode11.g ) + weightedBlendVar90.z*( _Specular_Color_3 * tex2DArrayNode14.g ) + weightedBlendVar90.w*( _Specular_Color_4 * tex2DArrayNode17.g ) );
				float4 weightedBlendVar189 = tex2DNode138;
				float4 weightedBlend189 = ( weightedBlendVar189.x*( _Specular_Color_5 * tex2DArrayNode171.g ) + weightedBlendVar189.y*( _Specular_Color_6 * tex2DArrayNode172.g ) + weightedBlendVar189.z*( _Specular_Color_7 * tex2DArrayNode173.g ) + weightedBlendVar189.w*( _Specular_Color_8 * tex2DArrayNode174.g ) );
				
				float4 weightedBlendVar75 = tex2DNode9;
				float weightedBlend75 = ( weightedBlendVar75.x*( _Smoothness_1 * tex2DArrayNode10.r ) + weightedBlendVar75.y*( _Smoothness_2 * tex2DArrayNode11.r ) + weightedBlendVar75.z*( _Smoothness_3 * tex2DArrayNode14.r ) + weightedBlendVar75.w*( _Smoothness_4 * tex2DArrayNode17.r ) );
				float4 weightedBlendVar161 = tex2DNode138;
				float weightedBlend161 = ( weightedBlendVar161.x*( _Smoothness_5 * tex2DArrayNode171.r ) + weightedBlendVar161.y*( _Smoothness_6 * tex2DArrayNode172.r ) + weightedBlendVar161.z*( _Smoothness_7 * tex2DArrayNode173.r ) + weightedBlendVar161.w*( _Smoothness_8 * tex2DArrayNode174.r ) );
				
				surfaceDescription.Albedo = ( weightedBlend66 + weightedBlend179 ).rgb;
				surfaceDescription.Normal = ( weightedBlend97 + weightedBlend159 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = ( weightedBlend90 + weightedBlend189 ).rgb;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = ( weightedBlend75 + weightedBlend161 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef _ASE_DISTORTION
				surfaceDescription.Distortion = float2 ( 2, -1 );
				surfaceDescription.DistortionBlur = 1;
				#endif

				#ifdef _ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );
				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );
				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			
			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			
			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				builtinData.emissiveColor = surfaceDescription.Emission;

				#if (SHADERPASS == SHADERPASS_DISTORTION)
				builtinData.distortion = surfaceDescription.Distortion;
				builtinData.distortionBlur = surfaceDescription.DistortionBlur;
				#else
				builtinData.distortion = float2(0.0, 0.0);
				builtinData.distortionBlur = 0.0;
				#endif

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			CBUFFER_START(UnityMetaPass)
			bool4 unity_MetaVertexControl;
			bool4 unity_MetaFragmentControl;
			CBUFFER_END

			float unity_OneOverOutputBoost;
			float unity_MaxOutputValue;

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

				float2 uv_SplatMap2 = inputMesh.uv0.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.uv0.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.uv0.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				
				outputPackedVaryingsMeshToPS.ase_texcoord.xy = inputMesh.uv0.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float2 uv = float2(0.0, 0.0);
				if (unity_MetaVertexControl.x)
				{
					uv = inputMesh.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				}
				else if (unity_MetaVertexControl.y)
				{
					uv = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				}

				outputPackedVaryingsMeshToPS.positionCS = float4(uv * 2.0 - 1.0, inputMesh.positionOS.z > 0 ? 1.0e-4 : 0.0, 1.0);
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_SplatMap1 = packedInput.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2D( _SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = packedInput.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar66 = tex2DNode9;
				float4 weightedBlend66 = ( weightedBlendVar66.x*tex2DArrayNode10 + weightedBlendVar66.y*tex2DArrayNode11 + weightedBlendVar66.z*tex2DArrayNode14 + weightedBlendVar66.w*tex2DArrayNode17 );
				float2 uv_SplatMap2 = packedInput.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2D( _SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0 );
				float4 tex2DArrayNode174 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),7.0 );
				float4 weightedBlendVar179 = tex2DNode138;
				float4 weightedBlend179 = ( weightedBlendVar179.x*tex2DArrayNode171 + weightedBlendVar179.y*tex2DArrayNode172 + weightedBlendVar179.z*tex2DArrayNode173 + weightedBlendVar179.w*tex2DArrayNode174 );
				
				float3 unpack200 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack200.z = lerp( 1, unpack200.z, saturate(_Normal_Scale_1) );
				float3 unpack94 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack94.z = lerp( 1, unpack94.z, saturate(_Normal_Scale_2) );
				float3 unpack95 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack95.z = lerp( 1, unpack95.z, saturate(_Normal_Scale_3) );
				float3 unpack96 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack96.z = lerp( 1, unpack96.z, saturate(_Normal_Scale_4) );
				float4 weightedBlendVar97 = tex2DNode9;
				float3 weightedBlend97 = ( weightedBlendVar97.x*unpack200 + weightedBlendVar97.y*unpack94 + weightedBlendVar97.z*unpack95 + weightedBlendVar97.w*unpack96 );
				float3 unpack141 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack141.z = lerp( 1, unpack141.z, saturate(_Normal_Scale_5) );
				float3 unpack144 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack144.z = lerp( 1, unpack144.z, saturate(_Normal_Scale_6) );
				float3 unpack147 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),14.0 ), _Normal_Scale_7 );
				unpack147.z = lerp( 1, unpack147.z, saturate(_Normal_Scale_7) );
				float3 unpack150 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),14.0 ), _Normal_Scale_8 );
				unpack150.z = lerp( 1, unpack150.z, saturate(_Normal_Scale_8) );
				float4 weightedBlendVar159 = tex2DNode138;
				float3 weightedBlend159 = ( weightedBlendVar159.x*unpack141 + weightedBlendVar159.y*unpack144 + weightedBlendVar159.z*unpack147 + weightedBlendVar159.w*unpack150 );
				
				float4 weightedBlendVar90 = tex2DNode9;
				float4 weightedBlend90 = ( weightedBlendVar90.x*( _Specular_Color_1 * tex2DArrayNode10.g ) + weightedBlendVar90.y*( _Specular_Color_2 * tex2DArrayNode11.g ) + weightedBlendVar90.z*( _Specular_Color_3 * tex2DArrayNode14.g ) + weightedBlendVar90.w*( _Specular_Color_4 * tex2DArrayNode17.g ) );
				float4 weightedBlendVar189 = tex2DNode138;
				float4 weightedBlend189 = ( weightedBlendVar189.x*( _Specular_Color_5 * tex2DArrayNode171.g ) + weightedBlendVar189.y*( _Specular_Color_6 * tex2DArrayNode172.g ) + weightedBlendVar189.z*( _Specular_Color_7 * tex2DArrayNode173.g ) + weightedBlendVar189.w*( _Specular_Color_8 * tex2DArrayNode174.g ) );
				
				float4 weightedBlendVar75 = tex2DNode9;
				float weightedBlend75 = ( weightedBlendVar75.x*( _Smoothness_1 * tex2DArrayNode10.r ) + weightedBlendVar75.y*( _Smoothness_2 * tex2DArrayNode11.r ) + weightedBlendVar75.z*( _Smoothness_3 * tex2DArrayNode14.r ) + weightedBlendVar75.w*( _Smoothness_4 * tex2DArrayNode17.r ) );
				float4 weightedBlendVar161 = tex2DNode138;
				float weightedBlend161 = ( weightedBlendVar161.x*( _Smoothness_5 * tex2DArrayNode171.r ) + weightedBlendVar161.y*( _Smoothness_6 * tex2DArrayNode172.r ) + weightedBlendVar161.z*( _Smoothness_7 * tex2DArrayNode173.r ) + weightedBlendVar161.w*( _Smoothness_8 * tex2DArrayNode174.r ) );
				
				surfaceDescription.Albedo = ( weightedBlend66 + weightedBlend179 ).rgb;
				surfaceDescription.Normal = ( weightedBlend97 + weightedBlend159 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = ( weightedBlend90 + weightedBlend189 ).rgb;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = ( weightedBlend75 + weightedBlend161 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4(0.0, 0.0, 0.0, 1.0);
				if (unity_MetaFragmentControl.x)
				{
					res.rgb = clamp(pow(abs(lightTransportData.diffuseColor), saturate(unity_OneOverOutputBoost)), 0, unity_MaxOutputValue);
				}

				if (unity_MetaFragmentControl.y)
				{
					res.rgb = lightTransportData.emissiveColor;
				}

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_SHADOWS

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			//#define USE_LEGACY_UNITY_MATRIX_VARIABLES

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			
			void BuildSurfaceData(FragInputs fragInputs, inout AlphaSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(AlphaSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				#ifdef _ALPHATEST_SHADOW_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow );
				#else
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
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
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif
			
			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				AlphaSurfaceDescription surfaceDescription = (AlphaSurfaceDescription)0;
				
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }
			ColorMask 0

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENESELECTIONPASS
			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			int _ObjectId;
			int _PassValue;

			
			void BuildSurfaceData(FragInputs fragInputs, inout SceneSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SceneSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
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
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SceneSurfaceDescription surfaceDescription = (SceneSurfaceDescription)0;
				
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _BLENDMODE_OFF _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ _DISABLE_DECALS

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile _ WRITE_MSAA_DEPTH
			#pragma multi_compile _ WRITE_DECAL_BUFFER

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			
			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			
			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif
			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				
				outputPackedVaryingsMeshToPS.ase_texcoord3.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				return outputPackedVaryingsMeshToPS;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
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

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
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
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
				#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
				#define SV_TARGET_DECAL SV_Target1
			#else
				#define SV_TARGET_DECAL SV_Target0
			#endif
			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
						, out float4 outDecalBuffer : SV_TARGET_DECAL
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float2 uv_SplatMap1 = packedInput.ase_texcoord3.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2D( _SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = packedInput.ase_texcoord3.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float3 unpack200 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack200.z = lerp( 1, unpack200.z, saturate(_Normal_Scale_1) );
				float3 unpack94 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack94.z = lerp( 1, unpack94.z, saturate(_Normal_Scale_2) );
				float3 unpack95 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack95.z = lerp( 1, unpack95.z, saturate(_Normal_Scale_3) );
				float3 unpack96 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack96.z = lerp( 1, unpack96.z, saturate(_Normal_Scale_4) );
				float4 weightedBlendVar97 = tex2DNode9;
				float3 weightedBlend97 = ( weightedBlendVar97.x*unpack200 + weightedBlendVar97.y*unpack94 + weightedBlendVar97.z*unpack95 + weightedBlendVar97.w*unpack96 );
				float2 uv_SplatMap2 = packedInput.ase_texcoord3.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2D( _SplatMap2, uv_SplatMap2 );
				float3 unpack141 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack141.z = lerp( 1, unpack141.z, saturate(_Normal_Scale_5) );
				float3 unpack144 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack144.z = lerp( 1, unpack144.z, saturate(_Normal_Scale_6) );
				float3 unpack147 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),14.0 ), _Normal_Scale_7 );
				unpack147.z = lerp( 1, unpack147.z, saturate(_Normal_Scale_7) );
				float3 unpack150 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),14.0 ), _Normal_Scale_8 );
				unpack150.z = lerp( 1, unpack150.z, saturate(_Normal_Scale_8) );
				float4 weightedBlendVar159 = tex2DNode138;
				float3 weightedBlend159 = ( weightedBlendVar159.x*unpack141 + weightedBlendVar159.y*unpack144 + weightedBlendVar159.z*unpack147 + weightedBlendVar159.w*unpack150 );
				
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar75 = tex2DNode9;
				float weightedBlend75 = ( weightedBlendVar75.x*( _Smoothness_1 * tex2DArrayNode10.r ) + weightedBlendVar75.y*( _Smoothness_2 * tex2DArrayNode11.r ) + weightedBlendVar75.z*( _Smoothness_3 * tex2DArrayNode14.r ) + weightedBlendVar75.w*( _Smoothness_4 * tex2DArrayNode17.r ) );
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0 );
				float4 tex2DArrayNode174 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),7.0 );
				float4 weightedBlendVar161 = tex2DNode138;
				float weightedBlend161 = ( weightedBlendVar161.x*( _Smoothness_5 * tex2DArrayNode171.r ) + weightedBlendVar161.y*( _Smoothness_6 * tex2DArrayNode172.r ) + weightedBlendVar161.z*( _Smoothness_7 * tex2DArrayNode173.r ) + weightedBlendVar161.w*( _Smoothness_8 * tex2DArrayNode174.r ) );
				
				surfaceDescription.Normal = ( weightedBlend97 + weightedBlend159 );
				surfaceDescription.Smoothness = ( weightedBlend75 + weightedBlend161 );
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif

				#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Motion Vectors"
			Tags { "LightMode"="MotionVectors" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_MOTION_VECTORS
			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			
			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			
			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				
				outputPackedVaryingsMeshToPS.ase_texcoord3.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS =  inputMesh.normalOS ;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				float3 VMESHpositionRWS = positionRWS;
				float4 VMESHpositionCS = TransformWorldToHClip(positionRWS);

				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(VMESHpositionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}

				outputPackedVaryingsMeshToPS.vmeshPositionCS = VMESHpositionCS;
				outputPackedVaryingsMeshToPS.vmeshInterp00.xyz = VMESHpositionRWS;

				outputPackedVaryingsMeshToPS.vpassInterpolators0 = float3(VPASSpositionCS.xyw);
				outputPackedVaryingsMeshToPS.vpassInterpolators1 = float3(VPASSpreviousPositionCS.xyw);
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.previousPositionOS = v.previousPositionOS;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
				o.precomputedVelocity = v.precomputedVelocity;
				#endif
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
				#endif
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
				, out float4 outMotionVector : SV_Target0
				#ifdef WRITE_NORMAL_BUFFER
				, out float4 outNormalBuffer : SV_Target1
					#ifdef WRITE_MSAA_DEPTH
						, out float1 depthColor : SV_Target2
					#endif
				#elif defined(WRITE_MSAA_DEPTH)
				, out float4 outNormalBuffer : SV_Target1
				, out float1 depthColor : SV_Target2
				#endif

				#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
				#endif
				
				)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.vmeshPositionCS;
				input.positionRWS = packedInput.vmeshInterp00.xyz;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SurfaceData surfaceData;
				BuiltinData builtinData;

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float2 uv_SplatMap1 = packedInput.ase_texcoord3.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2D( _SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = packedInput.ase_texcoord3.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float3 unpack200 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack200.z = lerp( 1, unpack200.z, saturate(_Normal_Scale_1) );
				float3 unpack94 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack94.z = lerp( 1, unpack94.z, saturate(_Normal_Scale_2) );
				float3 unpack95 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack95.z = lerp( 1, unpack95.z, saturate(_Normal_Scale_3) );
				float3 unpack96 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack96.z = lerp( 1, unpack96.z, saturate(_Normal_Scale_4) );
				float4 weightedBlendVar97 = tex2DNode9;
				float3 weightedBlend97 = ( weightedBlendVar97.x*unpack200 + weightedBlendVar97.y*unpack94 + weightedBlendVar97.z*unpack95 + weightedBlendVar97.w*unpack96 );
				float2 uv_SplatMap2 = packedInput.ase_texcoord3.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2D( _SplatMap2, uv_SplatMap2 );
				float3 unpack141 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack141.z = lerp( 1, unpack141.z, saturate(_Normal_Scale_5) );
				float3 unpack144 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack144.z = lerp( 1, unpack144.z, saturate(_Normal_Scale_6) );
				float3 unpack147 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),14.0 ), _Normal_Scale_7 );
				unpack147.z = lerp( 1, unpack147.z, saturate(_Normal_Scale_7) );
				float3 unpack150 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),14.0 ), _Normal_Scale_8 );
				unpack150.z = lerp( 1, unpack150.z, saturate(_Normal_Scale_8) );
				float4 weightedBlendVar159 = tex2DNode138;
				float3 weightedBlend159 = ( weightedBlendVar159.x*unpack141 + weightedBlendVar159.y*unpack144 + weightedBlendVar159.z*unpack147 + weightedBlendVar159.w*unpack150 );
				
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar75 = tex2DNode9;
				float weightedBlend75 = ( weightedBlendVar75.x*( _Smoothness_1 * tex2DArrayNode10.r ) + weightedBlendVar75.y*( _Smoothness_2 * tex2DArrayNode11.r ) + weightedBlendVar75.z*( _Smoothness_3 * tex2DArrayNode14.r ) + weightedBlendVar75.w*( _Smoothness_4 * tex2DArrayNode17.r ) );
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0 );
				float4 tex2DArrayNode174 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),7.0 );
				float4 weightedBlendVar161 = tex2DNode138;
				float weightedBlend161 = ( weightedBlendVar161.x*( _Smoothness_5 * tex2DArrayNode171.r ) + weightedBlendVar161.y*( _Smoothness_6 * tex2DArrayNode172.r ) + weightedBlendVar161.z*( _Smoothness_7 * tex2DArrayNode173.r ) + weightedBlendVar161.w*( _Smoothness_8 * tex2DArrayNode174.r ) );
				
				surfaceDescription.Normal = ( weightedBlend97 + weightedBlend159 );
				surfaceDescription.Smoothness = ( weightedBlend75 + weightedBlend161 );
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );

				float4 VPASSpositionCS = float4(packedInput.vpassInterpolators0.xy, 0.0, packedInput.vpassInterpolators0.z);
				float4 VPASSpreviousPositionCS = float4(packedInput.vpassInterpolators1.xy, 0.0, packedInput.vpassInterpolators1.z);

				#ifdef _DEPTHOFFSET_ON
				VPASSpositionCS.w += builtinData.depthOffset;
				VPASSpreviousPositionCS.w += builtinData.depthOffset;
				#endif

				float2 motionVector = CalculateMotionVector( VPASSpositionCS, VPASSpreviousPositionCS );
				EncodeMotionVector( motionVector * 0.5, outMotionVector );

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if( forceNoMotion )
					outMotionVector = float4( 2.0, 0.0, 0.0, 0.0 );

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );

				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.vmeshPositionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.vmeshPositionCS.z;
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			ColorMask [_ColorMaskTransparentVel] 1

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define TESSELLATION_ON 1
			#pragma require tessellation tessHW
			#pragma hull HullFunction
			#pragma domain DomainFunction
			#define ASE_DISTANCE_TESSELLATION
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 999999


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#if !defined(DEBUG_DISPLAY) && defined(_ALPHATEST_ON)
			#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
			#endif

			#define SHADERPASS SHADERPASS_FORWARD
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
			#pragma multi_compile SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif

			// CBuffer must be declared before Material.hlsl since it internaly uses _BlendMode now
			CBUFFER_START( UnityPerMaterial )
			float4 _SplatMap2_ST;
			float4 _AlbedoMaps_ST;
			float4 _Specular_Color_8;
			float4 _Specular_Color_6;
			float4 _Specular_Color_5;
			float4 _SplatMap1_ST;
			float4 _Specular_Color_4;
			float4 _Specular_Color_1;
			float4 _Specular_Color_3;
			float4 _Specular_Color_7;
			float4 _Specular_Color_2;
			float2 _UV_3;
			float2 _UV_1;
			float2 _UV_0;
			float2 _UV_6;
			float2 _UV_5;
			float2 _UV_4;
			float2 _UV_2;
			float2 _UV_7;
			float _Smoothness_4;
			float _Smoothness_2;
			float _Smoothness_3;
			float _Smoothness_5;
			float _Smoothness_6;
			float _Smoothness_1;
			float _Normal_Scale_8;
			float _Normal_Scale_3;
			float _Normal_Scale_6;
			float _Normal_Scale_5;
			float _Normal_Scale_4;
			float _Smoothness_7;
			float _Normal_Scale_2;
			float _Normal_Scale_1;
			float _Displacement_8;
			float _Displacement_7;
			float _Displacement_6;
			float _Displacement_5;
			float _Displacement_4;
			float _Displacement_3;
			float _Displacement_2;
			float _Displacement_1;
			float _Normal_Scale_7;
			float _Smoothness_8;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _SplatMap2;
			TEXTURE2D_ARRAY(_AlbedoMaps);
			SAMPLER(sampler_AlbedoMaps);
			sampler2D _SplatMap1;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
			#define HAS_LIGHTLOOP
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 interp03 : TEXCOORD3;
				float4 interp04 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			
			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs.tangentToWorld[2], surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float2 uv_SplatMap2 = inputMesh.ase_texcoord.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2Dlod( _SplatMap2, float4( uv_SplatMap2, 0, 0.0) );
				float2 uv_AlbedoMaps = inputMesh.ase_texcoord.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0, 0.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0, 0.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0, 0.0 );
				float4 weightedBlendVar197 = tex2DNode138;
				float weightedBlend197 = ( weightedBlendVar197.x*tex2DArrayNode171.a + weightedBlendVar197.y*tex2DArrayNode172.a + weightedBlendVar197.z*tex2DArrayNode173.a + weightedBlendVar197.w*0.0 );
				float2 uv_SplatMap1 = inputMesh.ase_texcoord.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2Dlod( _SplatMap1, float4( uv_SplatMap1, 0, 0.0) );
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0, 0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0, 0.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0, 0.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY_LOD( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0, 0.0 );
				float4 weightedBlendVar123 = tex2DNode9;
				float weightedBlend123 = ( weightedBlendVar123.x*tex2DArrayNode10.a + weightedBlendVar123.y*tex2DArrayNode11.a + weightedBlendVar123.z*tex2DArrayNode14.a + weightedBlendVar123.w*tex2DArrayNode17.a );
				float4 weightedBlendVar129 = tex2DNode9;
				float weightedBlend129 = ( weightedBlendVar129.x*_Displacement_1 + weightedBlendVar129.y*_Displacement_2 + weightedBlendVar129.z*_Displacement_3 + weightedBlendVar129.w*_Displacement_4 );
				float4 weightedBlendVar195 = tex2DNode138;
				float weightedBlend195 = ( weightedBlendVar195.x*_Displacement_5 + weightedBlendVar195.y*_Displacement_6 + weightedBlendVar195.z*_Displacement_7 + weightedBlendVar195.w*_Displacement_8 );
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ( ( weightedBlend197 + weightedBlend123 ) * ( weightedBlend129 + weightedBlend195 ) ) * inputMesh.normalOS );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.interp03.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.interp04.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = v.previousPositionOS;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = v.precomputedVelocity;
					#endif
				#endif
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
					#endif
				#endif
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag(PackedVaryingsMeshToPS packedInput,
					#ifdef OUTPUT_SPLIT_LIGHTING
						out float4 outColor : SV_Target0,
						out float4 outDiffuseLighting : SV_Target1,
						OUTPUT_SSSBUFFER(outSSSBuffer)
					#else
						out float4 outColor : SV_Target0
					#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						, out float4 outMotionVec : SV_Target1
					#endif
					#endif
					#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
					#endif
					
						)
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outMotionVec = float4(2.0, 0.0, 0.0, 0.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.interp03.xyzw;
				input.texCoord2 = packedInput.interp04.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				input.positionSS.xy = _OffScreenRendering > 0 ? (input.positionSS.xy * _OffScreenDownsampleFactor) : input.positionSS.xy;
				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_SplatMap1 = packedInput.ase_texcoord7.xy * _SplatMap1_ST.xy + _SplatMap1_ST.zw;
				float4 tex2DNode9 = tex2D( _SplatMap1, uv_SplatMap1 );
				float2 uv_AlbedoMaps = packedInput.ase_texcoord7.xy * _AlbedoMaps_ST.xy + _AlbedoMaps_ST.zw;
				float4 tex2DArrayNode10 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),0.0 );
				float4 tex2DArrayNode11 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),1.0 );
				float4 tex2DArrayNode14 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),2.0 );
				float4 tex2DArrayNode17 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),3.0 );
				float4 weightedBlendVar66 = tex2DNode9;
				float4 weightedBlend66 = ( weightedBlendVar66.x*tex2DArrayNode10 + weightedBlendVar66.y*tex2DArrayNode11 + weightedBlendVar66.z*tex2DArrayNode14 + weightedBlendVar66.w*tex2DArrayNode17 );
				float2 uv_SplatMap2 = packedInput.ase_texcoord7.xy * _SplatMap2_ST.xy + _SplatMap2_ST.zw;
				float4 tex2DNode138 = tex2D( _SplatMap2, uv_SplatMap2 );
				float4 tex2DArrayNode171 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),4.0 );
				float4 tex2DArrayNode172 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),5.0 );
				float4 tex2DArrayNode173 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),6.0 );
				float4 tex2DArrayNode174 = SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),7.0 );
				float4 weightedBlendVar179 = tex2DNode138;
				float4 weightedBlend179 = ( weightedBlendVar179.x*tex2DArrayNode171 + weightedBlendVar179.y*tex2DArrayNode172 + weightedBlendVar179.z*tex2DArrayNode173 + weightedBlendVar179.w*tex2DArrayNode174 );
				
				float3 unpack200 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_0 ),8.0 ), _Normal_Scale_1 );
				unpack200.z = lerp( 1, unpack200.z, saturate(_Normal_Scale_1) );
				float3 unpack94 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_1 ),9.0 ), _Normal_Scale_2 );
				unpack94.z = lerp( 1, unpack94.z, saturate(_Normal_Scale_2) );
				float3 unpack95 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_2 ),10.0 ), _Normal_Scale_3 );
				unpack95.z = lerp( 1, unpack95.z, saturate(_Normal_Scale_3) );
				float3 unpack96 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_3 ),11.0 ), _Normal_Scale_4 );
				unpack96.z = lerp( 1, unpack96.z, saturate(_Normal_Scale_4) );
				float4 weightedBlendVar97 = tex2DNode9;
				float3 weightedBlend97 = ( weightedBlendVar97.x*unpack200 + weightedBlendVar97.y*unpack94 + weightedBlendVar97.z*unpack95 + weightedBlendVar97.w*unpack96 );
				float3 unpack141 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_4 ),12.0 ), _Normal_Scale_5 );
				unpack141.z = lerp( 1, unpack141.z, saturate(_Normal_Scale_5) );
				float3 unpack144 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_5 ),13.0 ), _Normal_Scale_6 );
				unpack144.z = lerp( 1, unpack144.z, saturate(_Normal_Scale_6) );
				float3 unpack147 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_6 ),14.0 ), _Normal_Scale_7 );
				unpack147.z = lerp( 1, unpack147.z, saturate(_Normal_Scale_7) );
				float3 unpack150 = UnpackNormalScale( SAMPLE_TEXTURE2D_ARRAY( _AlbedoMaps, sampler_AlbedoMaps, ( uv_AlbedoMaps * _UV_7 ),14.0 ), _Normal_Scale_8 );
				unpack150.z = lerp( 1, unpack150.z, saturate(_Normal_Scale_8) );
				float4 weightedBlendVar159 = tex2DNode138;
				float3 weightedBlend159 = ( weightedBlendVar159.x*unpack141 + weightedBlendVar159.y*unpack144 + weightedBlendVar159.z*unpack147 + weightedBlendVar159.w*unpack150 );
				
				float4 weightedBlendVar90 = tex2DNode9;
				float4 weightedBlend90 = ( weightedBlendVar90.x*( _Specular_Color_1 * tex2DArrayNode10.g ) + weightedBlendVar90.y*( _Specular_Color_2 * tex2DArrayNode11.g ) + weightedBlendVar90.z*( _Specular_Color_3 * tex2DArrayNode14.g ) + weightedBlendVar90.w*( _Specular_Color_4 * tex2DArrayNode17.g ) );
				float4 weightedBlendVar189 = tex2DNode138;
				float4 weightedBlend189 = ( weightedBlendVar189.x*( _Specular_Color_5 * tex2DArrayNode171.g ) + weightedBlendVar189.y*( _Specular_Color_6 * tex2DArrayNode172.g ) + weightedBlendVar189.z*( _Specular_Color_7 * tex2DArrayNode173.g ) + weightedBlendVar189.w*( _Specular_Color_8 * tex2DArrayNode174.g ) );
				
				float4 weightedBlendVar75 = tex2DNode9;
				float weightedBlend75 = ( weightedBlendVar75.x*( _Smoothness_1 * tex2DArrayNode10.r ) + weightedBlendVar75.y*( _Smoothness_2 * tex2DArrayNode11.r ) + weightedBlendVar75.z*( _Smoothness_3 * tex2DArrayNode14.r ) + weightedBlendVar75.w*( _Smoothness_4 * tex2DArrayNode17.r ) );
				float4 weightedBlendVar161 = tex2DNode138;
				float weightedBlend161 = ( weightedBlendVar161.x*( _Smoothness_5 * tex2DArrayNode171.r ) + weightedBlendVar161.y*( _Smoothness_6 * tex2DArrayNode172.r ) + weightedBlendVar161.z*( _Smoothness_7 * tex2DArrayNode173.r ) + weightedBlendVar161.w*( _Smoothness_8 * tex2DArrayNode174.r ) );
				
				surfaceDescription.Albedo = ( weightedBlend66 + weightedBlend179 ).rgb;
				surfaceDescription.Normal = ( weightedBlend97 + weightedBlend159 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = ( weightedBlend90 + weightedBlend189 ).rgb;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = ( weightedBlend75 + weightedBlend161 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = 1;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef _ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);
				#ifdef DEBUG_DISPLAY
				#ifdef OUTPUT_SPLIT_LIGHTING
					outDiffuseLighting = 0;
					ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#endif

				bool viewMaterial = false;
				int bufferSize = int(_DebugViewMaterialArray[0].x);
				if (bufferSize != 0)
				{
					bool needLinearToSRGB = false;
					float3 result = float3(1.0, 0.0, 1.0);

					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = int(_DebugViewMaterialArray[index].x);

						if (indexMaterialProperty != 0)
						{
							viewMaterial = true;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, posInput, result, needLinearToSRGB);
							GetSurfaceDataDebug(indexMaterialProperty, surfaceData, result, needLinearToSRGB);
							GetBSDFDataDebug(indexMaterialProperty, bsdfData, result, needLinearToSRGB);
						}
					}

					if (!needLinearToSRGB)
						result = SRGBToLinear(max(0, result));

					outColor = float4(result, 1.0);
				}

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);

						GetPBRValidatorDebug(surfaceData, result);

						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
				#endif
					{
				#ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
				#else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
				#endif
					
						LightLoopOutput lightLoopOutput;
						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, lightLoopOutput);

						// Alias
						float3 diffuseLighting = lightLoopOutput.diffuseLighting;
						float3 specularLighting = lightLoopOutput.specularLighting;
					
						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

				#ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = 0;
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);
						outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
				#endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = float4(packedInput.vpassPositionCS.xy, 0.0, packedInput.vpassPositionCS.z);
						float4 VPASSpreviousPositionCS = float4(packedInput.vpassPreviousPositionCS.xy, 0.0, packedInput.vpassPreviousPositionCS.z);

						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
						if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
					}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}
			ENDHLSL
		}
		
	}
	CustomEditor "Rendering.HighDefinition.LightingShaderGraphGUI"
	
	
}
/*ASEBEGIN
Version=18900
0;0;800;539;-1574.152;901.6366;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;125;-2025.839,-1783.219;Inherit;False;1500.728;1727.471;Albedo;18;178;177;176;175;174;173;172;171;47;46;32;33;17;14;11;10;3;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-2005.124,-1726.299;Float;True;Property;_AlbedoMaps;AlbedoMaps;2;0;Create;True;0;0;0;False;0;False;None;None;False;white;LockedToTexture2DArray;Texture2DArray;-1;0;2;SAMPLER2DARRAY;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;201;-6410.695,-2848.947;Float;False;Property;_UV_2;UV_2;19;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;203;-6410.696,-3004.833;Float;False;Property;_UV_1;UV_1;16;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;204;-6419.062,-3148.868;Float;False;Property;_UV_0;UV_0;13;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;202;-6410.694,-2700.985;Float;False;Property;_UV_3;UV_3;22;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;205;-6396.759,-2253.799;Float;False;Property;_UV_6;UV_6;18;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;207;-6396.76,-2409.686;Float;False;Property;_UV_5;UV_5;15;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;208;-6405.126,-2553.721;Float;False;Property;_UV_4;UV_4;12;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1836.68,-1016.791;Inherit;False;0;3;2;3;2;SAMPLER2DARRAY;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-1246.81,-712.723;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-1255.706,-484.6324;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1272.265,-1317.37;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1279.017,-1123.781;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1290.239,-1666.571;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;130;478.0417,656.0351;Inherit;False;1271.142;776.9246;Displacement;13;195;194;193;192;191;129;126;128;114;127;112;115;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;206;-6396.758,-2105.838;Float;False;Property;_UV_7;UV_7;20;0;Create;True;0;0;0;False;0;False;30,30;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-1294.196,-915.4965;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1275.999,-1518.258;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;135;-3864.35,-4702.2;Inherit;False;1820.084;1642.141;Comment;24;147;146;145;144;143;142;141;140;139;96;133;109;95;94;107;131;108;132;110;106;148;149;150;200;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;14;-960.2587,-1326.269;Inherit;True;Property;_TextureArray2;Texture Array 2;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;2;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-981.0203,-1759.673;Inherit;True;Property;_AlbedoArray;AlbedoArray;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;192;543.0546,1057.773;Float;False;Property;_Displacement_5;Displacement_5;39;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;535.4833,881.0829;Float;False;Property;_Displacement_3;Displacement_3;37;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;136;-1867.461,-2979.216;Inherit;False;1068.033;924.5947;Comment;18;169;168;167;166;165;164;163;162;161;76;77;78;71;74;72;73;75;79;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;126;538.4833,794.0829;Float;False;Property;_Displacement_2;Displacement_2;36;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;124;-3728.566,326.5414;Inherit;False;889.2822;1491.483;Specular;18;189;188;187;186;185;184;183;182;181;90;88;86;87;89;82;83;81;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;17;-961.4342,-1120.175;Inherit;True;Property;_TextureArray3;Texture Array 3;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;3;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;138;-5893.803,-477.8911;Inherit;True;Property;_SplatMap2;SplatMap2;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-5900.493,-692.1379;Inherit;True;Property;_SplatMap1;SplatMap1;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;191;537.1483,1231.367;Float;False;Property;_Displacement_7;Displacement_7;41;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;541.3897,707.4896;Float;False;Property;_Displacement_1;Displacement_1;35;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;535.4833,969.0829;Float;False;Property;_Displacement_4;Displacement_4;38;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-1246.285,-274.941;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;194;540.1483,1144.367;Float;False;Property;_Displacement_6;Displacement_6;40;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;538.1483,1319.367;Float;False;Property;_Displacement_8;Displacement_8;42;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;173;-952.5554,-509.6272;Inherit;True;Property;_TextureArray12;Texture Array 12;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;6;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-971.4817,-1543.736;Inherit;True;Property;_TextureArray1;Texture Array 1;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;1;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;171;-955.6483,-895.368;Inherit;True;Property;_TextureArray10;Texture Array 10;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;4;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;172;-945.9139,-711.8343;Inherit;True;Property;_TextureArray11;Texture Array 11;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;5;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SummedBlendNode;123;-88.0489,-668.4572;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-1797.169,-2180.024;Float;False;Property;_Smoothness_8;Smoothness_8;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;-3678.567,718.4485;Float;False;Property;_Specular_Color_3;Specular_Color_3;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;80;-3676.735,384.4427;Float;False;Property;_Specular_Color_1;Specular_Color_1;11;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;-1810.119,-2626.099;Float;False;Property;_Smoothness_4;Smoothness_4;6;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-3012.744,-3660.013;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;165;-1804.511,-2473.179;Float;False;Property;_Smoothness_5;Smoothness_5;7;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;183;-3661.585,1606.291;Float;False;Property;_Specular_Color_8;Specular_Color_8;26;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;174;-951.7917,-286.4938;Inherit;True;Property;_TextureArray13;Texture Array 13;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;7;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SummedBlendNode;195;906.2344,1081.32;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;182;-3665.243,1283.632;Float;False;Property;_Specular_Color_6;Specular_Color_6;24;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;184;-3664.585,1445.289;Float;False;Property;_Specular_Color_7;Specular_Color_7;25;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;-1830.119,-2729.098;Float;False;Property;_Smoothness_3;Smoothness_3;5;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;181;-3662.67,1113.327;Float;False;Property;_Specular_Color_5;Specular_Color_5;23;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;81;-3677.567,558.4481;Float;False;Property;_Specular_Color_2;Specular_Color_2;14;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SummedBlendNode;197;-76.87102,-381.3903;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;139;-3009.528,-3847.268;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-3005.901,-4621.729;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-3016.773,-3256.126;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-3007.839,-4429.345;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-1797.169,-2379.025;Float;False;Property;_Smoothness_6;Smoothness_6;8;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-3675.567,879.4498;Float;False;Property;_Specular_Color_4;Specular_Color_4;21;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;110;-2750.775,-4537.538;Float;False;Property;_Normal_Scale_1;Normal_Scale_1;27;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-1797.169,-2275.024;Float;False;Property;_Smoothness_7;Smoothness_7;9;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1817.461,-2919.253;Float;False;Property;_Smoothness_1;Smoothness_1;3;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;129;911.4785,852.512;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-3015.936,-3466.367;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-2745.229,-3574.727;Float;False;Property;_Normal_Scale_6;Normal_Scale_6;32;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-3013.984,-4045.315;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-2749.653,-3187.835;Float;False;Property;_Normal_Scale_8;Normal_Scale_8;34;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;-2744.24,-3769.399;Float;False;Property;_Normal_Scale_5;Normal_Scale_5;31;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;-2747.749,-4347.972;Float;False;Property;_Normal_Scale_2;Normal_Scale_2;28;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-2752.52,-3389.847;Float;False;Property;_Normal_Scale_7;Normal_Scale_7;33;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-1810.119,-2825.099;Float;False;Property;_Smoothness_2;Smoothness_2;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-2751.162,-3969.981;Float;False;Property;_Normal_Scale_4;Normal_Scale_4;30;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-3011.54,-4236.562;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-2743.087,-4156.866;Float;False;Property;_Normal_Scale_3;Normal_Scale_3;29;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;94;-2387.316,-4458.061;Inherit;True;Property;_TextureArray0;Texture Array 0;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;9;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;167;-1399.362,-2287.621;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-3327.871,418.7313;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;141;-2396.909,-3877.723;Inherit;True;Property;_TextureArray6;Texture Array 6;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;12;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;95;-2385.346,-4263.377;Inherit;True;Property;_TextureArray4;Texture Array 4;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;10;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-1412.312,-2733.695;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-3316.429,727.5101;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;198;242.1236,-544.5306;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;200;-2387.033,-4657.596;Inherit;True;Property;_NormallArray;NormallArray;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;8;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-1395.462,-2185.241;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;144;-2401.606,-3687.552;Inherit;True;Property;_TextureArray7;Texture Array 7;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;13;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-3326.736,1617.809;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;150;-2404.486,-3293.189;Inherit;True;Property;_TextureArray9;Texture Array 9;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;14;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;-3319.373,1107.393;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-3327.296,564.8068;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-3319.095,883.6687;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1419.313,-2929.216;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;147;-2403.952,-3495.037;Inherit;True;Property;_TextureArray8;Texture Array 8;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;14;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-3312.796,1293.454;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;96;-2389.242,-4075.758;Inherit;True;Property;_TextureArray5;Texture Array 5;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;10;Auto;Texture2DArray;8;0;SAMPLER2DARRAY;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;11;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-3320.02,1448.033;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1419.313,-2829.074;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1412.183,-2603.296;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;196;1111.285,969.7888;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-1405.044,-2487.096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-1406.362,-2383.001;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;189;-3057.549,1308.791;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;90;-3053.426,643.9554;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;115;1344.534,977.7064;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;1329.35,708.1938;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;66;-138.0398,-1255.402;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;179;-128.6516,-944.6517;Inherit;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;75;-1007.892,-2826.422;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;161;-1008.632,-2399.23;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;97;-1217.887,-4309.968;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;159;-1193.016,-3786.394;Inherit;False;5;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-668.9998,-2542.664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;160;-189.9032,-3942.589;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;190;-387.7433,731.7554;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;142.0839,-1034.604;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;1580.184,766.9326;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;213;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;DepthOnly;0;4;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;False;False;False;False;False;True;True;0;True;-6;255;False;-1;255;True;-7;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;216;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentBackface;0;7;TransparentBackface;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;True;1;0;True;-19;0;True;-20;1;0;True;-21;0;True;-22;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;False;True;True;True;True;True;0;True;-44;False;False;False;False;False;False;False;True;0;True;-23;True;0;True;-31;False;True;1;LightMode=TransparentBackface;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;215;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Distortion;0;6;Distortion;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;True;4;1;False;-1;1;False;-1;4;1;False;-1;1;False;-1;True;1;False;-1;1;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;-10;255;False;-1;255;True;-11;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;3;False;-1;False;True;1;LightMode=DistortionVectors;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;214;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Motion Vectors;0;5;Motion Vectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;False;False;False;False;False;True;True;0;True;-8;255;False;-1;255;True;-9;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=MotionVectors;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;218;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPostpass;0;9;TransparentDepthPostpass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=TransparentDepthPostpass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;212;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;211;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;210;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;META;0;1;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;209;1995.239,-749.6547;Float;False;True;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;2;LightingBox/Terrain/Terrain 8-Layers;53b46d85872c5b24c8f4f0a1c3fe4c87;True;GBuffer;0;0;GBuffer;35;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;False;False;False;False;False;True;True;0;True;-13;255;False;-1;255;True;-12;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;True;0;True;-14;False;True;1;LightMode=GBuffer;False;0;;0;0;Standard;42;Surface Type;0;  Rendering Pass;1;  Refraction Model;0;    Blending Mode;0;    Blend Preserves Specular;1;  Receive Fog;1;  Back Then Front Rendering;0;  Transparent Depth Prepass;0;  Transparent Depth Postpass;0;  Transparent Writes Motion Vector;0;  Distortion;0;    Distortion Mode;0;    Distortion Depth Test;1;  ZWrite;0;  Z Test;4;Double-Sided;0;Alpha Clipping;0;  Use Shadow Threshold;0;Material Type,InvertActionOnDeselection;4;  Energy Conserving Specular;1;  Transmission;1;Receive Decals;1;Receives SSR;1;Receive SSR Transparent;0;Motion Vectors;1;  Add Precomputed Velocity;0;Specular AA;0;Specular Occlusion Mode;1;Override Baked GI;0;Depth Offset;0;DOTS Instancing;0;LOD CrossFade;0;Tessellation;1;  Phong;0;  Strength;0.5,False,-1;  Type;1;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position;1;0;11;True;True;True;True;True;True;False;False;False;False;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;217;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPrepass;0;8;TransparentDepthPrepass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;False;False;False;False;False;True;True;0;False;-1;255;False;-1;255;False;-1;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;3;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=TransparentDepthPrepass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;219;1995.239,-749.6547;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Forward;0;10;Forward;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;True;1;0;True;-19;0;True;-20;1;0;True;-21;0;True;-22;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-28;False;False;False;True;True;True;True;True;0;True;-44;False;False;False;False;False;True;True;0;True;-4;255;False;-1;255;True;-5;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;0;True;-23;True;0;True;-30;False;True;1;LightMode=Forward;False;0;;0;0;Standard;0;False;0
WireConnection;6;2;3;0
WireConnection;175;0;6;0
WireConnection;175;1;207;0
WireConnection;177;0;6;0
WireConnection;177;1;205;0
WireConnection;46;0;6;0
WireConnection;46;1;201;0
WireConnection;47;0;6;0
WireConnection;47;1;202;0
WireConnection;32;0;6;0
WireConnection;32;1;204;0
WireConnection;176;0;6;0
WireConnection;176;1;208;0
WireConnection;33;0;6;0
WireConnection;33;1;203;0
WireConnection;14;1;46;0
WireConnection;10;0;3;0
WireConnection;10;1;32;0
WireConnection;17;1;47;0
WireConnection;178;0;6;0
WireConnection;178;1;206;0
WireConnection;173;1;177;0
WireConnection;11;1;33;0
WireConnection;171;1;176;0
WireConnection;172;1;175;0
WireConnection;123;0;9;0
WireConnection;123;1;10;4
WireConnection;123;2;11;4
WireConnection;123;3;14;4
WireConnection;123;4;17;4
WireConnection;142;0;6;0
WireConnection;142;1;207;0
WireConnection;174;1;178;0
WireConnection;195;0;138;0
WireConnection;195;1;192;0
WireConnection;195;2;194;0
WireConnection;195;3;191;0
WireConnection;195;4;193;0
WireConnection;197;0;138;0
WireConnection;197;1;171;4
WireConnection;197;2;172;4
WireConnection;197;3;173;4
WireConnection;139;0;6;0
WireConnection;139;1;208;0
WireConnection;106;0;6;0
WireConnection;106;1;204;0
WireConnection;148;0;6;0
WireConnection;148;1;206;0
WireConnection;107;0;6;0
WireConnection;107;1;203;0
WireConnection;129;0;9;0
WireConnection;129;1;114;0
WireConnection;129;2;126;0
WireConnection;129;3;127;0
WireConnection;129;4;128;0
WireConnection;145;0;6;0
WireConnection;145;1;205;0
WireConnection;109;0;6;0
WireConnection;109;1;202;0
WireConnection;108;0;6;0
WireConnection;108;1;201;0
WireConnection;94;1;107;0
WireConnection;94;5;131;0
WireConnection;167;0;162;0
WireConnection;167;1;173;1
WireConnection;86;0;80;0
WireConnection;86;1;10;2
WireConnection;141;1;139;0
WireConnection;141;5;140;0
WireConnection;95;1;108;0
WireConnection;95;5;132;0
WireConnection;78;0;73;0
WireConnection;78;1;14;1
WireConnection;88;0;82;0
WireConnection;88;1;14;2
WireConnection;198;0;197;0
WireConnection;198;1;123;0
WireConnection;200;1;106;0
WireConnection;200;5;110;0
WireConnection;166;0;164;0
WireConnection;166;1;174;1
WireConnection;144;1;142;0
WireConnection;144;5;143;0
WireConnection;185;0;183;0
WireConnection;185;1;174;2
WireConnection;150;1;148;0
WireConnection;150;5;149;0
WireConnection;187;0;181;0
WireConnection;187;1;171;2
WireConnection;87;0;81;0
WireConnection;87;1;11;2
WireConnection;89;0;83;0
WireConnection;89;1;17;2
WireConnection;76;0;71;0
WireConnection;76;1;10;1
WireConnection;147;1;145;0
WireConnection;147;5;146;0
WireConnection;186;0;182;0
WireConnection;186;1;172;2
WireConnection;96;1;109;0
WireConnection;96;5;133;0
WireConnection;188;0;184;0
WireConnection;188;1;173;2
WireConnection;77;0;72;0
WireConnection;77;1;11;1
WireConnection;79;0;74;0
WireConnection;79;1;17;1
WireConnection;196;0;129;0
WireConnection;196;1;195;0
WireConnection;169;0;165;0
WireConnection;169;1;171;1
WireConnection;168;0;163;0
WireConnection;168;1;172;1
WireConnection;189;0;138;0
WireConnection;189;1;187;0
WireConnection;189;2;186;0
WireConnection;189;3;188;0
WireConnection;189;4;185;0
WireConnection;90;0;9;0
WireConnection;90;1;86;0
WireConnection;90;2;87;0
WireConnection;90;3;88;0
WireConnection;90;4;89;0
WireConnection;113;0;198;0
WireConnection;113;1;196;0
WireConnection;66;0;9;0
WireConnection;66;1;10;0
WireConnection;66;2;11;0
WireConnection;66;3;14;0
WireConnection;66;4;17;0
WireConnection;179;0;138;0
WireConnection;179;1;171;0
WireConnection;179;2;172;0
WireConnection;179;3;173;0
WireConnection;179;4;174;0
WireConnection;75;0;9;0
WireConnection;75;1;76;0
WireConnection;75;2;77;0
WireConnection;75;3;78;0
WireConnection;75;4;79;0
WireConnection;161;0;138;0
WireConnection;161;1;169;0
WireConnection;161;2;168;0
WireConnection;161;3;167;0
WireConnection;161;4;166;0
WireConnection;97;0;9;0
WireConnection;97;1;200;0
WireConnection;97;2;94;0
WireConnection;97;3;95;0
WireConnection;97;4;96;0
WireConnection;159;0;138;0
WireConnection;159;1;141;0
WireConnection;159;2;144;0
WireConnection;159;3;147;0
WireConnection;159;4;150;0
WireConnection;170;0;75;0
WireConnection;170;1;161;0
WireConnection;160;0;97;0
WireConnection;160;1;159;0
WireConnection;190;0;90;0
WireConnection;190;1;189;0
WireConnection;180;0;66;0
WireConnection;180;1;179;0
WireConnection;112;0;113;0
WireConnection;112;1;115;0
WireConnection;209;0;180;0
WireConnection;209;1;160;0
WireConnection;209;5;190;0
WireConnection;209;7;170;0
WireConnection;209;11;112;0
ASEEND*/
//CHKSM=255D6225ABD08DFFD3514C4963E73443CEB023E5