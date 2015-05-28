///glr_shadowdir_set_active(id, active)

/*
    <=============== DESCRIPTION ===============>
        activate or deactivate the shadowdir    
        
    <===============  ARGUMENTS  ===============>
        id: shadowdir id returned by glr_shadowdir_create  
        active: true or false  
    <===========================================>
*/

var l = argument0; 
l[| GLR_SHADOWDIR.active] = argument1;