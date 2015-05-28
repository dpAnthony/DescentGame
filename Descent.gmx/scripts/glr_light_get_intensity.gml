///glr_light_get_intensity(light)

/*
    <=============== DESCRIPTION ===============>
        returns the light intensity

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        intensity = glr_light_get_intensity(light);
    <===========================================>
*/

return argument0[| GLR_LIGHT.intensity];