#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP float uie_scale;
extern MY_HIGHP_OR_MEDIUMP float uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 alpha_effect;

float vnoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    float a = fract(sin(dot(i,             vec2(127.1, 311.7))) * 43758.5453);
    float b = fract(sin(dot(i + vec2(1,0), vec2(127.1, 311.7))) * 43758.5453);
    float c = fract(sin(dot(i + vec2(0,1), vec2(127.1, 311.7))) * 43758.5453);
    float d = fract(sin(dot(i + vec2(1,1), vec2(127.1, 311.7))) * 43758.5453);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    float iTime = alpha_effect.y;

    vec4 tex  = Texel(texture, texture_coords);
    vec4 base = tex * colour;

    vec2 normPos = (screen_coords - uie_details.xy) / max(uie_details.w, uie_details.z);

    vec2 warp = vec2(
        vnoise(normPos * 2.5 + vec2( iTime * 0.07,  iTime * 0.05)),
        vnoise(normPos * 2.5 + vec2(-iTime * 0.05,  iTime * 0.08) + vec2(3.7, 1.4))
    );

    vec2 warped = normPos + warp * 0.18;

    float n1 = vnoise(warped * 3.0 + vec2( iTime * 0.09,  iTime * 0.06));
    float n2 = vnoise(warped * 6.0 + vec2( iTime * 0.05, -iTime * 0.11));
    float n  = n1 * 0.65 + n2 * 0.35;

    float alpha = 0.4 + n * 0.6;

    vec3 col = base.rgb;
    col += vec3(min(0.0, 0.000001 * (uie_details.x + uie_details.y + uie_details.w + uie_details.z + uie_scale + uie_rot)));

    return vec4(col, base.a * alpha);
}