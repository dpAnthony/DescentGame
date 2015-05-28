///glr_draw(x,y)
 
/*
    <=============== DESCRIPTION ===============>
        Render the main surface on the screen
        
        Use this function in Draw Event
        
        NOTE: you can choose only one of
              glr_draw or glr_draw_gamma
              the 2 functions are different and 
              must be used in different events

    <===============  ARGUMENTS  ===============>
        x: the x coordinate (relative to the world)
        y: the x coordinate (relative to the world)
        
    <===============  EXAMPLE  ===============>
        glr_draw(view_xview, view_yview);
    <===========================================>
*/

 
if(view_enabled){
    var v_x0 = view_xview,
    v_y0 = view_yview,
    v_x1 = v_x0+view_wview,
    v_y1 = v_y0+view_hview;
}else{
    var v_x0 = 0,
    v_y0 = 0,
    v_x1 = room_width,
    v_y1 = room_height;
}



//===============================================
//  Drawing main surface
//===============================================
if(!surface_exists(global.GLR_MAIN_SURFACE)){
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    if(!surface_exists(global.GLR_MAIN_SURFACE)){
        return 0;
    }
} 
surface_set_target(global.GLR_MAIN_SURFACE);
draw_clear(global.GLR_AMBIENT_COLOR);
if(global.GLR_DIRECTIONAL_ENABLED  && global.GLR_DIRECTIONAL_STRENGTH > 0 ){
    draw_surface_stretched_ext(global.GLR_DIRECTIONAL_SURFACE,0,0,global.GLR_MAIN_SURFACE_WIDTH ,global.GLR_MAIN_SURFACE_HEIGHT ,0,global.GLR_DIRECTIONAL_STRENGTH);
}

 
  
//area shadows

d3d_set_projection_ortho(0,0,global.GLR_WIDTH /global.GLR_ZOOM,global.GLR_HEIGHT /global.GLR_ZOOM,0); 
var sz = ds_list_size(global.GLR_SHADOWAREA_LIST); 
var ill, col;
var c = (1-global.GLR_DIRECTIONAL_STRENGTH);  
for(j = 0; j < sz j++){
    l = global.GLR_SHADOWAREA_LIST[| j];
    if(l[| GLR_SHADOWAREA.active]){
        ill = l[| GLR_SHADOWAREA.illumination] * c;
        col = make_color_rgb(colour_get_red(global.GLR_AMBIENT_COLOR)*ill,colour_get_green(global.GLR_AMBIENT_COLOR)*ill,colour_get_blue(global.GLR_AMBIENT_COLOR)*ill);
        d3d_transform_set_identity(); 
        d3d_transform_add_translation(l[| GLR_SHADOWAREA.px]-v_x0, l[| GLR_SHADOWAREA.py]-v_y0, 0);
        shader_set(glr_shader_mesh_color);
        shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, color_get_red(col)/255, color_get_green(col)/255, color_get_blue(col)/255, 1); 
        vertex_submit(l[| GLR_SHADOWAREA.model_vertex_buffer],pr_trianglestrip, -1); 
        shader_reset();
    }
} 
d3d_transform_set_identity();

 

surface_reset_target();


////////////////////////////////////////////////
//  Render All lights
//////////////////////////////////////////////// 

draw_set_blend_mode(bm_add);
surface_set_target(global.GLR_MAIN_SURFACE);
d3d_set_projection_ortho(0, 0, global.GLR_WIDTH /global.GLR_ZOOM, global.GLR_HEIGHT /global.GLR_ZOOM, 0);
  
for(var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST); i++)
{
    l_id = global.GLR_LIGHT_LIST[| i];
    
    if(!l_id[| GLR_LIGHT.active] || l_id[| GLR_LIGHT.outofview]) continue;
     
     
    //info 
    l_intensity = l_id[| GLR_LIGHT.intensity];  
     
    
    if(!surface_exists(l_id[| GLR_LIGHT.surf_light])){
        l_sprite = l_id[| GLR_LIGHT.sprite];
        var l_spr_w = sprite_get_width(l_sprite);
        var l_spr_h = sprite_get_height(l_sprite); 
        l_id[| GLR_LIGHT.surf_light] = surface_create(l_spr_w, l_spr_h);
        if(!surface_exists(l_id[| GLR_LIGHT.surf_light])) return 0;
    }
    l_surf = l_id[| GLR_LIGHT.surf_light];  
    
    //transform light 
    
    matrix_set(matrix_world, matrix_multiply( l_id[| GLR_LIGHT.matrix], matrix_build(-v_x0, -v_y0, 0, 0, 0, 0, 1, 1, 1)));  
    
    //draw light 
    draw_surface_stretched(l_surf, 0, 0, 1 ,1);   
   
} 
//reset world identity
d3d_transform_set_identity();

////////////////////////////////////////////////
//  Drawing simple lights
////////////////////////////////////////////////
for(var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST_SIMPLE); i++)
{     
    l_id = global.GLR_LIGHT_LIST_SIMPLE[| i];
    
    if(!l_id[| GLR_LIGHT.active]) continue; 
    //transform
    l_x = l_id[| GLR_LIGHT.px];
    l_y = l_id[| GLR_LIGHT.py];
    l_xscale = l_id[| GLR_LIGHT.xscale];
    l_yscale = l_id[| GLR_LIGHT.yscale];
    
    l_bcircle = l_id[| GLR_LIGHT.bounding_circle] * max(l_xscale, l_yscale);
    
    //out of view
    test_x = l_x - clamp(l_x, v_x0, v_x1);
    test_y = l_y - clamp(l_y, v_y0, v_y1);
    if (test_x * test_x + test_y * test_y > l_bcircle * l_bcircle) {continue;}
    
    l_rotation = l_id[| GLR_LIGHT.rotation];
    
    //info 
    l_color = l_id[| GLR_LIGHT.color];
    l_alpha = l_id[| GLR_LIGHT.alpha];
    l_intensity = l_id[| GLR_LIGHT.intensity];
    l_sprite = l_id[| GLR_LIGHT.sprite];
    l_spr_index = l_id[| GLR_LIGHT.subimage];
      
    
    //draw light
    draw_sprite_ext(l_sprite, l_spr_index,  l_x - v_x0, l_y - v_y0, l_xscale   , l_yscale   , l_rotation, l_color, l_alpha);

}
surface_reset_target();
draw_set_blend_mode(bm_normal);




//===============================================
//  Render Ambient occlusion
//===============================================

if(global.GLR_OCCLUSION_ENABLED)
{
    if(!surface_exists(global.GLR_DEPTH_SURFACE)){
        global.GLR_DEPTH_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH , global.GLR_MAIN_SURFACE_HEIGHT);
        if(!surface_exists(global.GLR_DEPTH_SURFACE)){
            return 0;
        }
    }
    
    //depthmap sampler creation
    var size = ds_list_size(global.GLR_OCCLUSION_LIST);
    var size2 = ds_list_size(global.GLR_OCCLUSION_LIST_INST);
    if(size > 0 || size2 > 0){
        surface_set_target(global.GLR_DEPTH_SURFACE);
        d3d_set_projection_ortho(0,0,global.GLR_WIDTH /global.GLR_ZOOM,global.GLR_HEIGHT /global.GLR_ZOOM,0);
 
        shader_set(glr_shader_depth);
         
         
        var sw, bcircle; 
        for(i = 0; i<size; i++)
        {
            l = global.GLR_OCCLUSION_LIST[| i];
            if(l[| GLR_OCCLUSION.active])
            {
                px = l[| GLR_OCCLUSION.px];
                py = l[| GLR_OCCLUSION.py];
                bcircle = l[| GLR_OCCLUSION.bounding_circle];
                //out of view
                test_x = px - clamp(px, v_x0,v_x1);
                test_y = py - clamp(py, v_y0, v_y1);
                if (test_x * test_x + test_y * test_y < bcircle * bcircle )
                {
                    draw_sprite_ext(
                        l[| GLR_OCCLUSION.sprite],
                        l[| GLR_OCCLUSION.subimage],
                        px-view_xview, py-view_yview,
                        l[| GLR_OCCLUSION.xscale],
                        l[| GLR_OCCLUSION.yscale],
                        l[| GLR_OCCLUSION.rotation], 0, 1);
                }
            }
        }
        var inst;
        for(i = 0; i<size2; i++){
            inst = global.GLR_OCCLUSION_LIST_INST[| i];
            with(inst)
                draw_sprite_ext(sprite_index, image_index, x-v_x0, y-v_y0, image_xscale, image_yscale, image_angle, 0, 1);
        }
        shader_reset(); 
        surface_reset_target();
    }
    
}
 
 

if(global.GLR_BLUR_ENABLED)
{
    
    if(!surface_exists(global.GLR_BLUR_SURFACE)){
        global.GLR_BLUR_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
        if(!surface_exists(global.GLR_BLUR_SURFACE)){
            return 0;
        }
    }
    
    //blur hor
    surface_set_target(global.GLR_BLUR_SURFACE);
    shader_set(glr_shader_blur_hor);
    draw_surface(global.GLR_MAIN_SURFACE, 0, 0);
    shader_reset();
    surface_reset_target();
    
    
    
    draw_set_blend_mode_ext(bm_zero,bm_src_color);
    
    //blur vert on screen
    shader_set(glr_shader_blur_ver);
    draw_surface_stretched(global.GLR_BLUR_SURFACE,argument0,argument1, global.GLR_WIDTH /global.GLR_ZOOM, global.GLR_HEIGHT /global.GLR_ZOOM);
    shader_reset(); 
     
    draw_set_blend_mode(bm_normal); 

}
else{

    draw_set_blend_mode_ext(bm_zero,bm_src_color); 
    if(global.GLR_FXAA_ENABLED){
        shader_set(glr_shader_fxaa);
        shader_set_uniform_f(global.GLR_UNIF_FXAA_SIZE, global.GLR_WIDTH /global.GLR_ZOOM, global.GLR_HEIGHT /global.GLR_ZOOM);
    }
    
    if(surface_exists(global.GLR_MAIN_SURFACE)){
        draw_surface_stretched(global.GLR_MAIN_SURFACE,argument0,argument1, global.GLR_WIDTH /global.GLR_ZOOM, global.GLR_HEIGHT /global.GLR_ZOOM);
    }
    if(global.GLR_FXAA_ENABLED){
        shader_reset();
    }
    draw_set_blend_mode(bm_normal);
}

 
//occlusion rendering
if(global.GLR_OCCLUSION_ENABLED && surface_exists(global.GLR_DEPTH_SURFACE))
{
    texture_set_repeat(false);
    shader_set(glr_shader_ambient_occlusion); 
    shader_set_uniform_f(global.GLR_UNIF_OCCLUSION, global.GLR_OCCLUSION_INTENSITY);
    draw_surface_stretched(global.GLR_DEPTH_SURFACE,argument0,argument1, global.GLR_WIDTH /global.GLR_ZOOM, global.GLR_HEIGHT /global.GLR_ZOOM);

    shader_reset();  
    texture_set_repeat(true);
} 
   