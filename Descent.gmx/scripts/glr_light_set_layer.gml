///glr_light_set_layer(light, layer)

/*
    <=============== DESCRIPTION ===============>
        Set the light layer.
        
        if you have a mesh with a layer value
        Greater then the light layer
        This mesh will not cast shadows
        for this light
        
        Useful when you have a torch light
        in your player and you don't want
        that this torch casts the shadows
        of your player

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        layer: the layer (numeric, also negative)
        
    <===============  EXAMPLE  ===============>
        glr_light_set_layer(-1.6);
    <===========================================>
*/

argument0[| GLR_LIGHT.layer] = argument1;