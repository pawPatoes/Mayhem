#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP float uie_scale;
extern MY_HIGHP_OR_MEDIUMP float uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 ethereal_bg;

vec3 hsv2rgb( in vec3 c ) {
    vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );
    return c.z * mix( vec3(1.0), rgb, c.y);
}

vec3 rgb255(in float r, in float g, in float b) {
    return vec3(r/255.0, g/255.0, b/255.0);
}

vec3 grad2( in float t, in vec3 col1, in vec3 col2) {
    return mix(col1, col2, smoothstep(0.0, 1.0, 1.0-abs(2.0*fract(t)-1.0)));
}

vec3 grad3(float t, vec3 col1, vec3 col2, vec3 col3) {
    float st = fract(t)*3.0;
    float i = floor(st);
    float p = smoothstep(0.0, 1.0, fract(st));
    if (i == 0.0)      return mix(col1, col2, p);
    else if (i == 1.0) return mix(col2, col3, p);
    else               return mix(col3, col1, p);
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 fragCoord = screen_coords - uie_details.xy;
    vec2 iResolution = uie_details.zw;
    float iTime = ethereal_bg.y;

    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / max(iResolution.x, iResolution.y);
    uv *= 1.75 + (uie_scale * 0.00001 + uie_rot * 0.00001);
    vec3 col = vec3(0.0);

    col += grad2(iTime*0.25+(uv.x*0.08)+(uv.y*-0.02),
        rgb255(0.0, 174.0, 255.0),
        rgb255(32.0*1.1, 116.0*1.1, 245.0*1.1));

    float squareDist = (abs(uv.x))+(abs(uv.y));
    col *= 0.93+0.07*step(0.5, mod(squareDist-(iTime*0.2), 1.0));

    float vign = 1.0 - smoothstep(0.5, 1.5, length(uv * 0.5));
    col *= vign;

    float brightness = dot(colour.rgb, vec3(0.299, 0.587, 0.114));
    col *= brightness;

    return vec4(col, colour.a);
}