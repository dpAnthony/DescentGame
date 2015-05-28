///glr_light_get_active(light)

/*
    <=============== DESCRIPTION ===============>
        returns true if the light is active

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        
    <================  EXAMPLE  ================>
        active = glr_light_get_active(light);
    <===========================================>
*/


return argument0[| GLR_LIGHT.active];