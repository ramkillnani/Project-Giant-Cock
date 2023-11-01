// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using System.Collections.Generic;

namespace TheVegetationEngine
{
#if UNITY_EDITOR
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q4fstlrr3cw4")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Terrain")]
#endif
    public class TVETerrain : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Terrain")]
        public bool styledBanner;

        [Tooltip("Sets the maximum supported terrain layers.")]
        public TVETerrainLayersMode terrainLayers = TVETerrainLayersMode._4Layers;
        [Tooltip("Sets the layer maps packing mode.")]
        public TVETerrainMapsMode terrainMaps = TVETerrainMapsMode.Default;
        [Tooltip("Sets the terrain holes support.")]
        public TVEBoolMode terrainHoles = TVEBoolMode.Off;

        [Space(10)]
        [Tooltip("Override the terrain control maps without modifying the actual terrain maps.")]
        public List<TVETerrainSplatData> terrainSplatOverrides = new List<TVETerrainSplatData>();
        [Tooltip("Override the terrain layer maps and settings without modifying the actual terrain layer.")]
        public List<TVETerrainLayerData> terrainLayerOverrides = new List<TVETerrainLayerData>();
        [Tooltip("Sets the terrain bounds multiplier used to avoid patches culling when using vertex offset elements.")]
        public float terrainBoundsMultiplier = 1;
        [Tooltip("Shader template used to generate new terrain shaders when the options are changed.")]
        public Shader terrainShaderTemplate;

        [Space(10)]
        [Tooltip("Sync the terrain data in editor if the terrain is modified by external tools.")]
        public bool syncTerrainData = false;
        [Tooltip("Hide the shader creation and update button.")]
        public bool usesCustomShader = false;

        [HideInInspector]
        public bool isInitialized = false;

        Terrain terrain;
        MaterialPropertyBlock materialPropertyBlock;

        Texture2D whiteTex;
        Texture2D normalTex;

        [StyledSpace(5)]
        public bool styledSpace1;

        void OnEnable()
        {
            InitializeTerrain();
        }

        void Start()
        {
            UpdateTerrainParameters();
        }

#if UNITY_EDITOR
        void Update()
        {
            if (!Application.isPlaying)
            {
                if (Selection.Contains(gameObject) || syncTerrainData)
                {
                    UpdateTerrainParameters();
                }
            }
        }
#endif

        void InitializeTerrain()
        {
            terrain = GetComponent<Terrain>();

            if (terrainShaderTemplate == null)
            {
                terrainShaderTemplate = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Landscape/Terrain Standard Lit");
            }

            if (terrain.materialTemplate != null)
            {
                if (terrain.materialTemplate.shader.name.Contains("Error"))
                {
                    terrain.materialTemplate.shader = terrainShaderTemplate;
                }
            }

            whiteTex = Resources.Load<Texture2D>("Internal WhiteTex");
            normalTex = Resources.Load<Texture2D>("Internal NormalTex");
        }

        public void UpdateTerrainParameters()
        {
            if (terrain == null || terrain.terrainData == null)
            {
                return;
            }

            if (materialPropertyBlock == null)
            {
                materialPropertyBlock = new MaterialPropertyBlock();
            }

            var holesTexture = terrain.terrainData.holesTexture;

            if (holesTexture != null)
            {
                materialPropertyBlock.SetTexture("_HolesTex", holesTexture);
            }

            for (int i = 0; i < terrain.terrainData.alphamapTextures.Length; i++)
            {
                var splat = terrain.terrainData.alphamapTextures[i];
                var id = i + 1;

                if (splat != null)
                {
                    materialPropertyBlock.SetTexture("_ControlTex" + id, splat);
                }
            }

            for (int i = 0; i < terrain.terrainData.terrainLayers.Length; i++)
            {
                var layer = terrain.terrainData.terrainLayers[i];
                var id = i + 1;

                if (layer == null)
                {
                    continue;
                }

                if (layer.diffuseTexture != null)
                {
                    materialPropertyBlock.SetTexture("_AlbedoTex" + id, layer.diffuseTexture);
                }
                else
                {
                    materialPropertyBlock.SetTexture("_AlbedoTex" + id, whiteTex);
                }

                if (layer.normalMapTexture != null)
                {
                    materialPropertyBlock.SetTexture("_NormalTex" + id, layer.normalMapTexture);
                }
                else
                {
                    materialPropertyBlock.SetTexture("_NormalTex" + id, normalTex);
                }

                if (layer.maskMapTexture != null)
                {
                    materialPropertyBlock.SetTexture("_MaskTex" + id, layer.maskMapTexture);
                }
                else
                {
                    materialPropertyBlock.SetTexture("_MaskTex" + id, whiteTex);
                }

                materialPropertyBlock.SetVector("_MaskMin" + id, layer.maskMapRemapMin);
                materialPropertyBlock.SetVector("_MaskMax" + id, layer.maskMapRemapMax);
                materialPropertyBlock.SetVector("_SpecularColor" + id, layer.specular);
                materialPropertyBlock.SetFloat("_NormalValue" + id, layer.normalScale);
                materialPropertyBlock.SetFloat("_MetallicValue" + id, layer.metallic);
                materialPropertyBlock.SetFloat("_SmoothnessValue" + id, layer.smoothness);

                materialPropertyBlock.SetVector("_Coords" + id, new Vector4(1 / layer.tileSize.x, 1 / layer.tileSize.y, layer.tileOffset.x, layer.tileOffset.y));
            }

            // Terrain Control Overrides
            for (int i = 0; i < terrainSplatOverrides.Count; i++)
            {
                var splat = terrainSplatOverrides[i];

                if (!splat.isInitialized)
                {
                    terrainSplatOverrides[i] = new TVETerrainSplatData();
                    terrainSplatOverrides[i].isInitialized = true;
                }

                var id = splat.controlID;

                if (splat.overrideControl)
                {
                    if (splat.controlTexture != null)
                    {
                        materialPropertyBlock.SetTexture("_ControlTex" + id, splat.controlTexture);
                    }
                }
            }

            // Terrain Layer Overrides
            for (int i = 0; i < terrainLayerOverrides.Count; i++)
            {
                var layer = terrainLayerOverrides[i];

                if (!layer.isInitialized)
                {
                    terrainLayerOverrides[i] = new TVETerrainLayerData();
                    terrainLayerOverrides[i].isInitialized = true;
                }

                var id = layer.layerID;

                if (layer.overrideTextures)
                {
                    if (layer.albedoTexture != null)
                    {
                        materialPropertyBlock.SetTexture("_AlbedoTex" + id, layer.albedoTexture);
                    }

                    if (layer.normalTexture != null)
                    {
                        materialPropertyBlock.SetTexture("_NormalTex" + id, layer.normalTexture);
                    }

                    if (layer.maskTexture != null)
                    {
                        materialPropertyBlock.SetTexture("_MaskTex" + id, layer.maskTexture);
                    }
                }

                if (layer.overrideSettings)
                {
                    materialPropertyBlock.SetVector("_MaskMin" + id, layer.maskRemapMin);
                    materialPropertyBlock.SetVector("_MaskMax" + id, layer.maskRemapMax);
                    materialPropertyBlock.SetVector("_SpecularColor" + id, layer.specular);
                    materialPropertyBlock.SetFloat("_NormalValue" + id, layer.normal);
                    materialPropertyBlock.SetFloat("_MetallicValue" + id, layer.metallic);
                    materialPropertyBlock.SetFloat("_SmoothnessValue" + id, layer.smoothness);

                    materialPropertyBlock.SetVector("_Coords" + id, new Vector4(1 / layer.textureCoords.x, 1 / layer.textureCoords.y, layer.textureCoords.x, layer.textureCoords.y));
                }
            }

            // Terrain Transform
            materialPropertyBlock.SetVector("_TerrainPosition", terrain.transform.position);
            materialPropertyBlock.SetVector("_TerrainSize", terrain.terrainData.size);

            terrain.SetSplatMaterialPropertyBlock(materialPropertyBlock);

            terrain.patchBoundsMultiplier = new Vector3(terrainBoundsMultiplier, terrainBoundsMultiplier, terrainBoundsMultiplier);
        }

#if UNITY_EDITOR
        void OnValidate()
        {
            InitializeTerrain();
        }
#endif
    }
}


