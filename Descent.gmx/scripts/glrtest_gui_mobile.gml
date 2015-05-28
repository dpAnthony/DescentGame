///glrtest_gui_mobile()


var vw = display_get_gui_width();
var vh = display_get_gui_height();

var fxaa = glr_get_enabled_fxaa();
var directional = glr_get_enabled_directional();
var occlusion = glr_get_enabled_occlusion();
var blur = glr_get_enabled_blur();

var ps = 10;
if(glrtest_text_pressed("Fxaa", ps, vh-50,2)){
    fxaa = !fxaa;
    glr_enable_fxaa(fxaa);
}


ps += 100;
//toggle directional
if(glrtest_text_pressed("DirLight", ps, vh-50,2)){
    directional = !directional;
    glr_enable_directional(directional);
}

ps += 100;
//toggle occlusion
if(glrtest_text_pressed("Occlus.", ps, vh-50,2)){
    occlusion = !occlusion;
    glr_enable_occlusion(occlusion);
}


ps += 100;
//toggle occlusion
if(glrtest_text_pressed("Blur", ps, vh-50,2)){
    blur = !blur;
    glr_enable_blur(blur);
}



ps += 100;
//switch quality
var q = glr_get_quality();
if(glrtest_text_pressed("Quality", ps, vh-50,2)){
    switch(q){
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

    
ps += 100;
//edit daytime
if(glrtest_text_pressed("Time++", ps, vh-50,2)){
    add_time+=1000;
}

ps += 100;
if(glrtest_text_pressed("Time--", ps, vh-50,2)){
    add_time-=1000;
}

ps += 100;
if(glrtest_text_pressed("New Render", ps, vh-50,2)){
    obj_glare_controller.new_rendering_mode = !obj_glare_controller.new_rendering_mode 
}

if(glrtest_text_hold(" < ", 40, vh-160, 5))
    keyboard_key_press(ord("A"));
else
    keyboard_key_release(ord("A"));
    
if(glrtest_text_hold(" > ", 190, vh-160, 5))
    keyboard_key_press(ord("D"));
else
    keyboard_key_release(ord("D"));
    
if(glrtest_text_hold("  ^  ", vw-150, vh-150, 5))
    keyboard_key_press(ord("W"));
else
    keyboard_key_release(ord("W"));
    

 
draw_set_font(font_glare);
var col=draw_get_color();
var alpha = draw_get_alpha();
var str =  "== Mobile Test ==#" +
string(fps)+" fps#"+
"Quality: "+string(q*100)+ "%#"+ 
"ViewSize: "+string(global.GLR_WIDTH)+"x"+string(global.GLR_HEIGHT)+ "#"+
"DayTime: "+string_format(daytime*24,2,0)+ "#"+
string(ds_list_size(global.GLR_MESH_DYN_LIST))+" dynamic meshes#"+
string(ds_list_size(global.GLR_MESH_STC_LIST))+" static meshes#"+
string(ds_list_size(global.GLR_LIGHT_LIST))+" lights#"+
string(ds_list_size(global.GLR_LIGHT_LIST_SIMPLE))+" simple lights#"+
"FXAA: "+glrtest_string_onoff(fxaa)+"#"+
"Directional: "+glrtest_string_onoff(directional)+"#"+
"Occlusion: "+glrtest_string_onoff(occlusion)+"#"+
"Blur: "+glrtest_string_onoff(blur)+"#"+
"New Render Mode: "+glrtest_string_onoff(obj_glare_controller.new_rendering_mode)+"#"

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(5,5, string_width(str)+20,string_height(str)+20, 0);
draw_set_color(c_white);
draw_rectangle(5,5, string_width(str)+20,string_height(str)+20, 1);
draw_text(15, 15, str ); 

draw_set_alpha(1);
draw_set_color(col);
 

 