///glr_mesh_set_depth_mask(mesh id, sprite, subimage)

/*
    <=============== DESCRIPTION ===============>
        Sets a sprite as mask replacing the 
        default mesh mask
    <===============  ARGUMENTS  ===============>
        mesh: the mesh id
        sprite: the sprite index
        subimage: the sprite frame
    <===========================================>
*/

var mesh = argument0;
mesh[| GLR_MESH.depth_mask] = argument1;
mesh[| GLR_MESH.depth_mask_index] = argument2;