shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
// New uniform to control the effect's alpha/opacity
uniform float alpha_multiplier : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec3 background_color = texture(screen_texture, SCREEN_UV).rgb;
    
    // Get the texture's native alpha
    float tex_alpha = texture(TEXTURE, UV).a;
    
    // Combine native alpha with your tweenable multiplier
    float final_alpha = tex_alpha * alpha_multiplier;
    
    vec3 inverted_color = vec3(1.0) - background_color;
    
    // Use the combined alpha to mix the inversion
    vec3 final_color = mix(background_color, inverted_color, final_alpha);
    
    COLOR = vec4(final_color, final_alpha);
}