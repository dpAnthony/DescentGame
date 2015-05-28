///glr_light_refresh(light)

/*
    <=============== DESCRIPTION ===============>
        Use this function to update the
        surface of a STATIC light
        
        Example: during your gameplay
        you place a static mesh near the light
        and you want to save it's shadows?
        Use this function.
        
    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
    
    <===============  EXAMPLE  ===============>
        glr_light_refresh(light);
    <===========================================>
*/


var t_sur = argument0[| GLR_LIGHT.surf_shadowmap];
if(t_sur != -1)
{
    surface_free(t_sur);
    argument0[| GLR_LIGHT.surf_shadowmap] = -1;
}