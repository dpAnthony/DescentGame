///glrtest_text_pressed(text, x, y, scale) 
draw_set_halign(fa_center);
draw_set_valign(fa_center);
var ret = false;
var text = argument0
var px=argument1;
var py=argument2;
var scale=argument3; 
var padding = 5;
var w = (string_width(text)+padding) * scale;
var h = (string_height(text)+padding) * scale;
for(var i=0;i<5;i++){
    if(device_mouse_check_button_pressed(i,mb_left)){
        mx=device_mouse_x_to_gui(i);
        my=device_mouse_y_to_gui(i);
        if(mx>min(px,px+w))
         if(my>min(py,py+h))
          if(mx<max(px,px+w))
           if(my<max(py,py+h)){
            ret = 1;
            break;
           }
    }
}
var col = draw_get_color();

if(ret)
    draw_set_color(c_green);
else
    draw_set_color(c_white);

draw_set_alpha(0.4);
draw_rectangle(px, py, px+w, py+h, 0);

draw_set_alpha(1); 
draw_set_color(c_black);
draw_text_transformed(px+w/2, py+h/2, text, scale, scale, 0);

draw_set_color(col);

draw_set_halign(fa_left);
draw_set_valign(fa_top); 

return ret;