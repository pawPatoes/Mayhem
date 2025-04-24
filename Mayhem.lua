if not (Big and Big.arrow) then
	error('!! OMEGANUM NOT ENABLED. PLEASE REMOVE MAYHEM FROM YOUR MODS FOLDER, SET TALISMAN TO OMEGANUM AND MOVE MAYHEM BACK.')
end

-- Config
local conf = SMODS.current_mod.config

-- Handy values for the mod
-- You can use the stuff here for cross-mod content (if you like this mod for some reason)
may = {}

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
					current_option = conf.Mode,
                })
			}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Number Limit",
					scale = 1,
					w = 10,
					options = {"Omeganum (e10##100)", "e10##100000 (RECOMMENDED)", "e10##1073741824 (UNSTABLE)", "e10##9007199254740991 (UNSTABLE)"},
					opt_callback = 'may_upd_limit',
					current_option = conf.Limit,
                })
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Safe Mode', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Safe" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Custom Menu', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Menu" },
				}},
			}},
			{n=G.UIT.R, config={}, nodes={
				{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Transcendence counter (experimental)', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
			}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "transcendence_counter" },
				}},
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
					{ n = G.UIT.T, config = { text = 'Debug Mode', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
				}},
				{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
					create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Debug" },
				}},
			}},
        }}
	}}
end

G.FUNCS.may_conf_restart = function(e)
	SMODS.restart_game()
end

G.FUNCS.may_upd_mode = function(e)
	conf.Mode = e.to_key
end

G.FUNCS.may_upd_treffects = function(e)
	conf.TrEffects = e.to_key
end

G.FUNCS.may_upd_params = function(e)
	conf.Params = e.to_key
end

G.FUNCS.may_upd_scaling = function(e)
	conf.Scaling = e.to_key
end

if #SMODS.find_mod('MEOST') == 0 then
	G.FUNCS.may_upd_music = function(e)
		conf.Music = e.to_key
	end
end

G.FUNCS.may_upd_limit = function(e)
	conf.Limit = e.to_key
end

if #SMODS.find_mod('MEOST') ~= 0 then
	print("MAYHEM: found module Mayhem Extended OST")
end

	--[[ {n = G.UIT.T, config = {text = "CREDITS", colour = G.C.UI.TEXT_LIGHT, scale = 1}},
	{n = G.UIT.T, config = {text = "Techno and Antimatter sounds - Colossatron", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Genesis sound - Minecraft", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Ethereal ambience (stage 2) - Will You Snail?", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Ethereal ambience (stage 3) - tubesofthepit by Freesound on Pixabay", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Ethereal ambience (stage 4) - Daytime to Night by cxnder", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Santa Music - Rolling Sky", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
	{n = G.UIT.T, config = {text = "Santa hohoho - Santa Papa Noel by Risa on Pixabay", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
]]
SMODS.current_mod.extra_tabs = function()
	return {
			{
				label = 'Gameplay',
				tab_definition_function = function()
					return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_option_cycle({
									label = "Blind Scaling",
									scale = 1,
									w = 6,
									options = {"Vanilla", "Accelerated (Default)", "Very Fast", "RIDICULOUS"},
									opt_callback = 'may_upd_scaling',
									current_option = conf.Scaling,
								})
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Mayhem enables unique content if you're also playing with certain mods", colour = G.C.UI.TEXT_LIGHT, scale = 0.3}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Cryptid', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.CM, ref_value = "Cryptid" },
								}},
								{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Blind Editions', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
								{n = G.UIT.C, config = { align = "c", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.CM, ref_value = "BlindEditions" },
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
									options = {"Disabled", "Default", "High"},
									opt_callback = 'may_upd_treffects',
									current_option = conf.TrEffects,
								})
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Window Shake', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "WindowShake" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								create_slider({
									label = "Score Shakiness: Pulse Limit",
									label_scale = 0.4,
									text_scale = 0.3,
									ref_table = conf.Shakiness,
									ref_value = "pulselimit",
									min = 0,
									max = 25,
								}),
								create_slider({
									label = "Score Shakiness: Quiver Limit",
									label_scale = 0.4,
									text_scale = 0.3,
									ref_table = conf.Shakiness,
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
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.Shakiness, ref_value = "unlimitpulse" },
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Score Shakiness: Unlimit Quiver', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.Shakiness, ref_value = "unlimitquiver" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Misc. Joker Effects', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "JokerEffects" },
								}},
							}},
							{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Mass Use Ambiance (Incantation)', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "massuse" },
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
									create_toggle{ col = true, label = "", scale = 0.9, w = 0, shadow = true, ref_table = conf, ref_value = "WIP" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Normal Jokers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Jokers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Fusion Jokers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "FusionJokers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Consumables', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Consumables" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Vouchers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Vouchers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Vouchers', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Vouchers" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Enhancements', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Enhancements" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Editions', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Editions" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'UltraBlinds', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf.content, ref_value = "Blinds" },
								}},
							}},
						}}
					}}
			end,
			},
			{
				label = 'Music',
				tab_definition_function = function()
					if #SMODS.find_mod('MEOST') ~= 0 then
						return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
						{n=G.UIT.C, config={}, nodes={
							{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
								create_option_cycle({
									label = "Menu Music",
									scale = 1,
									w = 6,
									options = {
									"Auto", 
									"Mayhem Theme",
									"Eternum Theme", 
									"Edition Card Theme",
									"UltraBlind Theme", 
									"Party Time",
									"Santa", 
									"Mayhem Theme (Old)", 
									"Big Score", 
									"December 3 Sketch", 
									"November 8 Sketch (1)", 
									"November 8 Sketch (2)", 
									"Classic Menu",
									"Classic Menu (Old)",
									"Classic Boss",
									"Classic Shop",
									"Classic Arcana",
									"Classic Celestial",
									"Classic Celestial (Old)",
									"Default", 
									},
									opt_callback = 'may_upd_music',
									current_option = MEOST_conf.music
								})
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Mayhem Extended OST enabled', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Santa', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Santamusic" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Party Time', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Partymusic" },
								}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Use Classic OST in-game', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = '(requires retsart)', scale = 0.15, colour = G.C.UI.TEXT_LIGHT }},
								}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = MEOST, ref_value = "classic_ost" },
								}},
							}},
						}}
					}}
					else
						return {n = G.UIT.ROOT, config = {align = 'cm',minw = 8,minh = 4,r = .1,padding = .1,colour = G.C.BLACK}, nodes = {
							{n=G.UIT.C, config={}, nodes={
								{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
									create_option_cycle({
										label = "Menu Music",
										scale = 1,
										w = 6,
										options = {"Auto", "Mayhem Theme", "Eternum Theme", "Default"},
										opt_callback = 'may_upd_music',
										current_option = conf.Music,
									})
								}},
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
										{ n = G.UIT.T, config = { text = 'Santa', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
									}},
									{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
										create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Santamusic" },
									}},
								}},
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
										{ n = G.UIT.T, config = { text = 'Party Time', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
									}},
									{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
										create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = conf, ref_value = "Partymusic" },
									}},
								}},
							}}
						}}
					end
			end,
			}
		}
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

-- Score Operator
-- Inspired and admitedly frankensteined from Jen's Almanac

function get_final_score(chips, mult)
	if to_big(chips or 0) == to_big(0) or to_big(mult or 0) == to_big(0) then
		return 0
	else
		if get_score_operator() >= 0 then
			return to_big(chips or 0):arrow(get_score_operator(), to_big(mult or 0))
		else
			if get_score_operator() == -1 then
				return to_big(chips or 0) + to_big(mult or 0)
			elseif get_score_operator() == -2 then
				return to_big(chips or 0):sub(to_big(mult or 0))
			elseif get_score_operator() == -3 then
				return to_big(chips or 0):div(to_big(mult or 0))
			elseif get_score_operator() <= -3 then
				if to_big(mult or 0) == to_big(1) or to_big(chips or 0) == to_big(1) then
					return 0
				else
					return to_big(chips or 0):logBase(to_big(mult or 0))
				end
			end
		end
	end
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
					if conf.Safe then
						G.GAME.score_operator = 25000
					else
						G.GAME.score_operator = 1e307
					end
				end
				if G.GAME.score_operator > 25000 and conf.Safe then
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
		G.hand_text_area.score_operator:update()
		G.hand_text_area.score_operator.config.text = text
		G.hand_text_area.score_operator.config.text_drawable:set(text)
		G.hand_text_area.score_operator.UIBox:recalculate()
		G.hand_text_area.score_operator.config.colour = col
		if operator < 4 and operator >= 0 then
			G.hand_text_area.score_operator.config.scale = 0.8-(operator/20)
		else
			if operator > 4 then
				G.hand_text_area.score_operator.config.scale = 0.8-(string.len(text)/50)
			else
				G.hand_text_area.score_operator.config.scale = 0.8
			end
		end
		if not no_effects then
			G.hand_text_area.score_operator:juice_up(0.8, 0.5)
		end
	return true end}))
end

function change_blind_size(arrow, mod)
	mod = to_big(mod)
	if arrow >= 0 then
		G.GAME.starting_params.ante_scaling = to_number(to_big(G.GAME.starting_params.ante_scaling):arrow(arrow or 0, mod or 0))
	else
		if arrow == -1 then
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling + to_number(mod)
		elseif arrow == -2 then
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling - to_number(mod)
		elseif arrow == -3 then
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / to_number(mod)
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

	-- Omeganum limits

if conf.Limit == 1 then
	maxArrow = 1e3
elseif conf.Limit == 2 then
	maxArrow = 1e5
elseif conf.Limit == 3 then
	maxArrow = 1073741824
elseif conf.Limit == 4 then
	maxArrow = 9007199254740991
end

-- Empowered Consumables
-- code mostly taken from Jen's Almanac

if conf.content.WIP then

may.asc_rate = .01

-- There will be more tiers in the future, currently it's just ascended

may.can_be_empowered = {
	'hermit',
	'familiar',
	'pluto',
	'may_planetae',
}

local ccr = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if G.STAGE ~= G.STAGES.MAIN_MENU and card.gc and card:gc() then
		for k, v in ipairs(may.can_be_empowered) do
			if card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_asc'] and not G.GAME.banned_keys['c_may_'..v.. '_asc'] then
				if pseudorandom('spawn_empowered') < may.asc_rate / 1 then
				-- not using G.GAME.probabilities.normal because making empowered consumables more common with OA6s would be silly
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
						if card then
							card:set_ability(G.P_CENTERS['c_may_'..v..'_asc'])
							card:set_cost()
							if card:gc().set ~= 'yottacards' then
								play_sound('may_ascended', 1, 0.75)
								card:juice_up(1, 1)
							else
								play_sound('may_ascended_yotta')
								card:juice_up(2, 2)
								G.ROOM.jiggle = G.ROOM.jiggle + 0.7
							end
						end
					return true end}))
				end
			break
			end
		end
		-- play special card sounds
		if card and card:gc().set == 'yottacards' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_enchant', 1, 0.75)
				card:juice_up(.5, .5)
			return true end}))
		end
		if card and card:gc().planet_rarity == 2 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_rare_planet', 1, 0.75)
				card:juice_up(.35, .35)
			return true end}))
		end
		if card and card:gc().planet_rarity == 3 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
				play_sound('may_legendary_planet', 1, 0.75)
				card:juice_up(.5, .5)
			return true end}))
		end
	end
	return card
end

end

-- misc badges
-- taken from Jen's Alamanac (which took it from Cryptid (it's slightly different????))
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

	-- Starting Params


may.parambuff = conf.Params

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

may.mode = conf.Mode
	
if conf.Mode == 2 then
	SMODS.current_mod.display_name = "Eternum"
	SMODS.current_mod.name = "Eternum"
	SMODS.current_mod.badge_colour = SMODS.Gradients.may_eternum_green
end

-- Custom scaling
if conf.Scaling ~= 1 then
	function get_blind_amount(ante)
		if not amount then
			amount = to_big(200) 
		end
		if conf.Scaling == 2 then
			if ante < 8 then
				amount = to_big(100*(ante+2))
			else
				amount = to_big(100):arrow(math.floor(math.log10(ante)), to_big(1000))
			end
		elseif conf.Scaling == 3 then
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
		elseif conf.Scaling == 4 then
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
if conf.transcendence_counter and #SMODS.find_mod('multiplayer') == 0 then
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

end

-- Menu
if conf.Menu then 
	if conf.Mode == 1 then
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

-- incantation stuff

if Incantation then
	AllowMassUsing('editioncards')
	AllowMassUsing('yottacards')
	AllowMassUsing('ascendedyottas')
	AllowMassUsing('ascendedplanets')
	
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
							if #G.play.cards > 10 and may.mass_use_index < 100 and conf.massuse then
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

SMODS.current_mod.debug_info = "Hi you found a crash. Yell about it in my dms with the error message so i can fix it."

-- Aurinko stuff
if #SMODS.find_mod('aurinko') ~= 0 then
	for k, v in pairs(G.P_CENTERS) do
		if k.set == 'editioncards' then
			table.insert(AurinkoWhitelist, v)
		end
	end
end
-- Unrerollable UltraBlind stuff

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

-- Money operations

function hypermoney(arrow, amount, silent)
	if G and G.GAME then
		G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
			G.GAME.dollars = G.GAME.dollars:arrow(arrow, amount)
			G.ROOM.jiggle = G.ROOM.jiggle + (arrow/5)
			local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
			local text = ''
			if arrow == 0 then
				text = 'x'..localize('$')
			elseif arrow == 1 then
				text = '^'..localize('$')
			elseif arrow == 2 then
				text = '^^'..localize('$')
			elseif arrow == 3 then
				text = '^^^'..localize('$')
			elseif arrow > 3 then
				text = '{'..arrow..'}'..localize('$')
			end
			dollar_UI.config.object:update()
			G.HUD:recalculate()
			attention_text({
				text = text..tostring(math.abs(amount)),
				scale = 0.8, 
				hold = 0.7,
				cover = dollar_UI.parent,
				cover_colour = G.C.MONEY,
				align = 'cm',
			})
			play_sound('may_bigmoney')
			if not silent then
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
				elseif arrow >= 8 then
					play_sound('may_decmult')
				end
			end
			if arrow > 0 then
				if conf.Shakiness.unlimitquiver then
					G.FUNCS.tsj_specific(dollar_UI, 0, arrow*4, true)
				else
					G.FUNCS.tsj_specific(dollar_UI, 0, math.min(conf.Shakiness.maxpulse, arrow*4), true)
				end
			end
		return true end}))
	end
end

-- Transcendence effects

if conf.TrEffects ~= 1 then
	SMODS.DrawStep {
		key = 'transcendence_shake',
		order = -3000,
		func = function(self)
			if G.hand then
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
				end
			end
		end
	}
end

if conf.TrEffects == 2 then
	local upd = Game.update
	function Game:update(dt)
		upd(self, dt)
		if G.GAME and G.GAME.blind then
			may.safe_transcendence = (G.ARGS.score_intensity.transcendence or 0)
		end
		if G.hand then
			if (may.transcendence or 0) > 0 then
				if may.transcendence ~= 12 then
					G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
					ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
					ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
				else
					ease_colour(G.C.UI_CHIPS, HEX('111111'), .6)
					ease_colour(G.C.UI_MULT, HEX('111111'), .6)
				end
			else
				ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
				ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
			end
		end
		if G.GAME.blind and #SMODS.find_card('j_may_party_time') ~= 0 and (may.transcendence or 0) == 0 and conf.JokerEffects then
			ease_background_colour({ new_colour = copy_table(G.C.BLACK), special_colour = G.C.EDITION, contrast = 2 })
		end
	end
elseif conf.TrEffects == 3 then
	local upd = Game.update
	function Game:update(dt)
		upd(self, dt)
		if G.GAME and G.GAME.blind then
			may.safe_transcendence = (G.ARGS.score_intensity.transcendence or 0)
		end
		if G.hand then
			G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
			if (may.transcendence or 0) > 0 then
				if may.transcendence < 10 then
					G.hand_text_area.blind_chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.hand_text_area.mult:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.hand_text_area.chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.hand_text_area.handname:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.hand_text_area.hand_level:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.hand_text_area.score_operator:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
					G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
					G.ARGS.spin.real = -math.log10(may.transcendence)
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = may.transcendence
					else
						glitched_intensity = may.transcendence
					end
					transcendence_noise = may.transcendence/30
					transcendence_crt = may.transcendence/60
				elseif may.transcendence == 10 then
					G.hand_text_area.blind_chips:juice_up(0.01, 100)
					G.hand_text_area.mult:juice_up(0.01, 100)
					G.hand_text_area.chips:juice_up(0.01, 100)
					G.hand_text_area.handname:juice_up(0.01, 100)
					G.hand_text_area.hand_level:juice_up(0.01, 100)
					G.hand_text_area.score_operator:juice_up(0.01, 100)
					G.ROOM.jiggle = G.ROOM.jiggle + 10
					G.ARGS.spin.real = -2
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 15
					else
						glitched_intensity = 15
					end
					transcendence_noise = 0.4
					transcendence_crt = 0.2
				elseif may.transcendence == 11 then
					G.hand_text_area.blind_chips:juice_up(0.01, 400)
					G.hand_text_area.mult:juice_up(0.01, 400)
					G.hand_text_area.chips:juice_up(0.01, 400)
					G.hand_text_area.handname:juice_up(0.01, 400)
					G.hand_text_area.hand_level:juice_up(0.01, 400)
					G.hand_text_area.score_operator:juice_up(0.01, 400)
					G.ROOM.jiggle = G.ROOM.jiggle + 20
					G.ARGS.spin.real = -5
					love.window.setTitle(may.obfuscatedtext(string.len(love.window.getTitle())))
					if conf.WindowShake then
						love.window.setPosition(love.window.getPosition(x)+math.random(-1, 1), love.window.getPosition(y)+math.random(-1, 1), love.window.getPosition(displayindex)+math.random(-1, 1))
					end
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 70
					else
						glitched_intensity = 70
					end
					ease_colour(G.C.DARK_EDITION, SMODS.Gradients.may_col_asc_yotta, 1)
					transcendence_noise = 0.5
					transcendence_crt = 0.3
				elseif may.transcendence == 12 then
					ease_colour(G.C.DARK_EDITION, HEX('111111'), 1)
					G.ARGS.spin.real = 0
					G.ARGS.spin.amount = 0
					G.ARGS.spin.eased = 0
					love.window.setTitle('null')
					if conf.WindowShake then
						love.window.setPosition(love.window.getPosition(x)+math.random(-4, 4), love.window.getPosition(y)+math.random(-4, 4), love.window.getPosition(displayindex)+math.random(-4, 4))
					end
					if #SMODS.find_mod('Cryptid') == 0 then
						transcendence_glitch = 100
					else
						glitched_intensity = 100
					end
					transcendence_noise = 0.6
					transcendence_crt = 100
				end
				ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.MONEY, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.RED, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.BLUE, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.IMPORTANT, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.GOLD, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.ORANGE, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.UI.BACKGROUND_DARK, copy_table(G.C.DARK_EDITION), .6)
				ease_background_colour({ new_colour = copy_table(G.C.DARK_EDITION), special_colour = copy_table(G.C.BLACK), contrast = 2 })
			else
				ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
				ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
				ease_colour(G.C.RED, HEX('FE5F55'), 1)
				ease_colour(G.C.BLUE, HEX("009dff"), 1)
				ease_colour(G.C.MONEY, HEX('f3b958'), 1)
				ease_colour(G.C.IMPORTANT, HEX('ff9a00'), 1)
				ease_colour(G.C.GOLD, HEX('eac058'), 1)
				ease_colour(G.C.ORANGE, HEX('fda200'), 1)
				ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), 1)
				love.window.setTitle('Balatro Mayhem')
				if #SMODS.find_mod('Cryptid') == 0 then
					transcendence_glitch = 0
				else
					glitched_intensity = 0
				end
				transcendence_noise = 0.001*G.SETTINGS.GRAPHICS.crt/100
				transcendence_crt = 0.16*G.SETTINGS.GRAPHICS.crt/100
			end
		end
		-- Party Time background
		if G.GAME.blind and #SMODS.find_card('j_may_party_time') ~= 0 and (may.transcendence or 0) == 0 and conf.JokerEffects then
			ease_background_colour({ new_colour = copy_table(G.C.BLACK), special_colour = G.C.EDITION, contrast = 2 })
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

--[[ultraeditions = {
	'ultrafoil',
	'ultraholo',
	'ultraamber',
	'ultranostalgic',
	'ultratechno'
 }

ultraenhancements = {
	'ultrariffraff'
}

function getjokers()
	if not G.jokers then return 0 end
	return #G.jokers.cards
end]]
local vanf_cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
	vanf_cuc(self)
	if self:gc().set == 'editioncards' and self:gc().key ~= 'c_may_nostalgic_card' then
		G.GAME.last_edition_card = self:gc().key
	end
end

function may.get_operation_sound(operation, chipsmult)
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
		elseif operation >= 8 then
			return 'may_decchip'
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
		elseif operation >= 8 then
			return 'may_decmult'
		end
	elseif chipsmult == 'dollars' then
		if operation == -1 then
			return 'coin3'
		elseif operation == 0 then
			return 'may_bigmoney'
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
	local f = factorials
	local errorFixer = 1
	for i=1, (to_number(times) or 1), 1 do
		if x:lte(R.ZERO) or not (x or 0):isint() then 
			x = x:add(1):gamma() 
		end
		if x:lte(170) then 
			x = to_big(factorials[to_number(x)+1])
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

-- Number shakiness 
-- slightly modified code from Jen's Almanac

function G.FUNCS.tsj_specific(e, quiver, pulse, juice)
	if e and e.config and e.config.object and next(e.config.object) then
		if conf.Shakiness.unlimitquiver then
			e.config.object:set_quiver(quiver)
		else
			e.config.object:set_quiver(math.min(conf.Shakiness.quiverlimit, quiver))
		end
		if conf.Shakiness.unlimitpulse then
			e.config.object:pulse(pulse)
		else
			e.config.object:pulse(math.min(conf.Shakiness.pulselimit, pulse))
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
			if comparison > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100)
			elseif comparison > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 4, 24)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9)
			elseif comparison > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5)
			elseif comparison > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3)
			elseif comparison > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5)
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
			if comparison > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100)
			elseif comparison > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 4, 24)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12)
				--play_sound('may_big_number_set')
			elseif comparison > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9)
			elseif comparison > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5)
			elseif comparison > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3)
			elseif comparison > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5)
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
			if not G.ARGS.hand_chip_total_UI_set or to_big(G.ARGS.hand_chip_total_UI_set) < to_big(G.GAME.current_round.current_hand.chip_total) then
				local comparison = G.GAME.current_round.current_hand.chip_total
				if type(comparison) == 'number' then
					comparison = Big:create(comparison)
				elseif type(comparison) == 'string' then
					comparison = Big:create(1)
				end
				if comparison > Big:create(1e308):arrow(1000, 2) then
					G.FUNCS.tsj_specific(e, 10, 100)
				elseif comparison > Big:create(1e308):arrow(100, 10) then
					G.FUNCS.tsj_specific(e, 4, 24)
				elseif comparison > Big:create(1e308):arrow(10, 3) then
					G.FUNCS.tsj_specific(e, 3.5, 21)
				elseif comparison > Big:create(1e308):arrow(5, 3) then
					G.FUNCS.tsj_specific(e, 3, 18)
				elseif comparison > Big:create(1e308):arrow(4, 3) then
					G.FUNCS.tsj_specific(e, 2.5, 15)
				elseif comparison > Big:create(1e308):arrow(3, 3) then
					G.FUNCS.tsj_specific(e, 2, 12)
				elseif comparison > Big:create(1e308):arrow(2, 2) then
					G.FUNCS.tsj_specific(e, 1.35, 9)
				elseif comparison > Big:create(1e308) ^ 2 then
					G.FUNCS.tsj_specific(e, 1, 5)
				elseif comparison > Big:create(1e308) then
					G.FUNCS.tsj_specific(e, 0.75, 3)
				elseif comparison > Big:create(1e100) then
					G.FUNCS.tsj_specific(e, 0.5, 1.5)
				else
					G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log((type(G.GAME.current_round.current_hand.chip_total) == 'number' or type(G.GAME.current_round.current_hand.chip_total) == 'table') and G.GAME.current_round.current_hand.chip_total or 1))))
				end
				if comparison > Big:create(1e100):arrow(2, 100) then
					G.ROOM.jiggle = G.ROOM.jiggle + math.min(100, to_number(comparison:arrow(3, 0.01)))
				end
			end
			G.ARGS.hand_chip_total_UI_set = G.GAME.current_round.current_hand.chip_total
		end
	end
end

G.FUNCS.blind_chip_UI_scale = function(e)
	if G.GAME.blind and G.GAME.blind.chips then
		e.config.object.scale = scale_number(G.GAME.blind.chips, 0.7, 100000)
		e.config.object:set_quiver(math.min(conf.Shakiness.quiverlimit, math.min(math.max(0, (may.transcendence or 0)*0.1), 5)))
		e.config.object:update_text()
		e.config.object:align_letters()
		e:update_object()
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
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
		G.macrocosm = Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], {x = 2,y = 0})
		G.genesis = Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], {x = 4,y = 0})
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

-- Multiply hand level
function super_level_up_hand(card, hand, instant, amount)
    amount = to_big(amount) or to_big(1)
    G.GAME.hands[hand].level = math.max(0, to_big(G.GAME.hands[hand].level):arrow(0, amount))
    G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1), 1)
    G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1), 0)
    if not instant then 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('may_super_level')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('may_super_level')
            if card then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('may_super_level')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
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

-- Custom chip-mult operations (doesnt work because talisman hates me)
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
            card_eval_status_text_apemult(scored_card or effect.card or effect.focus, 'may_apemult', amount, percent)
            return true
        end
		if (key == 'ape_chip' or key == 'APEchip_mod') then 
            local e = card_eval_status_text
            card_eval_status_text = function() end
            hand_chips = mod_chips(to_big(hand_chips):aperiorate(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            card_eval_status_text = e
            card_eval_status_text_apechip(scored_card or effect.card or effect.focus, 'may_apechip', amount, percent)
            return true
        end
		if (key == 'fact_mult' or key == 'FACTmult_mod') then 
            local e = card_eval_status_text
            card_eval_status_text = function() end
            mult = mod_mult(to_big(mult):fact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            card_eval_status_text = e
            card_eval_status_text_factmult(scored_card or effect.card or effect.focus, 'may_factmult', amount, percent)
            return true
        end
		if (key == 'fact_chip' or key == 'FACTchip_mod') then 
            local e = card_eval_status_text
            card_eval_status_text = function() end
            hand_chips = mod_chips(to_big(hand_chips):fact(amount))
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            card_eval_status_text = e
            card_eval_status_text_factchip(scored_card or effect.card or effect.focus, 'may_factchip', amount, percent)
            return true
        end
		if (key == 'x_dollars' or key == 'xdollars_mod') then 
            local e = card_eval_status_text
            card_eval_status_text = function() end
            hypermoney(0, amount, true)
            card_eval_status_text = e
            card_eval_status_text_xdollars(scored_card or effect.card or effect.focus, 'may_bigmoney', amount, percent)
            return true
        end
		if key == 'super_level_up' then
			if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
			local hand_type = effect.level_up_hand or G.GAME.last_hand_played
			super_level_up_hand(scored_card, hand_type, effect.instant, type(amount) == 'number' and amount or 1)
			return true
		end
    end
    for _, v in ipairs({'ape_mult', 'APEmult_mod', 'ape_chip', 'APEchip_mod', 'fact_mult', 'FACTmult_mod', 'fact_chip', 'FACTchip_mod', 'x_dollars', 'xdollars_mod', 'super_level_up'}) do
        table.insert(SMODS.calculation_keys, v)
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
	text = "{Mult, "..amt..'}'
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
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
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
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
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
					end
					return true
					end
			}))
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
	text = "{Chips, "..amt..'}'
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
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
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
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
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
					end
					return true
					end
			}))
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
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
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
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
					end
					return true
					end
			}))
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
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
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
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
					end
					return true
					end
			}))
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
	colour = G.C.DOLLARS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
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
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
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
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.log(amt, 500)
					end
					return true
					end
			}))
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
	key = 'transcendent',
	loc_txt = {
	name = "Transcendent"
	},
	badge_colour = G.C.DARK_EDITION,
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

SMODS.Atlas {
  key = "n_jokers",
  path = "N_jokers.png",
  px = 71,
  py = 95
}

if conf.Mode == 1 then
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
	key = "Placeholder",
	path = "placeholder.png",
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
	key = "planets",
	path = "planets.png",
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
	key = 'blind_chips',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 31,
	py = 31,
	path = 'bossblind.png'
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

SMODS.Sound({key = 'thunder1', path='thunder1.ogg'})
SMODS.Sound({key = 'thunder2', path='thunder2.ogg'})
SMODS.Sound({key = 'bigmoney', path='hugemoney.ogg'})

SMODS.Sound({key = 'e_amber', path = 'edition/e_amber.ogg'})
SMODS.Sound({key = 'e_nostalgic', path = 'edition/e_nostalgic.ogg'})
SMODS.Sound({key = 'e_techno', path = 'edition/e_techno.ogg'})
SMODS.Sound({key = 'e_antimatter', path = 'edition/e_antimatter.ogg'})
SMODS.Sound({key = 'e_hallucinatory', path = 'edition/e_hallucinatory.ogg'})
SMODS.Sound({key = 'e_hypnotic', path = 'edition/e_hypnotic.ogg'})
SMODS.Sound({key = 'e_omega', path = 'edition/e_omega.ogg'})
SMODS.Sound({key = 'e_otherworldly', path = 'edition/e_otherworldly.ogg'})
SMODS.Sound({key = 'e_shimmering', path = 'edition/e_shimmering.ogg'})
SMODS.Sound({key = 'e_cosmic', path = 'edition/e_cosmic.ogg'})
SMODS.Sound({key = 'e_print', path = 'edition/e_print.ogg'})

SMODS.Sound({key = 'e_ultrafoil', path = 'edition/e_ultrafoil.ogg'})
SMODS.Sound({key = 'e_ultraholo', path = 'edition/e_ultraholographic.ogg'})
SMODS.Sound({key = 'e_ultrapoly', path = 'edition/e_ultrapolychrome.ogg'})
SMODS.Sound({key = 'e_ultraamber', path = 'edition/e_ultraamber.ogg'})
SMODS.Sound({key = 'e_ultranostalgic', path = 'edition/e_ultranostalgic.ogg'})
SMODS.Sound({key = 'e_ultratechno', path = 'edition/e_ultratechno.ogg'})
SMODS.Sound({key = 'e_ultraantimatter', path = 'edition/e_ultraantimatter.ogg'})

SMODS.Sound({key = 'weezer', path='weezer.ogg'})
SMODS.Sound({key = 'st_hohoho', path='hohoho.ogg'})
SMODS.Sound({key = 'st_bells', path='santa_bells.mp3'})

SMODS.Sound({key = 'enchant', path='enchant.ogg'})
SMODS.Sound({key = 'super_level', path='super_level.ogg'})
SMODS.Sound({key = 'rare_planet', path='rare_planet.ogg'})
SMODS.Sound({key = 'legendary_planet', path='legendary_planet.ogg'})
SMODS.Sound({key = 'ascended', path='ascended.ogg'})
SMODS.Sound({key = 'decrease_operator', path='decrease_operator.ogg'})
SMODS.Sound({key = 'error', path='error.ogg'})
SMODS.Sound({key = 'universal_collapse', path='universalcollapse.ogg'})
SMODS.Sound({key = 'ascended_yotta', path='ascended_yotta.ogg'})
SMODS.Sound({key = 'big_number_set', path='big_number_set.ogg'})
SMODS.Sound({key = 'error_seal', path='error_seal.ogg'})

SMODS.Sound({key = 'transcendent_joker', path='rarity/transcendent_joker.ogg'})
SMODS.Sound({key = 'interdimensional_joker', path='rarity/interdimensional_joker.ogg'})
SMODS.Sound({key = 'ethereal_joker', path='rarity/ethereal_joker.ogg'})
SMODS.Sound({key = 'hyperascendant_joker', path='rarity/hyperascendant_joker.ogg'})

SMODS.Sound({key = 'tran1', path = 'tran/tran1.ogg'})
SMODS.Sound({key = 'tran2', path = 'tran/tran2.ogg'})
SMODS.Sound({key = 'tran3', path = 'tran/tran3.ogg'})
SMODS.Sound({key = 'tran4', path = 'tran/tran4.ogg'})
SMODS.Sound({key = 'tran5', path = 'tran/tran5.ogg'})
SMODS.Sound({key = 'tran6', path = 'tran/tran6.ogg'})
SMODS.Sound({key = 'tran7', path = 'tran/tran7.ogg'})
SMODS.Sound({key = 'tran8', path = 'tran/tran8.ogg'})

SMODS.Sound({key = 'ambient_mass_use', path = 'ambient_mass_use.ogg'})

SMODS.Sound({key = 'hexmult', path='operation/HexationalMult.ogg'})
SMODS.Sound({key = 'hepmult', path='operation/HeptationalMult.ogg'})
SMODS.Sound({key = 'octmult', path='operation/OctationalMult.ogg'})
SMODS.Sound({key = 'ennmult', path='operation/EnneationalMult.ogg'})
SMODS.Sound({key = 'decmult', path='operation/DecationalMult.ogg'})
SMODS.Sound({key = 'apemult', path='operation/AperiotiveMult.ogg'})
SMODS.Sound({key = 'factmult', path='operation/FactorialMult.ogg'})

SMODS.Sound({key = 'hexchip', path='operation/HexationalChips.ogg'})
SMODS.Sound({key = 'hepchip', path='operation/HeptationalChips.ogg'})
SMODS.Sound({key = 'octchip', path='operation/OctationalChips.ogg'})
SMODS.Sound({key = 'ennchip', path='operation/EnneationalChips.ogg'})
SMODS.Sound({key = 'decchip', path='operation/DecationalChips.ogg'})
SMODS.Sound({key = 'apechip', path='operation/AperiotiveChips.ogg'})
SMODS.Sound({key = 'factchip', path='operation/FactorialChips.ogg'})

SMODS.Sound({key = 'eboth', path='operation/ExponentialMultChips.ogg'})
SMODS.Sound({key = 'eeboth', path='operation/TetrationalMultChips.ogg'})
SMODS.Sound({key = 'eeeboth', path='operation/PentationalMultChips.ogg'})

-- Fusions

-- joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, condition, code, shake

	-- Mythic
	
-- FusionJokers.fusions:add_fusion('j_triboulet', nil, nil, 'j_baron', nil, nil, 'j_may_patriarch', 250)

FusionJokers.fusions:add_fusion('j_may_man', nil, nil, 'j_may_wheel_of_eternity', nil, nil, 'j_may_diskus', 140)
 
	-- Transcendent

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_hurley', nil, nil, 'j_may_ultimate_hurley', 1000, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_nebula', nil, nil, 'j_may_cosmos', 1000, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_AAAA', nil, nil, 'j_may_acum', 1111, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_destroyer', nil, nil, 'j_may_storm', 1300, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_royale', nil, nil, 'j_may_little_prince', 1100, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_daredevil', nil, nil, 'j_may_party_time', 1100, 'may_transcendent_joker')

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_jolly', nil, nil, 'j_may_santa', 8888, 'may_transcendent_joker')

	-- Interdimensional
 
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum', nil, nil, 'j_may_acum_universum', 111111, 'may_interdimensional_joker', nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_storm', nil, nil, 'j_may_cosmos', nil, nil, 'j_may_kepler', 100000, 'may_interdimensional_joker', nil, 0.8)

	-- Ethereal
  
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum_universum', nil, nil, 'j_may_acum_multiplexum', 11111111, 'may_ethereal_joker', nil, 1)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_kepler', nil, nil, 'j_may_keplers_dream', 1e7, 'may_ethereal_joker', nil, 1)

	-- HyperAscendant

FusionJokers.fusions:add_fusion('j_may_acum_multiplexum', nil, nil, 'j_may_keplers_dream', nil, nil, 'j_may_spadus', 11e110, 'may_hyperascendant_joker', nil, 1.5)


-- Sounds

	-- Music
	--[[ if conf.Music then 
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
		return #SMODS.find_card('j_may_santa') > 0  and conf.Santamusic and (may.transcendence or 0) < 9
	end,
})

SMODS.Sound({
	key = "music_party",
	path = "music/music_party.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return #SMODS.find_card('j_may_party_time') > 0 and conf.Partymusic and (may.transcendence or 0) < 9
	end,
})

if #SMODS.find_mod('MEOST') == 0 then

SMODS.Sound({
	key = "music_menu",
	path = "music/music_menu.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not conf.Music == 4 or conf.Music == 2 or (conf.Music == 1 and conf.Mode == 1)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_eternum",
	path = "music/music_eternum.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not conf.Music == 4 or conf.Music == 3 or (conf.Music == 1 and conf.Mode == 2)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

end

SMODS.Sound({
	key = "music_editioncard",
	path = "music/music_edition.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "editioncards") and -1000 or false
	end
})

if conf.content.WIP and conf.Mode == 2 then

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
		return ((G.pack_cards and G.pack_cards.cards) and (G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "yottacards") or found_yotta) and -1000 or false
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

end

SMODS.Sound({
	key = "music_ultrablind",
	path = "music/music_ultrablind.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and (G.GAME.blind.config.blind.ultra)) and -1000 or false
	end
})

SMODS.Sound({
	key = "music_tran9",
	path = "tran/tran9.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 9
	end,
})

SMODS.Sound({
	key = "music_tran10",
	path = "tran/tran10.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 10
	end,
})

SMODS.Sound({
	key = "music_tran11",
	path = "tran/tran11.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 11
	end,
})

SMODS.Sound({
	key = "music_tran12",
	path = "tran/tran12.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 12
	end,
})

-- Editions
if conf.content.Editions then

SMODS.Shader({key = 'shimmering', path = 'shimmering.fs'})
SMODS.Shader({key = 'omega', path = 'omega.fs'})
SMODS.Shader({key = 'nostalgic', path = 'nostalgic.fs'})
SMODS.Shader({key = 'otherworldly', path = 'otherworldly.fs'})
SMODS.Shader({key = 'cosmic', path = 'cosmic.fs'})
SMODS.Shader({key = 'print', path = 'print.fs'})

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
		super_level_up_hand(card, jl.favhand(), nil, 4)
		jl.ch()
	end,
	in_shop = true,
	weight = 1,
	extra_cost = 4,
	apply_to_float = true,
}

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

if conf.content.Enhancements then

SMODS.Enhancement {
	key = 'super_mult',
	loc_txt = {
		name = 'Super Mult',
		text = {
			'{X:mult,C:white}^1.14{} Mult',
		}
	},
	pos = { x = 1, y = 0 },
	unlocked = false,
	replace_base_card = false,
	weight = .3,
	discovered = false,
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
		name = 'Overgrown',
		text = {
			'{C:green}#1# in 3{} chance to apply a',
			"{C:attention}random{} {C:dark_edition}Edition{} to this card",
			"when it is {C:attention}discarded{}",
			"then {C:mult}remove this enhancement{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	pos = { x = 2, y = 0 },
	unlocked = false,
	replace_base_card = false,
	weight = .3,
	discovered = false,
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
			"{X:chips,C:white}X1.4{} Chips"
		}
	},
	atlas = 'seal',
	pos = { x = 3, y = 0 },
	badge_colour = HEX('acf097'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_chips = 1.4
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
			"{X:mult,C:white}X1.6{} Mult"
		}
	},
	atlas = 'seal',
	pos = { x = 5, y = 0 },
	badge_colour = HEX('ff5900'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = 1.6
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
			"{C:inactive}JIMCO. CORPORATE{}"
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
			"additional {X:mult,C:white}X0.05{} Mult for every card",
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
				x_mult = 1.2 + (bonus*0.05),
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
			"This card gives {X:attention,C:white}X200{} more {C:chips}Chips{}"
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
			"with {C:inactive}Black Seal{} in full deck",
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
			"#1#"
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
					x_dollars = pseudorandom('may_error_seal', 1, 3)
				}
			elseif operation > 9 then
				return {
					ease_dollars = pseudorandom('may_error_seal', 1, 60)
				}
			elseif operation > 8 then
				return {
					ease_discard(math.floor(pseudorandom('may_error_seal')))
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
					ease_hands_played(math.floor(pseudorandom('may_error_seal')))
				}
			end
		end
	end
}

end

-- Consumable Types

if conf.content.Consumables then

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

if conf.content.WIP then

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

end

end


-- Booster packs

	-- Group key stuff
function SMODS.current_mod.process_loc_text()
	G.localization.misc.dictionary['k_may_editioncard_pack'] = "Edition Card Pack"
	G.localization.misc.dictionary['k_may_yotta_pack'] = "Yotta Card Pack"
end

if conf.content.Consumables then
SMODS.Booster {
	key = "b_editioncard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = .7,
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
}

if conf.content.WIP and conf.Mode == 2 then

-- have to use pseudorandom element because all of the yotta cards are technically hidden
may.yotta_cards = {
	'c_may_planetae',
	'c_may_cupiditas',
	'c_may_potestas'
}

SMODS.Booster {
	key = "b_yottacard1",
	kind = 'yottacard',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 1, choose = 1 },
	cost = 100,
	weight = .006,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("yottacards", G.pack_cards, nil, nil, true, true, pseudorandom_element(may.yotta_cards, pseudoseed('may_yotta_pack')), "may_yottapack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.MONEY, contrast = 2 })
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
}

end

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
			"to level 10000"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 1, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "upgrade_hand" and to_big(args.level) >= to_big(10000) then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'big_hundred',
	loc_txt = {
		name = "Big Hundred",
		description = {
			"Reach ante 100"
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
		if args.type == 'modify_deck' and G.deck and G.deck.config.card_limit == 1 then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'i_think',
	loc_txt = {
		name = "I think that's enough",
		description = {
			"Win a run with 30 jokers"
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

if conf.content.Consumables then

	-- Acsended Consumables
		
		-- Tarots
if conf.content.WIP then

SMODS.Consumable {
	key = 'hermit_asc',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Hermit",
		text = {
			"{X:money,C:white}^1.5${}",
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'asc_tarot',
	cost = 1000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		hypermoney(1, 1.5)
	end,
}

	-- Planets
	
SMODS.Consumable {
	set = 'ascendedplanets',
	key = 'pluto_asc',
	config = { mphand = 2, other = -1 },
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ascended Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge, nil, 1.2)
	end,
	loc_txt = {
		name = 'Ascended Pluto',
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
		super_level_up_hand(card, hand, nil, 5)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		jl.th(hand)
		super_level_up_hand(card, hand, nil, 5*number)
		delay(0.5)
		jl.ch()
	end,
}
	
	-- Spectrals
	
SMODS.Consumable {
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
	cost = 1000,
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
		for _, card in ipairs(G.playing_cards) do
			if not card:is_face() then
				card:start_dissolve(nil, true)
				amount = amount + 2
			end
		end
		for i=1, amount, 1 do
			local rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('asc_familiar'))
            local suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('asc_familiar'))
			local card = create_playing_card({front = G.P_CARDS[suit..'_'..rank], center = pseudorandom_element(enhance, pseudoseed('asc_familiar'))}, G.play, true, i ~= 1, {G.C.SECONDARY_SET.Spectral})
			card:set_edition(poll_edition('may_asc_familiar', nil, true, true), true, true)
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
	end,
}

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
			"{X:money,C:white}^^1.2${}"
		}
	},
	pos = { x = 1, y = 0 },
	soul_pos = { x = 0, y = 0 },
	atlas = 'may_ascyotta_placeholder',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		hypermoney(2, 1.2)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(2, 1.2*number)
	end,
}

SMODS.Consumable {
	key = 'potestas_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Potestas",
		text = {
			"{C:attention}Doubles{} {C:dark_edition}score operator{} level"
		}
	},
	pos = { x = 1, y = 0 },
	soul_pos = { x = 0, y = 0 },
	atlas = 'may_ascyotta_placeholder',
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

end

if not may.yottarate then
	if conf.Mode == 1 then
		may.yottarate = 0.02
	else
		may.yottarate = 0.03
	end
end

	-- Yotta Cards
	
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
		hypermoney(1, 2)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(1, 2*number)
	end,
}

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
	config = { amount = 1, canmod = false },
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		if self.config.canmod then
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
		if self.config.canmod then
			mod_score_operator(-1, 1)
		else
			jl.a('Activated', 2, nil, G.C.YELLOW, 'gong')
			play_sound('generic1')
		end
		self.config.canmod = not self.config.canmod
	end,
	bulk_use = function(self, card, area, copier, number)
		mod_score_operator(-1, number/2)
		if number%2 ~= 0 then
			self.config.canmod = not self.config.canmod
			if self.config.canmod then
				jl.a('Activated', 2, nil, G.C.YELLOW, 'gong')
				play_sound('generic1')
			end
		end
	end,
}

	-- Tarots
	
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
	pos = { x = 0, y = 0 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				play_sound('card1', 1+(k/10))
				delay(0.5)
			return true end}))
		end
		local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('may_paragon'))
		delay(0.5)
		for k, v in ipairs(G.hand.cards) do
			if v ~= selected_card then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					v:flip()
					play_sound('card1', 1+(k/10))
					delay(0.5)
				return true end}))
			end
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			selected_card.highlighted = true
			play_sound('card1')
		return true end}))
		delay(0.5)
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
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 3, mod_conv = "m_may_overgrown" },
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.hand.highlighted <= (3 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}
	
	-- Spectrals

SMODS.Consumable {
	key = 'genesis',
	set = 'Spectral',
	name = 'Genesis',
	loc_txt = {
		name = "Genesis",
		text = {
			"Creates an {C:attention}Universal Collapse{} joker",
			"{C:attention}+2{} Ante",
			"{C:inactive}(requires room){}"
		}
	},
	config = { xante = 2 },
	pos = { x = 3, y = 0 },
	atlas = 'may_spectral',
	cost = 17,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.2,
	use = function(self, card, area, copier)
		local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
		G.jokers:emplace(card2)
		play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		card2:add_to_deck()
		if not G.GAME.may_unstable_sleeve_alt then
			ease_ante(2)
		end
	end
}

SMODS.Consumable {
	key = 'macrocosm',
	set = 'Spectral',
	name = 'Macrocosm',
	loc_txt = {
		name = "Macrocosm",
		text = {
			"Creates a {C:attention}random{} {X:dark_edition,C:white}Transcendent{} Joker",
			"{C:mult}-2 hands{} played",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 1, y = 0 },
	atlas = 'may_special_spectral',
	special_soul = 'may_rotate_constant',
	cost = 10,
	unlocked = true,
	hidden = true,
	soul_rate = 0.02,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.round_resets.hands > 2 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local card2 = create_card('Joker', G.jokers, nil, 'may_transcendent', nil, nil, nil, 'may_shortcut')
		G.jokers:emplace(card2)
		play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		play_sound('may_transcendent_joker', 1, 0.75)
		card2:add_to_deck()
		card2:juice_up(1,1)
		G.GAME.round_resets.hands =  G.GAME.round_resets.hands - 2
		ease_hands_played(-2)
		delay(0.6)
	end
}

SMODS.Consumable {
	key = 'warp',
	set = 'Spectral',
	loc_txt = {
		name = "Warp",
		text = {
			"{C:attention}-1 Ante{}",
			"Only works if you have {C:attention}at least{} {C:money}#1#${}"
		}
	},
	pos = { x = 5, y = 0 },
	config = { dollars = 30 },
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.dollars } }
	end,
	atlas = 'may_spectral',
	cost = 10,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.dollars > to_big(self.config.dollars)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		ease_ante(-1)
		self.config.dollars = self.config.dollars*2
	end
}

SMODS.Consumable {
	key = 'deal',
	set = 'Spectral',
	loc_txt = {
		name = "Deal",
		text = {
			"{C:attention}+2 Joker Slots{}",
			"{C:mult}Halves money{}"
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_spectral',
	cost = 10,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 2
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
		return true end}))
		delay(.2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			hypermoney(0, .5)
		return true end}))
	end
}

if conf.content.WIP then

may.rare_planets = {
	'c_may_wasp_15b',
	'c_may_stos'
}

may.legendary_planets = {
	'c_may_kivaaritehdas',
	'c_may_quac_n7'
}

SMODS.Consumable {
	key = 'astronomy',
	set = 'Spectral',
	loc_txt = {
		name = "Astronomy",
		text = {
			"Creates 2 {C:attention}random{} {X:mult,C:white}Rare{} {C:planet}planets{}",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 2 },
	atlas = 'Placeholder',
	cost = 5,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
				return true
			end }))
		end
		delay(0.6)
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(2*number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
				return true
			end }))
		end
		delay(0.6)
	end
}

SMODS.Consumable {
	key = 'celestra',
	set = 'Spectral',
	loc_txt = {
		name = "Celestra",
		text = {
			"Creates a {C:attention}random{} {X:legendary,C:white}Legendary{} {C:planet}planet{}",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 2 },
	atlas = 'Placeholder',
	cost = 5,
	hidden = true,
	soul_rate = 0.06,
	soul_set = 'Spectral',
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and #G.consumeables.cards < G.consumeables.config.card_limit
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			if G.consumeables.config.card_limit > #G.consumeables.cards then
				play_sound('timpani', 0.5)
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			end
			return true
		end }))
		delay(0.6)
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani', 0.5)
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
				return true
			end }))
		end
		delay(0.6)
	end
}

end
-- Planets

SMODS.Consumable {
	set = 'Planet',
	key = 'proxima_centauri',
	config = { hand_type = 'may_Royal Flush' },
	pos = {x = 0, y = 0 },
	atlas = 'planets',
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
	key = 'tartarus',
	config = { extra = { mphand = 2, other = -1 } },
	pos = {x = 1, y = 0 },
	atlas = 'planets',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Tartarus',
		text = {
			"{C:planet}Levels up{} most played hand {C:attention}#1#{} times,",
			"{C:mult}decreases level{} of another {C:attention}2 random{} hands by {C:attention}#2#{}",
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

if conf.content.WIP then

SMODS.Consumable {
	set = 'Planet',
	key = 'mangas',
	pos = {x = 0, y = 2 },
	atlas = 'Placeholder',
	misc_badge = may_wip_badge,
	loc_txt = {
		name = 'Mangas',
		text = {
			"{C:attention}Gain double the level{} of a {C:attention}random Poker Hand{} as {C:money}dollars{}",
			"then {C:mult}set it's level to 1{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card)
		local hand = jl.rndhand()
		jl.th(hand)
		ease_dollars(G.GAME.hands[hand].level*2)
		if G.GAME.hands[hand].level > to_big(1) then
			level_up_hand(card, hand, nil, -G.GAME.hands[hand].level+1)
		else
			play_sound('tarot2')
		end
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local total = 0
		for i=1, number, 1 do
			local hand = jl.rndhand(hand)
			total = total + G.GAME.hands[hand].level
			level_up_hand(card, hand, true, -G.GAME.hands[hand].level+1)
		end
		jl.h('Random Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
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
	atlas = 'Placeholder',
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
	pos = { x = 0, y = 2 },
	atlas = 'Placeholder',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Planet Wee',
		text = {
			"{C:planet}Levels up{} {C:attention}lowest scoring{} hand {C:attention}#1#{} times",
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
	config = { extra = { smphand = 2, mphand = -1 } },
	pos = { x = 0, y = 2 },
	atlas = 'Placeholder',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Orcus',
		text = {
			"{C:planet}Levels up{} {C:attention}second-most played{} hand {C:attention}#1#{} times,",
			"{C:mult}Decreases level{} of {C:attention}most played{} hand {C:attention}#2#{} time(s)",
			"{C:inactive}will level up #3#, will decrease level of #4#{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.smphand, math.abs(card.ability.extra.mphand), jl.sfavhand(), jl.favhand() } }
	end,
	use = function(self, card)
		jl.th(jl.sfavhand())
		level_up_hand(card, jl.sfavhand(), nil, card.ability.extra.smphand)
		delay(0.5)
		jl.th(jl.favhand())
		level_up_hand(card, jl.favhand(), nil, card.ability.extra.mphand)
		delay(0.5)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		jl.th(jl.sfavhand())
		level_up_hand(card, jl.sfavhand(), nil, card.ability.extra.smphand*number)
		delay(0.5)
		jl.th(jl.favhand())
		level_up_hand(card, jl.favhand(), nil, card.ability.extra.mphand*number)
		delay(0.5)
		jl.ch()
	end
}

-- Rare Planets
SMODS.Consumable {
	set = 'Planet',
	key = 'wasp_15b',
	config = { extra = { amount = 10 } },
	pos = {x = 0, y = 2 },
	atlas = 'Placeholder',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
		badges[3] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge), nil, 1.2
	end,
	loc_txt = {
		name = 'WASP-15b',
		text = {
			"{C:planet}Levels up{} {C:attention}most played{} Poker Hand",
			"{C:attention}10{} times",
			"{C:inactive}will level up #2#{}"
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
	key = 'stos',
	pos = {x = 0, y = 2 },
	atlas = 'Placeholder',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
		badges[3] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge), nil, 1.2
	end,
	loc_txt = {
		name = 'Stos',
		text = {
			"{C:attention}Adds{} the {C:purple}Mult & Chips{} of {C:attention}most played Poker Hand{}",
			"to {C:attention}every other{} Poker Hand",
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

SMODS.Consumable {
	set = 'Planet',
	key = 'kivaaritehdas',
	config = { mphand = 2, other = -1 },
	pos = {x = 0, y = 2 },
	atlas = 'Placeholder',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
		badges[3] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge), nil, 1.2
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'Kivaaritehdas',
		text = {
			"{C:attention}Adds quadruple{} the {C:purple}Mult & Chips{} of {C:planet}every Poker Hand{}",
			"to your {C:attention}most played{} Poker Hand",
			"{C:inactive}Will give #1# {C:mult}#2#{} {C:inactive}Mult and {C:chips}#3#{} {C:inactive}Chips{}",
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
	pos = {x = 0, y = 2 },
	atlas = 'Placeholder',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
		badges[3] = create_badge('WIP', SMODS.Gradients.may_col_may_wip_badge), nil, 1.2
	end,
	cost = 30,
	planet_rarity = 3,
	loc_txt = {
		name = 'QUAC-N7',
		text = {
			"Set the {C:planet}level{} of {C:attention}every other Poker Hand{}",
			"to {C:attention}triple{} the {C:planet}level{} of {C:attention}most played Poker Hand{}",
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
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[jl.favhand()] then
				level_up_hand(card, k, true, G.GAME.hands[jl.favhand()].level:mul(3):sub(G.GAME.hands[k].level))
			end
		end
		jl.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+/-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+/-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hlv(number_format(G.GAME.hands[jl.favhand()].level:mul(3)))
		delay(1.3)
		jl.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[jl.favhand()] then
				level_up_hand(card, k, true, G.GAME.hands[jl.favhand()].level:mul(3):sub(G.GAME.hands[k].level))
			end
		end
		jl.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hm('+/-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hc('+/-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		jl.hlv(number_format(G.GAME.hands[jl.favhand()].level:mul(3)))
		delay(1.3)
		jl.ch()
	end,
}

end

	-- Edition Cards
	
SMODS.Consumable {
	key = 'foil_card',
	config = { extra = { chips = 50 } },
	loc_txt = {
		name = 'Foil Card',
		text = {
			'Gives all hands {C:chips}+#1# Chips{}',
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
			'Gives all hands {C:mult}+#1# Mult{}',
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
			play_sound('may_hexchip')
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
			play_sound('may_hexchip')
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

	
--[[SMODS.Consumable {
	key = 'ambercard',
	config = { extra = { chips = 875, mult = 10 } },
	loc_txt = {
		name = 'Amber Card',
		text = {
			'All hands gain {C:chips}+875 Chips{}',
			'But lose {C:mult}10 Mult{}'
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
	        for k, v in pairs(G.GAME.hands) do
           					G.GAME.hands[k].mult = G.GAME.hands[k].mult - card.ability.extra.mult
							G.GAME.hands[k].chips = G.GAME.hands[k].chips + card.ability.extra.chips
        end
					delay(0.5)
					Q(function() card:juice_up(.2, .3) return true end)
					jl.hn("All Hands")
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							play_sound('button')
							return true end }))	
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							play_sound('chips'..math.random(1,2)..'')
							card:juice_up(1, 1)
						return true end }))				
					jl.hcm('+'..card.ability.extra.chips..'', nil, true)
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							play_sound('multhit1')
							card:juice_up(1, 1)
						return true end }))				
					jl.hcm(nil, '-'..card.ability.extra.mult..'', true)
					delay(0.5)
					jl.ch()
	end
    }
	
SMODS.Consumable {
	key = 'nostalgiccard',
	config = { extra = { xmult = 10 } },
	loc_txt = {
		name = 'Nostalgic Card',
		text = {
			'Gives all hands {C:mult}x10 Mult{}',
		}
	},
	set = 'editioncards',
	pos = { x = 0, y = 1 },
	cost = 14,
	unlocked = true,
	discovered = true,
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
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
							return true end }))	
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							play_sound('multhit2')
							card:juice_up(1, 1)
						return true end }))				
					jl.hcm(nil, 'x'..card.ability.extra.xmult..'', true)
					jl.ch()
					delay(0.5)
	end
    }
]]
end
-- Blinds
if conf.content.Blinds then
	-- UltraBlinds
	
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
			'Cannot play most played Poker hand.',
			'Blind size is multiplied by the level',
			'of most played Poker hand.'
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
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 4
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
	mult = 256,
	disable = function(self)
		self.chips = math.sqrt(self.chips)
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.Blind	{
    loc_txt = {
		name = 'Downwards Spiral',
		text = { 
			'When hand is played',
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
			mod_score_operator(-3, 2)
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

if conf.content.Vouchers then

SMODS.Voucher {
	key = 'food_chain',
	loc_txt = {
		name = "Food Chain",
		text = {
			"{C:mult}Rare{} jokers are {C:attention}2x{} more common",
		}
	},
	pos = { x = 4, y = 0 },
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
			"{C:mult}Rare{} jokers are {C:attention}3x{} more common",
			"{C:green}Uncommon{} jokers are {C:attention}2x{} more common",
		}
	},
	pos = { x = 5, y = 0 },
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
		name = "Booster Suprlus",
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
			"{C:green}Edition Cards{} may appear in {C:attention}shop{}",
		}
	},
	pos = { x = 2, y = 0 },
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
			"{C:green}Edition Cards{} appear in {C:attention}shop 2X{} more frequently",
			"{C:money}Yotta cards{} can appear {C:attention}very rarely{} in {C:attention}shop"
		}
	},
	pos = { x = 3, y = 0 },
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

if #SMODS.find_mod('Cryptid') ~= 0 and conf.CM.Cryptid then

SMODS.Voucher {
	key = 'power_trip',
	loc_txt = {
		name = "Power Trip",
		text = {
			"{X:mult,C:white}Rare{} and {X:uncommon,C:white}Uncommon{} jokers are {C:money}free{}",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	requires = {'c_may_natural_selection'},
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
			"{C:attention}+1{} {C:green}booster pack{} in shop",
			"{C:attention}Booster packs{} have {C:attention}1 extra card{} for the rest of the run"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_booster_overabundance'},
	redeem = function(self, card)
		SMODS.change_booster_limit(1)
		for k, v in ipairs(G.P_CENTERS) do
			-- admittedly dumb way of doing this, please make my code better for profits
			if G.P_CENTERS[v].config.choose then
				if G.P_CENTERS[v].config.extra then
					G.P_CENTERS[v].config.extra = G.P_CENTERS[v].config.extra + 1
				end
			end
		end
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-1)
		for k, v in ipairs(G.P_CENTERS) do
			if G.P_CENTERS[v].config.choose then
				if G.P_CENTERS[v].config.extra and G.P_CENTERS[v].config.extra > 1 then
					G.P_CENTERS[v].config.extra = G.P_CENTERS[v].config.extra + 1
				end
			end
		end
	end,
}

SMODS.Voucher {
	key = 'trifecta',
	loc_txt = {
		name = "Trifecta",
		text = {
			"{C:money}Yotta Cards{} in shop are {C:attention}X20{} more common",
			"{C:spectral}Spectral Cards{} can appear in {C:attention}shop{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_booster_overabundance'},
	redeem = function(self, card)
		G.GAME.spectral_rate = 4
		G.GAME.yottacards_rate = G.GAME.yottacards_rate*20
	end,
	unredeem = function(self, card)
		G.GAME.spectral_rate = 0
		G.GAME.yottacards_rate = G.GAME.yottacards_rate/20
	end,
}

end

--[[SMODS.Voucher {
	key = 'golden_cup',
	loc_txt = {
		name = "Golden Cup",
		text = {
			"{C:money}Yotta Cards{} are {C:attention}2x{} more common",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		may_yottarate = may_yottarate*2
	end,
	unredeem = function(self, card)
		may_yottarate = may_yottarate/2
	end,
}

SMODS.Voucher {
	key = 'golden_ball',
	loc_txt = {
		name = "Golden Ball",
		text = {
			"{C:money}Yotta Cards{} are {C:attention}4x{} more common",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_golden_cup'},
	redeem = function(self, card)
		may_yottarate = may_yottarate*4
	end,
	unredeem = function(self, card)
		may_yottarate = may_yottarate/4
	end,
}]]

end

-- Jokers
if conf.content.Jokers then
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
  end
}
	
SMODS.Joker {
	key = 'fading_joker',
	loc_txt = {
		name = 'Fading Joker',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"{C:mult}Disappears{} after {C:attention}#2#{} rounds"
		}
	},
	config = { extra = { Xmult = 3, rounds = 3} },
	rarity = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.rounds} }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
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
	end
}

SMODS.Joker {
	key = 'sly_n',
	loc_txt = {
		name = "Sly N",
		text = {
			"All {C:dark_edition}N{} Jokers give {C:chips}+#1#{} Chips",
			"if played {C:attention}hand{} contains {C:attention}3 cards{} and a {C:attention}Pair{}",
			"{C:inactive,E:1,s:0.5}art & idea by _TeKKen_{}"
		}
	},
	rarity = 1,
	atlas = 'n_jokers',
	n_joker = true,
	pos = { x = 0, y = 0 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { chips = 50 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			if context.other_joker.config.center.n_joker  then
			-- this is unnecessarily complicated :D
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
				if (#G.play.cards == 3) and poker_hands['Pair'] then
					return {
						chips = card.ability.extra.chips,
						card = card,
						message = "+"..card.ability.extra.chips,
						colour = G.C.CHIPS
					}
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'noble_gas',
	loc_txt = {
		name = 'Noble Gas',
		text = {
			"If played hand is {C:attention}Five of a Kind{}",
			"this joker {C:planet}levels up{} {C:attention}Three of a Kind{} {C:attention}#1#{} times",
			"{C:mult}Self destructs{}"
		}
	},
	rarity = 1,
	atlas = 'n_jokers',
	pos = { x = 4, y = 1 },
	blueprint_compat = false,
	n_joker = true,
	cost = 4,
	config = { extra = { level = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level } }
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and G.GAME.current_round.current_hand.handname == "Five of a Kind" then
			jl.th('High Card')
			level_up_hand(card, 'High Card', nil, card.ability.extra.level)
			delay(0.5)
			jl.ch()
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


	-- Uncommon

SMODS.Joker {
	key = 'AAAA',
	loc_txt = {
		name = 'AAAA',
		text = {
			"Retrigger all",
			"played {C:attention}Aces #1#{} times"
		}
	},
	config = { extra = { repetitions = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions} }
	end,
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 4, y = 5 },
	cost = 6,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then		
				return {
					message = 'AAAAgain!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
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
			"{X:attention,C:white}x#1#{} Blind Size",
			"{C:money}+#2#${} at the end of round"
		}
	},
	config = { extra = { size = 1.3, dollars = 10 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 4, y = 4 },
	blueprint_compat = false,
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
	end
}

SMODS.Joker {
	key = 'paper_shredder',
	loc_txt = {
		name = 'Paper Shredder',
		text = {
			"{C:attention}After hand{} is played,",
			"{C:mult}destroy{} a {C:attention}random card{}",
			"held in hand and {C:attention}gain{} {X:mult,C:white}x#1#{} Mult",
			"{C:inactive}Currently {X:mult,C:white}x#2#{} Mult"
		}
	},
	config = { extra = { Xmult_gain = .1, Xmult = 1 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 1, y = 3 },
	cost = 5,
	blueprint_compat = true,
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
			"{C:inactive}Currently {C:mult}+#1#{} Mult{}",
		}
	},
	config = { extra = { mult = 0 } },
	pos = { x = 0, y = 3 },
	cost = 5,
	rarity = 2,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'joker1',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].level 
		end
		if context.joker_main then
			return {
				message = "+"..card.ability.extra.mult.." Mult",
				colour = G.C.MULT,
				mult_mod = card.ability.extra.mult,
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
		"apply {C:attention}random{} {C:dark_edition}enhancements{} to",
		"all {C:attention}played cards before scoring{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = false,
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
			"{C:inactive}(may have an enhancement, seal and/or edition){}"
		}
	},
	config = { extra = { amount = 4 } },
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
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
	end
}

SMODS.Joker {
	key = 'navigation',
	loc_txt = {
		name = "Navigation",
		text = {
			"When a blind is {C:attention}skipped{}",
			"this joker creates {C:attention}3{} {C:dark_edition}negative{} {C:attention}Sly Jokers{}",
			"and {C:mult}self destructs{}",
			"{C:mult}Self destructs{} in {C:attention}#1# rounds{}"
		}
	},
	rarity = 2,
	atlas = 'n_jokers',
	n_joker = true,
	pos = { x = 2, y = 0 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { rounds = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if context.skip_blind and context.cardarea == G.jokers then
			for i=1, 3, 1 do
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({negative = true}, false, false)
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
	end
}

	-- Rare
	
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
			"{C:inactive,E:1,s:0.5}Art & name by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'n_jokers',
	pos = { x = 3, y = 0 },
	blueprint_compat = true,
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
	blueprint_compat = false,
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
	atlas = 'n_jokers',
	n_joker = true,
	pos = { x = 1, y = 0 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { chips = 50 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Three of a Kind']) and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({polychrome = true}, false, false)
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
			"Increases by {C:attention}#2#{} for every owned {C:attention}Sly Joker{}",
			"at the {C:attention}end of round{}",
			"{C:inactive,E:1,s:0.5}original idea & art by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'n_jokers',
	n_joker = true,
	pos = { x = 2, y = 1 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { mult = 3, mult_gain = 3} },
	loc_vars = function(self, info_queue, card)
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
	end
}

SMODS.Joker {
	key = 'grafitti_n',
	loc_txt = {
		name = "Grafitti N",
		text = {
			"If played hand is {C:attention}Three of a kind{},",
			"{C:green}#1# in #2#{} chance to create a {C:dark_edition}foil{} {C:attention}Sly Joker{}",
			"{C:green}Always{} triggers if you own {C:attention}3{} or more {C:dark_edition}N{} jokers",
			"{C:mult}Works once per round{}",
			"{C:inactive}(must have room){}",
			"{C:inactive}#3#, #4#{}",
			"{C:inactive,E:1,s:0.5}original idea & art by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'n_jokers',
	n_joker = true,
	pos = { x = 3, y = 1 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { odds = 6, cantrigger = true, guaranteed = false} },
	loc_vars = function(self, info_queue, card)
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


if conf.Mode == 1 then

SMODS.Joker {
	key = 'collectors_edition',
	loc_txt = {
    name = 'Collector\'s Edition',
    text = {
		"{X:mult,C:white}^#1#{} Mult if",
		"{C:attention}this joker{} has an {C:dark_edition}Edition{}"
		}
	},
	config = { extra = { Emult = 1.5 } },
	rarity = 3,
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
	end
}

else  

SMODS.Joker {
	key = 'collectors_edition',
	loc_txt = {
    name = 'Collector\'s Edition',
    text = {
		"{X:mult,C:white}^^#1#{} Mult if",
		"{C:attention}this joker{} has an {C:dark_edition}Edition{}"
		}
	},
	config = { extra = { EEmult = 1.05 } },
	rarity = 3,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.EEmult } }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
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
	end
}

end

SMODS.Joker {
	key = 'collectionist',
	loc_txt = {
    name = 'Collectionist',
    text = {
		"{C:attention}Jokers{} with an {C:dark_edition}Edition{}",
		"give {X:chips,C:white}X#1#{} Chips"
		}
	},
	rarity = 3,
	atlas = 'n_jokers',
	pos = { x = 4, y = 0 },
	cost = 6,
	config = { extra = { Xchips = 2 } },
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
		"{C:inactive,E:1,s:0.5}idea by _TeKKen_{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 2, y = 5 },
	cost = 8,
	config = { extra = { odds = 4, cards = 2 } },
	loc_vars = function(self, info_queue, card)
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
				return true end }))
			end
		end
	end
}

SMODS.Joker {
	key = 'man',
	loc_txt = {
		name = "man",
		text = {
			"When {C:attenton}Blind{} is {C:attention}selected{},",
			"this joker creates {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
			"{C:inactive,E:1,s:0.5}idea by _TeKKeN_{}"
		}
	},
	config = { extra = { cards = 3 } },
	rarity = 3,
	atlas = 'n_jokers',
	blueprint_compat = true,
	pos = { x = 5, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
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
	end
}

SMODS.Joker {
	key = 'destroyer',
	loc_txt = {
		name = 'Destroyer',
		text = {
			"This joker {C:attention}gains{} {X:chips,C:white}X#1#{} Chips",
			"when a {C:planet}planet{} card is {C:attention}sold{}",
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
	end
}

SMODS.Joker {
	key = 'royale',
	loc_txt = {
		name = 'Royale',
		text = {
			"This joker {C:attention}gains{} {X:mult,C:white}X#1#{} Mult",
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Currently {X:mult,C:white}X#2#{} Mult{}"
		}
	},
	config = { extra = { Xmult_gain = 0.5, Xmult = 1 } },
	pos = { x = 4, y = 3 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
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
	end
}

if conf.Mode == 2 then
SMODS.Joker {
	key = 'daredevil',
	loc_txt = {
		name = 'Daredevil',
		text = {
			"If blind was {C:attention}beaten{} on your {C:attention}last{} hand,",
			"{C:green}#1# in #2#{} chance to increase {C:dark_edition}score operator{}",
			"level by {C:attention}#3#{}",
			"{X:attention,C:white}X#4#{} blind size",
		}
	},
	config = { extra = { odds = 20, mod = 1, blindmult = 4 } },
	pos = { x = 1, y = 7 },
	cost = 7,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
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
		if context.end_of_round and context.cardarea == G.jokers and G.GAME.current_round.hands_left == 0 then
			if pseudorandom('may_daredevil') < G.GAME.probabilities.normal / card.ability.extra.odds then
				mod_score_operator(-1, card.ability.extra.mod)
				return {
					message = 'Upgraded!',
					card = card
				}
			end
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
	pos = { x = 6, y = 0 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'n_jokers',
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
	end
}

SMODS.Joker {
	key = 'mustard',
	loc_txt = {
		name = 'Mustard',
		text = {
			"If {C:attention}joker slots{} are {C:attention}fully occupied{},",
			"played {C:attention}Diamonds{} have a {C:green}#1# in #2#{} chance",
			"to give {C:money}$#3#{}",
			"{C:inactive,E:1,s:0.5}art & original idea by _TeKKen_{}"
		}
	},
	config = { extra = { odds = 4, dollars = 15 } },
	pos = { x = 5, y = 1 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'n_jokers',
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
	pos = { x = 0, y = 2 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'n_jokers',
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
	end
}

if conf.Mode == 1 then

SMODS.Joker {
	key = 'hurley',
	loc_txt = {
		name = 'Hurley',
		text = {
			"Scoring {C:attention}10s{} have a",
			"{C:green}#2# in #3#{} chance to give {C:money}#1#${}",
			"{C:inactive,E:1,s:0.5}concept by therealten95{}"
    }
  },
	config = { extra = { dollars = 10, odds = 5 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
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
			"{C:inactive,E:1,s:0.5}concept by therealten95{}"
    }
  },
	config = { extra = { dollars = 100, odds = 10 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
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
	end
}

end

if conf.content.WIP then
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
	atlas = 'Placeholder',
	blueprint_compat = true,
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
	end
}
end
	
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
		"if hand is played while {C:attention}joker slots{}",
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
	pos = { x = 2, y = 6 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult, BA_messages[math.random(#BA_messages)] } }
   end,
   add_to_deck = function(self, card, from_debuff)
		if (not from_debuff) and conf.JokerEffects then
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
	end
}

SMODS.Joker {
	key = 'cacophonous',
	loc_txt = {
    name = 'Cacophonous',
    text = {
		"{X:mult,C:white}X#1#{} Mult for {C:attention}every owned joker{}",
		"{C:attention}Increases by {C:attention}#2#{} when a {C:attention}joker is {C:attention}bought{}",
		"{C:inactive}{X:mult,C:white}X#3#{} {C:inactive}Mult in total{}"
		}
	},
	config = { extra = { Xmult = 0.5, Xmult_gain = 0.2,  } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 3, y = 6 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, G.jokers and (#(G.jokers.cards or {})*card.ability.extra.Xmult) or 0 } }
	end,
	calculate = function(self, card, context) 
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult*#G.jokers.cards,
				message = "X"..card.ability.extra.Xmult*#G.jokers.cards.." Mult",
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
	end
}

if conf.Mode == 1 then

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
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1, 1)
					return true end}))
				}
			end
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
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1, 1)
					return true end}))
				}
			end
		end
	end
}

end

end
	-- Mythic
if conf.content.FusionJokers then

local UC_messages = {
	"I don't feel safe around this thing...",
	"Are you sure this is a good idea?",
	"I dont like where this is going.",
	"Who am I you ask? ERROR:(undefined string, author was too lazy to create lore)",
	"I feel funny...",
	"How did we get here?",
	"Is this thing really that important to you?",
	"Why am I saying strange things? I thought this mod has no lore!",
	"I am self aware, I just like not to think about it."
}

SMODS.Joker {
	key = 'universal_collapse',
	loc_txt = {
		name = 'Universal Collapse',
		text = {
			"{C:attention}Gains{} {X:mult,C:white}^#1#{} Mult when a {C:attention}joker{} is {C:attention}sold{}",
			"{C:inactive}Currently {X:mult,C:white}^#2#{}{C:inactive} Mult{}",
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
	rarity = 'may_mythic',
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 5, y = 4 },
	cost = 100,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Emult > 1 then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = '^'.. card.ability.extra.Emult .. ' Mult',
				colour = G.C.RED,
				card = card,	
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
				return true end}))				
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
	end
}

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
	atlas = 'Placeholder',
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
		"When Blind is selected,",
		"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} {C:attention}cards{}",
		"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:mult,C:white}^#2#{} Mult",
		"When {C:attention}a playing card{} is triggered, create {C:attention}#3#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} card(s)",
		"{C:inactive,s:0.5}man + Wheel of Eternity{}"
		}
	},
	rarity = 'may_mythic',
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 100,
	config = { extra = { blindcards = 5, Emult = 1.5, cards = 1, } },
	loc_vars = function(self, info_queue, card)
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
			return true end }))
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
			return true end }))
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
	end
}

if conf.content.WIP then

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
	atlas = 'n_jokers',
	blueprint_compat = true,
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
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
				colour = G.C.YELLOW
			}
		end
		if context.skipping_booster and context.cardarea == G.jokers then
			card.ability.extra.canupgrade = not card.ability.extra.canupgrade
			if card.ability.extra.canupgrade then
				card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
				if card.ability.extra.dollars >= 25 then
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.config.canspawn then
						G.E_MANAGER:add_event(Event({func = function()
							local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_jerrys_bait_shop')
							G.jokers:emplace(card2)
							card2:add_to_deck()
							play_sound("may_thunder"..math.random(1,2))
						return true end}))
						card.config.canspawn = false
					end
				return {
					message = 'Upgraded!',
					colour = G.C.YELLOW
				}
				end
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
			"This joker {C:attention}gains{} {X:mult,C:white}^^#2#{} Mult{}", 
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Curerntly {X:mult,C:white}^^#1#{}{C:inactive} Mult{}",
			"{C:inactive,s:0.5}Universal Collapse + Royale{}"
		}
	},
	config = { extra = { EEmult = 1, EEmult_gain = 0.1 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
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
	end
}

if conf.Mode == 2 then
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
	end
}

--[[SMODS.Joker {
	key = 'factorial_test',
	loc_txt = {
		name = 'Factorial Test 1',
		text = {
			"{X:mult,C:white}Mult!{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'Placeholder',
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
	atlas = 'Placeholder',
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
	atlas = 'Placeholder',
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
	key = 'aperiotion_test1',
	loc_txt = {
		name = 'Aperiotion Test 1',
		text = {
			"{X:mult,C:white}#1#{},"
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'Placeholder',
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
	atlas = 'Placeholder',
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
			"{C:inactive,s:0.5}Universal Collapse + AAAA{}"
		}
	},
	config = { extra = { repetitions = 4, e_mult = 11 } },
	rarity = "may_transcendent",
	blueprint_compat = true,
	atlas = 'joker1',
	pos = { x = 5, y = 5 },
	soul_pos = { x = 0, y = 6 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
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
				local soul = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_grim', nil)
				soul.no_forced_edition = true
				soul:set_edition({negative = true})
				soul.no_forced_edition = nil
				soul:setQty(1)
				soul:set_cost()
				soul:add_to_deck()
				G.consumeables:emplace(soul)
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
	end
}

if conf.Mode == 1 then

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = 'Storm',
		text = {
			"This joker {C:attention}gains{} {X:chips,C:white}^^#1#{} Chips",
			"when a {C:planet}planet{} card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}",
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
	end
}

else

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = 'Storm',
		text = {
			"This joker {C:attention}gains{} {X:chips,C:white}^^#1#{} Chips",
			"when a {C:planet}planet{} card is {C:attention}sold{}",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}",
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
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEchip_gain, card.ability.extra.EEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
			card.ability.extra.EEchip = card.ability.extra.EEchip + card.ability.extra.EEchip_gain
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
	end
}

SMODS.Joker {
	key = 'santa',
	loc_txt = {
		name = "Santa",
		text = {
			"This joker creates a {C:attention}random{} {C:dark_edition}Negative{} {X:mult,C:white}Rare{} Joker",
			"if played hand is a {C:attention}Pair{}",
			"{X:mult,C:white}^#2#{} Mult",
			"{C:inactive,s:0.5}Universal Collapse + Jolly Joker{}"
    }
  },
	config = { extra = { consumables = 8, Emult = 88 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
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
			return true end }))	
		end
		if context.joker_main then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = '^'.. card.ability.extra.Emult .. ' Mult',
				colour = G.C.MULT,
			}
		end
	end
}

	-- Interdimensional
	
SMODS.Joker {
	key = 'acum_universum',
	loc_txt = {
		name = 'ACVM VNIVERSVM',
		text = {
			"{C:attention}All{} scoring {C:attention}cards{} are {C:attention}turned into{} {C:attention}Aces{}",
			"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
			"and give {X:mult,C:white}^^#2#{} Mult",
			"{C:inactive,s:0.5}Universal Collapse + Acum{}"
		}
	},
	config = { extra = { repetitions = 11, ee_mult = 11 } },
	rarity = "may_interdimensional",
	atlas = 'joker1',
	blueprint_compat = true,
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
		"{C:inactive,s:0.5}Universal Collapse + ACVM VNIVERSVM{}"
		}
	},
	config = { extra = { repetitions = 22, eee_mult = 11 } },
	rarity = "may_ethereal",
	atlas = 'joker1',
	blueprint_compat = true,
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
		"{C:inactive,s:0.5}original concept by pyleup{}",
		"{C:inactive,s:0.5}Universal Collapse + Kepler{}"
		}
	},
	config = { extra = { EEEmult = 1 } },
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 },
	cost = 100000,
	rarity = 'may_ethereal',
	atlas = 'joker1',
	blueprint_compat = true,
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
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(3, 3)
				return true end }))				
		}
		end
	end
}

if conf.content.WIP then

SMODS.Joker {
	key = 'diskus_distruktum',
	loc_txt = {
		name = 'Diskus Distruktum',
		text = {
		"When {C:attention}blind{} is {C:attention}selected{}, create {C:attention}#1#{} {C:dark_edition}negative{} {C:purple}Wheel of Fortunes{}",
		"Amount {C:attention}increases{} by {C:attention}#2#{} when a {C:purple}Wheel of Fortune{} is used",
		"{C:attention}Jokers{} with an {C:dark_edition}edition{} give {X:purple,C:white}^^^#3#{} Mult & Chips",
		}
	},
	config = { extra = { blindamount = 10, scale = 1, EEEmultchips = 14 } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_ethereal',
	misc_badge = may_wip_badge,
	unlocked = true,
	discovered = true,
	atlas = 'Placeholder',
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.blindamount, card.ability.extra.scale, card.ability.extra.EEEmultchips,}}
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
	end
}

end

-- HyperAscendant

if conf.Mode == 1 then

SMODS.Joker {
	key = 'spadus',
	loc_txt = {
		name = 'Spadus',
		text = {
		"Played {C:attention}Aces{} give {X:purple,C:white}#1##2##3##4# Mult & Chips",
		"and are retriggered {C:attention}#5# times{}",
		"When hand is played, {C:attention}before scoring{}, {C:attention}gain{} the {C:planet}level{}",
		"of played Poker Hand as {X:purple,C:white}hyperoperational Mult & Chips{}",
		"{C:attention}Arrows increase{} by {C:attention}#6#{} when a {C:planet}planet card{} is {C:attention}used{} during a {C:attention}blind{}",
		"Arrows {C:mult}reset to #1##7##3#{} at the end of round",
		"When {C:attention}Blind{} is {C:attention}selected{}, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
		"{C:inactive,s:0.5}ACVM MVLTIPLEXVM + Kepler's Dream{}"
		}
	},
	config = { extra = { arrow = 6, Hmultchips = 11, retrigger = 11, arrow_gain = 1, reset = 6 } },
	rarity = "may_hyperascendant",
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 11e11,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hmultchips, card.ability.extra.retrigger, card.ability.extra.arrow_gain, card.ability.extra.reset }}
    end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			local b = 0
			if to_big(G.GAME.hands[context.scoring_name].level) >= to_big(500) then
				b = 500
			else
				b = to_number(G.GAME.hands[context.scoring_name].level)
			end
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = b,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1.3, 1.3)
					return true end }))
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then	
				local a = 0
				if to_big(G.GAME.hands[context.scoring_name].level) >= to_big(600) then
					a = 600
				else
					a = to_number(G.GAME.hands[context.scoring_name].level)
				end 
				return {
					hyper_mult = {a, card.ability.extra.Hmultchips},
					hyper_chips = {a, card.ability.extra.Hmultchips},
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
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.arrow = card.ability.extra.reset
			return {
				message = 'Reset!',
				colour = G.C.PURPLE,
				card = card,
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
		if context.using_consumeable and context.consumeable:gc().set == 'Planet' or context.consumeable:gc().set == 'rare_planets' or context.consumeable:gc().set == 'legendary_planets' and G.hand and not context.blueprint then
			card.ability.extra.arrow = card.ability.extra.arrow + card.ability.extra.arrow_gain 
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
		"Played {C:attention}Aces{} give {X:purple,C:white}#2##1# Mult & Chips",
		"Number of arrows is set to {C:planet}level{} of played Poker Hand before scoring",
		"{C:inactive}Max arrow limit of 50,000{}",
		"All {C:attention}Aces{} are {C:attention}retriggered{} a number of times equal to played Poker Hand {C:planet}level{}",
		"When {C:attention}Blind{} is {C:attention}selected{}, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
		"{C:inactive,s:0.5}ACVM MVLTIPLEXVM + Kepler's Dream{}"
		},
	},
	config = { extra = { amount = 11 } },
	rarity = "may_hyperascendant",
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 11e11,
	config = { extra = { amount = 11 } },
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount, "{...}"}}
    end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = to_number(G.GAME.hands[context.scoring_name].level),
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(1.3, 1.3)
					return true end }))
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then	
				local a = 0
				if to_big(G.GAME.hands[context.scoring_name].level) >= to_big(50000) then
					a = 50000
				else
					a = to_number(G.GAME.hands[context.scoring_name].level)
				end 
				return {
					hyper_mult = {a, card.ability.extra.amount},
					hyper_chips = {a, card.ability.extra.amount},
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
	end
}

end

if conf.content.WIP then

SMODS.Joker {
	key = 'overflow',
	loc_txt = {
		name = 'Overflow',
		text = {
		"{X:chips,C:white}#1##2##3##4#{} Chips",
		"When {C:attention}blind{} is {C:attention}selected{}, set number of {C;attention}arrows to {C:chips}current hands{}",
		"Arrow count {C:attention}increases by #5#{} when {C:attention}hand{} is {C:attention}played{}",
		"{C:mult}Resets to 1{} when {C:attention}blind{} is {C:attention}defeated{}"
		}
	},
	config = { extra = { arrow = 1, Hchips = 3, arrow_gain = 1 } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_hyperascendant',
	misc_badge = may_wip_badge,
	unlocked = true,
	discovered = true,
	atlas = 'Placeholder',
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hchips, card.ability.extra.arrow_gain }}
    end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.arrow = G.GAME.current_round.hands_left
			return {
				message = generate_arrow_text(card.ability.extra.arrow, 8),
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.joker_main then
			if not context.blueprint then
				card.ability.extra.arrow = card.ability.extra.arrow + card.ability.extra.arrow_gain
			end
			return {
				hyper_chips = {card.ability.extra.arrow, card.ability.extra.Hchips},
				message = generate_arrow_text(card.ability.extra.arrow, 5)..' Chips',
				colour = G.C.CHIPS,
				card = card,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.arrow = 1
			return {
				message = 'Reset!',
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
	apply = function(self)
		G.GAME.starting_params.hand_size = 8 + self.config.hand_size
	end
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
			"{C:attention}Playing cards{} give {X:attention,C:white}X10{} more {C:chips}Chips{}"
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
	config = {mult = 10},
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
			"{X:mult,C:white}Rare{} {C:attention}joker{}"
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
			"copies of a {C:attention}random{} {X:green,C:white}Uncommon{} {C:attention}joker{}"
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

-- Have to change the name because MF also has a raibow deck and they like interchanging
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
			"and a radom {X:mult,C:white}Rare{} {C:attention}joker{}",
		},
    },
	apply = function(self)
		G.GAME.starting_params.hand_size = 8 + self.config.hand_size
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.size_mod
		G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
		G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
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
			"and a radom {X:mult,C:white}Rare{} {C:attention}joker{}",
		},
    },
	apply = function(self)
		G.GAME.starting_params.hand_size = 8 + self.config.hand_size
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.size_mod
		G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
		G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
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
	name = "AAAA deck",
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
				local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_etherealdeck")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				play_sound('may_ethereal_joker')
			end
		return true end}))
	end
}

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

SMODS.Back {
	name = "Ascended Plasma Deck",
	key = "asc_plasma_deck",
	atlas = 'Placeholder',
	pos = { x = 4, y = 2 },
	config = {EEmultchips = 30},
	loc_txt = {
		name = "Ascended Plasma Deck",
		text = {
			"{C:attention}Balances{} {C:purple}Mult & Chips{}",
			"Before balancing, {X:purple,C:white}^^30{} Mult & Chips",
		},
    },
	calculate = function(self, card, context)
		if context.final_scoring_step then
			hand_chips = mod_chips(hand_chips:arrow(2, self.config.EEmultchips))
			mult = mod_mult(mult:arrow(2, self.config.EEmultchips))	
			jl.hcm(hand_chips, mult)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eemult')
				play_sound('talisman_eechip')
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
	end
}

SMODS.Back {
	name = "Balance Deck",
	key = "balance_deck",
	atlas = 'Placeholder',
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = "Balance Deck",
		text = {
			"After {C:attention}hand{} is {C:attention}played{},",
			"{C:attention}increase{} {C:dark_edition}score operator{} level by",
			"{C:attention}final{} {C:mult}Mult{} {C:attention}divided by{} {C:attention}final{} {C:chips}Chips",
			"{C:inactive}(rounded){}"
		},
    },
	calculate = function(self, back, context)
		if context.after then
			mod_score_operator(-1, math.ceil(to_number(mult:div(hand_chips))), false)
		end
	end
}

-- Cryptid CM content
if #SMODS.find_mod('Cryptid') ~= 0 and conf.CM.Cryptid then

-- Cryptid Fusions

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_cry_circulus_pistoris', nil, nil, 'j_may_hypersphere', 314159, 'may_interdimensional_joker', nil, 0.8)

if conf.content.WIP then

FusionJokers.fusions:add_fusion('j_bones', nil, nil, 'j_cry_tenebris', nil, nil, 'j_may_mortuary', 1000000, 'may_interdimensional_joker', nil, 0.8)

end

-- Cryptid Atlases
SMODS.Atlas {
	key = "cry_editioncard",
	path = "cry_editioncard.png",
	px = 71,
	py = 95
}

if conf.content.Consumables then
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
	config = { extra = { min_xmult = 0.1, max_xmult = 10, min_xchips = 0.1, max_xchips = 10 } },
	loc_txt = {
		name = 'Glitched Card',
		text = {
			'Gives all hands {C:attention}anywhere between x0.1 and x10{}',
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
		jl.hcm('x'..xchips, nil, true)		
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
		jl.hcm(nil, 'x'..xmult, true)		
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
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
			card:juice_up(1, 1)
		return true end }))	
		jl.hcm(nil, 'x'..card.ability.extra.xmult, true)		
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
			G.GAME.hands[k].mult = G.GAME.hands[k].mult * (card.ability.extra.xmult*number)
			G.GAME.hands[k].chips = G.GAME.hands[k].chips * (card.ability.extra.xchips*number)
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
		jl.hcm(nil, 'x'..card.ability.extra.xmult*number, true)		
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_xchip')
			card:juice_up(1, 1)
		return true end }))	
		jl.hcm('x'..card.ability.extra.xchips*number, nil, true)		
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

-- Cryptid Jokers


if conf.content.FusionJokers then
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
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	rarity = "may_interdimensional",
	cost = 314159,
	blueprint_compat = true,
	atlas = "joker1",
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

if conf.content.WIP then

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
	atlas = 'Placeholder',
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

if conf.content.WIP then

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
	atlas = 'Placeholder',
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

end


-- CardSleeves CM
if CardSleeves and conf.content.WIP then

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
			G.GAME.blind.chips = G.GAME.blind.chips * 0.5
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
			self.config = { extra_discard_bonus = 2 }
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
if SMODS.BlindEdition and conf.CM.BlindEditions then

-- Idea of adding sounds to blind editions was *borrowed* from Jen's Almanac
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

-- Debug tools
if conf.Debug then

	local goog = to_big(1e100)
	
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
			if conf.Mode == 1 then
				conf.Mode = 2
			else
				conf.Mode = 1
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
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:fact()
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:fact()
			end
			jl.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_factmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm(nil, 'Mult!', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_factchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			jl.hcm('Chips!', nil, true)
			jl.ch()
			delay(0.5)
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
	
	
end