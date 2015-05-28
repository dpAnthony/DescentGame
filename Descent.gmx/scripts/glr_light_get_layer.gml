///glr_light_get_layer(light id)

/*
    <=============== DESCRIPTION ===============>
        returns the light layer

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        layer = glr_light_get_layer(light);
    <===========================================>
*/
return argument0[| GLR_LIGHT.layer];