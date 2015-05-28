attribute vec3 in_Position;
uniform vec2 direction; 
void main()
{  
    vec4 vertex_space_pos = vec4(in_Position.x, in_Position.y, 0, 1.0); 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vertex_space_pos;
    gl_Position.x += in_Position.z * direction.x;
    gl_Position.y -= in_Position.z * direction.y;
}    
//######################_==_YOYO_SHADER_MARKER_==_######################@~void main() 
{
    gl_FragColor = vec4(0,0,0, 1.0); 
}
