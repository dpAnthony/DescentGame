///glr_lightsimple_set_active(light, active)

/*
    <=============== DESCRIPTION ===============>
        If you want to disable a simple light
        you can set it as inactive.
        
        Useful when you have a huge room and
        you want to disable the lights
        in the other side of the room
    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_lightsimple_create()
        active: true or false
    <===========================================>
*/

argument0[| GLR_LIGHT.active] = argument1;