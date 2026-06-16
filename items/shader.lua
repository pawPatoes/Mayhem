-- Edition Shaders

SMODS.Shader({key = 'shimmering', path = 'edition/shimmering.fs'})
SMODS.Shader({key = 'amber', path = 'edition/amber.fs'})
SMODS.Shader({key = 'omega', path = 'edition/omega.fs'})
SMODS.Shader({key = 'nostalgic', path = 'edition/nostalgic.fs'})
SMODS.Shader({key = 'otherworldly', path = 'edition/otherworldly.fs'})
SMODS.Shader({key = 'cosmic', path = 'edition/cosmic.fs'})
SMODS.Shader({key = 'print', path = 'edition/print.fs'})
SMODS.Shader({key = 'goldfoil', path = 'edition/goldfoil.fs'})
SMODS.Shader({key = 'misprint', path = 'edition/misprint.fs'})
SMODS.Shader({key = 'radioactive', path = 'edition/radioactive.fs'})
SMODS.Shader({key = 'bitcrush', path = 'edition/bitcrush.fs'})
SMODS.Shader({key = 'neon', path = 'edition/neon.fs'})
SMODS.Shader({key = 'magenta', path = 'edition/magenta.fs'})
SMODS.Shader({key = 'alloy', path = 'edition/alloy.fs'})
SMODS.Shader({key = 'inverted', path = 'edition/inverted.fs'})
SMODS.Shader({key = 'dichromatic', path = 'edition/dichromatic.fs'})
SMODS.Shader({key = 'laminated', path = 'edition/laminated.fs'})
SMODS.Shader({key = 'twilight', path = 'edition/twilight.fs'})
SMODS.Shader({key = 'ionized', path = 'edition/ionized.fs'})
SMODS.Shader({key = 'hypnotic', path = 'edition/hypnotic.fs'})
SMODS.Shader({key = 'kaleidoscopic', path = 'edition/kaleidoscopic.fs'})
SMODS.Shader({key = 'sharpened', path = 'edition/sharpened.fs'})
SMODS.Shader({key = 'light', path = 'edition/light.fs'})
SMODS.Shader({key = 'metallic', path = 'edition/metallic.fs'})

-- Screen Shaders

SMODS.ScreenShader({
	key = 'transcendence_crt',
	path = 'screen/transcendence_crt.fs',
	should_apply = function()
		return G.GAME and G.GAME.blind and (may.transcendence or 0) > 0 and may.conf.TrEffects >= 3
	end,
	send_vars = function(self)
		return {
		    glitch_intensity = transcendence_glitch or 0,
			noise_fac = transcendence_noise or 0, 
			bloom_fac = transcendence_bloom or 0,
			crt_intensity = transcendence_crt or 0, 
			
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

-- Other Shaders

SMODS.Shader({key = 'semihologram', path = 'semihologram.fs'}) 