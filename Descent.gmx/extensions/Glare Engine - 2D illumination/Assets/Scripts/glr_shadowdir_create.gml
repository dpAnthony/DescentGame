///glr_shadowdir_create(sprite, subimage, sprite_shadow, subimage_shadow, x, y, zdepth, xscale, yscale, rotation)

/*
    <=============== DESCRIPTION ===============>
        Create ambient occlusion around the
        given sprite at the given position
        
    <===============  ARGUMENTS  ===============>
        sprite: the sprite used as mask
        subimage: the number of the frame
        sprite_shadow: sprite used as shadow
        subimage_shadow: subimage of the sprite used as shadow
        x: coordinate in world space
        y: coordinate in world space
        zdepth:  depth from 0 to 16777215 (only integer numbers)
        xscale: scaling in x axis of the sprite
        yscale: scaling in y axis of the sprite
        rotation: angle of the sprite
        
    <===========================================>
*/

var l = ds_list_create();
l[| GLR_SHADOWDIR.type] = GLR_TYPE.shadowdir;
l[| GLR_SHADOWDIR.active] = true;
l[| GLR_SHADOWDIR.sprite] = argument0;
l[| GLR_SHADOWDIR.subimage] = argument1; 
l[| GLR_SHADOWDIR.sprite_shadow] = argument2; 
l[| GLR_SHADOWDIR.subimage_shadow] = argument3; 
l[| GLR_SHADOWDIR.px] = argument4; 
l[| GLR_SHADOWDIR.py] = argument5; 
l[| GLR_SHADOWDIR.zdepth] = floor(argument6); 
l[| GLR_SHADOWDIR.xscale] = argument7; 
l[| GLR_SHADOWDIR.yscale] = argument8; 
l[| GLR_SHADOWDIR.rotation] = argument9; 

var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);
l[| GLR_SHADOWDIR.bcircle] =  max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo));

ds_list_add(global.GLR_SHADOWDIR_LIST, l);
global.GLR_DIRECTIONAL_UPDATED = false;
return l;