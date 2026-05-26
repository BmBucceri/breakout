shader_type canvas_item;

// Define the screen texture uniform
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Read the pixel from the screen behind the object
    vec3 background_color = texture(screen_texture, SCREEN_UV).rgb;
    
    // Read the alpha from the node's own texture (to use as a mask)
    float mask_alpha = texture(TEXTURE, UV).a;
    
    // Invert the background colors
    vec3 inverted_color = vec3(1.0) - background_color;
    
    // Apply the inverted color where the mask is visible, 
    // otherwise keep the original background
    vec3 final_color = mix(background_color, inverted_color, mask_alpha);
    
    // Output the final color with the original mask alpha
    COLOR = vec4(final_color, mask_alpha);
}