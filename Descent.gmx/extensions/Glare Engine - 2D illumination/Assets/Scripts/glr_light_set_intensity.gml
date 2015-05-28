///glr_light_set_intensity(light, intensity)

/*
    <=============== DESCRIPTION ===============>
        sets the intensity/brightness value for
        the light.
        
        ONLY AVAILABLE if you use glr_draw_gamma

    <===============  ARGUMENTS  ===============>
        light: the light id returned by glr_light_create()
        intensity: brightness value from 0 to 1
    
    <===============  EXAMPLE  ===============>
        glr_light_set_intensity(light, 0.5);
    <===========================================>
*/
argument0[| GLR_LIGHT.intensity] = argument1;