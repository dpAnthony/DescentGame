///glr_shadowdir_set_transform(id, x, y, xscale, yscale, rot)

/*
    <=============== DESCRIPTION ===============>
        Change the transform of the shadowdir
     
        NOTE: you can use ds accessors to
        speed up your code
        
    <===========================================>
*/

var l = argument0; 
l[| GLR_SHADOWDIR.px] = argument1;
l[| GLR_SHADOWDIR.py] = argument2;
l[| GLR_SHADOWDIR.xscale] = argument3;
l[| GLR_SHADOWDIR.yscale] = argument4; 
l[| GLR_SHADOWDIR.rotation] = argument5; 