///glr_light_set_color(light, color)

/*
    <=============== DESCRIPTION ===============>
        Sets the light color
    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        color: the light color
        
    <===============  EXAMPLE  ===============>
        glr_light_set_color(light, c_red);
    <===========================================>
*/

var light = argument0;
light[| GLR_LIGHT.color] = argument1;