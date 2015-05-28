///glr_init(quality, width, height, view)

/*
    <=============== DESCRIPTION ===============>
        Initializes the engine
        
        Call this function as first!

    <===============  ARGUMENTS  ===============>
        quality: the main surface resolution (from 0.1 to 1)
        
        < OPTIONAL >
        width: main surface width
        height: main surface height
        view: number of the view that uses the engine
        
    <===============  EXAMPLE  ===============>
        glr_init(0.5);
        or
        glr_init(0.5, 640, 480, 0);
    <===========================================>
*/
 


global.GLR_VIEW = 0;
global.GLR_ZOOM = 1;


global.GLR_MATRIX_WORLD_IDENTITY = matrix_get(matrix_world);
if(argument_count < 3){
    if(view_enabled){
        var s_width=view_wview[global.GLR_VIEW];
        var s_height=view_hview[global.GLR_VIEW]; 
    }
    else{
        var s_width=room_width;
        var s_height=room_height; 
    }
}
else{
    var s_width = argument[1];
    var s_height = argument[2];
    global.GLR_VIEW = argument[3];
}

global.GLR_WIDTH = s_width;
global.GLR_HEIGHT = s_height;

var q = clamp(argument[0], 0.05,1);
global.GLR_MAIN_QUALITY = q; 
global.GLR_DIRECTIONAL_QUALITY = q; 


global.GLR_MAIN_SURFACE_WIDTH = s_width*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE_HEIGHT = s_height*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH , global.GLR_MAIN_SURFACE_HEIGHT); 


global.GLR_BLUR_ENABLED = false;
global.GLR_BLUR_SURFACE = -1;

global.GLR_AMBIENT_COLOR = $111111;

global.GLR_DIRECTIONAL_ENABLED = false;
global.GLR_DIRECTIONAL_SURFACE = -1;
global.GLR_DIRECTIONAL_WIDTH = s_width*global.GLR_DIRECTIONAL_QUALITY;
global.GLR_DIRECTIONAL_HEIGHT = s_height*global.GLR_DIRECTIONAL_QUALITY;


global.GLR_DEPTH_SURFACE = -1;
global.GLR_MAX_DEPTH = 16777215; //c_white 
global.GLR_OCCLUSION_ENABLED = false;
global.GLR_OCCLUSION_INTENSITY = 1;
global.GLR_FXAA_ENABLED=false;


global.GLR_MESH_DYN_LIST = ds_list_create();
global.GLR_MESH_STC_LIST = ds_list_create();

global.GLR_MESH_SORTED_LIST = ds_list_create();


global.GLR_SPR_DYN_LIST = ds_list_create();
global.GLR_SPR_STC_LIST = ds_list_create();

global.GLR_DEP_DYN_LIST = ds_list_create();
global.GLR_SHADOWDIR_LIST = ds_list_create();


global.GLR_SHADOWAREA_LIST = ds_list_create();

global.GLR_DIRECTIONAL_QUEUE = ds_priority_create();
global.GLR_DIRECTIONAL_TEMP_QUEUE = ds_priority_create();


global.GLR_DIRECTIONAL_STRENGTH = 0.5;
global.GLR_DIRECTIONAL_ANGLE = 320;
global.GLR_DIRECTIONAL_LENGTH = 0.2;
global.GLR_DIRECTIONAL_UPDATED = false;
 
global.GLR_LIGHT_LIST = ds_list_create();
global.GLR_LIGHT_LIST_SIMPLE = ds_list_create();
global.GLR_OCCLUSION_LIST = ds_list_create();
global.GLR_OCCLUSION_LIST_INST = ds_list_create();

global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH*global.GLR_MAIN_SURFACE_HEIGHT*4, buffer_fixed, 4); 
//buffer_seek(global.GLR_ILLUM_BUFFER, buffer_seek_start, 0); 


global.GLR_OS_MESH_SHADER = glr_shader_mesh;
global.GLR_OS_GAMMA_SHADER = glr_shader_gamma;
global.GLR_OS_GAMMA_SHADER_FXAA = glr_shader_gamma_fxaa;
global.GLR_OS_GAMMA_SHADER_BLUR = glr_shader_gamma_blur;
if(os_type == os_android || os_type == os_ios)
{
    global.GLR_OS_GAMMA_SHADER = glr_shader_gamma_mobile;
    global.GLR_OS_GAMMA_SHADER_FXAA = glr_shader_gamma_fxaa_mobile;
    global.GLR_OS_GAMMA_SHADER_BLUR = glr_shader_gamma_blur_mobile;
    global.GLR_OS_MESH_SHADER = glr_shader_mesh_mobile;
}


//shaders
global.GLR_UNIF_LIGHT_SCALE_SPR = shader_get_uniform(glr_shader_shadow_sprite,"uScale");
global.GLR_UNIF_LIGHT_OFFSET_SPR = shader_get_uniform(glr_shader_shadow_sprite,"LightOffset");
global.GLR_UNIF_LIGHT_OFFSET = shader_get_uniform(global.GLR_OS_MESH_SHADER,"LightOffset");
global.GLR_UNIF_LIGHT_STRENGTH = shader_get_uniform(global.GLR_OS_MESH_SHADER,"strength"); 
global.GLR_UNIF_MESH_MATDEPTH = shader_get_uniform(global.GLR_OS_MESH_SHADER,"uMatDepth"); 
global.GLR_UNIF_SHADOW_DEPTH = shader_get_uniform(global.GLR_OS_MESH_SHADER,"uShadowDepth"); 
global.GLR_UNIF_DIRECTIONAL = shader_get_uniform(glr_shader_directional,"direction");
global.GLR_UNIF_MESH_COLOR = shader_get_uniform(glr_shader_mesh_color,"uColor"); 
global.GLR_UNIF_LIGHT_INTENSITY = shader_get_uniform(glr_shader_light, "uIntensity");
global.GLR_UNIF_LIGHT_INTENSITY_SIMPLE = shader_get_uniform(glr_shader_light_simple, "uIntensity");
global.GLR_UNIF_OCCLUSION = shader_get_uniform(glr_shader_ambient_occlusion, "uOcclusionIntensity"); 
global.GLR_UNIF_DIRECTIONAL_AMBIENT = shader_get_uniform(glr_shader_directional_gamma, "uAmbient");  
global.GLR_UNIF_GAMMA_FXAA_SIZE = shader_get_uniform(global.GLR_OS_GAMMA_SHADER_FXAA, "frameBufSize");
global.GLR_UNIF_FXAA_SIZE = shader_get_uniform(glr_shader_fxaa,"frameBufSize");

global.GLR_SAMPLER_APP = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER, "uAppSampler");  
global.GLR_SAMPLER_APP_BLUR = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER_BLUR, "uAppSampler");  
global.GLR_SAMPLER_APP_FXAA = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER_FXAA, "uAppSampler");


global.GLR_SHADOWSPRITE_ENABLED = shader_is_compiled(glr_shader_shadow_sprite);


vertex_format_begin();
vertex_format_add_position_3d();
global.GLR_VERTEX_FORMAT = vertex_format_end();


vertex_format_begin();
vertex_format_add_position();
global.GLR_MODEL_FORMAT = vertex_format_end();

 
//Daytime

//midnight
global.GLR_M_R = 18;
global.GLR_M_G = 14;
global.GLR_M_B = 32;

//sunrise
global.GLR_S_R = 32;
global.GLR_S_G = 28;
global.GLR_S_B = 46;


//noon
global.GLR_N_R = 93;
global.GLR_N_G = 88;
global.GLR_N_B = 103;


//afternoon
global.GLR_A_R = 243;
global.GLR_A_G = 238;
global.GLR_A_B = 203;


//evening
global.GLR_E_R = 183;
global.GLR_E_G = 128;
global.GLR_E_B = 73;


enum GLR_TYPE{
    mesh,
    shadowdir
}

enum GLR_MESH{
    type,
    static,
    active,
    shadow_vertex_buffer,
    model_vertex_buffer,
    meshes,
    px,
    py,
    rotation,
    xscale,
    yscale,
    bounding_circle,
    bcircle,
    shadow_triangles_count,
    model_triangles_count,
    shadow_vertex_count,
    layer,
    shadow_strength,
    shadow_length_directional,
    height,
    zdepth,
    depth_mask,
    depth_mask_index,
    matrix,
}

enum GLR_LIGHT {
    active,
    static,
    info_size,
    px,
    py,
    rotation,
    zdepth,
    xscale,
    yscale,
    xoffset,
    yoffset,
    color,
    alpha,
    intensity,
    sprite,
    subimage,
    layer,
    bounding_circle,
    bcircle,
    surf_light,
    surf_shadowmap,
    surf_shadowsprite1,
    surf_shadowsprite2,
    is_clear,
    shadow_strength,
    tolerance,
    matrix_offset,
    matrix,
    outofview
}

enum GLR_SHADOWDEPTH {
    active,
    sprite,
    subimage,
    px,
    py,
    zdepth,
    xscale,
    yscale,
    rotation,
    bounding_circle
}


enum GLR_SHADOWAREA {
    active,
    model_vertex_buffer,
    px,
    py,
    illumination
}


enum GLR_SHADOWDIR{
    type,
    active,
    sprite,
    sprite_shadow,
    subimage,
    subimage_shadow,
    px,
    py,
    zdepth,
    xscale,
    yscale,
    rotation,
    bcircle
}

enum GLR_SHADOWSPRITE{
    active,
    static,
    layer,
    sprite,
    subimage,
    px,
    py,
    xscale,
    yscale,
    rotation,
    bcircle
}

enum GLR_OCCLUSION{
    active,
    sprite,
    subimage,
    px,
    py,
    xscale,
    yscale,
    rotation,
    bcircle,
    bounding_circle
}
