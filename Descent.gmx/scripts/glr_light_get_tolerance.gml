///glr_light_get_tolerance(light)

/*
    <=============== DESCRIPTION ===============>
        returns the light tolerance

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        tolerance = glr_light_get_tolerance(light);
    <===========================================>
*/
return argument0[| GLR_LIGHT.tolerance];