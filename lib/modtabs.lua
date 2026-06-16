-- Load mod's tabs 

SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
				{n=G.UIT.T, config={text = "Settings marked with * require game restart to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.35, padding = .2}},
			}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Mode*",
					scale = 1.2,
					w = 8,
					options = {"Mayhem", "Eternum"},
					opt_callback = 'may_upd_mode',
					current_option = may.conf.Mode,
				})
			}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Custom Menu*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Menu" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Custom Intro*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "intro" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Pagers in item descriptions*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "pagers" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Condense fusion information*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "short_fusion" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Display Mayhem\'s version on title screen*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "show_version" },
				}},
			}},
		}}
	}}
end

may.conf.WIP = true

G.FUNCS.may_conf_restart = function(e)
	SMODS.restart_game()
end

G.FUNCS.may_upd_mode = function(e)
	may.conf.Mode = e.to_key
	if may.conf.Mode == 1 then
		may.conf.reroll_cost = 1
		may.conf.scaling_activation = 1
		may.conf.reroll_punishment = true
		may.conf.rich_punishment = true
		may.conf.threshold_punishment = true
		may.conf.round_punishment = true
		may.conf.scaling = 2
	end
end

G.FUNCS.may_upd_treffects = function(e)
	may.conf.TrEffects = e.to_key
end

G.FUNCS.may_upd_scaling = function(e)
	may.conf.scaling = e.to_key
end 

G.FUNCS.may_upd_limit = function(e)
	may.conf.Limit = e.to_key
end

G.FUNCS.may_upd_music = function(e)
	may.conf.Music = e.to_key
end

G.FUNCS.may_upd_reroll_cost = function(e)
	may.conf.reroll_cost = e.to_key
end

G.FUNCS.may_upd_scaling_activation = function(e)
	may.conf.scaling_activation = e.to_key
end

SMODS.current_mod.extra_tabs = function()
	return {
			{
				label = 'Cross-mod',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n=G.UIT.R, config={align = "cm"}, nodes={
							    {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
								    {n=G.UIT.T, config={text = "Settings marked with * require game restart to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.35, padding = .2}},
							    }},
						    }},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Mayhem enables unique content if you're also playing with certain mods.", colour = G.C.UI.TEXT_LIGHT, scale = 0.3}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Cryptid*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.CM, ref_value = "Cryptid" },
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Grim*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.CM, ref_value = "Grim" },
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Blind Editions*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
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
							{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
							    {n=G.UIT.C, config={align = "cm"}, nodes={
								    {n=G.UIT.T, config={text = "Settings marked with * require game restart to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.35, padding = .2}},
							    }},
						    }},
							{n=G.UIT.R, config={align = "cm"}, nodes={
							    {n=G.UIT.C, config={align = "cm"}, nodes={
								    {n=G.UIT.T, config={text = "Transcendence is the glitchy effect when you get large scores", colour = G.C.UI.TEXT_LIGHT, scale = 0.35, padding = .2}},
							    }},
						    }},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_option_cycle({
									label = "Transcendence Effects",
									scale = 0.7,
									w = 10,
									options = {"Disabled", "Low", "Medium", "High", "Extreme"},
									opt_callback = 'may_upd_treffects',
									current_option = may.conf.TrEffects,
								})
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0.2 }, nodes = {
									create_slider({
										label = "Score Shakiness: Pulse Limit",
										label_scale = 0.4,
										text_scale = 0.3,
										ref_table = may.conf.Shakiness,
										ref_value = "pulselimit",
										min = 0,
										max = 25,
									}),
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.2 }, nodes = {
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
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0.2 }, nodes = {
									create_slider({
										label = "Score Shakiness: Pulse Multiplier",
										label_scale = 0.4,
										text_scale = 0.3,
										ref_table = may.conf.Shakiness,
										ref_value = "pulsemult",
										min = 0,
										max = 2,
									}),
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0.2 }, nodes = {
									create_slider({
										label = "Score Shakiness: Quiver Multiplier",
										label_scale = 0.4,
										text_scale = 0.3,
										ref_table = may.conf.Shakiness,
										ref_value = "quivermult",
										min = 0,
										max = 2,
									}),
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_slider({
									label = "Score Shakiness: Screen Shake Multiplier",
									label_scale = 0.4,
									text_scale = 0.3,
									ref_table = may.conf.Shakiness,
									ref_value = "screen_shake",
									min = 0,
									max = 2,
								}),
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Unlimit Pulse', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.Shakiness, ref_value = "unlimitpulse" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Unlimit Quiver', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf.Shakiness, ref_value = "unlimitquiver" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Shake Cards during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrShakeCards" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Shake Screen during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrShakeScreen" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Misc. Joker Effects', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "JokerEffects" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Shake HUD Elements during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrShakeUI" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'White noise during Transcendence', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrNoise" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Reduce Flashing Lights', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "epileptic" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Transcendence Particles', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TrParticles" },
								}},
							}},
						}}
					}}
			end,
			},
			{
				label = 'Gameplay',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							create_option_cycle({
								label = "Exponential Reroll Cost Increase Threshold",
								scale = 1,
								w = 6,
								options = {"25 rerolls", "50 rerolls", "75 rerolls", "Disabled"},
								opt_callback = 'may_upd_reroll_cost',
								current_option = may.conf.reroll_cost,
							})
						}},	
                        {n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Activate Scaling when obtaining Fusion Jokers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
							    create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "fusion_punishment" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Activate Prismatic Scaling when reroll price reaches $1e100', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
							    create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "reroll_punishment" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Activate Opalescent Scaling when reroll threshold is reached 5 times in a row', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "threshold_punishment" },
							}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Activate various Fusion Scaling after high round thresholds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "round_punishment" },
							}},
						}},
					}}
				end,
			},
			{
				label = 'Music and SFX',
				tab_definition_function = function()
				return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n=G.UIT.R, config={align = "cm"}, nodes={
							{n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
								{n=G.UIT.T, config={text = "Settings marked with * require game restart to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.35, padding = .2}},
							}},
						}},
						{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							create_option_cycle({
								label = "Menu Music",
								scale = 1,
								w = 6,
								options = {"Auto", "Mayhem Theme", "Eternum Theme", "Yotta Card", "UltraBlind", "Transcendent Joker", "Enhanced Pack", "Party Time", "Rondo Discoteca", "Opalescent Joker", "Pixel Pack", "Tainted Boss", "Fusion Joker", "Fusion Pack", "Fusion Joker (Shop)", "Transcendent Joker (Shop)", "Opalescent Joker (Shop)", "Default"},
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
								max = 300,
							}),
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
							{n=G.UIT.C, config={align = "cm"}, nodes={
								{n=G.UIT.T, config={text = "Changes to Transcendence Volume take a few seconds to apply", colour = G.C.UI.TEXT_LIGHT, scale = 0.3, padding = .2}},
							}},
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Santa', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Santamusic" },
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Party Time', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Partymusic" },
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Transcendent Joker', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Hyperascendantmusic" },
							}},
							{n = G.UIT.C, config = { align = "cr", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Yotta Card', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cr", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Yottamusic" },
							}},
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Enhanced Pack', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Editionmusic" },
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'UltraBlind', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Ultrablindmusic" },
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Rondo Discoteca', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Ibizamusic" },
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Opalescent Joker', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Surrealmusic" },
							}}, 
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Pixel Pack', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Retromusic" },
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'POKER', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Pokermusic" },
							}}, 
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Fusion Joker', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Fusionmusic" },
							}}, 
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Fusion Joker (Shop)', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Fusionshopmusic" },
							}}, 
							{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Fusion Pack', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "Fusionpackmusic" },
							}}, 
						}},
						
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Custom Hyperoperation Sounds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "CustomHyperoperations" },
							}},

							{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Tamer Hyperoperation Sounds*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "TameSounds" },
							}},
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Legacy Transcendence 1 Ambiance*', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "LegacyTr1" },
							}},
						}},
						{n=G.UIT.R, config={ align = "cm" }, nodes={
							{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = 'Use Party Time Theme instead of Fusion Joker music', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
							{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
								create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = may.conf, ref_value = "party_music_everywhere" },
							}},
						}}
					}}
				}}
			end
		},
	}
end

function may.get_mode_gradient(mode)
	return mode == 2 and 'may_col_eternum_green' or 'may_col_mayhem_gradient'
end

SMODS.current_mod.ui_config = {
	colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark1'],
	author_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)],
	back_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)],
	tab_button_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)],
	collection_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark1'],
	collection_bg_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark2'],
	bg_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark2'],
}