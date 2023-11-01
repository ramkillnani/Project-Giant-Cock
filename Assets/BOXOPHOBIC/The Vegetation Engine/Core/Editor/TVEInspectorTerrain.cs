//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using System.IO;
using System.Collections.Generic;

namespace TheVegetationEngine
{
    [DisallowMultipleComponent]
    [CustomEditor(typeof(TVETerrain))]
    public class TVEInspectorTerrain : Editor
    {
        string[] excludeProps = {"m_Script"};
        TVETerrain targetScript;

        void OnEnable()
        {
            targetScript = (TVETerrain)target;
        }

        public override void OnInspectorGUI()
        {
            EditorGUI.BeginChangeCheck();

            DrawInspector();

            if (EditorGUI.EndChangeCheck())
            {
                targetScript.isInitialized = false;
            }

            if (targetScript.usesCustomShader)
            {
                GUILayout.Space(10);
                EditorGUILayout.HelpBox("When a custom shaders is used, the terrain will only use features enabled in the shader.", MessageType.Info);
                GUILayout.Space(5);

                return;
            }

            var terrain = targetScript.gameObject.GetComponent<Terrain>();
            var terrainMaterial = terrain.materialTemplate;
            var shaderTemplate = targetScript.terrainShaderTemplate;

            //var terrainMaterial = targetScript.terrainMaterial;
            //var terrainShader = targetScript.terrainShader;

            var terrainDataPath = AssetDatabase.GetAssetPath(terrain.terrainData).Replace(".asset", "");
            var terrainDataName = terrain.terrainData.name;

            var newShaderPath = terrainDataPath + ".shader";
            var newMaterialPath = terrainDataPath + ".mat";

            var button = "Convert Terrain Shader";


            if (terrainMaterial == null)
            {
                GUILayout.Space(10);
                EditorGUILayout.HelpBox("The terrain material is not assigned! Convert the terrain to create a new shader with up to 16 layers and holes support.", MessageType.Error);
            }

            if (terrainMaterial != null)
            {
                if (terrainMaterial.shader.name.Contains("The Vegetation Engine"))
                {
                    if (!File.Exists(newShaderPath) || !File.Exists(newShaderPath))
                    {
                        GUILayout.Space(10);
                        EditorGUILayout.HelpBox("The terrain is using a default terrain shader! Create a new terrain shader to chnage the settings.", MessageType.Info);

                        targetScript.isInitialized = false;

                        button = "Create Terrain Shader";
                    }
                    else
                    {
                        if (!targetScript.isInitialized)
                        {
                            GUILayout.Space(10);
                            EditorGUILayout.HelpBox("The terrain settings have been modified! Update the terrain shaders to enable the features.", MessageType.Warning);
                        }

                        button = "Update Terrain Shader";
                    }
                }
                else
                {
                    GUILayout.Space(10);
                    EditorGUILayout.HelpBox("The terrain material is not using a Vegetation Engine shader! Convert the terrain enable all the supported Vegetation Engine features.", MessageType.Error);
                }
            }

            GUILayout.Space(10);

            if (GUILayout.Button(button))
            {
                // Create new Shaader
                var oldShaderPath = AssetDatabase.GetAssetPath(shaderTemplate);

                if (!File.Exists(newShaderPath))
                {
                    AssetDatabase.CopyAsset(oldShaderPath, newShaderPath);
                    AssetDatabase.Refresh();
                }

                //Inject shader features
                StreamReader reader = new StreamReader(oldShaderPath);

                List<string> lines = new List<string>();

                while (!reader.EndOfStream)
                {
                    lines.Add(reader.ReadLine());
                }

                reader.Close();

                int count = lines.Count;

                for (int i = 0; i < count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        int c = 0;
                        int j = i + 1;

                        while (lines[j].Contains("SHADER INJECTION POINT END") == false)
                        {
                            j++;
                            c++;
                        }

                        lines.RemoveRange(i + 1, c);
                        count = count - c;
                    }

                    if (lines[i].Contains("ASEBEGIN"))
                    {
                        int c = 0;
                        int j = i;

                        while (lines[j].Contains("CHKSM") == false)
                        {
                            j++;
                            c++;
                        }

                        lines.RemoveRange(i, c);
                        count = count - c;
                    }
                }

                lines.RemoveAt(count - 1);

                count = lines.Count;

                for (int i = 0; i < count; i++)
                {
                    if (lines[i].StartsWith("Shader"))
                    {
                        lines[i] ="Shader \"Hidden/BOXOPHOBIC/The Vegetation Engine Runtime/Landscape/" + terrainDataName + "\"";
                    }

                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        var offset = 1;

                        if (targetScript.terrainLayers == TVETerrainLayersMode._4Layers)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_LAYERS_04");
                            offset += 1;
                        }

                        if (targetScript.terrainLayers == TVETerrainLayersMode._8Layers)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_LAYERS_08");
                            offset += 1;
                        }

                        if (targetScript.terrainLayers == TVETerrainLayersMode._12Layers)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_LAYERS_12");
                            offset += 1;
                        }

                        if (targetScript.terrainLayers == TVETerrainLayersMode._16Layers)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_LAYERS_16");
                            offset += 1;
                        }

                        if (targetScript.terrainMaps == TVETerrainMapsMode.Packed)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_LAYERS_16");
                            offset += 1;
                        }

                        if (targetScript.terrainHoles == TVEBoolMode.On)
                        {
                            lines.Insert(i + offset, "          #define TVE_FEATURE_CLIP");
                        }
                    }
                }

                StreamWriter writer = new StreamWriter(newShaderPath, false);

                for (int i = 0; i < lines.Count; i++)
                {
                    writer.WriteLine(lines[i]);
                }

                writer.Close();

                lines = new List<string>();

                AssetDatabase.ImportAsset(newShaderPath);

                // Create new material
                var newTerrainMaterial = new Material(terrain.materialTemplate);
                newTerrainMaterial.name = terrainDataName;
                newTerrainMaterial.shader = AssetDatabase.LoadAssetAtPath<Shader>(newShaderPath);

                if (File.Exists(newMaterialPath))
                {
                    AssetDatabase.DeleteAsset(newMaterialPath);
                    AssetDatabase.Refresh();
                }

                AssetDatabase.CreateAsset(newTerrainMaterial, newMaterialPath);

                terrain.materialTemplate = AssetDatabase.LoadAssetAtPath<Material>(newMaterialPath);

                if (Application.isPlaying == false)
                {
                    EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
                }

                AssetDatabase.Refresh();

                targetScript.isInitialized = true;
            }

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }
    }
}


