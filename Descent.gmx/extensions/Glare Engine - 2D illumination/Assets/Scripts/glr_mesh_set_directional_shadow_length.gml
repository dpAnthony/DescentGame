///glr_mesh_set_directional_shadow_length(mesh, shadow_length);

/*
    <=============== DESCRIPTION ===============>
        Sets the directional shadow length for
        this mesh
    
    <===============  ARGUMENTS  ===============>
        mesh: the mesh id
        shadow_length: the shadow length
    <===========================================>
    You can directly use
    my_mesh[| GLR_MESH.shadow_length_directional] = value;
*/
var mesh = argument0;
mesh[| GLR_MESH.shadow_length_directional] = argument1;