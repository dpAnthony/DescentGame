///glr_light_get_depth(light)

/*
    <=============== DESCRIPTION ===============>
        returns the light depth

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        depth = glr_light_get_depth(light);
    <===========================================>
*/

return argument0[| GLR_LIGHT.zdepth];