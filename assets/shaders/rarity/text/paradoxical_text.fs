#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec4 text_details;
extern MY_HIGHP_OR_MEDIUMP number text_scale;
extern MY_HIGHP_OR_MEDIUMP number text_rot;
extern MY_HIGHP_OR_MEDIUMP vec4 letter_details;
extern MY_HIGHP_OR_MEDIUMP number letter_scale;
extern MY_HIGHP_OR_MEDIUMP number letter_rot;
extern bool text_shadow;

extern MY_HIGHP_OR_MEDIUMP vec2 paradoxical_text;

float rand(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    float letter_seed = rand(floor(texture_coords * 250.));

    vec4 base = Texel(texture, texture_coords) * colour;

    float cycle_pos = fract(paradoxical_text.y * 0.35 + letter_seed * 7.0);
    float unstable = step(0.92, cycle_pos);
    float pulse = 0.85 + 0.15 * sin(paradoxical_text.y * 1.3 + letter_seed * 6.2831853);

    vec3 col = base.rgb * pulse;
    col = mix(col, vec3(dot(col, vec3(0.299, 0.587, 0.114))), unstable * 0.6);

    col.r += min(0.0, 0.000001 * (text_scale + text_rot + letter_scale + letter_rot + (text_shadow ? 1.0 : 0.0) + text_details.x + text_details.y + text_details.z + text_details.w + letter_details.x + letter_details.y + letter_details.z + letter_details.w));

    float brightness = dot(colour.rgb, vec3(0.299, 0.587, 0.114));
    col *= brightness;
	
    return vec4(col, base.a);
}