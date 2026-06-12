-- Notifications
-- Mostly taken from Cryptid

G.FUNCS.notif_welcome = function()
	G.SETTINGS.screenshake = 25
	G:save_settings()
	play_sound("foil1", 0.7, 0.3)
	G.FUNCS:exit_overlay_menu()
end

function may.display_notification(key, soundfunc)
	G.E_MANAGER:add_event(Event({trigger = "immediate", no_delete = true, func = function()
		if not G.OVERLAY_MENU then
			G.SETTINGS.paused = true
			G.FUNCS.overlay_menu({
				definition = create_UIBox_may_notif(key),
			})
			soundfunc()
			return true 
	    end
	end}), "unlock")
end

function may.display_welcome_notification()
	G.E_MANAGER:add_event(Event({trigger = "immediate", no_delete = true, func = function()
		if not G.OVERLAY_MENU then
			G.SETTINGS.paused = true
			G.FUNCS.overlay_menu({
				definition = create_UIBox_may_welcome_notif(),
			})
			play_sound('may_transcendent_joker')
			return true 
	    end
	end}), "unlock")
end 

function create_UIBox_may_notif(key)
	local t = create_UIBox_generic_options({
		padding = 0,
		back_label = localize("b_continue"),
		no_pip = true,
		snap_back = true,
		back_func = "continue_unlock",
		minw = 4.5,
		bg_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark2'],
		outline_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)], 
		colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark1'],
		back_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)],
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.1 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm", padding = 0 },
										nodes = {
											{
												n = G.UIT.O,
												config = {
													object = DynaText({
														string = { localize("may_notif_" .. key .. "_1") },
														colours = { SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)] },
														shadow = true,
														rotate = true,
														bump = true,
														pop_in = 0.3,
														pop_in_rate = 2,
														scale = 1.2,
													}),
												},
											},
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0.2 },
								nodes = {
									{
										n = G.UIT.R,
										config = {
											align = "cm",
											padding = 0.05,
											emboss = 0.05,
											colour = G.C.WHITE,
											r = 0.1,
										},
										nodes = {
											may.notifications[key].nodes(),
										},
									},
								},
							},
						},
					},
					may.notifications[key].cta and {
						n = G.UIT.R,
						config = {
							id = "overlay_menu_back_button",
							align = "cm",
							minw = 2.5,
							padding = 0.1,
							r = 0.1,
							hover = true,
							colour = G.C.BLUE,
							button = "notif_" .. key,
							shadow = true,
							focus_args = { nav = "wide", button = "b" },
						},
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0, no_fill = true },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize(may.notifications[key].cta.label),
											scale = 0.5,
											colour = G.C.UI.TEXT_LIGHT,
											shadow = true,
											func = "set_button_pip",
											focus_args = { button = "b" },
										},
									},
								},
							},
						},
					} or nil,
				},
			},
		},
	})
	return t
end

function create_UIBox_may_welcome_notif(key)
	local t = create_UIBox_generic_options({
		padding = 0,
		back_label = localize("may_n_no"),
		no_pip = true,
		snap_back = true,
		back_func = "continue_unlock",
		minw = 4.5,
		bg_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark2'],
		outline_colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)], 
		colour = SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)..'_dark1'],
		back_colour = SMODS.Gradients.may_col_mayhem_gradient,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.1 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm", padding = 0 },
										nodes = {
											{
												n = G.UIT.O,
												config = {
													object = DynaText({
														string = { localize("may_notif_welcome_1") },
														colours = { SMODS.Gradients[may.get_mode_gradient(may.conf.Mode)] },
														shadow = true,
														rotate = true,
														bump = true,
														pop_in = 0.3,
														pop_in_rate = 2,
														scale = 1.2,
													}),
												},
											},
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0.2 },
								nodes = {
									{
										n = G.UIT.R,
										config = {
											align = "cm",
											padding = 0.05,
											emboss = 0.05,
											colour = G.C.WHITE,
											r = 0.1,
										},
										nodes = {
											may.notifications.welcome.nodes(),
										},
									},
								},
							},
						},
					},
					may.notifications.welcome.cta and {
						n = G.UIT.R,
						config = {
							id = "overlay_menu_back_button",
							align = "cm",
							minw = 2.5,
							padding = 0.1,
							r = 0.1,
							hover = true,
							colour = SMODS.Gradients.may_col_eternum_green,
							button = "notif_welcome",
							shadow = true,
							focus_args = { nav = "wide", button = "b" },
						},
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0, no_fill = true },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize(may.notifications.welcome.cta.label),
											scale = 0.5,
											colour = G.C.UI.TEXT_LIGHT,
											shadow = true,
											func = "set_button_pip",
											focus_args = { button = "b" },
										},
									},
								},
							},
						},
					} or nil,
				},
			},
		},
	})
	return t
end

may.notifications = {
	welcome = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_welcome_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_welcome_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_welcome_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_welcome_d4"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_welcome_d5"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
		cta = {
			label = "may_n_yes",
		},
	},
	slaythejokers = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_stj_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_stj_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_stj_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_stj_d4"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
	},
	cryptid = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_cry_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_cry_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_cry_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
	},
	talisman = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_talisman_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_talisman_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_talisman_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
	},
	overflow = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_overflow_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_overflow_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_overflow_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
	},
	smods = {
		nodes = function()
			return {
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE,
					r = 0.1,
					padding = 0.04,
					minw = 2,
					minh = 0.8,
					emboss = not empty and 0.05 or nil,
					filler = true,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_smods_d1"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_smods_d2"),
											scale = 0.5, 
											colour = G.C.BLACK,
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 0 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("may_notif_smods_d3"),
											scale = 0.5,
											colour = G.C.BLACK,
										},
									},
								},
							},
						},
					},
				},
			}
		end,
	},
}
