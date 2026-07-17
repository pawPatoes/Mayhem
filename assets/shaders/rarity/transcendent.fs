#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP float uie_scale;
extern MY_HIGHP_OR_MEDIUMP float uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 transcendent;

vec3 rgb255(in float r, in float g, in float b) {
    return vec3(r/255.0, g/255.0, b/255.0);
}

vec3 grad4(float t, vec3 col1, vec3 col2, vec3 col3, vec3 col4) {
    float st = fract(t) * 4.0;
    float i  = floor(st);
    float p  = smoothstep(0.0, 1.0, fract(st));
    if (i == 0.0)      return mix(col1, col2, p);
    else if (i == 1.0) return mix(col2, col3, p);
    else if (i == 2.0) return mix(col3, col4, p);
    else               return mix(col4, col1, p);
}

const mat2 FBM_ROT = mat2(
    0.87758256, 0.47942554,
   -0.47942554, 0.87758256
);

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

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    for (int i = 0; i < 5; i++) {
        v += a * vnoise(p);
        p  = FBM_ROT * p * 2.0 + vec2(100.0);
        a *= 0.5;
    }
    return v;
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 fragCoord   = screen_coords - uie_details.xy;
    vec2 iResolution = uie_details.zw;
    float iTime      = transcendent.y;

    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / max(iResolution.x, iResolution.y);
    uv *= 0.5 + (uie_scale * 0.0001 + uie_rot * 0.0001);

    vec3 c1 = rgb255(18.0,  194.0, 233.0);
    vec3 c2 = rgb255(196.0, 113.0, 237.0);
    vec3 c3 = rgb255(246.0,  79.0,  89.0);
    vec3 c4 = rgb255(196.0, 113.0, 237.0);

    vec2 p = uv;

    vec2 q = vec2(
        fbm(p + vec2(0.0, 0.0) + iTime * 0.008),
        fbm(p + vec2(5.2, 1.3) - iTime * 0.006)
    );

    vec2 r = vec2(
        fbm(p + 3.2 * q + vec2(1.7, 9.2) + iTime * 0.005),
        fbm(p + 3.2 * q + vec2(8.3, 2.8) - iTime * 0.004)
    );

    float f = fbm(p + 3.5 * r);

    float hueT  = iTime * 0.08 + uv.x * 0.07 + q.x * 0.35 - q.y * 0.15;
    vec3 hueCol = grad4(hueT, c1, c2, c3, c4);

    float filament = max(0.1, pow(smoothstep(0.25, 0.75, f), 7.));
    float glow     = max(0.1, smoothstep(0.3, 0.7, f) * 0.5);

    vec3 col = vec3(0.0);
    col += hueCol * filament * 2.0;
    col += hueCol * glow;
    col  = clamp(col, 0.0, 1.0);

    col *= colour.rgb;

    return vec4(col, colour.a);
}