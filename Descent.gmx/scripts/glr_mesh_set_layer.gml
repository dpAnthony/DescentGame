///glr_mesh_set_layer(mesh id, layer)

/*
    <=============== DESCRIPTION ===============>
        Sets the mesh layer.
        if the mesh layer is greater then a 
        light layer, this mesh will not cast
        shadows from that light
    <===============  ARGUMENTS  ===============>
        mesh: the mesh id
        layer: floating point number (also negative)
    <===========================================>
*/

argument0[| GLR_MESH.layer] = argument1;