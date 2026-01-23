-- Menu

if may.conf.Mode == 1 then
	SMODS.Atlas({
		key = "titlecard",
		path = "may_titlecard.png",
		px = 197,
		py = 43,
	})
else
	SMODS.Atlas({
		key = "titlecard",
		path = "etm_titlecard.png",
		px = 204,
		py = 43,
	})
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
	'j_may_spadus', 
	'j_may_universal_collapse',
	'j_may_fortuno',
    'j_may_doomsday_device', 
    'j_may_artso', 
    'j_may_ad_infinitum', 
    'j_may_party_time', 
    'j_may_world_destroyer',
	'j_may_guacamole',
	'j_may_universal_collapse',
	
	'c_may_kivaaritehdas',
    'c_may_matakka', 
    'c_may_stos', 
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
	
	'v_may_extended_selection', 
	'v_may_increment', 
	'v_may_booster_surplus', 
    'v_may_card_merchant', 
    'v_may_transcend_1', 
}

may.menu_editions = {'e_may_dichromatic', 'e_may_amber', 'e_may_cosmic', 'e_may_radioactive', 'e_may_neon', 'e_may_alloy', 'e_may_laminated'}
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
		-- Create pools 
		G.E_MANAGER:add_event(Event({func = function()
			G.P_CENTER_POOLS.HandSpecific = G.P_CENTER_POOLS.HandSpecific or {}
			G.P_CENTER_POOLS.Food = G.P_CENTER_POOLS.Food or {}
			SMODS.ObjectTypes.Food = { default = 'j_ice_cream' }
			SMODS.ObjectTypes.HandSpecific = { default = 'c_pluto' }
			for k, v in pairs(G.P_CENTERS) do
				if v.pools then 
					for k2, v2 in pairs(v.pools) do
						if not G.P_CENTER_POOLS[v2] then G.P_CENTER_POOLS[v2] = {} end
						table.insert(G.P_CENTER_POOLS[v2], v)
					end
				end
				if may.is_pool_center(v, 'HandSpecific') then
					table.insert(G.P_CENTER_POOLS.HandSpecific, v)
				end
				if may.is_pool_center(v, 'Food') then
					table.insert(G.P_CENTER_POOLS.Food, v)
				end
			end
		return true end}))
	end
	local ret = oldfunc(change_context)
	if may.conf.Menu then 
		G.SPLASH_BACK:define_draw_steps({{
		    shader = "splash",
			send = {
				{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
				{ name = "vort_speed", val = 0.4 },
				{ name = "colour_1", ref_table = SMODS.Gradients, ref_value = may.conf.Mode == 1 and "may_col_mayhem_gradient" or "may_col_eternum_green" },
				{ name = "colour_2", ref_table = G.C, ref_value = "BLACK" },
			},
		}})
		-- Add mod logo 
		-- Code mostly taken from Maximus
		G.may_titlecard = Sprite(0, 0, 6.6, 6.6 * (G.ASSET_ATLAS["may_titlecard"].py / G.ASSET_ATLAS["may_titlecard"].px), G.ASSET_ATLAS["may_titlecard"], { x = 0, y = 0 })
		G.may_titlecard:set_alignment({major = G.title_top, type = 'cm', bond = 'Strong', offset = { x = 5, y = 3.5 }})
		G.may_titlecard:define_draw_steps({{shader = 'dissolve'}})
		G.may_titlecard.tilt_var = { mx = 0.2, my = 0, dx = 0, dy = 0, amt = 0.1 }
		G.may_titlecard.dissolve_colours = { SMODS.Gradients[may.conf.Mode == 1 and 'may_col_mayhem_gradient' or 'may_col_eternum_green'], G.C.BLACK}
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
		
		-- Add random card to the main menu
        local chosen = math.random(1, #may.menu_cards)
        local newcard = create_card(G.P_CENTERS[may.menu_cards[chosen]], G.title_top, nil, nil, nil, nil, may.menu_cards[chosen], 'may_title_card')
        G.title_top:emplace(newcard)
        newcard:start_materialize()
        newcard:resize(1.32)
        newcard.no_ui = true
        newcard.ability.title_card = true
        -- Recenter the title
        G.title_top.T.w = G.title_top.T.w * 1.7675
        G.title_top.T.x = G.title_top.T.x - 0.8
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, blockable = false, blocking = false, func = function()
            if change_context == "splash" then
                newcard.states.visible = true
                newcard:start_materialize({ G.C.BLACK, G.C.RARITY['may_ethereal'] }, true, 2.5)
            else
                newcard.states.visible = true
                newcard:start_materialize({ G.C.BLACK, G.C.RARITY['may_ethereal'] }, nil, 1.2)
            end
            newcard:set_edition(may.menu_editions[math.random(1, #may.menu_editions)], false, false)
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
            colours = { G.C.BLACK, SMODS.Gradients[may.conf.Mode == 1 and "may_col_mayhem_gradient" or "may_col_eternum_green"] },
            fill = true
        })
        G.menu_particles.fade_alpha = 0.7
        G.menu_particles:fade(0.7, 0)
		
		-- Display Mayhem version on title screen
		if may.conf.show_version then
		    UIBox({
                definition = {n = G.UIT.ROOT, config = { align = "cm", colour = SMODS.Gradients[may.conf.Mode == 1 and "may_col_mayhem_gradient_dark2" or "may_col_eternum_green_dark2"] }, nodes = 
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
	-- Amulet notice
	if (not may.conf.notices.amulet) and Talisman.cdataman then
		may.display_notification('amulet', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.amulet = true 
		G:save_settings()
    end
	-- Cryptid notice
	if (not may.conf.notices.cry) and #SMODS.find_mod('Cryptid') ~= 0 then
		may.display_notification('cry', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.cry = true 
		G:save_settings()
   end
	-- Unstable SMODS notice
	if (not may.conf.notices.smods) and SMODS.version == "1.0.0~BETA-1221a" then
		may.display_notification('smods', function() play_sound("foil1", 0.7, 0.3); play_sound("gong", 1.4, 0.15) end)
		may.conf.notices.smods = true 
		G:save_settings()
    end 
	return ret
end