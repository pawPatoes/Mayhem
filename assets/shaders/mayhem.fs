#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec4  uie_details;
extern MY_HIGHP_OR_MEDIUMP float uie_scale;
extern MY_HIGHP_OR_MEDIUMP float uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 mayhem;

vec2 rot(vec2 uv, float a) {
    float c = cos(a), s = sin(a);
    return vec2(uv.x*c - uv.y*s, uv.y*c + uv.x*s);
}

float rand(float n) {
    return fract(cos(n * 29.42) * 363.42);
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	vec2 fragCoord = screen_coords - uie_details.xy;
    vec2 iResolution = uie_details.zw;

    float pixel_size = 3.0;
    fragCoord = floor(fragCoord / pixel_size) * pixel_size;

	vec2 uv = (fragCoord * 2.0 - iResolution.xy) / max(iResolution.x, iResolution.y);

    vec2 pixel_uv = (floor(fragCoord / pixel_size) * pixel_size * 2.0 - iResolution.xy) / max(iResolution.x, iResolution.y);
    pixel_uv *= 2.0 + (uie_scale * 0.0001 + uie_rot * 0.0001);

    vec2 base_uv = pixel_uv;

	float s   = 0.0;
    float rim = 0.0;

	vec3 col = vec3(0.0);

	for (int i = 0; i < 64; i++) {
        float fi = float(i);
        vec2 suv = base_uv;

        float angle = rand(fi * 3.7) * 3.14159;
        suv = rot(suv, angle);

        float offset = (rand(fi + 7.3) - 0.5) * 4.0;
        suv.x += offset;

        float wfreq1  = 2.0 + rand(fi + 3.1) * 4.0;
        float wfreq2  = 1.0 + rand(fi + 9.2) * 2.0;
        float wfreq3  = 0.5 + rand(fi + 6.3) * 1.5;
        float wphase1 = rand(fi + 5.7) * 6.28318;
        float wphase2 = rand(fi + 2.1) * 6.28318;
        float wphase3 = rand(fi + 8.8) * 6.28318;
		
		float t1 = mayhem.y * rand(fi + 11.1) * 0.5;
		float t2 = mayhem.y * rand(fi + 13.7) * 0.5;
		float t3 = mayhem.y * rand(fi + 17.3) * 0.5;

		float amp1 = clamp(0.35 + sin(t1 * 0.7 + 1.3) * 0.25, 0.0, 0.15);
        float amp2 = clamp(0.20 + sin(t2 * 1.3 + 2.7) * 0.20, 0.0, 0.10);
        float amp3 = clamp(0.50 + sin(t3 * 0.4 + 0.9) * 0.40, 0.0, 0.20);

		float freq1 = wfreq1 + sin(t1 * 1.1 + 0.5) * 2.0;
		float freq2 = wfreq2 + sin(t2 * 0.8 + 1.9) * 1.5;
		float freq3 = wfreq3 + sin(t3 * 1.7 + 3.1) * 1.0;

        float thickness = 20.0 + rand(fi + 1.5) * 20.0;
		float w1 = sin(suv.y * freq1 + wphase1 + t1) * amp1;
		float w2 = sin(suv.y * freq2 + wphase2 + t2) * amp2;
		float w3 = sin(suv.y * freq3 + wphase3 + t3) * amp3;
        float spine = w1 + w2 + w3;

		float dw1 = cos(suv.y * freq1 + wphase1 + t1) * amp1 * freq1;
		float dw2 = cos(suv.y * freq2 + wphase2 + t2) * amp2 * freq2;
		float dw3 = cos(suv.y * freq3 + wphase3 + t3) * amp3 * freq3;
        float dspine = dw1 + dw2 + dw3;

        float dist = (suv.x - spine) / sqrt(1.0 + dspine * dspine);

        float spike = exp(-dist * dist * thickness);

		float outer    = step(0.15, spike);
        float rim_band = 1.0 - smoothstep(0.15, 1.1, spike);

        float shadow = smoothstep(0.0, 0.15, spike) * (1.0 - outer);

        vec3 strand_col = vec3(0.5, 0.5, 0.5);
        strand_col = mix(strand_col, vec3(1.0, 1.0, 1.0), rim_band);

        col = mix(col, col * 0.667, shadow);
        col = mix(col, strand_col, outer);
    }

    col.r -= rand(uv.x) * 0.04;
    col = clamp(col, 0.0, 1.0);
	
	col *= colour.rgb;

    return vec4(col, colour.a);
}