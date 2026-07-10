-- Menu

if math.random(1, 70) == 70 then
	SMODS.Atlas({
	    key = "titlecard",
		path = "mehm_titlecard.png",
	    px = 197,
	    py = 43,
	})
else
	SMODS.Atlas({
	    key = "titlecard",
		path = "may_titlecard.png",
	    px = 197,
	    py = 43,
	})
end

-- Used to contain buggy SMODS versions, minimum SMODS required for Mayhem has increased however so no point in keeping older versions
may.unstable_smods = {
}

local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	if change_context ~= "splash" then
		for _, v in pairs({
		    'mdc_chip', 'MDCchip_mod', 
		    'mdc_mult', 'MDCmult_mod', 
		    'fact_mult', 'FACTmult_mod', 
		    'fact_chip', 'FACTchip_mod', 
		    'expofact_mult', 'EXPOFACTmult_mod', 
		    'expofact_chip', 'EXPOFACTchip_mod',
		    'score', 'score_mod',
		    'x_score', 'Xscore_mod',
		    'e_score', 'Escore_mod',
		    'ee_score', 'EEscore_mod',
		    'eee_score', 'EEEscore_mod',
		    'hyper_score',
		    'eq_mult', 'EQmult_mod',
		    'eq_chips', 'EQchip_mod',
		    'eq_score', 'EQSCORE_mod',
		    'eq_dollars',
		    'x_dollars', 'xdollars_mod',
		    'super_level_up'
	    }) do
		    table.insert(SMODS.calculation_keys, v)
	    end
	end
	local ret = oldfunc(change_context)
	if may.conf.custom_menu then 
		G.SPLASH_BACK:define_draw_steps({{
		    shader = "splash",
			send = {
				{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
				{ name = "vort_speed", val = 0.4 },
				{ name = "colour_1", ref_table = SMODS.Gradients, ref_value = "may_col_mayhem_gradient" },
				{ name = "colour_2", ref_table = G.C, ref_value = 'BLACK' },
			},
		}})
		-- Add mod logo 
		-- Code mostly taken from Maximus
		G.may_titlecard = Sprite(0, 0, 6.6, 6.6 * (G.ASSET_ATLAS["may_titlecard"].py / G.ASSET_ATLAS["may_titlecard"].px), G.ASSET_ATLAS["may_titlecard"], { x = 0, y = 0 })
		G.may_titlecard:set_alignment({major = G.title_top, type = 'cm', bond = 'Strong', offset = { x = 5, y = 3.5 }})
		G.may_titlecard:define_draw_steps({{shader = 'dissolve'}})
		G.may_titlecard.tilt_var = { mx = 0.2, my = 0, dx = 0, dy = 0, amt = 0.1 }
		G.may_titlecard.dissolve_colours = { SMODS.Gradients.may_col_mayhem_gradient, G.C.BLACK }
		G.may_titlecard.dissolve = 1
		G.may_titlecard.states.collide.can = true
		function G.may_titlecard:click()
			G.may_titlecard:juice_up(0.05, 0.03)
			play_sound('button', 1, 0.3)
			play_sound('cardFan2', 1, 0.35)
            G.FUNCS['openModUI_mayhem']()
		end
		function G.may_titlecard:hover()
			G.may_titlecard:juice_up(0.05, 0.03)
			play_sound('paper1', 1, 0.5)
			if math.random(1, 300) == 1 then
				play_sound('may_ah_yes_the_store')
			end
			Node.hover(self)
		end
		function G.may_titlecard:stop_hover() 
            Node.stop_hover(self)
            G.may_titlecard:juice_up(0.025, 0.015) 
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1, blockable = false, blocking = false, func = function()
			play_sound('magic_crumple' .. (change_context == 'splash' and 2 or 3), (change_context == 'splash' and 1 or 1.3), 0.9)
			play_sound('whoosh1', 0.2, 0.8)
			ease_value(G.may_titlecard, 'dissolve', -1, nil, nil, nil, change_context == 'splash' and 2.3 or 0.9)
			G.ROOM.jiggle = G.ROOM.jiggle + 0.1
            G.may_titlecard:juice_up(0.05, 0.1)
		return true end}))
		
		-- Add particles to main menu
        G.menu_particles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, SMODS.Gradients.may_col_mayhem_gradient },
            fill = true
        })
        G.menu_particles.fade_alpha = 0.7
        G.menu_particles:fade(0.7, 0)
		
		-- Display Mayhem version on title screen
		if may.conf.show_version then
		    UIBox({
                definition = {n = G.UIT.ROOT, config = { align = "cm", colour = SMODS.Gradients.may_col_mayhem_gradient_dark2 }, nodes = 
					{{n = G.UIT.T, config = { scale = 0.3, text = "Mayhem "..may.version, colour = G.C.UI.TEXT_LIGHT}}
                }},
                config = { align = "tri", bond = "Weak", offset = { x = 0, y = 0.58 }, major = G.ROOM_ATTACH }
            })
		end
	end
	-- Welcome message 
	if not may.conf.notices.welcome then
		may.display_welcome_notification()
		may.conf.notices.welcome = true 
		G:save_settings()
    end 
	-- Slay the Jokers notice
	if (not may.conf.notices.stj) and #SMODS.find_mod('SlayTheJokers') ~= 0 then
		may.display_notification('slaythejokers', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.stj = true 
		G:save_settings()
    end
	-- Talisman notice
	if (not may.conf.notices.talisman) and not Talisman.cdataman then
		may.display_notification('talisman', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.talisman = true 
		G:save_settings()
    end
	-- Cryptid notice
	if (not may.conf.notices.cry) and #SMODS.find_mod('Cryptid') ~= 0 then
		may.display_notification('cryptid', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.cry = true 
		G:save_settings()
    end
	-- Overflow notice
	if (not may.conf.notices.overflow) and Noituus.OverflowInstalled then
		may.display_notification('overflow', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.overflow = true 
		G:save_settings()
    end 
	-- Unstable SMODS notice
	if table_hasvalue(may.unstable_smods, SMODS.version) then
		may.display_notification('smods', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
    end 
	--[[ Config notice 
	if not may.conf.notices.config then
		may.display_notification('config', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.config = true 
		G:save_settings()
    end]] 
	return ret
end

may.menu_cards = {
	'j_may_mr_nacho',
	'j_may_doggo',
	'j_may_jonas',
	'j_may_man',
	'j_may_lil_prince',
	'j_may_ah_yes_the_store',
	'j_may_diskus_distruktum',
	'j_may_kids_drawing',
	'j_may_as_ultimatum', 
	--'j_may_fortuno',
    'j_may_alex343xd', 
    'j_may_astro', 
    --'j_may_ad_infinitum', 
    'j_may_party_time', 
    'j_may_world_destroyer',
	'j_may_guacamole',
	'j_may_omniversal_catalyst',
	'j_may_anniversary_cake',
	
	--'c_may_kivaaritehdas',
    --'c_may_matakka', 
    --'c_may_stos', 
	--'c_may_prestige',
	'c_may_moon', 
    'c_may_dysnomia', 
	'c_may_soul_upsd', 
    'c_may_wheel_of_fortune_upsd', 
    'c_may_potent', 
	'c_may_gray_hole', 
    'c_may_galileo',
	'c_may_gem', 
    'c_may_potestas', 
	'c_may_mult_card', 
	
	'v_may_extended_selection', 
	'v_may_increment', 
	'v_may_booster_surplus', 
    'v_may_card_merchant', 
    'v_may_transcend_1', 
	'v_may_endless_mode'
}

may.menu_editions = {
	'e_may_dichromatic',
	'e_may_amber', 
	'e_may_cosmic', 
	'e_may_radioactive', 
	'e_may_neon',
	'e_may_alloy', 
	'e_may_laminated', 
	'e_may_hypnotic', 
	'e_may_twilight', 
} 

if may.conf.custom_menu then
	local chosen = may.menu_cards[math.random(1, #may.menu_cards)]
	SMODS.current_mod.menu_cards = function()
		return {
			{ key = chosen },
			func = function()
				for k, v in pairs(G.title_top.cards) do
					if v:gc().key == chosen then
							v:set_ability(G.P_CENTERS[may.menu_cards[math.random(1, #may.menu_cards)]])
							v:resize(1.32)
							v:set_edition(may.menu_editions[math.random(1, #may.menu_editions)], false, false)
						break
					end
				end
			end
		}
	end
end