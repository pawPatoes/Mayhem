if not (Big and Big.arrow) then
	error('!! OMEGANUM NOT ENABLED. PLEASE REMOVE MAYHEM FROM YOUR MODS FOLDER, SET TALISMAN TO OMEGANUM AND MOVE MAYHEM BACK.')
end

SMODS.optional_features.quantum_enhancements = true

-- Handy values for the mod
-- You can use the stuff here for cross-mod content (if you like this mod for some reason)
may = {}

-- Config
-- global for convenience and cross-mod whatevers
may.conf = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
	return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.BLACK}, nodes={
		{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = "Settings", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
				}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = "Most settings need you to restart the game to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.2, padding = .2}},
				}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Mode",
					scale = 1.4,
					w = 6,
					options = {"Mayhem (Classic)", "Eternum"},
					opt_callback = 'may_upd_mode',
					current_option = may.conf.Mode,
                })
			}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Number Limit",
					scale = 1,
					w = 10,
					options = {"e10##4000 (MINIMUM)", "e10##100000", "e10##1073741824", "e10##9007199254740991"},
					opt_callback = 'may_upd_limit',
					current_option = may.conf.Limit,
                })
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Safe Mode', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Safe" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Custom Menu', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Menu" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Debug Mode', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Debug" },
				}},
			}},
        }}
	}}
end

G.FUNCS.may_conf_restart = function(e)
	SMODS.restart_game()
end

G.FUNCS.may_upd_mode = function(e)
	may.conf.Mode = e.to_key
end

G.FUNCS.may_upd_treffects = function(e)
	may.conf.TrEffects = e.to_key
end

G.FUNCS.may_upd_scaling = function(e)
	may.conf.Scaling = e.to_key
end 

G.FUNCS.may_upd_limit = function(e)
	may.conf.Limit = e.to_key
end

G.FUNCS.may_upd_music = function(e)
	may.conf.Music = e.to_key
end

SMODS.current_mod.extra_tabs = function()
	return {
			{
				label = 'Cross-mod',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Mayhem enables unique content if you're also playing with certain mods.", colour = G.C.UI.TEXT_LIGHT, scale = 0.3}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Cryptid', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.CM, ref_value = "Cryptid" },
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Grim', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.CM, ref_value = "Grim" },
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Blind Editions', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.CM, ref_value = "BlindEditions" },
								}},
							}},
						}}
					}}
			end,
			},
			{
				label = 'Effects',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_option_cycle({
									label = "Transcendence Effects",
									scale = 1,
									w = 10,
									options = {"Disabled", "Low", "Medium", "High"},
									opt_callback = 'may_upd_treffects',
									current_option = may.conf.TrEffects,
								})
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Window Shake', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "WindowShake" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_slider({
									label = "Score Shakiness: Pulse Limit",
									label_scale = 0.4,
									text_scale = 0.3,
									ref_table = may.conf.Shakiness,
									ref_value = "pulselimit",
									min = 0,
									max = 25,
								}),
								create_slider({
									label = "Score Shakiness: Quiver Limit",
									label_scale = 0.4,
									text_scale = 0.3,
									ref_table = may.conf.Shakiness,
									ref_value = "quiverlimit",
									min = 0,
									max = 25,
								}),
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Unlimit Pulse', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.Shakiness, ref_value = "unlimitpulse" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Unlimit Quiver', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.Shakiness, ref_value = "unlimitquiver" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Shake Screen', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.Shakiness, ref_value = "shake_screen" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Shake Cards during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrShakeCards" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Shake Screen during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrShakeScreen" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Misc. Joker Effects', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "JokerEffects" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Mass Use Ambiance (Incantation)', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "massuse" },
								}},
							}},
						}}
					}}
			end,
			},
			{
				label = 'Content',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'WIP Features', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.9, w = 0, shadow = true, ref_table = may.conf, ref_value = "WIP" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Normal Jokers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Jokers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Fusion Jokers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "FusionJokers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Consumables', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Consumables" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Vouchers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Vouchers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Booster Packs', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Boosters" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Enhancements', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Enhancements" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Editions', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Editions" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Blinds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "Blinds" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'UltraBlinds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.content, ref_value = "UltraBlinds" },
								}},
							}},
						}}
					}}
				end,
			},
			{
				label = 'Music and SFX',
				tab_definition_function = function()
				return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
							create_option_cycle({
								label = "Menu Music",
								scale = 1,
								w = 6,
								options = {"Auto", "Mayhem Theme", "Eternum Theme", "Yotta Card", "UltraBlind", "HyperAscendant Joker", "Edition Card Pack", "Party Time", "Default"},
								opt_callback = 'may_upd_music',
								current_option = may.conf.Music,
							})
						}},
						{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							create_slider({
								label = "Transcendence Volume",
								label_scale = 0.4,
								text_scale = 0.3,
								ref_table = may.conf,
								ref_value = "TrAudio",
								min = 0,
								max = 100,
							}),
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Santa', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Santamusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Party Time', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Partymusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'HyperAscendant Joker', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Hyperascendantmusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Yotta Card', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Yottamusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Edition Card Pack', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Editionmusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'UltraBlind', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Ultrablindmusic" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Custom Hyperoperation Sounds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "CustomHyperoperations" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Tamer Hyperoperation Sounds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TameSounds" },
							}},
						}},
					}}
				}}
			end
		},
	}
end

-- Custom description

SMODS.current_mod.custom_ui = function(self)
	return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
		{n=G.UIT.C, config={}, nodes={
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Enact the most stupid builds you can and watch the big numbers get bigger.', scale = 0.4, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n=G.UIT.R, config={}, nodes={
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.O, config = { object = 'may_spadus' }},
				}},
			}},
		}}
	}}
end

if #SMODS.find_mod('MEOST') ~= 0 then
	print("MAYHEM: Mayhem Extended OST found! MEOST has been deprecated and as such no longer has any functionality.")
end

if #SMODS.find_mod('mayhem_dumpyard') ~= 0 then
	print("MAYHEM: Found module Mayhem Dumpyard.")
end

-- Misc

function generate_arrow_text(arrow, threshold)
	local str = ""
	if arrow < (threshold or 5) then
		for i=1, arrow, 1 do
			str = str .. '^'
		end
	else
		str = '{'..arrow..'}'
	end
	if arrow == 0 then
		str = 'X'
	end
	return str
end

function generate_fact_text(fact, threshold)
	local str = ""
	if fact < (threshold or 10) then
		for i=1, to_number(fact), 1 do
			str = str .. '!'
		end
	else
		str = '!('..fact..')'
	end
	return str
end

function generate_expofact_text(fact, threshold)
	local str = ""
	if fact < (threshold or 10) then
		for i=1, to_number(fact), 1 do
			str = str .. '^!'
		end
	else
		str = '^!('..fact..')'
	end
	return str
end

-- Score Operator
-- Inspired and admitedly frankensteined from POLTERWORX

function get_final_score(chips, mult)
	local retval
	if get_score_operator() >= 0 and to_big(chips or 0) == to_big(0) or to_big(mult or 0) == to_big(0) then
		return 0
	else
		if get_score_operator() >= 0 then
			retval = to_big(chips or 0):arrow(get_score_operator(), to_big(mult or 0))
		else
			if get_score_operator() == -1 then
				retval = to_big(chips or 0) + to_big(mult or 0)
			elseif get_score_operator() == -2 then
				retval = to_big(chips or 0):sub(to_big(mult or 0))
			elseif get_score_operator() == -3 then
				retval = to_big(chips or 0):div(to_big(mult or 0))
			elseif get_score_operator() <= -3 then
				if to_big(mult or 0) == to_big(1) or to_big(chips or 0) == to_big(1) then
					retval = 0
				else
					retval = to_big(chips or 0):logBase(to_big(mult or 0))
				end
			end
		end
	end
	if G then
		if G.GAME then
			if G.GAME.blind then
				if G.GAME.blind.config.blind.key == 'bl_may_half' then
					if G.GAME.blind.config.blind.config.canchange then
						retval = to_big((chips or 0))
					end
				end
			end
		end
	end
	return retval
end

function get_score_operator()
	if not G.GAME then return 0 end
	if not G.GAME.score_operator then G.GAME.score_operator = 0 end
	return G.GAME.score_operator
end

function set_score_operator(mod, silent)
	mod = math.ceil(mod)
	if G and G.GAME and G.GAME.score_operator and math.min(math.max(mod, 0), maxArrow+1) > -4 then 
		G.GAME.score_operator = math.min(math.max(mod, 0), maxArrow+1)
		if not (silent or false) then
			update_score_operator()
		end
	end
end

-- For multiplication, set arrow to 0. For addition, set arrow to -1
function mod_score_operator(arrow, mod, silent)
	mod = math.ceil(mod)
	if G.GAME.score_operator then 
		G.E_MANAGER:add_event(Event({trigger = 'after',func = function()
			if arrow > -1 then
				if not jl.invalid_number(to_number(to_big(G.GAME.score_operator):arrow(arrow, mod))) then
					G.GAME.score_operator = to_number(to_big(G.GAME.score_operator):arrow(arrow, mod))
				else
					if maxArrow < 1e308 then
						G.GAME.score_operator = 1e308
					else
						G.GAME.score_operator = maxArrow
					end
				end
			else
				G.GAME.score_operator = G.GAME.score_operator + mod
				if jl.invalid_number(G.GAME.score_operator) then
					if may.conf.Safe then
						G.GAME.score_operator = 25000
					else
						G.GAME.score_operator = 1e307
					end
				end
				if G.GAME.score_operator > 25000 and may.conf.Safe then
					G.GAME.score_operator = 25000
				end
			end
			if not (silent or false) then
				update_score_operator(nil, false, mod>0)
			end
		return true end}))
	end
end

function update_score_operator(sound, no_effects, increase)
	local operator = get_score_operator()
	local text = generate_arrow_text(operator, 5)
	local col = G.C.WHITE
	if operator > 3 then
		if operator < 100 then
			col = SMODS.Gradients.may_col_big_operator
		else
			col = SMODS.Gradients.may_col_huge_operator
		end
	else
		if operator > 0 then
			text = generate_arrow_text(operator)
			if operator == 1 then
				col = SMODS.Gradients.may_eternum_green
			elseif operator == 2 then
				col = SMODS.Gradients.may_col_interdimensional
			elseif operator == 3 then
				col = SMODS.Gradients.may_col_ethereal
			end
		else
			if operator == 0 then
				text = 'X'
				col = G.C.UI_MULT
			elseif operator == -1 then
				text = '+'
				col = G.C.UI_CHIPS
			elseif operator == -2 then
				text = '-'
				col = SMODS.Gradients.may_mayhem_gradient
			elseif operator == -3 then
				text = '/'
				col = G.C.UI.BACKGROUND_INACTIVE
			elseif operator <= -3 then
				text = 'log'
				col = G.C.L_BLACK
			end
		end
	end
	G.E_MANAGER:add_event(Event({trigger = 'after',func = function()
		if not no_effects then
			if sound then
				play_sound(sound)
			else
				if increase == true or increase == nil then
					play_sound(sound or 'may_e_techno')
				else
					play_sound(sound or 'may_decrease_operator')
				end
			end
		end
		G.hand_text_area.chipmult_op:update()
		G.hand_text_area.chipmult_op.config.text = text
		G.hand_text_area.chipmult_op.config.text_drawable:set(text)
		G.hand_text_area.chipmult_op.UIBox:recalculate()
		G.hand_text_area.chipmult_op.config.colour = col
		-- Yggdrasil stuff
		local scale = 0.8
		if Yggdrasil then
			scale = 0.4
		end
		if operator < 4 and operator >= 0 then
			G.hand_text_area.chipmult_op.config.scale = scale-(operator/20)
		else
			if operator > 4 then
				G.hand_text_area.chipmult_op.config.scale = scale-(string.len(text)/50)
			else
				G.hand_text_area.chipmult_op.config.scale = scale
			end
		end
		if not no_effects then
			G.hand_text_area.chipmult_op:juice_up(0.8, 0.5)
		end
	return true end}))
end

-- PTA "fix"
if PTASaka then
	function PTASaka.recalc_chips_mult_shit(str, op)
		mod_score_operator(-1, str, false)
	end
	
	SMODS.Joker:take_ownership('j_payasaka_paya', {
	calculate = function(self, card, context)
		if context.setting_blind and ((pseudorandom('paya_hell') < (G.GAME.probabilities.normal or 1) / card.ability.odds) or card.ability.cry_rigged) then
			card.ability.extra.exponential_cnt = card.ability.extra.exponential_cnt + 1
			G.E_MANAGER:add_event(Event{func = function()
				mod_score_operator(-1, card.ability.extra.exponential_cnt, false)
			return true end })
			return {
				message = card.ability.extra.exponential_cnt == 1 and localize('k_active_ex') or localize('k_payasaka_hyperactive_ex'),
				colour = card.ability.extra.exponential_cnt == 1 and G.C.GOLD or G.C.DARK_EDITION,
				card = context.blueprint_card or card
			}
		end
		while context.end_of_round and card.ability.extra.exponential_cnt > 0 and not context.individual do
			card.ability.extra.exponential_cnt = card.ability.extra.exponential_cnt - 1
			G.E_MANAGER:add_event(Event{func = function()
				mod_score_operator(-1, card.ability.extra.exponential_cnt, false)
			return true end})
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_payasaka_inactive_ex') })
		end
	end
})
end

function change_blind_size(arrow, mod)
	mod = to_big(mod)
	if arrow >= 0 then
		G.GAME.starting_params.ante_scaling = to_big(G.GAME.starting_params.ante_scaling):arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.starting_params.ante_scaling = to_big(G.GAME.starting_params.ante_scaling) + mod
		elseif arrow == -2 then
			G.GAME.starting_params.ante_scaling = to_big(G.GAME.starting_params.ante_scaling) - mod
		elseif arrow == -3 then
			G.GAME.starting_params.ante_scaling = to_big(G.GAME.starting_params.ante_scaling) / mod
		end
	end
	local blind_chips = G.HUD:get_UIE_by_ID('chip_UI_count')
	if blind_chips then
		blind_chips:update()
	end
	G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
		local text = ''
		if arrow >= 1 then
			text = generate_arrow_text(arrow, 4)
		elseif arrow == 0  then
			text = 'X'
		elseif arrow == -1 then
			text = '+'
		elseif arrow == -2 then
			text = '-'
		elseif arrow <= -3 then
			text = '/'
		end
		local col = G.C.IMPORTANT
		attention_text({
			text = text..(to_number(mod) or 0),
			scale = 1, 
			hold = 1,
			cover = blind_chips,
			cover_colour = col,
			align = 'cm',
		})
		play_sound('highlight2', 0.715, 0.2)
		play_sound('generic1')
	return true end}))
end

function hand_mod_lvl_multchips(hand, multchips, arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult)
	G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips)
	if arrow >= 0 then
		if multchips == 'mult' then
			G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:arrow(arrow, mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:arrow(arrow, mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:arrow(arrow, mod)
			G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:arrow(arrow, mod)
		end
	else
		if arrow == -1 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:add(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:add(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:add(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:add(mod)
			end
		elseif arrow == -2 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:sub(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:sub(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:sub(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:sub(mod)
			end
		elseif arrow == -3 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:div(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:div(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:div(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:div(mod)
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = hand..' '
			if arrow >= 1 then
				text = text..generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			local col 
			if multchips == 'mult' then
				col = G.C.MULT
			elseif	multchips == 'chips' then
				col = G.C.CHIPS
			elseif	multchips == 'multchips' then
				col = G.C.PURPLE
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('may_lvl_multchips')
			play_sound('generic1')
		return true end}))
	end
end

function hand_mod_lvl_multchips_all(multchips, arrow, mod)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		v.l_mult = to_big(v.l_mult)
		v.l_chips = to_big(v.l_chips)
	end
	if arrow >= 0 then
		if multchips == 'mult' then
			for k, v in pairs(G.GAME.hands) do
				v.l_mult = v.l_mult:arrow(arrow, mod)
			end
		elseif multchips == 'chips' then
			for k, v in pairs(G.GAME.hands) do
				v.l_chips = v.l_chips:arrow(arrow, mod)
			end
		elseif multchips == 'multchips' then
			for k, v in pairs(G.GAME.hands) do
				v.l_mult = v.l_mult:arrow(arrow, mod)
				v.l_chips = v.l_chips:arrow(arrow, mod)
			end
		end
	else
		if arrow == -1 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:add(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:add(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:add(mod)
					v.l_chips = v.l_chips:add(mod)
				end
			end
		elseif arrow == -2 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:sub(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:sub(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:sub(mod)
					v.l_chips = v.l_chips:sub(mod)
				end
			end
		elseif arrow == -3 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:div(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:div(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:div(mod)
					v.l_chips = v.l_chips:div(mod)
				end
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = 'All Hands '
			if arrow >= 1 then
				text = text..generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			local col 
			if multchips == 'mult' then
				col = G.C.MULT
			elseif	multchips == 'chips' then
				col = G.C.CHIPS
			elseif	multchips == 'multchips' then
				col = G.C.PURPLE
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('may_lvl_multchips')
			play_sound('generic1')
		return true end}))
	end
end

	-- Omeganum limits

if may.conf.Limit == 1 then
	maxArrow = 4000
elseif may.conf.Limit == 2 then
	maxArrow = 1e5
elseif may.conf.Limit == 3 then
	maxArrow = 1073741824
elseif may.conf.Limit == 4 then
	maxArrow = 9007199254740991
end

-- Consumable variants
-- code mostly taken from POLTERWORX
-- you will need to copy this and replace may_ with your mod prefix if you add empowered consumables

may.upsd_rate = 80

may.can_be_upsd = {
	'mercury',
	'venus',
	'earth',
	'mars',
	'jupiter',
	'saturn',
	'uranus',
	'neptune',
	'pluto',
	'planet_x',
	'ceres',
	'eris',
	'may_proxima_centauri',
	
	'familiar',
	'grim', 
	'incantation',
	'talisman',
	'aura',
	'wraith',
	'sigil',
	'ouija',
	'ectoplasm',
	'immolate',
	'ankh',
	'deja_vu',
	'hex',
	'trance',
	'medium',
	'cryptid',
	'soul',
	'black_hole'
}

if may.conf.content.WIP then

may.empower = {}

may.empower.tiers = {'asc', 'pan', 'unw', 'won', 'eps'}

may.empower.can_be_empowered = {
	'fool',
	'magician',
	'high_priestess',
	'empress',
	'hermit',
	
	'pluto',
	
	'familiar',
	
	'may_planetae', 
	'may_cupiditas',
	'may_potestas',
}

end

local ccr = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if G.STAGE ~= G.STAGES.MAIN_MENU and card.gc and card:gc() then
		if not G.GAME.may_asc_rate then
			G.GAME.may_asc_rate = 30
		end
		if not G.GAME.may_pan_rate then
			G.GAME.may_pan_rate = 120
		end
		if not G.GAME.may_unw_rate then
			G.GAME.may_unw_rate = 400
		end
		if not G.GAME.may_won_rate then
			G.GAME.may_won_rate = 1000
		end
		if not G.GAME.may_eps_rate then
			G.GAME.may_eps_rate = 5000
		end
		if not G.GAME.may_upsd_rate then
			G.GAME.may_upsd_rate = 70
		end
		-- Empowered
		if may.conf.content.WIP then
			if G.GAME.selected_back.effect.center.original_key ~= 'celestial_hierarchy_deck' then
				for k, v in pairs(may.empower.can_be_empowered) do
					-- Epsilon
					if pseudorandom('spawn_empowered') < 1 / G.GAME.may_eps_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_eps'] and not G.GAME.banned_keys['c_may_'..v.. '_eps'] then
						-- not using G.GAME.probabilities.normal because making empowered consumables more common with OA6s would be silly
						G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
							if card then
								card:set_ability(G.P_CENTERS['c_may_'..v..'_eps'])
								card:set_cost()
								play_sound('may_c_epsilon', 1, 1.5)
								card:juice_up(1, 1)
							end
						return true end}))
						break
					-- Wondrous
					elseif pseudorandom('spawn_empowered') < 1 / G.GAME.may_won_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_won'] and not G.GAME.banned_keys['c_may_'..v.. '_won'] then
						G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
							if card then
								card:set_ability(G.P_CENTERS['c_may_'..v..'_won'])
								card:set_cost()
								play_sound('may_c_wondrous', 1, 2.5)
								card:juice_up(1, 1)
							end
						return true end}))
						break
					-- Unworldly
					elseif pseudorandom('spawn_empowered') < 1 / G.GAME.may_unw_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_unw'] and not G.GAME.banned_keys['c_may_'..v.. '_unw'] then
						G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
							if card then
								card:set_ability(G.P_CENTERS['c_may_'..v..'_unw'])
								card:set_cost()
								play_sound('may_c_unworldly', 1, 1.5)
								card:juice_up(1, 1)
							end
						return true end}))
						break
					-- Pandimentional
					elseif pseudorandom('spawn_empowered') < 1 / G.GAME.may_pan_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_pan'] and not G.GAME.banned_keys['c_may_'..v.. '_pan'] then
						G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
							if card then
								card:set_ability(G.P_CENTERS['c_may_'..v..'_pan'])
								card:set_cost()
								play_sound('may_c_pandimentional', 1, 1.5)
								card:juice_up(1, 1)
							end
						return true end}))
						break
					-- Ascended
					elseif pseudorandom('spawn_empowered') < 1 / G.GAME.may_asc_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_asc'] and not G.GAME.banned_keys['c_may_'..v.. '_asc'] then
						G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
							if card then
								card:set_ability(G.P_CENTERS['c_may_'..v..'_asc'])
								card:set_cost()
								if card:gc().set ~= 'yottacards' then
									play_sound('may_c_ascended', 1, 1.5)
									card:juice_up(1, 1)
								else
									play_sound('may_ascended_yotta')
									card:juice_up(2, 2)
									G.ROOM.jiggle = G.ROOM.jiggle + 0.7
								end
							end
						return true end}))
						break
					end
				end
			else
				-- Celestial Hierarchy deck doodads
				for k, v in pairs(may.empower.can_be_empowered) do
					-- choose a random tier
					local tier = '_'..may.empower.tiers[math.random(1, 5)]
					if card:gc().key == ('c_'..v) then
						-- empowered stuff is not finished yet so i need to make sure i get an empowerement tier that exists
						local success = true
						if not G.P_CENTERS['c_may_'..v..tier] then
							tier = '_eps'
						end
						if not G.P_CENTERS['c_may_'..v..tier] then
							tier = '_won'
						end
						if not G.P_CENTERS['c_may_'..v..tier] then
							tier = '_unw'
						end
						if not G.P_CENTERS['c_may_'..v..tier] then
							tier = '_pan'
						end
						if not G.P_CENTERS['c_may_'..v..tier] then
							tier = '_asc'
						end
						if G.P_CENTERS['c_may_'..v..tier] then
							G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
								if card then
									card:set_ability(G.P_CENTERS['c_may_'..v..tier])
									card:set_cost()
									if tier == '_asc' then
										play_sound('may_c_ascended', 1, 1.5)
									elseif tier == '_pan' then
										play_sound('may_c_pandimentional', 1, 1.5)
									elseif tier == '_unw' then
										play_sound('may_c_unworldly', 1, 1.5)
									elseif tier == '_won' then
										play_sound('may_c_wondrous', 1, 1.5)
									elseif tier == '_eps' then
										play_sound('may_c_epsilon', 1, 1.5)
									end
									card:juice_up(1, 1)
								end
							return true end}))
							break
						else
							break
						end
					end
				end
			end
		end
		-- Upside down
		if G.GAME.may_upside_down_deck then
			for k, v in pairs(may.can_be_upsd) do
				if card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v..'_upsd'] then
					card:set_ability(G.P_CENTERS['c_may_'..v..'_upsd'])
					card:set_cost()
					break
				end
			end
		else
			if pseudorandom('may_spawn_upsd') < 1 / G.GAME.may_upsd_rate then 
				for k, v in pairs(may.can_be_upsd) do
					if card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v..'_upsd'] then
						card:set_ability(G.P_CENTERS['c_may_'..v..'_upsd'])
						card:set_cost()
						break
					end
				end
			end
		end
		if card and card:gc().set == 'upside_down_tarots' or card:gc().set == 'upside_down_planets' or card:gc().set == 'upside_down_spectrals' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_upside_down', 1, 0.75)
				card:juice_up(1, 0.5)
			return true end}))
		end
		-- play special card sounds
		if card and card:gc().set == 'yottacards' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_yotta', 1, 0.75)
				card:juice_up(1, 0.5)
			return true end}))
		end
		if card and card:gc().set == 'ascendedyottas' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_ascended_yotta')
				card:juice_up(2, 2)
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7
			return true end}))
		end
		if card and card:gc().planet_rarity == 2 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_rare_planet', 1, 0.75)
				card:juice_up(1, 0.5)
			return true end}))
		end
		if card and card:gc().planet_rarity == 3 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_legendary_planet', 1, 0.75)
				card:juice_up(1, 0.5)
			return true end}))
		end
		if card and card:gc().planet_rarity == 4 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_mythic_planet', 1, 0.75)
				card:juice_up(1, 0.5)
			return true end}))
		end
	end
	return card
end

-- misc badges
-- taken from POLTERWORX (which took it from Cryptid (it's slightly different????))
local function calculate_scalefactor(text)
	local size = 0.9
	local font = G.LANG.font
	local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
	local calced_text_width = 0
	for _, c in utf8.chars(text) do
		local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
		calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
	end
	local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
	return scale_fac
end

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if obj and obj.misc_badge then
		local scale_fac = {}
		local scale_fac_len = 1
		if obj.misc_badge and obj.misc_badge.text then
			for i = 1, #obj.misc_badge.text do
				local calced_scale = calculate_scalefactor(obj.misc_badge.text[i])
				scale_fac[i] = calced_scale
				scale_fac_len = math.min(scale_fac_len, calced_scale)
			end
		end
		local ct = {}
		for i = 1, #obj.misc_badge.text do
			ct[i] = {
				string = obj.misc_badge.text[i]
			}
		end
		badges[#badges + 1] = {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						colour = obj.misc_badge and obj.misc_badge.colour or G.C.RED,
						r = 0.1,
						minw = 2/scale_fac_len,
						minh = 0.36,
						emboss = 0.05,
						padding = 0.03 * 0.9,
					},
					nodes = {
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						{
							n = G.UIT.O,
							config = {
								object = DynaText({
									string = ct or "ERROR",
									colours = { obj.misc_badge and obj.misc_badge.text_colour or G.C.WHITE },
									silent = true,
									float = true,
									shadow = true,
									offset_y = -0.03,
									spacing = 1,
									scale = 0.33 * 0.9,
								}),
							},
						},
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
					},
				},
			},
		}
	end
end

	-- Custom Colors

G.C.MAY_RED = HEX('8c0303')

G.C.DARK_MAY_RED = HEX('a14343')

SMODS.Gradient {
	key = 'eternum_green',
	colours = {G.C.GREEN, HEX('6aa35d')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'mayhem_gradient',
	colours = {HEX('8c0303'), HEX('a14343')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_hyperascendant',
	colours = {HEX('ff0000'), HEX('fbff00'), HEX('ff6200'), HEX('ff6200'), HEX('2bff00')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_ethereal',
	colours = {HEX('6f00ff'), HEX('ff00fb'), HEX('182052'), HEX('00e1ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_interdimensional',
	colours = {HEX('34eb9b'), HEX('ffe600'), HEX('2c2054')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_surreal',
	colours = {HEX('baf5ca'), HEX('21001b'), HEX('d1c436')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_asc_tarot',
	colours = {HEX('fc8403'), HEX('ff7300')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_asc_yotta',
	colours = {HEX('5900ff'), HEX('481182')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_big_operator',
	colours = {
	HEX('ff0000'), 
	HEX('000000'), 
	HEX('ff7300'), 
	HEX('000000'), 
	HEX('fff700'), 
	HEX('000000'), 
	HEX('00ff00'), 
	HEX('000000'), 
	HEX('0000ff'), 
	HEX('000000'), 
	HEX('7300ff'), 
	HEX('000000'), 
	HEX('ff00e1'), 
	HEX('000000'), 
	},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_huge_operator',
	colours = {
	HEX('ff0000'), 
	HEX('ff7300'), 
	HEX('fff700'), 
	HEX('00ff00'), 
	HEX('0000ff'), 
	HEX('7300ff'), 
	HEX('ff00e1'), 
	},
	cycle = 1.75,
	interpolation = 'linear'
}

SMODS.Gradient {
	key = 'col_tran11',
	colours = {
	HEX('ff0000'), 
	HEX('ff7300'), 
	HEX('fff700'), 
	HEX('00ff00'), 
	HEX('0000ff'), 
	HEX('7300ff'), 
	HEX('ff00e1'), 
	},
	cycle = 0.1,
	interpolation = 'linear'
}

SMODS.Gradient {
	key = 'col_may_wip_badge',
	colours = {HEX('000000'), HEX('ffb700')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_hidden_enhancement',
	colours = {HEX('7357ff'), HEX('537044')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_e_omega',
	colours = {HEX('000000'), HEX('5c0000')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_e_otherworldly',
	colours = {HEX('020629'), HEX('96e1ff'), HEX('e1ffc2')},
	interpolation = 'trig'
}

	-- Mayhem/Eternum stuff

may.mode = may.conf.Mode
	
if may.conf.Mode == 2 then
	SMODS.current_mod.display_name = "Eternum"
	SMODS.current_mod.name = "Eternum"
	SMODS.current_mod.badge_colour = SMODS.Gradients.may_eternum_green
end

-- Custom scaling
if may.conf.Scaling ~= 1 then
	function get_blind_amount(ante)
		if not amount then
			amount = to_big(200) 
		end
		if may.conf.Scaling == 2 then
			if ante < 8 then
				amount = to_big(100*(ante+2))
			else
				amount = to_big(100):arrow(math.floor(math.log10(ante)), to_big(1000))
			end
		elseif may.conf.Scaling == 3 then
			if ante < 4 then
				amount = to_big(100*(ante+1))
			end
			if ante > 4 then 
				amount = to_big(10^ante)
			end
			if ante > 8 then
				amount = to_big(100):arrow(math.max(math.floor(math.log10(ante))-2, 1), to_big(100):arrow(1, math.sqrt(ante*.5)))
			end
			if ante > 50 then
				amount = to_big(100):arrow(math.floor(math.log10(ante))*ante, to_big(100):arrow(1, ante))
			end
		elseif may.conf.Scaling == 4 then
			if ante < 4 then
				amount = to_big(100*(ante+2))
			end
			if ante > 4 then 
				amount = to_big(100^ante)
			end
			if ante > 8 then
				amount = to_big(100):arrow(math.floor(math.log10(ante))*ante, to_big(100):arrow(1, math.sqrt(ante)))
			end
			if ante > 50 then
				amount = to_big(100):arrow(3+math.floor(math.sqrt(ante)), ante^2)
			end
		end
		if ante < 1 then
			amount = to_big(100)
		end
		if amount == 0 then
			amount = 100
		end
		return amount
	end
end

-- Transcendence counter
--[[
{n=G.UIT.C, config={id = 'hud_transcendence',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
					{n=G.UIT.T, config={text = 'Transcendence', scale = .34, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				}},
			}},
			{n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
				{n=G.UIT.O, config={object = DynaText({string = {{ref_table = may, ref_value = 'transcendence'}}, colours = {G.C.DARK_EDITION},shadow = true, font = G.LANGUAGES['en-us'].font, scale = .8+((may.transcendence or 0)/10)}),id = 'transcendence_count'}},
			}},
]]
--[[if may.conf.transcendence_counter and #SMODS.find_mod('Multiplayer') == 0 then
function create_UIBox_HUD()
	local scale = 0.4
	local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

	local contents = {}

	local spacing = 0.13
	local temp_col = G.C.DYN_UI.BOSS_MAIN
	local temp_col2 = G.C.DYN_UI.BOSS_DARK
			contents.round = {
			  {n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={id = 'hud_hands',align = "cm", padding = 0.05, minw = 1.45, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				  {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
					{n=G.UIT.T, config={text = localize('k_hud_hands'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				  }},
				  {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
					{n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'hands_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.BLUE},shadow = true, rotate = true, scale = 2*scale}),id = 'hand_UI_count'}},
				  }}
				}},
				{n=G.UIT.C, config={minw = spacing},nodes={}},
				{n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				  {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
					{n=G.UIT.T, config={text = localize('k_hud_discards'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				  }},
				  {n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
					  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'discards_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.RED},shadow = true, rotate = true, scale = 2*scale}),id = 'discard_UI_count'}},
					}}
				  }},
				}},
			  }},
			  {n=G.UIT.R, config={minh = spacing},nodes={}},
			  {n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45*2 + spacing, minh = 1.15, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				  {n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.C, config={align = "cm", r = 0.1, minw = 1.28*2+spacing, minh = 1, colour = temp_col2}, nodes={
					  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'dollars', prefix = localize('$')}},
						scale_function = function ()
							return scale_number(G.GAME.dollars, 2.2 * scale, 99999, 1000000)
						end, maxw = 1.35, colours = {G.C.MONEY}, font = G.LANGUAGES['en-us'].font, shadow = true,spacing = 2, bump = true, scale = 2.2*scale}), id = 'dollar_text_UI'}}
					}},
				  }},
				}},
			}},
			{n=G.UIT.R, config={minh = spacing},nodes={}},
			{n=G.UIT.R, config={align = "cm"}, nodes={
			  {n=G.UIT.C, config={id = 'hud_ante',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
				  {n=G.UIT.T, config={text = localize('k_ante'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
				  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.round_resets, ref_value = 'ante'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'ante_UI_count'}},
				  {n=G.UIT.T, config={text = " ", scale = 0.3*scale}},
				  {n=G.UIT.T, config={text = "/ ", scale = 0.7*scale, colour = G.C.WHITE, shadow = true}},
				  {n=G.UIT.T, config={ref_table = G.GAME, ref_value='win_ante', scale = scale, colour = G.C.WHITE, shadow = true}}
				}},
			  }},
			  {n=G.UIT.C, config={minw = spacing},nodes={}},
			  {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				{n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
				  {n=G.UIT.T, config={text = localize('k_round'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2, id = 'row_round_text'}, nodes={
				  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'round'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'round_UI_count'}},
				}},
			  }},
			}},            
	}

	contents.hand =
		{n=G.UIT.R, config={align = "cm", id = 'hand_text_area', colour = darken(G.C.BLACK, 0.1), r = 0.1, emboss = 0.05, padding = 0.03}, nodes={
            {n=G.UIT.C, config={align = "cm"}, nodes={
              {n=G.UIT.R, config={align = "cm", minh = 1.1}, nodes={
                {n=G.UIT.O, config={id = 'hand_name', func = 'hand_text_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "handname_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
                {n=G.UIT.O, config={id = 'hand_chip_total', func = 'hand_chip_total_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_total_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
                {n=G.UIT.T, config={ref_table = G.GAME.current_round.current_hand, ref_value='hand_level', scale = scale, colour = G.C.UI.TEXT_LIGHT, id = 'hand_level', shadow = true}}
              }},
              {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cr", minw = 2, minh =1, r = 0.1,colour = G.C.UI_CHIPS, id = 'hand_chip_area', emboss = 0.05}, nodes={
                    {n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_chips', object = Moveable(0,0,0,0), w = 0, h = 0}},
                    {n=G.UIT.O, config={id = 'hand_chips', func = 'hand_chip_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
                    {n=G.UIT.B, config={w=0.1,h=0.1}},
                }},
                {n=G.UIT.C, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={id = "score_operator_text", text = "X", lang = G.LANGUAGES["en-us"], scale = scale*2, colour = G.C.UI_MULT, shadow = true}},
                }},
                {n=G.UIT.C, config={align = "cl", minw = 2, minh=1, r = 0.1,colour = G.C.UI_MULT, id = 'hand_mult_area', emboss = 0.05}, nodes={
                  {n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_mult', object = Moveable(0,0,0,0), w = 0, h = 0}},
                  {n=G.UIT.B, config={w=0.1,h=0.1}},
                  {n=G.UIT.O, config={id = 'hand_mult', func = 'hand_mult_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "mult_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
                }}
              }}
            }}
        }}
	if #SMODS.find_mod('Cryptid') ~= 0 then
		contents.hand = {n=G.UIT.R, config={align = "cm", id = 'hand_text_area', colour = darken(G.C.BLACK, 0.1), r = 0.1, emboss = 0.05, padding = 0.03}, nodes={
			{n=G.UIT.C, config={align = "cm"}, nodes={
			  {n=G.UIT.R, config={align = "cm", minh = 1.1}, nodes={
				{n=G.UIT.O, config={id = 'hand_name', func = 'hand_text_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "handname_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
				{n=G.UIT.O, config={id = 'cry_asc', func = 'cry_asc_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "cry_asc_num_text"}}, colours = {G.C.GOLD}, shadow = true, float = true, scale = scale*1})}},
				{n=G.UIT.O, config={id = 'hand_chip_total', func = 'hand_chip_total_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_total_text"}}, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, float = true, scale = scale*1.4})}},
				{n=G.UIT.T, config={ref_table = G.GAME.current_round.current_hand, ref_value='hand_level', scale = scale, colour = G.C.UI.TEXT_LIGHT, id = 'hand_level', shadow = true}}
			  }},
			  {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
				{n=G.UIT.C, config={align = "cr", minw = 2, minh =1, r = 0.1,colour = G.C.UI_CHIPS, id = 'hand_chip_area', emboss = 0.05}, nodes={
				{n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_chips', object = Moveable(0,0,0,0), w = 0, h = 0}},
				{n=G.UIT.O, config={id = 'hand_chips', func = 'hand_chip_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "chip_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
					{n=G.UIT.B, config={w=0.1,h=0.1}},
				}},
				{n=G.UIT.C, config={align = "cm"}, nodes={
				  {n=G.UIT.T, config={id = "score_operator_text", text = "X", lang = G.LANGUAGES["en-us"], scale = scale*2, colour = G.C.UI_MULT, shadow = true}},
				}},
				{n=G.UIT.C, config={align = "cl", minw = 2, minh=1, r = 0.1,colour = G.C.UI_MULT, id = 'hand_mult_area', emboss = 0.05}, nodes={
				  {n=G.UIT.O, config={func = 'flame_handler',no_role = true, id = 'flame_mult', object = Moveable(0,0,0,0), w = 0, h = 0}},
				  {n=G.UIT.B, config={w=0.1,h=0.1}},
				  {n=G.UIT.O, config={id = 'hand_mult', func = 'hand_mult_UI_set',object = DynaText({string = {{ref_table = G.GAME.current_round.current_hand, ref_value = "mult_text"}}, colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = scale*2.3})}},
				}}
			  }}
			}}
		  }}
	end
	contents.dollars_chips = {n=G.UIT.R, config={align = "cm",r=0.1, padding = 0,colour = G.C.DYN_UI.BOSS_MAIN, emboss = 0.05, id = 'row_dollars_chips'}, nodes={
	  {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
		{n=G.UIT.C, config={align = "cm", minw = 1.3}, nodes={
		  {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
			{n=G.UIT.T, config={text = localize('k_round'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
		  }},
		  {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
			{n=G.UIT.T, config={text =localize('k_lower_score'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
		  }}
		}},
		{n=G.UIT.C, config={align = "cm", minw = 3.3, minh = 0.7, r = 0.1, colour = G.C.DYN_UI.BOSS_DARK}, nodes={
		  {n=G.UIT.O, config={w=0.5,h=0.5 , object = stake_sprite, hover = true, can_collide = false}},
		  {n=G.UIT.B, config={w=0.1,h=0.1}},
		  {n=G.UIT.T, config={ref_table = G.GAME, ref_value = 'chips_text', lang = G.LANGUAGES['en-us'], scale = 0.85, colour = G.C.WHITE, id = 'chip_UI_count', func = 'chip_UI_set', shadow = true}}
		}}
	  }}
	}}

	contents.buttons = {
		{n=G.UIT.C, config={align = "cm", r=0.1, colour = G.C.CLEAR, shadow = true, id = 'button_area',padding=0.33}, nodes={
			{n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
			{n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
				{n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
			}},
			{n=G.UIT.R, config={align = "cm", padding = 0, maxw = 2}, nodes={
				{n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
			}}
			}},
			{n=G.UIT.R, config={align = "cm", minh = 1, minw = 1.6,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
			{n=G.UIT.C, config={align = "cm", maxw = 1.35, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
				{n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
			}},
			}},
			{n=G.UIT.R, config={align = "cm", minh = 1, minw = 1.6,padding = 0.05, r = 0.1, hover = true, colour=G.C.DYN_UI.BOSS_MAIN,emboss=0.05}, nodes={
			{n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
				{n=G.UIT.T, config={text = 'Transcendence', minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
			}},
			{n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.5, colour = temp_col2, id = 'row_transcendence_counter'}, nodes={
				{n=G.UIT.O, config={object = DynaText({string = {{ref_table = may, ref_value = 'safe_transcendence'}}, colours = {G.C.DARK_EDITION},shadow = true, scale = 2*scale}),id = 'transcendence_UI_counter'}},
			}},
			}}
		}}
	}

	return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
	  {n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
		{n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minh = 30, padding = 0.08}, nodes={
		  {n=G.UIT.R, config={align = "cm", minh = 0.3}, nodes={}},
		  {n=G.UIT.R, config={align = "cm", id = 'row_blind', minw = 1, minh = 3.75}, nodes={
			  {n=G.UIT.B, config={w=0, h=3.64, id = 'row_blind_bottom'}, nodes={}}
		  }},
		  contents.dollars_chips,
		  contents.hand,
		  {n=G.UIT.R, config={align = "cm", id = 'row_round'}, nodes={
			{n=G.UIT.C, config={align = "cm"}, nodes=contents.buttons},
			{n=G.UIT.C, config={align = "cm"}, nodes=contents.round}
		  }},
		}}
	  }}
	}}
end

end]]

-- Menu
if may.conf.Menu then 
	if may.conf.Mode == 1 then
		local oldfunc = Game.main_menu
		Game.main_menu = function(change_context)
			local ret = oldfunc(change_context)
			G.SPLASH_BACK:define_draw_steps({
				{
					shader = "splash",
					send = {
						{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
						{ name = "vort_speed", val = 0.4 },
						{ name = "colour_1", ref_table = SMODS.Gradients, ref_value = "may_mayhem_gradient" },
						{ name = "colour_2", ref_table = G.C, ref_value = "BLACK" },
					},
				},
			})
		return ret
		end
	else
		local oldfunc = Game.main_menu
		Game.main_menu = function(change_context)
			local ret = oldfunc(change_context)
			G.SPLASH_BACK:define_draw_steps({
				{
					shader = "splash",
					send = {
						{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
						{ name = "vort_speed", val = 0.4 },
						{ name = "colour_1", ref_table = SMODS.Gradients, ref_value = "may_eternum_green" },
						{ name = "colour_2", ref_table = G.C, ref_value = "BLACK" },
					},
				},
			})
		return ret
		end
	end
end

-- jen why
function jl.randomise(targets, noanim)
	if #targets <= 0 then return end
	if noanim then
		for i=1, #targets do
			local card = targets[i]
			card:set_base(pseudorandom_element(G.P_CARDS))	
			if pseudorandom(pseudoseed('chancetime')) > 1 / (#G.P_CENTER_POOLS['Enhanced']+1) then
				card:set_ability(pseudorandom_element(G.P_CENTER_POOLS['Enhanced'], pseudoseed('spectral_chance')))
			else
				card:set_ability(G.P_CENTERS['c_base'])
			end	
			local edition_rate = 2
			card:set_edition(poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true), true, true)
			local seal_rate = 10
			local seal_poll = pseudorandom(pseudoseed('stdseal'..G.GAME.round_resets.ante))
			if seal_poll > 1 - 0.02*seal_rate then
				local seal_type = pseudorandom(pseudoseed('stdsealtype'..G.GAME.round_resets.ante))
				local seal_list = {}
				for k, _ in pairs(G.P_SEALS) do
					table.insert(seal_list, k)
				end
				seal_type = math.floor(seal_type * #seal_list)
				card:set_seal(seal_list[seal_type], true, true)
			else
				card:set_seal(nil, true, true)
			end
			card:juice_up(0.3, 0.3)
		end
	else
		for i=1, #targets do
			local percent = math.max(0.01, 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() targets[i]:flip();play_sound('card1', percent);targets[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		for i=1, #targets do
			local percent = math.max(0.01, 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()	
				local card = targets[i]
				card:set_base(pseudorandom_element(G.P_CARDS))	
				if pseudorandom(pseudoseed('chancetime')) > 1 / (#G.P_CENTER_POOLS['Enhanced']+1) then
					card:set_ability(pseudorandom_element(G.P_CENTER_POOLS['Enhanced'], pseudoseed('spectral_chance')))
				else
					card:set_ability(G.P_CENTERS['c_base'])
				end	
				local edition_rate = 2
				card:set_edition(poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true))
				local seal_rate = 10
				local seal_poll = pseudorandom(pseudoseed('stdseal'..G.GAME.round_resets.ante))
				if seal_poll > 1 - 0.02*seal_rate then
					local seal_type = pseudorandom(pseudoseed('stdsealtype'..G.GAME.round_resets.ante))
					local seal_list = {}
					for k, _ in pairs(G.P_SEALS) do
						table.insert(seal_list, k)
					end
					seal_type = math.floor(seal_type * #seal_list)
					card:set_seal(seal_list[seal_type])
				else
					card:set_seal()
				end
				card:flip()
				play_sound('card3', percent, 0.6)
				card:juice_up(0.3, 0.3)
				return true 
			end }))
		end
	end
end
-- incantation stuff

if Incantation then
	AllowBulkUse('retrocards')
	AllowMassUsing('editioncards')
	AllowMassUsing('yottacards')
	AllowMassUsing('ascendedyottas')
	AllowMassUsing('ascendedplanets')
	AllowMassUsing('pandimentionalplanets')
	AllowMassUsing('unworldlyplanets')
	AllowMassUsing('wondrousplanets')
	AllowMassUsing('epsilonplanets')
	
	AllowMassUsingIndividual('c_hermit')
	AllowMassUsingIndividual('c_may_hermit_asc')
	AllowMassUsingIndividual('c_temperance')
	AllowMassUsingIndividual('c_may_astronomy')
	AllowMassUsingIndividual('c_may_celestra')
	
	-- Overriding for mass use ambiance
	function runthrough_planets()
		if not may.mass_use_index then
			may.mass_use_index = 0
		end
		for i = 1, #G.play.cards do
			local card = G.play.cards[i]
			if card then
				local obj = card.config.center
				if (((card.config or {}).center or {}).set or '') == 'Planet' or card:CanMassUse() then
					G.E_MANAGER:add_event(Event({delay = 0.1, func = function()
						if card then card.highlighted = true play_sound('button', 1.5) end
							if #G.play.cards > 10 and may.mass_use_index < 100 and may.conf.massuse then
								may.mass_use_index = may.mass_use_index + 1
							end
						return true
					end}))
					card.bulkuse = card:CanBulkUse() and math.max(1, card:getQty()) > 1
					card.force_incantation_acceleration = true
					card:use_consumeable(G.consumeables)
					if G.betmma_abilities then
						for i = 1, #G.betmma_abilities.cards do
							G.betmma_abilities.cards[i]:calculate_joker({using_consumeable = true, consumeable = card})
						end
					end
					for i = 1, #G.jokers.cards do
						local effects = G.jokers.cards[i]:calculate_joker({using_consumeable = true, consumeable = card})
						if effects and effects.joker_repetitions then
							rep_list = effects.joker_repetitions
							for z=1, #rep_list do
								if type(rep_list[z]) == 'table' and rep_list[z].repetitions then
									for r=1, rep_list[z].repetitions do
										card_eval_status_text(rep_list[z].card, 'jokers', nil, nil, nil, rep_list[z])
										G.jokers.cards[i]:calculate_joker({using_consumeable = true, consumeable = card, retrigger_joker = true})
									end
								end
							end
						end
					end
					G.E_MANAGER:add_event(Event({delay = 0.1, func = function()
						if card then
							card.highlighted = false
							play_sound('button', 1.25)
							card.ignore_incantation_consumable_in_use = true
							card:start_dissolve()
						end
						return true
					end}))
				end
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				blockable = true,
				func = function()
					Incantation.consumable_in_use = false
					Incantation.accelerate = false
					may.mass_use_index = 0
					return true
				end
			}))
		end
	end
end


-- Aurinko stuff
if #SMODS.find_mod('aurinko') ~= 0 then
	for k, v in pairs(G.P_CENTERS) do
		if k.set == 'editioncards' then
			table.insert(AurinkoWhitelist, v)
		end
	end
end

-- Unrerollable UltraBlind stuff
-- Taken from POLTERWORX
local vanf_reb = G.FUNCS.reroll_boss

G.FUNCS.reroll_boss = function(e)
	local blind = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if blind.ultra then
		play_sound('cancel', 0.8, 1)
		play_sound('may_error')
		G.blind_select_opts.boss:juice_up()
		G.ROOM.jiggle = G.ROOM.jiggle + 0.2
	else
		return vanf_reb(e)
	end
end

-- Money hyperoperations

function hypermoney(arrow, amount, silent)
	if G and G.GAME then
		G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
			G.GAME.dollars = to_big(G.GAME.dollars):arrow(arrow, amount)
			if not Talisman.config_file.disable_anims then
				G.ROOM.jiggle = G.ROOM.jiggle + (arrow/5)
				local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
				local text = ''
				if arrow == 0 then
					text = 'X'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 1 then
					text = '^'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 2 then
					text = '^^'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 3 then
					text = '^^^'..tostring(math.abs(amount))..localize('$')
				elseif arrow > 3 then
					text = '{'..arrow..'}'..tostring(math.abs(amount))..localize('$')
				end
				dollar_UI.config.object:update()
				G.HUD:recalculate()
				attention_text({
					text = text,
					scale = 0.8, 
					hold = 0.7,
					cover = dollar_UI.parent,
					cover_colour = G.C.MONEY,
					align = 'cm',
				})
				if silent == nil then 
					silent = true
				end
				if not silent then
					play_sound('may_bigmoney')
					if arrow == 1 then
						play_sound('may_e_antimatter')
					elseif arrow == 2 then
						play_sound('talisman_eemult')
					elseif arrow == 3 then
						play_sound('talisman_eeemult')
					elseif arrow == 4 then
						play_sound('may_hexmult')
					elseif arrow == 5 then
						play_sound('may_hepmult')
					elseif arrow == 6 then
						play_sound('may_octmult')
					elseif arrow == 7 then
						play_sound('may_ennmult')
					elseif arrow == 8 then
						play_sound('may_decmult')
					elseif arrow >= 9 then
						play_sound('may_undmult')
					end
				end
				if arrow > 0 then
					if may.conf.Shakiness.unlimitquiver then
						G.FUNCS.tsj_specific(dollar_UI, 0, arrow*4, true)
					else
						G.FUNCS.tsj_specific(dollar_UI, 0, math.min(may.conf.Shakiness.pulselimit, arrow*4), true)
					end
				end
			end
		return true end}))
	end
end

-- Hyperoperational hand level
function may.level_up_hand_hyper(card, hand, instant, amount, arrow)
	arrow = arrow or 0
	amount = amount or 1
    amount = to_big(amount)
	if hand and G.GAME.hands[hand] then
		G.GAME.hands[hand].level = to_big(G.GAME.hands[hand].level):arrow(arrow, amount)
		G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult) + (to_big(G.GAME.hands[hand].l_mult)*(G.GAME.hands[hand].level - to_big(1)))
		G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips) + (to_big(G.GAME.hands[hand].l_chips)*(G.GAME.hands[hand].level - to_big(1)))
		G.GAME.hands[hand].mult = G.GAME.hands[hand].mult:normalize()
		G.GAME.hands[hand].chips = G.GAME.hands[hand].chips:normalize()
		if not instant then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end }))
			update_hand_text({delay = 0}, {mult = number_format(G.GAME.hands[hand].mult), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				return true end }))
			update_hand_text({delay = 0}, {chips = number_format(G.GAME.hands[hand].chips), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
				return true end }))
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=number_format(G.GAME.hands[hand].level)})
			delay(1.3)
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			blocking = G.SETTINGS.FASTFORWARD < 3,
			func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
		}))
		SMODS.calculate_context({level_up_hand = true, other_card = card, hand = hand, instant = instant, amount = to_number(amount)})
	end
end

-- Equals level basically, used in stuff like Mangas
function may.set_hand_level(card, hand, instant, mod)
	if hand and G.GAME.hands[hand] then
		local pre_level = G.GAME.hands[hand].level
		if not instant then 
			jl.h(hand, G.GAME.hands[hand].mult, G.GAME.hands[hand].chips, G.GAME.hands[hand].level)
			G.GAME.hands[hand].level = to_big(mod):normalize()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
			return true end}))
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult) - to_big(G.GAME.hands[hand].l_mult) * to_big(G.GAME.hands[hand].level)
			G.GAME.hands[hand].mult = G.GAME.hands[hand].mult:normalize()
			jl.hm(G.GAME.hands[hand].mult, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips) - to_big(G.GAME.hands[hand].l_chips) * to_big(G.GAME.hands[hand].level)
			G.GAME.hands[hand].chips = G.GAME.hands[hand].chips:normalize()
			jl.hc(G.GAME.hands[hand].chips, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			jl.hlv(mod, true)
			delay(1.3)
		else
			G.GAME.hands[hand].level = to_big(mod):normalize()
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].l_mult) * to_big(G.GAME.hands[hand].level)
			G.GAME.hands[hand].mult = G.GAME.hands[hand].mult:normalize()
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].l_chips) * to_big(G.GAME.hands[hand].level)
			G.GAME.hands[hand].chips = G.GAME.hands[hand].chips:normalize()
		end
		if to_big(pre_level) < to_big(mod) then
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				blocking = G.SETTINGS.FASTFORWARD < 3,
				func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
			}))
			SMODS.calculate_context({level_up_hand = true, other_card = card, hand = hand, instant = instant, amount = to_number(to_big(mod) - to_big(pre_level))})
		end
	end
end

function may.level_up_all_hands(card, instant, amount, ignore)
	if to_big(amount) ~= to_big(0) then
		for k, v in pairs(G.GAME.hands) do
			if ignore then
				if k ~= ignore then 
					level_up_hand(card, k, true, amount)
				end
			else
				level_up_hand(card, k, true, amount)
			end
		end
		if not instant then
			local hand_name = 'All Hands'
			if ignore then
				if type(ignore) == 'string' then
					hand_name = 'Other Hands'
				else
					hand_name = 'Hands'
				end
			end
			jl.h(hand_name, '...', '...', '...')
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('generic1')
				card:juice_up(0.8, 0.5)
			return true end}))
			delay(1.2)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end}))
			if to_big(amount) > to_big(0) then
				jl.hm('+')
			else
				jl.hm('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				return true end}))
			if to_big(amount) > to_big(0) then
				jl.hc('+')
			else
				jl.hc('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			if to_big(amount) > to_big(0) then
				jl.hlv('+'..amount)
			else
				jl.hlv(amount)
			end
			delay(1.3)
			jl.ch()
		end
	end
end

function may.level_up_all_hands_hyper(card, instant, amount, arrow, ignore)
	arrow = arrow or 0
	if to_big(amount) ~= to_big(0) then
		for k, v in pairs(G.GAME.hands) do
			if ignore then
				if v ~= G.GAME.hands[ignore] then 
					may.level_up_hand_hyper(card, k, true, amount, arrow)
				end
			else
				may.level_up_hand_hyper(card, k, true, amount, arrow)
			end
		end
		if not instant then
			local hand_name = 'All Hands'
			if ignore then
				if type(ignore) == 'string' then
					hand_name = 'Other Hands'
				else
					hand_name = 'Hands'
				end
			end
			jl.h(hand_name, '...', '...', '...')
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('generic1')
				card:juice_up(0.8, 0.5)
			return true end}))
			delay(1.2)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end}))
			if to_big(amount) > to_big(0) then
				jl.hm('+')
			else
				jl.hm('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				return true end}))
			if to_big(amount) > to_big(0) then
				jl.hc('+')
			else
				jl.hc('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			jl.hlv(generate_arrow_text(arrow)..amount)
			delay(1.3)
			jl.ch()
		end
	end
end

function may.set_all_hand_levels(card, instant, mod, ignore)
	for k, v in pairs(G.GAME.hands) do
		if ignore then
			if v ~= G.GAME.hands[ignore] then 
				may.set_hand_level(card, k, true, mod)
			end
		else
			may.set_hand_level(card, k, true, mod)
		end
	end
	if not instant then
		local hand_name = 'All Hands'
		if ignore then
			if type(ignore) == 'string' then
				hand_name = 'Other Hands'
			else
				hand_name = 'Hands'
			end
		end
		jl.h(hand_name, '...', '...', '...')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		jl.hm('=', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		jl.hc('=', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
		jl.hlv(mod, true)
		delay(1.3)
	end
end

-- Transcendence effects

if may.conf.TrEffects ~= 1 then
	SMODS.DrawStep {
		key = 'transcendence_shake',
		order = -3000,
		func = function(self)
			if G.hand and may.conf.TrShakeCards then
				if (may.transcendence or 0) < 9 and (may.transcendence or 0) > 0 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
						self:juice_up(0.01, math.random(0, (may.transcendence or 0))/9)
					end
				else 
					if (may.transcendence or 0) == 9 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
							self:juice_up(math.random(-.5, .5), math.random(1, 3))
						end
					end
					if (may.transcendence or 0) == 10 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
							self:juice_up(math.random(-2, 0), 100)
						end
					end
					if (may.transcendence or 0) == 11 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
							self:juice_up(0, math.random(100, 800))
						end
					end
					if (may.transcendence or 0) == 12 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
							self:juice_up(0, 0.001)
						end
					end
					if (may.transcendence or 0) == 14 or (may.transcendence or 0) == 15 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play then
							self:juice_up(math.random(-.5, .5), math.random(1, 3))
						end
					end
				end
			end
		end
	}
end

if may.conf.TrEffects ~= 1 then
	local upd = Game.update
	function Game:update(dt)
		upd(self, dt)
		if not G.GAME then
			if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 0
					else
						glitched_intensity = 0
					end
					transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
					end
		if G.GAME and G.GAME.blind then
			may.safe_transcendence = (G.ARGS.score_intensity.transcendence or 0)
		end
		if G.hand then
			if may.conf.TrEffects >= 3 then
				if (may.transcendence or 0) > 0 then
					if may.transcendence < 10 then
						G.hand_text_area.blind_chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						G.hand_text_area.mult:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						G.hand_text_area.chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						G.hand_text_area.handname:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						G.hand_text_area.hand_level:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						G.hand_text_area.chipmult_op:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
						end
						G.ARGS.spin.real = -math.log10(may.transcendence)
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = may.transcendence
							else
								glitched_intensity = may.transcendence
							end
							transcendence_noise = may.transcendence/30
							transcendence_crt = may.transcendence/60
						end
					elseif may.transcendence == 10 then
						G.hand_text_area.blind_chips:juice_up(0.01, 100)
						G.hand_text_area.mult:juice_up(0.01, 100)
						G.hand_text_area.chips:juice_up(0.01, 100)
						G.hand_text_area.handname:juice_up(0.01, 100)
						G.hand_text_area.hand_level:juice_up(0.01, 100)
						G.hand_text_area.chipmult_op:juice_up(0.01, 100)
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + 10
						end
						G.ARGS.spin.real = -2
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 15
							else
								glitched_intensity = 15
							end
							transcendence_noise = 0.4
							transcendence_crt = 0.2
						end
					elseif may.transcendence == 11 then
						G.hand_text_area.blind_chips:juice_up(0.01, 400)
						G.hand_text_area.mult:juice_up(0.01, 400)
						G.hand_text_area.chips:juice_up(0.01, 400)
						G.hand_text_area.handname:juice_up(0.01, 400)
						G.hand_text_area.hand_level:juice_up(0.01, 400)
						G.hand_text_area.chipmult_op:juice_up(0.01, 400)
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + 20
						end
						G.ARGS.spin.real = -5
						--[[if may.conf.TrEffects == 4 then
							love.window.setTitle(may.obfuscatedtext(string.len(love.window.getTitle())))
						end]]
						if may.conf.WindowShake then
							love.window.setPosition(love.window.getPosition(x)+math.random(-1, 1), love.window.getPosition(y)+math.random(-1, 1), love.window.getPosition(displayindex)+math.random(-1, 1))
						end
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 70
							else
								glitched_intensity = 70
							end
							transcendence_noise = 0.5
							transcendence_crt = 0.3
						end
						ease_colour(G.C.DARK_EDITION, SMODS.Gradients.may_col_asc_yotta, 1)
					elseif may.transcendence == 12 then
						ease_colour(G.C.DARK_EDITION, HEX('111111'), 1)
						G.ARGS.spin.real = 0
						G.ARGS.spin.amount = 0
						G.ARGS.spin.eased = 0
						--[[if may.conf.TrEffects == 4 then
							love.window.setTitle('null')
						end]]
						if may.conf.WindowShake then
							love.window.setPosition(love.window.getPosition(x)+math.random(-4, 4), love.window.getPosition(y)+math.random(-4, 4), love.window.getPosition(displayindex)+math.random(-4, 4))
						end
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 100
							else
								glitched_intensity = 100
							end
							transcendence_noise = 0.6
							transcendence_crt = 100
						end
					elseif may.transcendence == 13 then
						ease_colour(G.C.DARK_EDITION, HEX('ffd9fb'), 1)
						G.ARGS.spin.real = 0
						G.ARGS.spin.amount = 0
						G.ARGS.spin.eased = 0
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + 5
						end
						--[[if may.conf.TrEffects == 4 then
							love.window.setTitle('')
						end]]
						if may.conf.WindowShake then
							love.window.setPosition(love.window.getPosition(x)+math.random(-8, 8), love.window.getPosition(y)+math.random(-8, 8), love.window.getPosition(displayindex)+math.random(-8, 8))
						end
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 50
							else
								glitched_intensity = 50
							end
							transcendence_noise = 0.1
							transcendence_crt = 0.2
						end
					elseif may.transcendence == 14 then
						ease_colour(G.C.DARK_EDITION, HEX('0d0200'), 1)
						G.ARGS.spin.real = 2
						G.ARGS.spin.amount = 2
						G.ARGS.spin.eased = 2
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + 20
						end
						--[[if may.conf.TrEffects == 4 then
							love.window.setTitle('')
						end]]
						if may.conf.WindowShake then
							love.window.setPosition(love.window.getPosition(x)+math.random(-12, 12), love.window.getPosition(y)+math.random(-12, 12), love.window.getPosition(displayindex)+math.random(-12, 12))
						end
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 90
							else
								glitched_intensity = 90
							end
							transcendence_noise = 0.5
							transcendence_crt = 0.5
						end
						if not G.GAME.may_override_monitor_colors then
							ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
							ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
						end
						ease_colour(G.C.MONEY, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.RED, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.BLUE, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.IMPORTANT, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.GOLD, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.ORANGE, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.UI.BACKGROUND_DARK, copy_table(G.C.DARK_EDITION), .6)
						if #SMODS.find_mod('GRM') ~= 0 then
							ease_colour(G.C.PURPLE, copy_table(G.C.DARK_EDITION), .6)
						end
						ease_background_colour({ new_colour = copy_table(G.C.DARK_EDITION), special_colour = copy_table(G.C.BLACK), contrast = 2 })
					elseif may.transcendence == 15 then
						ease_colour(G.C.DARK_EDITION, HEX('000000'), 1)
						G.ARGS.spin.real = 1
						G.ARGS.spin.amount = 1
						G.ARGS.spin.eased = 1
						--[[if may.conf.TrEffects == 4 then
							love.window.setTitle('')
						end]]
						if may.conf.TrEffects == 4 then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 1
							else
								glitched_intensity = 1
							end
							transcendence_noise = 0.65
							transcendence_crt = 0.6
						end
						if not G.GAME.may_override_monitor_colors then
							ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
							ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
						end
						ease_colour(G.C.MONEY, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.RED, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.BLUE, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.IMPORTANT, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.GOLD, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.ORANGE, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.UI.BACKGROUND_DARK, copy_table(G.C.DARK_EDITION), .6)
						if #SMODS.find_mod('GRM') ~= 0 then
							ease_colour(G.C.PURPLE, copy_table(G.C.DARK_EDITION), .6)
						end
						ease_background_colour({ new_colour = copy_table(G.C.DARK_EDITION), special_colour = copy_table(G.C.BLACK), contrast = 2 })
					end
					if not G.GAME.may_override_monitor_colors then
						ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
					end
					ease_colour(G.C.MONEY, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.RED, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.BLUE, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.IMPORTANT, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.GOLD, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.ORANGE, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.UI.BACKGROUND_DARK, copy_table(G.C.DARK_EDITION), .6)
					if #SMODS.find_mod('GRM') ~= 0 then
						ease_colour(G.C.PURPLE, copy_table(G.C.DARK_EDITION), .6)
					end
					ease_background_colour({ new_colour = copy_table(G.C.DARK_EDITION), special_colour = copy_table(G.C.BLACK), contrast = 2 })
					else
						if not G.GAME.may_override_monitor_colors then
							ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
							ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
						end
						ease_colour(G.C.RED, HEX('FE5F55'), 1)
						ease_colour(G.C.BLUE, HEX("009dff"), 1)
						ease_colour(G.C.MONEY, HEX('f3b958'), 1)
						ease_colour(G.C.IMPORTANT, HEX('ff9a00'), 1)
						ease_colour(G.C.GOLD, HEX('eac058'), 1)
						ease_colour(G.C.ORANGE, HEX('fda200'), 1)
						ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), 1)
						if #SMODS.find_mod('GRM') ~= 0 then
							ease_colour(G.C.PURPLE, HEX('8867a5'), .6)
						end
					-- love.window.setTitle('Balatro Mayhem')
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 0
					else
						glitched_intensity = 0
					end
					transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
				end
			elseif may.conf.TrEffects == 2 then
				if (may.transcendence or 0) > 0 then
					if may.transcendence ~= 12 then
						if may.conf.TrShakeScreen then
							G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
						end
						ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
						ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
					else
						ease_colour(G.C.UI_CHIPS, HEX('111111'), .6)
						ease_colour(G.C.UI_MULT, HEX('111111'), .6)
					end
				else
					if not G.GAME.may_override_monitor_colors then
						ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
						ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
					end
					ease_colour(G.C.RED, HEX('FE5F55'), 1)
					ease_colour(G.C.BLUE, HEX("009dff"), 1)
					ease_colour(G.C.MONEY, HEX('f3b958'), 1)
					ease_colour(G.C.IMPORTANT, HEX('ff9a00'), 1)
					ease_colour(G.C.GOLD, HEX('eac058'), 1)
					ease_colour(G.C.ORANGE, HEX('fda200'), 1)
					ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), 1)
					if #SMODS.find_mod('GRM') ~= 0 then
						ease_colour(G.C.PURPLE, HEX('8867a5'), .6)
					end
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 0
					else
						glitched_intensity = 0
					end
					transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
				end
			end
		end
		-- Party Time background
		if G.GAME.blind then
			if #SMODS.find_card('j_may_party_time') ~= 0 and (may.transcendence or 0) == 0 and may.conf.JokerEffects then
				ease_background_colour({ new_colour = copy_table(G.C.BLACK), special_colour = G.C.EDITION, contrast = 2 })
			end	
		end
		if may.Transcendence == 0 then
			if not G.GAME.may_override_monitor_colors then
				ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
				ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
			end
			ease_colour(G.C.RED, HEX('FE5F55'), 1)
			ease_colour(G.C.BLUE, HEX("009dff"), 1)
			ease_colour(G.C.MONEY, HEX('f3b958'), 1)
			ease_colour(G.C.IMPORTANT, HEX('ff9a00'), 1)
			ease_colour(G.C.GOLD, HEX('eac058'), 1)
			ease_colour(G.C.ORANGE, HEX('fda200'), 1)
			ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), 1)
			if #SMODS.find_mod('GRM') ~= 0 then
				ease_colour(G.C.PURPLE, HEX('8867a5'), .6)
			end
			if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 0
					else
						glitched_intensity = 0
					end
					transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
					transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
		end
	end
end

may.flame_limit = 5e3
-- Fix flames because Talisman 2.2.0 MAGICALLY broke them 
G.FUNCS.flame_handler = function(e)
	G.C.UI_CHIPLICK = G.C.UI_CHIPLICK or {1, 1, 1, 1}
	G.C.UI_MULTLICK = G.C.UI_MULTLICK or {1, 1, 1, 1}
	for i=1, 3 do
		if (may.transcendence or 0) >= 8 then
			G.C.UI_CHIPLICK[i] = math.min(math.max(((G.C.BLACK[i]*0.5+G.C.BLACK[i]*0.5) + 0.1)^2, 0.1), 1)
			G.C.UI_MULTLICK[i] = math.min(math.max(((G.C.BLACK[i]*0.5+G.C.BLACK[i]*0.5) + 0.1)^2, 0.1), 1)
		else
			G.C.UI_CHIPLICK[i] = math.min(math.max(((G.C.UI_CHIPS[i]*0.5+G.C.YELLOW[i]*0.5) + 0.1)^2, 0.1), 1)
			G.C.UI_MULTLICK[i] = math.min(math.max(((G.C.UI_MULT[i]*0.5+G.C.YELLOW[i]*0.5) + 0.1)^2, 0.1), 1)
		end
	end
  
	G.ARGS.flame_handler = G.ARGS.flame_handler or {
		chips = {
			id = 'flame_chips', 
			arg_tab = 'chip_flames',
			colour = G.C.UI_CHIPS,
			accent = G.C.UI_CHIPLICK
	  },
	  mult = {
		id = 'flame_mult', 
		arg_tab = 'mult_flames',
		colour = G.C.UI_MULT,
		accent = G.C.UI_MULTLICK
	  }
	}
	for k, v in pairs(G.ARGS.flame_handler) do
	  if e.config.id == v.id then 
		if not e.config.object:is(Sprite) or e.config.object.ID ~= v.ID then 
		  e.config.object:remove()
		  e.config.object = Sprite(0, 0, 2.5, 2.5, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
		  v.ID = e.config.object.ID
		  G.ARGS[v.arg_tab] = {
			  intensity = 0,
			  real_intensity = 0,
			  intensity_vel = 0,
			  colour_1 = v.colour,
			  colour_2 = v.accent,
			  timer = G.TIMERS.REAL
		  }      
		  e.config.object:set_alignment({
			  major = e.parent,
			  type = 'bmi',
			  offset = {x=0,y=0},
			  xy_bond = 'Weak'
		  })
		  e.config.object:define_draw_steps({{
			shader = 'flame',
			send = {
				{name = 'time', ref_table = G.ARGS[v.arg_tab], ref_value = 'timer'},
				{name = 'amount', ref_table = G.ARGS[v.arg_tab], ref_value = 'real_intensity'},
				{name = 'image_details', ref_table = e.config.object, ref_value = 'image_dims'},
				{name = 'texture_details', ref_table = e.config.object.RETS, ref_value = 'get_pos_pixel'},
				{name = 'colour_1', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_1'},
				{name = 'colour_2', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_2'},
				{name = 'id', val =  e.config.object.ID},
			}}})
			e.config.object:get_pos_pixel()
		end
		local _F = G.ARGS[v.arg_tab]
		local exptime = math.exp(-0.4*G.real_dt)
		if to_big(G.ARGS.score_intensity.earned_score) >= to_big(G.ARGS.score_intensity.required_score) and to_big(G.ARGS.score_intensity.required_score) > to_big(0) then
		  _F.intensity = ((G.pack_cards and not G.pack_cards.REMOVED) or (G.TAROT_INTERRUPT)) and 0 or math.max(0., math.log(G.ARGS.score_intensity.earned_score, 7)-2)
			if type(_F.intensity) == "table" then
				if _F.intensity > to_big(may.flame_limit) then
					_F.intensity = may.flame_limit
				else
					_F.intensity = _F.intensity:to_number()
				end
			elseif _F.intensity > may.flame_limit then
				_F.intensity = may.flame_limit
			end
		else
		  _F.intensity = 0
		end
		_F.timer = _F.timer + G.real_dt*(1 + _F.intensity*0.2)
		if _F.intensity_vel < 0 then _F.intensity_vel = _F.intensity_vel*(1 - 10*G.real_dt) end
		_F.intensity_vel = (1-exptime)*(_F.intensity - _F.real_intensity)*G.real_dt*25 + exptime*_F.intensity_vel
		_F.real_intensity = math.max(0, _F.real_intensity + _F.intensity_vel)
		-- Cryptid compat
		_F.real_intensity = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.real_intensity + G.cry_flame_override['intensity'])/2) or _F.real_intensity
		if to_big(_F.real_intensity) > to_big(may.flame_limit) then
			_F.real_intensity = may.flame_limit
		end
		if (may.transcendence or 0) >= 10 then
			_F.real_intensity = may.flame_limit*math.random(1, 3)
		end
		_F.change = (_F.change or 0)*(1 - 4.*G.real_dt) + ( 4.*G.real_dt)*(_F.real_intensity < _F.intensity - 0.0 and 1 or 0)*_F.real_intensity
		-- Cryptid compat 2
		_F.change = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.change + G.cry_flame_override['intensity'])/2) or _F.change
		end
    end
end

local randtext = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	" ",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"+",
	"-",
	"?",
	"!",
	"$",
	"%",
	"[",
	"]",
	"(",
	")",
}

function may.obfuscatedtext(length)
	local str = ""
	for i = 1, length do
		str = str .. randtext[math.random(#randtext)]
	end
	return str
end

-- Automated Fusion notice generator
function may.add_fusion_text(joker)
	return "{C:inactive}This Joker can{} {C:dark_edition}fuse{} {C:inactive}with "..joker
end

local vanf_cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
	vanf_cuc(self)
	if self:gc().set == 'editioncards' and self:gc().key ~= 'c_may_nostalgic_card' then
		G.GAME.last_edition_card = self:gc().key
	end
end

function may.get_operation_sound(operation, chipsmult)
	operation = to_number(operation)
	if may.conf.CustomHyperoperations then
		if chipsmult == 'chips' then
			if operation == -1 then
				return 'chips'..math.random(1, 2)
			elseif operation == 0 then
				return 'talisman_xchip'
			elseif operation == 1 then
				return 'talisman_echip'
			elseif operation == 2 then
				return 'talisman_eechip'
			elseif operation == 3 then
				return 'talisman_eeechip'
			elseif operation == 4 then
				return 'may_hexchip'
			elseif operation == 5 then
				return 'may_hepchip'
			elseif operation == 6 then
				return 'may_octchip'
			elseif operation == 7 then
				return 'may_ennchip'
			elseif operation == 8 then
				return 'may_decchip'
			elseif operation == 9 then
				return 'may_undchip'
			elseif operation == 10 then
				return 'may_doechip'
			elseif operation >= 11 then
				return 'may_trechip'
			end
		elseif chipsmult == 'mult' then
			if operation == -1 then
				return 'multhit1'
			elseif operation == 0 then
				return 'multhit2'
			elseif operation == 1 then
				return 'talisman_emult'
			elseif operation == 2 then
				return 'talisman_eemult'
			elseif operation == 3 then
				return 'talisman_eeemult'
			elseif operation == 4 then
				return 'may_hexmult'
			elseif operation == 5 then
				return 'may_hepmult'
			elseif operation == 6 then
				return 'may_octmult'
			elseif operation == 7 then
				return 'may_ennmult'
			elseif operation == 8 then
				return 'may_decmult'
			elseif operation == 9 then
				return 'may_undmult'
			elseif operation == 10 then
				return 'may_doemult'
			elseif operation >= 11 then
				return 'may_tremult'
			end
		elseif chipsmult == 'dollars' then
			if operation == -1 then
				return 'coin3'
			elseif operation == 0 then
				return 'may_bigmoney'
			end
		elseif chipsmult == 'score' then
			if operation == -1 then
				return 'may_addscore'
			elseif operation == 0 then
				return 'may_xscore'
			elseif operation == 1 then
				return 'may_escore'
			elseif operation == 2 then
				return 'may_eescore'
			elseif operation == 3 then
				return 'may_eeescore'
			elseif operation == 4 then
				return 'may_hexscore'
			end
		end
	else
		if chipsmult == 'chips' then
			if operation == -1 then
				return 'chips'..math.random(1, 2)
			elseif operation == 0 then
				return 'talisman_xchip'
			elseif operation == 1 then
				return 'talisman_echip'
			elseif operation == 2 then
				return 'talisman_eechip'
			elseif operation >= 3 then
				return 'talisman_eeechip'
			end
		elseif chipsmult == 'mult' then
			if operation == -1 then
				return 'multhit1'
			elseif operation == 0 then
				return 'multhit2'
			elseif operation == 1 then
				return 'talisman_emult'
			elseif operation == 2 then
				return 'talisman_eemult'
			elseif operation >= 3 then
				return 'talisman_eeemult'
			end
		elseif chipsmult == 'dollars' then
			if operation == -1 then
				return 'coin3'
			elseif operation == 0 then
				return 'may_bigmoney'
			end
		elseif chipsmult == 'score' then
			if operation == -1 then
				return 'may_addscore'
			elseif operation == 0 then
				return 'may_xscore'
			elseif operation == 1 then
				return 'may_escore'
			elseif operation == 2 then
				return 'may_eescore'
			elseif operation == 3 then
				return 'may_eeescore'
			elseif operation == 4 then
				return 'may_hexscore'
			end
		end
	end
end

vanf_csc = Card.set_cost
function Card:set_cost()
	vanf_csc(self)
	if (self.edition or {}).may_print then self.cost = self.cost*0.3 end
	if self:gc().set == 'Joker' then
		if G.GAME.power_trip then
			if self:gc().rarity == 2 or self:gc().rarity == 3 then
				self.cost = 0
			end
		end
	end
end

-- Betmma compatibility (fairly sure it crashes without this mod but oh well)
if #SMODS.find_mod('BetmmaVouchers') ~= 0 then
function Card:redeem()
    if self.ability.set == "Voucher" then
        stop_use()
        if not self.config.center.discovered then
            discover_card(self.config.center)
        end
        if self.shop_voucher and G.GAME.current_round.voucher.spawn then G.GAME.current_round.voucher.spawn[self.config.center_key] = false end 
        if self.from_tag then G.GAME.current_round.voucher.spawn[G.GAME.current_round.voucher[1]] = false end

        self.states.hover.can = false
        G.GAME.used_vouchers[self.config.center_key] = true
        local top_dynatext = nil
        local bot_dynatext = nil
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                top_dynatext = DynaText({string = localize{type = 'name_text', set = self.config.center.set, key = self.config.center.key}, colours = {G.C.WHITE}, rotate = 1,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 0.6/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR})
                bot_dynatext = DynaText({string = localize('k_redeemed_ex'), colours = {G.C.WHITE}, rotate = 2,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 1.4/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR, pitch_shift = 0.25})
                self:juice_up(0.3, 0.5)
                play_sound('card1')
                play_sound('coin1')
                self.children.top_disp = UIBox{
                    definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                        {n=G.UIT.O, config={object = top_dynatext}}
                                    }},
                    config = {align="tm", offset = {x=0,y=0},parent = self}
                }
                self.children.bot_disp = UIBox{
                        definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                            {n=G.UIT.O, config={object = bot_dynatext}}
                                        }},
                        config = {align="bm", offset = {x=0,y=0},parent = self}
                    }
            return true end }))
        if self.cost ~= 0 then
            ease_dollars(-self.cost)
            inc_career_stat('c_shop_dollars_spent', self.cost)
        end
        inc_career_stat('c_vouchers_bought', 1)
        set_voucher_usage(self)
        check_for_unlock({type = 'run_redeem'})
        --G.GAME.current_round.voucher = nil

        G.GAME.current_round.cry_voucher_edition = nil
        G.GAME.current_round.cry_voucher_stickers = {eternal = false, perishable = false, rental = false, pinned = false, banana = false}
        self:apply_to_run()

        delay(0.6)
        SMODS.calculate_context({buying_card = true, card = self})
        if G.GAME.modifiers.inflation then 
            G.GAME.inflation = G.GAME.inflation + 1
            G.E_MANAGER:add_event(Event({func = function()
              for k, v in pairs(G.I.CARD) do
                  if v.set_cost then v:set_cost() end
              end
              return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2.6, func = function()
            top_dynatext:pop_out(4)
            bot_dynatext:pop_out(4)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
            self.children.top_disp:remove()
            self.children.top_disp = nil
            self.children.bot_disp:remove()
            self.children.bot_disp = nil
        return true end }))
    end
end

end

-- Mass redeem Vouchers
-- based on jl.voucher
-- can take in table of keys, or number of random vouchers
function may.massvoucher(keys, amount)
	if keys and type(keys) == 'table' then
		for k, v in pairs(keys) do
			if not G.P_CENTERS[v] then return end
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local card = Card(area.T.x + area.T.w/2 - G.CARD_W/2, area.T.y + area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[v],{bypass_discovery_center = true, bypass_discovery_ui = true})
			card:start_materialize()
			area:emplace(card)
			card.cost=0
			card.shop_voucher=false
			card:redeem()
			G.E_MANAGER:add_event(Event({delay = 0,func = function() 
				card:start_dissolve()
			return true end}))
		end
	else
		for i=1, amount, 1 do
			local key = get_next_voucher_key(true)
			if not G.P_CENTERS[key] then return end
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local card = Card(area.T.x + area.T.w/2 - G.CARD_W/2, area.T.y + area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[key],{bypass_discovery_center = true, bypass_discovery_ui = true})
			card:start_materialize()
			area:emplace(card)
			card.cost=0
			card.shop_voucher=false
			card:redeem()
			G.E_MANAGER:add_event(Event({delay = 0,func = function() 
				card:start_dissolve()
			return true end}))
		end
	end
		
end

-- Joker Pools
-- taken from Paperback 
if not SMODS.ObjectTypes.Food then
  SMODS.ObjectType {
    key = 'Food',
    default = 'j_gros_michel',
    cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_egg)
		self:inject_card(G.P_CENTERS.j_ice_cream)
		self:inject_card(G.P_CENTERS.j_cavendish)
		self:inject_card(G.P_CENTERS.j_turtle_bean)
		self:inject_card(G.P_CENTERS.j_diet_cola)
		self:inject_card(G.P_CENTERS.j_popcorn)
		self:inject_card(G.P_CENTERS.j_ramen)
		self:inject_card(G.P_CENTERS.j_selzer)
	end,
  }
end

function may.is_food(card)
	local center = type(card) == "string" and G.P_CENTERS[card] or (card.config and card.config.center)
	if not center then return false end
	if center.pools and center.pools.Food then
		return true
	end
	if center.key == 'j_gros_michel' or
	center.key == 'j_egg' or
	center.key == 'j_ice_cream' or
	center.key == 'j_cavendish' or
	center.key == 'j_turtle_bean' or
	center.key == 'j_diet_cola' or
	center.key == 'j_popcorn' or
	center.key == 'j_ramen' or
	center.key == 'j_selzer' then
		return true 
	end
end

if not SMODS.ObjectTypes.N then
	SMODS.ObjectType {
		key = 'N',
		default = 'j_may_n',
		cards = {},
	}
end

if not SMODS.ObjectTypes.N_bl then
	SMODS.ObjectType {
		key = 'N_bl',
		default = 'j_may_n',
		cards = {},
		inject = function(self)
			SMODS.ObjectType.inject(self)
			for k, v in pairs(G.P_CENTERS) do
				if G.P_CENTERS[k].pools and G.P_CENTERS[k].pools.N and type(G.P_CENTERS[k].rarity)== 'number' and G.P_CENTERS[k].rarity < 4 then
					local key = G.P_CENTERS[k].key
					self:inject_card(G.P_CENTERS.key)
				end
			end
		end
	}
end

-- !! n_jokers = true in the center of N jokers is deprecated! Use this instead
function may.is_n(card, below_legendary)
	local center = type(card) == "string" and G.P_CENTERS[card] or (card.config and card.config.center)
	if not center then return false end
	if not below_legendary then
		if center.pools and center.pools.N then
			return true
		end
	else
		if center.pools and center.pools.N and type(center.rarity) == 'number' and center.rarity < 4 then
			return true
		end
	end
end

-- Misc value increases (Hand Size, Card Selection Limit etc.)
-- taken from POLTERWORX
local vanf_casc = CardArea.change_size
function CardArea:change_size(mod, silent)
	vanf_casc(self, mod)
	if not silent then self:may_highlight_mod(mod) end
end

function CardArea:may_highlight_mod(mod)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = '+'
			local col = G.C.FILTER
			if mod < 0 then
				text = '-'
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
			-- juicing hand does some funky UI stuff so no
			if self ~= G.hand then
				self:juice_up()
			end
		return true end}))
		delay(0.5)
	end
end

function CardArea:change_max_highlight(mod, silent)
	self.config.highlighted_limit = self.config.highlighted_limit + (mod or 0)
	if self == G.hand then
		SMODS.change_play_limit(mod)
		SMODS.change_discard_limit(mod)
	end
	if not silent then self:may_highlight_mod_selection_limit(mod) end
end

function CardArea:may_highlight_mod_selection_limit(mod)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = 'Selection Limit +'
			local col = G.C.FILTER
			if mod < 0 then
				text = 'Selection Limit -'
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up()
			end
		return true end}))
		delay(0.5)
	end
end

-- Hyperoperations on CardArea slots
function CardArea:change_size_hyper(mod, arrow, silent)
	if mod ~= 0 then 
		G.E_MANAGER:add_event(Event({func = function() 
			self.config.real_card_limit = to_number(to_big((self.config.real_card_limit or self.config.card_limit)):arrow(arrow, mod))
			self.config.card_limit = math.max(0, self.config.real_card_limit)
			if mod > 0 and self.config.real_card_limit > 1 and self == G.hand and self.cards[1] and (G.STATE == G.STATES.DRAW_TO_HAND or G.STATE == G.STATES.SELECTING_HAND) then 
				local card_count = math.abs(mod)
				for i=1, card_count do
					draw_card(G.deck,G.hand, i*100/card_count,nil, nil , nil, 0.07)
					G.E_MANAGER:add_event(Event({func = function() self:sort() return true end}))
				end
			end
			if self == G.hand then check_for_unlock({type = 'min_hand_size'}) end
		return true end}))
    end
	if not silent then self:may_highlight_mod_hyper(mod, arrow) end
end

function CardArea:may_highlight_mod_hyper(mod, arrow)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text
			if arrow == 0 then
				text = 'X'
			else
				text = generate_arrow_text(arrow, 5)
			end
			local col = G.C.DARK_EDITION
			if mod < 1 then
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			if self == G.jokers then
				play_sound('may_hyper_joker_slots', 1, 0.3)
			elseif self == G.hand then
				play_sound('may_hyper_selection_limit', 1, 0.3)
			else
				play_sound('may_hyper_consumable_slots', 1, 0.3)
			end
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up()
			end
		return true end}))
		delay(0.5)
	end
end

function CardArea:change_max_highlight_hyper(mod, arrow, silent)
	self.config.highlighted_limit = to_number(to_big(self.config.highlighted_limit):arrow(arrow, mod))
	if not silent then self:may_highlight_mod_selection_limit_hyper(mod, arrow) end
end

function CardArea:may_highlight_mod_selection_limit_hyper(mod, arrow)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = 'Selection Limit'
			local col = G.C.DARK_EDITION
			if mod < 0 then
				col = G.C.RED
			end
			if arrow == 0 then
				text = text..' X'
			else
				text = text..' '..generate_arrow_text(arrow, 5)
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('may_hyper_selection_limit', 1, 0.3)
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up()
			end
		return true	end}))
		delay(0.5)
	end
end

-- OmegaNum operations

function Big:sqrt()
    local x = self:clone()
    if (x:lt(math.exp(-1/R.E))) then return R.NaN end
    if ((x or 1):isFinite()) then return x end
    if (x:gt(R.TETRATED_MAX_SAFE_INTEGER)) then return x end
    if (x:gt(R.EE_MAX_SAFE_INTEGER)) then
		x.array[2] = x.array[2] - 1
		return x
	end
    local l = x:ln()
    return l:div(l:lambertw())
end

-- ??????
function Big:ssrt()
    return self:sqrt()
end


function f_gamma(n)
	n = to_big(n)
	if not n:isFinite() then return n end
	if n < to_big(-50) then 
		if n == n:floor() then return R.NEGATIVE_INFINITY end
		return 0
    end
    local scal1 = 1
    while n < to_big(10) do 
		scal1=scal1*n
		n = n + to_big(1)
    end
	n = n - to_big(1)
    local l=0.9189385332046727
	l = l+(to_number(n) + 0.5)*n:logBase(to_big(2))
    l = l-to_number(n)
    local n2 = to_number(n)^2
    local np = to_number(n)
    l = l+1/(12*np)
    np = n2
    l = 1/(360*np)
    np = np*(np*n2)
    l = l+1/(1260*np)
    np = np*n2
    l = l-1/(1680*np)
    np = np*n2
    l = l+1/(1188*np)
    np = np*n2
    l = l-691/(360360*np)
    np = np*n2
    l = l+7/(1092*np)
    np = np*n2
    l = l-3617/(122400*np)
    return math.exp(l)/scal1
end

function Big:gamma()
	local x = self:clone()
	if (x:gt(R.TETRATED_MAX_SAFE_INTEGER)) then return x end
	if (x:gt(R.E_MAX_SAFE_INTEGER)) then return x:exp() end
	if (x:gt(R.MAX_SAFE_INTEGER)) then return (x:arrow(0, x:ln():sub(1))):exp() end
	local n = x.array[1]
	if n>1 then 
		if n<24 then return to_big(f_gamma(x.sign*n)) end
		local t = n-1;
		local l = 0.9189385332046727
		l = l+((t+0.5)*math.log(t))
		l= l - t
		local n2 = t^2
		local np = t
		local lm = 12*np
		local adj = 1/lm
		local l2 = l+adj
		if l2==l then return to_big(l):exp() end
		l = l2
		np = np*n2
		lm = 360*np
		adj = 1/lm
		l2 = l-adj
		if l2==l then return to_big(l):exp() end
		l=l2
		np = np*n2
		lm = 1260*np
		local lt=1/lm
		l = l+lt
		np = np*n2
		lm = 1680*np
		lt = 1/lm
		l = l- lt
		return to_big(l):exp()
    else 
		return self.rec()
	end
end
  
local factorials = {
1,1,2,6,24,120,720,
5040,40320,362880,
3628800,39916800,
479001600,6227020800,
87178291200,1307674368000,
20922789888000,355687428096000,
6402373705728000,121645100408832000,
2432902008176640000,51090942171709440000,
1.1240007277776076800e+21,2.5852016738884978213e+22,
6.2044840173323941000e+23,1.5511210043330986055e+25,
4.0329146112660565032e+26,1.0888869450418351940e+28,
3.0488834461171387192e+29,8.8417619937397018986e+30,
2.6525285981219106822e+32,8.2228386541779224302e+33,
2.6313083693369351777e+35,8.6833176188118859387e+36,
2.9523279903960415733e+38,1.0333147966386145431e+40,
3.7199332678990125486e+41,1.3763753091226345579e+43,
5.2302261746660111714e+44,2.0397882081197444123e+46,
8.1591528324789768380e+47,3.3452526613163807956e+49,
1.4050061177528799549e+51,6.0415263063373834074e+52,
2.6582715747884488694e+54,1.1962222086548018857e+56,
5.5026221598120891536e+57,2.5862324151116817767e+59,
1.2413915592536072528e+61,6.0828186403426752249e+62,
3.0414093201713375576e+64,1.5511187532873821895e+66,
8.0658175170943876846e+67,4.2748832840600254848e+69,
2.3084369733924137924e+71,1.2696403353658276447e+73,
7.1099858780486348103e+74,4.0526919504877214100e+76,
2.3505613312828784949e+78,1.3868311854568983861e+80,
8.3209871127413898951e+81,5.0758021387722483583e+83,
3.1469973260387939390e+85,1.9826083154044400850e+87,
1.2688693218588416544e+89,8.2476505920824715167e+90,
5.4434493907744306945e+92,3.6471110918188683221e+94,
2.4800355424368305480e+96,1.7112245242814129738e+98,
1.1978571669969892213e+100,8.5047858856786230047e+101,
6.1234458376886084639e+103,4.4701154615126843855e+105,
3.3078854415193862416e+107,2.4809140811395399745e+109,
1.8854947016660503806e+111,1.4518309202828587210e+113,
1.1324281178206296794e+115,8.9461821307829757136e+116,
7.1569457046263805709e+118,5.7971260207473678414e+120,
4.7536433370128420198e+122,3.9455239697206587884e+124,
3.3142401345653531943e+126,2.8171041143805501310e+128,
2.4227095383672734128e+130,2.1077572983795278544e+132,
1.8548264225739843605e+134,1.6507955160908460244e+136,
1.4857159644817615149e+138,1.3520015276784029158e+140,
1.2438414054641308179e+142,1.1567725070816415659e+144,
1.0873661566567430754e+146,1.0329978488239059305e+148,
9.9167793487094964784e+149,9.6192759682482120384e+151,
9.4268904488832479837e+153,9.3326215443944153252e+155,
9.3326215443944150966e+157,9.4259477598383598816e+159,
9.6144667150351270793e+161,9.9029007164861804721e+163,
1.0299016745145628100e+166,1.0813967582402909767e+168,
1.1462805637347083683e+170,1.2265202031961380050e+172,
1.3246418194518290179e+174,1.4438595832024936625e+176,
1.5882455415227430287e+178,1.7629525510902445874e+180,
1.9745068572210740115e+182,2.2311927486598137657e+184,
2.5435597334721876552e+186,2.9250936934930159967e+188,
3.3931086844518980862e+190,3.9699371608087210616e+192,
4.6845258497542909237e+194,5.5745857612076058231e+196,
6.6895029134491271205e+198,8.0942985252734440920e+200,
9.8750442008336010580e+202,1.2146304367025329301e+205,
1.5061417415111409314e+207,1.8826771768889261129e+209,
2.3721732428800468512e+211,3.0126600184576594309e+213,
3.8562048236258040716e+215,4.9745042224772874590e+217,
6.4668554892204741474e+219,8.4715806908788206314e+221,
1.1182486511960043298e+224,1.4872707060906857134e+226,
1.9929427461615187928e+228,2.6904727073180504073e+230,
3.6590428819525488642e+232,5.0128887482749919605e+234,
6.9177864726194885808e+236,9.6157231969410893532e+238,
1.3462012475717525742e+241,1.8981437590761708898e+243,
2.6953641378881628530e+245,3.8543707171800730787e+247,
5.5502938327393044385e+249,8.0479260574719917061e+251,
1.1749972043909107097e+254,1.7272458904546389230e+256,
2.5563239178728653927e+258,3.8089226376305697893e+260,
5.7133839564458546840e+262,8.6272097742332399855e+264,
1.3113358856834524492e+267,2.0063439050956822953e+269,
3.0897696138473507759e+271,4.7891429014633940780e+273,
7.4710629262828942235e+275,1.1729568794264144743e+278,
1.8532718694937349890e+280,2.9467022724950384028e+282,
4.7147236359920616095e+284,7.5907050539472189932e+286,
1.2296942187394494177e+289,2.0044015765453026266e+291,
3.2872185855342959088e+293,5.4239106661315886750e+295,
9.0036917057784375454e+297,1.5036165148649991456e+300,
2.5260757449731984219e+302,4.2690680090047051083e+304,
7.2574156153079990350e+306
}
function Big:fact(times)
	self = to_big(self)
	local x = self:clone()
	x = x:ceil()
	local f = factorials
	local errorFixer = 1
	for i=1, (to_number(times) or 1), 1 do
		x = x:ceil()
		if x:lte(R.ZERO) or not (x or 0):isint() then 
			x = x:add(1):gamma() 
		end
		if x:lte(170) then 
			if to_number(x) == 0 then
				x = to_big(1)
			elseif to_number(x) == 170 then
				x = to_big(7.2574156153079990350e+306)
			else
				x = to_big(factorials[to_number(x)+1])
			end
		else
			x = x:div(R.E):pow(x):mul(x:mul(R.PI):mul(2):sqrt()):mul(errorFixer)
		end
	end
	return x:normalize()
end

-- Torian: T(a) = a!(a)
function Big:torian()
	if self:gt(to_big(1e308)) then
		return self:fact(1e308)
	else
		return self:fact(self)
	end
end

-- Aperiotion: {a,b} = a{b}a
function Big:aperiorate(arrow)
	if not arrow then return 0 end
	return self:arrow(arrow, self)
end

-- Extension: a<-> = a{a}a
function Big:extend()
	local val = self:arrow(self, self)
	-- this is a very powerful function so we should check if the result is infinity
	if val == R.POSITIVE_INFINITY or val == R.NaN then
		return to_big(10):arrow(maxArrow, 10)
	else
		return val
	end
end

-- Exponential Factorial: a^! = a^a-1^a-2^a-3..^a-n (where a-n is 2)
local exponential_factorials = {1, 1, 2, 9, 262144}

function Big:expofact(times)
	local x = self:clone()
	x = x:ceil()
	for i=1, (times or 1), 1 do
		if x:lte(4) then
			x = x:ceil()
			if to_number(x) == 0 then
				x = to_big(1)
			elseif to_number(x) == 4 then
				x = to_big(262144)
			else
				x = to_big(exponential_factorials[to_number(x)+1])
			end
		else
			x = (to_big(10):arrow(2, x:sub(2.2787667783))):normalize()
		end
	end
	return x:normalize()
end

-- Superfactorial (Pickover): a$ = a!^^a!
function Big:pick_superfactorial(times)
	local x = self:clone()
	x = x:ceil()
	for i=1, (times or 1), 1 do
		x = x:fact():arrow(2, x:fact())
	end
	return x:normalize()
end

-- Factorexation: a\ = a!^a! = a!^^2
function Big:factorexate(times)
	local x = self:clone()
	x = x:ceil()
	for i=1, (times or 1), 1 do
		x = x:fact():arrow(2, 2)
	end
	return x:normalize()
end

function Card:get_chip_fact_mult()
    if self.debuff then return false end
    if self.ability.set == 'Joker' then return false end
    return (self.ability.fact_mult or false)
end

function Card:get_chip_fact_bonus()
    if self.debuff then return false end
    if self.ability.set == 'Joker' then return false end
    return (self.ability.fact_chips or false)
end

-- Midground sprites
-- Taken from Cryptid
if #SMODS.find_mod('Cryptid') == 0 then

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front)
    if _center and _center.name == "cry-Gateway" then
        self.children.floating_sprite = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            { x = 2, y = 0 }
        )
        self.children.floating_sprite.role.draw_major = self
        self.children.floating_sprite.states.hover.can = false
        self.children.floating_sprite.states.click.can = false
        self.children.floating_sprite2 = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            { x = 1, y = 0 }
        )
        self.children.floating_sprite2.role.draw_major = self
        self.children.floating_sprite2.states.hover.can = false
        self.children.floating_sprite2.states.click.can = false
    end
    if _center and _center.soul_pos and _center.soul_pos.extra then
        self.children.floating_sprite2 = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            _center.soul_pos.extra
        )
        self.children.floating_sprite2.role.draw_major = self
        self.children.floating_sprite2.states.hover.can = false
        self.children.floating_sprite2.states.click.can = false
    end
end

SMODS.DrawStep({
	key = "floating_sprite2",
	order = 59,
	func = function(self)
		if self.ability.name == "cry-Gateway" and (self.config.center.discovered or self.bypass_discovery_center) then
			local scale_mod2 = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod2 = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			self.children.floating_sprite2:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod2,
				rotate_mod2,
				nil,
				0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
				nil,
				0.6
			)
			self.children.floating_sprite2:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod2,
				rotate_mod2
			)

			local scale_mod = 0.05
				+ 0.05 * math.sin(1.8 * G.TIMERS.REAL)
				+ 0.07
					* math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
			local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
				+ 0.07
					* math.sin(G.TIMERS.REAL * math.pi * 5)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

			self.children.floating_sprite.role.draw_major = self
			self.children.floating_sprite:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			self.children.floating_sprite:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod
			)
		end
		if
			self.config.center.soul_pos
			and self.config.center.soul_pos.extra
			and (self.config.center.discovered or self.bypass_discovery_center)
		then
			local scale_mod = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			if self.children.floating_sprite2 then
				self.children.floating_sprite2:draw_shader(
					"dissolve",
					0,
					nil,
					nil,
					self.children.center,
					scale_mod,
					rotate_mod,
					nil,
					0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
					nil,
					0.6
				)
				self.children.floating_sprite2:draw_shader(
					"dissolve",
					nil,
					nil,
					nil,
					self.children.center,
					scale_mod,
					rotate_mod
				)
			else
				local center = self.config.center
				if _center and _center.soul_pos and _center.soul_pos.extra then
					self.children.floating_sprite2 = Sprite(
						self.T.x,
						self.T.y,
						self.T.w,
						self.T.h,
						G.ASSET_ATLAS[_center.atlas or _center.set],
						_center.soul_pos.extra
					)
					self.children.floating_sprite2.role.draw_major = self
					self.children.floating_sprite2.states.hover.can = false
					self.children.floating_sprite2.states.click.can = false
				end
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})
SMODS.draw_ignore_keys.floating_sprite2 = true

end

-- Number shakiness 
-- slightly modified code from POLTERWORX

function DynaText:pulse(amt, shake)
	if may.conf.Shakiness.shake_screen then
		self.config.pulse = {
			speed = 40,
			width = 2.5,
			start = G.TIMERS.REAL, 
			amount = amt or 0.2,
			silent = false,
			shake_screen = shake or false
		}
	else
		self.config.pulse = {
			speed = 40,
			width = 2.5,
			start = G.TIMERS.REAL, 
			amount = amt or 0.2,
			silent = false,
			shake_screen = false
		}
	end
end

function G.FUNCS.tsj_specific(e, quiver, pulse, juice, shake_screen)
	if e and e.config and e.config.object and next(e.config.object) then
		if may.conf.Shakiness.unlimitquiver then
			e.config.object:set_quiver(quiver)
		else
			e.config.object:set_quiver(math.min(may.conf.Shakiness.quiverlimit, quiver))
		end
		if may.conf.Shakiness.unlimitpulse then
			e.config.object:pulse(pulse, shake_screen)
		else
			e.config.object:pulse(math.min(may.conf.Shakiness.pulselimit, pulse), shake_screen)
		end
		e.config.object:update_text()
		e.config.object:align_letters()
		e:update_object()
		if juice then
			e.config.object:juice_up()
		end
	end
end

G.FUNCS.hand_mult_UI_set = function(e)
	local new_mult_text = number_format(G.GAME.current_round.current_hand.mult)
	if new_mult_text ~= G.GAME.current_round.current_hand.mult_text then
		G.GAME.current_round.current_hand.mult_text = new_mult_text
		e.config.object.scale = scale_number(G.GAME.current_round.current_hand.mult, 0.9, 1000)
		e.config.object:update_text()
		local comparison = G.GAME.current_round.current_hand.mult
		if type(comparison) == 'number' then
			comparison = Big:create(comparison)
		elseif type(comparison) == 'string' then
			comparison = Big:create(1)
		end
		if not G.TAROT_INTERRUPT_PULSE then
			if comparison > Big:create(1e308):arrow(2000, 2) then
				G.FUNCS.tsj_specific(e, 10, 200, false, true)
			elseif comparison > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100, false, true)
			elseif comparison > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 7.5, 60, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 5.5, 33, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(9, 3) then
				G.FUNCS.tsj_specific(e, 5, 30, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(8, 3) then
				G.FUNCS.tsj_specific(e, 4.5, 27, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(7, 3) then
				G.FUNCS.tsj_specific(e, 4, 24, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(6, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif comparison > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif comparison > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif comparison > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
			else
				G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10((type(G.GAME.current_round.current_hand.mult) == 'number' or type(G.GAME.current_round.current_hand.mult) == 'table') and G.GAME.current_round.current_hand.mult or 1))))
			end
		end
		if comparison > Big:create(1e100):arrow(2, 100) then
			G.ROOM.jiggle = G.ROOM.jiggle + math.min(5, to_number(comparison:arrow(3, 0.01)))
		end
	end
end

G.FUNCS.hand_chip_UI_set = function(e)
	local new_chip_text = number_format(G.GAME.current_round.current_hand.chips)
	if new_chip_text ~= G.GAME.current_round.current_hand.chip_text then
		G.GAME.current_round.current_hand.chip_text = new_chip_text
		e.config.object.scale = scale_number(G.GAME.current_round.current_hand.chips, 0.9, 1000)
		e.config.object:update_text()
		local comparison = G.GAME.current_round.current_hand.chips
		if type(comparison) == 'number' then
			comparison = Big:create(comparison)
		elseif type(comparison) == 'string' then
			comparison = Big:create(1)
		end
		if not G.TAROT_INTERRUPT_PULSE then
			if comparison > Big:create(1e308):arrow(2000, 2) then
				G.FUNCS.tsj_specific(e, 10, 200, false, true)
			elseif comparison > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100, false, true)
			elseif comparison > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 7.5, 60, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 5.5, 33, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(9, 3) then
				G.FUNCS.tsj_specific(e, 5, 30, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(8, 3) then
				G.FUNCS.tsj_specific(e, 4.5, 27, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(7, 3) then
				G.FUNCS.tsj_specific(e, 4, 24, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(6, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif comparison > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif comparison > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif comparison > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
			else
				G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10((type(G.GAME.current_round.current_hand.chips) == 'number' or type(G.GAME.current_round.current_hand.chips) == 'table') and G.GAME.current_round.current_hand.chips or 1))))
			end
		end
		if comparison > Big:create(1e100):arrow(2, 100) then
			G.ROOM.jiggle = G.ROOM.jiggle + math.min(5, to_number(comparison:arrow(3, 0.01)))
		end
    end
end

G.FUNCS.hand_chip_total_UI_set = function(e)
	if to_big(G.GAME.current_round.current_hand.chip_total) < to_big(1) then
		G.GAME.current_round.current_hand.chip_total_text = ''
	else
		local new_chip_total_text = number_format(G.GAME.current_round.current_hand.chip_total)
		if new_chip_total_text ~= G.GAME.current_round.current_hand.chip_total_text then 
			e.config.object.scale = scale_number(G.GAME.current_round.current_hand.chip_total, 0.95, 100000000)
			
			G.GAME.current_round.current_hand.chip_total_text = new_chip_total_text
			local comparison = G.GAME.current_round.current_hand.chip_total
			if type(comparison) == 'number' then
				comparison = Big:create(comparison)
			elseif type(comparison) == 'string' then
				comparison = Big:create(1)
			end
			if comparison > Big:create(1e100):arrow(1, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 40
			elseif comparison > Big:create(1e100):arrow(2, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 80
			elseif comparison > Big:create(1e100):arrow(3, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 120
			elseif comparison > Big:create(1e100):arrow(4, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 200
			elseif comparison > Big:create(1e100):arrow(5, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 280
			elseif comparison > Big:create(1e100):arrow(6, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 360
			elseif comparison > Big:create(1e100):arrow(7, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 560
			elseif comparison > Big:create(1e100):arrow(8, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 760
			elseif comparison > Big:create(1e100):arrow(10, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 1160
			elseif comparison > Big:create(1e100):arrow(30, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 1600
			elseif comparison > Big:create(1e100):arrow(150, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle +  2400
			elseif comparison > Big:create(1e100):arrow(800, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 3200
			elseif comparison > Big:create(1e100):arrow(5000, 100) then
				G.ROOM.jiggle = G.ROOM.jiggle + 4000
			end
			if comparison > Big:create(1e100):arrow(2, 100) then
				play_sound('may_huge_score', 1, 2)
			end
			if comparison > Big:create(1e308):arrow(2000, 2) then
				G.FUNCS.tsj_specific(e, 10, 200, false, true)
			elseif comparison > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100, false, true)
			elseif comparison > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 7.5, 60, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 5.5, 33, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(9, 3) then
				G.FUNCS.tsj_specific(e, 5, 30, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(8, 3) then
				G.FUNCS.tsj_specific(e, 4.5, 27, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(7, 3) then
				G.FUNCS.tsj_specific(e, 4, 24, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(6, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif comparison > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif comparison > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif comparison > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
				G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log((type(G.GAME.current_round.current_hand.chip_total) == 'number' or type(G.GAME.current_round.current_hand.chip_total) == 'table') and G.GAME.current_round.current_hand.chip_total or 1))))
			end
			G.ARGS.hand_chip_total_UI_set = G.GAME.current_round.current_hand.chip_total
		end
	end
end

-- Custom soul effects 
-- Taken from Grim

SMODS.Atlas({ key = "special_spectral", atlas_table = "ASSET_ATLAS", path = "spectral.png", px = 65, py = 95,
	inject = function(self)
		local file_path = type(self.path) == 'table' and
			(self.path[G.SETTINGS.language] or self.path['default'] or self.path['en-us']) or self.path
		if file_path == 'DEFAULT' then return end
		-- language specific sprites override fully defined sprites only if that language is set
		if self.language and not (G.SETTINGS.language == self.language) then return end
		if not self.language and self.obj_table[('%s_%s'):format(self.key, G.SETTINGS.language)] then return end
		self.full_path = (self.mod and self.mod.path or SMODS.path) ..
			'assets/' .. G.SETTINGS.GRAPHICS.texture_scaling .. 'x/' .. file_path
		local file_data = assert(NFS.newFileData(self.full_path),
			('Failed to collect file data for Atlas %s'):format(self.key))
		self.image_data = assert(love.image.newImageData(file_data),
			('Failed to initialize image data for Atlas %s'):format(self.key))
		self.image = love.graphics.newImage(self.image_data,
			{ mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
		G[self.atlas_table][self.key_noloc or self.key] = self
		G.macrocosm = Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], {x = 3,y = 2})
		G.genesis = Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], {x = 1,y = 2})
	end
})

local vanf_soul = SMODS.DrawSteps['soul'].func
SMODS.DrawSteps['soul'].func = function(self)
    if self.ability.name == 'Macrocosm' and (self.config.center.discovered or self.bypass_discovery_center) then
		local scale_mod = 0
		local rotate_mod = 0

		G.macrocosm.role.draw_major = self
		G.macrocosm:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        G.macrocosm:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod+(math.sin(G.TIMERS.REAL/3)/9), rotate_mod)
	end
	if self.ability.name == 'Genesis' and (self.config.center.discovered or self.bypass_discovery_center) then
		local scale_mod = math.sin(G.TIMERS.REAL/3)/6
		local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2 + (math.random(-500, 500)/10000)

		G.genesis.role.draw_major = self
		G.genesis:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        G.genesis:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end
    vanf_soul(self)
end

function lphand()
	if not G.GAME then return 0 else
		local chosen_hand = 'High Card'
		local lowest_amount = math.huge
		for _, v in ipairs(G.handlist) do
			if G.GAME.hands[v].played <= lowest_amount then
				chosen_hand = v
				lowest_amount = G.GAME.hands[v].played
			end
		end
		return chosen_hand
	end
end

function table_hasvalue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function get_mphand_level()
	if not G.GAME then return 0 end
	return G.GAME.hands[jl.favhand()].level 
end

-- Custom chip-mult operations
if SMODS and SMODS.calculate_individual_effect then
	local scie = SMODS.calculate_individual_effect
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local ret = scie(effect, scored_card, key, amount, from_edition)
		if ret then
		  return ret
		end
		if (key == 'ape_mult' or key == 'APEmult_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			mult = mod_mult(to_big(mult):aperiorate(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_apemult(scored_card or effect.card or effect.focus, 'may_apemult', amount, percent)
			end
			return true
		end
		if (key == 'ape_chip' or key == 'APEchip_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hand_chips = mod_chips(to_big(hand_chips):aperiorate(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_apechip(scored_card or effect.card or effect.focus, 'may_apechip', amount, percent)
			end
			return true
		end
		if (key == 'fact_mult' or key == 'FACTmult_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			mult = mod_mult(to_big(mult):fact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_factmult(scored_card or effect.card or effect.focus, 'may_factmult', amount, percent)
			end
			return true
		end
		if (key == 'fact_chip' or key == 'FACTchip_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hand_chips = mod_chips(to_big(hand_chips):fact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_factchip(scored_card or effect.card or effect.focus, 'may_factchip', amount, percent)
			end
			return true
		end
		if (key == 'expofact_mult' or key == 'EXPOFACTmult_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			mult = mod_mult(to_big(mult):expofact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_expofactmult(scored_card or effect.card or effect.focus, 'may_expofactmult', amount, percent)
			end
			return true
		end
		if (key == 'expofact_chips' or key == 'EXPOFACTchip_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hand_chips = mod_chips(to_big(hand_chips):expofact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_expofactchip(scored_card or effect.card or effect.focus, 'may_expofactchip', amount, percent)
			end
			return true
		end
		if (key == 'x_dollars' or key == 'xdollars_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hypermoney(0, amount, true)
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_xdollars(scored_card or effect.card or effect.focus, 'may_bigmoney', amount, percent)
			end
			return true
		end
		if key == 'super_level_up' then
			if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
			local hand_type = effect.level_up_hand or G.GAME.last_hand_played
			may.level_up_hand_hyper(scored_card, hand_type, effect.instant, type(amount) == 'number' and amount or 1)
			return true
		end
		-- ! score operations should be done on context.after
		if (key == 'score' or key == 'SCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):add(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_addscore(scored_card or effect.card or effect.focus, 'may_addscore', amount, percent)
			end
			return true
		end
		if (key == 'x_score' or key == 'XSCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):mul(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4, 0.4)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_xscore(scored_card or effect.card or effect.focus, 'may_xscore', amount, percent)
			end
			return true
		end
		if (key == 'e_score' or key == 'ESCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(1, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.5, 0.5)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_escore(scored_card or effect.card or effect.focus, 'may_escore', amount, percent)
			end
			return true
		end
		if (key == 'ee_score' or key == 'EESCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(2, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.6, 0.6)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eescore(scored_card or effect.card or effect.focus, 'may_eescore', amount, percent)
			end
			return true
		end
		if (key == 'eee_score' or key == 'EEESCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(3, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.7, 0.7)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eeescore(scored_card or effect.card or effect.focus, 'may_eeescore', amount, percent)
			end
			return true
		end
		if key == 'hyper_score' then 
			local e = card_eval_status_text
			-- dont know who or what this would save but hhhhhh
			if type(amount) ~= 'table' then
				local operand = amount
				amount = {3, operand}
			end
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(amount[1], amount[2])
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4 + (amount[1] * 0.1), 0.7)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4 + (amount[1] * 0.1), 0.7)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_hyper_score(scored_card or effect.card or effect.focus, 'may_eeescore', amount, percent)
			end
			return true
		end
		if (key == 'eq_mult' or key == 'EQmult_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			mult = mod_mult(to_big(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eqmult(scored_card or effect.card or effect.focus, 'may_eqmult', amount, percent)
			end
			return true
		end
		if (key == 'eq_chips' or key == 'EQchip_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hand_chips = mod_chips(to_big(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eqchip(scored_card or effect.card or effect.focus, 'may_eqchip', amount, percent)
			end
			return true
		end
		if (key == 'eq_score' or key == 'EQSCORE_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			 G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.2, 0.2)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eqscore(scored_card or effect.card or effect.focus, 'may_eqscore', amount, percent)
			end
			return true
		end
		if key == 'eq_dollars' then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			ease_dollars(to_big(0):sub(to_big(G.GAME.dollars)):add(to_big(amount)))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eqdollars(scored_card or effect.card or effect.focus, 'may_eqdollars', amount, percent)
			end
			return true
		end
		if key == 'hyper_mult' or key == 'hypermult_mod' then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			mult = mod_mult(to_big(mult):arrow(amount[1], amount[2]))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_hyper_mult(scored_card or effect.card or effect.focus, 'may_hyper_mult', amount, percent)
			end
			return true
		end
		if key == 'hyper_chips' or key == 'hyperchip_mod' then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			hand_chips = mod_chips(to_big(hand_chips):arrow(amount[1], amount[2]))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_hyper_chips(scored_card or effect.card or effect.focus, 'may_hyper_chips', amount, percent)
			end
			return true
		end
	end
    for _, v in ipairs({
		'ape_mult', 'APEmult_mod', 
		'ape_chip', 'APEchip_mod', 
		'fact_mult', 'FACTmult_mod', 
		'fact_chip', 'FACTchip_mod', 
		'expofact_mult', 'EXPOFACTmult_mod', 
		'expofact_chip', 'EXPOFACTchip_mod',
		'score', 'SCORE_mod',
		'x_score', 'XSCORE_mod',
		'e_score', 'ESCORE_mod',
		'ee_score', 'EESCORE_mod',
		'eee_score', 'EEESCORE_mod',
		'hyper_score',
		'eq_mult', 'EQmult_mod',
		'eq_chips', 'EQchip_mod',
		'eq_score', 'EQSCORE_mod',
		'eq_dollars',
		'x_dollars', 'xdollars_mod',
		'hyper_mult', 'hyper_chips',
		'super_level_up'
	}) do
        table.insert(SMODS.calculation_keys, v)
    end
end

-- score color
may.C = {}
may.C.score = HEX('f024ff')
G.ARGS.LOC_COLOURS.may_score = may.C.score

function card_eval_status_text_hyper_mult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'mult')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Mult'
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_hyper_chips(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'chips')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Chips'
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqmult'
	amt = amt
	text = 'Mult='..amt
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqchip'
	amt = amt
	text = 'Chips='..amt
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqscore'
	amt = amt
	text = 'Score='..amt
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqdollars(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqdollars'
	amt = amt
	text = '$='..amt
	colour = G.C.MONEY
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_addscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_addscore'
	amt = amt
	text = '+'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_xscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_xscore'
	amt = amt
	text = 'X'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_escore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_escore'
	amt = amt
	text = '^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.8
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eescore'
	amt = amt
	text = '^^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.9
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eeescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eeescore'
	amt = amt
	text = '^^^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(30, math.log(amt, 500))
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_hyper_score(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'score')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(40, math.log(amt, 500))
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_apemult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_apemult'
	amt = amt
	text = "{Mult, "..amt.."}"
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_apechip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_apechip'
	amt = amt
	text = "{Chips, "..amt.."}"
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_factmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_factmult'
	amt = amt
	text = 'Mult'..generate_fact_text(amt, 20)
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_factchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_factchip'
	amt = amt
	text = 'Chips'..generate_fact_text(amt, 20)
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_expofactmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_expofactmult'
	amt = amt
	text = 'Mult'..generate_expofact_text(amt, 20)
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_expofactchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_expofactchip'
	amt = amt
	text = 'Chips'..generate_expofact_text(amt, 20)
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_xdollars(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_bigmoney'
	amt = amt
	text = "X"..amt..'$'
	colour = G.C.MONEY
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

-- Fusion Jokers stuff

function FusionJokers.fusions:add_fusion(joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, code, shake)
	table.insert(self, 
		{ jokers = {
			{ name = joker1, carry_stat = carry_stat1, extra_stat = extra1 },
			{ name = joker2, carry_stat = carry_stat2, extra_stat = extra2 }
		}, result_joker = result_joker, cost = cost, sound = sound, condition = condition, code = code, shake = shake})
end

local function has_joker(val, start_pos)
	if not start_pos then
		start_pos = 0
	end
	for i, v in ipairs(G.jokers.cards) do
		if v.ability.set == 'Joker' and v.config.center_key == val and i > start_pos then
			return i
		end
	end
	return -1
end


function Card:fuse_card()
	G.CONTROLLER.locks.selling_card = true
    stop_use()
    local area = self.area
    G.CONTROLLER:save_cardarea_focus('jokers')

    if self.children.use_button then self.children.use_button:remove(); self.children.use_button = nil end
    if self.children.sell_button then self.children.sell_button:remove(); self.children.sell_button = nil end

	local my_pos = has_joker(self.config.center_key)

	local edition = nil
	if self.edition then
		edition = self.edition
	end

	local chosen_fusion = nil
	local joker_pos = {}
	local found_me = false
	for _, fusion in ipairs(FusionJokers.fusions) do
		joker_pos = {}
		found_me = false
		for _, joker in ipairs(fusion.jokers) do
			if fusion.jokers[1].name == fusion.jokers[2].name then
				if #SMODS.find_card(joker.name) > 1 and #joker_pos == 0 then
					local first_pos = has_joker(joker.name)
					table.insert(joker_pos, {pos = first_pos, joker = joker})
					table.insert(joker_pos, {pos = has_joker(joker.name, first_pos), joker = joker})
				end
			elseif next(SMODS.find_card(joker.name)) then
				table.insert(joker_pos, {pos = has_joker(joker.name), joker = joker})
			end
			if joker.name == self.config.center_key then
				found_me = true
			end
		end

		if #joker_pos == #fusion.jokers and found_me then
			chosen_fusion = fusion
			break
		end
	end

	if chosen_fusion ~= nil then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
			play_sound('whoosh1')
			for _, pos in ipairs(joker_pos) do
				if not edition and G.jokers.cards[pos.pos].edition then
					edition = G.jokers.cards[pos.pos].edition
				end
				G.jokers.cards[pos.pos]:juice_up(0.3, 0.4)
			end
			return true
		end}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			ease_dollars(-chosen_fusion.cost)
			local j_fusion = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_fusion.result_joker, nil)
			if edition and not j_fusion.edition then
				j_fusion.edition = edition
			end
			table.sort(joker_pos, function (a, b)
				return a.pos > b.pos
			end)
			for index, pos in ipairs(joker_pos) do
				local isPrimary = false
				if G.jokers.cards[pos.pos] == self then
					isPrimary = true
				end
				for k,_ in pairs(SMODS.Stickers) do
					if G.jokers.cards[pos.pos].ability[k] then
						-- if string.find(k, "gemslot") then
						-- 	local gemExists = false
						-- 	for k1, _ in pairs(j_fusion.ability) do
						-- 		if string.find(k1, "gemslot") then
						-- 				gemExists = true
						-- 		end
						-- 	end
						-- 	if isPrimary then
						-- 		j_fusion.ability[k] = true
						-- 	end
						-- else
							j_fusion.ability[k] = true
						--end
					end
				end
				local check_joker = pos.joker
				if check_joker.carry_stat then
					if check_joker.extra_stat then
						j_fusion.ability.extra[check_joker.carry_stat] = G.jokers.cards[pos.pos].ability.extra[check_joker.carry_stat]
					else
						j_fusion.ability[check_joker.carry_stat] = G.jokers.cards[pos.pos].ability[check_joker.carry_stat]
					end
				end
				if check_joker.merge_stat then
					if chosen_fusion.merge_extra then
						if check_joker.extra_stat then
							j_fusion.ability.extra[chosen_fusion.merged_stat] = j_fusion.ability.extra[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability.extra[check_joker.merge_stat]
						else
							j_fusion.ability.extra[chosen_fusion.merged_stat] = j_fusion.ability.extra[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability[check_joker.merge_stat]
						end
					else
						if check_joker.extra_stat then
							j_fusion.ability[chosen_fusion.merged_stat] = j_fusion.ability[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability.extra[check_joker.merge_stat]
						else
							j_fusion.ability[chosen_fusion.merged_stat] = j_fusion.ability[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability[check_joker.merge_stat]
						end
					end
				end
				--G.jokers.cards[pos]:start_dissolve({G.C.GOLD})
				G.jokers.cards[pos.pos]:remove()
			end
			
			delay(0.3)

			j_fusion:add_to_deck()
			G.jokers:emplace(j_fusion)
			play_sound('explosion_release1')
			if chosen_fusion.sound then
				play_sound(chosen_fusion.sound)
			end
			if chosen_fusion.code then
				chosen_fusion.code()
			end
			if chosen_fusion.shake then
				G.ROOM.jiggle = G.ROOM.jiggle + chosen_fusion.shake
			end

			delay(0.1)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3, blocking = false,
			func = function()
				G.E_MANAGER:add_event(Event({trigger = 'immediate',
				func = function()
					G.E_MANAGER:add_event(Event({trigger = 'immediate',
					func = function()
						G.CONTROLLER.locks.selling_card = nil
						G.CONTROLLER:recall_cardarea_focus(area == G.jokers and 'jokers' or 'consumeables')
					return true
					end}))
				return true
				end}))
			return true
			end}))
			return true
		end}))
	end

	G.CONTROLLER.locks.selling_card = nil
	G.CONTROLLER:recall_cardarea_focus('jokers')
end

-- Level up hand context
-- Use this function so you dont get infinite loops
level_up_hand_nctx = level_up_hand

local vanf_luh = level_up_hand
function level_up_hand(card, hand, instant, amount)
	vanf_luh(card, hand, instant, amount)
	SMODS.calculate_context({level_up_hand = true, other_card = card, hand = (hand or 'High Card'), instant = (instant or false), amount = (amount or 1)})
end

	-- Rarities

SMODS.Rarity{
	key = 'mythic',
	name = "Mythic",
	loc_txt = {
		name = "Mythic"
	},
	badge_colour = G.C.FILTER,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'mystery',
	name = "??????",
	loc_txt = {
		name = "??????"
	},
	badge_colour = G.C.BLACK,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'transcendent',
	loc_txt = {
	name = "Transcendent"
	},
	badge_colour = G.C.DARK_EDITION,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'surreal',
	loc_txt = {
		name = "Surreal"
	},
	badge_colour = SMODS.Gradients.may_col_surreal,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'interdimensional',
	loc_txt = {
		name = "Interdimensional"
	},
	badge_colour = SMODS.Gradients.may_col_interdimensional,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'ethereal',
	loc_txt = {
		name = "Ethereal",
	},
	badge_colour = SMODS.Gradients.may_col_ethereal,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'hyperascendant',
	name = "HyperAscendant",
	loc_txt = {
		name = "HyperAscendant"
	},
	badge_colour = SMODS.Gradients.may_col_hyperascendant,
	default_rate = 0,
	pools = {["Joker"] = true}
}

	-- Misc badges

--[[ local editionplanet = function(self, card, badges)
	badges[#badges + 1] = create_badge('Edition Planet', get_type_colour(self or card.config, card), nil, 1.2)
end ]]

may_wip_badge = {
	colour = SMODS.Gradients.may_col_may_wip_badge,
	text_colour = G.C.WHITE,
	text = {
		'WIP'
	}
}

may_hidden_enhancement = {
	colour = SMODS.Gradients.may_col_hidden_enhancement,
	text_colour = G.C.WHITE,
	text = {
		'Hidden Enhancement',
		'Can only be found randomly'
	}
}

may_rare = {
	colour = G.C.RARITY[3],
	text_colour = G.C.WHITE,
	text = {
		'Rare'
	}
}

may_red_dwarf = {
	colour = G.C.SECONDARY_SET.Planet,
	text_colour = G.C.WHITE,
	text = {
		'Red Dwarf'
	}
}

may_legendary_badge = {
	colour = G.C.RARITY[4],
	text_colour = G.C.WHITE,
	text = {
		'Legendary'
	}
}

may_epic_badge = {
	colour = HEX("ef0098"),
	text_colour = G.C.WHITE,
	text = {
		'Epic'
	}
}

may_rare_badge = {
	colour = G.C.RARITY[3],
	text_colour = G.C.WHITE,
	text = {
		'Rare'
	}
}

may_uncommon_badge = {
	colour = G.C.RARITY[2],
	text_colour = G.C.WHITE,
	text = {
		'Uncommon'
	}
}

may_transcendent_badge = {
	colour = G.C.DARK_EDITION,
	text_colour = G.C.WHITE,
	text = {
		'Transcendent'
	}
}

may_ascended_badge = {
	colour = SMODS.Gradients.may_col_huge_operator,
	text_colour = G.C.WHITE,
	text = {
		'Ascended'
	}
}

-- Add rarity badges to vanilla hidden consumables

SMODS.Consumable:take_ownership('c_soul', {
	misc_badge = may_rare_badge
})

SMODS.Consumable:take_ownership('c_black_hole', {
	misc_badge = may_rare_badge
})

-- Hands

SMODS.PokerHand {
    key = 'Royal Flush',
    chips = 110,
    mult = 9,
    l_chips = 60,
    l_mult = 10,
    example = {
        { 'S_A',    true },
        { 'S_K',    true },
        { 'S_Q',    true },
        { 'S_J',    true },
        { 'S_T',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Royal Flush',
            description = {
                'A Straight Flush that has an Ace and a 10.'
            }
        }
    },
    evaluate = function(parts, hand)
        if next(parts._flush) and next(parts._straight) then
            local _strush = SMODS.merge_lists(parts._flush, parts._straight)
            local royal = true
            for j = 1, #_strush do
                local rank = SMODS.Ranks[_strush[j].base.value]
                royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
            end
            if royal then return {_strush} end
        end
    end,
}

-- Atlases
SMODS.Atlas {
  key = "joker1",
  path = "joker1.png",
  px = 71,
  py = 95
}

if may.conf.Mode == 1 then
	SMODS.Atlas({
		key = "modicon",
		path = "may_icon.png",
		px = 32,
		py = 32,
	})
else
	SMODS.Atlas({
		key = "modicon",
		path = "eternum_icon.png",
		px = 32,
		py = 32,
	})
end

SMODS.Atlas {
	key = "placeholder",
	path = "placeholder.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "temp_store",
	path = "temp_store.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "consumable",
	path = "consumables.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "upside_down",
	path = "upside_down.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "spectral",
	path = "spectral.png",
	px = 65,
	py = 95
}

SMODS.Atlas {
	key = "tarot",
	path = "tarot.png",
	px = 65,
	py = 95
}

SMODS.Atlas {
	key = "jovianmoon",
	path = "jovianmoon.png",
	px = 65,
	py = 95
}

SMODS.Atlas {
	key = "tag",
	path = "tag.png",
	px = 34,
	py = 34
}

SMODS.Atlas {
	key = "planet",
	path = "planet.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "rareplanet",
	path = "rareplanet.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "legendaryplanet",
	path = "legendaryplanet.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "mythicplanet",
	path = "mythicplanet.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "editioncard",
	path = "editioncard.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "asc_tarot",
	path = "asc_tarot.png",
	px = 65,
	py = 95,
}

SMODS.Atlas {
	key = "voucher",
	path = "voucher.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "voucher_bundle",
	path = "voucher_bundle.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "placeholder_vouchert4",
	path = "placeholder_vouchert4.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "placeholder_voucher",
	path = "placeholder_voucher.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "ultrablind",
	path = "ultrablind.png",
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34,
}

SMODS.Atlas {
	key = "blind",
	path = "blind.png",
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34,
}

SMODS.Atlas {
	key = "booster",
	path = "booster.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "placeholder_booster",
	path = "placeholder_booster.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "enhancement",
	path = "enhancement.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "seal",
	path = "seal.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "yotta",
	path = "yotta.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "achievement",
	path = "achievement.png",
	px = 32,
	py = 32,
}

SMODS.Atlas {
	key = "ascyotta",
	path = "ascendedyotta.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "ascyotta_placeholder",
	path = "ascyotta_placeholder.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "deck",
	path = "deck.png",
	px = 71,
	py = 95
}

-- SFX

SMODS.Sound({key = 'thunder1', path = 'thunder1.ogg'})
SMODS.Sound({key = 'thunder2', path = 'thunder2.ogg'})
SMODS.Sound({key = 'bigmoney', path = 'hugemoney.ogg'})

SMODS.Sound({key = 'e_amber', path = 'edition/e_amber.ogg'})
SMODS.Sound({key = 'e_nostalgic', path = 'edition/e_nostalgic.ogg'})
SMODS.Sound({key = 'e_techno', path = 'edition/e_techno.ogg'})
SMODS.Sound({key = 'e_antimatter', path = 'edition/e_antimatter.ogg'})
SMODS.Sound({key = 'e_hallucinatory', path = 'edition/e_hallucinatory.ogg'})
SMODS.Sound({key = 'e_hypnotic', path = 'edition/e_hypnotic.ogg'})
SMODS.Sound({key = 'e_omega', path = 'edition/e_omega.ogg'})
SMODS.Sound({key = 'e_reverse', path = 'edition/e_reverse.ogg'})
SMODS.Sound({key = 'e_wavy', path = 'edition/e_wavy.ogg'})
SMODS.Sound({key = 'e_misprint', path = 'edition/e_misprint.ogg'})
SMODS.Sound({key = 'e_otherworldly', path = 'edition/e_otherworldly.ogg'})
SMODS.Sound({key = 'e_shimmering', path = 'edition/e_shimmering.ogg'})
SMODS.Sound({key = 'e_cosmic', path = 'edition/e_cosmic.ogg'})
SMODS.Sound({key = 'e_print', path = 'edition/e_print.ogg'})
SMODS.Sound({key = 'e_goldfoil', path = 'edition/e_goldfoil.ogg'})

SMODS.Sound({key = 'e_ultrafoil', path = 'edition/e_ultrafoil.ogg'})
SMODS.Sound({key = 'e_ultraholo', path = 'edition/e_ultraholographic.ogg'})
SMODS.Sound({key = 'e_ultrapoly', path = 'edition/e_ultrapolychrome.ogg'})
SMODS.Sound({key = 'e_ultraamber', path = 'edition/e_ultraamber.ogg'})
SMODS.Sound({key = 'e_ultranostalgic', path = 'edition/e_ultranostalgic.ogg'})
SMODS.Sound({key = 'e_ultratechno', path = 'edition/e_ultratechno.ogg'})
SMODS.Sound({key = 'e_ultraantimatter', path = 'edition/e_ultraantimatter.ogg'})

SMODS.Sound({key = 'weezer', path = 'weezer.ogg'})
SMODS.Sound({key = 'st_hohoho', path = 'hohoho.ogg'})
SMODS.Sound({key = 'st_bells', path = 'santa_bells.ogg'})

SMODS.Sound({key = 'yotta', path = 'consumable/yotta.ogg'})
SMODS.Sound({key = 'upside_down', path = 'consumable/upside_down.ogg'})
SMODS.Sound({key = 'super_level', path = 'super_level.ogg'})
SMODS.Sound({key = 'rare_planet', path = 'consumable/planet/rare_planet.ogg'})
SMODS.Sound({key = 'legendary_planet', path = 'consumable/planet/legendary_planet.ogg'})
SMODS.Sound({key = 'mythic_planet', path = 'consumable/planet/mythic_planet.ogg'})
SMODS.Sound({key = 'decrease_operator', path = 'decrease_operator.ogg'})
SMODS.Sound({key = 'error', path = 'error.ogg'})
SMODS.Sound({key = 'universal_collapse', path = 'universalcollapse.ogg'})
SMODS.Sound({key = 'ah_yes_the_store', path = 'ah_yes_the_store.ogg'})
SMODS.Sound({key = 'ascended_yotta', path = 'consumable/empower/ascended_yotta.ogg'})
SMODS.Sound({key = 'big_number_set', path = 'big_number_set.ogg'})
SMODS.Sound({key = 'huge_score', path = 'huge_score.ogg'})
SMODS.Sound({key = 'error_seal', path = 'error_seal.ogg'})
SMODS.Sound({key = 'hyperoperator', path = 'hyperoperator.ogg'})
SMODS.Sound({key = 'lvl_multchips', path = 'lvl_multchips.ogg'})
SMODS.Sound({key = 'blind_size', path = 'blind_size.ogg'})
SMODS.Sound({key = 'nominal_chips', path = 'nominal_chips.ogg'})
SMODS.Sound({key = 'eq_level', path = 'eq_level.ogg'})

SMODS.Sound({key = 'hyper_selection_limit', path = 'hyper_selection_limit.ogg'})
SMODS.Sound({key = 'hyper_joker_slots', path = 'hyper_joker_slots.ogg'})
SMODS.Sound({key = 'hyper_consumable_slots', path = 'hyper_consumable_slots.ogg'})

SMODS.Sound({key = 'c_ascended', path = 'consumable/empower/c_ascended.ogg'})
SMODS.Sound({key = 'c_pandimentional', path = 'consumable/empower/c_pandimentional.ogg'})
SMODS.Sound({key = 'c_unworldly', path = 'consumable/empower/c_unworldly.ogg'})
SMODS.Sound({key = 'c_wondrous', path = 'consumable/empower/c_wondrous.ogg'})
SMODS.Sound({key = 'c_epsilon', path = 'consumable/empower/c_epsilon.ogg'})

SMODS.Sound({key = 'mythic_joker', path = 'rarity/mythic_joker.ogg'})
SMODS.Sound({key = 'transcendent_joker', path = 'rarity/transcendent_joker.ogg'})
SMODS.Sound({key = 'surreal_joker', path = 'rarity/surreal_joker.ogg'})
SMODS.Sound({key = 'nexus_joker', path = 'rarity/nexus_joker.ogg'})
SMODS.Sound({key = 'interdimensional_joker', path = 'rarity/interdimensional_joker.ogg'})
SMODS.Sound({key = 'ethereal_joker', path = 'rarity/ethereal_joker.ogg'})
SMODS.Sound({key = 'hyperascendant_joker', path = 'rarity/hyperascendant_joker.ogg'})

SMODS.Sound({key = 'tran1', path = 'tran/tran1.ogg'})
SMODS.Sound({key = 'tran2', path = 'tran/tran2.ogg'})
SMODS.Sound({key = 'tran3', path = 'tran/tran3.ogg'})
SMODS.Sound({key = 'tran4', path = 'tran/tran4.ogg'})
SMODS.Sound({key = 'tran5', path = 'tran/tran5.ogg'})
SMODS.Sound({key = 'tran6', path = 'tran/tran6.ogg'})
SMODS.Sound({key = 'tran7', path = 'tran/tran7.ogg'})
SMODS.Sound({key = 'tran8', path = 'tran/tran8.ogg'})

SMODS.Sound({key = 'ambient_mass_use', path = 'ambient_mass_use.ogg'})

SMODS.Sound({key = 'eqscore', path = 'operation/EqualsScore.ogg'})
SMODS.Sound({key = 'addscore', path = 'operation/AdditiveScore.ogg'})
SMODS.Sound({key = 'xscore', path = 'operation/MultiplicativeScore.ogg'})
SMODS.Sound({key = 'escore', path = 'operation/ExponentialScore.ogg'})
SMODS.Sound({key = 'eescore', path = 'operation/TetrationalScore.ogg'})
SMODS.Sound({key = 'eeescore', path = 'operation/PentationalScore.ogg'})
SMODS.Sound({key = 'hexscore', path = 'operation/HexationalScore.ogg'})

SMODS.Sound({key = 'eboth', path = 'operation/ExponentialMultChips.ogg'})
SMODS.Sound({key = 'eeboth', path = 'operation/TetrationalMultChips.ogg'})
SMODS.Sound({key = 'eeeboth', path = 'operation/PentationalMultChips.ogg'})

-- Tamer sounds
if may.conf.TameSounds then

SMODS.Sound({key = 'eqmult', path = 'operation/EqualsMult.ogg'})
SMODS.Sound({key = 'hexmult', path = 'operation/HexationalMult.ogg'})
SMODS.Sound({key = 'hepmult', path = 'operation/tame/HeptationalMult.ogg'})
SMODS.Sound({key = 'octmult', path = 'operation/tame/OctationalMult.ogg'})
SMODS.Sound({key = 'ennmult', path = 'operation/tame/EnneationalMult.ogg'})
SMODS.Sound({key = 'decmult', path = 'operation/tame/DecationalMult.ogg'})
SMODS.Sound({key = 'undmult', path = 'operation/tame/UndecationalMult.ogg'})
SMODS.Sound({key = 'doemult', path = 'operation/tame/DoedecationalMult.ogg'})
SMODS.Sound({key = 'tremult', path = 'operation/tame/TredecationalMult.ogg'})
SMODS.Sound({key = 'apemult', path = 'operation/tame/AperiotiveMult.ogg'})
SMODS.Sound({key = 'factmult', path = 'operation/FactorialMult.ogg'})
SMODS.Sound({key = 'expofactmult', path = 'operation/tame/ExponentialFactorialMult.ogg'})

SMODS.Sound({key = 'eqchip', path = 'operation/EqualsChips.ogg'})
SMODS.Sound({key = 'hexchip', path = 'operation/HexationalChips.ogg'})
SMODS.Sound({key = 'hepchip', path = 'operation/HeptationalChips.ogg'})
SMODS.Sound({key = 'octchip', path = 'operation/tame/OctationalChips.ogg'})
SMODS.Sound({key = 'ennchip', path = 'operation/tame/EnneationalChips.ogg'})
SMODS.Sound({key = 'decchip', path = 'operation/tame/DecationalChips.ogg'})
SMODS.Sound({key = 'undchip', path = 'operation/tame/UndecationalChips.ogg'})
SMODS.Sound({key = 'doechip', path = 'operation/tame/DoedecationalChips.ogg'})
SMODS.Sound({key = 'trechip', path = 'operation/tame/TredecationalChips.ogg'})
SMODS.Sound({key = 'apechip', path = 'operation/tame/AperiotiveChips.ogg'})
SMODS.Sound({key = 'factchip', path = 'operation/FactorialChips.ogg'})
SMODS.Sound({key = 'expofactchip', path = 'operation/tame/ExponentialFactorialChips.ogg'})

else

SMODS.Sound({key = 'eqmult', path = 'operation/EqualsMult.ogg'})
SMODS.Sound({key = 'hexmult', path = 'operation/HexationalMult.ogg'})
SMODS.Sound({key = 'hepmult', path = 'operation/HeptationalMult.ogg'})
SMODS.Sound({key = 'octmult', path = 'operation/OctationalMult.ogg'})
SMODS.Sound({key = 'ennmult', path = 'operation/EnneationalMult.ogg'})
SMODS.Sound({key = 'decmult', path = 'operation/DecationalMult.ogg'})
SMODS.Sound({key = 'undmult', path = 'operation/UndecationalMult.ogg'})
SMODS.Sound({key = 'doemult', path = 'operation/DoedecationalMult.ogg'})
SMODS.Sound({key = 'tremult', path = 'operation/TredecationalMult.ogg'})
SMODS.Sound({key = 'apemult', path = 'operation/AperiotiveMult.ogg'})
SMODS.Sound({key = 'factmult', path = 'operation/FactorialMult.ogg'})
SMODS.Sound({key = 'expofactmult', path = 'operation/ExponentialFactorialMult.ogg'})

SMODS.Sound({key = 'eqchip', path = 'operation/EqualsChips.ogg'})
SMODS.Sound({key = 'hexchip', path = 'operation/HexationalChips.ogg'})
SMODS.Sound({key = 'hepchip', path = 'operation/HeptationalChips.ogg'})
SMODS.Sound({key = 'octchip', path = 'operation/OctationalChips.ogg'})
SMODS.Sound({key = 'ennchip', path = 'operation/EnneationalChips.ogg'})
SMODS.Sound({key = 'decchip', path = 'operation/DecationalChips.ogg'})
SMODS.Sound({key = 'undchip', path = 'operation/UndecationalChips.ogg'})
SMODS.Sound({key = 'doechip', path = 'operation/DoedecationalChips.ogg'})
SMODS.Sound({key = 'trechip', path = 'operation/TredecationalChips.ogg'})
SMODS.Sound({key = 'apechip', path = 'operation/AperiotiveChips.ogg'})
SMODS.Sound({key = 'factchip', path = 'operation/FactorialChips.ogg'})
SMODS.Sound({key = 'expofactchip', path = 'operation/ExponentialFactorialChips.ogg'})

end

-- Fusions

-- joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, condition, code, shake

	-- Mythic

FusionJokers.fusions:add_fusion('j_may_man', nil, nil, 'j_may_wheel_of_eternity', nil, nil, 'j_may_diskus', 140, 'may_mythic_joker')
 
	-- Transcendent

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_hurley', nil, nil, 'j_may_ultimate_hurley', 1000, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_nebula', nil, nil, 'j_may_cosmos', 1000, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_AAAA', nil, nil, 'j_may_acum', 1111, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_destroyer', nil, nil, 'j_may_storm', 1300, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_royale', nil, nil, 'j_may_little_prince', 1100, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_daredevil', nil, nil, 'j_may_party_time', 1100, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_jolly', nil, nil, 'j_may_santa', 8888, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_diskus', nil, nil, 'j_may_collectionist', nil, nil, 'j_may_diskus_kollectum', 1414, 'may_transcendent_joker')

	-- Interdimensional
 
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum', nil, nil, 'j_may_acum_universum', 111111, 'may_interdimensional_joker', nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_storm', nil, nil, 'j_may_cosmos', nil, nil, 'j_may_kepler', 100000, 'may_interdimensional_joker', nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_diskus_kollectum', nil, nil, 'j_may_collectors_edition', nil, nil, 'j_may_diskus_kollectum_maximus', 141414, 'may_interdimensional_joker', nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_storm', nil, nil, 'j_may_world_destroyer', 100000, 'may_interdimensional_joker')

	-- Ethereal
  
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum_universum', nil, nil, 'j_may_acum_multiplexum', 11111111, 'may_ethereal_joker', nil, 1)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_kepler', nil, nil, 'j_may_keplers_dream', 1e7, 'may_ethereal_joker', nil, 1)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_diskus_kollectum_maximus', nil, nil, 'j_may_diskus_distruktum', 1e7, 'may_ethereal_joker', nil, 1)

	-- HyperAscendant

FusionJokers.fusions:add_fusion('j_may_acum_multiplexum', nil, nil, 'j_may_keplers_dream', nil, nil, 'j_may_spadus', 11e110, 'may_hyperascendant_joker', nil, 1.5)

-- Music
	--[[ if may.conf.Music then 
	SMODS.Sound({
	key = "music_main",
	path = "music_main.ogg",
	pitch = 1,
	select_music_track = function()
		return (G.GAME) and 0 or false
	end,
})

	SMODS.Sound({
	key = "music_boss",
	path = "boss.ogg",
	pitch = 1,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and (G.GAME.blind.config.blind.boss)) and 1 or false
	end,
})

	SMODS.Sound({
	key = "music_arcana",
	path = "arcana.ogg",
	pitch = 1,
	select_music_track = function()
		return (G.STATES.TAROT_PACK and G.GAME) and 0 or true
	end,
})
]]


SMODS.Sound({
	key = "music_santa",
	path = "music/music_santa.ogg",
	pitch = 1,
	sync = false,
	select_music_track = function()
		return (#SMODS.find_card('j_may_santa') > 0  and may.conf.Santamusic and (may.transcendence or 0) < 9) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_party",
	path = "music/music_party.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (#SMODS.find_card('j_may_party_time') > 0 and may.conf.Partymusic and (may.transcendence or 0) < 9 ) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 8) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_mayhem",
	path = "music/music_mayhem.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not may.conf.Music == 9 or may.conf.Music == 2 or (may.conf.Music == 1 and may.conf.Mode == 1)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_eternum",
	path = "music/music_eternum.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not may.conf.Music == 9 or may.conf.Music == 3 or (may.conf.Music == 1 and may.conf.Mode == 2)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_editioncard",
	path = "music/music_edition.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "editioncards" and may.conf.Editionmusic) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 7) and -1000 or false
	end
})

SMODS.Sound({
	key = "music_retrocard",
	path = "music/music_retro.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "retrocards" and may.conf.Editionmusic) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 7) and -1000 or false
	end
})

SMODS.Sound({
	key = "music_hyperascendant",
	path = "music/music_hyperascendant.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		local found_hyperascendant
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_hyperascendant' then
					return found_hyperascendant
				end
			end
		end
		return (found_hyperascendant and (may.conf.Hyperascendantmusic and (may.transcendence or 0) < 9)) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 6) and 0 or false
	end
})

SMODS.Sound({
	key = "music_yotta",
	path = "music/music_yotta.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		local found_yotta = false
		if G.pack_cards and G.pack_cards.cards then
			for k, v in pairs(G.pack_cards.cards) do
				if v:gc().set == 'yottacards' then
					found_yotta = true
				end
			end
		end
		return (found_yotta and may.conf.Yottamusic) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 4) and -1000 or false
	end
})

--[[SMODS.Sound({
	key = "music_asc_yotta",
	path = "music/music_party.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "ascendedyottas") and -1000 or false
	end
})]]

SMODS.Sound({
	key = "music_ultrablind",
	path = "music/music_ultrablind.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and G.GAME.blind.config.blind.ultra and may.conf.Ultrablindmusic) or ((G.GAME and not G.GAME.blind) and may.conf.Music == 5) and -1000 or false
	end
})

SMODS.Sound({
	key = "music_tran9",
	path = "tran/tran9.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 9 and may.conf.TrAudio ~= 0
	end,
	volume = 2
})

SMODS.Sound({
	key = "music_tran10",
	path = "tran/tran10.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 10 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran11",
	path = "tran/tran11.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 11 and may.conf.TrAudio ~= 0
	end,
	volume = 2
})

SMODS.Sound({
	key = "music_tran12",
	path = "tran/tran12.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 12 and may.conf.TrAudio ~= 0
	end,
	volume = 3
})

SMODS.Sound({
	key = "music_tran13",
	path = "tran/tran13.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 13 and may.conf.TrAudio ~= 0
	end,
	volume = 3
})

SMODS.Sound({
	key = "music_tran14",
	path = "tran/tran14.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 14 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran15",
	path = "tran/tran15.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 15 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})


-- Editions
if may.conf.content.Editions then

SMODS.Shader({key = 'shimmering', path = 'shimmering.fs'})
SMODS.Shader({key = 'amber', path = 'amber.fs'})
SMODS.Shader({key = 'omega', path = 'omega.fs'})
SMODS.Shader({key = 'nostalgic', path = 'nostalgic.fs'})
SMODS.Shader({key = 'otherworldly', path = 'otherworldly.fs'})
SMODS.Shader({key = 'cosmic', path = 'cosmic.fs'})
SMODS.Shader({key = 'print', path = 'print.fs'})
SMODS.Shader({key = 'goldfoil', path = 'goldfoil.fs'})
-- SMODS.Shader({key = 'reverse', path = 'reverse.fs'})
SMODS.Shader({key = 'misprint', path = 'misprint.fs'})

SMODS.Shader({key = 'semihologram', path = 'semihologram.fs'})

SMODS.Edition {
	key = "shimmering",
	loc_txt = {
		name = "Shimmering",
		label = "Shimmering",
		text = {
			"{C:mult}+15{} Mult and {C:chips}+10{} Chips"
		}
	},

	shader = 'shimmering',
	discovered = true,
	badge_colour = HEX('ffc9ff'),
	sound = { sound = "may_e_shimmering", per = 1, vol = 0.9 },
	unlocked = true,
	config = { mult = 15, chips = 15 },
	in_shop = true,
	weight = 10,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				chips = self.config.chips,
				mult = self.config.mult
			}
		end
	end
}

SMODS.Edition {
	key = "amber",
	loc_txt = {
		name = "Amber",
		label = "Amber",
		text = {
			"{C:mult}-2{} Mult and {C:chips}+120{} Chips"
		}
	},

	shader = 'amber',
	discovered = true,
	badge_colour = HEX('854711'),
	sound = { sound = "may_e_amber", per = 1, vol = 2 },
	unlocked = true,
	config = { mult = -2, chips = 120 },
	in_shop = true,
	weight = 10,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			local safe_mult
			if mult < to_big(2) then
				if mult == to_big(1) then
					safe_mult = -1
				elseif mult <= to_big(0) then
					safe_mult = 0
				end
			end
			return {
				chips = self.config.chips,
				mult = safe_mult,
			}
		end
	end
}

SMODS.Edition {
	key = "goldfoil",
	loc_txt = {
		name = "Goldfoil",
		label = "Goldfoil",
		text = {
			"{C:money}+5${}"
		}
	},

	shader = 'goldfoil',
	discovered = true,
	badge_colour = HEX('ffd561'),
	sound = { sound = "may_e_goldfoil", per = 1, vol = 0.9 },
	unlocked = true,
	config = { p_dollars = 5 },
	in_shop = true,
	weight = 8,
	extra_cost = 6,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				dollars = 5
			}
		end
	end
}

SMODS.Edition{
	key = "print",
	loc_txt = {
		name = "Print",
		label = "Print",
		text = {
			"Card is {C:money}significantly cheaper{}"
		}
	},

	shader = 'print',
	discovered = true,
	badge_colour = HEX('aaaaaa'),
	sound = { sound = "may_e_print", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 3,
	extra_cost = 0,
	apply_to_float = true,
}

SMODS.Edition{
	key = "nostalgic",
	loc_txt = {
		name = "Nostalgic",
		label = "Nostalgic",
		text = {
			"Creates the last {C:purple}Tarot{} or",
			"{C:planet}Planet{} card used during this run",
			"{C:inactive}(Requires room){}"
		}
	},

	shader = 'nostalgic',
	discovered = true,
	badge_colour = HEX('d1a54d'),
	sound = { sound = "may_e_nostalgic", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 3,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if G.GAME.last_tarot_planet and context.pre_joker or (context.main_scoring and context.cardarea == G.play) or (context.using_consumeable and context.consumeable == card) then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local new = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, 'fool')
					new:add_to_deck()
					G.consumeables:emplace(new)
					new:juice_up(0.3, 0.5)
					if Incantation then
						if card.ability.qty then
							new:setQty(card.ability.qty)
						end
					end
				end
			return true end}))
		end
	end
}

SMODS.Edition {
	key = "cosmic",
	loc_txt = {
		name = "Cosmic",
		label = "Cosmic",
		text = {
			"{C:mult}Remove{} {C:attention}this{} {C:dark_edition}edition{} to {C:attention}quadruple{} the {C:attention}level{}",
			"of {C:attention}most played{} {C:planet}Poker Hand{}",
			"{C:inactive}(Will level up #1#){}",
		}
	},

	shader = 'cosmic',
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand() } }
	end, 
	discovered = true,
	badge_colour = HEX('117b9c'),
	sound = { sound = "may_e_cosmic", per = 1, vol = 0.9 },
	unlocked = true,
	on_remove = function(card)
		jl.th(jl.favhand())
		may.level_up_hand_hyper(card, jl.favhand(), nil, 4)
		jl.ch()
	end,
	in_shop = true,
	weight = 1,
	extra_cost = 4,
	apply_to_float = true,
}

--[[SMODS.Edition {
	key = "reverse",
	loc_txt = {
		name = "Reverse",
		label = "Reverse",
		text = {
			"{C:attention}+1 Hand Size this round{}",
			"when triggered",
			"{C:inactive}Shader by stupxd{}"
		}
	},
	shader = 'reverse',
	discovered = true,
	badge_colour = HEX('777777'),
	sound = { sound = "may_e_reverse", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 1,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			G.hand:change_size(1)
			G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 1
			return {
				message = '+1 Hand Size'
			}
		end
	end
}

SMODS.Edition {
	key = "wavy",
	loc_txt = {
		name = "Wavy",
		label = "Wavy",
		text = {
			"{C:attention}Retrigger{} this card"
		}
	},
	shader = 'wavy',
	discovered = true,
	badge_colour = HEX('777777'),
	sound = { sound = "may_e_wavy", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 1,
	extra_cost = 5,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
			return {
				message = 'Again!',
				card = card,
				repetitions = 1
			}
		end
	end,
	send_vars = function (sprite, card)
        return {
            r_time = G.TIMERS.REAL
        }
    end,
}]]

SMODS.Edition {
	key = "omega",
	loc_txt = {
		name = "Omega",
		label = "Omega",
		text = {
			"{X:chips,C:white}^^1.177{} Chips"
		}
	},

	shader = 'omega',
	discovered = true,
	badge_colour = SMODS.Gradients.may_col_e_omega,
	sound = { sound = "may_e_omega", per = 1, vol = 0.9 },
	unlocked = true,
	config = { ee_chips = 1.177 },
	in_shop = true,
	weight = .1,
	extra_cost = 15,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				ee_chips = self.config.ee_chips
			}
		end
	end
}

SMODS.Edition {
	key = "otherworldly",
	loc_txt = {
		name = "Otherworldly",
		label = "Otherworldly",
		text = {
			"{X:chips,C:white}^^^^1.57{} Chips & {X:mult,C:white}^^^15.7{} Mult"
		}
	},

	shader = 'otherworldly',
	discovered = true,
	badge_colour = SMODS.Gradients.may_col_e_otherworldly,
	sound = { sound = "may_e_otherworldly", per = 1, vol = 0.9 },
	unlocked = true,
	config = { hyper_chips = 1.57, eee_mult = 15.7 },
	in_shop = true,
	weight = .001,
	extra_cost = 300,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				hyper_chips = {4, self.config.hyper_chips},
				eee_mult = self.config.eee_mult
			}
		end
	end
}

end

-- Enhancements

if may.conf.content.Enhancements then

SMODS.Enhancement {
	key = 'jagged',
	loc_txt = {
		name = 'Jagged Card',
		text = {
			'{X:chips,C:white}X1.3{} Chips',
		}
	},
	pos = { x = 9, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .5,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_chips = 1.3
			}
		end
	end
}

SMODS.Enhancement {
	key = 'magma',
	loc_txt = {
		name = 'Magma Card',
		text = {
			'{X:mult,C:white}X1.4{} Mult',
		}
	},
	pos = { x = 10, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .5,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = 1.4
			}
		end
	end
}

SMODS.Enhancement {
	key = 'grid',
	loc_txt = {
		name = 'Grid Card',
		text = {
			"{C:attention}Gains{} {C:mult}+2{} Mult when {C:attention}played{}",
			"{C:mult}Loses 1{} Mult when {C:mult}discarded{}",
			"{C:inactive}Currently {C:mult}+#1#{} {C:inactive}Mult{}"
		}
	},
	pos = { x = 11, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .4,
	config = { grid_mult = 0 },
	discovered = true,
	atlas = 'enhancement',
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.grid_mult or 0 } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.grid_mult = 0
	end,
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			if card.ability.grid_mult ~= 0 then
				card.ability.grid_mult = card.ability.grid_mult - 1
				return {
					message = 'Downgraded!',
					colour = G.C.RED,
					card = card,
				}
			end
		end
		if context.before and context.cardarea == G.play then
			card.ability.grid_mult = card.ability.grid_mult + 2
			return {
				message = 'Upgraded!',
				colour = G.C.RED,
				card = card,
			}
		end
		if context.cardarea == G.play and context.main_scoring then
			return {
				mult = card.ability.grid_mult
			}
		end
	end
}

SMODS.Enhancement {
	key = 'super_mult',
	loc_txt = {
		name = 'Super Mult Card',
		text = {
			'{X:mult,C:white}^1.14{} Mult',
		}
	},
	pos = { x = 1, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				e_mult = 1.14
			}
		end
	end
}

SMODS.Enhancement {
	key = 'overgrown',
	loc_txt = {
		name = 'Overgrown Card',
		text = {
			'{C:green}#1# in 3{} chance to apply a',
			"{C:attention}random{} {C:dark_edition}Edition{} to this card",
			"when it is {C:attention}discarded{}",
			"then {C:mult}remove this enhancement{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	pos = { x = 2, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	atlas = 'enhancement',
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			if pseudorandom('may_overgrown') < G.GAME.probabilities.normal / 3 then
				card:set_edition(poll_edition('may_overgrown', nil, true, true), false, false)
				card:set_ability(G.P_CENTERS.c_base, true, nil)
			end
		end
	end
}

SMODS.Enhancement {
	key = 'platinum',
	loc_txt = {
		name = 'Platinum Card',
		text = {
			'{X:money,C:white}X1.3${} {C:attention}after scoring{} if {C:attention}held in hand{}',
		}
	},
	pos = { x = 3, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .15,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.after	then
			return {
				x_dollars = 1.3
			}
		end
	end
}

SMODS.Enhancement {
	key = 'scorched',
	loc_txt = {
		name = 'Scorched Card',
		text = { 
			"{X:planet,C:white}X1.5{} Level of a {C:attention}random{}",
			"{C:purple}Poker Hand{} when {C:mult}discarded{}",
		}
	},
	pos = { x = 4, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .05,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			local hand = jl.rndhand()
			jl.th(hand)
			may.level_up_hand_hyper(card, hand, nil, 1.5)
			jl.ch()
		end
	end
}

SMODS.Enhancement {
	key = 'crystal',
	loc_txt = {
		name = 'Crystal Card',
		text = {
			'{C:money}+#1#%{} of {C:money}total balance{} when scored {C:inactive}($#2#){}',
			'{C:mult}Decreases{} by {C:attention}1{} when {C:attention}triggered{}',
			'{C:attention}Increases{} by {C:attention}10{} if {C:attention}held in hand{} after scoring',
		}
	},
	pos = { x = 5, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .1,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.crystal_percent or 20, number_format((to_big(G.GAME.dollars) or to_big(0)):mul((card.ability.crystal_percent or 20) * 0.01)) } }
	end, 
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.crystal_percent = 20
	end,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			-- I LOVE TALISMAN
			ease_dollars(to_big(G.GAME.dollars) * to_big(card.ability.crystal_percent * 0.01))
			card.ability.crystal_percent = math.max(0, card.ability.crystal_percent - 1)
			return {
				message = 'Downgraded!',
				colour = G.C.MONEY,
				card = card
			}
		end
		if context.after and context.cardarea == G.hand then
			card.ability.crystal_percent = card.ability.crystal_percent + 10
			return {
				message = 'Upgraded!',
				colour = G.C.MONEY,
				card = card
			}
		end
	end
}

local vanf_dc = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	vanf_dc(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	SMODS.calculate_context({card_drawn = true, other_card = card, from = from, to = to})
end

SMODS.Enhancement {
	key = 'cardboard',
	loc_txt = {
		name = 'Cardboard Card',
		text = {
			"If {C:attention}held in hand{} after hand is played, {C:attention}give{} all {C:attention}other{}",
			"{C:attention}Cardboard{} cards {C:attention}held in hand{}",
			"{X:attention,C:white}X30{} Nominal Chips"
		}
	},
	pos = { x = 6, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end, 
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.hand then
			for i=1, #G.hand.cards, 1 do
				if SMODS.has_enhancement(G.hand.cards[i], 'm_may_cardboard') and G.hand.cards[i] ~= card then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
						G.hand.cards[i].ability.nominal_multiplier = (G.hand.cards[i].ability.nominal_multiplier or 0) + 30
						G.hand.cards[i]:juice_up()
						play_sound('may_nominal_chips')
					return true end}))
				end
			end
		end
	end
}

if may.conf.Mode == 1 then

SMODS.Enhancement {
	key = 'ultra',
	loc_txt = {
		name = 'Ultra Card',
		text = {
			'{X:purple,C:white}^2{} Mult & Chips, {C:money}+$50{}, {X:money,C:white}X1.05${}',
			'{C:green}#1# in 2{} chance to create a {C:attention}Double Tag{} when scored',
			'{C:mult}Destroyed after scoring{}'
		}
	},
	pos = { x = 7, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = 0,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end, 
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if pseudorandom('may_unstable') < G.GAME.probabilities.normal / 2 then
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
					add_tag(Tag('tag_double'))
				return true end}))
			end
			return {
				e_mult = 2,
				e_chips = 2,
				dollars = 50,
			}
		end
		if context.after and table_hasvalue(G.play.cards, card) then
			card:start_dissolve()
		end
	end
}


else

SMODS.Enhancement {
	key = 'ultra',
	loc_txt = {
		name = 'Ultra Card',
		text = {
			'{X:purple,C:white}^2{} Mult & Chips, {X:money,C:white}X1.2${},',
			'{C:green}#1# in 2{} chance to create a {C:attention}Double Tag{} when scored',
		}
	},
	pos = { x = 7, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .03,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end, 
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if pseudorandom('may_unstable') < G.GAME.probabilities.normal / 2 then
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
					add_tag(Tag('tag_double'))
				return true end}))
			end
			return {
				e_mult = 2,
				e_chips = 2,
				x_dollars = 1.2,
			}
		end
	end
}

end

SMODS.Enhancement {
	key = 'titanium',
	loc_txt = {
		name = 'Titanium Card',
		text = {
			'{X:money,C:white}X1.2${} but {X:attention,C:white}X5{} {C:attention}Blind Size{}',
			'when scored'
		}
	},
	pos = { x = 8, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .5,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
				G.GAME.blind.chips = G.GAME.blind.chips:mul(5)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
			return true end}))
			return {
				x_dollars = 1.2
			}
		end
	end
}

SMODS.Enhancement {
	key = 'geometric',
	loc_txt = {
		name = 'Geometric Card',
		text = {
			'{X:mult,C:white}^^sqrt(2){}Mult',
		}
	},
	config = { EEmult = math.sqrt(2)},
	pos = { x = 0, y = 0 },
	unlocked = true,
	weight = 0.00141,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				ee_mult = math.sqrt(2)
			}
		end
	end
}

end

-- Seals

SMODS.Seal {
	key = 'copper_seal',
	loc_txt = {
		name = 'Copper Seal',
		label = 'Copper Seal',
		text = {
			"{C:mult}Destroy{} {C:attention}this card{}",
			"to redeem a {C:attention}random{} {C:green}Voucher{}"
		}
	},
	atlas = 'seal',
	pos = { x = 0, y = 0 },
	badge_colour = HEX('995b37'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.cardarea ~= G.discard and table_hasvalue(context.removed, card) then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				jl.voucher()
			return true end}))
		end
	end,
	draw = function(self, card, layer)
		G.shared_seals["may_copper_seal"].role.draw_major = card
		G.shared_seals["may_copper_seal"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["may_copper_seal"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

SMODS.Seal {
	key = 'lime_seal',
	loc_txt = {
		name = 'Lime Seal',
		label = 'Lime Seal',
		text = {
			"{X:chips,C:white}X#1#{} Chips",
			"{C:attention}Increases{} by {X:chips,C:white}0.1{} when {C:mult}discarded{}"
		}
	},
	atlas = 'seal',
	pos = { x = 3, y = 0 },
	config = { x_chips = 1.4 },
	badge_colour = HEX('acf097'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.seal.x_chips } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_chips = card.ability.seal.x_chips
			}
		end
		if context.discard and context.other_card == card then
			card.ability.seal.x_chips = card.ability.seal.x_chips + 0.1
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

SMODS.Seal {
	key = 'inverted_seal',
	loc_txt = {
		name = 'Inverted Seal',
		label = 'Inverted Seal',
		text = {
			"{C:green}#1# in 5{} chance to",
			"{C:attention}create{} a {C:dark_edition}Negative{} {C:attention}copy{} of a {C:attention}random{}",
			"held {C:attention}consumable{} at the {C:attention}end of round{}",
			"if this card is {C:attention}held in hand{}"
		}
	},
	atlas = 'seal',
	pos = { x = 4, y = 0 },
	badge_colour = HEX('ff6200'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal } }
	end, 
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.hand and #G.consumeables.cards > 0 then
			if pseudorandom('may_inverted_seal') < G.GAME.probabilities.normal / 5 then
				local target = pseudorandom_element(G.consumeables.cards, pseudoseed("may_inverted_seal"))
				G.E_MANAGER:add_event(Event({func = function()
					local card_copy = copy_card(target, nil)
					if Incantation then
						card_copy:setQty(1)
					end
					card_copy:set_edition({ negative = true }, true)
					card_copy:add_to_deck()
					G.consumeables:emplace(card_copy)
					card:juice_up()
				return true end}))
			end
		end
	end
}

SMODS.Seal {
	key = 'orange_seal',
	loc_txt = {
		name = 'Orange Seal',
		label = 'Orange Seal',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"{C:attention}Increases{} by {X:mult,C:white}0.1{} when {C:attention}played{}"
		}
	},
	atlas = 'seal',
	pos = { x = 5, y = 0 },
	badge_colour = HEX('ff5900'),
	config = { x_mult = 1.4 },
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.seal.x_mult } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = card.ability.seal.x_mult
			}
		end
		if context.before and context.cardarea == G.play then
			card.ability.seal.x_mult = card.ability.seal.x_mult + 0.1
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}

SMODS.Seal {
	key = 'pink_seal',
	loc_txt = {
		name = 'Pink Seal',
		label = 'Pink Seal',
		text = {
			"{X:mult,C:white}^0.01{} Mult for {C:attention}every{} {C:dark_edition}Edition Card{}",
			"{C:attention}used{} this run",
			"{C:inactive}Currently {X:mult,C:white}^#1#{} {C:inactive}Mult{}",
			"{C:inactive,s:0.5}JIMCO. CORPORATE{}"
		}
	},
	atlas = 'seal',
	pos = { x = 6, y = 0 },
	badge_colour = HEX('ff00ea'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(1+(jl.ctu('editioncards')*0.01)) } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				e_mult = 1+(jl.ctu('editioncards')*0.01)
			}
		end
	end
}

SMODS.Seal {
	key = 'silver_seal',
	loc_txt = {
		name = 'Silver Seal',
		label = 'Silver Seal',
		text = {
			"{X:mult,C:white}X1.2{} Mult if {C:attention}held in hand{}",
			"additional {X:mult,C:white}X0.5{} Mult for every card",
			"with {C:inactive}Silver Seal{} held in hand"
		}
	},
	atlas = 'seal',
	pos = { x = 7, y = 0 },
	badge_colour = HEX('ababab'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.main_scoring then
			local bonus = 0
			for k, v in pairs(G.hand.cards) do
				if v.seal == 'may_silver_seal' then 
					bonus = bonus + 1
				end
			end
			 return {
				x_mult = 1.2 + (bonus*0.5),
				card = card
			}
		end
	end,
	draw = function(self, card, layer)
		G.shared_seals["may_silver_seal"].role.draw_major = card
		G.shared_seals["may_silver_seal"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["may_silver_seal"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

SMODS.Seal {
	key = 'white_seal',
	loc_txt = {
		name = 'White Seal',
		label = 'White Seal',
		text = {
			"{X:attention,C:white}X200{} Nominal Chips"
		}
	},
	atlas = 'seal',
	pos = { x = 8, y = 0 },
	badge_colour = HEX('ffffff'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if card then
			card.ability.nominal_multiplier = 200
		end
	end
}

SMODS.Seal {
	key = 'yellow_seal',
	loc_txt = {
		name = 'Yellow Seal',
		label = 'Yellow Seal',
		text = {
			"{C:green}#1# in 3{} chance to create a",
			"{C:attention}random{} {C:spectral}Spectral{} card when",
			"this card is {C:attention}retriggered{}",
			"{C:inactive}(requires room){}"
		}
	},
	atlas = 'seal',
	pos = { x = 9, y = 0 },
	badge_colour = HEX('fbff00'),
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal } }
	end, 
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if not card.yellow_seal_check then
				card.yellow_seal_check = true
				G.E_MANAGER:add_event(Event({func = function()
					if card then
						card.yellow_seal_check = nil
					end
				return true end }))
			else
				if pseudorandom('may_yellow_seal') < G.GAME.probabilities.normal / 3 then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						if G.consumeables.config.card_limit > #G.consumeables.cards then
							play_sound('timpani', 0.5)
							local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_yellow_seal')
							card2:add_to_deck()
							G.consumeables:emplace(card2)
							card:juice_up(0.3, 0.5)
						end
					return true end }))
				end
			end
		end
	end
}

SMODS.Seal {
	key = 'black_seal',
	loc_txt = {
		name = 'Black Seal',
		label = 'Black Seal',
		text = {
			"{X:chips,C:white}^0.02{} Chips for every card",
			"with {C:attention}Black Seal{} in full deck",
			"{C:inactive}Currently {X:chips,C:white}^#1#{} {C:inactive}Chips{}",
		}
	},
	atlas = 'seal',
	pos = { x = 10, y = 0 },
	badge_colour = HEX('000000'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	config = { Echips = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(self.config.Echips) } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			 return {
				e_chips = self.config.Echips,
				card = card
			}
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			self.config.Echips = 1
			for k, v in pairs(G.playing_cards) do
				if v.seal == 'may_black_seal' then 
					self.config.Echips = self.config.Echips + 0.02
				end
			end
		end
	end
}

SMODS.Seal {
	key = 'error_seal',
	loc_txt = {
		name = 'ERROR Seal',
		label = 'ERROR Seal',
		text = {
			"nil"
		}
	},
	atlas = 'seal',
	pos = { x = 1, y = 0 },
	badge_colour = HEX('ffffff'),
	sound = { sound = 'may_error_seal', per = 1.2, vol = 0.4 },
	loc_vars = function (self, info_queue, card)
		return { main_start = { 
			-- im sorry
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 0.8,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 5,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 2,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 0.1,
					}),
				},
			}
		} }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			local operation = math.floor(pseudorandom('may_error_seal')*10)
			if operation == 1 then
				return {
					x_dollars = pseudorandom('may_error_seal', 1, 2)
				}
			elseif operation > 9 then
				return {
					ease_dollars = pseudorandom('may_error_seal', 1, 60)
				}
			elseif operation > 8 then
				return {
					ease_discard(0.1)
				}
			elseif operation > 7 then
				return {
					mult = pseudorandom('may_error_seal', 1, 100),
				}
			elseif operation > 6 then
				return {
					e_mult = pseudorandom('may_error_seal', 1, 3),
				}
			elseif operation > 5 then
				return {
					e_chips = pseudorandom('may_error_seal', 1, 3),
				}
			elseif operation > 4 then
				return {
					x_mult = pseudorandom('may_error_seal', 1, 20),
				}
			elseif operation > 3 then
				return {
					x_chips = pseudorandom('may_error_seal', 1, 20),
				}
			elseif operation > 2 then
				return {
					mult = pseudorandom('may_error_seal', 1, 100),
				}
			elseif operation > 1 then
				return {
					chips = pseudorandom('may_error_seal', 1, 200),
				}
			elseif operation < 1 then
				return {
					ease_hands_played(0.2)
				}
			end
		end
	end
}

-- Consumable Types

if may.conf.content.Consumables then

SMODS.ConsumableType {
	key = 'editioncards',
	collection_rows = {6, 6},
	primary_colour = G.C.EDITION,
	secondary_colour = G.C.BLACK,
	default = 'c_may_foil_card',
	loc_txt = {
		collection = 'Edition Cards',
		name = 'Edition Card',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

--[[SMODS.ConsumableType {
	key = 'retrocards',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('1b7500'),
	default = 'c_may_easter_egg',
	loc_txt = {
		collection = 'Retro Cards',
		name = 'Retro Card',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}]]

SMODS.ConsumableType {
	key = 'yottacards',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.YELLOW,
	loc_txt = {
		collection = 'Yotta Cards',
		name = 'Yotta Card',
	},
	default = 'c_may_potestas',
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'upside_down_planets',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('dbe398'),
	default = 'c_may_pluto_upsd',
	loc_txt = {
		collection = 'PlaalP CaraC',
		name = 'PlaalP CaraC',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'upside_down_spectrals',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('ff00d4'),
	default = 'c_may_incantation_upsd',
	loc_txt = {
		collection = 'SpecepS CaraC',
		name = 'SpecepS CaraC',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

if may.conf.content.WIP then

SMODS.ConsumableType {
	key = 'ascendedtarots',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = SMODS.Gradients.may_col_asc_tarot,
	loc_txt = {
		collection = 'Ascended Tarots',
		name = 'Ascended Tarot',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Ascended Planets',
		name = 'Ascended Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedspectrals',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.SECONDARY_SET.Spectral,
	loc_txt = {
		collection = 'Ascended Spectrals',
		name = 'Ascended Spectral',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedyottas',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = SMODS.Gradients.may_col_asc_yotta,
	loc_txt = {
		collection = 'Ascended Yotta Cards',
		name = 'Ascended Yotta Card',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'pandimentionalplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Pandimentional Planets',
		name = 'Pandimentional Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'unworldlyplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Unworldly Planets',
		name = 'Unworldly Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'wondrousplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Wondrous Planets',
		name = 'Wondrous Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'epsilonplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Epsilon Planets',
		name = 'Epsilon Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

end

end


-- Booster packs

if may.conf.content.Boosters then

	-- Group key stuff
function SMODS.current_mod.process_loc_text()
	G.localization.misc.dictionary['k_may_editioncard_pack'] = "Edition Card Pack"
	G.localization.misc.dictionary['k_may_retro_pack'] = "Pixel Pack"
	G.localization.misc.dictionary['k_may_yotta_pack'] = "Yotta Card Pack"
	G.localization.misc.dictionary['k_may_voucher_pack'] = "Voucher Pack"
	G.localization.misc.dictionary['k_may_universal_pack'] = "Universal Pack"
	G.localization.misc.dictionary['k_may_booster_bundle'] = "Booster Bundle"
end

if may.conf.content.Consumables then
SMODS.Booster {
	key = "b_editioncard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("editioncards", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Edition Card Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Edition Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_editioncard_pack",
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("editioncards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_editioncard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 1, y = 0 },
	config = { extra = 6, choose = 1 },
	cost = 8,
	weight = .9,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("editioncards", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Edition Card Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Edition Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_editioncard_pack",
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("editioncards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_mega_editioncard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 2, y = 0 },
	config = { extra = 6, choose = 2 },
	cost = 10,
	weight = .8,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("editioncards", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Edition Card Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Edition Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_editioncard_pack",
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("editioncards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

if false then

SMODS.Booster {
	key = "b_retrocard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	select_card = 'consumeables',
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Pixel Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Retro Cards{}",
			"to be reserved"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_retrocard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	config = { extra = 5, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	select_card = 'consumeables',
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Pixel Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Retro Cards{}",
			"to be reserved"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_mega_retrocard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	config = { extra = 5, choose = 2 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	select_card = 'consumeables',
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Pixel Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Retro Cards{}",
			"to be reserved"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

end

-- have to use pseudorandom element because all of the yotta cards are technically hidden
may.yotta_cards = {
	'c_may_planetae',
	'c_may_cupiditas',
	'c_may_potestas'
}

may.asc_yotta_cards = {
	'c_may_planetae_asc',
	'c_may_cupiditas_asc',
	'c_may_potestas_asc'
}

if may.conf.content.WIP and may.conf.Mode == 2 then

SMODS.Booster {
	key = "b_yottacard1",
	kind = 'yottacard',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 1, choose = 1 },
	cost = 100,
	weight = .5,
	misc_badge = may_wip_badge,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("yottacards", G.pack_cards, nil, nil, true, true, pseudorandom_element(may.yotta_cards, pseudoseed('may_yotta_pack')), "may_yottapack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.YELLOW, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Yotta Card Pack",
		text = {
			"Choose {C:attention}#1#{} random {C:money}Yotta Card{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		if (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "ascendedyottas") then
			ease_background_colour({ new_colour = G.C.BLACK, special_colour = SMODS.Gradients.may_col_asc_yotta, contrast = 2 })
		else
			ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.YELLOW, contrast = 2 })
		end
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_yotta_pack",
	cry_digital_hallucinations = {
		colour = G.C.YELLOW,
		loc_key = "may_cry_plus_yotta",
		create = function()
			local ccard = create_card("yottacards", G.consumables, nil, nil, nil, nil, pseudorandom_element(may.yotta_cards, pseudoseed('may_yotta_pack')), "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

end

end

SMODS.Booster {
	key = "b_voucherpack1",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 3, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 10,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_voucherpack2",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 4, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 10,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_voucherpack3",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 0, y = 1 },
	config = { extra = 2, choose = 1 },
	cost = 10,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_voucherpack4",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 1, y = 1 },
	config = { extra = 2, choose = 1 },
	cost = 10,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_voucherpack1",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 2, y = 1 },
	order = 5,
	config = { extra = 4, choose = 1 },
	cost = 15,
	weight = .8,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_voucherpack2",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 3, y = 1 },
	order = 5,
	config = { extra = 4, choose = 1 },
	cost = 15,
	weight = .8,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_voucherpack3",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 4, y = 1 },
	order = 5,
	config = { extra = 4, choose = 1 },
	cost = 15,
	weight = .8,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_voucherpack4",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 0, y = 2 },
	order = 5,
	config = { extra = 4, choose = 1 },
	cost = 15,
	weight = .8,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_mega_voucherpack1",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 1, y = 2 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 20,
	weight = .6,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_mega_voucherpack2",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 2, y = 2 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 20,
	weight = .6,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_mega_voucherpack3",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 3, y = 2 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 20,
	weight = .6,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_mega_voucherpack4",
	kind = 'voucher',
	atlas = "booster",
	pos = { x = 4, y = 2 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 20,
	weight = .6,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				jl.voucher()
			return true end}))
		end
	}
}

end

may.universal_choices = {'Tarot', 'Planet', 'Spectral', 'Voucher'}

if may.conf.content.WIP then

SMODS.Booster {
	key = "b_universalpack",
	kind = 'universal',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 7, choose = 2 },
	cost = 9,
	weight = 1,
	draw_hand = true,
	misc_badge = may_wip_badge,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Universal Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{},",
			"{C:spectral}Spectral{} Cards or {C:green}Vouchers{} to be",
			"used or redeemed immediately "

		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_universalpack",
	kind = 'universal',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 8, choose = 3 },
	cost = 11,
	weight = .8,
	draw_hand = true,
	misc_badge = may_wip_badge,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Universal Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{},",
			"{C:spectral}Spectral{} Cards or {C:green}Vouchers{} to be",
			"used or redeemed immediately "

		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

SMODS.Booster {
	key = "b_mega_universalpack",
	kind = 'universal',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 9, choose = 3 },
	cost = 13,
	weight = .6,
	draw_hand = true,
	misc_badge = may_wip_badge,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Mega Universal Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{},",
			"{C:spectral}Spectral{} Cards or {C:green}Vouchers{} to be",
			"used or redeemed immediately "

		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

--[[SMODS.Booster {
	key = "b_booster_bundle",
	kind = 'booster',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 7,
	weight = .7,
	draw_hand = false,
	select_card = 'consumeables',
	create_card = function(self, card)
		return create_card("Booster", G.pack_cards, nil, nil, true, true, nil, "may_boosterbundle")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Booster Bundle",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Booster Packs{}",
			"to be added to your Consumable Slots"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.PURPLE, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_booster_bundle",
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_booster",
		create = function()
			local ccard = create_card("Booster", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}]]

end

	-- Buff spectral packs so the mod isnt grindy nonsense
	
SMODS.Booster:take_ownership('p_spectral_normal_1', {
	weight = 1,
	config = {extra = 3, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_normal_2', {
	weight = 1,
	config = {extra = 3, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_jumbo_1', {
	weight = .6,
	config = {extra = 5, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_mega_1', {
	weight = .4,
	config = {extra = 6, choose = 2}
})

-- Achievements

SMODS.Achievement {
	key = 'keplers_nightmare',
	loc_txt = {
		name = "Kepler's Nightmare",
		description = {
			"Level up a Poker Hand",
			"to level 1e100"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 1, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "upgrade_hand" and to_big(args.level):gt(to_big(1e100)) then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'big_hundred',
	loc_txt = {
		name = "Big Hundred",
		description = {
			"Reach Ante 100"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 3, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "ante_up" and args.ante >= 100 then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'money_mouth',
	loc_txt = {
		name = ":money_mouth:",
		description = {
			"Have $e1000"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 2, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'money' and G.GAME.dollars >= to_big(1e100):arrow(1, 10) then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'the_one',
	loc_txt = {
		name = "The One",
		description = {
			"Have a deck of 1 card"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 4, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'modify_deck' and #G.playing_cards == 1 then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'i_think',
	loc_txt = {
		name = "I think that's enough",
		description = {
			"Win a run with 30 Jokers"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 5, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'win' and #G.jokers.cards >=30 then
			return true
		end
	end,
}

-- Consumables

if may.conf.content.Consumables then

	-- Upside Down Consumables

-- Upside Down Planets

if may.conf.content.WIP then

SMODS.Consumable {
	key = 'mercury_upsd',
	set = 'upside_down_planets',
	name = 'MercucreM',
	loc_txt = {
		name = "MercucreM",
		text = {
			"{C:mult}Level down{} {C:purple}Pair{}",
			"{C:planet}Level up{} {C:purple}Two Pair{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 9, y = 2 },
	config = { extra = { hand1 = 'Pair', hand2 = 'Two Pair' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'venus_upsd',
	set = 'upside_down_planets',
	name = 'VeneV',
	loc_txt = {
		name = "VeneV",
		text = {
			"{C:mult}Level down{} {C:purple}Three of a Kind{}",
			"{C:planet}Level up{} {C:purple}Straight{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 8, y = 2 },
	config = { extra = { hand1 = 'Three of a Kind', hand2 = 'Straight' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'earth_upsd',
	set = 'upside_down_planets',
	name = 'EaraE',
	loc_txt = {
		name = "EaraE",
		text = {
			"{C:mult}Level down{} {C:purple}Full House{}",
			"{C:planet}Level up{} {C:purple}Four of a Kind{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 7, y = 2 },
	config = { extra = { hand1 = 'Full House', hand2 = 'Four of a Kind' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'mars_upsd',
	set = 'upside_down_planets',
	name = 'MaaM',
	loc_txt = {
		name = "MaaM",
		text = {
			"{C:mult}Level down{} {C:purple}Four of a Kind{}",
			"{C:planet}Level up{} {C:purple}Straight Flush{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 6, y = 2 },
	config = { extra = { hand1 = 'Four of a Kind', hand2 = 'Straight Flush' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'jupiter_upsd',
	set = 'upside_down_planets',
	name = 'JupuJ',
	loc_txt = {
		name = "JupuJ",
		text = {
			"{C:mult}Level down{} {C:purple}Flush{}",
			"{C:planet}Level up{} {C:purple}Full House{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 5, y = 2 },
	config = { extra = { hand1 = 'Flush', hand2 = 'Full House' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'saturn_upsd',
	set = 'upside_down_planets',
	name = 'SatutaS',
	loc_txt = {
		name = "SatutaS",
		text = {
			"{C:mult}Level down{} {C:purple}Straight{}",
			"{C:planet}Level up{} {C:purple}Flush{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 4, y = 2 },
	config = { extra = { hand1 = 'Straight', hand2 = 'Flush' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'uranus_upsd',
	set = 'upside_down_planets',
	name = 'UrarU',
	loc_txt = {
		name = "UrarU",
		text = {
			"{C:mult}Level down{} {C:purple}Two Pair{}",
			"{C:planet}Level up{} {C:purple}Three of a Kind{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 3, y = 2 },
	config = { extra = { hand1 = 'Two Pair', hand2 = 'Three of a Kind' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'neptune_upsd',
	set = 'upside_down_planets',
	name = 'NeptpeN',
	loc_txt = {
		name = "NeptpeN",
		text = {
			"{C:mult}Level down{} {C:purple}Straight Flush{}",
			"{C:planet}Level up{} {C:purple}Royal Flush{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 2, y = 2 },
	config = { extra = { hand1 = 'Straight Flush', hand2 = 'may_Royal Flush' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'pluto_upsd',
	set = 'upside_down_planets',
	name = 'PlulP',
	loc_txt = {
		name = "PlulP",
		text = {
			"{C:mult}Level down{} {C:purple}High Card{}",
			"{C:planet}Level up{} {C:purple}Pair{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 1, y = 2 },
	config = { extra = { hand1 = 'High Card', hand2 = 'Pair' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'planet_x_upsd',
	set = 'upside_down_planets',
	name = 'PlaalP X',
	loc_txt = {
		name = "PlaalP X",
		text = {
			"{C:mult}Level down{} {C:purple}Five of a Kind{}",
			"{C:planet}Level up{} {C:purple}Flush House{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 0, y = 3 },
	config = { extra = { hand1 = 'Five of a Kind', hand2 = 'Flush House' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.hands['Five of a Kind'].visible and G.GAME.hands['Flush Five'].visible, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'ceres_upsd',
	set = 'upside_down_planets',
	name = 'CereC',
	loc_txt = {
		name = "CereC",
		text = {
			"{C:mult}Level down{} {C:purple}Flush House{}",
			"{C:planet}Level up{} {C:purple}Flush Five{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 1, y = 3 },
	config = { extra = { hand1 = 'Flush House', hand2 = 'Flush Five' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.hands['Flush House'].visible and G.GAME.hands['Flush Five'].visible, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'eris_upsd',
	set = 'upside_down_planets',
	name = 'ErE',
	loc_txt = {
		name = "ErE",
		text = {
			"{C:mult}Level down{} {C:purple}Flush Five{}",
			"{C:planet}Level up{} {C:purple}High Card{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 6, y = 3 },
	config = { extra = { hand1 = 'Flush', hand2 = 'Full House' } },
	atlas = 'upside_down',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.hands['Flush Five'].visible, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'proxima_centauri_upsd',
	set = 'upside_down_planets',
	name = 'ProxorP CentneC',
	loc_txt = {
		name = "ProxorP CentneC",
		text = {
			"{C:mult}Level down{} {C:purple}Royal Flush{}",
			"{C:planet}Level up{} {C:purple}Five of a Kind{} {C:attention}2{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 0, y = 2 },
	config = { extra = { hand1 = 'may_Royal Flush', hand2 = 'Five of a Kind' } },
	atlas = 'placeholder',
	cost = 30,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		jl.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		jl.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 2)
		delay(1.3)
		jl.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.hands['Five of a Kind'].visible, { allow_duplicates = false }
	end
}


-- Upside Down Spectrals

SMODS.Consumable {
	key = 'familiar_upsd',
	set = 'upside_down_spectrals',
	name = 'FamiimaF',
	loc_txt = {
		name = "FamiimaF",
		text = {
			"{C:mult}Destroys{} all {C:attention}face cards{} in {C:attention}hand{}",
			"{C:attention}+1 Hand Size{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 9, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for _, card in ipairs(G.hand.cards) do
			if card:is_face() then
				card:start_dissolve(nil, false)
				table.insert(targets, card)
			end
		end
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
		G.hand:change_size(1)
	end
}


SMODS.Consumable {
	key = 'grim_upsd',
	set = 'upside_down_spectrals',
	name = 'GrrG',
	loc_txt = {
		name = "GrrG",
		text = {
			"{C:mult}Destroys{} all {C:attention}Aces{} in {C:attention}full deck{}",
			"{C:attention}-1 Ante{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 8, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for _, card in ipairs(G.playing_cards) do
			if card:get_id() == 14 then
				card:start_dissolve(nil, true)
				table.insert(targets, card)
			end
		end
		ease_ante(-1)
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}


SMODS.Consumable {
	key = 'incantation_upsd',
	set = 'upside_down_spectrals',
	name = 'IncantnacnI',
	loc_txt = {
		name = "IncantnacnI",
		text = {
			"{C:mult}Destroys{} all {C:attention}numbered cards{} in {C:attention}hand{}",
			"{C:attention}+2 Consumable Slots{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 7, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for _, card in ipairs(G.hand.cards) do
			if not card:is_face() then
				card:start_dissolve(nil, false)
				table.insert(targets, card)
			end
		end
		G.consumeables:change_size(2)
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}

SMODS.Consumable {
	key = 'talisman_upsd',
	set = 'upside_down_spectrals',
	name = 'TalilaT',
	loc_txt = {
		name = "TalilaT",
		text = {
			"{C:mult}Removes{} {C:attention}Gold Seal{} from all cards in {C:attention}deck{}",
			"Gives all {C:attention}cards{} held in {C:attention}hand random{} {C:dark_edition}Enhancements{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 6, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and G.hand
	end,
	use = function(self, card, area, copier)
		local enhance = {}
		for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
			if v.key ~= 'm_stone' then
				table.insert(enhance, v)
			end
		end
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Gold' then
				card:set_seal(nil, true, false)
			end
		end
		play_sound('gong')
		delay(0.5)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
				delay(0.5)
			return true end}))
		end
		for _, card in ipairs(G.hand.cards) do
			card:set_ability(pseudorandom_element(enhance, pseudoseed('may_talisman_upsd')), false, false)
		end
		delay(0.5)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
				delay(0.5)
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'aura_upsd',
	set = 'upside_down_spectrals',
	name = 'AuuA',
	loc_txt = {
		name = "AuuA",
		text = {
			"{C:attention}Select{} a {C:attention}playing card{} with an {C:dark_edition}Edition{}",
			"{C:mult}Remove it's{} {C:dark_edition}Edition{} and {C:planet}level up{}",
			"{C:attention}3 random{} {C:purple}Poker Hands{} {C:attention}500{} times",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 5, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and G.hand and #G.hand.highlighted == (1 + (card.area == G.hand and 1 or 0)) and G.hand.highlighted[1].edition
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		local percent = 1.15 - (1-0.999)/(#G.hand.highlighted-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			G.hand.highlighted[1]:flip()
			play_sound('card1', percent)
			G.hand.highlighted[1]:juice_up(0.3, 0.3)
		return true end}))
		G.hand.highlighted[1].edition = nil
		percent = 0.85 + (1-0.999)/(#G.hand.highlighted-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			G.hand.highlighted[1]:flip()
			play_sound('tarot2', percent, 0.6)
			G.hand.highlighted[1]:juice_up(0.3, 0.3)
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
		delay(0.5)
		for i=1, 3, 1 do
			local hand = jl.rndhand()
			jl.th(hand)
			level_up_hand(card, hand, nil, 500)
			jl.ch()
		end
	end
}

SMODS.Consumable {
	key = 'wraith_upsd',
	set = 'upside_down_spectrals',
	name = 'WraarW',
	loc_txt = {
		name = "WraarW",
		text = {
			"{C:mult}Destroys{} {C:attention}all{} {X:rare,C:white}Rare{} {C:attention}Jokers{}",
			"{C:chips}+2 Hands{} and {C:mult}Discards{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 4, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == 3 then
				v:start_dissolve(nil, false)
			end
		end
		ease_hands_played(2)
		ease_discard(2)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
	end
}

SMODS.Consumable {
	key = 'sigil_upsd',
	set = 'upside_down_spectrals',
	name = 'SigiS',
	loc_txt = {
		name = "SigiS",
		text = {
			"{C:attention}Select{} a {C:attention}playing card{}",
			"{C:mult}Destroys{} all {C:attention}cards{} in {C:attention}full deck{} with {C:attention}that card's suit{}",
			"{X:money,C:white}X2${}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 3, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and G.hand and #G.hand.highlighted == (1 + (card.area == G.hand and 1 or 0))
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local suit = G.hand.highlighted[1].base.suit
		for k, v in pairs(G.playing_cards) do
			if v.base.suit == suit then
				v:start_dissolve(nil, false)
				table.insert(targets, card)
			end
		end
		hypermoney(0, 2)
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}

SMODS.Consumable {
	key = 'ouija_upsd',
	set = 'upside_down_spectrals',
	name = 'OuiuO',
	loc_txt = {
		name = "OuiuO",
		text = {
			"{C:attention}Select{} a {C:attention}playing card{}",
			"{C:mult}Destroys{} all {C:attention}cards{} in {C:attention}full deck{} with {C:attention}that card's rank{}",
			"{C:attention}Redeem{} a {C:attention}random{} {C:green}Voucher{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and G.hand and #G.hand.highlighted == (1 + (card.area == G.hand and 1 or 0))
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local rank = G.hand.highlighted[1]:get_id()
		for k, v in pairs(G.playing_cards) do
			if v:get_id() == rank then
				v:start_dissolve(nil, false)
				table.insert(targets, v)
			end
		end
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
		G.E_MANAGER:add_event(Event({func = function()
			jl.voucher()
		return true end}))
	end
}

SMODS.Consumable {
	key = 'ectoplasm_upsd',
	set = 'upside_down_spectrals',
	name = 'EctopotcE',
	loc_txt = {
		name = "EctopotcE",
		text = {
			"{C:mult}Removes{} {C:dark_edition}Negative{} from {C:attention}all{} {C:attention}Jokers{}",
			"If {C:attention}Joker Slots{} are {C:attention}overfilled{}, {C:mult}destroy{}",
			"{C:attention}rightmost Jokers{} until they are {C:attention}no longer overfilled{}",
			"Gain 10 {C:attention}random{} {C:dark_edition}Negative Edition Cards{}",
			"{C:inactive}(requires room){}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 1, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and #G.consumeables.cards < G.consumeables.config.card_limit
	end,
	use = function(self, card, area, copier)
		local jokers_found = {}
		for k, v in pairs(G.jokers.cards) do
			if v.edition and v.edition.type == 'negative' then
				v.edition = nil
			end
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local edition = create_card("editioncards", G.consumables, nil, nil, nil, nil, nil, "may_ectoplasm_upsd")
			edition:add_to_deck()
			G.consumeables:emplace(edition)
			edition:set_edition({negative = true})
		return true end}))
	end
}

SMODS.Consumable {
	key = 'immolate_upsd',
	set = 'upside_down_spectrals',
	name = 'ImmoommI',
	loc_txt = {
		name = "ImmoommI",
		text = {
			"{C:attention}Duplicates{} up to {C:attention}5 selected cards{}",
			"{X:mult,C:white}X0.5{} Mult to {C:attention}most played{} {C:planet}Poker Hand{} per {C:attention}selected card{}",
			"{C:inactive}(base of X1, will upgrade #1#){}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 0, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and G.hand and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0))
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand() } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.highlighted) do
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local _card = copy_card(v, nil, nil, G.playing_card)
			_card:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, _card)
			G.hand:emplace(_card)
			_card:start_materialize(nil, _first_dissolve)
			_first_dissolve = true
		end
		playing_card_joker_effects(new_cards)
		delay(0.5)
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult * ((#G.hand.highlighted*0.5) + 1)
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, 'X'..((#G.hand.highlighted*0.5) + 1), true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'ankh_upsd',
	set = 'upside_down_spectrals',
	name = 'AnnA',
	loc_txt = {
		name = "AnnA",
		text = {
			"{C:mult}Destroys{} all {C:attention}duplicate Jokers{}",
			"{C:attention}Creates{} a {C:attention}random{} {X:may_mythic,C:white}Mythic{} {C:attention}Joker{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 9, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local joker_keys = {}
		local duplicates = {}
		for k, v in pairs(G.jokers.cards) do
			if not table_hasvalue(joker_keys, v:gc().key) then
				table.insert(joker_keys, v:gc().key)
			else
				table.insert(duplicates, v)
			end
		end
		for k, v in pairs(duplicates) do
			v:start_dissolve(nil, false)
		end
		delay(0.5)
		local mythic = create_card("Joker", G.consumables, nil, 'may_mythic', nil, nil, nil, "may_ankh_upsd")
		mythic:add_to_deck()
		G.jokers:emplace(mythic)
		play_sound('may_mythic_joker')
	end
}

SMODS.Consumable {
	key = 'deja_vu_upsd',
	set = 'upside_down_spectrals',
	name = 'DeeD VV',
	loc_txt = {
		name = "DeeD VV",
		text = {
			"{C:mult}Removes{} {C:attention}Red Seal{} from all cards in {C:attention}deck{}",
			"Gives all {C:attention}Jokers random{} {C:dark_edition}Editions{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 8, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Red' then
				card:set_seal(nil, true, false)
			end
		end
		play_sound('gong')
		delay(0.5)
		for i = 1, #G.jokers.cards do
			local joker = G.jokers.cards[i]
			G.E_MANAGER:add_event(Event({trigger = "after",delay = 0.15,func = function()
				if not joker.edition then
					joker:set_edition(poll_edition('may_deja_vu_upsd', nil, true, true), true, true)
				end
				joker:juice_up(0.3, 0.3)
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'hex_upsd',
	set = 'upside_down_spectrals',
	name = 'HeH',
	loc_txt = {
		name = "HeH",
		text = {
			"{C:mult}Removes{} {C:dark_edition}Polychrome{} from all Jokers",
			"{C:money}+$120{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 7, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.jokers.cards) do
			if card.edition and card.edition.type == 'polychrome' then
				card:set_edition(nil, true, false)
			end
		end
		play_sound('gong')
		delay(0.5)
		ease_dollars(120)
	end
}

SMODS.Consumable {
	key = 'trance_upsd',
	set = 'upside_down_spectrals',
	name = 'TraarT',
	loc_txt = {
		name = "TraarT",
		text = {
			"{C:mult}Removes{} {C:attention}Blue Seal{} from all cards in {C:attention}deck{}",
			"Applies {C:dark_edition}Negative{} to a {C:attention}random Joker{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 6, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Blue' then
				card:set_seal(nil, true, false)
			end
		end
		play_sound('gong')
		delay(0.5)
		local targets = {}
		for k, v in pairs(G.jokers.cards) do
			if not v.edition then
				table.insert(targets, v)
			end
		end
		local joker = pseudorandom_element(targets, pseudoseed('may_trance_upsd'))
		joker:set_edition({negative = true})
	end
}

SMODS.Consumable {
	key = 'medium_upsd',
	set = 'upside_down_spectrals',
	name = 'MeddeM',
	loc_txt = {
		name = "MeddeM",
		text = {
			"{C:mult}Removes{} {C:attention}Purple Seal{} from all cards in {C:attention}deck{}",
			"{X:money,C:white}X1.2${}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 5, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Purple' then
				card:set_seal(nil, true, false)
			end
		end
		play_sound('gong')
		delay(0.5)
		hypermoney(0, 1.2)
	end
}

SMODS.Consumable {
	key = 'cryptid_upsd',
	set = 'upside_down_spectrals',
	name = 'CrypyrC',
	loc_txt = {
		name = "CrypyrC",
		text = {
			"{C:mult}Destroys{} all {C:attention}duplicates{} of a {C:attention}random playing card{}",
			"{C:money}+70${}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 4, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local selected_card = pseudorandom_element(G.playing_cards, pseudoseed('may_cryptid_upsd'))
		for k, v in pairs(G.playing_cards) do
			if v:get_id() == selected_card:get_id() and v.base.suit == selected_card.base.suit then
				v:start_dissolve(nil, false)
				table.insert(targets, card)
			end
		end
		delay(0.5)
		ease_dollars(70)
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}

SMODS.Consumable {
	key = 'soul_upsd',
	set = 'upside_down_spectrals',
	name = 'SooS',
	loc_txt = {
		name = "SooS",
		text = {
			"{C:mult}Destroys{} all {X:legendary,C:white}Legendary{} {C:attention}Jokers{}",
			"{C:attention}Creates{} {C:attention}random{} {X:may_mythic,C:white}Mythic{} and {X:may_transcendent,C:white}Transcendent{} {C:attention}Jokers{}",
			"for {C:attention}every destroyed Joker{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 7, y = 3 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == 4 then
				v:start_dissolve(nil, false)
				amount = amount + 1
			end
		end
		delay(0.5)
		for i=1, amount, 1 do
			if math.floor(pseudorandom('may_soul_upsd')*10)/5 > 1 then
				local mythic = create_card("Joker", G.consumables, nil, 'may_mythic', nil, nil, nil, "may_ankh_upsd")
				mythic:add_to_deck()
				G.jokers:emplace(mythic)
				play_sound('may_mythic_joker')
			else
				local transcendent = create_card("Joker", G.consumables, nil, 'may_transcendent', nil, nil, nil, "may_ankh_upsd")
				transcendent:add_to_deck()
				G.jokers:emplace(transcendent)
				play_sound('may_transcendent_joker')
			end
		end
	end
}

SMODS.Consumable {
	key = 'black_hole_upsd',
	set = 'upside_down_spectrals',
	name = 'BlalB HooH',
	loc_txt = {
		name = "BlalB HooH",
		text = {
			"{C:mult}Levels down{} {C:attention}all Poker Hands{} by 1",
			"Creates {C:dark_edition}Universal Collapse{}",
			"{C:inactive}(requires room){}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	pos = { x = 0, y = 2 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse() and #G.jokers.cards < G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		may.level_up_all_hands(card, false, -1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
			G.jokers:emplace(card2)
			play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
			card2:add_to_deck()
		return true end}))
	end
}

end

	-- Empowered Consumables
		
		-- Ascended
		
		-- Tarots
if may.conf.content.WIP then

SMODS.Consumable {
	key = 'fool_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Fool",
		text = {
			"Creates {C:attention}5{} {C:dark_edition}Negative{} {C:attention}copies{} of the last used",
			"{C:purple}Tarot{} or {C:planet}Planet{} card this run"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.last_tarot_planet
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local new = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, 'may_asc_fool')
			new:add_to_deck()
			G.consumeables:emplace(new)
			new:juice_up(0.3, 0.5)
			new:set_edition({negative = true}, false, false)
			if Incantation then
				if card.ability.qty then
					new:setQty(card.ability.qty*5)
				end
			else
				for i=1, 4, 1 do
					local copy = copy_card(new, nil)
					G.consumeables:emplace(copy)
					copy:add_to_deck()
					copy:set_edition({negative = true}, false, false)
				end
			end
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'magician_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Magician",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Lucky{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 10, mod_conv = "m_lucky" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'high_priestess_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended High Priestess",
		text = {
			"Creates {C:attention}10 random{} {C:dark_edition}Negative{} {C:planet}Planet Cards{}",
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i=1, 10, 1 do
				play_sound('timpani')
				local new = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_asc_high_priestess')
				new:add_to_deck()
				G.consumeables:emplace(new)
				new:juice_up(0.3, 0.5)
				new:set_edition({negative = true})
			end
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'empress_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Empress",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Mult{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 10, mod_conv = "m_mult" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'emperor_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Emperor",
		text = {
			"Creates up to {C:attention}2 random{} {C:may_ascendedtarots}Ascended Tarot{} cards",
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
				play_sound('timpani')
				local new = create_card('ascendedtarots', G.consumeables, nil, nil, nil, nil, nil, 'may_asc_emperor')
				new:add_to_deck()
				G.consumeables:emplace(new)
				new:juice_up(0.3, 0.5)
			end
		return true end}))
	end,
}

-- localthunk why
SMODS.Consumable {
	key = 'heiropant_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Hierophant",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Bonus{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 10, mod_conv = "m_bonus" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'lovers_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Lovers",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Wild{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 5, mod_conv = "m_wild" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'chariot_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Chariot",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Steel{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 5, mod_conv = "m_steel" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'justice_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Justice",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Glass{} cards"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	config = { max_highlighted = 5, mod_conv = "m_glass" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
}

SMODS.Consumable {
	key = 'hermit_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Hermit",
		text = {
			"{X:money,C:white}X2${}",
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'asc_tarot',
	cost = 100,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		hypermoney(0, 2, false)
	end,
}

SMODS.Consumable {
	key = 'wheel_of_fortune_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Wheel of Fortune",
		text = {
			"{C:green}#1# in 4{} chance to apply",
			"{C:dark_edition}any Edition{} to a random Joker"
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 100,
	unlocked = true,
	config = { extra = { has_targets = false, odds = 4 } },
	can_use = function(self, card)
		return jl.canuse() and card.ability.extra.has_targets
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		if pseudorandom('may_wheel_of_fortune_asc') < G.GAME.probabilities.normal / card.ability.extra.odds then
			local targets = {}
			for k, v in pairs(G.jokers.cards) do
				if not v.edition then
					table.insert(targets, v)
				end
			end
			local joker = pseudorandom_element(targets, pseudoseed('may_wheel_of_fortune_asc'))
			joker:set_edition(poll_edition('may_wheel_of_fortune_asc', nil, true, false))
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				attention_text({
					text = localize('k_nope_ex'),
					scale = 1.3, 
					hold = 1.4,
					major = card,
					backdrop_colour = SMODS.Gradients.may_col_asc_tarot,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
					offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0},
					silent = true
					})
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
						play_sound('tarot2', 0.76, 0.4)
					return true end}))
					play_sound('tarot2', 1, 0.4)
					card:juice_up(0.3, 0.5)
            return true end}))
		end
	end,
	update = function(self, card, dt)
		card.ability.extra.has_targets = false
		if G.GAME.blind then
			for k, v in pairs(G.jokers.cards) do
				if not v.edition then
					card.ability.extra.has_targets = true
					break
				end
			end
		end
	end
}


	-- Planets
	
SMODS.Consumable {
	set = 'ascendedplanets',
	key = 'pluto_asc',
	config = { mphand = 2, other = -1 },
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	misc_badge = may_wip_badge,
	cost = 100,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ascended Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Ascended Pluto',
		text = {
			"{C:attention}Doubles{} the {C:planet}level{} of",
			"{C:attention}High Card{} (lvl.#1#)"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 2)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 2*number)
		delay(0.5)
		jl.ch()
	end,
}
	
	-- Spectrals
	
-- Relic from when Ascended consumables were the only Empowerement tier, will be reworked later
--[[SMODS.Consumable {
	key = 'familiar_asc',
	set = 'ascendedspectrals',
	loc_txt = {
		name = "Ascended Familiar",
		text = {
			"{C:mult}Destroys{} all {C:attention}numbered{} cards in deck",
			"and creates {C:attention}2{} random face cards with random {C:green}enhancements{}, {C:dark_edition}editions{} and {C:green}seals{}",
			"for each destroyed card"
		}
	},
	pos = { x = 3, y = 1 },
	atlas = 'consumable',
	cost = 100,
	misc_badge = may_wip_badge,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	soul_rate = 0.01,
	use = function(self, card, area, copier)
		local enhance = {}
		for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
			if v.key ~= 'm_stone' then
				table.insert(enhance, v)
			end
		end
		local amount = 0
		local targets = {}
		for _, card in ipairs(G.playing_cards) do
			if not card:is_face() then
				card:start_dissolve(nil, true)
				amount = amount + 2
				table.insert(targets, card)
			end
		end
		for i=1, amount, 1 do
			local rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('asc_familiar'))
            local suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('asc_familiar'))
			local card = create_playing_card({front = G.P_CARDS[suit..'_'..rank], center = pseudorandom_element(enhance, pseudoseed('asc_familiar'))}, G.play, true, i ~= 1, {G.C.SECONDARY_SET.Spectral})
			card:set_edition(poll_edition('may_asc_familiar', nil, true, false), true, true)
			card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "asc_familiar" }), true, false)
			card:add_to_deck(false)
			G.play:remove_card(card)
			G.deck:emplace(card)
		end
		-- Play the card sounds separately so the sound manager doesnt get overloaded
		for i=1, 10, 1 do
			play_sound('card1')
		end
		play_sound('gong')
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end,
}]]

-- Yotta

SMODS.Consumable {
	key = 'planetae_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Planetae",
		text = {
			"Gives all Poker Hands",
			"{X:purple,C:white}^^^33{} Mult & Chips"
		}
	},
	config = { amount = 33 },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { '{5}' } }
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, self.config.amount)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(3, self.config.amount)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 4
		return true end}))
		jl.hcm(nil, '^^^'..self.config.amount, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 4
		return true end}))
		jl.hcm('^^^'..self.config.amount, nil, true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, self.config.amount*number)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(3, self.config.amount*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + (4 + math.min(number/10, 10))
		return true end}))
		jl.hcm(nil, '^^^'..self.config.amount*number, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + (4 + math.min(number/10, 10))
		return true end}))
		jl.hcm('^^^'..self.config.amount*number, nil, true)
		jl.ch()
		delay(0.5)
	end,
}

SMODS.Consumable {
	key = 'cupiditas_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Cupiditas",
		text = {
			"{X:money,C:white}^^1.2${}",
			"{C:inactive,E:1,s:0.5}art by Violet{}"
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		hypermoney(2, 1.2, false)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(2, 1.2*number, false)
	end,
}

SMODS.Consumable {
	key = 'potestas_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Potestas",
		text = {
			"{C:attention}Doubles{} {C:dark_edition}score operator{} level",
			"{C:inactive,E:1,s:0.5}art by Violet{}"
		}
	},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		mod_score_operator(0, 2)
	end,
	bulk_use = function(self, card, area, copier, number)
		mod_score_operator(0, 2*number)
	end,
}

SMODS.Consumable {
	key = 'speculum_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Speculum",
		text = {
			"Create {C:attention}15{} {C:dark_edition}Negative{} {C:attention}copies{} of",
			"{C:attention}every Consumable{} in your possesion"
		}
	},
	config = { amount = 15 },
	misc_badge = may_wip_badge,
	pos = { x = 1, y = 0 },
	soul_pos = { x = 0, y = 0 },
	atlas = 'may_ascyotta_placeholder',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			for k,v in pairs(G.consumeables.cards) do
				for i=1, 15, 1 do
					local card2 = copy_card(v, nil, nil, nil, nil)
					card2:start_materialize()
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
					card2:set_edition({negative = true})
				end
			end
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			for k,v in pairs(G.consumeables.cards) do
				for i=1, 15*number, 1 do
					local card2 = copy_card(v, nil, nil, nil, nil)
					card2:start_materialize()
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
					card2:set_edition({negative = true})
				end
			end
		return true end}))
	end,
}

end

if not may.yottarate then
	if may.conf.Mode == 1 then
		may.yottarate = 0.02
	else
		may.yottarate = 0.03
	end
end

	-- Yotta Cards

if may.mode == 1 then

SMODS.Consumable {
	key = 'cupiditas',
	set = 'yottacards',
	loc_txt = {
		name = "Cupiditas",
		text = {
			"{X:money,C:white}X100${}",
		}
	},
	config = { amount = 2 },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		hypermoney(1, 100, false)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(0, 100*number, false)
	end,
}

else

SMODS.Consumable {
	key = 'cupiditas',
	set = 'yottacards',
	loc_txt = {
		name = "Cupiditas",
		text = {
			"{X:money,C:white}^2${}",
		}
	},
	config = { amount = 2 },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		hypermoney(1, 2, false)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(1, 2*number, false)
	end,
}

end

SMODS.Consumable {
	key = 'planetae',
	set = 'yottacards',
	loc_txt = {
		name = "Planetae",
		text = {
			"Gives all Poker Hands",
			"{X:purple,C:white}^^3{} Mult & Chips"
		}
	},
	config = { amount = 3 },
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(2, self.config.amount)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, self.config.amount)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 2
		return true end}))
		jl.hcm(nil, '^^'..self.config.amount..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 2
		return true end}))
		jl.hcm('^^'..self.config.amount..'', nil, true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(2, self.config.amount*number)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, self.config.amount*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + (2 + math.min(number/10, 10))
		return true end}))
		jl.hcm(nil, '^^'..self.config.amount*number..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + (2 + math.min(number/10, 10))
		return true end}))
		jl.hcm('^^'..self.config.amount*number..'', nil, true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'potestas',
	set = 'yottacards',
	loc_txt = {
		name = "Potestas",
		text = {
			"Every {C:attention}2{} times this consumable is used,",
			"{C:attention}increase{} {C:dark_edition}score operator{} level",
			"by {C:attention}1{}",
			"{C:inactive}#1#{}"
		}
	},
	config = { amount = 1, },
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		if G.GAME.potestas_active then
			return { vars = { 'Active!' } }
		else
			return { vars = { 'Inactive' } }
		end
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		if G.GAME.potestas_active then
			mod_score_operator(-1, 1)
		else
			jl.a('Activated', 2, nil, G.C.YELLOW, 'gong')
			play_sound('generic1')
		end
		G.GAME.potestas_active = not (G.GAME.potestas_active or false)
	end,
	bulk_use = function(self, card, area, copier, number)
		mod_score_operator(-1, number/2)
		if number%2 ~= 0 then
			G.GAME.potestas_active = not (G.GAME.potestas_active or false)
			if G.GAME.potestas_active then
				jl.a('Activated', 2, nil, G.C.YELLOW, 'gong')
				play_sound('generic1')
			end
		end
	end,
}

SMODS.Consumable {
	key = 'speculum',
	set = 'yottacards',
	loc_txt = {
		name = "Speculum",
		text = {
			"Create {C:attention}5{} {C:dark_edition}Negative{} {C:attention}copies{} of",
			"{C:attention}every Consumable{} in your possesion"
		}
	},
	config = { amount = 5 },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 0 },
	atlas = 'placeholder',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			for k,v in pairs(G.consumeables.cards) do
				for i=1, 5, 1 do
					local card2 = copy_card(v, nil, nil, nil, nil)
					card2:start_materialize()
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
					card2:set_edition({negative = true})
				end
			end
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			for k,v in pairs(G.consumeables.cards) do
				for i=1, 5*number, 1 do
					local card2 = copy_card(v, nil, nil, nil, nil)
					card2:start_materialize()
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
					card2:set_edition({negative = true})
				end
			end
		return true end}))
	end,
}

	-- Pandimentional

SMODS.Consumable {
	set = 'pandimentionalplanets',
	key = 'pluto_pan',
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	cost = 500,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Pandimentional Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Pandimentional Pluto',
		text = {
			"{C:attention}Quintuples{} the {C:planet}level{} of",
			"{C:attention}High Card{} (lvl.#1#)"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 5)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 5*number)
		delay(0.5)
		jl.ch()
	end,
}

-- Unworldly

SMODS.Consumable {
	set = 'unworldlyplanets',
	key = 'pluto_unw',
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	cost = 1000,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Unworldly Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Unworldly Pluto',
		text = {
			"{X:planet,C:white}^3{} {C:planet}level{} of",
			"{C:attention}High Card{} (lvl.#1#)"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 3, 1)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 3*number, 1)
		delay(0.5)
		jl.ch()
	end,
}

-- Wondrous

SMODS.Consumable {
	set = 'wondrousplanets',
	key = 'pluto_won',
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	cost = 5000,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Wondrous Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Wondrous Pluto',
		text = {
			"{X:planet,C:white}^500{} {C:planet}level{} of",
			"{C:attention}High Card{} (lvl.#1#)"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 500, 1)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 500*number, 1)
		delay(0.5)
		jl.ch()
	end,
}

-- Epsilon

SMODS.Consumable {
	set = 'epsilonplanets',
	key = 'pluto_eps',
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	cost = 10000,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Epsilon Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Pluto Epsilon',
		text = {
			"{X:planet,C:white}^^3{} {C:planet}level{} of",
			"{C:attention}High Card{} (lvl.#1#)"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 3, 2)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 3*number, 2)
		delay(0.5)
		jl.ch()
	end,
}

	-- Tarots

SMODS.Consumable {
	key = 'blade',
	set = 'Tarot',
	loc_txt = {
		name = "The Blade",
		text = {
			"Enhances up to {C:attention}#1#{} selected card in {C:attention}hand{}",
			"into a {C:attention}Jagged{} card"
		}
	},
	pos = { x = 3, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_jagged" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'volcano',
	set = 'Tarot',
	loc_txt = {
		name = "The Volcano",
		text = {
			"Enhances up to {C:attention}#1#{} selected card in {C:attention}hand{}",
			"into a {C:attention}Magma{} card"
		}
	},
	pos = { x = 2, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_magma" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'spreadsheet',
	set = 'Tarot',
	loc_txt = {
		name = "The Spreadsheet",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Grid{} cards"
		}
	},
	pos = { x = 2, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 2, mod_conv = "m_may_grid" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'paragon',
	set = 'Tarot',
	loc_txt = {
		name = "The Paragon",
		text = {
			"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
			"into a {C:attention}Super Mult{} card"
		}
	},
	pos = { x = 5, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_super_mult']
	end,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
	
			return true end}))
		end
		local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('may_paragon'))
		for k, v in ipairs(G.hand.cards) do
			if v ~= selected_card then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					v:flip()
					play_sound('card1', 1+(k/10))
					delay(0.5)
				return true end}))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = true
			play_sound('card1')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = false
			selected_card:flip()
			selected_card:set_ability(G.P_CENTERS['m_may_super_mult'], true, nil)
			play_sound('tarot2')
			selected_card:juice_up(0.3, 0.3)
		return true end}))
	end
}

SMODS.Consumable {
	key = 'vines',
	set = 'Tarot',
	loc_txt = {
		name = "The Vines",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Overgrown{} cards"
		}
	},
	pos = { x = 1, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 3, mod_conv = "m_may_overgrown" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'pickaxe',
	set = 'Tarot',
	loc_txt = {
		name = "The Pickaxe",
		text = {
			"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
			"into a {C:attention}Platinum{} card"
		}
	},
	pos = { x = 1, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_platinum']
	end,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
	
			return true end}))
		end
		local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('may_miner'))
		for k, v in ipairs(G.hand.cards) do
			if v ~= selected_card then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					v:flip()
					play_sound('card1', 1+(k/10))
		
				return true end}))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = true
			play_sound('card1')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = false
			selected_card:flip()
			selected_card:set_ability(G.P_CENTERS['m_may_platinum'], true, nil)
			play_sound('tarot2')
			selected_card:juice_up(0.3, 0.3)
		return true end}))
	end
}

SMODS.Consumable {
	key = 'torch',
	set = 'Tarot',
	loc_txt = {
		name = "The Torch",
		text = {
			"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
			"into a {C:attention}Scorched{} card"
		}
	},
	pos = { x = 0, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_scorched']
	end,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
	
			return true end}))
		end
		local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('may_torch'))
		for k, v in ipairs(G.hand.cards) do
			if v ~= selected_card then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					v:flip()
					play_sound('card1', 1+(k/10))
					delay(0.5)
				return true end}))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = true
			play_sound('card1')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = false
			selected_card:flip()
			selected_card:set_ability(G.P_CENTERS['m_may_scorched'], true, nil)
			play_sound('tarot2')
			selected_card:juice_up(0.3, 0.3)
		return true end}))
	end
}

SMODS.Consumable {
	key = 'gem',
	set = 'Tarot',
	loc_txt = {
		name = "The Gem",
		text = {
			"Enhances #1# selected card in {C:attention}hand{}",
			"into a {C:attention}Crystal{} card"
		}
	},
	pos = { x = 4, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_crystal" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'box',
	set = 'Tarot',
	loc_txt = {
		name = "The Box",
		text = {
			"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
			"into {C:attention}Cardboard{} cards"
		}
	},
	pos = { x = 3, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 2, mod_conv = "m_may_cardboard" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'void',
	set = 'Tarot',
	loc_txt = {
		name = "The Void",
		text = {
			"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
			"into an {C:attention}Ultra{} card"
		}
	},
	pos = { x = 4, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	hidden = true,
	soul_rate = 0.05,
	soul_set = 'Tarot',
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.cards ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_ultra']
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
	
			return true end}))
		end
		local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('may_void'))
		for k, v in ipairs(G.hand.cards) do
			if v ~= selected_card then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					v:flip()
					play_sound('card1', 1+(k/10))
		
				return true end}))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = true
			play_sound('card1')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = false
			selected_card:flip()
			selected_card:set_ability(G.P_CENTERS['m_may_ultra'], true, nil)
			play_sound('tarot2')
			selected_card:juice_up(0.3, 0.3)
		return true end}))
	end
}

SMODS.Consumable {
	key = 'mecha',
	set = 'Tarot',
	loc_txt = {
		name = "The Mecha",
		text = {
			"Enhances #1# selected card in {C:attention}hand{}",
			"into a {C:attention}Titanium{} card"
		}
	},
	pos = { x = 0, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_titanium" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

	-- Spectrals
	
SMODS.Consumable {
	key = 'amnesia',
	set = 'Spectral',
	name = 'Amnesia',
	loc_txt = {
		name = "Amnesia",
		text = {
			"Add a {C:attention}Copper Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_copper_seal" },
	pos = { x = 0, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'apathy',
	set = 'Spectral',
	name = 'Apathy',
	loc_txt = {
		name = "Apathy",
		text = {
			"Add an {C:attention}Inverted Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_inverted_seal" },
	pos = { x = 1, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'fury',
	set = 'Spectral',
	name = 'Fury',
	loc_txt = {
		name = "Fury",
		text = {
			"Add an {C:attention}Orange Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_orange_seal" },
	pos = { x = 5, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'bargaining',
	set = 'Spectral',
	name = 'Bargaining',
	loc_txt = {
		name = "Bargaining",
		text = {
			"Add a {C:attention}Pink Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_pink_seal" },
	pos = { x = 3, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'conglomerate',
	set = 'Spectral',
	name = 'Conglomerate',
	loc_txt = {
		name = "Conglomerate",
		text = {
			"Add a {C:attention}Silver Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_silver_seal" },
	pos = { x = 1, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'canvas',
	set = 'Spectral',
	name = 'Canvas',
	loc_txt = {
		name = "Canvas",
		text = {
			"Add a {C:attention}White Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_white_seal" },
	pos = { x = 4, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'dream',
	set = 'Spectral',
	name = 'Dream',
	loc_txt = {
		name = "Dream",
		text = {
			"Add a {C:attention}Yellow Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_yellow_seal" },
	pos = { x = 4, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'mesmerize',
	set = 'Spectral',
	name = 'Mesmerize',
	loc_txt = {
		name = "Mesmerize",
		text = {
			"Add a {C:attention}Lime Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_lime_seal" },
	pos = { x = 4, y = 2 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'dependency',
	set = 'Spectral',
	name = 'Dependency',
	loc_txt = {
		name = "Dependency",
		text = {
			"Add a {C:attention}Black Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_black_seal" },
	pos = { x = 3, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'terminal_lucidity',
	set = 'Spectral',
	name = 'Terminal Lucidity',
	loc_txt = {
		name = "Terminal Lucidity",
		text = {
			"Add a {C:may_ethereal}?????{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_error_seal" },
	pos = { x = 2, y = 3 },
	soul_pos = { x = 4, y = 3 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	misc_badge = may_uncommon_badge,
	cost = 8,
	hidden = true,
	soul_rate = 0.08,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'warp',
	set = 'Spectral',
	loc_txt = {
		name = "Warp",
		text = {
			"{C:attention}#2# Ante{}",
			"Only works if you have {C:attention}at least{} {C:money}#1#${}"
		}
	},
	pos = { x = 3, y = 3 },
	display_size = { w = 65, h = 95 },
	config = { dollars = 30, ante = -1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.dollars, card.ability.ante or self.config.ante} }
	end,
	atlas = 'may_spectral',
	cost = 10,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.dollars > to_big(self.config.dollars)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		ease_ante(card.ability.ante)
		self.config.dollars = self.config.dollars*2
	end
}

SMODS.Consumable {
	key = 'deal',
	set = 'Spectral',
	loc_txt = {
		name = "Deal",
		text = {
			"{C:attention}+#1# Joker Slots{}",
			"{X:money,C:white}X#2#${}"
		}
	},
	pos = { x = 2, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 10,
	config = { slots = 2, x_dollars = 0.5 },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.slots or self.config.slots, card.ability.x_dollars or self.config.x_dollars } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.jokers:change_size(2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
		return true end}))
		delay(.2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			hypermoney(0, card.ability.x_dollars, false)
		return true end}))
	end
}

may.rare_planets = {
	'c_may_vespia',
	'c_may_stos',
	'c_may_triton',
	'c_may_yryx',
}

may.legendary_planets = {
	'c_may_kivaaritehdas',
	'c_may_quac_n7',
	'c_may_opolisis',
	'c_may_en_7b',
}

may.mythic_planets = {
	'c_may_amadeus',
	'c_may_theia',
	'c_may_gaea',
	'c_may_matakka'
}

SMODS.Consumable {
	key = 'astronomy',
	set = 'Spectral',
	loc_txt = {
		name = "Astronomy",
		text = {
			"Creates {C:attention}#1# random{} {X:mult,C:white}Rare{} {C:planet}Planet{} Cards",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 5,
	config = { planets = 2 },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.planets or self.config.planets } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(card.ability.planets*number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'celestra',
	set = 'Spectral',
	loc_txt = {
		name = "Celestra",
		text = {
			"Creates {C:attention}#1# random{} {X:legendary,C:white}Legendary{} {C:planet}Planet{} Card",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 5, y = 0 },
	soul_pos = { x = 0, y = 1, 
		draw = function(card, scale_mod, rotate_mod)
			card.hover_tilt = card.hover_tilt * 1.2
			card.children.floating_sprite:draw_shader('may_semihologram', nil, card.ARGS.send_to_shader, nil,
			card.children.center, 2 * scale_mod, 2 * rotate_mod)
			card.hover_tilt = card.hover_tilt / 1.2
        end
	},
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 5,
	hidden = true,
	soul_rate = 0.06,
	soul_set = 'Spectral',
	config = { planets = 1 },
	unlocked = true,
	misc_badge = may_uncommon_badge,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.planets or self.config.planets } }
	end,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(card.ability.planets*number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'prestige',
	set = 'Spectral',
	loc_txt = {
		name = "Prestige",
		text = {
			"{C:mult}Reset{} all {C:attention}Poker Hands{}",
			"{C:mult}Destroy{} all owned {C:attention}Jokers and Consumables{}",
			"Go to {C:attention}Ante 1{}",
			"Set money to {C:money}$4{}",
			"{C:mult}Reset{} all {C:chips}Hands{} and {C:mult}Discards{}",
			"Create a {C:attention}random {X:may_surreal,C:white}Surreal{} Joker"
		}
	},
	pos = { x = 5, y = 2 },
	soul_pos = { x = 0, y = 3, extra = { x = 1, y = 3 }},
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	cost = 17,
	hidden = true,
	soul_rate = 0.02,
	soul_set = 'Spectral',
	misc_badge = may_epic_badge,
	unlocked = true,
	can_use = function(self, card)
		if G.GAME.may_surreal_sleeve_alt then
			return jl.canuse() and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		else
			return jl.canuse()
		end
	end,
	discovered = true,
	use = function(self, card, area, copier)
		if not G.GAME.may_surreal_sleeve_alt then
			G.GAME.round_resets.hands = G.GAME.starting_params.hands
			G.GAME.round_resets.discards = G.GAME.starting_params.discards
			ease_discard(-(G.GAME.round_resets.discards - G.GAME.starting_params.discards))
			ease_hands_played(-(G.GAME.round_resets.hands - G.GAME.starting_params.hands))
			G.GAME.dollars = to_big(4)
			G.GAME.round_resets.ante = 1
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].level = to_big(1)
				G.GAME.hands[k].mult = math.max(G.GAME.hands[k].s_mult, 1)
				G.GAME.hands[k].chips = math.max(G.GAME.hands[k].s_chips, 1)
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({trigger = "before",delay = 0.75,func = function()
				for k, v in pairs(G.jokers.cards) do
					if not v.ability.eternal then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				for k, v in pairs(G.consumeables.cards) do
					if not v.ability.eternal then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = "after",delay = 0.4,func = function()
			local card2 = create_card('Joker', G.jokers, nil, 'may_surreal', nil, nil, nil, 'may_prestige')
			G.jokers:emplace(card2)
			play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
			play_sound('may_surreal_joker', 1, 0.75)
			card2:add_to_deck()
			card2:juice_up(1,1)
		return true end}))
	end
}

SMODS.Consumable {
	key = 'genesis',
	set = 'Spectral',
	name = 'Genesis',
	loc_txt = {
		name = "Genesis",
		text = {
			"Creates an {C:attention}Universal Collapse{} Joker",
			"{C:attention}+#1#{} Ante",
			"{C:inactive}(requires room){}"
		}
	},
	config = { ante = 2 },
	pos = { x = 0, y = 2 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_spectral',
	misc_badge = may_uncommon_badge,
	cost = 17,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.2,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_may_universal_collapse
		return { vars = { card.ability.ante or self.config.ante } }
	end,
	use = function(self, card, area, copier)
		local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
		G.jokers:emplace(card2)
		play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		card2:add_to_deck()
		if not G.GAME.may_unstable_sleeve_alt then
			ease_ante(card.ability.ante)
		end
	end
}

if may.mode == 2 then

SMODS.Consumable {
	key = 'macrocosm',
	set = 'Spectral',
	name = 'Macrocosm',
	loc_txt = {
		name = "Macrocosm",
		text = {
			"Creates a {C:attention}random{} {X:dark_edition,C:white}Transcendent{} Joker",
			"{C:mult}#1# hands{} played",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 2 },
	display_size = { w = 65, h = 95 },
	config = { hands = -2 },
	atlas = 'may_special_spectral',
	misc_badge = may_rare_badge,
	cost = 10,
	unlocked = true,
	hidden = true,
	soul_rate = 0.02,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.round_resets.hands > 2 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.hands or self.config.hands } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		if not G.GAME.may_interdimensional_sleeve_alt then
			local card2 = create_card('Joker', G.jokers, nil, 'may_transcendent', nil, nil, nil, 'may_macrocosm')
			G.jokers:emplace(card2)
			play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
			play_sound('may_transcendent_joker', 1, 0.75)
			card2:add_to_deck()
			card2:juice_up(1,1)
			G.GAME.round_resets.hands =  G.GAME.round_resets.hands - 2
			ease_hands_played(card.ability.hands)
			delay(0.6)
		else
			local card2 = create_card('Joker', G.jokers, nil, 'may_interdimensional', nil, nil, nil, 'may_macrocosm')
			G.jokers:emplace(card2)
			play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
			play_sound('may_interdimensional_joker', 1, 0.75)
			card2:add_to_deck()
			card2:juice_up(1,1)
			G.GAME.round_resets.hands =  G.GAME.round_resets.hands - 2
			ease_hands_played(card.ability.hands)
			delay(0.6)
		end
	end
}

end

-- Planets

SMODS.Consumable {
	set = 'Planet',
	key = 'proxima_centauri',
	config = { hand_type = 'may_Royal Flush' },
	pos = {x = 4, y = 0 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Red Dwarf', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	process_loc_text = function(self)
		local target_text = G.localization.descriptions[self.set]['c_mercury'].text
		SMODS.Consumable.process_loc_text(self)
		G.localization.descriptions[self.set][self.key].text = target_text
	end,
	generate_ui = 0,
	loc_txt = {
		['en-us'] = {
			name = 'Proxima Centauri'
		}
	}
}

	-- Misc Planets
	
SMODS.Consumable {
	set = 'Planet',
	key = 'chronos',
	pos = {x = 0, y = 0 },
	atlas = 'planet',
	loc_txt = {
		name = 'Chronos',
		text = {
			"{C:attention}Trigger{} all held {C:planet}Planet Cards{}",
			"as if they were used",
			"{C:inactive}(Chronos excluded){}"
		}
	},
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' and v:gc().key ~= 'c_may_chronos' then
				return jl.canuse()
			end
		end
		return false
	end,
	use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and Incantation then
				v.bulkuse = v:CanBulkUse() and math.max(1, v:getQty()) > 1
			end
			if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and v:gc().key ~= 'c_may_chronos'then
				if #SMODS.find_mod('Cryptid') ~= 0 then
					card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Force-triggered!', colour = SMODS.Gradients.may_col_interdimensional, delay = 0.45})
				end
				G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.2, func = function()
					card:juice_up(0.3, 0.5)
					if #SMODS.find_mod('Cryptid') ~= 0  then
						play_sound('cry_forcetrigger')
					end
				return true end}))
			end
			if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and v:gc().key ~= card:gc().key then
				v:use_consumeable(G.consumeables)
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, number, 1 do
			for k, v in pairs(G.consumeables.cards) do
				if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and Incantation then
					v.bulkuse = v:CanBulkUse() and math.max(1, v:getQty()) > 1
				end
				if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and v:gc().key ~= 'c_may_chronos'then
					if #SMODS.find_mod('Cryptid') ~= 0 then
						card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Force-triggered!', colour = SMODS.Gradients.may_col_interdimensional, delay = 0.45})
					end
					G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.2, func = function()
						card:juice_up(0.3, 0.5)
						if #SMODS.find_mod('Cryptid') ~= 0  then
							play_sound('cry_forcetrigger')
						end
					return true end}))
				end
				if (v:gc().set == 'Planet' or v:gc().set == 'upside_down_planets') and v:gc().key ~= card:gc().key then
					v:use_consumeable(G.consumeables)
				end
			end
		end
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'parthenope',
	pos = {x = 3, y = 0 },
	config = { extra = { amount = 0.2 } },
	atlas = 'planet',
	loc_txt = {
		name = 'Parthenope',
		text = {
			"{C:planet}Level up{} all {C:purple}Poker Hands{} by {C:attention}#1#{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount } }
	end,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		may.level_up_all_hands(card, false, card.ability.extra.amount)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.level_up_all_hands(card, false, card.ability.extra.amount*number)
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'tartarus',
	config = { extra = { mphand = 2, other = -1 } },
	pos = {x = 1, y = 1 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Tartarus',
		text = {
			"{C:planet}Levels up{} {C:attention}most played{} {C:purple}Poker Hand{} {C:attention}#1#{} times",
			"{C:mult}Decreases level{} of another {C:attention}2 random{} {C:purple}Poker Hands{} by {C:attention}#2#{}",
			"{C:inactive}Will level up #3#{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mphand, math.abs(card.ability.extra.other), jl.favhand() } }
	end,
	use = function(self, card)
		local hand = jl.favhand()
		jl.th(hand)
		level_up_hand(card, hand, nil, card.ability.extra.mphand)
		delay(0.5)
		for i=1, 2, 1 do
			local hand2 = jl.rndhand(hand)
			jl.th(hand2)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, card.ability.extra.other)
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot2')
				return true end}))
			end
			delay(1.3)
			jl.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = jl.favhand()
		jl.th(hand)
		level_up_hand(card, hand, nil, card.ability.extra.mphand*number)
		delay(0.5)
		for i=1, number*2, 1 do
			local hand2 = jl.rndhand(hand)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, card.ability.extra.other)
			end
		end
		jl.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		jl.hm('-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		jl.hc('-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		jl.h(nil, nil, nil, card.ability.extra.other)
		delay(1.3)
		jl.ch()
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'mangas',
	pos = {x = 1, y = 0 },
	atlas = 'planet',
	loc_txt = {
		name = 'Mangas',
		text = {
			"{C:attention}Gain double the level{} of a",
			"{C:attention}random{} {C:purple}Poker Hand{} as {C:money}dollars{}",
			"then {C:mult}set it's level to 1{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		local hand = jl.rndhand()
		jl.th(hand)
		ease_dollars(to_big(G.GAME.hands[hand].level or 1)*2)
		if to_big(G.GAME.hands[hand].level or 1) > to_big(1) then
			may.set_hand_level(card, hand, nil, 1)
		else
			play_sound('tarot2')
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			jl.ch()
			G.TAROT_INTERRUPT_PULSE = false
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		local total = 0
		for i=1, number, 1 do
			local hand = jl.rndhand(hand)
			total = total + G.GAME.hands[hand].level
			may.set_hand_level(card, hand, true, 1)
		end
		jl.h('Random Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eq_level')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		jl.hlv(1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot2')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		ease_dollars(total)
		jl.ch()
	end
}

--[[SMODS.Consumable {
	set = 'Planet',
	key = 'codename_wonder',
	loc_txt = {
		name = 'CODENAME-Wonder',
		text = {
			'{C:planet}Levels up{} all {C:attention}undiscovered{} {C:planet}Poker Hands{} {C:attention}#1# times{}',
		}
	},
	pos = {x = 0, y = 2 },
	atlas = 'placeholder',
	config = { extra = { amount = 2 } },
	cost = 4,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount } }
	end,
	use = function(self, card, area, copier)
		local triggers = 0
		for k, v in pairs(G.GAME.hands) do
			if not G.GAME.hands[k].visible then
				G.GAME.hands[k].visible = true
				level_up_hand(card, G.GAME.hands[k], true, card.ability.extra.amount)
				triggers = triggers + 1
				G.GAME.hands[k].visible = false
			end
		end
		if triggers ~= 0 then
			jl.h('Undiscovered Hands', '...', '...', '')
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
			return true end}))
			jl.hm('+', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
			return true end}))
			jl.hc('+', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				card:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
			return true end}))
			jl.h(nil, nil, nil, '+'..card.ability.extra.amount:toString())
			delay(1.3)
			jl.ch()
		else
			jl.a('No undiscovered Poker hands!', 2, nil, get_type_colour(self or card.config, card), 'may_error')
			card:juice_up(0.8, 0.5)
		end
	end
 }]]
 
function get_wee_hand()
	local hand = 'High Card'
	local lowest_score = 0
	for _, v in ipairs(G.handlist) do
		if lowest_score == 0 or G.GAME.hands[v].chips:mul(G.GAME.hands[v].mult) <= lowest_score then
			hand = v
			lowest_score = G.GAME.hands[v].chips:mul(G.GAME.hands[v].mult)
		end
	end
	return hand
end

SMODS.Consumable {
	set = 'Planet',
	key = 'planet_wee',
	config = { extra = { amount = 2 } },
	pos = { x = 0, y = 1 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Planet Wee',
		text = {
			"{C:planet}Levels up{} {C:attention}lowest scoring{}",
			"{C:purple}Poker Hand{} {C:attention}#1#{} times",
			"{C:inactive}will level up #2#{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, get_wee_hand() } }
	end,
	use = function(self, card)
		jl.th(get_wee_hand())
		level_up_hand(card, get_wee_hand(), nil, card.ability.extra.amount)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		jl.th(get_wee_hand())
		level_up_hand(card, get_wee_hand(), nil, card.ability.extra.amount*number)
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'orcus',
	pos = { x = 2, y = 0 },
	atlas = 'planet',
	loc_txt = {
		name = 'Orcus',
		text = {
			"{C:attention}Set{} the {C:purple}Mult & Chips{} of",
			"a {C:attention}random{} {C:purple}Poker Hand{}",
			"to the {C:purple}Mult & Chips{} of",
			"{C:attention}second-most played{} {C:purple}Poker Hand{}",
			"{C:inactive}#1#, {C:mult}#2#{} {C:inactive}Mult and {C:chips}#3#{} {C:inactive}Chips{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.sfavhand(), G.GAME.hands[jl.sfavhand()].mult, G.GAME.hands[jl.sfavhand()].chips } }
	end,
	use = function(self, card)
		local hand = jl.rndhand(jl.sfavhand())
		jl.th(hand)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eqchip')
			card:juice_up(0.8, 0.5)
			G.GAME.hands[hand].chips = G.GAME.hands[jl.sfavhand()].chips
		return true end}))
		jl.hc('='..number_format(G.GAME.hands[jl.sfavhand()].chips), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eqmult')
			card:juice_up(0.8, 0.5)
			G.GAME.hands[hand].mult = G.GAME.hands[jl.sfavhand()].mult
		return true end}))
		jl.hm('='..number_format(G.GAME.hands[jl.sfavhand()].mult), true)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, number, 1 do
			local hand = jl.rndhand(jl.sfavhand())
			jl.th(hand)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_eqchip')
				card:juice_up(0.8, 0.5)
				G.GAME.hands[hand].chips = G.GAME.hands[jl.sfavhand()].chips
			return true end}))
			jl.hc('='..number_format(G.GAME.hands[jl.sfavhand()].chips), true)
			delay(0.5)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_eqmult')
				card:juice_up(0.8, 0.5)
				G.GAME.hands[hand].mult = G.GAME.hands[jl.sfavhand()].mult
			return true end}))
			jl.hm('='..number_format(G.GAME.hands[jl.sfavhand()].mult), true)
			delay(0.5)
			jl.ch()
		end	
	end
}

	-- Jovian Moons

SMODS.Consumable {
	set = 'Planet',
	key = 'amalthea',
	config = { extra = { hand = 'Pair', lev_mult = 1, lev_chips = 7, } },
	pos = {x = 1, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Amalthea',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'metis',
	config = { extra = { hand = 'Three of a Kind', lev_mult = 1, lev_chips = 10, } },
	pos = {x = 4, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Metis',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'iocaste',
	config = { extra = { hand = 'Full House', lev_mult = 1, lev_chips = 12, } },
	pos = {x = 2, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Iocaste',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'ganymede',
	config = { extra = { hand = 'Four of a Kind', lev_mult = 1, lev_chips = 15, } },
	pos = {x = 4, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Ganymede',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'europa',
	config = { extra = { hand = 'Flush', lev_mult = 1, lev_chips = 7, } },
	pos = {x = 3, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Europa',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'io',
	config = { extra = { hand = 'Straight', lev_mult = 1, lev_chips = 15, } },
	pos = {x = 1, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Io',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'adrastea',
	config = { extra = { hand = 'Two Pair', lev_mult = 1, lev_chips = 10, } },
	pos = {x = 0, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Adrastea',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'themisto',
	config = { extra = { hand = 'Straight Flush', lev_mult = 2, lev_chips = 20, } },
	pos = {x = 2, y = 2 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Themisto',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'thebe',
	config = { extra = { hand = 'High Card', lev_mult = 1, lev_chips = 2, } },
	pos = {x = 0, y = 2 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Thebe',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'leda',
	config = { extra = { hand = 'Five of a Kind', lev_mult = 1, lev_chips = 17, } },
	pos = {x = 3, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Leda',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played ~= 0, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'himalia',
	config = { extra = { hand = 'Flush House', lev_mult = 2, lev_chips = 20, } },
	pos = {x = 0, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Himalia',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played ~= 0, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'ersa',
	config = { extra = { hand = 'Flush Five', lev_mult = 1, lev_chips = 25, } },
	pos = {x = 2, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Ersa',
		text = {
			"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played ~= 0, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'thelxinoe',
	config = { extra = { hand = 'may_Royal Flush', lev_mult = 5, lev_chips = 30, } },
	pos = {x = 1, y = 2 },
	display_size = { w = 65, h = 95 },
	atlas = 'jovianmoon',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	loc_txt = {
		name = 'Thelxinoe',
		text = {
			"Give {C:attention}Royal Flush{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand, card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
		hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
	end,
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played ~= 0, {allow_duplicates = false}
	end
}

-- Rare Planets

SMODS.Consumable {
	set = 'Planet',
	key = 'vespia',
	config = { extra = { amount = 10 } },
	pos = {x = 3, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	loc_txt = {
		name = 'Vespia',
		text = {
			"{C:planet}Levels up{} {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:attention}10{} times",
			"{C:inactive}Will level up #2#{}"
		}
	},
	hidden = true,
	soul_rate = 0.04,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, jl.favhand() } }
	end,
	use = function(self, card)
		jl.th(jl.favhand())
		level_up_hand(card, jl.favhand(), nil, card.ability.extra.amount)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		jl.th(jl.favhand())
		level_up_hand(card, jl.favhand(), nil, card.ability.extra.amount*number)
		jl.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'triton',
	config = { extra = { amount = 3 } },
	pos = {x = 1, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Neptunian Moon', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	loc_txt = {
		name = 'Triton',
		text = {
			"{X:purple,C:white}X#1#{} {C:may_ethereal}Level{} Mult & Chips of {C:attention}most played{}",
			"{C:purple}Poker Hand{}",
			"{C:inactive}Will upgrade up #2#{}"
		}
	},
	hidden = true,
	soul_rate = 0.04,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, jl.favhand() } }
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(jl.favhand(), 'multchips', 0, card.ability.extra.amount)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(jl.favhand(), 'multchips', 0, card.ability.extra.amount*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'yryx',
	config = { extra = { hands = 5, amount = 20 } },
	pos = {x = 4, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	loc_txt = {
		name = 'Yryx',
		text = {
			"{C:planet}Levels up{} {C:attention}#2# random{} {C:purple}Poker Hands{}",
			"{C:attention}#1#{} times",
		}
	},
	hidden = true,
	soul_rate = 0.04,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, card.ability.extra.hands } }
	end,
	use = function(self, card)
		for i=1, card.ability.extra.hands, 1 do
			local hand = jl.rndhand()
			jl.th(hand)
			level_up_hand(card, hand, nil, card.ability.extra.amount)
		end
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, card.ability.extra.hands*number, 1 do
			local hand = jl.rndhand()
			jl.th(hand)
			level_up_hand(card, hand, nil, card.ability.extra.amount)
		end
		jl.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'stos',
	pos = {x = 0, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	loc_txt = {
		name = 'Stos',
		text = {
			"{C:attention}Adds{} the {C:purple}Mult & Chips{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"to {C:attention}every other{} {C:purple}Poker Hand{}",
			"{C:inactive}#1#, {C:mult}#2#{} {C:inactive}Mult and {C:chips}#3#{} {C:inactive}Chips{}"
		}
	},
	hidden = true,
	soul_rate = 0.04,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand(), G.GAME.hands[jl.favhand()].mult, G.GAME.hands[jl.favhand()].chips } }
	end,
	use = function(self, card)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[jl.favhand()] then
				G.GAME.hands[k].chips = G.GAME.hands[k].chips + to_big(G.GAME.hands[jl.favhand()].chips)
				G.GAME.hands[k].mult = G.GAME.hands[k].mult + to_big(G.GAME.hands[jl.favhand()].mult)
			end
        end
		jl.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+'..number_format(to_big(G.GAME.hands[jl.favhand()].chips)), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+'..number_format(to_big(G.GAME.hands[jl.favhand()].mult)), true)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[jl.favhand()] then
				G.GAME.hands[k].chips = G.GAME.hands[k].chips + to_big(G.GAME.hands[jl.favhand()].chips):mul(number)
				G.GAME.hands[k].mult = G.GAME.hands[k].mult + to_big(G.GAME.hands[jl.favhand()].mult):mul(number)
			end
        end
		jl.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+'..number_format(to_big(G.GAME.hands[jl.favhand()].chips):mul(number)), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+'..number_format(to_big(G.GAME.hands[jl.favhand()].mult):mul(number)), true)
		delay(0.5)
		jl.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'vanathos',
	pos = {x = 2, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	loc_txt = {
		name = 'Vanathos',
		text = {
			"{C:attention}Adds{} the {C:purple}Mult & Chips{} of {C:attention}2 random{} {C:purple}Poker Hands{}",
			"to {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will upgrade #1#{}"
		}
	},
	hidden = true,
	soul_rate = 0.04,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand() } }
	end,
	use = function(self, card)
		local mult = 0
		local chips = 0 
		for i=1, 2, 1 do
			local hand = jl.rndhand(jl.favhand())
			jl.th(hand)
			mult = mult + G.GAME.hands[hand].mult
			chips = chips + G.GAME.hands[hand].chips
			delay(0.3)
		end
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult + mult
		G.GAME.hands[jl.favhand()].chips = G.GAME.hands[jl.favhand()].chips + chips
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+'..number_format(chips), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+'..number_format(mult), true)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local mult = 0
		local chips = 0 
		for i=1, 2*number, 1 do
			local hand = jl.rndhand(jl.favhand())
			jl.th(hand)
			mult = mult + G.GAME.hands[hand].mult
			chips = chips + G.GAME.hands[hand].chips
			delay(0.3)
		end
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult + mult
		G.GAME.hands[jl.favhand()].chips = G.GAME.hands[jl.favhand()].chips + chips
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+'..number_format(chips), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+'..number_format(mult), true)
		delay(0.5)
		jl.ch()
	end,
}

-- Legendary planets
function may.get_all_ph_mult(ignore)
	if G and G.GAME and G.GAME.blind then
		local mult = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= ignore and G.GAME.hands[k].visible then
				mult = mult + G.GAME.hands[k].mult
			end
		end
		return to_big(mult)
	else
		return to_big(0)
	end
end

function may.get_all_ph_chips(ignore)
	if G and G.GAME and G.GAME.blind then
		local chips = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= ignore and G.GAME.hands[k].visible then
				chips = chips + G.GAME.hands[k].chips
			end
		end
		return to_big(chips)
	else
		return to_big(0)
	end
end

function may.get_all_ph_level(ignore)
	if G and G.GAME and G.GAME.blind then
		local level = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= ignore and G.GAME.hands[k].visible then
				level = level + G.GAME.hands[k].level
			end
		end
		return to_big(level)
	else
		return to_big(0)
	end
end

SMODS.Consumable {
	set = 'Planet',
	key = 'kivaaritehdas',
	pos = {x = 2, y = 0 },
	soul_pos = {x = 3, y = 0 },
	atlas = 'legendaryplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'Kivaaritehdas',
		text = {
			"{C:attention}Adds quadruple{} the {C:purple}Mult & Chips{} of {C:attention}every{} {C:purple}Poker Hand{}",
			"to your {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}will give #1# {C:mult}#2#{} {C:inactive}Mult and {C:chips}#3#{} {C:inactive}Chips{}",
		}
	},
	hidden = true,
	soul_rate = 0.007,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand(), number_format(may.get_all_ph_mult(G.GAME.hands[jl.favhand()]):mul(4)), number_format(may.get_all_ph_chips(G.GAME.hands[jl.favhand()]):mul(4)) } }
	end,
	use = function(self, card)
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult + may.get_all_ph_mult(G.GAME.hands[jl.favhand()]):mul(4)
		G.GAME.hands[jl.favhand()].chips = G.GAME.hands[jl.favhand()].chips + may.get_all_ph_chips(G.GAME.hands[jl.favhand()]):mul(4)
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end }))				
		jl.hc('+'..number_format(may.get_all_ph_mult(jl.favhand()):mul(4)), true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))				
		jl.hm('+'..number_format(may.get_all_ph_mult(jl.favhand()):mul(4)), true)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult + (may.get_all_ph_mult(G.GAME.hands[jl.favhand()]):mul(4):mul(number))
		G.GAME.hands[jl.favhand()].chips = G.GAME.hands[jl.favhand()].chips + (may.get_all_ph_chips(G.GAME.hands[jl.favhand()]):mul(4):mul(number))
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end }))				
		jl.hc('+'..number_format(may.get_all_ph_mult(jl.favhand()):mul(4):mul(number)), true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))				
		jl.hm('+'..number_format(may.get_all_ph_mult(jl.favhand()):mul(4):mul(number)), true)
		jl.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'quac_n7',
	pos = {x = 2, y = 1 },
	soul_pos = {x = 3, y = 1 },
	atlas = 'legendaryplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'QUAC-N7',
		text = {
			"Set the {C:planet}level{} of {C:attention}every other{} {C:purple}Poker Hand{}",
			"to {C:attention}triple{} the {C:planet}level{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}#1#, will set level of Poker Hands to #2#{}",
		}
	},
	hidden = true,
	soul_rate = 0.007,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand(), number_format(G.GAME.hands[jl.favhand()].level:mul(3)) } }
	end,
	use = function(self, card)
		may.set_all_hand_levels(card, false, number_format(G.GAME.hands[jl.favhand()].level:mul(3)), jl.favhand())
	end,
	bulk_use = function(self, card, area, copier, number)
		may.set_all_hand_levels(card, false, number_format(G.GAME.hands[jl.favhand()].level:mul(3)), jl.favhand())
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'opolisis',
	pos = {x = 0, y = 1 },
	soul_pos = {x = 1, y = 1 },
	atlas = 'legendaryplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'Opolisis',
		text = {
			"Set the {C:planet}level{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"to {C:attention}quintuple{} the combined {C:planet}level{} of {C:attention}all other{} {C:purple}Poker Hands{}",
			"{C:inactive}Will set level of #1# to #2#{}",
		}
	},
	hidden = true,
	soul_rate = 0.007,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand(), number_format(may.get_all_ph_level():mul(5)) } }
	end,
	use = function(self, card)
		may.set_hand_level(card, jl.favhand(), false, number_format(may.get_all_ph_level():mul(5)))
	end,
	bulk_use = function(self, card, area, copier, number)
		may.set_hand_level(card, jl.favhand(), false, number_format(may.get_all_ph_level():mul(5)))
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'en_7b',
	pos = {x = 0, y = 0 },
	soul_pos = {x = 1, y = 0 },
	atlas = 'legendaryplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'EN-7B',
		text = {
			"{C:attention}Balance{} the {C:planet}level{}, {C:may_ethereal}Level{} {C:mult}Mult{}, {C:may_ethereal}Level{} {C:chips}Chips{},",
			"{C:mult}Mult{} and {C:chips}Chips{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will set values of #1# to #2#{}"
		}
	},
	hidden = true,
	soul_rate = 0.007,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand(), (G.GAME.hands[jl.favhand()].level + G.GAME.hands[jl.favhand()].l_mult + G.GAME.hands[jl.favhand()].l_chips + G.GAME.hands[jl.favhand()].mult + G.GAME.hands[jl.favhand()].chips) / 5 } }
	end,
	use = function(self, card)
		local balanced = (G.GAME.hands[jl.favhand()].level + G.GAME.hands[jl.favhand()].l_mult + G.GAME.hands[jl.favhand()].l_chips + G.GAME.hands[jl.favhand()].mult + G.GAME.hands[jl.favhand()].chips) / 5
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eq_level')
		return true end}))
		jl.hlv(balanced)
		G.GAME.hands[jl.favhand()].level = balanced
		hand_mod_lvl_multchips(jl.favhand(), 'mult', -1, balanced - G.GAME.hands[jl.favhand()].l_mult)
		hand_mod_lvl_multchips(jl.favhand(), 'chips', -1, balanced - G.GAME.hands[jl.favhand()].l_chips)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		jl.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		G.GAME.hands[jl.favhand()].chips = balanced
		jl.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqmult')
		return true end}))
		G.GAME.hands[jl.favhand()].mult = balanced
		jl.hm('='..balanced, true)
		delay(1.3)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local balanced = (G.GAME.hands[jl.favhand()].level + G.GAME.hands[jl.favhand()].l_mult + G.GAME.hands[jl.favhand()].l_chips + G.GAME.hands[jl.favhand()].mult + G.GAME.hands[jl.favhand()].chips) / 5
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eq_level')
		return true end}))
		jl.hlv(balanced)
		G.GAME.hands[jl.favhand()].level = balanced
		hand_mod_lvl_multchips(jl.favhand(), 'mult', -1, balanced - G.GAME.hands[jl.favhand()].l_mult)
		hand_mod_lvl_multchips(jl.favhand(), 'chips', -1, balanced - G.GAME.hands[jl.favhand()].l_chips)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		jl.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		G.GAME.hands[jl.favhand()].chips = balanced
		jl.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqmult')
		return true end}))
		G.GAME.hands[jl.favhand()].mult = balanced
		jl.hm('='..balanced, true)
		delay(1.3)
		jl.ch()
	end,
}

-- Mythic Planets

SMODS.Consumable {
	set = 'Planet',
	key = 'amadeus',
	pos = {x = 0, y = 0 },
	soul_pos = {x = 1, y = 0 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	loc_txt = {
		name = 'Amadeus',
		text = {
			"{C:attention}Quintuple{} the {C:planet}level{} of {C:attention}every{} {C:purple}Poker Hand{}"
		}
	},
	hidden = true,
	soul_rate = 0.001,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		may.level_up_all_hands_hyper(card, false, 5, 0)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.level_up_all_hands_hyper(card, false, 5*number, 0)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'theia',
	pos = {x = 2, y = 1 },
	soul_pos = {x = 3, y = 1 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	loc_txt = {
		name = 'Theia',
		text = {
			"{X:purple,C:white}^5{} {C:may_ethereal}Level{} Mult & Chips of",
			"{C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will upgrade #1#{}"
		}
	},
	hidden = true,
	soul_rate = 0.001,
	soul_set = "Planet",
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand() } }
	end,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		hand_mod_lvl_multchips(jl.favhand(), 'multchips', 1, 5)
	end,
	bulk_use = function(self, card, area, copier, number)
		hand_mod_lvl_multchips(jl.favhand(), 'multchips', 1, 5*number)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'gaea',
	pos = {x = 2, y = 0 },
	soul_pos = {x = 3, y = 0 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	loc_txt = {
		name = 'Gaea',
		text = {
			"{X:purple,C:white}^10{} Mult & Chips to {C:attention}every{} {C:purple}Poker Hand{}"
		}
	},
	hidden = true,
	soul_rate = 0.001,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(1, 10)
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(1, 10)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_echip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4
		return true end }))
		jl.hc('^10', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1
		return true end }))
		jl.hm('^10', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(1, 10*number)
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(1, 10*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_echip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4
		return true end }))
		jl.hc('^'..10*number, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1
		return true end }))
		jl.hm('^'..10*number, true)
		jl.ch()
		delay(0.5)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'matakka',
	pos = {x = 0, y = 1 },
	soul_pos = {x = 1, y = 1 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	loc_txt = {
		name = 'Matakka',
		text = {
			"Creates {C:attention}5 random{} {C:dark_edition}Negative{} {X:mult,C:white}Rare{}",
			"{C:planet}Planet Cards{} and {C:attention}2{} {X:legendary,C:white}Legendary{} {C:planet}Planet Cards{}",
			"{C:inactive}(requires room){}"
		}
	},
	hidden = true,
	soul_rate = 0.001,
	soul_set = "Planet",
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i=1, 5, 1 do
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_matakka')), 'may_matakka')
				card2:add_to_deck()
				card2:set_edition({negative = true})
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			end
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i=1, 2, 1 do
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_matakka')), 'may_matakka')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			end
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i=1, 5*number, 1 do
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_matakka')), 'may_matakka')
				card2:add_to_deck()
				card2:set_edition({negative = true})
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			end
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for i=1, 2*number, 1 do
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_matakka')), 'may_matakka')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			end
		return true end}))
	end,
}

	-- Edition Cards
	
SMODS.Consumable {
	key = 'foil_card',
	config = { extra = { chips = 50 } },
	loc_txt = {
		name = 'Foil Card',
		text = {
			'Gives all hands {C:chips}+#1#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips + card.ability.extra.chips
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2)..'')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm('+'..card.ability.extra.chips..'', nil, true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips + (card.ability.extra.chips*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2)..'')
			card:juice_up(1, 1)
		return true end}))				
		jl.hcm('+'..card.ability.extra.chips*number..'', nil, true)
		jl.ch()
		delay(0.5)
	end
}
	
SMODS.Consumable {
	key = 'holographic_card',
	config = { extra = { mult = 10 } },
	loc_txt = {
		name = 'Holographic Card',
		text = {
			'Gives all hands {C:mult}+#1#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 2, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + card.ability.extra.mult
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, '+'..card.ability.extra.mult..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + (card.ability.extra.mult*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, '+'..card.ability.extra.mult*number..'', true)
		jl.ch()
		delay(0.5)
	end
}
	
SMODS.Consumable {
	key = 'polychrome_card',
	config = { extra = { xmult = 1.5 } },
	loc_txt = {
		name = 'Polychrome Card',
		text = {
			'Gives all hands {X:mult,C:white}X#1#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * card.ability.extra.xmult
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, 'X'..card.ability.extra.xmult..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * (card.ability.extra.xmult*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, 'X'..card.ability.extra.xmult*number..'', true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'shimmering_card',
	config = { extra = { mult = 15, chips = 10 } },
	loc_txt = {
		name = 'Shimmering Card',
		text = {
			'Gives all hands {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 3, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + card.ability.extra.mult
			G.GAME.hands[k].chips = G.GAME.hands[k].chips + card.ability.extra.chips
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end}))
		jl.hc('+'..card.ability.extra.chips..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hm('+'..card.ability.extra.mult..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + (card.ability.extra.mult * number)
			G.GAME.hands[k].chips = G.GAME.hands[k].mult + (card.ability.extra.chips * number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end}))
		jl.hc('+'..card.ability.extra.chips*number..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hm('+'..card.ability.extra.mult*number..'', true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'amber_card',
	config = { extra = { mult = -2, chips = 120 } },
	loc_txt = {
		name = 'Amber Card',
		text = {
			'Gives all hands {C:mult}#1#{} Mult and {C:chips}+#2#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 7, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + card.ability.extra.mult
			G.GAME.hands[k].chips = G.GAME.hands[k].chips + card.ability.extra.chips
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end}))
		jl.hc('+'..card.ability.extra.chips..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hm('+'..card.ability.extra.mult..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + (card.ability.extra.mult * number)
			G.GAME.hands[k].chips = G.GAME.hands[k].mult + (card.ability.extra.chips * number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end}))
		jl.hc('+'..card.ability.extra.chips*number..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end}))
		jl.hm('+'..card.ability.extra.mult*number..'', true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'nostalgic_card',
	loc_txt = {
		name = 'Nostalgic Card',
		text = {
			'Create a {C:attention}copy{} of the {C:attention}last{} used {C:dark_edition}Edition Card{} during this run',
			'{C:inactive}(Requires room, Nostalgic Card excluded){}'
		}
	},
	set = 'editioncards',
	pos = { x = 4, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	can_use = function(self, card)
		return jl.canuse() and G.GAME.last_edition_card and G.GAME.last_edition_card ~= 'c_may_nostalgic_card' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
	end,
	use = function(self, card, area, copier)
		if G.GAME.last_edition_card and G.GAME.last_edition_card ~= 'c_may_nostalgic_card' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local new = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_edition_card, 'nostalgic_card')
					new:add_to_deck()
					G.consumeables:emplace(new)
					new:juice_up(0.3, 0.5)
				end
				G.GAME.last_edition_card = 'c_may_nostalgic_card'
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'omega_card',
	config = { extra = { ee_chips = 1.177 } },
	loc_txt = {
		name = 'Omega Card',
		text = {
			'Gives all hands {X:chips,C:white}^^#1#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 5, y = 0 },
	cost = 200,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	misc_badge = may_rare_badge,
	hidden = true,
	soul_rate = 0.008,
	soul_set = 'editioncards',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ee_chips } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, card.ability.extra.ee_chips)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 0.7
		return true end}))
		jl.hc('^^'..card.ability.extra.ee_chips..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, card.ability.extra.ee_chips*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 0.7+(0.7*math.log10(number))
		return true end}))
		jl.hc('^^'..card.ability.extra.ee_chips*number..'', true)
		jl.ch()
		delay(0.5)
	end
}

SMODS.Consumable {
	key = 'otherworldly_card',
	config = { extra = { hyper_chips = 1.57, eee_mult = 15.7 } },
	loc_txt = {
		name = 'Otherworldly Card',
		text = {
			'Gives all hands {X:chips,C:white}^^^^#1#{} Chips and {X:mult,C:white}^^^#2#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 6, y = 0 },
	cost = 1000,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
	misc_badge = may_rare_badge,
	hidden = true,
	soul_rate = 0.0003,
	soul_set = 'editioncards',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hyper_chips, card.ability.extra.eee_mult } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(4, card.ability.extra.hyper_chips)
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, card.ability.extra.eee_mult)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound(may.get_operation_sound(4, 'chips'))
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4
		return true end }))
		jl.hc('^^^^'..card.ability.extra.hyper_chips..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1
		return true end }))
		jl.hm('^^^'..card.ability.extra.eee_mult..'', true)
		jl.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(4, card.ability.extra.hyper_chips*number)
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, card.ability.extra.eee_mult*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound(may.get_operation_sound(4, 'chips'))
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4 + (1.4*math.log10(number))
		return true end}))
		jl.hc('^^^^'..card.ability.extra.hyper_chips*number..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eeemult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1 + (math.log10(number))
		return true end}))
		jl.hm('^^^'..card.ability.extra.eee_mult*number..'', true)
		jl.ch()
		delay(0.5)
	end
}

-- Retro Cards
-- disabled because buggy and unfinished
if false then

SMODS.Consumable {
	key = 'easter_egg',
	config = { extra = { jokers = 1 } },
	loc_txt = {
		name = 'EASTER_EGG',
		text = {
			"Create {C:attention}#1# random{} {X:legendary,C:white}Legendary{} {C:attention}Joker{}",
			"for {C:attention}every{} {C:money}Yotta Card{} you have {C:attention}used{} this run",
			"{C:inactive}Will create #2# Jokers, requires room{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	can_use = function(self, card)
		return jl.canuse() and #G.jokers.cards < G.jokers.config.card_limit and card.ability.extra.jokers * jl.ctu('yottacards') ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.jokers, card.ability.extra.jokers * jl.ctu('yottacards') } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.extra.jokers * jl.ctu('yottacards'), G.jokers.config.card_limit - #G.jokers.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.jokers.config.card_limit > #G.jokers.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Joker', G.jokers, nil, nil, true, nil, nil, 'may_easter_egg')
					card2:add_to_deck()
					G.jokers:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for j = 1, number, 1 do
			for i = 1, math.min(card.ability.extra.jokers * jl.ctu('yottacards'), G.jokers.config.card_limit - #G.jokers.cards) do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if G.jokers.config.card_limit > #G.jokers.cards then
						play_sound('timpani', 0.5)
						local card2 = create_card('Joker', G.jokers, nil, nil, true, nil, nil, 'may_easter_egg')
						card2:add_to_deck()
						G.jokers:emplace(card2)
						card:juice_up(0.3, 0.5)
					end
				return true end}))
			end
		end
	end
}

SMODS.Consumable {
	key = '1_up',
	config = { extra = { dollars = 2 } },
	loc_txt = {
		name = '1-UP',
		text = {
			"{C:money}+$#1#{} for {C:attention}every{} {C:spectral}Spectral Card{}",
			"you have {C:attention}used{} this run",
			"{C:inactive}Will give $#2#{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * jl.ctu('Spectral') } }
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars * jl.ctu('Spectral'))
	end,
	bulk_use = function(self, card, area, copier, number)
		ease_dollars(number * card.ability.extra.dollars * jl.ctu('Spectral'))
	end
}

SMODS.Consumable {
	key = 'lootbox',
	config = { extra = { voucher_count = 5, voucher_gain = 1, dollars = 5 } },
	loc_txt = {
		name = 'LOOTBOX',
		text = {
			"For {C:attention}every #1#{} {C:green}Vouchers{} redeemed,",
			"{C:attention}redeem #2# random{} {C:green}Vouchers{} and {C:mult}lose{}",
			"{C:money}$#3#{} {C:attention}per redeemed{} {C:green}Voucher{}",
			"{C:inactive}Will redeem #4# Vouchers at the cost of $#5#{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	can_use = function(self, card)
		return jl.canuse() and #(G.vouchers.cards or {}) ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		if G.vouchers then
			return { vars = { card.ability.extra.voucher_count, card.ability.extra.voucher_gain, card.ability.extra.dollars, 
			math.floor(#(G.vouchers.cards or {}) / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain, 
			(math.floor(#(G.vouchers.cards or {}) / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain) * card.ability.extra.dollars} }
		else
			return { vars = { card.ability.extra.voucher_count, card.ability.extra.voucher_gain, card.ability.extra.dollars, 0, 0} }
		end
	end,
	use = function(self, card, area, copier)
		may.massvoucher(nil, to_number(math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain))
		ease_dollars(-((math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain) * card.ability.extra.dollars))
	end,
	bulk_use = function(self, card, area, copier, number)
		may.massvoucher(nil, to_number(math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain) * number)
		ease_dollars((-((math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain) * card.ability.extra.dollars)) * number)
	end
}

SMODS.Consumable {
	key = 'upgrade',
	config = { extra = { editioncards = 1, planetcards = 5, } },
	loc_txt = {
		name = 'UPGRADE',
		text = {
			"Create {C:attention}#1# random{} {C:dark_edition}Edition Card{}",
			"for {C:attention}every #2#{} {C:planet}Planet Cards{} you have {C:attention}used{} this run",
			"{C:inactive}Will create #2# Edition Cards, requires room{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	can_use = function(self, card)
		return jl.canuse() and #(G.vouchers.cards or {}) ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.editioncards, card.ability.extra.planetcards, math.floor(jl.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(math.floor(jl.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('editioncards', G.consumeables, nil, nil, nil, nil, nil, 'may_upgrade')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(math.floor(jl.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards * number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('editioncards', G.consumeables, nil, nil, nil, nil, nil, 'may_upgrade')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end
}

end

end
-- Blinds
if may.conf.content.Blinds then

SMODS.Blind {
	key = 'inheritance',
	config = { canchange = true },
	loc_txt = {
		name = 'The Inheritance',
		text = { 
			"Starting Chips is",
			"set to half of",
			"starting Mult"
		}
    },
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if self.config.canchange then
			local new_chips = math.max(math.floor(mult/2 + 0.5))
			return mult, new_chips, true
		else
			return mult, hand_chips, false
		end
	end,
	disable = function(self)
		self.config.canchange = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('94FDFF'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 1},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 3
	end
}

SMODS.Blind {
	key = 'half',
	config = { canchange = true },
	loc_txt = {
		name = 'The Half',
		text = { 
			"Mult is ignored",
			"when calculating",
			"score"
		}
    },
	disable = function(self)
		self.config.canchange = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('7A09FA'),
	dollars = 5,
	mult = 0.3,
	atlas = "blind",
	pos = {x = 0, y = 2},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'strike',
	loc_txt = {
		name = 'The Strike',
		text = { 
			"Playing cards",
			"substract chips",
		}
    },
	disable = function(self)
		G.GAME.playing_card_multiplier = math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	defeat = function(self)
		G.GAME.playing_card_multiplier = math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	set_blind = function(self)
		G.GAME.playing_card_multiplier = -math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('D3FC7E'),
	dollars = 5,
	mult = 1.5,
	atlas = "blind",
	pos = {x = 0, y = 0},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'crowd',
	config = { canincrease = true },
	loc_txt = {
		name = 'The Crowd',
		text = { 
			"When hand is played,",
			"+35% Blind requirements",
			"per 1 hand size"
		}
    },
	disable = function(self)
		self.config.canincrease = false
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	press_play = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (G.hand.config.card_limit * 0.35))
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A90000'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 3},
}

SMODS.Blind {
	key = 'philosopher',
	config = { safe_hands = {} },
	loc_txt = {
		name = 'The Philosopher',
		text = { 
			"You can only play",
			"4 random Poker Hands"
		}
    },
	debuff_hand = function(self, cards, hand, handname, check)
		if not table_hasvalue(self.config.safe_hands, handname) and not G.GAME.blind.disabled then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	set_blind = function(self)
		for i=1, 4, 1 do
			table.insert(self.config.safe_hands, jl.rndhand())
		end
	end,
	disable = function(self)
		self.config.safe_hands = {}
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('bf00ff'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 4},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'hourglass',
	config = { can_apply = true },
	loc_txt = {
		name = 'The Hourglass',
		text = { 
			"When hand is played,",
			"apply Eternal to a random",
			"Joker",
		}
    },
	disable = function(self)
		self.config.can_apply = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('9B59D6'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 5},
	press_play = function(self)
		if self.config.can_apply and #G.jokers.cards ~= 0 then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
				local joker = pseudorandom_element(G.jokers.cards, pseudoseed('may_hourglass'))
				play_sound("tarot1")
				joker:set_eternal(true)
			return true end}))
		end
	end,
}

-- After hand is played context (taken from Cryptid)
local vanf_gfep = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
	vanf_gfep(e)
	SMODS.calculate_context({after_play = true})
	G.GAME.blind:may_after_play()
end

function Blind:may_after_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.may_after_play and type(obj.may_after_play) == "function" then
			return obj:may_after_play()
		end
	end
end

--[[SMODS.Blind {
	key = 'bug',
	config = { can_increase = true },
	loc_txt = {
		name = 'The Bug',
		text = { 
			"^^2 Blind Size",
			"if played hand reaches",
			"any Transcendence level"
		}
    },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('FF9757'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 6},
	may_after_play = function(self)
		if G.GAME.chips >= G.GAME.blind.chips * 1e100 then
			local to_ease = G.GAME.blind.chips
			SMODS.juice_up_blind()
			G.E_MANAGER:add_event(Event({trigger = 'ease', blocking = false, ref_table = G.GAME.blind, ref_value = 'chips', 
			ease_to = to_big(get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2):arrow(2, 2),
			delay = 0.5, func = (function(t) 
				play_sound('may_blind_size')
				return math.floor(t) 
			end)}))
		end
	end,
}]]

SMODS.Blind {
	key = 'calculator',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Calculator',
		text = { 
			"Gain base Mult & Chips",
			"as Blind Size"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('36AE8D'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 7},
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		G.GAME.blind.chips = G.GAME.blind.chips + mult + hand_chips
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		G.GAME.blind.chip_text:juice_up()
		play_sound('may_blind_size')
		return mult, hand_chips, false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'candle',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Candle',
		text = { 
			"Level down discarded",
			"Poker Hands 3 times"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('C24040'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 8},
	calculate = function(self, blind, context)
		if context.pre_discard then
			local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			level_up_hand(blind, text, nil, math.max(-3, -G.GAME.hands[text].level))
			jl.ch()
		end
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'cement',
	config = { canincrease = true },
	loc_txt = {
		name = 'The Cement',
		text = { 
			"+1% Blind requirements",
			"for every card in",
			"full deck",
		}
    },
	disable = function(self)
		self.config.canincrease = false
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	set_blind = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (#G.deck.cards * 0.01))
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A8B5B2'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 9},
}

SMODS.Blind {
	key = 'charge',
	config = { canincrease = true, multiplier = 1.2 },
	loc_txt = {
		name = 'The Charge',
		text = { 
			"X#1# Blind Size when",
			"hand is played",
			"Increases by 0.2",
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 1.2 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.multiplier or 1.2 } }
	end,
	disable = function(self)
		self.config.canincrease = false
	end,
	press_play = function(self)
		if self.config.canincrease then
			self.config.multiplier = self.config.multiplier + 0.2
			G.GAME.blind.chips = G.GAME.blind.chips * self.config.multiplier
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			play_sound('may_blind_size')
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('5A76D7'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 10},
}

SMODS.Blind {
	key = 'fall',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Fall',
		text = { 
			"When hand is played,",
			"set the Nominal Chips multiplier",
			"of all cards in full deck",
			"to X0.01 the highest card rank",
			"in scoring hand",
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	calculate = function(self, blind, context)
		if context.before and self.config.can_decrease then
			local highest_rank = 0
			for k, v in pairs(context.scoring_hand) do
				if v:get_id() > highest_rank then
					highest_rank = v:get_id()
				end
			end
			for k, v in pairs(G.playing_cards) do
				v.ability.nominal_multiplier = highest_rank * 0.01
				if table_hasvalue(G.hand.cards, v) or table_hasvalue(G.play.cards, v) then
					v:juice_up()
					play_sound('may_nominal_chips')
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('429058'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 11},
}

SMODS.Blind {
	key = 'fifth',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Fifth',
		text = { 
			"X0.2 base Chips"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if self.config.can_decrease then
			return mult, hand_chips*0.2, true
		else
			return mult, hand_chips, false
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('FDADDE'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 12},
}

SMODS.Blind {
	key = 'squid',
	loc_txt = {
		name = 'The Squid',
		text = { 
			"^^^^^^5000 Blind Size",
			"until you play a Pair",
		}
    },
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2):arrow(7, 5000)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	press_play = function(self)
		if G.GAME.current_round.current_hand.handname == "Pair" then
			G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			play_sound('tarot1')
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B626A2'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 13},
}

SMODS.Blind {
	key = 'paw',
	config = { pre_hands = 0, pre_size = 0 },
	loc_txt = {
		name = 'The Paw',
		text = { 
			"Hand Size and Hands",
			"are swapped"
		}
    },
	disable = function(self)
		ease_hands_played(self.config.pre_hands - G.GAME.round_resets.hands)
		G.hand:change_size(self.config.pre_size - G.hand.config.card_limit)
	end,
	set_blind = function(self)
		self.config.pre_hands = G.GAME.round_resets.hands
		self.config.pre_size = G.hand.config.card_limit
		G.hand:change_size(G.GAME.round_resets.hands - G.hand.config.card_limit)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (G.GAME.round_resets.hands - G.hand.config.card_limit)
		ease_hands_played(G.hand.config.card_limit - G.GAME.round_resets.hands)
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('2BACA9'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 14},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 3
	end
}

SMODS.Blind {
	key = 'coffin',
	config = { can_debuff = true },
	loc_txt = {
		name = 'The Coffin',
		text = { 
			"Played cards are",
			"permanently debuffed",
			"after scoring"
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	calculate = function(self, blind, context)
		if context.after and self.config.can_debuff then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.75, func = function()
				for k, v in pairs(context.scoring_hand) do
					SMODS.debuff_card(v, true, 'may_coffin')
					v:juice_up()
				end
				play_sound('tarot1')
				SMODS.juice_up_blind()
			return true end}))
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('77744F'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 15},
}

SMODS.Blind {
	key = 'fork',
	config = { can_debuff = true, debuffed = {} },
	loc_txt = {
		name = 'The Fork',
		text = { 
			"Discarding debuffs all",
			"cards held in hand",
			"that were not discarded",
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	calculate = function(self, blind, context)
		if context.pre_discard and self.config.can_debuff then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.75, func = function()
				for k, v in pairs(G.hand.cards) do
					if not table_hasvalue(context.full_hand, v) then
						v:set_debuff(true)
						v:juice_up()
						table.insert(self.config.debuffed, v)
					end
				end
				play_sound('tarot1')
				SMODS.juice_up_blind()
			return true end}))
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('DAC651'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 16},
}

SMODS.Blind {
	key = 'pole',
	loc_txt = {
		name = 'The Pole',
		text = { 
			"Only most played Poker Hand",
			"scores"
		}
    },
	calculate = function(self, blind, context)
		if context.pre_discard then
			local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			if text == jl.favhand() then
				G.GAME.blind:disable()
			end
		end
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		if hand ~= jl.favhand() then
			G.GAME.blind.triggered = true
			G.GAME.blind:disable()
			return true
		end
		return false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6158B3'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 17},
}

SMODS.Blind {
	key = 'loanshark',
	loc_txt = {
		name = 'The Loanshark',
		text = { 
			"Multiply blind size",
			"by the sell value",
			"of a random Joker"
		}
    },
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * pseudorandom_element(G.jokers.cards, pseudoseed('may_loanshark')).sell_cost
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('8B5D41'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 18},
}

SMODS.Blind {
	key = 'branches',
	config = { can_spawn = true },
	loc_txt = {
		name = 'The Branches',
		text = { 
			"If played hand is most played",
			"Poker Hand, fill empty",
			"Joker Slots with Eternal",
			"copies of Joker"
		}
    },
	disable = function(self)
		self.config.can_spawn = false
	end,
	calculate = function(self, blind, context)
		if context.before and G.GAME.current_round.current_hand.handname == jl.favhand() then
			if self.config.can_spawn then
				for i=1, G.jokers.config.card_limit - #G.jokers.cards, 1 do
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_joker', 'may_trident')
					G.jokers:emplace(card2)
					play_sound('tarot1')
					card2:add_to_deck()
					card2:set_eternal(true)
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6B5B4C'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 19},
}

SMODS.Blind {
	key = 'runaway',
	config = { multiplier = 300 },
	loc_txt = {
		name = 'The Runaway',
		text = { 
			"+#1#% Blind Size",
			"-30% per blind skipped this run",
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 300 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (self.config.multiplier or 300) - ( G.GAME.skips * 30 ) } }
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * (((self.config.multiplier or 300) - ( G.GAME.skips * 30 )) * 0.01)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('0C0293'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 20},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'downpour',
	config = { can_convert = true },
	loc_txt = {
		name = 'The Downpour',
		text = { 
			"When hand is played,",
			"each card held in hand has",
			"a #1# in 4 chance to become",
			"a debuffed Stone card"
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 1 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	disable = function(self)
		self.config.can_convert = false
	end,
	calculate = function(self, blind, context)
		if context.before and self.config.can_convert then
			for k, v in pairs(G.hand.cards) do
				if pseudorandom('may_downpour') < G.GAME.probabilities.normal / 4 then
					G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
						play_sound("tarot1")
						v:set_ability('m_stone', nil, false)
						v:juice_up()
						v:set_debuff(true)
						SMODS.juice_up_blind()
					return true end}))
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B8F8B8'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 21},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'silence',
	config = { dollars = -1 },
	loc_txt = {
		name = 'The Silence',
		text = { 
			"Lose #1#$ when hand is played",
			"Increases by 1 for each",
			"discard and hand"
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 1 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { math.abs(self.config.dollars) } }
	end,
	press_play = function(self)
		self.config.dollars = self.config.dollars - G.GAME.round_resets.hands - G.GAME.round_resets.discards
		ease_dollars(self.config.dollars)
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('C6C6C6'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 22},
}

SMODS.Blind {
	key = 'bomb',
	config = { can_destroy = true },
	loc_txt = {
		name = 'The Bomb',
		text = { 
			"Destroy played cards",
			"with Enhancements after scoring",
		}
    },
	disable = function(self)
		self.config.can_destroy = false
	end,
	calculate = function(self, blind, context)
		if context.after and self.config.can_destroy then
			for k, v in pairs(G.play.cards) do
				if v.config.center.key ~= 'c_base' then
					G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
						v:start_dissolve()
					return true end}))
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A5B97D'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 23},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 2
	end
}

SMODS.Blind {
	key = 'trigonometry',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Trigonometry',
		text = { 
			"Apply square root",
			"to base Mult",
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if self.config.can_decrease then
			return math.sqrt(mult), hand_chips, true
		else
			return mult, hand_chips, false
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B94364'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 24},
}

end
	-- UltraBlinds

if may.conf.content.UltraBlinds then

SMODS.Blind	{
    loc_txt = {
		name = 'Ceaseless Void',
		text = { 
			'When hand is played,',
			'destroy all owned jokers',
			'if 2 or less hands remain',
			'(including eternals)'
		}
    },
	key = 'ceaseless_void',
	config = { candelete = true },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX("111111"),
	ultra = true,
	atlas = "ultrablind",
	pos = {x = 0, y = 2},
	dollars = 20,
	mult = 4,
	press_play = function(self)
		if G.GAME.current_round.hands_left <= 3 and self.config.candelete then
			G.E_MANAGER:add_event(Event({trigger = "before", delay = 0.75, func = function()
				for k, v in pairs(G.jokers.cards) do
					v:start_dissolve(nil, true)
					v = nil
				end
			return true end}))
		end
	end,
	disable = function(self)
		self.config.candelete = false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.Blind	{
    loc_txt = {
		name = 'Boundary Break',
		text = { 
			'When hand is played,',
			'destroy leftmost and rightmost jokers',
			'(including eternals)'
		}
    },
	key = 'boundary_break',
	config = { candelete = true },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX("402626"),
	ultra = true,
	atlas = "ultrablind",
	pos = {x = 0, y = 1},
	dollars = 20,
	mult = 4,
	press_play = function(self)
		if self.config.candelete then
			G.E_MANAGER:add_event(Event({trigger = "before", delay = 0.75, func = function()
				local target = G.jokers.cards[1]
				target:start_dissolve(nil, true)
				target = nil
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = "before", delay = 0.75, func = function()
				local target = G.jokers.cards[#G.jokers.cards]
				target:start_dissolve(nil, true)
				target = nil
			return true end}))
		end
	end,
	disable = function(self)
		self.config.candelete = false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.Blind	{
    loc_txt = {
		name = 'Superiority Complex',
		text = { 
			'Cannot play most played Poker hand',
			'Blind size is multiplied by the level',
			'of most played Poker hand'
		}
    },
	key = 'superiority_complex',
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX("a7a7a7"),
	ultra = true,
	atlas = "ultrablind",
	pos = {x = 0, y = 3},
	dollars = 20,
	mult = 1,
	debuff_hand = function(self, cards, hand, handname, check)
		if handname == jl.favhand() and not G.GAME.blind.disabled then
			G.GAME.blind.triggered = true
			return true
		end
	return false
	end,
	get_loc_debuff_text = function(self)
		return "Cannot play "..jl.favhand().."."
	end,
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * get_mphand_level()
		play_sound('may_blind_size')
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 4
		play_sound('tarot1')
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.Blind	{
    loc_txt = {
		name = 'Deep Space',
		text = { 
			'Gargantuan blind'
		}
    },
	key = 'deep_space',
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX("17142e"),
	ultra = true,
	atlas = "ultrablind",
	pos = {x = 0, y = 4},
	dollars = 20,
	mult = 1e32,
	disable = function(self)
		self.chips = get_blind_amount(G.GAME.round_resets.ante)*4
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.Blind	{
    loc_txt = {
		name = 'Downwards Spiral',
		text = { 
			'When hand is played,',
			'halve score operator level',
		}
    },
	key = 'downwards_spiral',
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX("ff9900"),
	config = { candecrease = true },
	ultra = true,
	atlas = "ultrablind",
	pos = {x = 0, y = 0},
	dollars = 20,
	mult = 4,
	press_play = function(self)
		if self.config.candecrease and get_score_operator() > 0 then
			set_score_operator(math.floor(get_score_operator()/2))
		end
	end,
	disable = function(self)
		self.config.candecrease = false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

end

-- Vouchers

if may.conf.content.Vouchers then

SMODS.Voucher {
	key = 'food_chain',
	loc_txt = {
		name = "Food Chain",
		text = {
			"{X:mult,C:white}Rare{} Jokers are {X:attention,C:white}X2{} more common",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod*2
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod/2
	end,
}

SMODS.Voucher {
	key = 'natural_selection',
	loc_txt = {
		name = "Natural Selection",
		text = {
			"{X:mult,C:white}Rare{} Jokers are {X:attention,C:white}X3{} more common",
			"{X:green,C:white}Uncommon{} Jokers are {X:attention,C:white}X2{} more common",
		}
	},
	pos = { x = 3, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	requires = {'v_may_food_chain'},
	unlocked = true,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod*3
		G.GAME.uncommon_mod = G.GAME.uncommon_mod*2
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod/3
		G.GAME.uncommon_mod = G.GAME.uncommon_mod/2
	end,
}

SMODS.Voucher {
	key = 'booster_surplus',
	loc_txt = {
		name = "Booster Surplus",
		text = {
			"{C:attention}+1{} {C:green}booster pack{} in shop",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		SMODS.change_booster_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-1)
	end,
}

SMODS.Voucher {
	key = 'booster_overabundance',
	loc_txt = {
		name = "Booster Overabundance",
		text = {
			"{C:attention}+1{} {C:green}booster pack{} in shop",
		}
	},
	pos = { x = 1, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_booster_surplus'},
	redeem = function(self, card)
		SMODS.change_booster_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-1)
	end,
}

SMODS.Voucher {
	key = 'varied_selection',
	loc_txt = {
		name = "Varied Selection",
		text = {
			"{C:dark_edition}Edition Cards{} may appear in {C:attention}shop{}",
		}
	},
	pos = { x = 4, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		G.GAME.editioncards_rate = 2
	end,
	unredeem = function(self, card)
		G.GAME.editioncards_rate = 0
	end,
}

SMODS.Voucher {
	key = 'bountiful_selection',
	loc_txt = {
		name = "Bountiful Selection",
		text = {
			"{C:dark_edition}Edition Cards{} appear in {C:attention}shop{} {X:attention,C:white}2X{} more frequently",
			"{C:money}Yotta cards{} can appear {C:attention}very rarely{} in {C:attention}shop"
		}
	},
	pos = { x = 5, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_varied_selection'},
	redeem = function(self, card)
		G.GAME.editioncards_rate = G.GAME.editioncards_rate*2
		G.GAME.yottacards_rate = .01
	end,
	unredeem = function(self, card)
		G.GAME.editioncards_rate = G.GAME.editioncards_rate/2
		G.GAME.yottacards_rate = 0
	end,
}

SMODS.Voucher {
	key = 'stardust',
	loc_txt = {
		name = "Stardust",
		text = {
			"{C:purple}Poker hands{} gain {C:mult}+5{} Mult and {C:chips}+15{} Chips when",
			"{C:planet}leveled up{}"
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0)	then
			G.GAME.hands[context.hand].mult = G.GAME.hands[context.hand].mult + (5 * context.amount)
			G.GAME.hands[context.hand].chips = G.GAME.hands[context.hand].chips + (15 * context.amount)
			if not context.instant then
				jl.th(context.hand)
				delay(0.5)
				Q(function() card:juice_up(.2, .3) return true end)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('chips'..math.random(1, 2))
					card:juice_up(1, 1)
				return true end}))
				jl.hc('+'..15*context.amount, true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('multhit1')
					card:juice_up(1, 1)
				return true end}))
				jl.hm('+'..5*context.amount, true)
				jl.ch()
				delay(0.5)
			end
		end
	end
}

SMODS.Voucher {
	key = 'meteor',
	loc_txt = {
		name = "Meteor",
		text = {
			"{C:purple}Poker hands{} gain {X:mult,C:white}X1.5{} Mult when",
			"{C:planet}leveled up{}"
		}
	},
	pos = { x = 3, y = 1 },
	atlas = 'voucher',
	cost = 10,
	requires = {'v_may_stardust'},
	unlocked = true,
	calculate = function(self, card, context)
		if context.level_up_hand and context.amount > 0 then
			G.GAME.hands[context.hand].mult = G.GAME.hands[context.hand].mult * (1.5 * context.amount)
			if not context.instant then
				jl.th(context.hand)
				delay(0.5)
				Q(function() card:juice_up(.2, .3) return true end)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('multhit2')
					card:juice_up(1, 1)
				return true end}))
				jl.hm('X'..1.5*context.amount, true)
				jl.ch()
				delay(0.5)
			end
		end
	end
}

SMODS.Voucher {
	key = 'investment',
	loc_txt = {
		name = "Investment",
		text = {
			"{C:money}+1 interest{}",
		}
	},
	pos = { x = 0, y = 1 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		G.GAME.interest_amount = G.GAME.interest_amount + 1
	end,
	unredeem = function(self, card)
		G.GAME.interest_amount = math.max(1, G.GAME.interest_amount - 1)
	end,
}

SMODS.Voucher {
	key = 'business',
	loc_txt = {
		name = "Business",
		text = {
			"{C:money}+1 interest{}",
		}
	},
	pos = { x = 1, y = 1 },
	atlas = 'may_voucher',
	requires = {'v_may_investment'},
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		G.GAME.interest_amount = G.GAME.interest_amount + 1
	end,
	unredeem = function(self, card)
		G.GAME.interest_amount = math.max(1, G.GAME.interest_amount - 1)
	end,
}

SMODS.Voucher {
	key = 'powerful',
	loc_txt = {
		name = "Powerful",
		text = {
			"{X:mult,C:white}X#1#{} Mult after scoring",
		}
	},
	pos = { x = 4, y = 1 },
	atlas = 'may_voucher',
	config = { extra = { x_mult = 1.5 } },
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('multhit2')
			return true end}))
			return {
				x_mult = card.ability.extra.x_mult,
				remove_default_message = true,
			}
		end
	end
}

SMODS.Voucher {
	key = 'unstoppable',
	loc_txt = {
		name = "Unstoppable",
		text = {
			"{X:chips,C:white}X#1#{} Chips after scoring",
		}
	},
	pos = { x = 5, y = 1 },
	atlas = 'may_voucher',
	config = { extra = { x_chips = 2.5 } },
	cost = 10,
	unlocked = true,
	requires = {'v_may_powerful'},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_xchip')
			return true end}))
			return {
				x_chips = card.ability.extra.x_chips,
				remove_default_message = true,
			}
		end
	end
}

SMODS.Voucher {
	key = 'transcend_1',
	loc_txt = {
		name = "Transcend I",
		text = {
			"{C:purple}Poker hands{} gain {X:mult,C:white}X1.2{} Mult and {C:chips}+200 Chips{} when",
			"{C:planet}leveled up{}",
			"{C:money}+1 Interest{}",
			"{C:attention}+2 Joker Slots{}",
			"{C:attention}+1{} {C:green}Voucher{} slot in {C:attention}shop{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 30,
	unlocked = true,
	requires = {
		'v_overstock',
		'v_clearance_sale',
		'v_hone',
		'v_reroll_surplus',
		'v_crystal_ball',
		'v_telescope',
		'v_grabber',
		'v_wasteful',
		'v_tarot_merchant',
		'v_planet_merchant',
		'v_seed_money',
		'v_blank',
		'v_magic_trick',
		'v_hieroglyph',
		'v_directors_cut',
		'v_paint_brush',
	},
	redeem = function(self, card)
		G.GAME.interest_amount = G.GAME.interest_amount + 1
		G.jokers:change_size(2)
		SMODS.change_voucher_limit(1)
	end,
	unredeem = function(self, card)
		G.GAME.interest_amount = G.GAME.interest_amount - 1
		G.jokers:change_size(-2)
		SMODS.change_voucher_limit(-1)
	end,
	calculate = function(self, card, context)
		if context.level_up_hand then
			G.GAME.hands[context.hand].mult = G.GAME.hands[context.hand].mult * (1.2 * context.amount)
			G.GAME.hands[context.hand].chips = G.GAME.hands[context.hand].chips + (15 * context.amount)
			if not context.instant then
				jl.th(context.hand)
				delay(0.5)
				Q(function() card:juice_up(.2, .3) return true end)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('chips'..math.random(1, 2))
					card:juice_up(1, 1)
				return true end}))
				jl.hc('+'..15*context.amount, true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('multhit2')
					card:juice_up(1, 1)
				return true end}))
				jl.hm('X'..1.2*context.amount, true)
				jl.ch()
				delay(0.5)
			end
		end
	end
}

SMODS.Voucher {
	key = 'transcend_2',
	loc_txt = {
		name = "Transcend II",
		text = {
			"{C:attention}+1 card{}, {C:green}Voucher{} and {C:attention}Booster{} slot in {C:attention}shop{}",
			"{C:money}-1 Reroll Price{}",
			"{C:attention}+1{} {C:chips}Hand{}, {C:mult}Discard{}, {C:attention}Hand Size{} and {C:attention}Card Selection Limit{}",
			"{C:attention}+3 Consumable Slots{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 60,
	unlocked = true,
	requires = {
		'v_overstock_plus',
		'v_liquidation',
		'v_glow_up',
		'v_reroll_glut',
		'v_omen_globe',
		'v_observatory',
		'v_nacho_tong',
		'v_recyclomancy',
		'v_tarot_tycoon',
		'v_planet_tycoon',
		'v_money_tree',
		'v_antimattter',
		'v_illusion',
		'v_petroglyph',
		'v_retcon',
		'v_palette',
	},
	redeem = function(self, card)
		G.consumeables:change_size(3)
		SMODS.change_voucher_limit(1)
		SMODS.change_booster_limit(1)
		change_shop_size(1)
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 1
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - 1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
		ease_hands_played(1)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
		ease_discard(1)
		G.hand:change_size(1)
		G.hand:change_max_highlight(1)
	end,
	unredeem = function(self, card)
		G.consumeables:change_size(-3)
		SMODS.change_voucher_limit(-1)
		SMODS.change_booster_limit(-1)
		change_shop_size(-1)
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + 1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
		ease_hands_played(-1)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
		ease_discard(-1)
		G.hand:change_size(-1)
		G.hand:change_max_highlight(-1)
	end,
}

-- Voucher Bundles

-- 2 Vouchers

SMODS.Voucher {
	key = '2_voucher_bundle_1',
	loc_txt = {
		name = "2 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_voucher_bundle',
	config = { extra = { vouchers = 2 } },
	cost = 15,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 2)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '2_voucher_bundle_2',
	loc_txt = {
		name = "2 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 1, y = 0 },
	atlas = 'may_voucher_bundle',
	config = { extra = { vouchers = 2 } },
	cost = 15,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 2)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '2_voucher_bundle_3',
	loc_txt = {
		name = "2 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'may_voucher_bundle',
	config = { extra = { vouchers = 2 } },
	cost = 15,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 2)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '2_voucher_bundle_4',
	loc_txt = {
		name = "2 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 3, y = 0 },
	atlas = 'may_voucher_bundle',
	config = { extra = { vouchers = 2 } },
	cost = 15,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 2)
		else
			may.massvoucher(nil, 2)
		end
	end
}

-- 3 Vouchers

SMODS.Voucher {
	key = '3_voucher_bundle_1',
	loc_txt = {
		name = "3 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'placeholder_voucher',
	config = { extra = { vouchers = 3 } },
	requires = {'v_may_2_booster_bundle_1'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 3)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '3_voucher_bundle_2',
	loc_txt = {
		name = "3 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'placeholder_voucher',
	config = { extra = { vouchers = 3 } },
	requires = {'v_may_2_booster_bundle_2'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 3)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '3_voucher_bundle_3',
	loc_txt = {
		name = "3 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'placeholder_voucher',
	config = { extra = { vouchers = 3 } },
	requires = {'v_may_2_booster_bundle_3'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 3)
		else
			may.massvoucher(nil, 2)
		end
	end
}

SMODS.Voucher {
	key = '3_voucher_bundle_4',
	loc_txt = {
		name = "3 Voucher Bundle",
		text = {
			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'placeholder_voucher',
	config = { extra = { vouchers = 3 } },
	requires = {'v_may_2_booster_bundle_4'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.vouchers } }
	end,
	redeem = function(self, card)
		if card then
			may.massvoucher(nil, card.ability.extra.vouchers or 3)
		else
			may.massvoucher(nil, 2)
		end
	end
}

end

-- Tags

if may.mode == 2 then

SMODS.Tag {
	atlas = "tag",
	pos = { x = 1, y = 0 },
	min_ante = 2,
	config = { type = "store_joker_create" },
	key = "mythic_tag",
	loc_txt = {
		name = 'Mythic Tag',
		text = {
			"Shop has a",
			"{C:may_mythic}Mythic Joker{}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, 'may_mythic', nil, nil, nil)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.FILTER, function()
				card:start_materialize()
				card:set_cost()
				play_sound('may_mythic_joker')
			return true end)
			tag.triggered = true
			return card
		end
	end,
}

end

SMODS.Tag {
	atlas = "tag",
	pos = { x = 2, y = 0 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "save_tag",
	loc_txt = {
		name = 'Save Tag',
		text = {
			"Create a random {C:dark_edition}Negative{}",
			"{C:attention}Perishable{} {X:may_surreal,C:white}Surreal{} {C:attention}Joker{}",
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.PURPLE, function()
				local card = create_card("Joker", G.jokers, nil, 'may_surreal', nil, nil, nil)
				card:add_to_deck()
				card:set_edition({negative = true})
				card:set_perishable(true)
				G.jokers:emplace(card)
				play_sound('may_surreal_joker')
				G.CONTROLLER.locks[lock] = nil
			return true end)
			tag.triggered = true
		return true
		end
	end,
}

SMODS.Tag {
	atlas = "tag",
	pos = { x = 3, y = 0 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "unstable_tag",
	loc_txt = {
		name = 'Unstable Tag',
		text = {
			"Creates an {C:attention}Universal Collapse{} Joker",
			"{C:attention}+3{} Ante",
			"{C:inactive}(requires room){}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				tag:yep("+", G.C.PURPLE, function()
					if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
						G.jokers:emplace(card2)
						play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
						card2:add_to_deck()
						ease_ante(3)
						G.CONTROLLER.locks[lock] = nil
					end
				return true end)
			else
				tag:nope()
			end
			tag.triggered = true
		return true
		end
	end,
}

SMODS.Tag {
	atlas = "tag",
	pos = { x = 0, y = 0 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "astronomy_tag",
	loc_txt = {
		name = 'Astronomy Tag',
		text = {
			"Creates {C:attention}3 random{} {C:dark_edition}Negative{} {X:mult,C:white}Rare{}",
			"{C:planet}Planet{} Cards",
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.RED, function()
				for i = 1, 3, 1 do
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						play_sound('timpani', 0.5)
						local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_telescope_tag')), 'may_telescope_tag')
						card2:add_to_deck()
						card2:set_edition({negative = true})
						G.consumeables:emplace(card2)
						card2:juice_up(0.3, 0.5)
					return true end}))
				end
			return true end)
			tag.triggered = true
		return true
		end
	end,
}

-- Jokers

-- dont have a good spot where to put this
may.n_jokers = {
	'j_may_sly_n',
	'j_may_noble_gas',
	'j_may_navigation',
	'j_may_n',
	'j_may_nnnn',
	'j_may_nose',
	'j_may_grafitti_n',
	'j_may_nanobot',
	'j_may_subdola',
}
if may.conf.content.Jokers then
	-- Common
	
SMODS.Joker {
	key = 'hierarchy',
	loc_txt = {
		name = 'Hierarchy',
		text = {
			"{C:attention}Gains{} {C:chips}+#1#{} Chips when a {C:attention}playing card{}",
			"with any {C:attention}Enhancement, Edition or Seal{} is {C:attention}scored{}",
			"{C:inactive}Currently {C:chips}+#2#{} Chips{}"
		}
	},
	config = { extra = { chips_gain = 5, chips = 0 } },
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 5, y = 0 },
	blueprint_compat = true,
	cost = 3,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card.config.center ~= G.P_CENTERS.c_base or context.other_card.edition then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
				return {
					colour = G.C.CHIPS,
					card = card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						message = "Upgraded!"
					return true end }))	
				}
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				card = card,
				colour = G.C.CHIPS,
				message = '+'.. card.ability.extra.chips .. ' Chips',
			}
		end
		if context.forcetrigger then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			return {
				colour = G.C.CHIPS,
				card = card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					message = "Upgraded!"
				return true end }))	
			}
		end
	end
}

SMODS.Joker {
	key = 'fading_joker',
	loc_txt = {
		name = 'Fading Joker',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"{C:mult}Self destructs{} after {C:attention}#2#{} rounds"
		}
	},
	config = { extra = { Xmult = 3, rounds = 3} },
	rarity = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.rounds} }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,
				colour = G.C.RED,
				message = 'X'.. card.ability.extra.Xmult .. ' Mult',
        }
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds < 1 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
                    play_sound('tarot1')
					message = "Faded!"
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
				return {
					message = 'Faded!',
					card = card
				}
			end
			return {
				message = card.ability.extra.rounds.."/3",
				card = card
			}
		end
		-- we do a little trolling
		if context.forcetrigger then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds < 1 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
                    play_sound('tarot1')
					message = "Faded!"
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
				return {
					message = 'Faded!',
					card = card
				}
			end
			return {
				message = card.ability.extra.rounds.."/3",
				card = card
			}
		end
    end
}

SMODS.Joker {
	key = 'dead_pixel',
	loc_txt = {
		name = 'Dead Pixel',
		text = {
			"{C:mult}+#1#{} Mult",
			"{C:green}#2# in #3#{} chance for {X:mult,C:white}X#4#{} Mult"
		}
	},
	config = { extra = { mult = 50, odds = 4, Xmult = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Xmult} }
	end,
	rarity = 1,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 2, y = 7 },
	demicoloncompat = true,
	cost = 4,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if pseudorandom('may_dead_pixel') < G.GAME.probabilities.normal / card.ability.extra.odds then	
				return {
					Xmult_mod = card.ability.extra.Xmult,
					message = "X"..card.ability.extra.Xmult.." Mult",
					colour = G.C.MULT
				}
			else
				return {
					mult_mod = card.ability.extra.mult,
					message = "+"..card.ability.extra.mult.." Mult",
					colour = G.C.MULT
				}
			end
		end
		if context.forcetrigger then
			-- we do a little trolling part 2
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = "X"..card.ability.extra.Xmult.." Mult",
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'illusion',
	loc_txt = {
		name = 'Illusion',
		text = {
			"{C:attention}All Blinds{} count as {C:attention}UltraBlinds{}",
			"{C:inactive,E:1,s:0.5}art by _TeKKen_{}"
		}
	},
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 0, y = 16 },
	blueprint_compat = true,
	cost = 3,
	demicoloncompat = false,
}

SMODS.Joker {
	key = 'sly_n',
	loc_txt = {
		name = "Sly N",
		text = {
			"All {C:dark_edition}N{} Jokers give {C:chips}+#1#{} Chips",
			"if played {C:attention}hand{} is {C:attention}Three of a Kind{}",
			"{C:attention}Additional{} {C:chips}+#2#{} Chips for {C:attention}every{} {C:dark_edition}Sly Joker{}",
			"{C:chips}+#3#{} {C:inactive}in total{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	rarity = 1,
	atlas = 'joker1',
	n_joker = true,
	pos = { x = 0, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { N = true },
	cost = 4,
	config = { extra = { base_chips = 20, bonus_chips = 30, total_chips = 0} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.base_chips, card.ability.extra.bonus_chips, card.ability.extra.total_chips } }
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			if may.is_n(context.other_joker) then
				if G.GAME.current_round.current_hand.handname == "Three of a Kind" then
					return {
						chips = card.ability.extra.total_chips,
						card = card,
						message = "+"..card.ability.extra.total_chips,
						colour = G.C.CHIPS
					}
				end
			end
		end
		if context.forcetrigger then
			return {
				chips = card.ability.extra.total_chips,
				card = card,
				message = "+"..card.ability.extra.total_chips,
				colour = G.C.CHIPS
			}
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local sly_jokers = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					sly_jokers = sly_jokers + 1
				end
			end
			card.ability.extra.total_chips = (sly_jokers * card.ability.extra.bonus_chips) + card.ability.extra.base_chips
		end
	end
}

SMODS.Joker {
	key = 'noble_gas',
	loc_txt = {
		name = 'Noble Gas',
		text = {
			"If played hand is {C:attention}Five of a Kind{}",
			"this Joker {C:planet}levels up{} {C:attention}Three of a Kind{} {C:attention}#1#{} times",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 4, y = 10 },
	blueprint_compat = false,
	n_joker = true,
	pools = { N = true },
	cost = 4,
	config = { extra = { level = 3 } },
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level } }
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and G.GAME.current_round.current_hand.handname == "Five of a Kind" then
			jl.th('High Card')
			level_up_hand(card, 'High Card', nil, card.ability.extra.level)
			delay(0.5)
			jl.ch()
		end
		if context.forcetrigger then
			jl.th('High Card')
			level_up_hand(card, 'High Card', nil, card.ability.extra.level)
			delay(0.5)
			jl.ch()
		end
	end
}


	-- Uncommon

SMODS.Joker {
	key = 'AAAA',
	loc_txt = {
		name = 'AAAA',
		text = {
			"Retrigger all",
			"played {C:attention}Aces #1#{} times",
			may.add_fusion_text('Universal Collapse')
		}
	},
	config = { extra = { repetitions = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions} }
	end,
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 5 },
	cost = 6,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then		
				return {
					message = 'AAAAgain!',
					repetitions = card.ability.extra.repetitions,
					card = card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(.5, .5)
					return true end }))	
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'double_edged_sword',
	loc_txt = {
		name = 'Double-Edged Sword',
		text = {
			"{X:attention,C:white}X#1#{} Blind Size",
			"{C:money}+$#2#{} at the end of round"
		}
	},
	config = { extra = { size = 1.3, dollars = 10 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 4, y = 4 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.size, card.ability.extra.dollars } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_blind_size(0, 1.3)
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		change_blind_size(-3, 1.3)
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				dollars = card.abilityt.extra.dollars,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'thumb',
	loc_txt = {
		name = 'Thumb',
		text = {
			"{C:money}+$#1#{} for {C:attention}every played card{}",
			"{C:attention}less{} than current {C:attention}Card Selection Limit{}",
			"{C:inactive}Max of $#2#{}",
			"{C:inactive,E:1,s:0.5}art & idea by Gorbnim{}"
		}
	},
	config = { extra = { dollars = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars*100} }
	end,
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 17 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger and not (G.hand.config.highlighted_limit == #G.play.cards) then
			return {
				dollars = math.min(100, (G.hand.config.highlighted_limit - #G.play.cards)) * card.ability.extra.dollars,
				message = '$'..math.min(100, (G.hand.config.highlighted_limit - #G.play.cards)) * card.ability.extra.dollars,
				card = card,
				colour = G.C.MONEY
			}
		end
	end
}

SMODS.Joker {
	key = 'paper_shredder',
	loc_txt = {
		name = 'Paper Shredder',
		text = {
			"{C:attention}After hand{} is played,",
			"{C:mult}destroy{} a {C:attention}random card{}",
			"held in hand and {C:attention}gain{} {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}Currently {X:mult,C:white}X#2#{} Mult"
		}
	},
	config = { extra = { Xmult_gain = .1, Xmult = 1 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 1, y = 3 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.jokers and #G.hand.cards > 0 and not context.blueprint then
			card2 = pseudorandom_element(G.hand.cards, pseudoseed("paper_shredder_selection"))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('generic1')
				card:juice_up(0.3, 0.5)
				card2.highlighted = true
			return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				card:juice_up(0.3, 0.5)
				if card2.ability.name == 'Glass Card' then 
					card2:shatter()
				else
					card2:start_dissolve(nil, true)
				end
			return true end }))
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				colour = G.C.MULT,
				card = card,
				message = "Upgraded!"
			}
		end
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = "X"..card.ability.extra.Xmult.." Mult",
				colour = G.C.MULT,
				Xmult_mod = card.ability.extra.Xmult,
				card = card
			}
		end
		if context.forcetrigger then
			card2 = pseudorandom_element(G.hand.cards, pseudoseed("paper_shredder_selection"))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('generic1')
				card:juice_up(0.3, 0.5)
				card2.highlighted = true
			return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				card:juice_up(0.3, 0.5)
				if card2.ability.name == 'Glass Card' then 
					card2:shatter()
				else
					card2:start_dissolve(nil, true)
				end
			return true end }))
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				colour = G.C.MULT,
				card = card,
				message = "Upgraded!"
			}
		end
	end
}

SMODS.Joker {
	key = 'voucher_joker',
	loc_txt = {
		name = 'Voucher Joker',
		text = {
			"{C:attention}+#1#{} {C:green}Voucher Slot{}",
			"{C:inactive,E:1,s:0.5}idea by _TeKKen_{}"
		}
	},
	config = { extra = { slots = 1 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 3, y = 15 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.change_voucher_limit(card.ability.extra.slots)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(-card.ability.extra.slots)
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.change_voucher_limit(card.ability.extra.slots)
			return {
				message = '+'..card.ability.extra.slots..' Voucher Slot',
				
			}
		end
	end
}

SMODS.Joker {
	key = 'nebula',
	loc_txt = {
		name = 'Nebula',
		text = {
			"When hand is played, {C:attention}before scoring{},",
			"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
			"as {C:mult}+Mult{}",
			"{C:inactive}Currently {C:mult}+#1#{} {C:inactive}Mult{}",
			may.add_fusion_text('Universal Collapse')
		}
	},
	config = { extra = { mult = 0 } },
	pos = { x = 0, y = 3 },
	cost = 5,
	rarity = 2,
	unlocked = true,
	demicoloncompat = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'joker1',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].level 
			return {
				message = "Upgraded!",
				colour = G.C.MULT,
				card = card,			
			}
		end
		if context.joker_main then
			return {
				message = "+"..card.ability.extra.mult.." Mult",
				colour = G.C.MULT,
				mult_mod = card.ability.extra.mult,
				card = card,			
			}
		end
		if context.forcetrigger then
			card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name or 'High Card'].level 
			return {
				message = "Upgraded!",
				colour = G.C.MULT,
				card = card,			
			}
		end
	end
}

SMODS.Joker {
	key = 'mana_orb',
	loc_txt = {
    name = 'Mana Orb',
    text = {
		"{C:green}#1# in #2#{} chance to",
		"apply {C:attention}random{} {C:dark_edition}Enhancements{} to",
		"all {C:attention}played cards before scoring{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 3, y = 2 },
	config = { extra = { odds = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	cost = 4,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and pseudorandom('may_mana_orb') < G.GAME.probabilities.normal / card.ability.extra.odds then
			local enhance = {}
				for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
					if v.key ~= 'm_stone' then
						table.insert(enhance, v)
					end
				end
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability(pseudorandom_element(enhance, pseudoseed('may_mana_orb')), nil, true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
			return {
				card = card,
				message = "Enhancements!",
				colour = G.C.DARK_EDITION
			}
		end
		if context.forcetrigger then
			local enhance = {}
				for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
					if v.key ~= 'm_stone' then
						table.insert(enhance, v)
					end
				end
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability(pseudorandom_element(enhance, pseudoseed('may_mana_orb')), nil, true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
			return {
				card = card,
				message = "Enhancements!",
				colour = G.C.DARK_EDITION
			}
		end
	end
}

SMODS.Joker {
	key = 'kids_drawing',
	loc_txt = {
		name = "Kid's Drawing",
		text = {
			"When {C:attention}blind{} is selected,",
			"this joker creates {C:attention}#1#{} random {C:attention}playing cards{}",
			"and shuffles them into your {C:attention}deck{}",
			"{C:inactive}(may have an Enhancement, Seal and/or Edition){}"
		}
	},
	config = { extra = { amount = 4 } },
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount } }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and context.cardarea == G.jokers) or (context.setting_blind and context.cardarea == G.jokers and context.blueprint) then
			local created_cards = {}
			for i=1, card.ability.extra.amount, 1 do
				local card = create_playing_card(nil, G.play, nil, i == 1, {G.C.IMPORTANT})
				table.insert(created_cards, card)
			end
			delay(0.5)
			jl.randomise(created_cards)
			delay(0.5)
			for k, v in ipairs(created_cards) do
				G.E_MANAGER:add_event(Event({delay = 0.2*k, timer = 'REAL', func = function()
					play_sound('card1')
					v:add_to_deck()
					G.play:remove_card(v)
					G.deck:emplace(v)
				return true end}))
			end
		end
		if context.forcetrigger then
			local created_cards = {}
			for i=1, card.ability.extra.amount, 1 do
				local card = create_playing_card(nil, G.pack_cards, nil, i == 1, {G.C.IMPORTANT})
				table.insert(created_cards, card)
			end
			delay(0.5)
			jl.randomise(created_cards)
			delay(0.5)
			for k, v in ipairs(created_cards) do
				G.E_MANAGER:add_event(Event({delay = 0.2*k, timer = 'REAL', func = function()
					play_sound('card1')
					v:add_to_deck()
					G.pack_cards:remove_card(v)
					G.deck:emplace(v)
				return true end}))
			end
		end
	end
}

SMODS.Joker {
	key = 'navigation',
	loc_txt = {
		name = "Navigation",
		text = {
			"When Blind is {C:attention}skipped{}",
			"this Joker creates {C:attention}3{} {C:dark_edition}Negative Sly Jokers{}",
			"and {C:mult}self destructs{}",
			"{C:mult}Self destructs{} in {C:attention}#1# rounds{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 2, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { rounds = 3 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if context.skip_blind and context.cardarea == G.jokers then
			for i=1, 3, 1 do
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({negative = true}, false, false)
			end
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
					return true end})) 
			return true end}))
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds < 1 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
                    play_sound('tarot1')
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
			end
			return {
				message = card.ability.extra.rounds.." rounds left",
				card = card
			}
		end
		if context.forcetrigger then
			for i=1, 3, 1 do
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({negative = true}, false, false)
			end
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
					return true end})) 
			return true end}))
		end
	end
}

	-- Rare
	
SMODS.Joker {
	key = 'jonas',
	loc_txt = {
		name = 'Jonas',
		text = {
			"{X:mult,C:white}X#1#{} Mult"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 4, y = 17 },
	blueprint_compat = false,
	config = { extra = { Xmult = 4, } },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X'..card.ability.extra.Xmult..' Mult',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'free_sample',
	loc_txt = {
		name = 'Free Sample',
		text = {
			"When {C:attention}Boss Blind{} is defeated,",
			"redeem a {C:green}random Voucher{}",
			"{C:mult}Self destructs{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 3, y = 0 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not (context.individual and context.cardarea == G.play) and G.GAME.blind.boss and not card.gone then
			delay(0.5)
			jl.voucher()
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
				return true end})) 
			return true end}))
		end
		if context.forcetrigger then
			delay(0.5)
			jl.voucher()
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
				return true end})) 
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'lil_prince',
	loc_txt = {
		name = "Lil' Prince",
		text = {
			"{X:mult,C:white}^#1#{} Mult if played",
			"hand is {C:attention}Royal Flush{}",
			"{C:attention}otherwise{}, {C:mult}destroy{} all played {C:attention}cards{}",
			"{C:inactive,E:1,s:0.5}art & name by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 3, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { Emult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands['may_Royal Flush']) then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT
			}
		end
		if context.destroying_card then
			if not (G.GAME.current_round.current_hand.handname == "Royal Flush") then
				return {remove = not context.destroying_card.ability.eternal}
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'gemstone',
	loc_txt = {
    name = 'Gemstone',
    text = {
			"{C:attention}Glass Cards{} also give {X:chips,C:white}X#1#{} Chips",
			"but {C:attention}always break{}"
		}
	},
	config = { extra = { Xchips = 2 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 0 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.name == 'Glass Card' then
				return {
					xchips = card.ability.extra.Xchips,
					colour = G.C.CHIPS,
					card = context.other_card,	
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card2 = context.other_card
						card:juice_up(.3, .5)
						card2:shatter()
						card2.will_shatter = true
					return true end }))
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'pea',
	loc_txt = {
    name = 'Pea',
    text = {
			"{C:attention}Held in hand{} {C:dark_edition}Steel{} cards",
			"give {C:attention}played{} {C:purple}Poker Hand{} {X:mult,C:white}X#1#{} Mult",
			"after scoring",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	config = { extra = { Xmult = 1.2 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 17 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.after then
			for k, v in pairs(G.hand.cards) do
				if v.ability.name == 'Steel Card' then
					jl.th(G.GAME.current_round.current_hand.handname)
					G.GAME.hands[G.GAME.current_round.current_hand.handname].mult = G.GAME.hands[G.GAME.current_round.current_hand.handname].mult * card.ability.extra.Xmult
					delay(0.5)
					Q(function() card:juice_up(.2, .3) return true end)
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						play_sound('button')
					return true end}))
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						play_sound('multhit2')
						card:juice_up(0.3, 0.5)
						v:juice_up(0.3, 0.5)
					return true end}))
					jl.hcm(nil, 'X'..card.ability.extra.Xmult..'', true)
					jl.ch()
					delay(0.5)
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'n',
	loc_txt = {
		name = "N",
		text = {
			"If played hand is {C:attention}Three of a kind{},",
			"create a {C:dark_edition}Polychrome{} {C:attention}Sly Joker{}",
			"{C:inactive}(must have room){}",
			"{C:inactive,E:1,s:0.5}original idea & art by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 1, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 14,
	config = { extra = { chips = 50 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_polychrome']
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Three of a Kind']) and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({polychrome = true}, false, false)
		end
		if context.forcetrigger then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({polychrome = true}, false, false)
			end
		end
	end
}

SMODS.Joker {
	key = 'n_lowercase',
	loc_txt = {
		name = 'n',
		text = {
			"{C:attention}Gains{} {X:chips,C:white}^#1#{} Chips when {C:dark_edition}Sly Joker{} is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^#2#{}{C:inactive} Chips{}",
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.Echip_gain, card.ability.extra.Echip, } }
	end,
	config = { extra = { Echip_gain = 0.14, Echip = 1 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { N = true },
	pos = { x = 3, y = 8 },
	cost = 14,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Echip > 1 then
			return {
				Emult_mod = card.ability.extra.Echip,
				message = '^'.. card.ability.extra.Echip .. ' Chips',
				colour = G.C.CHIPS,
				card = card,				
			}
		end
		if context.selling_card and context.card.ability.set == "Joker" and context.card:gc().key == 'j_sly' and not context.blueprint then
			card.ability.extra.Echip = card.ability.extra.Echip + card.ability.extra.Echip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.forcetrigger then
			card.ability.extra.Echip = card.ability.extra.Echip + card.ability.extra.Echip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'nose',
	loc_txt = {
		name = "Nose",
		text = {
			"If played hand is {C:attention}Three of a kind{},",
			"all played {C:attention}cards{} gain {C:mult}+#1#{} Mult",
			"Increases by {C:attention}#2#{} for every owned {C:dark_edition}Sly Joker{}",
			"at the {C:attention}end of round{}",
			"{C:inactive,E:1,s:0.5}original idea & art by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 2, y = 10 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { mult = 3, mult_gain = 3} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and G.GAME.current_round.current_hand.handname == "Three of a Kind" then
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
			return {
				message = 'Upgraded!',
				card = context.other_card,
				colour = G.C.MULT
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					amount = amount + card.ability.extra.mult_gain
				end
			end
			if amount ~= 0 then
				card.ability.extra.mult = card.ability.extra.mult + amount
				return {
					message = 'Upgraded! (+'..amount..')',
					card = card,
					colour = G.C.MULT
				}
			end
		end
		if context.forcetrigger then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					amount = amount + card.ability.extra.mult_gain
				end
			end
			if amount ~= 0 then
				card.ability.extra.mult = card.ability.extra.mult + amount
				return {
					message = 'Upgraded! (+'..amount..')',
					card = card,
					colour = G.C.MULT
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'grafitti_n',
	loc_txt = {
		name = "Grafitti N",
		text = {
			"If played hand is {C:attention}Three of a kind{},",
			"{C:green}#1# in #2#{} chance to create a {C:dark_edition}Foil{} {C:attention}Sly Joker{}",
			"{C:green}Always{} triggers if you own {C:attention}3{} or more {C:dark_edition}N{} jokers",
			"{C:mult}Works once per round{}",
			"{C:inactive}(must have room){}",
			"{C:inactive}#3#, #4#{}",
			"{C:inactive,E:1,s:0.5}original idea & art by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 3, y = 10 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { odds = 6, cantrigger = true, guaranteed = false} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cantrigger and 'Active' or 'Inactive', card.ability.extra.guaranteed and 'guaranteed' or 'not guaranteed' } }
	end,
	calculate = function(self, card, context)
		if context.before and G.GAME.current_round.current_hand.handname == "Three of a Kind" and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.ability.extra.cantrigger then
			if card.ability.extra.guaranteed then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({foil = true}, false, false)
				card.ability.extra.cantrigger = false
			else
				if pseudorandom('may_grafitti_n') < G.GAME.probabilities.normal / card.ability.extra.odds then
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
					G.jokers:emplace(card2)
					card2:add_to_deck()
					card2:set_edition({foil = true}, false, false)
					card.ability.extra.cantrigger = false
				end
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.cantrigger == false then
			card.ability.extra.cantrigger = true
			return {
				message = 'Activated!',
				card = card
			}
		end
		if context.forcetrigger then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({foil = true}, false, false)
			card.ability.extra.cantrigger = false
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.n_joker and v ~= card then
					amount = amount + 1
					if amount >= 3 then
						card.ability.extra.guaranteed = true
					end
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'nnnn',
	loc_txt = {
		name = "NNNN",
		text = {
			"{C:attention}Retrigger{} all {C:dark_edition}N{} {C:attention}Jokers{} for",
			"{C:attention}every Ace{} in {C:attention}scoring hand{}",
			"If played hand is {C:attention}Three of a Kind{}, set the rank of",
			"{C:attention}all scoring cards{} to {C:attention}Aces{}",
			"{C:inactive}(NNNN excluded){}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	demicoloncompat = true,
	pos = { x = 1, y = 16 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { odds = 6, cantrigger = true, guaranteed = false} },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cantrigger and 'Active' or 'Inactive', card.ability.extra.guaranteed and 'guaranteed' or 'not guaranteed' } }
	end,
	calculate = function(self, card, context)
		local amount = 0
		if context.before then
			for k, v in pairs(context.scoring_hand) do
				if context.scoring_hand[k]:get_id() == 14 then
					amount = amount + 1
				end
			end
			if (not context.blueprint) and next(context.poker_hands['Three of a Kind']) then
				for _, card in ipairs(context.scoring_hand) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
				return {
					message = "Nace!",
					colour = G.C.DARK_EDITION,
				}
			end
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and context.other_card ~= card and may.is_n(context.other_card) then
			if amount > 0 then
				return {
					repetitions = amount,
					message = 'Again!',
					card = card
				}
			end
		end
		if context.forcetrigger then
			for _, card in ipairs(context.scoring_hand) do
					assert(SMODS.change_base(card, nil, "Ace"))
			end
			return {
				message = "Nace!",
				colour = G.C.DARK_EDITION,
			}
		end
	end
}

SMODS.Joker {
	key = 'burning_n',
	loc_txt = {
    name = 'Burning N',
    text = {
		"{C:green}#1# in #2#{} chance to",
		"apply {C:attention}Scorched{} to",
		"all {C:attention}played cards{} if played",
		"Poker Hand is {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 4, y = 8 },
	pools = { N = true },
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_scorched']
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	cost = 4,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and G.GAME.current_round.current_hand.handname == "Three of a Kind" then
			if pseudorandom('may_burning_n') < G.GAME.probabilities.normal / card.ability.extra.odds then
				for k, v in ipairs(context.scoring_hand) do
					v:set_ability('m_may_scorched', nil, true)
				end
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('holo1')
				return true end}))
				return {
					card = card,
					message = "scorched!",
					colour = G.C.DARK_EDITION
				}
			end
		end
		if context.forcetrigger then
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability("m_may_scorched", nil, true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
			return {
				card = card,
				message = "scorched!",
				colour = G.C.DARK_EDITION
			}
		end
	end
}


if may.conf.Mode == 1 then

SMODS.Joker {
	key = 'collectors_edition',
	loc_txt = {
    name = 'Collector\'s Edition',
    text = {
			"{X:mult,C:white}^#1#{} Mult if",
			"{C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			may.add_fusion_text('Diskus Kollectum')
		}
	},
	config = { extra = { Emult = 1.5 } },
	rarity = 3,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 3, y = 5 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main and card.edition then
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				colour = G.C.MULT,
				Emult_mod = card.ability.extra.Emult,
				card = card
			}
		end
		if context.forcetrigger then
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				colour = G.C.MULT,
				Emult_mod = card.ability.extra.Emult,
				card = card
			}
		end
	end
}

else  

SMODS.Joker {
	key = 'collectors_edition',
	loc_txt = {
    name = 'Collector\'s Edition',
    text = {
			"{X:mult,C:white}^^#1#{} Mult if",
			"{C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			may.add_fusion_text('Diskus Kollectum')
		}
	},
	config = { extra = { EEmult = 1.05 } },
	rarity = 3,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.EEmult } }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 5 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main and card.edition then
			return {
				EEmult_mod = card.ability.extra.EEmult,
				message = '^^'..card.ability.extra.EEmult..' Mult',
				colour = G.C.RED,
				card = card
			}
		end
		if context.forcetrigger then
			return {
				EEmult_mod = card.ability.extra.EEmult,
				message = '^^'..card.ability.extra.EEmult..' Mult',
				colour = G.C.RED,
				card = card
			}
		end
	end
}

end

SMODS.Joker {
	key = 'collectionist',
	loc_txt = {
    name = 'Collectionist',
    text = {
		"{C:attention}Jokers{} with an {C:dark_edition}Edition{}",
		"give {X:chips,C:white}X#1#{} Chips",
		may.add_fusion_text('Diskus')
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 4, y = 9 },
	cost = 6,
	config = { extra = { Xchips = 2 } },
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips} }
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.edition and card ~= context.other_joker then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "X"..card.ability.extra.Xchips.." Chips",
				Xchip_mod = card.ability.extra.Xchips,
				colour = G.C.CHIPS
			}
		end
		if context.forcetrigger then
			return {
				message = "X"..card.ability.extra.Xchips.." Chips",
				Xchip_mod = card.ability.extra.Xchips,
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'wheel_of_eternity',
	loc_txt = {
    name = 'Wheel of Eternity',
    text = {
		"{C:green}#1# in #2#{} chance to create",
		"{C:attention}#3#{} {C:purple}Wheel of Fortune{} cards",
		"when {C:attention}a playing card{} is triggered",
		"{C:inactive}(Requires room){}",
		may.add_fusion_text('man'),
		"{C:inactive,E:1,s:0.5}idea by _TeKKen_{}",
		}
	},
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 5 },
	cost = 8,
	config = { extra = { odds = 4, cards = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card then
			if pseudorandom('may_wheel_of_eternity') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({ func = function()
					card:juice_up(0.5, 0.5)
					if Incantation then
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						wheel:setQty(math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards))
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
					else
						for i=1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards), 1 do
							local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
							G.consumeables:emplace(wheel)
							wheel:add_to_deck()
							-- wheel:set_cost()
						end
					end
				return true end}))
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					wheel:setQty(math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards))
					G.consumeables:emplace(wheel)
					wheel:add_to_deck()
				else
					for i=1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards), 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						-- wheel:set_cost()
					end
				end
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'man',
	loc_txt = {
		name = "man",
		text = {
			"When {C:attenton}Blind{} is {C:attention}selected{},",
			"this Joker creates {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
			may.add_fusion_text('Wheel of Eternity'),
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKeN_{}"
		}
	},
	config = { extra = { cards = 3 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 9 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:setQty(card.ability.extra.cards)
						wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:setQty(card.ability.extra.cards)
						wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'destroyer',
	loc_txt = {
		name = 'Destroyer',
		text = {
			"This Joker {C:attention}gains{} {X:chips,C:white}X#1#{} Chips",
			"when a {C:planet}Planet{} Card is {C:attention}sold{}",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive}Currently {X:chips,C:white}X#2#{} Chips{}"
		}
	},
	config = { extra = { Xchips_gain = .2, Xchips = 1 } },
	pos = { x = 3, y = 7 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xchips_gain, card.ability.extra.Xchips}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchips_gain
			return	{
				message = 'Upgraded!',
				colour = G.C.CHIPS
			}
		end
		if context.joker_main and card.ability.extra.Xchips > 1 then
			return {
				message = "X"..card.ability.extra.Xchips.." Chips",
				colour = G.C.CHIPS,
				Xchip_mod = card.ability.extra.Xchips,
				card = card,			
			}
		end
		if context.forcetrigger then
			card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchips_gain
			return	{
				message = 'Upgraded!',
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'royale',
	loc_txt = {
		name = 'Royale',
		text = {
			"This Joker {C:attention}gains{} {X:mult,C:white}X#1#{} Mult",
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Currently {X:mult,C:white}X#2#{} Mult{}",
			may.add_fusion_text('Universal Collapse')
		}
	},
	config = { extra = { Xmult_gain = 2, Xmult = 1 } },
	pos = { x = 4, y = 3 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = "X"..card.ability.extra.Xmult.." Mult",
				colour = G.C.MULT,
				Xmult_mod = card.ability.extra.Xmult,
				card = card,	
			}
		end
		if context.before and next(context.poker_hands['may_Royal Flush']) and not context.blueprint then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

SMODS.Joker {
	key = 'bad_handwriting',
	loc_txt = {
		name = 'Bad Handwriting',
		text = {
			"This Joker {C:attention}gains{} {X:mult,C:white}^^#1#{} Mult",
			"when a {C:attention}secret{} {C:purple}Poker Hand{} is", 
			"{C:mult}discarded{} and has {C:attention}never{} been {C:attention}played{}",
			"{C:inactive}Currently {X:mult,C:white}^^#2#{} {C:inactive}Mult{}",
		}
	},
	config = { extra = { EEmult_gain = 0.01, EEmult = 1 } },
	pos = { x = 2, y = 17 },
	cost = 8,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEmult_gain, card.ability.extra.EEmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.EEmult > 1 then
			return {
				message = "^^"..card.ability.extra.EEmult.." Mult",
				colour = G.C.MULT,
				EEmult_mod = card.ability.extra.EEmult,
				card = card,	
			}
		end
		if context.pre_discard and table_hasvalue(may.secret_hands, G.GAME.current_round.current_hand.handname) and G.GAME.hands[G.GAME.current_round.current_hand.handname].played == 0 and not context.blueprint then
			card.ability.extra.EEmult = card.ability.extra.EEmult + card.ability.extra.EEmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEmult = card.ability.extra.EEmult + card.ability.extra.EEmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

if may.conf.Mode == 2 then
SMODS.Joker {
	key = 'daredevil',
	loc_txt = {
		name = 'Daredevil',
		text = {
			"If blind was {C:attention}beaten{} on your {C:attention}last{} hand,",
			"{C:green}#1# in #2#{} chance to increase {C:dark_edition}score operator{}",
			"level by {C:attention}#3#{}",
			"{X:attention,C:white}X#4#{} blind size",
			may.add_fusion_text('Universal Collapse')
		}
	},
	config = { extra = { odds = 20, mod = 1, blindmult = 4 } },
	pos = { x = 1, y = 7 },
	cost = 7,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult }}
    end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_blind_size(0, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_blind_size(-3, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and (G.GAME.current_round.hands_left == 0 or #SMODS.find_card('j_cry_panopticon') ~= 0) then
			if pseudorandom('may_daredevil') < G.GAME.probabilities.normal / card.ability.extra.odds then
				mod_score_operator(-1, card.ability.extra.mod)
				return {
					message = 'Upgraded!',
					card = card
				}
			end
		end
		if context.forcetrigger then
			mod_score_operator(-1, card.ability.extra.mod)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
	end
}
end

SMODS.Joker {
	key = 'ketchapp',
	loc_txt = {
		name = 'Ketchapp',
		text = {
			"If played hand has {C:attention}3 or less{} cards,",
			"played {C:attention}Hearts{} have a {C:green}#1# in #2#{} chance",
			"to give {X:mult,C:white}^#3#{} Mult",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	config = { extra = { odds = 3, Emult = 1.1 } },
	pos = { x = 0, y = 11 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Emult }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if #G.play.cards <= 3 then
				if context.other_card:is_suit('Hearts') then	
					if pseudorandom('may_ketchapp') < G.GAME.probabilities.normal / card.ability.extra.odds then
						return {
							e_mult = card.ability.extra.Emult,
							card = context.other_card,
							message = '^'..card.ability.extra.Emult..' Mult',
							colour = G.C.RED
						}
					end
				end
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = context.other_card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.RED
			}
		end
	end
}

SMODS.Joker {
	key = 'mustard',
	loc_txt = {
		name = 'Mustard',
		text = {
			"If {C:attention}Joker Slots{} are {C:attention}fully occupied{},",
			"played {C:attention}Diamonds{} have a {C:green}#1# in #2#{} chance",
			"to give {C:money}$#3#{}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { odds = 4, dollars = 15 } },
	pos = { x = 5, y = 10 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.dollars }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit then
				if context.other_card:is_suit('Diamonds') then
					if pseudorandom('may_mustard') < G.GAME.probabilities.normal / card.ability.extra.odds then
						return {
							dollars = card.ability.extra.dollars,
							card = context.other_card,
						}
					end
				end
			end
		end
		if context.forcetrigger then
			return {
				dollars = card.ability.extra.dollars,
				card = context.other_card,
			}
		end
	end
}

SMODS.Joker {
	key = 'soy_sauce',
	loc_txt = {
		name = 'Soy Sauce',
		text = {
			"Played {C:attention}Spades{} have a {C:green}#1# in #2#{} chance",
			"to give {C:attention}+#3# Hand Size{} for this round",
			"if you currently have {C:attention}more{} {C:mult}Mult{} {C:attention}than{} {C:chips}Chips{}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { odds = 5, handsize = 1 } },
	pos = { x = 2, y = 8 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.handsize }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if to_big(chips) < to_big(mult) then
				if context.other_card:is_suit('Spades') then
					if pseudorandom('may_soy_sauce') < G.GAME.probabilities.normal / card.ability.extra.odds then
						G.hand:change_size(card.ability.extra.handsize)
						G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.handsize
						return {
							message = '+'..card.ability.extra.handsize..' Hand Size'
						}
					end
				end
			end
		end
		if context.forcetrigger then
			G.hand:change_size(card.ability.extra.handsize)
			G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.handsize
			return {
				message = '+'..card.ability.extra.handsize..' Hand Size'
			}
		end
	end
}

SMODS.Joker {
	key = 'pesto',
	loc_txt = {
		name = 'Pesto',
		text = {
			"Played {C:attention}Clubs{} have a {C:green}#1# in #2#{} chance",
			"to give {C:attention}+#3# Card Selection Limit{}",
			"if {C:attention}Hand Size{} is {C:attention}bigger{} than {X:attention,C:white}X#4#{} {C:attention}Card Selection Limit{}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { odds = 6, selectionlimit = 1, multiplier = 0.5 } },
	pos = { x = 5, y = 8 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.selectionlimit, card.ability.extra.multiplier }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if G.hand.config.card_limit > G.hand.config.highlighted_limit * card.ability.extra.multiplier then
				if context.other_card:is_suit('Clubs') then
					if pseudorandom('may_pesto') < G.GAME.probabilities.normal / card.ability.extra.odds then
						G.hand:change_max_highlight(card.ability.extra.selectionlimit)
						return {
							message = '+'..card.ability.extra.selectionlimit..' Card Selection Limit'
						}
					end
				end
			end
		end
		if context.forcetrigger then
			G.hand:change_max_highlight(card.ability.extra.selectionlimit)
			return {
				message = '+'..card.ability.extra.selectionlimit..' Card Selection Limit'
			}
		end
	end
}

if may.conf.Mode == 1 then

SMODS.Joker {
	key = 'hurley',
	loc_txt = {
		name = 'Hurley',
		text = {
			"Scoring {C:attention}10s{} have a",
			"{C:green}#2# in #3#{} chance to give {C:money}#1#${}",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,E:1,s:0.5}concept by therealten95{}"
    }
  },
	config = { extra = { dollars = 10, odds = 5 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 7 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then
				if pseudorandom('may_hurley') < G.GAME.probabilities.normal / card.ability.extra.odds then	
					return {
						card = context.other_card,
						dollars = card.ability.extra.dollars,
					}
				end
			end
		end
		if context.forcetrigger then
			return {
				card = context.other_card,
				dollars = card.ability.extra.dollars,
			}
		end
	end
}

else

SMODS.Joker {
	key = 'hurley',
	loc_txt = {
		name = 'Hurley',
		text = {
			"Scoring {C:attention}10s{} have a",
			"{C:green}#2# in #3#{} chance to give {C:money}#1#${}",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,E:1,s:0.5}concept by therealten95{}"
    }
  },
	config = { extra = { dollars = 100, odds = 10 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 7 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then
				if pseudorandom('may_hurley') < G.GAME.probabilities.normal / card.ability.extra.odds then	
					return {
						card = context.other_card,
						dollars = card.ability.extra.dollars,
					}
				end
			end
		end
		if context.forcetrigger then
			return {
				card = context.other_card,
				dollars = card.ability.extra.dollars,
			}
		end
	end
}

end

if may.conf.content.WIP then
SMODS.Joker {
	key = 'bag_of_fortune',
	loc_txt = {
    name = 'Bag of Fortune',
    text = {
			"When {C:attention}hand{} is {C:attention}played{},",
			"create a {C:attention}random Tag{}"
		}
	},
	rarity = 3,
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 0 },
	cost = 6,
	misc_badge = may_wip_badge,
	calculate = function(self, card, context)
		if context.joker_main then
			local tag_key
			repeat
				tag_key = get_next_tag_key("may_bag_of_fortune")
			until tag_key ~= "tag_boss"
			local tag = Tag(tag_key)
			if #SMODS.find_mod('Cryptid') ~= 0 then
				tag.ability.shiny = Cryptid.is_shiny()
			end
			if tag.name == "Orbital Tag" then
				local _poker_hands = {}
				for k, v in pairs(G.GAME.hands) do
					if v.visible then
						_poker_hands[#_poker_hands + 1] = k
					end
				end
				tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("may_bag_of_fortune"))
			end
			add_tag(tag)
		end
		if context.force_trigger then
			local tag_key
			repeat
				tag_key = get_next_tag_key("may_bag_of_fortune")
			until tag_key ~= "tag_boss"
			local tag = Tag(tag_key)
			if #SMODS.find_mod('Cryptid') ~= 0 then
				tag.ability.shiny = Cryptid.is_shiny()
			end
			if tag.name == "Orbital Tag" then
				local _poker_hands = {}
				for k, v in pairs(G.GAME.hands) do
					if v.visible then
						_poker_hands[#_poker_hands + 1] = k
					end
				end
				tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("may_bag_of_fortune"))
			end
			add_tag(tag)
		end
	end
}
end

SMODS.Joker {
	key = 'ah_yes_the_store',
	loc_txt = {
		name = 'Ah yes, the store!',
		text = {
			"{C:attention}+#1# card slot{} in shop",
			"{C:attention}per{} redeemed {C:green}Voucher{}",
			"when obtained",
			"{C:inactive}Currently #2# slots{}",
			"{C:inactive,E:1,s:0.5}art by therealten95, idea by _TeKKen_{}"
		}
	},
	config = { extra = { slots = 1, total_slots = 0 } },
	rarity = 3,
	atlas = 'temp_store',
	pos = { x = 0, y = 0 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 7,
	loc_vars = function(self, info_queue, card)
		if G.vouchers then
			return { vars = { card.ability.extra.slots, (#G.vouchers.cards or {}) * card.ability.extra.slots } }
		else
			return { vars = { card.ability.extra.slots, 0 } }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound('may_ah_yes_the_store')
			card.ability.extra.total_slots = (#G.vouchers.cards or {})
			change_shop_size(card.ability.extra.total_slots * card.ability.extra.slots)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		change_shop_size(-(card.ability.extra.total_slots * card.ability.extra.slots))
	end,

	calculate = function(self, card, context)
		if context.forcetrigger then
			change_shop_size(card.ability.extra.slots)
		end
	end
}
	
	-- Legendary
	
local BA_messages = {
	"What's with these homies dissing my girl?",
	"Where i come from is a piece of crap",
	"Why do they gotta front?",
	"but it weer :blue_heart:",
	"What did we ever do to these guys",
	"That made them so violent?",
	"In the mini-mall",
	"5 Pcs. Tweezer Set",
	"It's a crying shame I'm all alone",
	"Why bother?",
	"This happened to be twice before"
}
	
SMODS.Joker {
	key = 'blue_album',
	loc_txt = {
    name = 'Blue Album',
    text = {
			"This joker {C:attention}gains{} {X:mult,C:white}^#1#{} Mult", 
			"if hand is played while {C:attention}Joker Slots{}",
			"are {C:mult}not fully occupied{}",
			"{C:inactive}Currently {X:mult,C:white}^#2#{} Mult",
			"{C:inactive,E:1,s:0.5}#3#{}",
			"{C:inactive,E:1,s:0.5}original concept by hellory4n{}"
		}
	},
	config = { extra = { Emult_gain = 0.01, Emult = 1 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 6 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult, BA_messages[math.random(#BA_messages)] } }
   end,
   add_to_deck = function(self, card, from_debuff)
		if (not from_debuff) and may.conf.JokerEffects then
			play_sound("may_weezer")
		end
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
				return {
					card = card,
					message = "Upgraded!",
					colour = G.C.MULT
				}
			end
		end
		if context.joker_main and card.ability.extra.Emult > 1 then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = "What's with these homies dissing my ^"..card.ability.extra.Emult.." Mult",
				card = card,
				colour = G.C.RED,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(1.5, 1.5)
					play_sound('may_weezer')
				return true end}))		
			}
		end
		if context.forcetrigger then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				card = card,
				message = "Upgraded!",
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'cacophonous',
	loc_txt = {
    name = 'Cacophonous',
    text = {
			"{X:mult,C:white}X#1#{} Mult for {C:attention}every owned Joker{}",
			"{C:attention}Increases by {X:mult,C:white}#2#{} when a {C:attention}Joker is bought{}",
			"{C:inactive}{X:mult,C:white}X#3#{} {C:inactive}Mult in total{}"
		}
	},
	config = { extra = { Xmult = 0.5, Xmult_gain = 0.2,  } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 6 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, G.jokers and ((#(G.jokers.cards or {})*card.ability.extra.Xmult) + 1) or 0 } }
	end,
	calculate = function(self, card, context) 
		if context.joker_main and (card.ability.extra.Xmult*#G.jokers.cards) + 1 > 1 then
			return {
				Xmult_mod = ((card.ability.extra.Xmult*#G.jokers.cards)+1),
				message = "X"..((card.ability.extra.Xmult*#G.jokers.cards)+1).." Mult",
				card = card,
				colour = G.C.RED,		
			}
		end
		if context.buying_card and context.card.ability.set == 'Joker' then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = "Upgraded!",
				card = card,
				colour = G.C.RED,		
			}
		end
		if context.forcetrigger then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = "Upgraded!",
				card = card,
				colour = G.C.RED,		
			}
		end
	end
}

if may.conf.Mode == 1 then

SMODS.Joker {
	key = '3d_joker',
	loc_txt = {
		name = '3D Joker',
		text = {
			"Played {C:attention}3s{} give {X:mult,C:white}^#1#{} Mult",
		}
	},
	config = { extra = { Emult = 1.13 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 4, y = 7 },
	cost = 33,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 3 then
				return {
					e_mult = card.ability.extra.Emult,
					colour = G.C.RED,
					card = context.other_card,	
				}
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.RED,
				card = context.other_card,	
			}
		end
	end
}

else

SMODS.Joker {
	key = '3d_joker',
	loc_txt = {
		name = '3D Joker',
		text = {
			"Played {C:attention}3s{} give {X:mult,C:white}^#1#{} Mult",
		}
	},
	config = { extra = { Emult = 1.3 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 4, y = 7 },
	cost = 33,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 3 then
				return {
					e_mult = card.ability.extra.Emult,
					colour = G.C.RED,
					card = context.other_card,
				}
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.RED,
				card = context.other_card,	
			}
		end
	end
}

end

SMODS.Joker {
	key = 'mr_nacho',
	loc_txt = {
		name = 'Mr. Nacho',
		text = {
			"Other {C:attention}Food Jokers{} give {X:money,C:white}X#1#${}",
		}
	},
	config = { extra = { Xdollars = 1.5 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 1, y = 13 },
	soul_pos = { x = 2, y = 13 },
	pools = { Food = true },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xdollars } }
	end,
	calculate = function(self, card, context)
		if context.other_joker and may.is_food(context.other_joker) and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "X"..card.ability.extra.Xdollars.."$",
				xdollars_mod = card.ability.extra.Xdollars,
				card = context.other_joker,
				colour = G.C.MONEY
			}
		end
		if context.forcetrigger then
			return {
				message = "X"..card.ability.extra.Xdollars.."$",
				xdollars_mod = card.ability.extra.Xdollars,
				card = card,
				colour = G.C.MONEY
			}
		end
	end
}

end

-- Cryptid please switch to smods quantum enhancements already i dont care about the lag
may.vanilla_enhancements = {
	'm_bonus',
	'm_mult',
	'm_wild',
	'm_glass',
	'm_steel',
	'm_stone',
	'm_gold',
	'm_lucky'
}

--[[if #SMODS.find_mod('Cryptid') == 0 and may.conf.content.WIP then
SMODS.Joker {
	key = "multiversum",
	loc_txt = {
		name = 'Multiversum',
		text = {
			"All {C:green}Vanilla{} {C:attention}enhancements{} count as {C:attention}every other{}",
			"{C:green}Vanilla{} {C:attention}enhancement{}",
		}
	},
	pos = { x = 0, y = 0 },
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	demicoloncompat = false,
	atlas = "placeholder",
	calculate = function(self, card, context)
		if context.check_enhancement then
			if table_hasvalue(may.vanilla_enhancements, context.other_card.config.center.key) then
				return { m_bonus = true, m_mult = true, m_wild = true, m_mult = true, m_glass = true, m_steel = true, m_stone = true, m_gold = true, m_lucky = true }
			end
		end
	end
}
end]]

-- Mystery

if may.conf.content.FusionJokers then

local UC_messages = {
	"I don't feel safe around this thing...",
	"Are you sure this is a good idea?",
	"I dont like where this is going.",
	"Who am I you ask? ERROR:(undefined string, author was too lazy to create lore)",
	"I feel funny...",
	"How did we get here?",
	"Is this thing really that important to you?",
	"Why am I saying strange things? I thought this mod has no lore!",
	"I am self aware, I just like not to think about it.",
	"This thing's making me hear colors!",
	"JIMCO CORPORATE: YOUR ADVERTISEMENT COULD BE HERE, CALL 375943573485 NOW!",
	"Maybe the Wheel of Fortune will work next time",
	"I AM OMINOUS. PLEASE BE SCARED",
	"Nice face cards you got there, gonna summon The Plant just for you!",
	"Fun fact this mod was originally called dddddddddddddddddddddddddddddd (citation needed)",
	"I dare you to use Macrocosm. I've got Ceaseless Void ready!"
}

SMODS.Joker {
	key = 'universal_collapse',
	loc_txt = {
		name = 'Universal Collapse',
		text = {
			"{C:attention}Gains{} {X:mult,C:white}^#1#{} Mult when a {C:attention}Joker{} is {C:attention}sold{}",
			"{C:inactive}Currently {X:mult,C:white}^#2#{}{C:inactive} Mult{}",
			may.add_fusion_text('many Jokers'),
			"{C:inactive,E:1,s:0.5}#3#{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult, UC_messages[math.random(#UC_messages)] } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
		play_sound("may_universal_collapse", 1, 2)
		end
	end,
	config = { extra = { Emult_gain = 0.1, Emult = 1 } },
	rarity = 'may_mystery',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 4 },
	cost = 100,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Emult > 1 then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = '^'.. card.ability.extra.Emult .. ' Mult',
				colour = G.C.RED,
				card = card,			
			}
		end
		if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
		end
		if context.forcetrigger then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}

	-- Mythic

-- Needs a better recipe, fusions with legendaries are absurd
--[[SMODS.Joker {
	key = 'patriarch',
	loc_txt = {
		name = 'Patriarch',
		text = {
			"Played {C:attention}face cards{}",
			"give {X:mult,C:white}^#1#{} Mult",
			"{C:inactive}Triboulet + Baron{}"
		}
	},
	config = { extra = { Emult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult} }
	end,
	rarity = 'may_mythic',
	atlas = 'placeholder',
	blueprint_compat = true,
	pos = { x = 0, y = 0 },
	cost = 100,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_face() then
				return {
					e_mult = card.ability.extra.Emult,
					colour = G.C.RED,
					card = context.other_card,	
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(.5, .5)
					return true end }))	
				}
			end
		end
	end
}]]

SMODS.Joker {
	key = 'diskus',
	loc_txt = {
    name = 'Diskus',
    text = {
		"When {C:attention}Blind{} is {C:attention}selected{},",
		"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
		"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:mult,C:white}^#2#{} Mult",
		"When {C:attention}a playing card{} is triggered, create {C:attention}#3#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
		may.add_fusion_text('Collectionist'),
		"{C:inactive,s:0.5}man + Wheel of Eternity{}"
		}
	},
	rarity = 'may_mythic',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 100,
	config = { extra = { blindcards = 10, Emult = 4, cards = 2, } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.blindcards, card.ability.extra.Emult, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
					if Incantation then
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:setQty(card.ability.extra.cards)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					else
						for i=1, card.ability.extra.cards, 1 do
							local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
							G.consumeables:emplace(wheel)
							wheel:add_to_deck()
							wheel:set_edition({negative = true}, false, false)
						end
					end
			return true end}))
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.MULT,
				card = context.other_joker
			}
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
	end
}

if may.conf.content.WIP then

SMODS.Joker {
	key = 'jerrys_bait_shop',
	loc_txt = {
		name = "Jerry's Bait Shop",
		text = {
			"{X:chips,C:white}X#1#{} Chips, earn {C:money}$#2#{} when opening a {C:attention}Booster Pack{}",
			"{C:attention}earned money increases{} by {C:money}$#3#{} every {C:attention}2 skipped Booster Packs{}",
			"When {C:attention}earned money{} reaches {C:money}$25{}, create an {C:dark_edition}Universal Collapse{} joker",
			"{C:inactive}(#4#, must have room, only works once){}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { Xchips = 7.5, dollars = 5, dollars_gain = 5, canupgrade = false, canspawn = true} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips, card.ability.extra.dollars, card.ability.extra.dollars_gain, 
		card.ability.extra.canupgrade and 'Active' or 'Inactive'} }
	end,
	rarity = 'may_mythic',
	misc_badge = may_wip_badge,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 10 },
	soul_pos = { x = 1, y = 10 },
	cost = 100,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xchip_mod = card.ability.extra.Xchips,
				card = card,
				message = 'X'..card.ability.extra.Xchips..' Chips',
				colour = G.C.CHIPS
			}
		end
		if context.open_booster and context.cardarea == G.jokers then
			return {
				dollars = card.ability.extra.dollars,
				card = card,
				message = '+'..card.ability.extra.dollars..'$',
				colour = G.C.MONEY
			}
		end
		if context.skipping_booster and context.cardarea == G.jokers then
			card.ability.extra.canupgrade = not card.ability.extra.canupgrade
			if card.ability.extra.canupgrade then
				card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
				if to_big(card.ability.extra.dollars) >= to_big(25) then
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.config.canspawn then
						G.E_MANAGER:add_event(Event({func = function()
							local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_jerrys_bait_shop')
							G.jokers:emplace(card2)
							card2:add_to_deck()
							play_sound("may_thunder"..math.random(1,2))
						return true end}))
						G.E_MANAGER:add_event(Event({func = function()
							card.config.canspawn = false
						return true end}))
					end
				return {
					message = 'Upgraded!',
					colour = G.C.MONEY
				}
				end
			end
		end
		if context.forcetrigger then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.config.canspawn then
				G.E_MANAGER:add_event(Event({func = function()
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_jerrys_bait_shop')
					G.jokers:emplace(card2)
					card2:add_to_deck()
					play_sound("may_thunder"..math.random(1,2))
				return true end}))
				G.E_MANAGER:add_event(Event({func = function()
					card.config.canspawn = false
				return true end}))
			end
		end
	end
}

end

	-- Transcendent

SMODS.Joker {
	key = 'little_prince',
	loc_txt = {
		name = 'Little Prince',
		text = {
			"This Joker {C:attention}gains{} {X:mult,C:white}^^#2#{} Mult{}", 
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Curerntly {X:mult,C:white}^^#1#{}{C:inactive} Mult{}",
			"{C:inactive,s:0.5}Universal Collapse + Royale{}"
		}
	},
	config = { extra = { EEmult = 1, EEmult_gain = 0.1 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 2 },
	soul_pos = { x = 1, y = 2 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.EEmult, card.ability.extra.EEmult_gain } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.EEmult > 1 then
			return {
				EEmult_mod = card.ability.extra.EEmult,
				card = card,
				message = '^^'..card.ability.extra.EEmult..' Mult',
				colour = G.C.MULT,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end }))				
			}
		end
		if context.before and next(context.poker_hands['may_Royal Flush']) and not context.blueprint then
			card.ability.extra.EEmult = card.ability.extra.EEmult + card.ability.extra.EEmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEmult = card.ability.extra.EEmult + card.ability.extra.EEmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

if may.conf.Mode == 2 then
SMODS.Joker {
	key = 'party_time',
	loc_txt = {
	name = 'Party Time',
	text = {
		"After hand is played, {C:green}#1# in #2#{}",
		"chance to {C:attention}increase{} {C:dark_edition}score operator{} level",
		"by {C:attention}#3#{}",
		"{X:attention,C:white}X#4#{} blind size",
		"{C:inactive,s:0.5}Daredevil + Universal Collapse{}"
		}
	},
	config = { extra = { odds = 15, mod = 1, blindmult = 200 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 3 },
	soul_pos = { x = 2, y = 3 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_blind_size(0, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_blind_size(-3, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.jokers then
			if pseudorandom('may_party_time') < G.GAME.probabilities.normal / card.ability.extra.odds then
				mod_score_operator(-1, card.ability.extra.mod)
				return {
					message = 'Upgraded!',
					card = card
				}
			end
		end
		if context.forcetrigger then
			mod_score_operator(-1, card.ability.extra.mod)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
	end
}
end

SMODS.Joker {
	key = 'ultimate_hurley',
	loc_txt = {
		name = 'Ultimate Hurley',
		text = {
			"Scoring {C:attention}10s{} give {X:money,C:white}X#1#${}",
			"{C:inactive,s:0.5}Universal Collapse + Hurley{}",
			"{C:inactive,E:1,s:0.5}concept by therealten95{}",
		}
	},
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 8 },
	soul_pos = { x = 1, y = 8 },
	cost = 1000,
	config = { extra = { xmoney = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmoney } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then	
				return {
					message = 'X'..card.ability.extra.xmoney..'$',
					colour = G.C.MONEY,
					card = context.other_card,
					x_dollars = card.ability.extra.xmoney
				}
			end
		end
		if context.forcetrigger then
			return {
				message = 'X'..card.ability.extra.xmoney..'$',
				colour = G.C.MONEY,
				card = card,
				x_dollars = card.ability.extra.xmoney
			}
		end
	end
}

--[[SMODS.Joker {
	key = 'score_test1',
	loc_txt = {
		name = 'Score Test 1',
		text = {
			"{C:may_score}+10000{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				SCORE_mod = 10000
			}
		end
	end
}

SMODS.Joker {
	key = 'score_test2',
	loc_txt = {
		name = 'Score Test 2',
		text = {
			"{X:may_score,C:white}X300{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				XSCORE_mod = 300
			}
		end
	end
}


SMODS.Joker {
	key = 'score_test3',
	loc_txt = {
		name = 'Score Test 3',
		text = {
			"{X:may_score,C:white}^50{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				ESCORE_mod = 50
			}
		end
	end
}

SMODS.Joker {
	key = 'score_test4',
	loc_txt = {
		name = 'Score Test 4',
		text = {
			"{X:may_score,C:white}^^20{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				EESCORE_mod = 20
			}
		end
	end
}

SMODS.Joker {
	key = 'score_test5',
	loc_txt = {
		name = 'Score Test 5',
		text = {
			"{X:may_score,C:white}^^^10{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				EEESCORE_mod = 10
			}
		end
	end
}

SMODS.Joker {
	key = 'score_test6',
	loc_txt = {
		name = 'Score Test 6',
		text = {
			"{X:may_score,C:white}^^^^5{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				hyper_score = {4, 5}
			}
		end
	end
}

SMODS.Joker {
	key = 'score_test7',
	loc_txt = {
		name = 'Score Test 7',
		text = {
			"{X:may_score,C:white}^^^^^^^50000{} Score"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.after then
			return {
				hyper_score = {7, 50000}
			}
		end
	end
}

SMODS.Joker {
	key = 'factorial_test',
	loc_txt = {
		name = 'Factorial Test 1',
		text = {
			"{X:mult,C:white}Mult!{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				FACTmult_mod = 1
			}
		end
	end
}

SMODS.Joker {
	key = 'factorial_test2',
	loc_txt = {
		name = 'Factorial Test 2',
		text = {
			"{X:mult,C:white}Mult!!!!!!!!{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				FACTmult_mod = 8
			}
		end
	end
}

SMODS.Joker {
	key = 'factorial_test3',
	loc_txt = {
		name = 'Factorial Test 3',
		text = {
			"{X:chips,C:white}Chips!(30){},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				FACTchip_mod = 30
			}
		end
	end
}

SMODS.Joker {
	key = 'expofactorial_test',
	loc_txt = {
		name = 'Exponential Factorial Test 1',
		text = {
			"{X:mult,C:white}Mult^!{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				EXPOFACTmult_mod = 1
			}
		end
	end
}

SMODS.Joker {
	key = 'expofactorial_test2',
	loc_txt = {
		name = 'Exponential Factorial Test 2',
		text = {
			"{X:chips,C:white}Chips^!(10){},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				EXPOFACTchip_mod = 10
			}
		end
	end
}

SMODS.Joker {
	key = 'aperiotion_test1',
	loc_txt = {
		name = 'Aperiotion Test 1',
		text = {
			"{X:mult,C:white}#1#{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return {vars = { '{Mult, 5}' } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				APEmult_mod = 5
			}
		end
	end
}

SMODS.Joker {
	key = 'aperiotion_test2',
	loc_txt = {
		name = 'Aperiotion Test 2',
		text = {
			"{X:chips,C:white}#1#{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return {vars = { '{Chips, 100}' } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				APEchip_mod = 100
			}
		end
	end
}]]

SMODS.Joker {
	key = 'acum',
	loc_txt = {
		name = 'Acum',
		text = {
			"{C:attention}After hand{} is played, create a {C:dark_edition}Negative{}",
			"{C:attention}Grim{} card",
			"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
			"and give {X:mult,C:white}^#2#{} Mult",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,s:0.5}Universal Collapse + AAAA{}"
		}
	},
	config = { extra = { repetitions = 4, e_mult = 11 } },
	rarity = "may_transcendent",
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	pos = { x = 5, y = 5 },
	soul_pos = { x = 0, y = 6 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_grim
		return { vars = { card.ability.extra.repetitions, card.ability.extra.e_mult } }
	end,
	calculate = function(self, card, context)
		if (context.cardarea == G.play and context.repetition) or (context.blueprint and context.cardarea == G.play and context.repetition) and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(.5, .5)
					return true end }))	
		  
				}
			end
		end
		if context.after or (context.blueprint and context.after) then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				card:juice_up(1,1)
				local grim = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_grim', nil)
				grim.no_forced_edition = true
				grim:set_edition({negative = true})
				grim.no_forced_edition = nil
				grim:setQty(1)
				grim:set_cost()
				grim:add_to_deck()
				G.consumeables:emplace(grim)
			return true end}))
		end
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if context.other_card:get_id() == 14 then	
				return {
					e_mult = card.ability.extra.e_mult,
					card = context.other_card,
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				card:juice_up(1,1)
				local grim = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_grim', nil)
				grim.no_forced_edition = true
				grim:set_edition({negative = true})
				grim.no_forced_edition = nil
				grim:setQty(1)
				grim:set_cost()
				grim:add_to_deck()
				G.consumeables:emplace(grim)
			return true end}))
		end
	end
}

if may.conf.Mode == 1 then

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = 'Storm',
		text = {
			"This Joker {C:attention}gains{} {X:chips,C:white}^^#1#{} Chips",
			"when a {C:planet}Planet{} Card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}",
			may.add_fusion_text('Universal Collapse or Cosmos'),
			"{C:inactive,s:0.5}Universal Collapse + Destroyer{}"
		}
	},
	config = { extra = {EEchip_gain = 0.01, EEchip = 1} },
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4 },
	cost = 1000,
	rarity = 'may_transcendent',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEchip_gain, card.ability.extra.EEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			if not context.card.ability.qty then
				card.ability.extra.EEchip = card.ability.extra.EEchip + card.ability.extra.EEchip_gain
			else
				card.ability.extra.EEchip = card.ability.extra.EEchip + (card.ability.extra.EEchip_gain * context.card.ability.qty)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
		if context.joker_main and card.ability.extra.EEchip > 1 then
			return {
				EEchip_mod = card.ability.extra.EEchip,
				card = card,
				message = '^^'..card.ability.extra.EEchip..' Chips',
				colour = G.C.CHIPS,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end}))				
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEchip = card.ability.extra.EEchip + card.ability.extra.EEchip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
	end
}

else

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = 'Storm',
		text = {
			"This Joker {C:attention}gains{} {X:chips,C:white}^^#1#{} Chips",
			"when a {C:planet}Planet{} Card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}",
			may.add_fusion_text('Universal Collapse or Cosmos'),
			"{C:inactive,s:0.5}Universal Collapse + Destroyer{}"
		}
	},
	config = { extra = {EEchip_gain = 0.1, EEchip = 1} },
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4 },
	cost = 1000,
	rarity = 'may_transcendent',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEchip_gain, card.ability.extra.EEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			if not context.card.ability.qty then
				card.ability.extra.EEchip = card.ability.extra.EEchip + card.ability.extra.EEchip_gain
			else
				card.ability.extra.EEchip = card.ability.extra.EEchip + (card.ability.extra.EEchip_gain * context.card.ability.qty)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
		if context.joker_main and card.ability.extra.EEchip > 1 then
			return {
				EEchip_mod = card.ability.extra.EEchip,
				card = card,
				message = '^^'..card.ability.extra.EEchip..' Chips',
				colour = G.C.CHIPS,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end}))				
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEchip = card.ability.extra.EEchip + card.ability.extra.EEchip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
	end
}

end
--[[ SMODS.Joker {
	key = 'jonkler',
	loc_txt = {
		name = 'Why so serious?',
		text = {
		"{C:mult,s:3}^^^^#1# Mult{}",
		"{C:mult}+#2# Antes{} when hand is played"
		}
	},
	config = { extra = {hexmult = 2, antes = 5} },
	pos = { x = 8, y = 2 },
	cost = 2626,
	rarity = 'may_transcendent',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'joker1',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hexmult, card.ability.extra.antes}}
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			ease_ante(5)
			return {
				message = 'We live in a society. (^^^^2 mult, +5 Antes)',
				HEXmult_mod = card.ability.extra.hexmult,
				colour = G.C.BLACK,
				card = card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(3, 6)
				return true end }))	
				}
		end
	end
} ]]

SMODS.Joker {
	key = 'cosmos',
	loc_txt = {
		name = 'Cosmos',
		text = {
			"When hand is played, {C:attention}before scoring{},",
			"{C:attention}gains half{} of the {C:planet}level{} of played Poker Hand",
			"as {X:mult,C:white}^Mult{}",
			"{C:inactive}Currently {X:mult,C:white}^#1#{} Mult{}",
			may.add_fusion_text('Storm'),
			"{C:inactive,s:0.5}Universal Collapse + Nebula{}"
		}
	},
	config = { extra = { Emult = 1 } },
	pos = { x = 5, y = 6 },
	soul_pos = { x = 0, y = 7 },
	cost = 1000,
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Emult}}
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.Emult = card.ability.extra.Emult + (G.GAME.hands[context.scoring_name].level / 2)
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
		if context.joker_main then
			return {
				Emult_mod = to_big(card.ability.extra.Emult),
				card = card,
				message = '^'.. card.ability.extra.Emult .. ' Mult',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.Emult = card.ability.extra.Emult + (G.GAME.hands[context.scoring_name].level / 2)
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'santa',
	loc_txt = {
		name = "Santa",
		text = {
			"This joker creates a {C:attention}random{} {C:dark_edition}Negative{} {X:mult,C:white}Rare{} Joker",
			"if played hand contains a {C:attention}Pair{}",
			"{X:mult,C:white}^#2#{} Mult",
			"{C:inactive,s:0.5}Universal Collapse + Jolly Joker{}"
    }
  },
	config = { extra = { consumables = 8, Emult = 88 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 1, y = 6 },
	soul_pos = { x = 5, y = 3 },
	cost = 8888,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_st_bells")
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.consumables, card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Pair']) or (context.blueprint and context.before and next(context.poker_hands['Pair']))then
			play_sound("holo1")
			local card = create_card("Joker", G.jokers, nil, 3, nil, nil, nil, "may_santa")
			card:set_edition({negative = true}, true, true)
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				card:juice_up(1, 1)
				play_sound('may_st_hohoho')
			return true end}))	
		end
		if context.joker_main then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = '^'.. card.ability.extra.Emult .. ' Mult',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			play_sound("holo1")
			local card = create_card("Joker", G.jokers, nil, 3, nil, nil, nil, "may_santa")
			card:set_edition({negative = true}, true, true)
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				card:juice_up(1, 1)
			return true end}))	
		end
	end
}

SMODS.Joker {
	key = 'diskus_kollectum',
	loc_txt = {
    name = 'Diskus Kollectum',
    text = {
			"When {C:attention}Blind{} is {C:attention}selected{},",
			"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} {C:attention}cards{}",
			"{C:attention}Increases{} by {C:attention}#2#{} when {C:attention}hand{} is {C:attention}played{}",
			"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:purple,C:white}^#3#{} Mult & Chips",
			may.add_fusion_text('Collector\'s Edition'),
			"{C:inactive,s:0.5}Diskus + Collectionist{}"
		}
	},
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 12 },
	soul_pos = { x = 0, y = 13 },
	cost = 1000,
	config = { extra = { blindcards = 20, cards_gain = 5, Emultchips = 144, } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { card.ability.extra.blindcards, card.ability.extra.cards_gain, card.ability.extra.Emultchips } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.blindcards = card.ability.extra.blindcards + card.ability.extra.cards_gain
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "^"..card.ability.extra.Emultchips.." Mult & Chips",
				Emult_mod = card.ability.extra.Emultchips,
				Echip_mod = card.ability.extra.Emultchips,
				colour = G.C.PURPLE,
				card = context.other_joker,
				sound = 'may_eboth'
			}
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
	end
}

	-- Surreal

SMODS.Joker {
	key = 'ad_infinitum',
	loc_txt = {
		name = 'Ad Infinitum',
		text = {
			"Retriggers {C:attention}first and last{} played {C:attention}cards #1#{} times",
			"Additional {C:attention}#2# retriggers per card in played hand{}",
			"{C:inactive,E:1,s:0.5}concept and original art by _TeKKen_{}",
		}
	},
	config = { extra = { base_retrigger = 30, retrigger_bonus = 5 } },
	pos = { x = 1, y = 11 },
	soul_pos = { x = 3, y = 11, extra = { x = 2, y = 11 } },
	cost = 5000,
	rarity = 'may_surreal',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.base_retrigger, card.ability.extra.retrigger_bonus }}
    end,
    calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				if context.other_card and (context.other_card == (context.scoring_hand or {})[1]) or (context.other_card == (context.scoring_hand or {})[#context.scoring_hand]) then
					if table_hasvalue(G.play.cards, context.other_card) then
						return {
							message = 'Again!',
							repetitions = card.ability.extra.base_retrigger + (#G.play.cards * card.ability.extra.retrigger_bonus),
							card = context.other_card,
						}
					end
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'universalis',
	loc_txt = {
		name = 'UNIVERSALIS',
		text = {
			"{C:attention}Retrigger adjacent Jokers{} once for {C:attention}every{}",
			"held {C:planet}Planet{} card",
			"{C:inactive}(Currently #1# retriggers){}"
		}
	},
	pos = { x = 0, y = 15 },
	soul_pos = { x = 2, y = 15, extra = { x = 1, y = 15 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { retrigger = 0 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.retrigger } }
    end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			local joker1
			local joker2
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						joker1 = G.jokers.cards[i - 1]
					end
					if i < #G.jokers.cards then
						joker2 = G.jokers.cards[i + 1]
					end
				end
			end
			if context.other_card == joker1 or context.other_card == joker2 then
				return {
					repetitions = card.ability.extra.retrigger,
					message = 'Again!',
					card = card,
				}
			end
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().set == 'Planet' then
					amount = amount + (v.ability.qty or 1)
				end
			end
			card.ability.extra.retrigger = amount
		end
	end
}

SMODS.Joker {
	key = 'ourania_kleidaria',
	loc_txt = {
		name = 'Ourania Kleidaria',
		text = {
			"{X:mult,C:white}^^^^#1#{} Mult against {C:attention}UltraBlinds{}"
		}
	},
	pos = { x = 0, y = 14 },
	soul_pos = { x = 1, y = 14, extra = { x = 2, y = 14 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { HEXmult = 2 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.HEXmult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.blind.config.blind.ultra or #SMODS.find_card('j_may_illusion') ~= 0 then
				return {
					hyper_mult = {4, card.ability.extra.HEXmult},
					message = '^^^^'..card.ability.extra.HEXmult..' Mult',
					colour = G.C.RED,
					card = card
				}
			end
		end
		if context.forcetrigger then
			return {
				hyper_mult = {4, card.ability.extra.HEXmult},
				message = '^^^^'..card.ability.extra.HEXmult..' Mult',
				colour = G.C.RED,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'decko_infinitorum',
	loc_txt = {
		name = 'Decko Infinitorum',
		text = {
			"When {C:mult}discarding{}, gain {C:mult}+#1# discards{}",
			"and {C:attention}+#2# temporary Hand Size{}"
		}
	},
	pos = { x = 0, y = 12 },
	soul_pos = { x = 1, y = 12, extra = { x = 2, y = 12 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { discards = 2, hand_size = 1 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.discards, card.ability.extra.hand_size } }
    end,
    calculate = function(self, card, context)
		if context.pre_discard and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				ease_discard(card.ability.extra.discards)
				G.hand:change_size(card.ability.extra.hand_size)
				G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.hand_size
			return true end}))		
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				ease_discard(card.ability.extra.discards)
				G.hand:change_size(card.ability.extra.hand_size)
				G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.hand_size
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'octum',
	loc_txt = {
		name = 'Octum',
		text = {
			"Played {C:attention}8s{} have a {C:green}#1# in #2#{} chance",
			"to give {X:chips,C:white}#3#{}"
		}
	},
	pos = { x = 3, y = 13 },
	soul_pos = { x = 4, y = 13, extra = { x = 5, y = 13 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { odds = 8 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_ape_tutorial", set = "Other", specific_vars = { '{a, b}', '{b}', '{Chips, 5}', '{5}' } }
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, '{Chips, 1}' } }
    end,
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 8 then
				if pseudorandom('may_octum') < G.GAME.probabilities.normal / card.ability.extra.odds then
					return {
						ape_chip = 1,
						card = context.other_card,
					}
				end
			end
		end
	end
}


SMODS.Joker {
	key = 'subdola',
	loc_txt = {
		name = 'Subdola',
		text = {
			"When {C:attention}Blind{} is {C:attention}selected{}, create a {C:attention}random{} {C:dark_edition}N{} {C:attention}Joker{} and {C:attention}#1# {C:dark_edition}Negative Sly Joker(s){}",
			"{C:attention}Increase{} amount of {C:dark_edition}Sly Jokers{} by {C:attention}#2#{} when an {C:dark_edition}N{} {C:attention}Joker{} is {C:attention}sold{}", 
			"{C:green}#3# in #4#{} chance to create a {C:attention}random{} {C:dark_edition}N{} {C:attention}Joker{} when {C:dark_edition}Sly Joker{} is {C:attention}sold{}", 
			"{C:attention}Retrigger{} all {C:dark_edition}Sly Jokers{} and {C:dark_edition}N{} {C:attention}Jokers{} if played hand is {C:attention}Three of a Kind{}",
			"{C:inactive}(Subdola excluded){}",
			"{C:inactive,E:1,s:0.5}concept by _TeKKen_{}",
		}
	},
	pos = { x = 3, y = 14 },
	soul_pos = { x = 5, y = 14, extra = { x = 4, y = 14 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { sly_jokers = 1, sly_jokers_gain = 1, odds = 4 } },
	unlocked = true,
	discovered = true,
	n_joker = true,
	pools = { N = true },
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
        return {vars = { card.ability.extra.sly_jokers, card.ability.extra.sly_jokers_gain, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
		if context.setting_blind then
			play_sound("holo1")
			local new_card = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_subdola")
			new_card:set_edition({negative = true}, true, true)
			new_card:add_to_deck()
			G.jokers:emplace(new_card)
			new_card:juice_up(0.3, 0.5)
			for i=1, to_number(card.ability.extra.sly_jokers), 1 do	
				local sly = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_sly', "may_subdola")
				sly:set_edition({negative = true}, true, true)
				sly:add_to_deck()
				G.jokers:emplace(sly)
				sly:juice_up(0.3, 0.5)
			end
		end
		if context.selling_card and not context.blueprint then
			if may.is_n(context.card) then
				card.ability.extra.sly_jokers = card.ability.extra.sly_jokers + card.ability.extra.sly_jokers_gain
				return {
					message = 'Upgraded!',
					card = card
				}
			elseif context.card.config.center.key == 'j_sly' then
				if pseudorandom('may_subdola') < G.GAME.probabilities.normal / card.ability.extra.odds then
					play_sound("holo1")
					local new_card = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_subdola")
					new_card:set_edition({negative = true}, true, true)
					new_card:add_to_deck()
					G.jokers:emplace(new_card)
					new_card:juice_up(0.3, 0.5)
				end
			end
		end
		if context.retrigger_joker_check and 
		not context.retrigger_joker and 
		context.other_card ~= self and 
		context.other_card ~= card and 
		(may.is_n(context.other_card) or context.other_card.config.center.key == 'j_sly') and
		G.GAME.current_round.current_hand.handname == "Three of a Kind"
		then
			return {
				message = 'Again!',
				card = card,
				repetitions = 1
			}
		end
		if context.forcetrigger then
			play_sound("holo1")
			local new_card = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_subdola")
			new_card:set_edition({negative = true}, true, true)
			new_card:add_to_deck()
			G.jokers:emplace(new_card)
			new_card:juice_up(0.3, 0.5)
			for i=1, to_number(card.ability.extra.sly_jokers), 1 do	
				local sly = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_sly', "may_subdola")
				sly:set_edition({negative = true}, true, true)
				sly:add_to_deck()
				G.jokers:emplace(sly)
				sly:juice_up(0.3, 0.5)
			end
		end
	end
}

SMODS.Joker {
	key = 'notatos',
	loc_txt = {
		name = 'Notatos',
		text = {
			"{X:may_score,C:white}^^#1#{} Score",
			"{C:attention}Increases by base{} {C:mult}Mult{} before scoring"
		}
	},
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { EESCORE = 1 } },
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.EESCORE, } }
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.EESCORE = card.ability.extra.EESCORE + mult
			return {
				message = 'Upgraded!',
				colour = may.C.score,
				card = card,
			}
		end
		if context.after then
			return {
				EESCORE_mod = card.ability.extra.EESCORE,
				card = card,
			}
		end
		if context.forcetrigger then
			return {
				EESCORE_mod = card.ability.extra.EESCORE,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'sexangulae_quattor',
	loc_txt = {
		name = 'Sexangulae Quattor',
		text = {
			"Played {C:attention}4s{} are {C:attention}retriggered #1#{} times",
			"and give {X:chips,C:white}Chips!(#2#){}",
			"Played cards that are {C:mult}not{} {C:attention}4s{} get",
			"{C:mult}destroyed{} and give {X:attention,C:white}^^#3#{} Blind Size before scoring",
		}
	},
	pos = { x = 5, y = 16 },
	soul_pos = { x = 1, y = 17, extra = { x = 0, y = 17 } },
	cost = 4444,
	rarity = 'may_surreal',
	config = { extra = { repetitions = 44, FACTchip = 44, EEblind_size = 4444,} },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	misc_badge = may_wip_badge,
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_nest_fact_tutorial", set = "Other" }
        return {vars = { card.ability.extra.repetitions, card.ability.extra.FACTchip, card.ability.extra.EEblind_size, } }
    end,
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card:get_id() == 4 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 4 then
				return {
					fact_chip = card.ability.extra.FACTchip,
					card = context.other_card
				}
			end
		end
		if context.before then
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in pairs(G.play.cards) do
					if v:get_id() ~= 4 then
						G.GAME.blind.chips = G.GAME.blind.chips:arrow(2, card.ability.extra.EEblind_size)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						play_sound('may_blind_size')
						v:start_dissolve()
					end
				end
			return true end}))
		end
		if context.forcetrigger then
			return {
				fact_chip = card.ability.extra.FACTchip,
				message = 'Chips!('..card.ability.extra.FACTchip..')',
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'fortuno',
	loc_txt = {
		name = "Fortuno",
		text = {
			"When {C:attenton}Blind{} is {C:attention}selected{},",
			"this Joker creates {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
			"for {C:attention}every Joker{} with an {C:dark_edition}Edition{}",
			"This Joker {C:attention}gains{} {X:purple,C:white}^^#2#{} Mult & Chips when using {C:purple}Wheel of Fortune{}",
			"{C:inactive}Currently{} {X:purple,C:white}^^#3#{} {C:inactive}Mult & Chips, will create #4# Wheel of Fortune cards{}",
		}
	},
	config = { extra = { cards = 5, EEmultchips_gain = 1.4, EEmultchips = 1, total_cards = 0 } },
	rarity = 'may_surreal',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 16 },
	soul_pos = { x = 4, y = 16, extra = { x = 3, y = 16 } },
	cost = 5000,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.cards, card.ability.extra.EEmultchips_gain, card.ability.extra.EEmultchips, card.ability.extra.total_cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and card.ability.extra.total_cards ~= 0 then
			G.E_MANAGER:add_event(Event({func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:setQty(card.ability.extra.total_cards)
						wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.total_cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
		if context.joker_main and card.ability.extra.EEmultchips ~= 1 then
			return {
				message = "^^"..card.ability.extra.EEmultchips.." Mult & Chips",
				colour = G.C.PURPLE,
				EEmult_mod = card.ability.extra.EEmultchips,
				EEchip_mod = card.ability.extra.EEmultchips,
				sound = 'may_eeboth',
			}
		end
		if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' and not context.blueprint then
			card.ability.extra.EEmultchips = card.ability.extra.EEmultchips + card.ability.extra.EEmultchips_gain
			return {
				message = 'Upgraded!',
				card = card,
				colour = G.C.PURPLE,
			}
		end
		if context.forcetrigger and card.ability.extra.total_cards ~= 0 then
			G.E_MANAGER:add_event(Event({func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:setQty(card.ability.extra.total_cards)
						wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.total_cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in pairs(G.jokers.cards) do
				if v.edition then
					amount = amount + card.ability.extra.cards
				end
			end
			card.ability.extra.total_cards = amount
		else
			card.ability.extra.total_cards = 0
		end
	end
}

	-- Interdimensional

if may.conf.Mode == 1 then

SMODS.Joker {
	key = 'world_destroyer',
	loc_txt = {
		name = 'World Destroyer',
		text = {
			"This Joker {C:attention}gains{} {X:chips,C:white}^^^#1#{} Chips",
			"when a {C:planet}Planet{} Card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^^#2#{} Chips{}",
			"{C:inactive,s:0.5}Universal Collapse + Destroyer{}"
		}
	},
	config = { extra = {EEEchip_gain = 0.005, EEEchip = 1} },
	pos = { x = 4, y = 15 },
	soul_pos = { x = 5, y = 15 },
	cost = 100000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEEchip_gain, card.ability.extra.EEEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			if not context.card.ability.qty then
				card.ability.extra.EEEchip = card.ability.extra.EEEchip + card.ability.extra.EEEchip_gain
			else
				card.ability.extra.EEEchip = card.ability.extra.EEEchip + (card.ability.extra.EEEchip_gain * context.card.ability.qty)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
		if context.joker_main and card.ability.extra.EEEchip > 1 then
			return {
				EEEchip_mod = card.ability.extra.EEEchip,
				card = card,
				message = '^^^'..card.ability.extra.EEEchip..' Chips',
				colour = G.C.CHIPS,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end}))				
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEEchip = card.ability.extra.EEEchip + card.ability.extra.EEEchip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
	end
}

else

SMODS.Joker {
	key = 'world_destroyer',
	loc_txt = {
		name = 'World Destroyer',
		text = {
			"This Joker {C:attention}gains{} {X:chips,C:white}^^^#1#{} Chips",
			"when a {C:planet}planet{} card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^^#2#{} Chips{}",
			"{C:inactive,s:0.5}Universal Collapse + Destroyer{}"
		}
	},
	config = { extra = {EEEchip_gain = 0.1, EEEchip = 1} },
	pos = { x = 4, y = 15 },
	soul_pos = { x = 5, y = 15 },
	cost = 100000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEEchip_gain, card.ability.extra.EEEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			if not context.card.ability.qty then
				card.ability.extra.EEEchip = card.ability.extra.EEEchip + card.ability.extra.EEEchip_gain
			else
				card.ability.extra.EEEchip = card.ability.extra.EEEchip + (card.ability.extra.EEEchip_gain * context.card.ability.qty)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
		if context.joker_main and card.ability.extra.EEEchip > 1 then
			return {
				EEEchip_mod = card.ability.extra.EEEchip,
				card = card,
				message = '^^^'..card.ability.extra.EEEchip..' Chips',
				colour = G.C.CHIPS,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end}))				
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEEchip = card.ability.extra.EEEchip + card.ability.extra.EEEchip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
			}
		end
	end
}

end

SMODS.Joker {
	key = 'acum_universum',
	loc_txt = {
		name = 'ACVM VNIVERSVM',
		text = {
			"{C:attention}All{} scoring {C:attention}cards{} are {C:attention}turned into{} {C:attention}Aces{}",
			"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
			"and give {X:mult,C:white}^^#2#{} Mult",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,s:0.5}Universal Collapse + Acum{}"
		}
	},
	config = { extra = { repetitions = 11, ee_mult = 11 } },
	rarity = "may_interdimensional",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
	cost = 5000,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.ee_mult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1, 1)
					return true end }))	
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				return {
					ee_mult = card.ability.extra.ee_mult,
					card = context.other_card
				}
			end
		end
		if context.before and not context.blueprint then
			for _, card in ipairs(context.scoring_hand) do
				assert(SMODS.change_base(card, nil, "Ace"))
			end
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.forcetrigger then
			return {
				EEmult_mod = card.ability.extra.ee_mult,
				message = '^^'..card.ability.extra.ee_mult..' Mult',
				colour = G.C.MULT,
				card = context.other_card,
			}
		end
	end
}

SMODS.Joker {
	key = 'kepler',
	loc_txt = {
		name = 'Kepler',
		text = {
			"When hand is played, {C:attention}before scoring{},",
			"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
			"as {X:mult,C:white}^^Mult{}",
			"{C:inactive}Currently {X:mult,C:white}^^#1#{} Mult{}",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,s:0.5}Cosmos + Storm{}"
		}
	},
	config = { extra = { EEmult = 1 } },
	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 },
	cost = 10000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEmult}}
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.EEmult = card.ability.extra.EEmult + G.GAME.hands[context.scoring_name].level
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
		if context.joker_main then
			return {
				EEmult_mod = card.ability.extra.EEmult,
				card = card,
				message = '^^'.. card.ability.extra.EEmult .. ' Mult',
				colour = G.C.MULT,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(1, 1)
				return true end }))			
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEmult = card.ability.extra.EEmult + (G.GAME.hands[G.GAME.current_round.current_hand.handname or 'High Card'].level or 0)
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus_kollectum_maximus',
	loc_txt = {
    name = 'Diskus Kollectum Maximus',
    text = {
			"When {C:attention}Blind{} is {C:attention}selected{},",
			"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} {C:attention}cards{}",
			"{C:attention}Increases{} by {C:attention}#2#{} per {C:attention}card{} in {C:attention}played hand{}",
			"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:purple,C:white}^^#3#{} Mult & Chips",
			"{X:purple,C:white}^^#4#{} Mult & Chips if {C:attention}this Joker{} has an {C:dark_edition}Edition{} instead",
			may.add_fusion_text('Universal Collapse'),
			"{C:inactive,s:0.5}Diskus Kollectum + Collector's Edition{}"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 4, y = 12 },
	soul_pos = { x = 5, y = 12 },
	cost = 100000,
	config = { extra = { blindcards = 40, cards_gain = 10, EEmultchips = 14, EEmultchips_alt = 80 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { card.ability.extra.blindcards, card.ability.extra.cards_gain, card.ability.extra.EEmultchips, card.ability.extra.EEmultchips_alt } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.blindcards = card.ability.extra.blindcards + (card.ability.extra.cards_gain * #G.play.cards)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			if card.edition then
				return {
					message = "^^"..card.ability.extra.EEmultchips_alt.." Mult & Chips",
					EEmult_mod = card.ability.extra.EEmultchips_alt,
					EEchip_mod = card.ability.extra.EEmultchips_alt,
					colour = G.C.PURPLE,
					card = context.other_joker,
					sound = 'may_eeboth'
				}
			else
				return {
					message = "^^"..card.ability.extra.EEmultchips.." Mult & Chips",
					EEmult_mod = card.ability.extra.EEmultchips,
					EEchip_mod = card.ability.extra.EEmultchips,
					colour = G.C.PURPLE,
					card = context.other_joker,
					sound = 'may_eeboth'
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
	end
}
	
	-- Ethereal
	
SMODS.Joker {
	key = 'acum_multiplexum',
	loc_txt = {
		name = 'ACVM MVLTIPLEXVM',
		text = {
		"When {C:attention}blind{} is {C:attention}selected{},",
		"turn {C:attention}all cards{} in deck into {C:attention}Aces{}",
		"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
		"and give {X:mult,C:white}^^^#2#{} Mult",
		may.add_fusion_text('Kepler\'s Dream'),
		"{C:inactive,s:0.5}Universal Collapse + ACVM VNIVERSVM{}"
		}
	},
	config = { extra = { repetitions = 22, eee_mult = 11 } },
	rarity = "may_ethereal",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 2 },
	cost = 111111,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.eee_mult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1.3, 1.3)
					return true end }))	
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then	
				return {
					eee_mult = card.ability.extra.eee_mult,
					card = context.other_card,
				}
			end
		end
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({func = function()
                for _, card in ipairs(G.playing_cards) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
			return true end}))
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.forcetrigger then
			return {
				EEEmult_mod = card.ability.extra.eee_mult,
				message = '^^^'..card.ability.extra.eee_mult..' Mult',
				colour = G.C.MULT,
				card = context.other_card,
			}
		end
	end
}
 
SMODS.Joker {
	key = 'keplers_dream',
	loc_txt = {
		name = 'Kepler\'s Dream',
		text = {
			"When hand is played, {C:attention}before scoring{},",
			"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
			"as {X:mult,C:white}^^^Mult{}",
			"{C:inactive}Currently {X:mult,C:white}^^^#1#{} Mult{}",
			may.add_fusion_text('ACVM MVLTIPLEXVM'),
			"{C:inactive,s:0.5}Universal Collapse + Kepler{}",
			"{C:inactive,s:0.5}original concept by pyleup{}",
		}
	},
	config = { extra = { EEEmult = 1 } },
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 },
	cost = 100000,
	rarity = 'may_ethereal',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEEmult}}
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.EEEmult = card.ability.extra.EEEmult + G.GAME.hands[context.scoring_name].level
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
		if context.joker_main then
			return {
				EEEmult_mod = card.ability.extra.EEEmult,
				message = '^^^'.. card.ability.extra.EEEmult .. ' Mult',
				colour = G.C.RED,
				card = card,				
			}
		end
		if context.forcetrigger then
			return {
				EEEmult_mod = card.ability.extra.EEEmult,
				message = '^^^'.. card.ability.extra.EEEmult ..' Mult',
				colour = G.C.RED,
				card = card,				
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus_distruktum',
	loc_txt = {
		name = 'Diskus Distruktum',
		text = {
			"When {C:attention}blind{} is {C:attention}selected{}, create {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
			"{C:attention}Increases{} by {C:attention}#2#{} when a {C:purple}Wheel of Fortune{} is used",
			"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:purple,C:white}^^^#3#{} Mult & Chips",
			"{C:attention}Increases{} by {X:purple,C:white}#4#{} at the {C:attention}end of round{} if {C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			"{C:inactive,s:0.5}Universal Collapse + Diskus Kollectum Maximus{}"
		}
	},
	config = { extra = { blindamount = 140, scale = 14, EEEmultchips = 14, EEEmultchips_gain = 14 } },
	pos = { x = 4, y = 11 },
	soul_pos = { x = 5, y = 11 },
	cost = 5000,
	rarity = 'may_ethereal',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {vars = {card.ability.extra.blindamount, card.ability.extra.scale, card.ability.extra.EEEmultchips, card.ability.extra.EEEmultchips_gain,}}
    end,
    calculate = function(self, card, context)
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(2, 2)
			return true end}))
			return {
				message = "^^^"..card.ability.extra.EEEmultchips.." Mult & Chips",
				EEEmult_mod = card.ability.extra.EEEmultchips,
				EEEchip_mod = card.ability.extra.EEEmultchips,
				colour = G.C.PURPLE,
				sound = 'may_eeeboth'
			}
		end
		if context.joker_main and card.edition then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(2, 2)
			return true end}))
			return {
				message = "^^^"..card.ability.extra.EEEmultchips.." Mult & Chips",
				EEEmult_mod = card.ability.extra.EEEmultchips,
				EEEchip_mod = card.ability.extra.EEEmultchips,
				colour = G.C.PURPLE,
				sound = 'may_eeeboth'
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(1, 1)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindamount)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindamount, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
		if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' and not context.blueprint then
			card.ability.extra.blindamount = card.ability.extra.blindamount + card.ability.extra.scale
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if card.edition then
				card.ability.extra.EEEmultchips = card.ability.extra.EEEmultchips + card.ability.extra.EEEmultchips_gain
				return {
					message = 'Upgraded!',
					colour = G.C.PURPLE,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(1, 1)
				if Incantation then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindamount)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindamount, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
	end
}

-- HyperAscendant

if may.conf.Mode == 1 then

SMODS.Joker {
	key = 'spadus',
	loc_txt = {
		name = 'Spadus',
		text = {
			"Played {C:attention}Aces{} give {X:purple,C:white}#1##2##3##4#{} Mult & Chips",
			"and are retriggered {C:attention}#5# times{}",
			"When hand is played, {C:attention}before scoring{}, {C:attention}gain{} the {C:planet}level{}",
			"of played Poker Hand as {X:purple,C:white}hyperoperational Mult & Chips{}",
			"{C:attention}Arrows increase{} by {C:attention}#6#{} when a {C:planet}planet card{} is {C:attention}used{} during a {C:attention}blind{}",
			"Arrows {C:mult}reset to #1##7##3#{} at the end of round",
			"When {C:attention}Blind{} is {C:attention}selected{}, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
			"{C:inactive,s:0.5}ACVM MVLTIPLEXVM + Kepler's Dream{}"
		}
	},
	config = { extra = { arrow = 4, Hmultchips = 11, repetitions = 11, arrow_gain = 1, reset = 6 } },
	rarity = "may_hyperascendant",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 11e11,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hmultchips, card.ability.extra.repetitions, card.ability.extra.arrow_gain, card.ability.extra.reset }}
    end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1.3, 1.3)
					return true end }))
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			return {
				hyper_mult = {card.ability.extra.arrow, card.ability.extra.Hmultchips},
				hyper_chips = {card.ability.extra.arrow, card.ability.extra.Hmultchips},
				card = context.other_card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(3, 3)
				return true end }))
			}
		end
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({func = function()
                for _, card in ipairs(G.playing_cards) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
			return true end}))
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.arrow = card.ability.extra.reset
			return {
				message = 'Reset!',
				colour = G.C.DARK_EDITION,
				card = card,
				sound = 'may_hyperoperator',
			}
		end
		if context.before and not context.blueprint then
			card.ability.extra.Hmultchips = card.ability.extra.Hmultchips + G.GAME.hands[context.scoring_name].level 
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
		if context.using_consumeable and not context.blueprint then 
			if context.consumeable:gc().set == 'Planet' or context.consumeable:gc().set == 'rare_planets' or context.consumeable:gc().set == 'legendary_planets' and G.GAME.blind.chip_text then
				card.ability.extra.arrow = card.ability.extra.arrow + (card.ability.extra.arrow_gain * (context.consumeable.ability.qty or 1))
				if may.conf.Safe then
					card.ability.extra.arrow = math.min(10000, card.ability.extra.arrow)
				end
				return {
					message = 'Upgraded!',
					colour = G.C.DARK_EDITION,
					card = card,
					sound = 'may_hyperoperator',
				}
			end
		end
		if context.forcetrigger then
			card.ability.extra.Hmultchips = card.ability.extra.Hmultchips + G.GAME.hands[context.scoring_name].level 
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
	end
}

else

SMODS.Joker {
	key = 'spadus',
	loc_txt = {
		name = 'Spadus',
		text = {
			"Played {C:attention}Aces{} give {X:purple,C:white}#1##2##3##4# Mult & Chips",
			"and are retriggered {C:attention}#5# times{}",
			"When hand is played, {C:attention}before scoring{}, {C:attention}gain{} the {C:planet}level{}",
			"of played Poker Hand as {X:purple,C:white}hyperoperational Mult & Chips{}",
			"{C:attention}Arrows increase{} by {C:attention}#6#{} when a {C:planet}planet card{} is {C:attention}used{}",
			"When {C:attention}Blind{} is {C:attention}selected{}, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
			"{C:inactive,s:0.5}ACVM MVLTIPLEXVM + Kepler's Dream{}"
		},
	},
	config = { extra = { arrow = 4, Hmultchips = 11, repetitions = 33, arrow_gain = 1 } },
	rarity = "may_hyperascendant",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 11e11,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hmultchips, card.ability.extra.repetitions, card.ability.extra.arrow_gain }}
    end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1.3, 1.3)
					return true end }))
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				return {
					hyper_mult = {math.ceil(card.ability.extra.arrow), card.ability.extra.Hmultchips},
					hyper_chips = {math.ceil(card.ability.extra.arrow), card.ability.extra.Hmultchips},
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(3, 3)
					return true end }))
				}
			end
		end
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({func = function()
                for _, card in ipairs(G.playing_cards) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
			return true end}))
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.before and not context.blueprint then
			card.ability.extra.Hmultchips = card.ability.extra.Hmultchips + G.GAME.hands[context.scoring_name].level 
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
		if context.using_consumeable and not context.blueprint then 
			if context.consumeable:gc().set == 'Planet' or context.consumeable:gc().set == 'rare_planets' or context.consumeable:gc().set == 'legendary_planets' then
				card.ability.extra.arrow = card.ability.extra.arrow + (card.ability.extra.arrow_gain * (context.consumeable.ability.qty or 1))
				if may.conf.Safe then
					card.ability.extra.arrow = math.min(10000, card.ability.extra.arrow)
				end
				return {
					message = 'Upgraded!',
					colour = G.C.DARK_EDITION,
					card = card,
					sound = 'may_hyperoperator',
				}
			end
		end
		if context.forcetrigger then
			card.ability.extra.Hmultchips = card.ability.extra.Hmultchips + G.GAME.hands[context.scoring_name].level 
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
	end
}

end

if may.conf.content.WIP then

SMODS.Joker {
	key = 'overflow',
	loc_txt = {
		name = 'Overflow',
		text = {
			"{X:chips,C:white}#1##2##3##4#{} Chips",
			"When {C:attention}blind{} is {C:attention}selected{}, gain {C:chips}current hands{}",
			"as {C:dark_edition}hyperoperator level{}"
		}
	},
	config = { extra = { arrow = 1, Hchips = 3, } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_hyperascendant',
	misc_badge = may_wip_badge,
	unlocked = true,
	discovered = true,
	atlas = 'placeholder',
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hchips, }}
    end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.arrow = card.ability.extra.arrow + G.GAME.current_round.hands_left
			if may.conf.Safe then
				card.ability.extra.arrow = math.min(10000, card.ability.extra.arrow)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.DARK_EDITION,
				card = card,
				sound = 'may_hyperoperator',
			}
		end
		if context.joker_main then
			return {
				hyper_chips = {card.ability.extra.arrow, card.ability.extra.Hchips},
				message = generate_arrow_text(card.ability.extra.arrow, 5)..' Chips',
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end
}

end

end

-- Decks

SMODS.Back {
	name = "Orange deck",
	key = "orange_deck",
	atlas = 'deck',
	pos = { x = 2, y = 0 },
	config = {hand_size = 1},
	loc_txt = {
		name = "Orange Deck",
		text = {
			"{C:attention}+1 Hand size{}"
		},
    },
}

SMODS.Back {
	name = "Purple deck",
	key = "purple_deck",
	atlas = 'deck',
	pos = { x = 4, y = 0 },
	config = {choices = 1},
	loc_txt = {
		name = "Purple Deck",
		text = {
			"You can select {C:green}1 more card{}",
			"from {C:attention}Booster Packs{}"
		},
    },
	calculate = function(self, card, context)
		if context.open_booster and G.GAME.pack_choices + 1 <= G.GAME.pack_size then
			G.GAME.pack_choices = G.GAME.pack_choices + self.config.choices
		end
	end
}

SMODS.Back {
	name = "Pink deck",
	key = "pink_deck",
	atlas = 'deck',
	pos = { x = 3, y = 0 },
	config = {size = 0.8},
	loc_txt = {
		name = "Pink Deck",
		text = {
			"{X:attention,C:white}X0.8{} Blind size"
		},
    },
	apply = function(self)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.size
	end
}

SMODS.Back {
	name = "Lime deck",
	key = "lime_deck",
	atlas = 'deck',
	pos = { x = 1, y = 0 },
	config = {mod = 1},
	loc_txt = {
		name = "Lime Deck",
		text = {
			"{C:attention}+1{} {C:green}Voucher{} slot in {C:atention}shop{}"
		},
    },
	apply = function(self)
		SMODS.change_voucher_limit(self.config.mod)
	end
}

SMODS.Back {
	name = "Brown deck",
	key = "brown_deck",
	atlas = 'deck',
	pos = { x = 0, y = 0 },
	config = {mult = 10},
	loc_txt = {
		name = "Brown Deck",
		text = {
			"All cards start with {X:attention,C:white}X10{} Nominal Chips"
		},
    },
	apply = function(self)
		G.GAME.playing_card_multiplier = self.config.mult
	end
}

SMODS.Back {
	name = "Gray deck",
	key = "gray_deck",
	atlas = 'deck',
	pos = { x = 7, y = 0 },
	loc_txt = {
		name = "Gray Deck",
		text = {
			"All {C:attention}cards{} in deck start with",
			"a {C:attention}random{} {C:dark_edition}seal{}",
			"{C:inactive,E:1,s:0.5}actually its grey !!!{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
			end
		return true end}))
	end
}

SMODS.Back {
	name = "Turqoise deck",
	key = "turqoise_deck",
	atlas = 'deck',
	pos = { x = 5, y = 0 },
	config = {discount = 25},
	loc_txt = {
		name = "Turqoise Deck",
		text = {
			"All {C:attention}cards{} in {C:attention}shop{} are",
			"{C:attention}25%{} {C:money}cheaper{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = self.config.discount
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end}))
	end
}

SMODS.Back {
	name = "Blurple deck",
	key = "blurple_deck",
	atlas = 'deck',
	pos = { x = 6, y = 0 },
	loc_txt = {
		name = "Blurple Deck",
		text = {
			"Start run with a {C:attention}random{}",
			"{X:mult,C:white}Rare{} {C:attention}Joker{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'blurple_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}

SMODS.Back {
	name = "Monochrome deck",
	key = "monochrome_deck",
	atlas = 'deck',
	pos = { x = 8, y = 0 },
	config = {amount = 5},
	loc_txt = {
		name = "Monochrome Deck",
		text = {
			"Start run with {C:attention}5{} {C:dark_edition}Negative{}",
			"copies of a {C:attention}random{} {X:green,C:white}Uncommon{} {C:attention}Joker{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
			card2:set_edition({negative = true}, false, false)
			G.jokers:emplace(card2)
			card2:add_to_deck()
			for i=1, self.config.amount-1, 1 do
				local copy = copy_card(card2, nil)
				G.jokers:emplace(copy)
				copy:add_to_deck()
				copy:set_edition({negative = true}, false, false)
			end
			play_sound('holo1')
		return true end}))
	end
}

-- Have to change the name because MF also has a rainbow deck and they like interchanging
if #SMODS.find_mod('MoreFluff') == 0 then

SMODS.Back {
	name = "Rainbow Deck",
	key = "rainbow_deck",
	atlas = 'deck',
	pos = { x = 13, y = 0 },
	config = { hands = 1, discards = 1, hand_size = 1, size_mod = 0.9, dollars = 10 },
	loc_txt = {
		name = "Rainbow Deck",
		text = {
			"{C:attention}+1{} {C:chips}hand{}, {C:mult}discard{} and {C:attention}hand size{}",
			"{X:attention,C:white}X0.9{} blind size",
			"Start with an {C:attention}extra{} {C:money}$10{}",
			"and a random {X:mult,C:white}Rare{} {C:attention}Joker{}",
		},
    },
	apply = function(self)
		G.GAME.starting_params.hand_size = 8 + self.config.hand_size
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.size_mod
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'rainbow_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}

else

SMODS.Back {
	name = "Spectrum Deck",
	key = "rainbow_deck",
	atlas = 'deck',
	pos = { x = 13, y = 0 },
	config = { hands = 1, discards = 1, hand_size = 1, size_mod = 0.9, dollars = 10 },
	loc_txt = {
		name = "Spectrum Deck",
		text = {
			"{C:attention}+1{} {C:chips}hand{}, {C:mult}discard{} and {C:attention}hand size{}",
			"{X:attention,C:white}X0.9{} blind size",
			"Start with an {C:attention}extra{} {C:money}$10{}",
			"and a random {X:mult,C:white}Rare{} {C:attention}joker{}",
		},
    },
	apply = function(self)
		G.GAME.starting_params.hand_size = 8 + self.config.hand_size
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.size_mod
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'rainbow_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}

end

SMODS.Back {
	name = "AAAA Deck",
	key = "aaaa_deck",
	atlas = 'joker1',
	pos = { x = 4, y = 5 },
	config = {rank = 'Ace'},
	loc_txt = {
		name = "AAAA Deck",
		text = {
			"Start run with {C:attention}AAAA{}",
			"and a deck of only {C:attention}Aces{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				assert(SMODS.change_base(v, nil, self.config.rank))
			end
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_AAAA', 'may_aaaa_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}

SMODS.Back {
	name = "Unstable Deck",
	key = "unstable_deck",
	atlas = 'deck',
	pos = { x = 11, y = 0 },
	loc_txt = {
		name = "Unstable Deck",
		text = {
			"Start run with {C:dark_edition}Universal Collapse{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_unstable_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound("may_thunder"..math.random(1,2))
		return true end}))
	end
}

SMODS.Back {
	name = "DeeD",
	key = "deed",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = "DeeD",
		text = {
			"{C:attention}All consumables{} are replaced with",
			"their {C:dark_edition}Upside Down{} version",
			"{C:inactive}(if possible){}"
		},
    },
	apply = function(self)
		G.GAME.may_upside_down_deck = true
	end
}

SMODS.Back {
	name = "Power Deck",
	key = "power_deck",
	atlas = 'deck',
	pos = { x = 9, y = 0 },
	loc_txt = {
		name = "Power Deck",
		text = {
			"{C:green}1 in 10{} chance to",
			"{C:attention}increase{} {C:dark_edition}score operator{} level by {C:attention}1{}",
			"after {C:attention}hand{} is {C:attention}played{}"
		},
    },
	calculate = function(self, back, context)
		if context.after  and pseudorandom('may_power_deck') < G.GAME.probabilities.normal / 10 then
			mod_score_operator(-1, 1, false)
		end
	end
}

if may.conf.content.Vouchers and may.conf.content.WIP then

SMODS.Back {
	name = "Stellar Deck",
	key = "stellar_deck",
	atlas = 'placeholder',
	misc_badge = may_wip_badge,
	pos = { x = 4, y = 2 },
	config = {vouchers = {'v_may_exoplanet'}},
	loc_txt = {
		name = "Stellar Deck",
		text = {
			"When {C:attention}Blind{} is {C:attention}selected{}",
			"create a {C:dark_edition}Negative{} copy of {C:attention}Matakka{}",
			"{C:attention}Start{} run with {C:attention}Exoplanet{} {C:green}Voucher{}",
		},
    },
	calculate = function(self, back, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_matakka', 'may_stellar_deck')
				card2:set_edition({negative = true})
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(0.3, 0.5)
			return true end}))
		end
	end
}

end

if may.conf.content.WIP then

SMODS.Back {
	name = "Mythic Deck",
	key = "mythic_deck",
	atlas = 'placeholder',
	misc_badge = may_wip_badge,
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = "Mythic Deck",
		text = {
			"Start run with a random",
			"{X:may_mythic,C:white}Mythic{} {C:attention}Joker{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_mythic", nil, nil, nil, "may_mythic_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_mythic_joker')
			end
		return true end}))
	end
}

end

SMODS.Back {
	name = "Transcendent deck",
	key = "transcendent_deck",
	atlas = 'deck',
	pos = { x = 12, y = 0 },
	config = { hands = -1, discards = -1 },
	loc_txt = {
		name = "Transcendent Deck",
		text = {
			"Start run with a random",
			"{X:dark_edition,C:white}Transcendent{} {C:attention}Joker{}",
			"{C:chips}-1 hand{} and {C:mult}discard{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_transcendent", nil, nil, nil, "may_transcendent_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_transcendent_joker')
				if card.config.center.key == 'j_may_party_time' then
					if Incantation then
						local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_deck")
						card:add_to_deck()
						card:setQty(40)
						card:start_materialize()
						G.consumeables:emplace(card)
						card:set_edition({negative = true}, false, false)
					else
						for i=1, 40, 1 do
							local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_deck")
							card:add_to_deck()
							card:start_materialize()
							G.consumeables:emplace(card)
							card:set_edition({negative = true}, false, false)
						end
					end
					play_sound('holo1')
				end
			end
		return true end}))
	end
}

if may.conf.content.WIP then

SMODS.Back {
	name = "Surreal deck",
	key = "surreal_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_wip_badge,
	config = { hands = -2 },
	loc_txt = {
		name = "Surreal Deck",
		text = {
			"Start run with a random",
			"{X:may_surreal,C:white}Surreal{} {C:attention}Joker{}",
			"{C:chips}-2 hands{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_surreal", nil, nil, nil, "may_surreal_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_surreal_joker')
			end
		return true end}))
	end
}

SMODS.Back {
	name = "Interdimensional Deck",
	key = "interdimensional_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_wip_badge,
	config = { hands = -1, discards = -1, joker_slot = -1, hand_size = -1 },
	loc_txt = {
		name = "Interdimensional Deck",
		text = {
			"Start run with a random",
			"{X:may_interdimensional,C:white}Interdimensional{} {C:attention}Joker{}",
			"{C:chips}-1 hand{}, {C:mult}discard{}, {C:attention}Hand Size{} and {C:attention}Joker Slot{}"
		},
    },
	apply = function(self)
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_interdimensional", nil, nil, nil, "may_interdimensional_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_interdimensional_joker')
			end
		return true end}))
	end
}

end

SMODS.Back {
	name = "Ethereal deck",
	key = "ethereal_deck",
	atlas = 'deck',
	pos = { x = 10, y = 0 },
	config = {  hands = -2, discards = -2, joker_slot = -3 },
	loc_txt = {
		name = "Ethereal Deck",
		text = {
			"Start run with a random",
			"{X:may_ethereal,C:white}Ethereal{} {C:attention}Joker{},",
			"{C:chips}2 hands{}, {C:mult}1 discard{} and {C:attention}2 joker slots{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_ethereal_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_ethereal_joker')
			end
		return true end}))
	end
}

if may.conf.content.WIP then

-- Ascended Decks

SMODS.Back {
	name = "Ascended Plasma Deck",
	key = "asc_plasma_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	config = {Hmultchips = 30, arrows = 2},
	loc_txt = {
		name = "Ascended Plasma Deck",
		text = {
			"{C:attention}Balances{} {C:purple}Mult & Chips{}",
			"Before balancing, {X:purple,C:white}^^30{} Mult & Chips",
			"{C:attention}Hyperoperation{} level {C:attention}increases{} by {C:attention}1{}",
			"when {C:attention}Boss Blind{} is {C:attention}selected{}",
		},
    },
	misc_badge = may_ascended_badge,
	calculate = function(self, card, context)
		if context.final_scoring_step then
			hand_chips = mod_chips(hand_chips:arrow(self.config.arrows, self.config.Hmultchips))
			mult = mod_mult(mult:arrow(self.config.arrows, self.config.Hmultchips))	
			jl.hcm(hand_chips, mult)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				G.GAME.may_override_monitor_colors = true
				play_sound(may.get_operation_sound(self.config.arrows, 'mult'))
				play_sound(may.get_operation_sound(self.config.arrows, 'chips'))
				ease_colour(G.C.UI_CHIPS, G.C.PURPLE)
				ease_colour(G.C.UI_MULT, G.C.PURPLE)
				delay(0.5)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
				return true end}))
			return true end}))
			delay(1)
			hand_chips = mod_chips(math.floor((hand_chips + mult)/2))
			mult = mod_mult(math.floor((hand_chips + mult)/2))
			jl.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				G.GAME.may_override_monitor_colors = true
				ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
				ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
				jl.a(localize('k_balanced'), 2, 1.4) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
					G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
				return true end}))
				G.GAME.may_override_monitor_colors = false
			return true end)}))
		end
		if context.setting_blind and G.GAME.blind.boss then
			self.config.arrows = self.config.arrows + 1
			return {
				message = 'Upgraded!',
				colour = G.C.DARK_EDITION,
				sound = 'may_hyperoperator',
			}
		end
	end
}

SMODS.Back {
	name = "Ascended Checkered Deck",
	key = "asc_checkered_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	config = { EEEmultchips = 3 },
	loc_txt = {
		name = "Ascended Checkered Deck",
		text = {
			"{C:attention}Start{} run with a deck of {C:attention}only Spades{}",
			"Played {C:attention}Spades{} give {X:purple,C:white}^^^3{} Mult & Chips"
		},
    },
	misc_badge = may_ascended_badge,
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				assert(SMODS.change_base(v, 'Spades', nil))
			end
		return true end}))
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit('Spades') then
				return {
					eee_mult = 3,
					eee_chips = 3,
					card = context.other_card
				}
			end
		end
	end
}

-- Transcendent Decks

SMODS.Back {
	name = "Balance Deck",
	key = "balance_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "Balance Deck",
		text = {
			"After scoring, {C:attention}balance{} {C:mult}Mult{}, {C:chips}Chips{}, {C:money}Dollars{},",
			"{C:attention}played{} {C:purple}Poker Hand level{} and the",
			"{C:purple}Mult & Chips{} of every {C:attention}other{} {C:purple}Poker Hand{}",
		},
    },
	calculate = function(self, back, context)
		if context.final_scoring_step then
			local items = 4
			local balanced = math.floor(hand_chips + mult + G.GAME.dollars + G.GAME.hands[G.GAME.current_round.current_hand.handname].level)
			for k, v in pairs(G.GAME.hands) do
				if v ~= G.GAME.hands[G.GAME.current_round.current_hand.handname] then
					balanced = balanced + v.mult + v.chips
					items = items + 2
				end
			end
			balanced = math.floor(balanced / items)
			hand_chips = mod_chips(balanced)
			mult = mod_mult(balanced)
			ease_dollars(balanced - G.GAME.dollars)
			for k, v in pairs(G.GAME.hands) do
				if v ~= G.GAME.hands[G.GAME.current_round.current_hand.handname] then
					G.GAME.hands[k].mult = balanced
					G.GAME.hands[k].chips = balanced
				end
			end
			delay(0.5)
			local previous = G.GAME.current_round.current_hand.handname
			jl.hn("Other Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_eqchip')
			return true end}))
			jl.hc('='..balanced, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_eqmult')
			return true end}))
			jl.hm('='..balanced, true)
			delay(0.5)
			jl.hn(previous)
			jl.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				play_sound('may_hyperoperator', 1.5)
				G.GAME.may_override_monitor_colors = true
				ease_colour(G.C.UI_CHIPS, G.C.EDITION)
				ease_colour(G.C.UI_MULT, G.C.EDITION)
				jl.a(localize('k_balanced'), 2, 1.4) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
					G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
				return true end}))
				G.GAME.may_override_monitor_colors = false
				G.GAME.hands[G.GAME.current_round.current_hand.handname].level = balanced:normalize()
				G.GAME.hands[G.GAME.current_round.current_hand.handname].mult = to_big(G.GAME.hands[G.GAME.current_round.current_hand.handname].mult) + (to_big(G.GAME.hands[G.GAME.current_round.current_hand.handname].l_mult)*(G.GAME.hands[G.GAME.current_round.current_hand.handname].level - to_big(1)))
				G.GAME.hands[G.GAME.current_round.current_hand.handname].chips = to_big(G.GAME.hands[G.GAME.current_round.current_hand.handname].chips) + (to_big(G.GAME.hands[G.GAME.current_round.current_hand.handname].l_chips)*(G.GAME.hands[G.GAME.current_round.current_hand.handname].level - to_big(1)))
				G.GAME.hands[G.GAME.current_round.current_hand.handname].mult = G.GAME.hands[G.GAME.current_round.current_hand.handname].mult:normalize()
				G.GAME.hands[G.GAME.current_round.current_hand.handname].chips = G.GAME.hands[G.GAME.current_round.current_hand.handname].chips:normalize()
			return true end)}))
		end
	end
}

SMODS.Back {
	name = "Celestial Hierarchy Deck",
	key = "celestial_hierarchy_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "Celestial Hierarchy Deck",
		text = {
			"{C:attention}All{} possible {C:attention}consumables{} are {C:dark_edition}empowered{}",
			"{C:attention}All{} empowerement {C:attention}tiers{} have the {C:green}same{}",
			"{C:green}chance{} of appearing"
		},
    },
	-- Logic is handled in the actual empowered consumable function
}

SMODS.Back {
	name = "HyperAscendant Deck",
	key = "hyperascendant_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "HyperAscendant Deck",
		text = {
			"Start run with a random",
			"{X:may_hyperascendant,C:white}HyperAscendant{} {C:attention}Joker{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_hyperascendant", nil, nil, nil, "may_hyperascendant_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_hyperascendant_joker')
			end
		return true end}))
	end
}

SMODS.Back {
	name = "Sandbox Deck",
	key = "sandbox_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	config = { joker_slot = 1e100, vouchers = {'v_overstock_plus'} },
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "Sandbox Deck",
		text = {
			"{C:attention}+1e100 Joker and Consumable Slots{}",
			"You can select {C:green}all cards{} from {C:attention}Booster Packs{}",
			"Start run with {C:attention}Overtsock Plus{}, a {C:dark_edition}Negative{} copy",
			"of {C:spectral}Soul{}, {C:spectral}Genesis{} and {C:spectral}Prestige{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			G.consumeables.config.card_limit = 1e100
			local soul = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_soul', "may_sandbox_deck")
			soul:add_to_deck()
			G.consumeables:emplace(soul)
			soul:set_edition({negative = true})
			local genesis = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_may_genesis', "may_sandbox_deck")
			genesis:add_to_deck()
			G.consumeables:emplace(genesis)
			genesis:set_edition({negative = true})
			local prestige = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_may_prestige', "may_sandbox_deck")
			prestige:add_to_deck()
			G.consumeables:emplace(prestige)
			prestige:set_edition({negative = true})
		return true end}))
	end,
	calculate = function(self, card, context)
		if context.open_booster then
			G.GAME.pack_choices = G.GAME.pack_size
		end
	end
}

function may.voucher_silent(key)
	local voucher_key = key or get_next_voucher_key(true)
	if not G.P_CENTERS[voucher_key] then return end
	local area
	if G.STATE == G.STATES.HAND_PLAYED then
		if not G.redeemed_vouchers_during_hand then
			G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
		end
		area = G.redeemed_vouchers_during_hand
	else
		area = G.play
	end
end


--[[SMODS.Back {
	name = "Wholesale Deck",
	key = "wholesale_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	config = {has_applied = false},
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "Wholesale Deck",
		text = {
			"When {C:attention}first Small Blind{} is selected,",
			"redeem {C:attention}every{} {C:green}Voucher{}"
		},
    },
	calculate = function(self, card, context)
		if context.setting_blind and not self.config.has_apllied then
			for k, v in pairs(G.P_CENTERS) do 
				if G.P_CENTERS[k].redeem then
					may.voucher_silent(G.P_CENTERS[k].name)
					return G.P_CENTERS[k]
				end
			end
			self.config.has_applied = true
		end
	end
}]]

end

-- More Nopeus speeds

if #SMODS.find_mod('nopeus') ~= 0 then
	function G.UIDEF.nopeus_options()
	local speeds = create_option_cycle({label = localize('b_set_gamespeed'), scale = 0.8, options = {0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.5, 3, 3.5, 4, 8, 16, 32, 64, 128, 256, 512, 800, 1024, 1500, 2048, 3000, 5096, 8000, 10192}, opt_callback = 'change_gamespeed', current_option = (
		G.SETTINGS.GAMESPEED == 0.25 and 1 or
		G.SETTINGS.GAMESPEED == 0.5 and 2 or
		G.SETTINGS.GAMESPEED == 0.75 and 3 or
		G.SETTINGS.GAMESPEED == 1 and 4 or
		G.SETTINGS.GAMESPEED == 1.25 and 5 or
		G.SETTINGS.GAMESPEED == 1.5 and 6 or
		G.SETTINGS.GAMESPEED == 1.75 and 7 or
		G.SETTINGS.GAMESPEED == 2 and 8 or
		G.SETTINGS.GAMESPEED == 2.5 and 9 or
		G.SETTINGS.GAMESPEED == 3 and 10 or
		G.SETTINGS.GAMESPEED == 3.5 and 11 or
		G.SETTINGS.GAMESPEED == 4 and 12 or
		G.SETTINGS.GAMESPEED == 8 and 13 or
		G.SETTINGS.GAMESPEED == 16 and 14 or
		G.SETTINGS.GAMESPEED == 32 and 15 or
		G.SETTINGS.GAMESPEED == 64 and 16 or
		G.SETTINGS.GAMESPEED == 128 and 17 or
		G.SETTINGS.GAMESPEED == 256 and 18 or
		G.SETTINGS.GAMESPEED == 512 and 19 or
		G.SETTINGS.GAMESPEED == 800 and 20 or
		G.SETTINGS.GAMESPEED == 1024 and 21 or
		G.SETTINGS.GAMESPEED == 1500 and 22 or
		G.SETTINGS.GAMESPEED == 2048 and 23 or
		G.SETTINGS.GAMESPEED == 3000 and 24 or
		G.SETTINGS.GAMESPEED == 5096 and 25 or
		G.SETTINGS.GAMESPEED == 8000 and 26 or
		G.SETTINGS.GAMESPEED == 10192 and 27 or
		3
	)})
	return speeds
end
end

-- Cryptid CM content
if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then

-- Misc

-- Pointer blacklist
for k, v in ipairs(may.yotta_cards) do 
	Cryptid.pointerblistify(v, false)
	Cryptid.pointerblistify(v..'_asc', false)
end

for k, v in ipairs(may.empower.can_be_empowered) do 
	Cryptid.pointerblistify('c_may_'..v..'_asc', false)
	Cryptid.pointerblistify('c_may_'..v..'_pan', false)
	Cryptid.pointerblistify('c_may_'..v..'_unw', false)
	Cryptid.pointerblistify('c_may_'..v..'_won', false)
	Cryptid.pointerblistify('c_may_'..v..'_eps', false)
end

Cryptid.pointerblistify('c_cry_pointer', false)
Cryptid.pointerblistify('c_may_omega_card', false)
Cryptid.pointerblistify('c_may_otherworldly_card', false)

Cryptid.pointerblistify('e_may_omega', false)
Cryptid.pointerblistify('e_may_otherworldly', false)

Cryptid.pointerblistify('m_may_geometric', false)

Cryptid.pointerblistifytype("rarity", "may_mythic")
Cryptid.pointerblistifytype("rarity", "may_transcendent")
Cryptid.pointerblistifytype("rarity", "may_surreal")
Cryptid.pointerblistifytype("rarity", "may_interdimensional")
Cryptid.pointerblistifytype("rarity", "may_ethereal")
Cryptid.pointerblistifytype("rarity", "may_hyperascendant")

-- Add rarity badges to Cryptid hidden consumables

SMODS.Consumable:take_ownership('c_cry_gateway', {
	misc_badge = may_epic_badge
})

-- fix white hole crash
SMODS.Consumable:take_ownership('c_cry_white_hole', {
	misc_badge = may_rare_badge,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local modest = Card.get_gameset(used_consumable) == "modest"
		local removed_levels = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			removed_levels = removed_levels + to_big(v.level) - to_big(1)
			v.level = to_big(1):normalize()
			v.mult = to_big(v.mult) + (to_big(v.l_mult)*(v.level - to_big(1)))
			v.chips = to_big(v.chips) + (to_big(v.l_chips)*(v.level - to_big(1)))
			v.mult = v.mult:normalize()
			v.chips = v.chips:normalize()
		end
		jl.th(jl.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hlv(removed_levels + to_big(1))
		G.GAME.hands[jl.favhand()].level = to_big(removed_levels + to_big(1)):normalize()
		G.GAME.hands[jl.favhand()].mult = to_big(G.GAME.hands[jl.favhand()].mult) + (to_big(G.GAME.hands[jl.favhand()].l_mult)*(G.GAME.hands[jl.favhand()].level - to_big(1)))
		G.GAME.hands[jl.favhand()].chips = to_big(G.GAME.hands[jl.favhand()].chips) + (to_big(G.GAME.hands[jl.favhand()].l_chips)*(G.GAME.hands[jl.favhand()].level - to_big(1)))
		G.GAME.hands[jl.favhand()].mult = G.GAME.hands[jl.favhand()].mult:normalize()
		G.GAME.hands[jl.favhand()].chips = G.GAME.hands[jl.favhand()].chips:normalize()
		delay(1.3)
		jl.ch()
	end
})

SMODS.Consumable:take_ownership('c_cry_pointer', {
	misc_badge = may_epic_badge
})

-- Cryptid Fusions

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_cry_circulus_pistoris', nil, nil, 'j_may_hypersphere', 314159, 'may_interdimensional_joker', nil, 0.8)

if may.conf.content.WIP then

FusionJokers.fusions:add_fusion('j_bones', nil, nil, 'j_cry_tenebris', nil, nil, 'j_may_mortuary', 1000000, 'may_interdimensional_joker', nil, 0.8)

end

-- Cryptid Atlases

SMODS.Atlas {
	key = "cry_editioncard",
	path = "cm/cry/editioncard.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "cry_joker1",
	path = "cm/cry/joker1.png",
	px = 71,
	py = 95
}

-- Cryptid Editions

SMODS.Edition {
	key = "misprint",
	loc_txt = {
		name = "Misprint",
		label = "Misprint",
		text = {
			"{C:attention}Randomize{} all {C:attention}values{} on {C:attention}this card{}",
			"{C:attention}during scoring{}",
			"{C:inactive}WIP shader!{}"
		}
	},
	shader = 'misprint',
	discovered = true,
	badge_colour = HEX('777777'),
	sound = { sound = "may_e_misprint", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 0.7,
	extra_cost = 8,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			Cryptid.with_deck_effects(card, function(card)
				Cryptid.misprintize(card, {
					min = 0.01,
					max = 30,
				}, nil, true)
			end)
			if card.config.center.apply_glitched then
				card.config.center:apply_glitched(card, function(val)
					return Cryptid.misprintize_val(val, {
						min = 0.01 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 30 * (G.GAME.modifiers.cry_misprint_max or 1),
					}, Cryptid.is_card_big(card))
				end)
			end
		end
	end
}

if may.conf.content.Consumables then
-- Cryptid Consumables

	-- Cryptid edition cards
	
SMODS.Consumable {
	key = 'astralcard',
	config = { extra = { emult = 1.1 } },
	loc_txt = {
		name = 'Astral Card',
		text = {
			'Gives all hands {X:mult,C:white}^#1#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 0, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult } }
	end,
	use = function(self, card, area, copier)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = to_big(G.GAME.hands[k].mult):arrow(1, card.ability.extra.emult)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
		return true end }))		
		jl.hcm(nil, '^'..card.ability.extra.emult, true)		
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = to_big(G.GAME.hands[k].mult):arrow(1, card.ability.extra.emult*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
		return true end }))		
		jl.hcm(nil, '^'..card.ability.extra.emult*number, true)		
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'mosaiccard',
	config = { extra = { xchips = 2.5 } },
	loc_txt = {
		name = 'Mosaic Card',
		text = {
			'Gives all hands {X:chips,C:white}X#1#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 4, y = 0 },
	cost = 7,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
	use = function(self, card, area, copier)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * card.ability.extra.xchips
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(1, 1)
		return true end }))
		jl.hcm('x'..card.ability.extra.xchips, nil, true)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * (card.ability.extra.xchips*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(1, 1)
		return true end }))
		jl.hcm('x'..card.ability.extra.xchips*number, nil, true)
		delay(0.5)
		jl.ch()
	end
}

local noisy_stats = {
	min = {
		mult = -10,
		chips = -10
	},
	max = {
		mult = 20,
		chips = 40
	}
}

SMODS.Consumable {
	key = 'noisycard',
	config = { extra = { min_mult = noisy_stats.min.mult, max_mult = noisy_stats.max.mult, min_chips = noisy_stats.min.chips, max_chips = noisy_stats.max.chips } },
	loc_txt = {
		name = 'Noisy Card',
		text = {
			'Gives all hands {C:purple}+???{} Mult & Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 5, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local chips = pseudorandom("may_noisycard_chips", card.ability.extra.min_chips, card.ability.extra.max_chips)
		local mult = pseudorandom("may_noisycard_mult", card.ability.extra.min_mult, card.ability.extra.max_mult)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips + chips
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + mult
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ chips = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2))
			card:juice_up(.5, .5)
		return true end }))		
		jl.hcm('+'..chips, nil, true)		
		delay(0.5)
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ mult = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(.5, .5)
		return true end }))			
		jl.hcm(nil, '+'..mult, true)		
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local chipamounts = {}
		local multamounts = {}
		for i=1, number, 1 do
			local chips = pseudorandom("may_noisycard_chips", card.ability.extra.min_chips, card.ability.extra.max_chips)
			local mult = pseudorandom("may_noisycard_mult", card.ability.extra.min_mult, card.ability.extra.max_mult)
			table.insert(chipamounts, chips)
			table.insert(multamounts, mult)
		end
	    for k, v in pairs(G.GAME.hands) do
			for i =1, number, 1 do
				G.GAME.hands[k].chips = G.GAME.hands[k].chips + chipamounts[i]
				G.GAME.hands[k].mult = G.GAME.hands[k].mult + multamounts[i]
			end
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ chips = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2))
			card:juice_up(.5, .5)
		return true end }))		
		jl.hcm('+???', nil, true)		
		delay(0.5)
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ mult = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(.5, .5)
		return true end }))			
		jl.hcm(nil, '+???', true)		
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'glitchedcard',
	config = { extra = { min_xmult = 0.1, max_xmult = 3, min_xchips = 0.1, max_xchips = 3 } },
	loc_txt = {
		name = 'Glitched Card',
		text = {
			'Gives all hands anywhere {C:attention}between{} {X:purple,C:white}X0.1{} and {X:purple,C:white}X3{}',
			'{C:purple}Mult & Chips{} {C:inactive}(separately){}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
		local xchips = pseudorandom("may_noisycard_chips", card.ability.extra.min_xchips, card.ability.extra.max_xchips)
		local xmult = pseudorandom("may_noisycard_mult", card.ability.extra.min_xmult, card.ability.extra.max_xmult)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * xchips
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * xmult
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ chips = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(.5, .5)
		return true end }))	
		jl.hcm('X'..xchips, nil, true)		
		delay(0.5)
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ mult = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(.5, .5)
		return true end }))
		jl.hcm(nil, 'X'..xmult, true)		
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local chipamounts = {}
		local multamounts = {}
		for i=1, number, 1 do
			local xchips = pseudorandom("may_noisycard_chips", card.ability.extra.min_xchips, card.ability.extra.max_xchips)
			local xmult = pseudorandom("may_noisycard_mult", card.ability.extra.min_xmult, card.ability.extra.max_xmult)
			table.insert(chipamounts, xchips)
			table.insert(multamounts, xmult)
		end
	    for k, v in pairs(G.GAME.hands) do
			for i=1, number, 1 do
				G.GAME.hands[k].chips = G.GAME.hands[k].chips * chipamounts[i]
				G.GAME.hands[k].mult = G.GAME.hands[k].mult * multamounts[i]
			end
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ chips = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(.5, .5)
		return true end }))	
		jl.hcm('x???', nil, true)		
		delay(0.5)
		for i = 1, math.random(2, 4) do
			update_hand_text(
				{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
				{ mult = may.obfuscatedtext(3) }
			)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(.5, .5)
		return true end }))
		jl.hcm(nil, 'x???', true)		
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'oversatcard',
	config = { extra = { xmult = 2, xchips = 2 } },
	loc_txt = {
		name = 'Oversaturated Card',
		text = {
			'Gives all hands {X:purple,C:white}X#1#{} Mult & Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 6, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	use = function(self, card, area, copier)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * card.ability.extra.xmult
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * card.ability.extra.xchips
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm('X'..card.ability.extra.xchips, nil, true)		
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm(nil, 'X'..card.ability.extra.xmult, true)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * (card.ability.extra.xmult*number)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * (card.ability.extra.xchips*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(1, 1)
		return true end }))	
		jl.hcm('X'..card.ability.extra.xchips*number, nil, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end}))	
		jl.hcm(nil, 'X'..card.ability.extra.xmult*number, true)		
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'jollycard',
	config = { extra = { mult = 8, } },
	loc_txt = {
		name = 'Jolly Card',
		text = {
			'Gives all hands {C:mult}+#1#{} Mult',
			'Generates a {C:dark_edition}Jolly Surprise{}...'
		}
	},
	set = 'editioncards',
	pos = { x = 3, y = 0 },
	cost = 8,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	use = function(self, card, area, copier)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + card.ability.extra.mult
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))
		jl.hcm(nil, '+'..card.ability.extra.mult, true)		
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_jolly', "may_santa")
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
			play_sound('cry_e_jolly')
		return true end }))				
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
	    for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].mult = G.GAME.hands[k].mult + (card.ability.extra.mult*number)
        end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))
		jl.hcm(nil, '+'..card.ability.extra.mult*number, true)		
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			for i=1, number, 1 do
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_jolly', "may_santa")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
			end
			play_sound('cry_e_jolly')
			return true end }))	
		delay(0.5)
		jl.ch()
	end
}

SMODS.Consumable {
	key = 'fragilecard',
	config = { extra = { xmult = 3, odds = 8 } },
	loc_txt = {
		name = 'Fragile Card',
		text = {
			'{C:green}#1# in #2#{} chance to give all hands',
			'{X:mult,C:white}X#3#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 7, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.xmult } }
	end,
	use = function(self, card, area, copier)
		if pseudorandom('may_fragilecard') < G.GAME.probabilities.normal / card.ability.extra.odds and not card.ability.eternal then
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult * to_big(card.ability.extra.xmult)
			end
			delay(0.5)
			Q(function() card:juice_up(.2, .3) return true end)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end }))	
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('multhit2')
				card:juice_up(1, 1)
			return true end }))
			jl.hcm(nil, 'x'..card.ability.extra.xmult, true)
			delay(0.5)
			jl.ch()
		else
			card.will_shatter = true
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
				card:shatter()
			return true end }))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		for i=1, number, 1 do
			if pseudorandom('may_fragilecard') < G.GAME.probabilities.normal / card.ability.extra.odds and not card.ability.eternal then
				for k, v in pairs(G.GAME.hands) do
					G.GAME.hands[k].mult = G.GAME.hands[k].mult * to_big(card.ability.extra.xmult)
				end
				amount = amount+1
			end
		end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		jl.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
			play_sound('glass'..math.random(1, 7))
		return true end }))
		jl.hcm(nil, 'x'..card.ability.extra.xmult*amount, true)
		delay(0.5)
	end
}

end

-- Cryptid Vouchers

-- T3

if may.conf.content.WIP then

SMODS.Voucher {
	key = 'power_trip',
	loc_txt = {
		name = "Power Trip",
		text = {
			"{X:mult,C:white}Rare{} and {X:uncommon,C:white}Uncommon{} Jokers are {C:money}free{}",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	pools = { Tier3 = true },
	unlocked = true,
	requires = {'v_may_natural_selection'},
	redeem = function(self, card)
		G.GAME.power_trip = true
	end,
	unredeem = function(self, card)
		G.GAME.power_trip = false
	end,
}

SMODS.Voucher {
	key = 'booster_cataclysm',
	loc_txt = {
		name = "Booster Cataclysm",
		text = {
			"{C:attention}+2{} {C:green}booster packs{} in shop",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	pools = { Tier3 = true },
	unlocked = true,
	requires = {'v_may_booster_overabundance'},
	redeem = function(self, card)
		SMODS.change_booster_limit(2)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-2)
	end,
}

SMODS.Voucher {
	key = 'trifecta',
	loc_txt = {
		name = "Trifecta",
		text = {
			"{C:money}Yotta Cards{} in shop are {X:attention,C:white}X20{} more common",
			"{C:spectral}Spectral Cards{} can appear in {C:attention}shop{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	pools = { Tier3 = true },
	unlocked = true,
	requires = {'v_may_bountiful_selection'},
	redeem = function(self, card)
		G.GAME.spectral_rate = 4
		G.GAME.yottacards_rate = G.GAME.yottacards_rate*20
	end,
	unredeem = function(self, card)
		G.GAME.spectral_rate = 0
		G.GAME.yottacards_rate = G.GAME.yottacards_rate/20
	end,
}

SMODS.Voucher {
	key = 'quasar',
	loc_txt = {
		name = "Quasar",
		text = {
			"{C:attention}Quintuple{} the {C:may_ethereal}Level{} {C:purple}Mult & Chips{}",
			"of {C:attention}all{} {C:purple}Poker Hands{}",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	requires = {'v_may_meteor'},
	pools = { Tier3 = true },
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		hand_mod_lvl_multchips_all('multchips', 0, 5)
	end
}

-- T4

SMODS.Voucher {
	key = 'ancestral_token',
	loc_txt = {
		name = "Ancestral Token",
		text = {
			"Set Ante to {C:attention}negative{} of current {C:attention}Ante{}",
			"{C:chips}+2 Hands{} and {C:mult}+1 Discard{}",
			"{C:inactive}(If Ante is already Negative, X2 Ante){}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	cost = 20,
	pools = { Tier4 = true },
	unlocked = true,
	requires = {'v_cry_asteroglyph'},
	redeem = function(self, card)
		if not (G.GAME.round_resets.ante <= 0) then
			ease_ante(-(2*G.GAME.round_resets.ante))
		else
			ease_ante(G.GAME.round_resets.ante)
		end
		ease_hands_played(2)
		ease_discard(1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
	end,
	unredeem = function(self, card)
		if G.GAME.round_resets.ante <= 0 then
			ease_ante(2*math.abs(G.GAME.round_resets.ante))
		end
		ease_hands_played(-2)
		ease_discard(-1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
	end,
}

SMODS.Voucher {
	key = 'universal_stream',
	loc_txt = {
		name = "Universal Stream",
		text = {
			"{C:dark_edition}Infinite{} {C:attention}card selection limit{}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	cost = 20,
	pools = { Tier4 = true },
	unlocked = true,
	requires = {'v_cry_hyperspacetether'},
	redeem = function(self, card)
		G.GAME.pre_universal_stream_limit = G.hand.config.highlighted_limit
		G.hand.config.highlighted_limit = 1e308
		SMODS.change_play_limit(1e308)
		SMODS.change_discard_limit(1e308)
	end,
	unredeem = function(self, card)
		G.hand.config.highlighted_limit = G.GAME.pre_universal_stream_limit
	end,
}

local vanf_rs = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(e) 
	vanf_rs(e)
	if G.GAME.ultrastock then
		if may.conf.Mode == 1 then
			if (G.GAME.ultrastock_mod or 0) < 5 then
				if pseudorandom('may_ultrastock') < G.GAME.probabilities.normal / 4 then
					change_shop_size(1)
					G.GAME.ultrastock_mod = (G.GAME.ultrastock_mod or 0) + 1
					e:juice_up()
					play_sound('highlight2', 1, 0.5)
					play_sound('highlight1')
					play_sound('cardFan2')
				end
			end
		else
			if pseudorandom('may_ultrastock') < G.GAME.probabilities.normal / 4 then
				change_shop_size(1)
				G.GAME.ultrastock_mod = (G.GAME.ultrastock_mod or 0) + 1
				e:juice_up()
				play_sound('highlight2', 1, 0.5)
				play_sound('highlight1')
				play_sound('cardFan2')
			end
		end
	end
end

local vanf_ts = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
	vanf_ts(e)
	if G.GAME.ultrastock_mod then
		change_shop_size(-G.GAME.ultrastock_mod)
		G.GAME.ultrastock_mod = 0
	end
end

if may.conf.Mode == 1 then

SMODS.Voucher {
	key = 'ultrastock',
	loc_txt = {
		name = "UltraStock",
		text = {
			"{C:attention}+1 card{}, {C:green}Voucher{},",
			"and {C:attention}Booster{} slot in {C:attention}shop{}",
			"When {C:attention}rerolling{}, {C:green}1 in 20{} chance to",
			"{C:attention}temporarily{} gain {C:attention}+1 card slot{}",
			"{C:inactive}(max limit of +5 slots){}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	cost = 20,
	pools = { Tier4 = true },
	unlocked = true,
	requires = {'v_cry_multistock'},
	redeem = function(self, card)
		change_shop_size(1)
		SMODS.change_booster_limit(1)
		SMODS.change_voucher_limit(1)
		G.GAME.ultrastock = true
	end,
	unredeem = function(self, card)
		change_shop_size(-1)
		SMODS.change_booster_limit(-1)
		SMODS.change_voucher_limit(-1)
		G.GAME.ultrastock = false
	end,
}

else

SMODS.Voucher {
	key = 'ultrastock',
	loc_txt = {
		name = "UltraStock",
		text = {
			"{C:attention}+1 card{}, {C:green}Voucher{},",
			"and {C:attention}Booster{} slot in {C:attention}shop{}",
			"When {C:attention}rerolling{}, {C:green}1 in 8{} chance to",
			"{C:attention}temporarily{} gain {C:attention}+1 card slot{}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	cost = 20,
	pools = { Tier4 = true },
	unlocked = true,
	requires = {'v_cry_multistock'},
	redeem = function(self, card)
		change_shop_size(1)
		SMODS.change_booster_limit(1)
		SMODS.change_voucher_limit(1)
		G.GAME.ultrastock = true
	end,
	unredeem = function(self, card)
		change_shop_size(-1)
		SMODS.change_booster_limit(-1)
		SMODS.change_voucher_limit(-1)
		G.GAME.ultrastock = false
	end,
}

end

if may.conf.Mode == 1 then

SMODS.Voucher {
	key = 'exoplanet',
	loc_txt = {
		name = "Exoplanet",
		text = {
			"When a {C:purple}Poker Hand{} is {C:planet}leveled up{}, {C:green}#1# in 5{} chance",
			"to create a random {X:legendary,C:white}Legendary{} {C:planet}Planet Card{}",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	requires = {'v_may_quasar'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			if pseudorandom('may_exoplanet') < G.GAME.probabilities.normal / 5 then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound('timpani', 0.5)
						local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
						card2:add_to_deck()
						G.consumeables:emplace(card2)
						card:juice_up(0.3, 0.5)
					end
				return true end}))
				delay(0.6)
			end
		end
	end
}

else

SMODS.Voucher {
	key = 'exoplanet',
	loc_txt = {
		name = "Exoplanet",
		text = {
			"When a {C:purple}Poker Hand{} is {C:planet}leveled up{}, {C:green}#1# in 8{} chance",
			"to create a random {X:may_mythic,C:white}Mythic{} {C:planet}Planet Card{}",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	requires = {'v_may_quasar'},
	cost = 20,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			if pseudorandom('may_exoplanet') < G.GAME.probabilities.normal / 8 then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound('timpani', 0.5)
						local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.mythic_planets, pseudoseed('may_celestra')), 'may_celestra')
						card2:add_to_deck()
						G.consumeables:emplace(card2)
						card:juice_up(0.3, 0.5)
					end
				return true end}))
				delay(0.6)
			end
		end
	end
}

SMODS.Voucher {
	key = 'multiversal_network',
	loc_txt = {
		name = "Multiversal Network",
		text = {
			"{X:attention,C:white}X2{} {C:attention}Joker Slots{}"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'placeholder_vouchert4',
	cost = 20,
	pools = { Tier4 = true },
	unlocked = true,
	requires = {'v_cry_universal_fabric'},
	redeem = function(self, card)
		G.jokers:change_size_hyper(2, 0)
	end,
	unredeem = function(self, card)
		G.jokers:change_size_hyper(0.5, 0)
	end,
}

end

end


-- Cryptid Jokers

-- Exotic 

-- Only spawn rare and below jokers because i have trace amounts of sanity
may.nanobot_choices = {
	'j_may_sly_n',
	'j_may_noble_gas',
	'j_may_navigation',
	'j_may_n',
	'j_may_nose',
	'j_may_grafitti_n',
}

SMODS.Joker {
	key = "nanobot",
	loc_txt = {
		name = 'Nanobot',
		text = {
			"{C:dark_edition}N{} {C:attention}Jokers{} give {X:chips,C:white}^#1#{} Chips",
			"{C:attention}Increases{} by {X:chips,C:white}#2#{} when an {C:dark_edition}N{} {C:attention}Joker{} is {C:attention}obtained{}",
			"{C:attention}After reaching{} {X:chips,C:white}^2{} Chips, create a {C:attention}random{}",
			"{C:dark_edition}Negative N{} {C:attention}Joker{} when playing {C:attention}Three of a Kind{}"
		}
	},
	config = { extra = { Echip = 1, Echip_gain = 0.05} },
	pos = { x = 0, y = 0 },
	misc_badge = may_wip_badge,
	rarity = "cry_exotic",
	n_joker = true,
	pools = { N = true },
	cost = 50,
	blueprint_compat = true,
	atlas = "placeholder",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Echip, card.ability.extra.Echip_gain } }
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			if may.is_n(context.other_joker) then
				return {
					e_chips = card.ability.extra.Echip,
					card = card,
					message = "^"..card.ability.extra.Echip..' Chips',
					colour = G.C.CHIPS
				}
			end
		end
		if context.card_added and context.cardarea == G.jokers and context.card and context.card.config.center.n_joker then
			card.ability.extra.Echip = card.ability.extra.Echip + card.ability.extra.Echip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.before and next(context.poker_hands['Three of a Kind']) then
			play_sound("holo1")
			local card = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_nanobot")
			card:set_edition({negative = true}, true, true)
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
		end
	end
}

SMODS.Joker {
	key = 'taimuresu',
	loc_txt = {
		name = 'Taimuresu',
		text = {
			"{C:attention}Gains{} {X:mult,C:white}X#1#{} Mult when",
			"{C:attention}any scoring context{} happens",
			"{C:inactive}Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult{}",
			"{C:inactive,s:0.5,E:1}This is gonna take a while...{}"
		}
	},
	rarity = 'cry_exotic',
	atlas = 'cry_joker1',
	pos = { x = 6, y = 0 },
	soul_pos = { x = 8, y = 0, extra = { x = 7, y = 0 } },
	blueprint_compat = true,
	config = { extra = { Xmult = 1, Xmult_gain = 0.0004 } },
	cost = 50,
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context and not context.joker_main and not context.blueprint then
			local myself = card
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = myself
			}
		end
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X'..card.ability.extra.Xmult..' Mult',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'multiplicae',
	loc_txt = {
		name = 'Multiplicae',
		text = {
			"When {C:attention}hand{} is {C:attention}played{}:",
			"{C:attention}Held{} in hand {C:attention}cards gain{} {X:chips,C:white}X#1#{} Chips",
			"{C:attention}Scoring cards gain{} {X:mult,C:white}X#2#{} Mult",
			"When {C:attention}discarding{}:",
			"{C:attention}Discarded cards gain{} {X:mult,C:white}X#3#{} {C:attention}held in hand Mult{}"
		}
	},
	rarity = 'cry_exotic',
	atlas = 'cry_joker1',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0 } },
	blueprint_compat = true,
	config = { extra = { Xchip_gain = 0.5, Xmult_gain = 0.5, h_Xmult_gain = 0.2 } },
	cost = 50,
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.Xchip_gain, card.ability.extra.Xmult_gain, card.ability.extra.h_Xmult_gain } }
	end,
	calculate = function(self, card, context)
		if context.individual then
			if context.cardarea == G.play then
				context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 1
				context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.Xmult_gain
				return {
					message = 'Upgraded!',
					card = context.other_card,
					colour = G.C.MULT
				}
			elseif context.cardarea == G.hand and not context.end_of_round then
				context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips or 1
				context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips + card.ability.extra.Xchip_gain
				return {
					message = 'Upgraded!',
					card = context.other_card,
					colour = G.C.CHIPS
				}
			end
		end
		if context.discard then
			context.other_card.ability.perma_h_x_mult = context.other_card.ability.perma_h_x_mult or 1
			context.other_card.ability.perma_h_x_mult = context.other_card.ability.perma_h_x_mult + card.ability.extra.h_Xmult_gain
			return {
				message = 'Upgraded!',
				card = context.other_card,
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'etericyclys',
	loc_txt = {
		name = 'Etericyclys',
		text = {
			"When a {C:attention}Playing Card{} is {C:mult}destroyed{}",
			"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:attention}copies{} of it",
			"and add them to your {C:attention}hand{}",
			"{C:green}#2# in #3#{} chance to {C:attention}increase{} number of {C:attention}copies{}",
			"by {C:attention}#4#{} when triggered"
		}
	},
	rarity = 'cry_exotic',
	atlas = 'cry_joker1',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	blueprint_compat = true,
	config = { extra = { copies = 2, odds = 15, copies_gain = 1 } },
	cost = 50,
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.copies, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.copies_gain } }
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({ trigger = 'after', func = function()
				for k, v in pairs(context.removed) do
					for i=1, card.ability.extra.copies, 1 do
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _card = copy_card(v, nil, nil, G.playing_card)
						_card:add_to_deck()
						_card:set_edition({negative = true})
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _card)
						G.hand:emplace(_card)
						_card:start_materialize(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
			return true end}))
			if pseudorandom('may_etericyclys') < G.GAME.probabilities.normal / card.ability.extra.odds then
				card.ability.extra.copies = card.ability.extra.copies + card.ability.extra.copies_gain
				return {
					message = 'Upgraded!',
					card = card,
				}
			end
		end
	end
}

if may.conf.content.FusionJokers then
-- Interdimensional
SMODS.Joker {
	key = "hypersphere",
	loc_txt = {
		name = 'Hypersphere',
		text = {
			"{X:purple,C:white}^#1#pi{} Mult & Chips",
			"Scoring {C:attention}3s, Aces and 4s{}",
			"give {X:purple,C:white}^^#2#pi{} Mult & Chips",
			"{C:inactive,s:0.5}Universal Collapse + Circulus Pistoris{}"
		}
	},
	config = { extra = { EEmult = 1, EEchips = 1, Emult = 1, Echips = 1 } },
	pos = { x = 9, y = 0 },
	soul_pos = { x = 10, y = 0 },
	rarity = "may_interdimensional",
	cost = 314159,
	blueprint_compat = true,
	atlas = "cry_joker1",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult, card.ability.extra.EEmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Echip_mod = card.ability.extra.Emult * math.pi,
				Emult_mod = card.ability.extra.Emult * math.pi,
				message = "^"..card.ability.extra.Emult.."pi Mult & Chips",
				colour = G.C.PURPLE,
				card = card,
				sound = 'may_eboth'
			}
		end
	  if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 3 or context.other_card:get_id() == 14 or context.other_card:get_id() == 4 then
				return {
				ee_chips = card.ability.extra.EEmult * math.pi,
				ee_mult = card.ability.extra.EEmult * math.pi,
				card = context.other_card,
				}
			end
		end
	end
}

if may.conf.content.WIP then

SMODS.Joker {
	key = 'mortuary',
	loc_txt = {
		name = 'Mortuary',
		text = {
		"{C:attention}+#1#{} joker slots",
		"Earn {C:money}$#2#{} at the {C:attention}end of round{}",
		"{X:purple,C:white}^^#3#{} Mult & Chips",
		"{C:green}Saves you{} when losing if you earned at least {C:attention}50%{} of required score",
		"{C:mult}Self destructs{}"
		}
	},
	config = { extra = { slots = 45, dollars = 250, EEmultchips = 1.25 } },
	pos = { x = 0, y = 0 },
	cost = 100000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	misc_badge = may_wip_badge,
	atlas = 'placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.slots, card.ability.extra.dollars, card.ability.extra.EEmultchips,}}
    end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if not Talisman.config_file.disable_anims then
			end
			return {
				EEchip_mod = card.ability.extra.EEmultchips,
				EEmult_mod = card.ability.extra.EEmultchips,
				card = card,
				message = '^^'.. card.ability.extra.EEmultchips .. ' Mult & Chips',
				colour = G.C.PURPLE,
				sound = 'may_eeboth'
			}
		end
		if context.game_over and G.GAME.chips/G.GAME.blind.chips >= 0.5 then
			G.E_MANAGER:add_event(Event({func = function()
				G.hand_text_area.blind_chips:juice_up()
				G.hand_text_area.game_chips:juice_up()
				play_sound('tarot1')
				self:start_dissolve()
			return true end})) 
			return {
				message = localize('k_saved_ex'),
				saved = true,
				colour = G.C.RED
			}
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end
}

end

-- Ethereal

if may.conf.content.WIP then

SMODS.Joker {
	key = 'artis_optima',
	loc_txt = {
		name = 'Artis Optima',
		text = {
		"{C:attention}Retriggers{} all {C:attention}jokers{}",
		"{C:attention}#1#{} times{}",
		"for {C:attention}every{} owned {C:attention}joker{}"
		}
	},
	config = { extra = { amount = 2 } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_ethereal',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	misc_badge = may_wip_badge,
	atlas = 'placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount}}
    end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and context.other_card ~= card then
			return {
				message = 'Again!',
				card = card,
				repetitions = card.ability.extra.amount * #G.jokers.cards
			}
		end
	end
}

end

end

-- Cryptid Decks

if may.conf.content.WIP then

SMODS.Back {
	name = "Universal Fabric Deck",
	key = "universal_fabric_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_wip_badge,
	config = { vouchers = { 'v_may_exoplanet' } },
	loc_txt = {
		name = "Universal Fabric Deck",
		text = {
			"Applies the {C:legendary,E:1}upsides{}",
			"of {C:attention}every{} {C:spectral}Cryptid{},",
			"{C:mult}Mayhem{} and {C:green}Vanilla{} deck",
			"{C:inactive}(Antimatter Deck, Ascended and Transcendent decks excluded){}"
		},
    },
	apply = function(self)
		-- Blue Deck and Rainbow Deck
		G.GAME.starting_params.hands = G.GAME.starting_params.hands + 2
		if not consumable_table or type(consumable_table) ~= "table" then
			consumable_table = {}
		end
		table.insert(consumable_table, "c_fool")
		table.insert(consumable_table, "c_fool")
		table.insert(consumable_table, "c_hex")
		if #consumable_table > 0 then
			delay(0.4)
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(consumable_table) do
					if G.P_CENTERS[v] then
						local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, v, "deck")
						card:add_to_deck()
						G.consumeables:emplace(card)
					end
				end
			return true end}))
		end
		-- Yellow Deck and Rainbow Deck
		G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + 20
		-- Abandoned Deck
		G.GAME.starting_params.no_faces = true
		G.GAME.spectral_rate = 2
		G.GAME.starting_params.discards = G.GAME.starting_params.discards + 2
		local vouchers = Cryptid.get_antimatter_vouchers(nil, skip)
		if #vouchers > 0 then
			for k, v in pairs(vouchers) do
				if G.P_CENTERS[v] then
					G.GAME.used_vouchers[v] = true
					G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
					G.E_MANAGER:add_event(Event({func = function()
						Card.apply_to_run(nil, G.P_CENTERS[v])
					return true end}))
				end
			end
		end
		-- Checkered Deck
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in pairs(G.playing_cards) do
				if v.base.suit == "Clubs" then
					v:change_suit("Spades")
				end
				if v.base.suit == "Diamonds" then
					v:change_suit("Hearts")
				end
			end
		return true end}))
		-- Black Deck
		G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
		-- Painted Deck
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 2
		-- Green Deck and Rainbow Deck
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
		G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + 2
		-- Spooky Deck
		G.GAME.modifiers.cry_spooky = true
		G.GAME.modifiers.cry_curse_rate = 0
		if Cryptid.enabled("j_cry_chocolate_dice") == true then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_chocolate_dice")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
				end
			return true end}))
		end
		-- Deck of Equilibrium
		G.GAME.modifiers.cry_equilibrium = true
		-- Misprint Deck
		G.GAME.modifiers.cry_misprint_min = 1
		G.GAME.modifiers.cry_misprint_max = 10
		-- Infinite Deck
		G.hand:change_max_highlight(1e20)
		-- also Orange Deck
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 2
		-- Wormhole deck
		G.GAME.modifiers.cry_negative_rate = 20
		if Cryptid.enabled("set_cry_exotic") == true then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card =
						create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_wormhole")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
				end
			return true end}))
		end
		-- Redeemed deck
		G.GAME.modifiers.cry_redeemed = true
		--Legendary Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
			end
		return true end}))
		--Encoded Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				if G.P_CENTERS["j_cry_CodeJoker"] and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_CodeJoker"]) and Cryptid.enabled("j_cry_CodeJoker") == true then
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_CodeJoker")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
				end
				if G.P_CENTERS["j_cry_copypaste"] and Cryptid.enabled("j_cry_copypaste") == true and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_copypaste"]) then
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_copypaste")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
				end
			end
		return true end}))
		--Beige Deck
		G.GAME.modifiers.cry_common_value_quad = true
		-- Pink Deck and Rainbow Deck
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 0.8 * 0.9
		-- Lime Deck
		SMODS.change_voucher_limit(1)
		-- Brown Deck
		G.GAME.playing_card_multiplier = 10
		-- Gray Deck
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
			end
		return true end}))
		-- Turqoise Deck
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = 25
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end}))
		-- Blurple Deck and Rainbow Deck
		G.E_MANAGER:add_event(Event({func = function()
			for i=1, 2, 1 do
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'blurple_deck')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			end
		return true end}))
		-- Monochrome Deck
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
			card2:set_edition({negative = true}, false, false)
			G.jokers:emplace(card2)
			card2:add_to_deck()
			for i=1, 4, 1 do
				local copy = copy_card(card2, nil)
				G.jokers:emplace(copy)
				copy:add_to_deck()
				copy:set_edition({negative = true}, false, false)
			end
			play_sound('holo1')
		return true end}))
		-- AAAA Deck
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				assert(SMODS.change_base(v, nil, 'Ace'))
			end
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_AAAA', 'may_aaaa_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
		-- Unstable Deck
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_unstable_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound("may_thunder"..math.random(1,2))
		return true end}))
		-- Mythic Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_mythic", nil, nil, nil, "may_mythic_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_mythic_joker')
			end
		return true end}))
		-- Transcendent Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_transcendent", nil, nil, nil, "may_transcendent_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_transcendent_joker')
				if card.config.center.key == 'j_may_party_time' then
					if Incantation then
						local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_deck")
						card:add_to_deck()
						card:setQty(40)
						card:start_materialize()
						G.consumeables:emplace(card)
						card:set_edition({negative = true}, false, false)
					else
						for i=1, 40, 1 do
							local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_deck")
							card:add_to_deck()
							card:start_materialize()
							G.consumeables:emplace(card)
							card:set_edition({negative = true}, false, false)
						end
					end
					play_sound('holo1')
				end
			end
		return true end}))
		-- Surreal Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_surreal", nil, nil, nil, "may_surreal_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_surreal_joker')
			end
		return true end}))
		-- Interdimensional Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_interdimensional", nil, nil, nil, "may_interdimensional_deck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_interdimensional_joker')
			end
		return true end}))
		-- Ethereal Deck
		G.E_MANAGER:add_event(Event({func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_etherealdeck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_ethereal_joker')
			end
		return true end}))
	end,
	calculate = function(self, card, context)
		-- Purple Deck
		if context.open_booster and G.GAME.pack_choices + 1 <= G.GAME.pack_size then
			G.GAME.pack_choices = G.GAME.pack_choices + 1
		end
		-- Power Deck
		if context.after and pseudorandom('may_power_deck') < G.GAME.probabilities.normal / 10 then
			mod_score_operator(-1, 1, false)
		end
		-- Plasma Deck
		if context.final_scoring_step then
			hand_chips = mod_chips(math.floor((hand_chips + mult)/2))
			mult = mod_mult(math.floor((hand_chips + mult)/2))
			jl.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
				ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
				jl.a(localize('k_balanced'), 2, 1.4) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
					G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
				return true end}))
			return true end)}))
		end
		-- Glowing Deck
		if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
			for i = 1, #G.jokers.cards do
				Cryptid.with_deck_effects(G.jokers.cards[i], function(card) 
					Cryptid.misprintize(card, { min = 1.25, max = 1.25 }, nil, true)
				end)
			end
			-- Legendary Deck (again)
			if G.jokers then
				if #G.jokers.cards < G.jokers.config.card_limit then
					local legendary_poll = pseudorandom(pseudoseed("cry_legendary"))
					legendary_poll = legendary_poll / (G.GAME.probabilities.normal or 1)
					if legendary_poll < 0.2 then
						local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "")
						card:add_to_deck()
						card:start_materialize()
						G.jokers:emplace(card)
						return true
					else
						card_eval_status_text(G.jokers, "jokers", nil, nil, nil, { message = localize("k_nope_ex"), colour = G.C.RARITY[4] }
						)
					end
				else
					card_eval_status_text(G.jokers, "jokers", nil, nil, nil, { message = localize("k_no_room_ex"), colour = G.C.RARITY[4] })
				end
			end
			-- Anaglyph Deck
			G.E_MANAGER:add_event(Event({func = function()
				add_tag(Tag("tag_double"))
				play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
				play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
			return true end}))
		end
		-- Stellar deck
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_matakka', 'may_stellar_deck')
				card2:set_edition({negative = true})
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(0.3, 0.5)
			return true end}))
		end
	end
}

end

end


-- CardSleeves CM
if CardSleeves and may.conf.content.WIP then

SMODS.Atlas {
	key = "cardsleeves",
	path = "cardsleeves.png",
	px = 73,
	py = 95
}

CardSleeves.Sleeve {
	key = 'orange_sleeve',
	atlas = 'may_cardsleeves',
	pos = { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_orange_deck" then
			key = self.key .. "_alt"
			self.config = { hand_size = 2 }
		else
			key = self.key
			self.config = { hand_size = 1 }
		end
		vars = { self.config.hand_size }
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
	end
}

CardSleeves.Sleeve {
	key = 'purple_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_purple_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	calculate = function(self, sleeve, context)
		if self.get_current_deck_key() ~= "b_may_purple_deck" then
			if context.open_booster and G.GAME.pack_choices + 1 <= G.GAME.pack_size then
				G.GAME.pack_choices = G.GAME.pack_choices + 1
			end
		else
			if context.open_booster then
				G.GAME.pack_choices = G.GAME.pack_size
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'pink_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_pink_deck" then
			key = self.key .. "_alt"
			self.config = { blind_size = 0.7 }
		else
			key = self.key
			self.config = { blind_size = 0.8 }
		end
		vars = { self.config.blind_size }
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.blind_size
		if self.get_current_deck_key() == "b_may_pink_deck" then
			G.GAME.purple_sleeve_alt = true
		end
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and G.GAME.blind.boss and G.GAME.purple_sleeve_alt then
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = G.GAME.blind.chips:arrow(1, card.ability.extra.size)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
				delay(0.4)
			return true end}))
		end
	end
}


CardSleeves.Sleeve {
	key = 'lime_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_lime_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		SMODS.change_voucher_limit(1)
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and self.get_current_deck_key() == "b_may_lime_deck" then
			for k, v in pairs(G.playing_cards) do
				v:set_seal('may_copper_seal', true, true)
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'brown_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },	
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_brown_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.playing_card_multiplier = 10
	end,
	calculate = function(self, sleeve, context)
		if context.individual and context.cardarea == G.play and self.get_current_deck_key() == "b_may_brown_deck" then
			if context.other_card.ability.name ~= 'Stone Card' and context.other_card:get_id() > 0 then
				return {
					x_chips = context.other_card:get_id(),
					card = context.other_card,
				}
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'gray_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },	
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_gray_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
			end
		return true end}))
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and self.get_current_deck_key() == "b_may_gray_deck" then
			for k, v in ipairs(G.playing_cards) do
				if not v.seal then
					v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_sleeve" }), true, false)
				end
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'turqoise_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_turqoise_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = 25
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end}))
	end,
	calculate = function(self, sleeve, context)
		if context.buying_card and self.get_current_deck_key() == "b_may_turqoise_deck" then
			if pseudorandom('may_turqoise_sleeve_alt') < 1 / 5 then
				ease_dollars(context.card.cost)
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'blurple_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_blurple_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_blurple_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'blurple_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, true, 4, false, nil, nil, 'blurple_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		end
	end
}

CardSleeves.Sleeve {
	key = 'monochrome_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_monochrome_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_monochrome_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
				card2:set_edition({negative = true}, false, false)
				G.jokers:emplace(card2)
				card2:add_to_deck()
				for i=1, 4, 1 do
					local copy = copy_card(card2, nil)
					G.jokers:emplace(copy)
					copy:add_to_deck()
					copy:set_edition({negative = true}, false, false)
				end
				play_sound('holo1')
			return true end}))
		end
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and G.GAME.blind.boss and self.get_current_deck_key() == "b_may_monochrome_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
				card2:set_edition({negative = true}, false, false)
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		end
	end
}

CardSleeves.Sleeve {
	key = 'rainbow_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_rainbow_deck" then
			key = self.key .. "_alt"
			self.config = { extra_discard_bonus = 1 }
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_rainbow_deck" then
			G.GAME.starting_params.hand_size = 8 + 1
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*0.9
			G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'rainbow_deck')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.discount_percent = 25
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
			return true end}))
			G.GAME.playing_card_multiplier = 10
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
				end
			return true end}))
		end
	end,
	calculate = function(self, sleeve, context)
		if context.open_booster and self.get_current_deck_key() == "b_may_rainbow_deck" and G.GAME.pack_choices + 1 <= G.GAME.pack_size  then
			G.GAME.pack_choices = G.GAME.pack_choices + 1
		end
	end
}

CardSleeves.Sleeve {
	key = 'aaaa_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_aaaa_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_aaaa_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					assert(SMODS.change_base(v, nil, 'Ace'))
				end
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_AAAA', 'may_aaaa_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					assert(SMODS.change_base(v, nil, self.config.rank))
				end
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_acum', 'may_aaaa_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
				play_sound('may_transcendent_joker')
			return true end}))
		end
	end,
}

CardSleeves.Sleeve {
	key = 'unstable_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_unstable_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_unstable_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_unstable_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound("may_thunder"..math.random(1,2))
			return true end}))
		else
			G.GAME.may_unstable_sleeve_alt = true
		end
	end,
}

CardSleeves.Sleeve {
	key = 'stellar_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_stellar_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	calculate = function(self, back, context)
		if context.setting_blind and self.get_current_deck_key() ~= "b_may_stellar_deck" then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_matakka', 'may_stellar_sleeve')
				card2:set_edition({negative = true})
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(0.3, 0.5)
			return true end}))
		end
		if context.level_up_hand and self.get_current_deck_key() == "b_may_stellar_deck" then
			hand_mod_lvl_multchips(context.hand, 'multchips', 0, 2*context.amount, context.silent)
		end
	end
}

CardSleeves.Sleeve {
	key = 'mythic_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_mythic_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_mythic_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_mythic", nil, nil, nil, "may_mythic_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_mythic_joker')
				end
			return true end}))
		end
	end,
	calculate = function(self, back, context)
		if context.other_joker and context.other_joker.config.center.rarity == 'may_mythic' then
			G.E_MANAGER:add_event(Event({func = function()
				context.other_joker:juice_up()
			return true end}))
			return {
				EEmult_mod = 3,
				message = '^^3 Mult',
				colour = G.C.RED,
				card = back,
			}
		end
	end
}

CardSleeves.Sleeve {
	key = 'transcendent_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -1, discards = -1 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_transcendent_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_transcendent_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_transcendent", nil, nil, nil, "may_transcendent_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_transcendent_joker')
					if card.config.center.key == 'j_may_party_time' then
						if Incantation then
							local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_sleeve")
							card:add_to_deck()
							card:setQty(40)
							card:start_materialize()
							G.consumeables:emplace(card)
							card:set_edition({negative = true}, false, false)
						else
							for i=1, 40, 1 do
								local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_sleeve")
								card:add_to_deck()
								card:start_materialize()
								G.consumeables:emplace(card)
								card:set_edition({negative = true}, false, false)
							end
						end
						play_sound('holo1')
					end
				end
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_interdimensional", nil, nil, nil, "may_transcendent_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_interdimensional_joker')
				end
			return true end}))
		end
	end,
}

CardSleeves.Sleeve {
	key = 'surreal_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -2 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_surreal_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_surreal_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_surreal", nil, nil, nil, "may_surreal_deck")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_surreal_joker')
				end
			return true end}))
		else
			G.GAME.may_surreal_sleeve_alt = true
		end
	end,
}

CardSleeves.Sleeve {
	key = 'interdimensional_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -1, discards = -1, joker_slot = -1, hand_size = -1 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_interdimensional_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_interdimensional_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_mythic", nil, nil, nil, "may_mythic_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_mythic_joker')
				end
			return true end}))
		else
			G.GAME.may_interdimensional_sleeve_alt = true
		end
	end,
}

CardSleeves.Sleeve {
	key = 'ethereal_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = 2, discards = 2, joker_slot = 3 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_ethereal_deck" then
			key = self.key .. "_alt"
			self.config = { hands = 2, discards = 2, joker_slot = 3 }
		else
			key = self.key
			self.config = { hands = -2, discards = -2, joker_slot = -3 }
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		CardSleeves.Sleeve.apply(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_ethereal_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_etherealdeck")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_ethereal_joker')
				end
			return true end}))
		end
	end,
}

CardSleeves.Sleeve {
	key = 'power_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_power_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	calculate = function(self, back, context)
		if context.after and pseudorandom('may_power_sleeve') < G.GAME.probabilities.normal / 10 and self.get_current_deck_key() ~= "b_may_power_deck" then
			mod_score_operator(-1, 1, false)
		end
		if context.setting_blind and G.GAME.blind.boss and self.get_current_deck_key() == "b_may_power_deck" then
			mod_score_operator(-1, 1, false)
		end
	end
}

end

-- Blind Editions CM
if SMODS.BlindEdition and may.conf.CM.BlindEditions then

-- Idea of adding sounds to blind editions was *borrowed* from POLTERWORX
SMODS.BlindEdition:take_ownership('ble_foil', {
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('foil1')
			SMODS.juice_up_blind()
		return true end}))
	end
})

SMODS.BlindEdition:take_ownership('ble_holographic', {
	set_blind = function(self, blind_on_deck)
		G.hand:change_size(-1)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('holo1', 1.2*1.58)
			SMODS.juice_up_blind()
		return true end}))
	end
})

SMODS.BlindEdition:take_ownership('ble_polychrome', {
	set_blind = function(self, blind_on_deck)
		ease_hands_played(-1)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('polychrome1', 1.2)
			SMODS.juice_up_blind()
		return true end}))
	end,
})

SMODS.BlindEdition {
	key = 'shimmering',
	blind_shader = 'may_shimmering',
	loc_txt = {
		name = "Shimmering",
		text = {"-1 Discard"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_discard(-1)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_shimmering')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.5,
}

SMODS.BlindEdition {
	key = 'amber',
	blind_shader = 'may_amber',
	loc_txt = {
		name = "Amber",
		text = {"Apply Rental to a random Joker"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_amber')
			SMODS.juice_up_blind()
			if #G.jokers.cards ~= 0 then
				G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
					local joker = pseudorandom_element(G.jokers.cards, pseudoseed('may_hourglass'))
					play_sound("tarot1")
					joker:set_rental(true)
				return true end}))
			end
		return true end}))
	end,
	weight = 0.4,
}

--[[SMODS.BlindEdition {
	key = 'reverse',
	blind_shader = 'may_reverse',
	loc_txt = {
		name = "Reverse",
		text = {"-3 Discards and +1 Hand"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_discard(-3)
		ease_hands_played(1)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_reverse')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.5,
}]]

if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then

SMODS.BlindEdition {
	key = 'misprint',
	blind_shader = 'may_misprint',
	loc_txt = {
		name = "Misprint",
		text = {"nil"}
	},
	contrast = 3,
	loc_vars = function (self, info_queue, card)
		return { main_start = { 
			-- im sorry yet again
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 0.8,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 5,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = math.random(1, 3),
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 2,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = randtext,
						colours = { G.C.BLACK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.1,
						scale = 0.4,
						min_cycle_time = 0.1,
					}),
				},
			}
		} }
	end,
	set_blind = function(self, blind_on_deck)
		ease_discard(-math.random(-3, 5))
		ease_hands_played(-math.random(-3, 5))
		local hand_size = math.random(-5, 3)
		G.hand:change_size(hand_size)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + hand_size
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_misprint')
			SMODS.juice_up_blind()
			G.GAME.blind.chips = G.GAME.blind.chips:mul(math.random(0.3, 1.8))
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
			play_sound('may_blind_size')
		return true end}))
	end,
	weight = 0.2,
}

end

SMODS.BlindEdition {
	key = 'goldfoil',
	blind_shader = 'may_goldfoil',
	loc_txt = {
		name = "Goldfoil",
		text = {"-5$"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_goldfoil')
			SMODS.juice_up_blind()
			ease_dollars(-5)
		return true end}))
	end,
	weight = 0.6,
}

SMODS.BlindEdition {
	key = 'print',
	blind_shader = 'may_print',
	loc_txt = {
		name = "Print",
		text = {"Blind gives no reward money"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_print')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.4,
	dollars_mod = function(self, dollars)
		return 0
	end
}

SMODS.BlindEdition {
	key = 'nostalgic',
	blind_shader = 'may_nostalgic',
	loc_txt = {
		name = "Nostalgic",
		text = {"+1 Ante"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_ante(1)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_nostalgic')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.2,
}

SMODS.BlindEdition {
	key = 'cosmic',
	blind_shader = 'may_cosmic',
	loc_txt = {
		name = "Cosmic",
		text = {"Sets level of most played", "Poker Hand to 1"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_cosmic')
			SMODS.juice_up_blind()
			jl.th(jl.favhand())
			level_up_hand(nil, jl.favhand(), nil, -G.GAME.hands[jl.favhand()].level+1)
			jl.ch()
		return true end}))
	end,
	weight = 0.1,
}

SMODS.BlindEdition {
	key = 'omega',
	blind_shader = 'may_omega',
	loc_txt = {
		name = "Omega",
		text = {"^^1.177 Blind Size"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.GAME.blind.chips = G.GAME.blind.chips:arrow(2, 1.177)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_omega')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.02,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.BlindEdition {
	key = 'otherworldly',
	blind_shader = 'may_otherworldly',
	loc_txt = {
		name = "Otherworldly",
		text = {"^^^1.5 Blind Size"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.GAME.blind.chips = G.GAME.blind.chips:arrow(3, 1.5)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_e_otherworldly')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.002,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 8
	end
}

end

-- Grim CM

if may.conf.CM.Grim and #SMODS.find_mod('GRM') ~= 0 then

-- Custom XP sound and XP hyperoperations
-- overwriting because grim likes being annoying
function add_skill_xp(amount, card, message_, no_mod, arrow)
	if G.GAME then
		local message = true
		if message_ ~= nil then
			message = message_
		end
		if not no_mod then
			amount = get_modded_xp(amount)
		end
		if not arrow then arrow = -1 end
		if arrow == -1 then
			G.GAME.skill_xp = G.GAME.skill_xp + amount
		else
			G.GAME.skill_xp = to_number(to_big(G.GAME.skill_xp):arrow(arrow, amount))
		end
		check_for_unlock({type = 'skill_check', total_xp = G.GAME.skill_xp})
		if skill_active("sk_grm_ghost_1") then
			G.GAME.ghost_skill_xp = G.GAME.ghost_skill_xp + amount
			if G.GAME.ghost_skill_xp > 200 then
				local spectrals = math.floor(G.GAME.ghost_skill_xp / 200)
				G.GAME.ghost_skill_xp = G.GAME.ghost_skill_xp - (200 * spectrals)
				spectrals = math.min(spectrals, G.consumeables.config.card_limit - #G.consumeables.cards)
				if spectrals > 0 then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.0,
						func = (function()
								spectrals = math.min(spectrals, G.consumeables.config.card_limit - #G.consumeables.cards)
								if spectrals > 0 then
									for i = 1, spectrals do
										local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'ghost')
										card:add_to_deck()
										G.consumeables:emplace(card)
									end
								end
								return true
						end)}))
				end
			end
		end
		if card and message and (amount ~= 0) then
			if arrow == -1 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='gain_xp',vars={amount}},colour = G.C.PURPLE, delay = 0.45})
			elseif arrow == 0 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='mult_xp',vars={amount}},colour = G.C.PURPLE, delay = 0.45})
			else
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='hyp_xp',vars={generate_arrow_text(arrow), amount}},colour = G.C.PURPLE, delay = 0.45})
			end
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('may_grim_xp')
				return true end}))
			end
		end
	end
end

if not SMODS.ObjectTypes.H then
	SMODS.ObjectType {
		key = 'H',
		default = 'j_may_h',
		cards = {},
	}
end


function may.is_h(card, below_legendary)
	local center = type(card) == "string" and G.P_CENTERS[card] or (card.config and card.config.center)
	if not center then return false end
	if not below_legendary then
		if center.pools and center.pools.H then
			return true
		end
	else
		if center.pools and center.pools.H and type(center.rarity) == 'number' and center.rarity < 4 then
			return true
		end
	end
end

-- Grim Atlases

SMODS.Atlas {
	key = 'grm_joker1',
	path = 'cm/GRM/grm_joker1.png',
	px = 71,
	py = 95
}

-- Grim sounds

SMODS.Sound({key = 'grim_xp', path = 'grim_xp.ogg'})

-- Grim Jokers

-- Common

SMODS.Joker {
	key = 'faulty_joker',
	loc_txt = {
		name = 'Faulty Joker',
		text = {
			"{C:purple}+#1#{} XP if played hand",
			"contains a {C:attention}#2#{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	config = { extra = { XP = 50, hand = 'Pair' } },
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 3, y = 1 },
	blueprint_compat = true,
	cost = 3,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.XP, card.ability.extra.hand } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if context.poker_hands ~= nil and (context.poker_hands[card.ability.extra.hand] and next(context.poker_hands[card.ability.extra.hand])) then
				add_skill_xp(card and card.ability.extra.XP or 50, card)
			end
		end
		if context.forcetrigger then
			add_skill_xp(card and card.ability.extra.XP or 50, card)
		end
	end
}

SMODS.Joker {
	key = 'hurry',
	loc_txt = {
		name = 'Hurry',
		text = {
			"{C:chips}+#1#{} Chips if played hand is {C:attention}High Card{}",
			"{C:attention}Increases{} by {C:chips}#2#{} for {C:attention}each unscored card{} in played hand",
			"Create a {C:dark_edition}Faulty Joker{} when {C:chips}Chips{} reach {C:chips}#3#{}",
			"{C:inactive}(#4#, requires room){}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	config = { extra = { chips = 16, chips_gain = 16, requirement = 160, active = true } },
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 0, y = 1 },
	blueprint_compat = true,
	cost = 4,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.requirement, card.ability.extra.active and 'Active' or 'Inactive' } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.current_round.current_hand.handname == "High Card" then
				return {
					hand_chips = card.ability.extra.chips,
					colour = G.C.CHIPS,
					card = card,
				}
			end
		end
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local cards = 0
			for k, v in ipairs(context.scoring_hand) do
				v.may_hurry_incompat = true
			end
			for k, v in ipairs(context.full_hand) do
				if not v.may_hurry_incompat then
					cards = cards + 1
					G.E_MANAGER:add_event(Event({func = function()
						v:juice_up()
					return true end}))
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v.may_hurry_incompat = nil
			end
			card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chips_gain * cards)
			if card.ability.extra.chips >= card.ability.extra.requirement and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.ability.extra.active then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hurry')
				G.jokers:emplace(card2)
				play_sound('holo1')
				card2:add_to_deck()
				card.ability.extra.active = false
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card,
			}
		end
		if context.forcetrigger then
			return {
				hand_chips = card.ability.extra.chips,
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end
}

if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then

SMODS.Joker {
	key = 'hate',
	loc_txt = {
		name = 'Hate',
		text = {
			"{C:may_ethereal}Force-trigger{} all {C:dark_edition}Faulty Jokers{}",
			"if played hand is {C:attention}High Card{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = {} }
	end,
	blueprint_compat = true,
	cost = 4,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.current_hand.handname == "High Card" or context.forcetrigger then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:gc().key == 'j_may_faulty_joker' then
					if Cryptid.demicolonGetTriggerable(G.jokers.cards[i])[1] then
						local results = Cryptid.forcetrigger(G.jokers.cards[i], context)
						if results and results.jokers then
							results.jokers.message = localize("cry_demicolon")
							results.jokers.colour = G.C.RARITY.cry_epic
							results.jokers.sound = "cry_demitrigger"
							return results.jokers
						end
						return {
							message = localize("cry_demicolon"),
							colour = G.C.RARITY.cry_epic,
							sound = "cry_demitrigger",
						}
					end
				end
			end
		end
	end
}

end

-- Uncommon

SMODS.Joker {
	key = 'minimalistic_h',
	loc_txt = {
		name = 'Minimalistic H',
		text = {
			"{X:purple,C:white}X#1#{} XP if hand contains only {C:attention}1 card{}",
			"{C:mult}without{} a {C:attention}suit or rank{}",
			"{C:mult}Self destructs{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	config = { extra = { X_XP = 2 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 1, y = 1 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.X_XP } }
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers or context.forcetrigger then
			if #G.play.cards == 1 then
				if SMODS.has_no_suit(G.play.cards[1]) and SMODS.has_no_rank(G.play.cards[1]) then
					add_skill_xp(card and card.ability.extra.X_XP or 2, card, nil, nil, 0)
					G.E_MANAGER:add_event(Event({func = function()
						self = card
						play_sound('tarot1')
						message = "Faded!"
						self:juice_up(0.3, 0.4)
						self.states.drag.is = true
						self.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
							G.jokers:remove_card(self)
							self:remove()
							self = nil
						return true end})) 
					return true end}))
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'hexing',
	loc_txt = {
		name = 'Hexing',
		text = {
			"Make an {C:dark_edition}Amber Faulty Joker{} when an",
			"{C:dark_edition}H{} {C:attention}Joker{} is {C:attention}sold{}",
			"{C:mult}Self destructs{} after {C:attention}#1# triggers{}",
			"{C:inactive}(requires room){}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { triggers = 3 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 3, y = 0 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_may_amber']
		return { vars = { card.ability.extra.triggers } }
	end,
	calculate = function(self, card, context)
		if (context.selling_card and context.card.ability.set == "Joker" and may.is_h(context.card) and not context.blueprint) or context.forcetrigger then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hexing')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({may_amber = true}, false, false)
			card.ability.extra.triggers = card.ability.extra.triggers - 1
			if card.ability.extra.triggers <= 0 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
					play_sound('tarot1')
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
			end
		end
	end
}

-- Rare

SMODS.Joker {
	key = 'horned_melon',
	loc_txt = {
		name = 'Horned Melon',
		text = {
			"{C:attention}Gains{} {C:purple}+#1#{} XP when a {C:dark_edition}Food Joker{} is {C:attention}sold{}",
			"{C:inactive}Currently{} {C:purple}+#2#{} {C:inactive}XP{}",
			"{C:inactive,E:1,s:0.5}original idea by _TeKKen_{}"
		}
	},
	config = { extra = { XP_gain = 100, XP = 0 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 4, y = 0 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true, Food = true, },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.XP_gain, card.ability.extra.XP } }
	end,
	calculate = function(self, card, context)
		if (context.selling_card and context.card.ability.set == "Joker" and may.is_food(context.card) and not context.blueprint) or context.forcetrigger then
			card.ability.extra.XP = card.ability.extra.XP + card.ability.extra.XP_gain
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
		if context.joker_main then
			add_skill_xp(card and card.ability.extra.XP or 0, card)
		end
	end
}

SMODS.Joker {
	key = 'h',
	loc_txt = {
		name = 'H',
		text = {
			"Make {C:attention}#1#{} {C:dark_edition}Foil Faulty Jokers{} after {C:attention}#2# High Cards{} are played,",
			"then {C:attention}increase{} the number of {C:dark_edition}Faulty Jokers{} and {C:attention}High Cards{} by {C:attention}#3#{}",
			"{C:inactive}#4# High Cards played so far, requires room{}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		},
	},
	rarity = 3,
	atlas = 'grm_joker1',
	pos = { x = 1, y = 0 },
	config = { extra = { faulty = 1, high_card = 5, increase = 1, played = 0} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
		return { vars = {card.ability.extra.faulty, card.ability.extra.high_card, card.ability.extra.increase, card.ability.extra.played} }
	end,
	blueprint_compat = true,
	cost = 18,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.before and G.GAME.current_round.current_hand.handname == "High Card" then
			card.ability.extra.played = card.ability.extra.played + 1
			if card.ability.extra.played == math.floor(card.ability.extra.high_card) then
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
					for i=1, card.ability.extra.faulty, 1 do
						local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hexing')
						G.jokers:emplace(card2)
						card2:add_to_deck()
						card2:set_edition({foil = true}, false, false)
					end
				end
				card.ability.extra.high_card = card.ability.extra.high_card + card.ability.extra.increase
				card.ability.extra.faulty = card.ability.extra.faulty + card.ability.extra.increase
				return {
					message = 'Upgraded!',
					card = card,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'h_lowercase',
	loc_txt = {
		name = 'h',
		text = {
			"{X:purple,C:white}X#1#{} XP when {C:dark_edition}Faulty Joker{} is {C:attention}sold{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = { card.ability.extra.X_XP } }
	end,
	config = { extra = { X_XP = 1.8 } },
	rarity = 3,
	atlas = 'grm_joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { H = true },
	pos = { x = 0, y = 0 },
	cost = 18,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and context.card:gc().key == 'j_may_faulty_joker' then
			add_skill_xp(card and card.ability.extra.X_XP or 1.8, card, nil, nil, 0)
		end
		if context.forcetrigger then
			add_skill_xp(card and card.ability.extra.X_XP or 1.8, card, nil, nil, 0)
		end
	end
}

end

-- Debug tools
if may.conf.Debug then

	local goog = to_big(1e100)
	
	-- added this way before the Alt+f5 shortcut and I've gotten used to it because contrary to popular belief im a human
	SMODS.Keybind {
		key_pressed = '`',
		action = function(self)
			SMODS.restart_game()
		end
	}

	SMODS.Keybind {
		key_pressed = 'p',
		action = function(self)
			hypermoney(10, 100)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'h',
		action = function(self)
			hypermoney(1, 3)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'n',
		action = function(self)
			hypermoney(2, 3)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ',',
		action = function(self)
			hypermoney(3, 3)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '6',
		action = function(self)
			if may.conf.Mode == 1 then
				may.conf.Mode = 2
			else
				may.conf.Mode = 1
			end
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f1',
		action = function(self)
			mult = mod_mult((G.ARGS.score_intensity.required_score+1)*to_big(1e101))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f2',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(1, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f3',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(2, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f4',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(3, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f5',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(4, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f6',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(5, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f7',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(6, to_big(1e101)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f8',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(7, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f9',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(10, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f10',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(70, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f11',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(200, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(1000, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'a',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(2000, to_big(1e101):arrow(1, 10)))
			hand_chips = mod_chips((to_big(G.ARGS.score_intensity.required_score+1)):arrow(2000, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
			jl.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '.',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(3000, to_big(1e101):arrow(1, 10)))
			hand_chips = mod_chips((to_big(G.ARGS.score_intensity.required_score+1)):arrow(3000, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
			jl.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '=',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(4000, to_big(1e101):arrow(1, 10)))
			hand_chips = mod_chips((to_big(G.ARGS.score_intensity.required_score+1)):arrow(4000, to_big(1e101):arrow(1, 10)))
			jl.hm(mult)
			jl.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '+',
		action = function(self)
			level_up_hand(G.jokers[1], 'High Card', nil, 1)
			jl.ch()
		end
	}
	
	SMODS.Keybind {
		key_pressed = '-',
		action = function(self)
			level_up_hand(G.jokers[1], 'High Card', nil, -1)
			jl.ch()
		end
	}
	
	SMODS.Keybind {
		key_pressed = '[',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(2, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, 10)
			end
			delay(0.5)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eemult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eechip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('^^10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ']',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(3, 10)
			end
			delay(0.5)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eeemult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eeechip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('^^^10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ';',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(4, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(4, 10)
			end
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hexmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '^^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hexchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('^^^^10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = "'",
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(5, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(5, 10)
			end
			delay(0.5)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hepmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '^^^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hepchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('^^^^^10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'o',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(6, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(6, 10)
			end
			delay(0.5)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_octmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '{6}10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_octchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('{6}10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'rshift',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(10, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(10, 10)
			end
			delay(0.5)
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, '{10}10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('{10}10', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'g',
		action = function(self)
			collectgarbage("collect")
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'i',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:aperiorate(10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:aperiorate(10)
			end
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, 'Mult^[10]', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('Chips^[10]', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'l',
		action = function(self)
			G.GAME.hands['High Card'].mult = G.GAME.hands['High Card'].mult:extend()
			G.GAME.hands['High Card'].chips = G.GAME.hands['High Card'].chips:extend()
			jl.hn("High Card")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, 'Mult<->', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('Chips<->', nil, true)
			jl.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '7',
		action = function(self)
			G.GAME.hands['High Card'].level = 1000
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'd',
		action = function(self)
			G.GAME.hands['High Card'].level = 205
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'up',
		action = function(self)
			mod_score_operator(-1, 1)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'down',
		action = function(self)
			mod_score_operator(-1, -1)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 's',
		action = function(self)
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_spadus', 'may_debug')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound("may_hyperascendant_joker")
			return true end}))
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'y',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = math.max(G.GAME.hands[k].l_mult*(G.GAME.hands[k].level - 1), 1)
				G.GAME.hands[k].chips = math.max(G.GAME.hands[k].l_chips*(G.GAME.hands[k].level - 1), 0)
			end
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'w',
		action = function(self)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('may_c_wondrous', 1, 2.5)
				local card2 = create_card('wondrousplanets', G.consumeables, nil, nil, nil, nil, 'c_may_pluto_won', 'may_debug')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(1, 1)
			return true end}))
		end
	}
	
	SMODS.Keybind {
		key_pressed = '4',
		action = function(self)
			G.jokers:change_size_hyper(2, 0)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '5',
		action = function(self)
			G.consumeables:change_size_hyper(2, 0)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '6',
		action = function(self)
			G.hand:change_max_highlight_hyper(2, 0)
		end
	}
	
end