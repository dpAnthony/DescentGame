attribute vec3 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord; 

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vTexcoord = in_TextureCoord;
}
 
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord; 

uniform vec2 LightOffset; 
uniform float uScale; 
 

void main()
{

  vec2 offset = (v_vTexcoord - LightOffset)*uScale ;  
  vec2 coord = v_vTexcoord;
  
  float alpha = 0.0; 
  for(int i=0; i < 4 ; i++)
  {
     coord -= offset;
     vec4 sample = texture2D(gm_BaseTexture, coord ); 
          alpha += sample.a; 
  }
    gl_FragColor.a = alpha;
}

