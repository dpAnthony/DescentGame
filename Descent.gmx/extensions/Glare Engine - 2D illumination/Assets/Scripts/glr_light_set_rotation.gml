///glr_light_set_rotation(light, rotation)

/*
    <=============== DESCRIPTION ===============>
        Set the light rotation
    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        rotation: the angle
        
    <===============  EXAMPLE  ===============>
        glr_light_set_rotation(light, image_angle);
    <===========================================>
*/

var l = argument0;

l[| GLR_LIGHT.rotation] = argument1;

ds_list_delete(l, GLR_LIGHT.matrix);
ds_list_insert(l, GLR_LIGHT.matrix, matrix_multiply(
    l[| GLR_LIGHT.matrix_offset],
    matrix_build(
        l[| GLR_LIGHT.px], l[| GLR_LIGHT.py], 0,
        0, 0, argument1,
        l[| GLR_LIGHT.xscale], l[| GLR_LIGHT.yscale], 1
    )
));