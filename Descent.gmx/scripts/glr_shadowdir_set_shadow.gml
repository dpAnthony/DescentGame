///glr_shadowdir_set_shadow(id, sprite_shadow, subimage_shadow)


/*
    <=============== DESCRIPTION ===============>
        Changes the sprite used as shadow
        to the shadowdir with the given id      
        
        NOTE: you can use ds accessors to
        speed up your code
        
    <===============  ARGUMENTS  ===============>
        id: shadowdir id returned by glr_shadowdir_create   
        sprite_shadow: the new sprite
        subimage_shadow: the new subimage  
    <===========================================>
*/

var l = argument0; 
l[| GLR_SHADOWDIR.sprite_shadow] = argument1;  
l[| GLR_SHADOWDIR.subimage_shadow] = argument2; 