///glr_shadowdir_destroy(id);

/*
    <=============== DESCRIPTION ===============>
        Destroy the shadowdir with the given id       
        
    <===============  ARGUMENTS  ===============>
        id: shadowdir id returned by glr_shadowdir_create     
    <===========================================>
*/


ds_list_delete(global.GLR_SHADOWDIR_LIST, ds_list_find_index(global.GLR_SHADOWDIR_LIST, argument0));
ds_list_destroy(argument0);

global.GLR_DIRECTIONAL_UPDATED = false;