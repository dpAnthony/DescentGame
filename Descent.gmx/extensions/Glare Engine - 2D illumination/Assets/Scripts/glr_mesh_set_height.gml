///glr_mesh_set_height(mesh id, height)

/*
    <=============== DESCRIPTION ===============>
        Sets the depth for directional lights
    <===============  ARGUMENTS  ===============>
        mesh: the mesh id
        height: the directional height of this mesh
    <===========================================>
*/


argument0[| GLR_MESH.height] = argument1;

global.GLR_DIRECTIONAL_UPDATED = false;