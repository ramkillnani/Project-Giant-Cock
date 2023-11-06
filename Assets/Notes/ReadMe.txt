

Make sure to purchase this package before any release of this project and update the shader to support URP (I chaged the 6-Layer shader to support URP. Use Amplify shader editor to edit them): https://assetstore.unity.com/packages/vfx/shaders/hdrp-terrain-tessellation-shader-191250

To create the tessellation, we need to make sure that we add an alpha channel on the main texture, paste the texture's normal map and greyscale it.

When adding this project from GitHub, the terrain may not be displayed correctly. To fix, click the terrain copy and reset "LB_Terrain_2", set layers to Layer_6 (only layer6 works for URP) and then press the init button. Tessellation values will need to be re-set

If Tessellation is being spastic (such as the tessellation being spread out way too much), make sure there are bumps or hills in the terrain to force the tessellation quality.