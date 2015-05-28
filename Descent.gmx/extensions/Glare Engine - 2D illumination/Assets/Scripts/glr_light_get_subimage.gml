///glr_light_get_subimage(light)

/*
    <=============== DESCRIPTION ===============>
        returns the light subimage

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        sub = glr_light_get_subimage(light);
    <===========================================>
*/

return argument0[| GLR_LIGHT.subimage];