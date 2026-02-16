-- Misc badges
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

may.misc_badges = {
	immutable = {
		text = {'Immutable'},
		col = G.C.BLUE,
	}, 
	WIP = {
		text = {'WIP'}, 
		col = SMODS.Gradients.may_col_wip_badge,
	},
	no_tree = {
		text = {'Unfinished Fusion Chain'}, 
		col = G.C.RED
	},
	default = {
		text = {'Default'},
		col = G.C.FILTER
	}, 
	endless = {
		text = {'Endless-Exclusive'}, 
		col = G.C.PURPLE
	}, 
	reserve = {
		text = {'Reservable'}, 
		col = G.C.GREEN
	}, 
	indestructible = {
		text = {'Indestructible', '(Fusing excluded)'}, 
		col = G.C.BLACK
	}, 
}

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
	if obj then 
		for k, v in pairs(may.misc_badges) do
			if obj[k] then 
				local scale_fac = {}
				local scale_fac_len = 1
				for i = 1, #v.text do
					local calced_scale = calculate_scalefactor(v.text[i])
					scale_fac[i] = calced_scale
					scale_fac_len = math.min(scale_fac_len, calced_scale)
				end
				local ct = {}
				for i = 1, #v.text do
					ct[i] = {
						string = v.text[i]
					}
				end
				badges[#badges + 1] =  {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								colour = v.col,
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
											colours = { v.txt_col or G.C.WHITE },
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
		if obj.set ~= 'may_display' and may.is_default(obj.key) then
			local scale_fac = {}
			local scale_fac_len = 1
			if obj.misc_badge and obj.misc_badge.text then
				for i = 1, #obj.misc_badge.text do
					local calced_scale = calculate_scalefactor(may.misc_badges.default.text[i])
					scale_fac[i] = calced_scale
					scale_fac_len = math.min(scale_fac_len, calced_scale)
				end
			end
			local ct = {}
			for i = 1, #may.misc_badges.default.text do
				ct[i] = {
					string = may.misc_badges.default.text[i]
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
							colour = G.C.FILTER,
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
										colours = { G.C.WHITE },
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
end