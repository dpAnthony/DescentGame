///glr_light_set_active(light, active)

/*
    <=============== DESCRIPTION ===============>
        If you want to disable a light
        you can set it as inactive.
        
        Useful when you have a huge room and
        you want to disable the lights
        in the other side of the room
    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        active: true or false
        
    <===============  EXAMPLE  ===============>
        glr_light_set_active(light, false);
    <===========================================>
*/
var l = argument0;
l[| GLR_LIGHT.active] = argument1;