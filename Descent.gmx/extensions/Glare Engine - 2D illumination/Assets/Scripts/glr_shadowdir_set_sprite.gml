///glr_shadowdir_set_sprite(id, sprite, subimage)

/*
    <=============== DESCRIPTION ===============>
        Changes the sprite used as Mask
        to the shadowdir with the given id      
        
        NOTE: you can use ds accessors to
        speed up your code
        
    <===============  ARGUMENTS  ===============>
        id: shadowdir id returned by glr_shadowdir_create   
        sprite: the new sprite
        subimage: the new subimage  
    <===========================================>
*/

var l = argument0; 
l[| GLR_SHADOWDIR.sprite] = argument1;  
l[| GLR_SHADOWDIR.subimage] = argument2; 