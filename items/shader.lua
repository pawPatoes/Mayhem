-- Shaders

may.shaders = {
	shimmering = 'edition/shimmering.fs', 
	amber = 'edition/amber.fs', 
	omega = 'edition/omega.fs', 
	nostalgic = 'edition/nostalgic.fs',
	otherworldly = 'edition/otherworldly.fs',
	cosmic = 'edition/cosmic.fs',
	print = 'edition/print.fs',
	goldfoil = 'edition/goldfoil.fs',
	misprint = 'edition/misprint.fs',
	radioactive = 'edition/radioactive.fs',
	bitcrush = 'edition/bitcrush.fs',
	neon = 'edition/neon.fs',
	magenta = 'edition/magenta.fs', 
	alloy = 'edition/alloy.fs',
	inverted = 'edition/inverted.fs', 
	dichromatic = 'edition/dichromatic.fs',
	laminated = 'edition/laminated.fs', 
	twilight = 'edition/twilight.fs',
	ionized = 'edition/ionized.fs', 
	hypnotic = 'edition/hypnotic.fs',
	kaleidoscopic = 'edition/kaleidoscopic.fs', 
	sharpened = 'edition/sharpened.fs', 
	light = 'edition/light.fs', 
	metallic = 'edition/metallic.fs', 
	vignette = 'edition/vignette.fs', 
	
	transcendent = 'rarity/transcendent.fs',
	
	transcendent_bg = 'rarity/bg/transcendent_bg.fs', 
	paradoxical_bg = 'rarity/bg/paradoxical_bg.fs', 
	opalescent_bg = 'rarity/bg/opalescent_bg.fs', 
	demiurgic_bg = 'rarity/bg/demiurgic_bg.fs', 
	prismatic_bg = 'rarity/bg/prismatic_bg.fs', 
	ethereal_bg = 'rarity/bg/ethereal_bg.fs', 
	mythic_bg = 'rarity/bg/mythic_bg.fs', 
	
	paradoxical_text = 'rarity/text/paradoxical_text.fs', 
	alpha_effect = 'rarity/misc/alpha_effect.fs', 
	
	semihologram = 'semihologram.fs', 
}

for k, v in pairs(may.shaders) do
	SMODS.Shader {
		key = k, 
		path = v
	} 
end

-- Screen Shaders

SMODS.Shader({
    key = 'blind_colour',
    path = 'blind/sprite/blind_colour.fs',
    send_vars = function(self)
        return { 
            target_colour = may.get_transcendence_color(may.transcendence or 0) or G.C.DARK_EDITION,
            progress_colour = G.C.MAY_TINT_PROGRESS,
        }
    end
}) 

SMODS.ScreenShader({
    key = 'transcendence_crt',
    path = 'screen/transcendence_crt.fs',
    should_apply = function()
        return G.GAME and G.GAME.blind and (may.transcendence or 0) > 0 and may.conf.TrEffects >= 3 and may.should_do_transcendence()
    end,
    send_vars = function(self)
        return {
            glitch_intensity = transcendence_glitch or 0,
            noise_fac = transcendence_noise or 0, 
            bloom_fac = transcendence_bloom or 0,
            crt_intensity = transcendence_crt or 0, 
            bloom_intensity = transcendence_bloom_intensity or 1,
            bloom_distance = transcendence_bloom_distance or 0.01,
            bloom_amount = transcendence_bloom_amount or 3,
            ca_intensity = transcendence_ca_intensity or 1,
            ca_distance = transcendence_ca_distance or 0.0005,
            
            distortion_fac = {1, 1}, 
            scale_fac = {1, 1}, 
            feather_fac = 0.01, 
            time = 400 + G.TIMERS.REAL,
            scanlines = G.CANVAS:getPixelHeight() * 0.75 / G.CANV_SCALE,
            mouse_screen_pos = G.video_control and {love.graphics.getWidth() / 2, love.graphics.getHeight() / 2} or {G.ARGS.eased_cursor_pos.sx, G.ARGS.eased_cursor_pos.sy},
            screen_scale = G.TILESCALE * G.TILESIZE,
            hovering = 1
        }
    end
})