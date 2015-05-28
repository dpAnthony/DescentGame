///glrtest_gui_desktop()

var vw = display_get_gui_width();
var vh = display_get_gui_height();

var fxaa = glr_get_enabled_fxaa();
var directional = glr_get_enabled_directional();
var occlusion = glr_get_enabled_occlusion();
var blur = glr_get_enabled_blur();

//create light        
if(mouse_check_button_pressed(mb_right))
    instance_create(mouse_x,mouse_y,  obj_light_random_static);
if(mouse_check_button_pressed(mb_middle)&& instance_number(obj_light_mouse) == 0){
    instance_create(mouse_x,mouse_y,  obj_light_mouse);
} 

//Change room
if(keyboard_check_pressed(vk_space)){
    if(room != room_last) room_goto_next();
    else room_goto(room_next(room_glare_init));
}



//toggle fxaa
if(keyboard_check_pressed(ord("1"))){
    fxaa = !fxaa;
    glr_enable_fxaa(fxaa);
} 
//toggle directional
if(keyboard_check_pressed(ord("2"))){
    directional = !directional;
    glr_enable_directional(directional);
}

//toggle occlusion
if(keyboard_check_pressed(ord("3"))){
    occlusion = !occlusion;
    glr_enable_occlusion(occlusion);
}

//blur
if(keyboard_check_pressed(ord("4"))){
    blur = !blur; 
    glr_enable_blur(blur);
}

//toggle illumination
if(keyboard_check_pressed(ord("5"))){
    getillum = !getillum; 
}


//gamma rendering system
if(keyboard_check_pressed(ord("6"))){
    obj_glare_controller.new_rendering_mode =  !obj_glare_controller.new_rendering_mode;
}


//switch quality
var q = glr_get_quality();
if(keyboard_check_pressed(vk_control))
{
    switch(q)
    {
        case 1:
            glr_set_quality(0.75);
            glr_set_directional_quality(0.75);
        break;
        case 0.75:
            glr_set_quality(0.5);
            glr_set_directional_quality(0.5);
        break;
        case 0.5:
            glr_set_quality(0.25);
            glr_set_directional_quality(0.25);
        break;
        case 0.25:
            glr_set_quality(1);
            glr_set_directional_quality(1);
        break;
    }
}


//edit daytime
if(keyboard_check(vk_pageup)){
    add_time+=500;
}
else if(keyboard_check(vk_down)){
    add_time-=500;
}


//test of get illumination functions

if(getillum)
    illum = glrtest_get_illumination(); 
else 
    illum = "disabled";
     

    
    
//DEBUG 
str = string(fps)+" fps#"+
"Quality: "+string(q*100)+ "%#"+ 
"Glare Surf: "+string(global.GLR_MAIN_SURFACE_WIDTH)+"x"+string(global.GLR_MAIN_SURFACE_HEIGHT)+ "#"+
"App Surf: "+string(surface_get_width(application_surface))+"x"+string(surface_get_height(application_surface))+ "#"+
"DayTime: "+string_format(daytime*24,2,0)+ "#"+
string(ds_list_size(global.GLR_MESH_DYN_LIST))+" dynamic meshes#"+
string(ds_list_size(global.GLR_MESH_STC_LIST))+" static meshes#"+
string(ds_list_size(global.GLR_LIGHT_LIST))+" lights#"+
string(ds_list_size(global.GLR_LIGHT_LIST_SIMPLE))+" simple lights#"+
"FXAA: "+glrtest_string_onoff(fxaa)+"#"+
"Directional: "+glrtest_string_onoff(directional)+"#"+
"Occlusion: "+glrtest_string_onoff(occlusion)+"#"+
"Blur: "+glrtest_string_onoff(blur)+"#"+
"Illum. at x,y: "+ string(illum)+"#"+
"New Render Mode: "+glrtest_string_onoff(obj_glare_controller.new_rendering_mode)+"#";

draw_set_font(font_glare);
var col=draw_get_color();
var alpha = draw_get_alpha();
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(5,5, 20 + string_width(str), 20+ string_height(str), 0);
draw_set_color(c_white);
draw_rectangle(5,5, 20 + string_width(str), 20+ string_height(str), 1);
draw_text(15, 15, str );
 
//Controls 
draw_set_color(c_black);
draw_rectangle(5,vh-55, vw-5,vh-5, 0);
draw_set_color(c_white);
draw_rectangle(5,vh-55, vw-5,vh-5, 1);
draw_text(10, vh-50, "CONTROLS:#"+
"[WASD: move] "+
"[CTRL: quality] "+
"[MOUSE: place light] "+
"[SPACE: change room] "+
"[F: Flashlight] "+
"[1: FXAA] "+
"[2: Directional] "+
"[3: Occlusion] "+
"[4: Blur] "+
"[5: Get Illumin.] "+
"[6: New Render System] "
);

draw_set_alpha(1);
draw_set_color(col);


 