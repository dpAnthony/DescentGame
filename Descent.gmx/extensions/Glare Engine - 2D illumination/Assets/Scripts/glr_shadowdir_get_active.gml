///glr_shadowdir_get_active(id)

/*
    <=============== DESCRIPTION ===============>
        return true if the shadowdir with
        the given id is Active
        
    <===============  ARGUMENTS  ===============>
        id: shadowdir id returned by glr_shadowdir_create     
    <===========================================>
*/

var l = argument0; 
return l[| GLR_SHADOWDIR.active];