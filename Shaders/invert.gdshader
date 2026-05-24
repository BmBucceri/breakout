shader_type canvas_item;

// Allows you to control the effect from the Inspector or via Tween
uniform float strength : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Get the color currently behind the panel
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Invert the color
    vec3 inverted_color = vec3(1.0) - screen_color.rgb;
    
    // Mix between original and inverted based on strength
    COLOR.rgb = mix(screen_color.rgb, inverted_color, strength);
    COLOR.a = screen_color.a;
}