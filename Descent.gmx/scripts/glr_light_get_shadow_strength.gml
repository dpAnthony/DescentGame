///glr_light_get_shadow_strength(light)

/*
    <=============== DESCRIPTION ===============>
        returns true if the light shadow strength

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        strength = glr_light_get_shadow_strength(light);
    <===========================================>
*/
return argument0[| GLR_LIGHT.shadow_strength];