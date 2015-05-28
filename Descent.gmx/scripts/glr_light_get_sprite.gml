///glr_light_get_sprite(light)

/*
    <=============== DESCRIPTION ===============>
        returns the light sprite

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
            
    <================  EXAMPLE  ================>
        spr = glr_light_get_sprite(light);
    <===========================================>
*/

return argument0[| GLR_LIGHT.sprite];