if not (Big and Big.arrow) then
	error('!! OMEGANUM NOT ENABLED. PLEASE REMOVE MAYHEM FROM YOUR MODS FOLDER, SET TALISMAN TO OMEGANUM AND THEN MOVE MAYHEM BACK.')
end

-- Config
local conf = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
	return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.UI.BACKGROUND_DARK}, nodes={
		{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = "Settings", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
				}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = "Most settings need you to restart the game to be applied", colour = G.C.UI.TEXT_LIGHT, scale = 0.2}},
				}},
		}},
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Mode",
					scale = 1,
					w = 6,
					options = {"Mayhem (Classic)", "Eternum"},
					opt_callback = 'may_upd_mode',
					current_option = conf.Mode,
                })
			}},
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
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Blind Scaling",
					scale = 1,
					w = 6,
					options = {"Vanilla", "Accelerated (Default)", "Very Fast", "RIDICULOUS"},
					opt_callback = 'may_upd_scaling',
					current_option = conf.Scaling,
                })
			}},
			{n = G.UIT.R, config = { align = "c", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Starting Parameters Buff",
					scale = 1,
					w = 6,
					options = {"None", "Default", "Generous"},
					opt_callback = 'may_upd_params',
					current_option = conf.Params,
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
				create_option_cycle({
					label = "Transcendence Effects",
					scale = .5,
					w = 10,
					options = {"Disabled", "Default", "High (LAGGY)"},
					opt_callback = 'may_upd_treffects',
					current_option = conf.TrEffects,
                })
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				create_option_cycle({
					label = "Transcendence Ambiance",
					scale = .5,
					w = 10,
					options = {"Disabled", "Enabled"},
					opt_callback = 'may_upd_traudio',
					current_option = conf.TrAudio,
                })
			}},
			{n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
				UIBox_button({label = {"Restart"}, button = 'may_conf_restart', minw = 1.7, minh = 0.4, scale = 0.35})
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

G.FUNCS.may_upd_traudio = function(e)
	conf.TrAudio = e.to_key
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

G.FUNCS.may_upd_music = function(e)
	conf.Music = e.to_key
end

G.FUNCS.may_upd_limit = function(e)
	conf.Limit = e.to_key
end

G.FUNCS.may_upd_VNShake = function(e)
	conf.VNShake = e.to_key
end

VNShake = conf.VNShake

modaddon = function()
return {
	Cryptid = true,
}
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
			label = 'Credits',
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = {
					align = 'cm',
					minw = 8,
					minh = 4,
					r = .1,
					padding = .1,
					colour = G.C.BLACK
				}, nodes = {
				-- balatro ui is esoteric
					{n=G.UIT.C, config={}, nodes={
						{n=G.UIT.R, config={}, nodes={
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Santa Music - Rolling Sky", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Techno and Antimatter sounds - Colossatron", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
							}}
						}},
						{n=G.UIT.R, config={}, nodes={
							{n = G.UIT.T, config = {text = "Genesis sound - Minecraft", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
						}},
						{n=G.UIT.R, config={}, nodes={
							{n=G.UIT.C, config={}, nodes={
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.T, config = {text = "Ethereal ambience (stage 2) - Will You Snail?", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
								}},
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.T, config = {text = "Ethereal ambience (stage 3) - tubesofthepit by Freesound on Pixabay", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
								}},
							}}
						}},
						{n=G.UIT.R, config={}, nodes={
							{n=G.UIT.C, config={}, nodes={
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.T, config = {text = "Ethereal ambience (stage 4) - Daytime to Night by cxnder", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
								}},
								{n=G.UIT.R, config={}, nodes={
									{n = G.UIT.T, config = {text = "Santa hohoho - Santa Papa Noel by Risa on Pixabay", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
								}},
							}}
						}}
					}}
				}}
			end,
			}
		},
				{
			label = 'Additional Content',
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = {
					align = 'cm',
					minw = 8,
					minh = 4,
					r = .1,
					padding = .1,
					colour = G.C.BLACK
				}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n=G.UIT.R, config={}, nodes={
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.T, config = {text = "Mayhem enables unique content if you're also playing with certain mods", colour = G.C.UI.TEXT_LIGHT, scale = 0.3}},
							}},
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Cryptid', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = modaddon, ref_value = "Cryptid" },
								}},
							}}
						}},
						{n=G.UIT.R, config={}, nodes={
							{n=G.UIT.R, config={}, nodes={
								{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = 'Jen\'s Almanac', scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
							}},
								{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
									create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = modaddon, ref_value = "Jen" },
								}},
							}}
						}},
					}}
				}}
			end,
			}
end
-- Misc

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

	-- Starting Params

may_parambuff = conf.Params

if conf.Params ~= 1 then
	local vanf_gsp = get_starting_params
	function get_starting_params()
		params = vanf_gsp()
		params.consumable_slots = params.consumable_slots + conf.Params
		return params
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
	colours = {HEX('000000'), HEX('8ebbbd'), HEX('0f0121')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_ethereal',
	colours = {HEX('9d52ff'), HEX('220647')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_interdimensional',
	colours = {HEX('000000'), HEX('f03030')},
	interpolation = 'trig'
}

	-- Mayhem/Eternum stuff

may_mode = conf.Mode
	
if conf.Mode == 2 then
	SMODS.current_mod.display_name = "Eternum"
	SMODS.current_mod.badge_colour = SMODS.Gradients.may_eternum_green
end

-- Custom scaling
if conf.Scaling ~= 1 then
	function get_blind_amount(ante)
		if not amount then
			amount = to_big(200) 
		end
		if conf.Scaling == 2 then
			if ante < 4 then
				amount = to_big(100*(ante+2))
			end
			if ante > 4 then 
				amount = to_big(10^(math.floor(ante*.8)))
			end
			if ante > 20 then
				amount = to_big(100):arrow(math.floor(math.sqrt(ante*.2)), ante^2)
			end
			if ante > 50 then
				amount = to_big(100):arrow(math.floor(math.log10(ante))*ante, to_big(100):arrow(1, math.sqrt(ante)))
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

wipmode = true
-- I kind of rushed the mod due to me worrying it will never come out. This enables some unfinished stuff i would've added.

-- Incantation stuff
if not IncantationAddons then
	IncantationAddons = {
		Stacking = {},
		Dividing = {},
		BulkUse = {},
		StackingIndividual = {},
		DividingIndividual = {},
		BulkUseIndividual = {}
	}
end

table.insert(IncantationAddons.BulkUse, 'editioncards')

table.insert(IncantationAddons.BulkUse, 'yottacards')

table.insert(IncantationAddons.BulkUse, 'ascendedplanets')

-- Ethereal checks
function hasethereal()
	if not G.GAME then return false end
	if not G.GAME.hasethereal then return false end
	if #SMODS.find_card("j_may_the_multiverse") > 0 then
		return false
	else
		return G.GAME.hasethereal
	end
end

function set_hasethereal(bool)
	if not G.GAME then return false end
	G.GAME.hasethereal = bool
end

SMODS.current_mod.debug_info = "Hi you found a crash. Yell about it in my dms with the error message so i can fix it."

-- Aurinko stuff
if not AurinkoAddons then
	AurinkoAddons = {}
end

if not AurinkoWhitelist then
	AurinkoWhitelist = {
	"may_editioncards"
	}
end

-- Money operations

function multmoney(amount)
	if G and G.GAME then
		-- OmegaNum arrow 0 is actually multiplication
		G.GAME.dollars = G.GAME.dollars:arrow(0, amount)
		play_sound('may_bigmoney')
	end
end

function hypermoney(arrow, amount)
	if G and G.GAME then
		G.GAME.dollars = G.GAME.dollars:arrow(arrow, amount)
		play_sound('may_bigmoney')
		if arrow == 1 then
			play_sound('may_e_antimatter')
		end
		if arrow == 2 then
			play_sound('talisman_eemult')
		end
		if arrow => 3 then
			play_sound('talisman_eeemult')
		end
		G.ROOM.jiggle = G.ROOM.jiggle + (arrow/5)
	end
end

-- Transcendence effects
if not may then may = {} end

may_TrAudio = conf.TrAudio 

if conf.TrEffects ~= 1 then
	SMODS.DrawStep {
		key = 'transcendence_shake',
		order = 1e10,
		func = function(self)
			if G.hand then
				if (may.transcendence or 0) < 9 and (may.transcendence or 0) > 0 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables then
						self:juice_up(0.01, math.random(0, (may.transcendence or 0))/9)
					end
				else 
					if (may.transcendence or 0) == 9 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables then
							self:juice_up(math.random(-2, 2), math.random(1, 3))
						end
					end
					if (may.transcendence or 0) == 10 then
						if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables then
							self:juice_up(math.random(-3, 3), math.random(1, 10))
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
		if G.GAME.blind then
			if (may.transcendence or 0) > 0 then
				G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
				ease_colour(G.C.UI_CHIPS, copy_table(G.C.DARK_EDITION), .6)
				ease_colour(G.C.UI_MULT, copy_table(G.C.DARK_EDITION), .6)
			else
				ease_colour(G.C.UI_CHIPS, HEX("009dff"), 1)
				ease_colour(G.C.UI_MULT, HEX('FE5F55'), 1)
			end
		end
	end
elseif conf.TrEffects == 3 then
	local upd = Game.update
	function Game:update(dt)
		upd(self, dt)
		if G.GAME.blind then
			if (may.transcendence or 0) > 0 then
				G.hand_text_area.blind_chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
				G.hand_text_area.mult:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
				G.hand_text_area.chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
				G.hand_text_area.handname:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
				G.hand_text_area.hand_level:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
				G.ROOM.jiggle = G.ROOM.jiggle + (may.transcendence or 0)/4.5
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
			end
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

function may_obfuscatedtext(length)
	local str = ""
	for i = 1, length do
		str = str .. randtext[math.random(#randtext)]
	end
	return str
end

 ultraeditions = {
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
end

function fact(n)
	if n <= 0 then
		return 1
	else
		result = n * fact(n-1)
		return result
	end
end

-- Multiply hand level
function super_level_up_hand(card, hand, instant, amount)
    amount = amount or 1
    G.GAME.hands[hand].level = math.max(0, G.GAME.hands[hand].level*amount)
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

local ccr = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
		if card.ability.set == 'yottacards' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = not immediate and 0.2 or 0, blockable = not immediate, func = function()
				play_sound('may_enchant')
				card:juice_up()
			return true end}))
		end
	return card
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

SMODS.PokerHand {
    key = 'Flush AAAA',
    chips = 111,
    mult = 11,
    l_chips = 111,
    l_mult = 11,
	visible = false,
    example = {
        { 'S_A',    true },
        { 'S_A',    true },
        { 'S_A',    true },
        { 'S_A',    true },
        { 'S_A',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Flush AAAA',
            description = {
                'Five Aces with the same suit.'
            }
        }
    },
    evaluate = function(parts, hand)
        if next(parts._5) and next(parts._flush) then
            local _strush = SMODS.merge_lists(parts._5, parts._flush)
            local five = true
            for j = 1, #_strush do
                local rank = SMODS.Ranks[_strush[j].base.value]
                five = five and (rank.key == 'Ace')
            end
            if five then return {_strush} end
        end
    end,
}

-- Atlases
SMODS.Atlas {
  key = "Jokers1",
  path = "mayjoker1.png",
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
	path = "placeholders.png",
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
	key = "editioncard",
	path = "editioncard.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "enhancements",
	path = "enhancements.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "booster",
	path = "packs.png",
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
	key = "greenmult",
	path = "greenmult.png",
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
	key = "voucher",
	path = "voucher.png",
	px = 71,
	py = 95,
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
	key = 'temp_ceasvoid',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34,
	path = 'temp_ceasvoid.png'
}

-- SFX

SMODS.Sound({key = 'bighit', path = 'bighit.ogg'})
SMODS.Sound({key = 'thunder1', path='thunder1.ogg'})
SMODS.Sound({key = 'thunder2', path='thunder2.ogg'})
SMODS.Sound({key = 'bigmoney', path='hugemoney.ogg'})

SMODS.Sound({key = 'e_amber', path = 'e_amber.ogg'})
SMODS.Sound({key = 'e_nostalgic', path = 'e_nostalgic.ogg'})
SMODS.Sound({key = 'e_techno', path = 'e_techno.ogg'})
SMODS.Sound({key = 'e_antimatter', path = 'e_antimatter.ogg'})
SMODS.Sound({key = 'e_hallucinatory', path = 'e_hallucinatory.ogg'})
SMODS.Sound({key = 'e_hypnotic', path = 'e_hypnotic.ogg'})

SMODS.Sound({key = 'e_ultrafoil', path = 'e_ultrafoil.ogg'})
SMODS.Sound({key = 'e_ultraholo', path = 'e_ultraholographic.ogg'})
SMODS.Sound({key = 'e_ultrapoly', path = 'e_ultrapolychrome.ogg'})
SMODS.Sound({key = 'e_ultraamber', path = 'e_ultraamber.ogg'})
SMODS.Sound({key = 'e_ultranostalgic', path = 'e_ultranostalgic.ogg'})
SMODS.Sound({key = 'e_ultratechno', path = 'e_ultratechno.ogg'})
SMODS.Sound({key = 'e_ultraantimatter', path = 'e_ultraantimatter.ogg'})

SMODS.Sound({key = 'weezer', path='weezer.ogg'})
SMODS.Sound({key = 'st_hohoho', path='hohoho.ogg'})
SMODS.Sound({key = 'st_bells', path='santa_bells.mp3'})

SMODS.Sound({key = 'enchant', path='enchant.ogg'})
SMODS.Sound({key = 'super_level', path='super_level.ogg'})
SMODS.Sound({key = 'rare_planet', path='rare_planet.ogg'})
SMODS.Sound({key = 'ascended', path='ascended.ogg'})

SMODS.Sound({key = 'interdimensional_joker', path='interdimensional_joker.ogg'})
SMODS.Sound({key = 'ethereal_joker', path='ethereal_joker.ogg'})
SMODS.Sound({key = 'hyperascendant_joker', path='hyperascendant_joker.ogg'})

SMODS.Sound({key = 'tran1', path = 'tran1.ogg'})
SMODS.Sound({key = 'tran2', path = 'tran2.ogg'})
SMODS.Sound({key = 'tran3', path = 'tran3.ogg'})
SMODS.Sound({key = 'tran4', path = 'tran4.ogg'})
SMODS.Sound({key = 'tran5', path = 'tran5.ogg'})
SMODS.Sound({key = 'tran6', path = 'tran6.ogg'})
SMODS.Sound({key = 'tran7', path = 'tran7.ogg'})
SMODS.Sound({key = 'tran8', path = 'tran8.ogg'})

-- Fusions

-- joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, condition, code, shake
 
FusionJokers.wildcards:add_wildcard('j_may_universal_collapse')

	-- Mythic
	
FusionJokers.fusions:add_fusion('j_triboulet', nil, nil, 'j_baron', nil, nil, 'j_may_patriarch', 250)

FusionJokers.fusions:add_fusion('j_may_man', nil, nil, 'j_may_wheel_of_eternity', nil, nil, 'j_may_diskus', 140)
 
	-- Transcendent

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_hurley', nil, nil, 'j_may_ultimate_hurley', 1000)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_nebula', nil, nil, 'j_may_cosmos', 1000)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_AAAA', nil, nil, 'j_may_acum', 1111)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_destroyer', nil, nil, 'j_may_storm', 1300)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_baron', nil, nil, 'j_may_little_prince', 1100)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_daredevil', nil, nil, 'j_may_party_time', 1100)

	-- Interdimensional
 
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum', nil, nil, 'j_may_acum_universum', 111111, 'may_interdimensional_joker', nil, nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_storm', nil, nil, 'j_may_cosmos', nil, nil, 'j_may_kepler', 100000, 'may_interdimensional_joker', nil, nil, 0.8)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_jolly', nil, nil, 'j_may_santa', 88888, 'may_interdimensional_joker', nil, nil, 0.8)

	-- Ethereal
  
FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_acum_universum', nil, nil, 'j_may_acum_multiplexum', 11111111, 'may_ethereal_joker', hasethereal() == false, set_hasethereal(true), 1)

FusionJokers.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_may_kepler', nil, nil, 'j_may_keplers_dream', 1e7, 'may_ethereal_joker', hasethereal() == false, set_hasethereal(true), 1)

	-- HyperAscendant

FusionJokers.fusions:add_fusion('j_may_acum_multiplexum', nil, nil, 'j_may_keplers_dream', nil, nil, 'j_may_spadus', 11e110, 'may_hyperascendant_joker', nil, nil, 1.5)


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
	path = "music_santa.mp3",
	pitch = 1,
	sync = false,
	select_music_track = function()
		return #SMODS.find_card('j_may_santa') > 0
	end,
})

SMODS.Sound({
	key = "music_party",
	path = "music_party.ogg",
	pitch = 1,
	sync = false,
	select_music_track = function()
		return #SMODS.find_card('j_may_party_time') > 0 and conf.Partymusic
	end,
})

SMODS.Sound({
	key = "music_menu",
	path = "music_menu.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not conf.Music == 4 or conf.Music == 2 or (conf.Music == 1 and conf.Mode == 1)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_eternum",
	path = "music_eternum.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not conf.Music == 4 or conf.Music == 3 or (conf.Music == 1 and conf.Mode == 2)) and (G.GAME and not G.GAME.blind) and 0 or false
	end,
})

SMODS.Sound({
	key = "music_tran9",
	path = "tran9.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 9
	end,
})

SMODS.Sound({
	key = "music_tran10",
	path = "tran10.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity.transcendence == 10
	end,
})

SMODS.Sound({
	key = "music_editioncard",
	path = "music_edition.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.pack_cards  and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "editioncards") or false
	end
})

SMODS.Sound({
	key = "music_ultrablind",
	path = "music_ultrablind.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and (G.GAME.blind.config.blind.ultra)) and 1 or false
	end,
})

--[[ Editions

	-- Shaders
	
	SMODS.Shader({ key = 'amber', path = 'amber.fs' })
	SMODS.Shader({ key = 'nostalgic', path = 'nostalgic.fs' })
	SMODS.Shader({ key = 'techno', path = 'techno.fs' })
	SMODS.Shader({ key = 'hallucinatory', path = 'hallucinatory.fs' })

	
	-- --
	
	SMODS.Edition({
    key = "Amber",
    loc_txt = {
        name = "Amber",
        label = "Amber",
        text = {
            "{C:chips}+875{} chips BUT {C:mult}-10{} Mult",
        }
    },

    shader = 'amber',
    discovered = true,
	badge_colour = G.C.DARK_EDITION,
	sound = { sound = "may_e_amber", per = 1, vol = 0.9},
    unlocked = true,
    config = { chips = 875, mult = -10},
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        return { vars = { self.config.chips, self.config.mult, } }
    end
})

	SMODS.Edition({
    key = "nostalgic",
    loc_txt = {
        name = "Nostalgic",
        label = "Nostalgic",
        text = {
			"{C:mult}x10 Mult{}"
        }
    },

    shader = 'nostalgic',
    discovered = true,
	badge_colour = G.C.FILTER,
	sound = { sound = "may_e_nostalgic", per = 1, vol = 0.9},
    unlocked = true,
    config = { x_mult = 10 },
    in_shop = true,
    weight = 2,
    extra_cost = 10,
    apply_to_float = true,
	})
	SMODS.Edition({
    key = "techno",
    loc_txt = {
        name = "Techno",
        label = "Techno",
        text = {
		"{C:mult}^2 Mult{}, {C:money}-10${}"
        }
    },

    shader = 'techno',
    discovered = true,
	badge_colour = G.C.BLACK,
	sound = { sound = "may_e_techno", per = 1, vol = 0.9 },
    unlocked = true,
    config = { e_mult = 2, p_dollars= -10},
    in_shop = true,
    weight = 2,
    extra_cost = 10,
    apply_to_float = true,
	})
	
	SMODS.Edition({
    key = "antimatter",
    loc_txt = {
        name = "Antimatter",
        label = "Antimatter",
        text = {
		"{C:purple}^^^1.1 Mult & Chips{}"
        }
    },

    shader = 'techno',
    discovered = true,
	badge_colour = G.C.BLACK,
	sound = { sound = "may_e_antimatter", per = 1, vol = 0.9 },
    unlocked = true,
    config = { eee_mult = 1.1, eee_chips = 1.1},
    in_shop = true,
    weight = 1,
    extra_cost = 10,
    apply_to_float = true,
	})
	
		SMODS.Edition({
    key = "hallucinatory",
    loc_txt = {
        name = "Hallucinatory",
        label = "Hallucinatory",
        text = {
		"{C:purple}^^^17 Mult & Chips{}"
        }
    },

    shader = 'hallucinatory',
    discovered = true,
	badge_colour = G.C.BLACK,
	sound = { sound = "may_e_hallucinatory", per = 1, vol = 0.9 },
    unlocked = true,
    config = { eee_chips = 17, eee_mult = 17 },
    in_shop = true,
    weight = .001,
    extra_cost = 10,
    apply_to_float = true,
	})
	-- Ultraeditions

	SMODS.Edition({
    key = "ultrafoil",
    loc_txt = {
        name = "Ultrafoil",
        label = "Ultrafoil",
        text = {
            "{C:chips, s:2}x500 Chips{}",
        }
    },

    shader = 'amber',
    discovered = true,
	badge_colour = G.C.BLUE,
	sound = { sound = "may_e_ultrafoil", per = 1, vol = 1.1},
    unlocked = true,
    config = { x_chips = 500 },
    in_shop = true,
    weight = .001,
    extra_cost = 50,
    apply_to_float = true,
})

	SMODS.Edition({
    key = "ultraholo",
    loc_txt = {
        name = "Ultraholographic",
        label = "Ultraholographic",
        text = {
            "{C:mult, s:2}x100 Mult{}",
        }
    },

    shader = 'amber',
    discovered = true,
	badge_colour = G.C.RED,
	sound = { sound = "may_e_ultraholo", per = 1, vol = 1.1},
    unlocked = true,
    config = { x_mult = 100 },
    in_shop = true,
    weight = .001,
    extra_cost = 50,
    apply_to_float = true,
})

	SMODS.Edition({
    key = "ultrapoly",
    loc_txt = {
        name = "Ultrapolychrome",
        label = "Ultrapolychrome",
        text = {
            "{C:mult, s:3}^15 Mult{}",
        }
    },

    shader = 'amber',
    discovered = true,
	badge_colour = G.C.RED,
	sound = { sound = "may_e_ultrapoly", per = 1, vol = 1.1},
    unlocked = true,
    config = { e_mult = 15 },
    in_shop = true,
    weight = .001,
    extra_cost = 50,
    apply_to_float = true,
})


	SMODS.Edition({
    key = "ultraamber",
    loc_txt = {
        name = "Ultraamber",
        label = "Ultraamber",
        text = {
            "{C:chips, s:2}x85 Chips{} and {C:mult, s:2}x200 Mult{}",
        }
    },

    shader = 'amber',
    discovered = true,
	badge_colour = G.C.DARK_EDITION,
	sound = { sound = "may_e_ultraamber", per = 1, vol = 1.1},
    unlocked = true,
    config = { x_chips = 85, x_mult = 200 },
    in_shop = true,
    weight = .001,
    extra_cost = 50,
    apply_to_float = true,
    loc_vars = function(self)
        return { vars = { self.config.x_chips, self.config.x_mult } }
    end
})

	SMODS.Edition({
    key = "ultranostalgic",
    loc_txt = {
        name = "Ultra Nostalgic",
        label = "Ultra Nostalgic",
        text = {
            "{C:mult,s:2}^100 mult{}",
        }
    },

    shader = 'nostalgic',
    discovered = true,
	badge_colour = G.C.FILTER,
	sound = { sound = "may_e_ultranostalgic", per = 1, vol = 0.9},
    unlocked = true,
    config = { e_mult = 100 },
    in_shop = true,
    weight = .0005,
    extra_cost = 10,
    apply_to_float = true,
	})
	
		SMODS.Edition({
    key = "ultratechno",
    loc_txt = {
        name = "Ultra Techno",
        label = "Ultra Techno",
        text = {
		"{C:mult}^^2 Mult{} and {C:money}+20${}"
        }
    },

    shader = 'techno',
    discovered = true,
	badge_colour = G.C.BLACK,
	sound = { sound = "may_e_ultratechno", per = 1, vol = 0.9 },
    unlocked = true,
    config = { ee_mult = 2, p_dollars= 20},
    in_shop = true,
    weight = .0005,
    extra_cost = 10,
    apply_to_float = true,
	})
	
	SMODS.Edition({
    key = "ultraantimatter",
    loc_txt = {
        name = "Ultra Antimatter",
        label = "Ultra Antimatter",
        text = {
		"{C:mult,s:2}^^^2.2 Mult{}"
        }
    },

    shader = 'techno',
    discovered = true,
	badge_colour = G.C.BLACK,
	sound = { sound = "may_e_ultraantimatter", per = 1, vol = 0.9 },
    unlocked = true,
    config = { ee_mult = 2, p_dollars= 20},
    in_shop = true,
    weight = .0005,
    extra_cost = 10,
    apply_to_float = true,
	}) ]]

-- Enhancements

--[[SMODS.Enhancement {
	key = 'riffraffcard',
	loc_txt = {
		name = 'Riff-Raff Card',
		text = {
			'Creates a {C:attention}random Common Joker{}',
			'{C:inactive}(Requires room){}'
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'enhancements',
	weight = 3,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context, effect)
	end
}

	-- Ultra Enhancements
	
	SMODS.Enhancement {
	key = 'ultrariffraffcard',
	loc_txt = {
		name = 'Ultra Riff-Raff Card',
		text = {
			'Creates a {C:attention}random{} {C:mult}Rare Joker{}',
			'{C:inactive}Requires room{}',
			'{X:dark_edition,C:edition}Ultra Enhancement{}'
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'enhancements',
	weight = 0.001,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context, effect)
	end
}
	


SMODS.Enhancement {
	key = 'ultrastone',
	loc_txt = {
		name = 'Ultra Stone Card',
		text = {
			'{C:chips,s:3}^5{} Chips',
			'No {C:attention}suit or rank{}',
			'{X:dark_edition,C:edition}Ultra Enhancement{}'
		}
	},
	config = {Echips = 5},
	pos = { x = 1, y = 0 },
	unlocked = true,
	always_scores = true,
	no_rank = true,
	no_suit = true,
	replace_base_card = true,
	weight = 0.1,
	discovered = true,
	atlas = 'enhancements',
}

SMODS.Enhancement {
	key = 'geometric',
	loc_txt = {
		name = 'Geometric Card',
		text = {
			'{X:mult,C:white}^^sqrt(2){}Mult',
			'{X:dark_edition,C:edition}Ultra Enhancement{}'
		}
	},
	config = {EEmult = math.sqrt(2)},
	pos = { x = 0, y = 0 },
	unlocked = true,
	weight = 0.1,
	discovered = true,
	atlas = 'enhancements',
}]]

SMODS.Enhancement {
	key = 'greenmult',
	loc_txt = {
		name = 'Super Mult',
		text = {
			'{C:mult}+444{} Mult',
			'{C:inactive}WIP{}'
		}
	},
	pos = { x = 0, y = 0 },
	config = {extra = {mult = 444 } },
	unlocked = false,
	replace_base_card = false,
	weight = 1,
	discovered = false,
	atlas = 'greenmult',
}

-- Consumable Types

SMODS.ConsumableType {
	key = 'editioncards',
	collection_rows = {6, 6},
	primary_colour = G.C.EDITION,
	secondary_colour = G.C.BLACK,
	loc_txt = {
		collection = 'Edition Cards',
		name = 'Edition Card',
	},
	shop_rate = 2,
	can_stack = true,
	can_divide = true,
	rarities = {
		{
			key = 'Common',
			rate = 1,
		},
		{
			key = 'Rare',
			rate = .4,
		}
	}
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
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

if wipmode then

SMODS.ConsumableType {
	key = 'ascendedtarots',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.PURPLE,
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

end


-- Booster packs

	-- Group key stuff
	function SMODS.current_mod.process_loc_text()
	G.localization.misc.dictionary['k_may_editioncard_pack'] = "Edition Card Pack"
		--[[if conf.Debug then
		G.localization.descriptions.Mod[may] = "Big number.\n {C:dark_edition,s:2}DEBUG MODE{}\n{s:0.2}Debug enables a few random keybinds for testing stuff"
		end ]]
	end

SMODS.Booster {
	key = "b_editioncard1",
	kind = 'editioncard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 3, choose = 1 },
	cost = 3,
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
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_editioncard_pack",
}

	-- Buff spectral packs so the mod isnt grindy nonsense
	
SMODS.Booster:take_ownership('p_spectral_normal_1', {
	weight = 1,
	config = {extra = 3, choose = 1}
}, true)

SMODS.Booster:take_ownership('p_spectral_normal_2', {
	weight = 1,
	config = {extra = 3, choose = 1}
}, true)

SMODS.Booster:take_ownership('p_spectral_jumbo_1', {
	weight = .6,
	config = {extra = 5, choose = 1}
}, true)

SMODS.Booster:take_ownership('p_spectral_mega_1', {
	weight = .4,
	config = {extra = 6, choose = 2}
}, true)

-- Consumables

	-- Acsended Consumables
		
		-- Tarots
if wipmode then

SMODS.Consumable {
	key = 'asc_hermit',
	set = 'ascendedtarots',
	loc_txt = {
		name = "Ascended Hermit",
		text = {
			"{X:money,C:white}^^1.2${}",
		}
	},
	pos = { x = 7, y = 0 },
	atlas = 'consumable',
	cost = 1000,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.005,
	soul_set = 'Tarot',
	use = function(self, card, area, copier)
		hypermoney(2, 1.2)
	end,
	set_sprites = function(self, card, front)
		if not card.added_to_deck then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = .2, func = function()
				play_sound('may_ascended')
				card:juice_up(.3, .4)
			return true end}))
		end
	end
}

	-- Planets
	
SMODS.Consumable {
	set = 'ascendedplanets',
	key = 'asc_pluto',
	config = { mphand = 2, other = -1 },
	pos = {x = 0, y = 1 },
	atlas = 'consumable',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ascended Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
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
	set_sprites = function(self, card, front)
		if not card.added_to_deck then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				play_sound('may_ascended')
				card:juice_up(.3, .4)
			return true end}))
		end
	end
}
	
	-- Spectrals
	
SMODS.Consumable {
	key = 'asc_familiar',
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
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
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
	set_sprites = function(self, card, front)
		if not card.added_to_deck then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				play_sound('may_ascended')
				card:juice_up(.3, .4)
			return true end}))
		end
	end
}

end

	-- Yotta Cards
	
if not yotta_chance then
	yotta_chance = 1
end
	
SMODS.Consumable {
	key = 'cupiditas',
	set = 'yottacards',
	loc_txt = {
		name = "Cupiditas",
		text = {
			"{X:money,C:white}^3${}",
		}
	},
	config = { amount = 3 },
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
	soul_rate = 0.01 * (yotta_chance or 1),
	use = function(self, card, area, copier)
		hypermoney(1, 3)
	end,
	bulk_use = function(self, card, area, copier, number)
		hypermoney(1, 3*number)
	end,
	set_sprites = function(self, card, front)
		if not card.added_to_deck then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				play_sound('may_enchant')
				card:juice_up(.3, .4)
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'planetae',
	set = 'yottacards',
	loc_txt = {
		name = "Planetae",
		text = {
			"{C:attention}All{} Poker Hands gain",
			"{X:purple,C:white}^^3{} Mult & Chips"
		}
	},
	config = { amount = 3 },
	pos = { x = 2, y = 0 },
	soul_pos = { x = 0, y = 1 },
	atlas = 'yotta',
	cost = 500,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.01 * (yotta_chance or 1),
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
		return true end}))
		jl.hcm(nil, '^^'..self.config.amount..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
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
		return true end}))
		jl.hcm(nil, '^^'..self.config.amount*number..'', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_eechip')
			card:juice_up(1, 1)
		return true end}))
		jl.hcm('^^'..self.config.amount*number..'', nil, true)
		jl.ch()
		delay(0.5)
	end,
	set_sprites = function(self, card, front)
		if not card.added_to_deck then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				play_sound('may_enchant')
				card:juice_up(.3, .4)
			return true end}))
		end
	end
}


	-- Tarots
	
	
	
	-- Spectrals

SMODS.Consumable {
	key = 'genesis',
	set = 'Spectral',
	loc_txt = {
		name = "Genesis",
		text = {
			"Creates an {C:attention}Universal Collapse{} joker.",
			"{C:mult,s:2}x2 Ante{}"
		}
	},
	config = { xante = 2 },
	pos = { x = 3, y = 0 },
	atlas = 'consumable',
	cost = 17,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.1,
	use = function(self, card, area, copier)
		local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
		G.jokers:emplace(card2)
		play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		card2:add_to_deck()
		ease_ante(G.GAME.round_resets.ante)
	end
}

SMODS.Consumable {
	key = 'macrocosm',
	set = 'Spectral',
	loc_txt = {
		name = "Macrocosm",
		text = {
			"Creates a random {X:dark_edition,s:2}Transcendent{} Joker",
			"{C:mult}-2 hands{} played"
		}
	},
	pos = { x = 4, y = 0 },
	atlas = 'consumable',
	cost = 10,
	unlocked = true,
	can_use = function(self, card)
		return jl.canuse() and G.GAME.round_resets.hands > 2
	end,
	discovered = true,
	hidden = true,
	soul_rate = 0.07,
	use = function(self, card, area, copier)
		local card2 = create_card('Joker', G.jokers, nil, 'may_transcendent', nil, nil, nil, 'may_shortcut')
		G.jokers:emplace(card2)
		play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		card2:add_to_deck()
		card2:juice_up(1,1)
		 G.GAME.round_resets.hands =  G.GAME.round_resets.hands - 2
		delay(0.6)
	end
}

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
	config = { mphand = 2, other = -1 },
	pos = {x = 1, y = 0 },
	atlas = 'planets',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Tartarus',
		text = {
			"{C:planet}Levels up{} most played hand {C:attention}2{} times,",
			"{C:mult}decreases level{} of another {C:attention}2 random{} hands by {C:attention}1{}",
			"{C:inactive}Will level up #1#{}"
		}
	},
	can_use = function(self, card)
		return jl.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { jl.favhand() } }
	end,
	use = function(self, card)
		local hand = jl.favhand()
		jl.th(hand)
		level_up_hand(card, hand, nil, 2)
		delay(0.5)
		for i=1, 2, 1 do
			local hand2 = jl.rndhand(hand)
			jl.th(hand2)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, -1)
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
		level_up_hand(card, hand, nil, 2*number)
		delay(0.5)
		for i=1, number*2, 1 do
			local hand2 = jl.rndhand(hand)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, -1)
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
		jl.h(nil, nil, nil, '-1')
		delay(1.3)
		jl.ch()
	end
}

	-- Rare Planets
	
if wipmode then
	SMODS.Consumable {
		set = 'Planet',
		key = 'wasp-15b',
		config = { mphand = 10 },
		pos = {x = 1, y = 1 },
		atlas = 'consumable',
		play_sound = 'may_rare_planet',
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
			badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
		end,
		hidden = true,
		soul_rate = .07,
		soul_set = 'Planet',
		loc_txt = {
			name = 'WASP-15b',
			text = {
				"{C:planet}Levels up{} most played hand {C:attention}10{} times",
				"{C:inactive}Will level up #1#{}"
			}
		},
		can_use = function(self, card)
			return jl.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			return { vars = { jl.favhand() } }
		end,
		use = function(self, card)
			local hand = jl.favhand()
			jl.th(hand)
			level_up_hand(card, hand, nil, 10)
			delay(0.5)
			jl.ch()
		end,
		bulk_use = function(self, card, area, copier, number)
			local hand = jl.favhand()
			jl.th(hand)
			level_up_hand(card, hand, nil, 10*number)
			delay(0.5)
			jl.ch()
		end,
		set_sprites = function(self, card, front)
			if not card.added_to_deck then
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
					play_sound('may_rare_planet', nil, 0.6)
					card:juice_up(.3, .4)
				return true end}))
			end
		end
	}
end

	--[[SMODS.Consumable {
	key = 'quasar',
	config = { hand_types = { "Five of a Kind", "Flush Five", "Flush House" } }},
	loc_txt = {
		name = 'Quasar',
		text = {
			'{C:planet}Levels up{} all {C:purple}secret hands{} {C:attention}2 times{}',
			'{C:inactive}Five of a Kind, Flush House etc.{}'
		}
	},
	set = 'Planet',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
		can_use = function(self, card)
		return jl.canuse()
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
					return true end }))	
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							play_sound('chips'..math.random(1,2)..'')
							card:juice_up(1, 1)
						return true end }))				
					jl.hcm('+'..card.ability.extra.chips..'', nil, true)
					jl.ch()
					delay(0.5)
	end
    }
	]]
	-- Edition Cards
	
SMODS.Consumable {
	key = 'foil_card',
	config = { extra = { chips = 50 } },
	loc_txt = {
		name = 'Foil Card',
		text = {
			'Gives all hands {C:chips}+50 Chips{}',
		}
	},
	set = 'editioncards',
	pos = { x = 2, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	rarity = 'Common',
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
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
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2)..'')
			card:juice_up(1, 1)
		return true end }))				
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
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1,2)..'')
			card:juice_up(1, 1)
		return true end }))				
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
			'Gives all hands {C:mult}+10 Mult{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	rarity = 'Common',
	atlas = 'editioncard',
		can_use = function(self, card)
		return jl.canuse()
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
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
		play_sound('multhit1')
		card:juice_up(1, 1)
		return true end }))				
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
			'Gives all hands {C:mult}x1.5 Mult{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 1 },
	cost = 6,
	unlocked = true,
	discovered = true,
	rarity = 'Common',
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
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit2')
		card:juice_up(1, 1)
		return true end }))				
		jl.hcm(nil, 'x'..card.ability.extra.xmult*number..'', true)
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

-- Vouchers

SMODS.Voucher {
	key = 'food_chain',
	loc_txt = {
		name = "Food Chain",
		text = {
			"{C:mult}Rare{} jokers are {C:attention}2x{} more commmon"
		}
	},
	atlas = "may_voucher",
	pos = { x = 0, y = 0},
	config = { extra = { mod = 2 } },
	cost = 10,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod * card.ability.extra.mod
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod / card.ability.extra.mod
	end
}

SMODS.Voucher {
	key = 'natural_selection',
	loc_txt = {
		name = "Natural Selection",
		text = {
			"{C:mult}Rare{} jokers are {C:attention}4x{} more commmon",
			"{C:green}Uncommon{} jokers are {C:attention}2x{} more common"
		}
	},
	atlas = "may_voucher",
	pos = { x = 1, y = 0},
	config = { extra = { rmod = 4, umod = 2 } },
	requires = { 'v_may_food_chain' },
	cost = 10,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod * card.ability.extra.rmod
		G.GAME.uncommon_mod = G.GAME.uncommon_mod * card.ability.extra.umod
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod / card.ability.extra.rmod
		G.GAME.uncommon_mod = G.GAME.uncommon_mod / card.ability.extra.umod
	end
}

-- Blinds

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
	atlas = "temp_ceasvoid",
	ultra = true,
	pos = {x = 0, y = 0},
	dollars = 20,
	mult = 4,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end,
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
	atlas = "blind_chips",
	ultra = true,
	pos = {x = 0, y = 2},
	dollars = 20,
	mult = 4,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end,
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
	atlas = "blind_chips",
	ultra = true,
	pos = {x = 0, y = 2},
	dollars = 20,
	mult = 1,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end,
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
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 4) * get_mphand_level()
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 4
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
	atlas = "blind_chips",
	ultra = true,
	pos = {x = 0, y = 1},
	dollars = 20,
	mult = 64,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
	end
}



-- Jokers

	-- Common
	
SMODS.Joker {
  key = 'hierarchy',
  loc_txt = {
    name = 'Hierarchy',
    text = {
      "Gains {C:chips}+#1#{} Chips when a playing card",
	  "with any {C:attention}Enhancement, Edition or Seal{} is scored",
	  "{C:inactive}Currently {C:chips}+#2#{} Chips{}"
    }
  },
  config = { extra = { chips_gain = 5, chips = 0 } },
  rarity = 1,
  atlas = 'Placeholder',
  pos = { x = 0, y = 0 },
  cost = 3,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
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
	config = { extra = { Xmult = 10, rounds = 3} },
	rarity = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.rounds} }
	end,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
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
		if context.setting_blind then
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
			end
		return {
			message = card.ability.extra.rounds.." rounds left",
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
	atlas = 'Jokers1',
	pos = { x = 1, y = 1 },
	cost = 4,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if pseudorandom('may_dead_pixel') < G.GAME.probabilities.normal / card.ability.extra.odds then	
				return {
					Xmult_mod = card.ability.extra.Xmult,
				}
			else
				return {
					mult_mod = card.ability.extra.mult
				}
			end
		end
	end
}

	-- UnCommon

SMODS.Joker {
	key = 'AAAA',
	loc_txt = {
		name = 'AAAA',
		text = {
			"Retrigger all",
			"played {C:attention}Aces{} #1# times"
		}
	},
	config = { extra = { repetitions = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions} }
	end,
	rarity = 2,
	atlas = 'Jokers1',
	pos = { x = 1, y = 0 },
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
	key = 'trickshot',
	loc_txt = {
	name = 'Trickshot',
	text = {
		"{X:attention,C:white}x#1#{} Blind Size",
		"{C:money}+#2#${} at the end of round"
		}
	},
	config = { extra = { size = 1.3, dollars = 10 } },
	rarity = 2,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.size, card.ability.extra.dollars } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.size
			jl.a("x"..card.ability.extra.size.."Blind Size", 1, 1, G.C.FILTER, 'highlight2', 0.685, 0.2)
			play_sound('generic1')
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.size
		jl.a("/"..card.ability.extra.size.."Blind Size", 1, 1, G.C.FILTER, 'highlight2', 0.685, 0.2)
		play_sound('generic1')
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
			"After hand is played,",
			"{C:mult}destroy{} a {C:attention}random card{}",
			"held in hand and gain {X:mult,C:white}x#1#{} Mult",
			"{C:inactive}Currently {X:mult,C:white}x#2#{} Mult"
		}
	},
	config = { extra = { Xmult_gain = .1, Xmult = 1 } },
	rarity = 2,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.jokers and #G.hand.cards > 0 then
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
				Xmult_mod = card.ability.extra.Xmult,
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
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
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
	key = 'gemstone',
	loc_txt = {
    name = 'Gemstone',
    text = {
		"{C:attention}Glass Cards{} also give {X:chips,C:white}x#1#{} Chips",
		"but {C:attention}always break{}"
		}
	},
	config = { extra = { Xchips = 2 } },
	rarity = 3,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
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
	atlas = 'Jokers1',
	pos = { x = 0, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main and card.edition then
			return {
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
		"{X:mult,C:white}^#1#{} Mult if",
		"{C:attention}this joker{} has an {C:dark_edition}Edition{}"
		}
	},
	config = { extra = { Emult = 2 } },
	rarity = 3,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	atlas = 'Jokers1',
	pos = { x = 0, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main and card.edition then
			return {
				Emult_mod = card.ability.extra.Emult,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.RED,
				card = card
			}
		end
	end
}

end

SMODS.Joker {
	key = 'mana_orb',
	loc_txt = {
    name = 'Mana Orb',
    text = {
		"Before scoring,",
		"add a random {C:dark_edition}Edition{} to",
		"the {C:attention}first{} card in hand"
		}
	},
	rarity = 3,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 6,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and context.other_card and context.other_card == context.scoring_hand[1] then
			return {
				card = context.other_card,
				card:set_edition(poll_edition('mana_orb', nil, true, true), true, true),
				message = "Edition!",
				colour = G.C.DARK_EDITION
			}
		end
	end
}

SMODS.Joker {
	key = 'collectionist',
	loc_txt = {
    name = 'Collectionist',
    text = {
		"{C:attention}Jokers{} with an {C:dark_edition}Edition{}",
		"give {X:chips,C:white}x#1#{} Chips"
		}
	},
	rarity = 3,
	atlas = 'Jokers1',
	pos = { x = 0, y = 1 },
	cost = 6,
	config = { extra = { Xchips = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips} }
	end,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.edition and card ~= context.other_joker then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "x"..card.ability.extra.Xchips.." Chips",
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
		"#3# {C:purple}Wheel of Fortune{} cards",
		"when {C:attention}a playing card{} is triggered",
		"{C:inactive}(Requires room){}",
		"{C:inactive,s:0.5} idea by _TeKKen_ {}"
		}
	},
	rarity = 3,
	atlas = 'Jokers1',
	pos = { x = 5, y = 1 },
	cost = 8,
	config = { extra = { odds = 4, cards = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if G.consumeables.config.card_limit - #G.consumeables.cards > 0 then
			if context.individual and context.cardarea == G.play and context.other_card then
				G.E_MANAGER:add_event(Event({ func = function()
						card:juice_up(0.5, 0.5)
						for i=1, math.min(math.ceil(card.ability.extra.cards), G.consumeables.config.card_limit - #G.consumeables.cards) do
							local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
							G.consumeables:emplace(wheel)
							wheel:add_to_deck()
							-- wheel:set_cost()
						end
				return true end }))
			end
		end
	end
}

SMODS.Joker {
	key = 'man',
	loc_txt = {
		name = 'man',
		text = {
			"When Blind is selected,",
			"create #1# {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} cards",
			"{C:inactive,s:0.5} idea by _TeKKeN_ {}"
		}
	},
	config = { extra = { cards = 3 } },
	rarity = 3,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				for i=1, card.ability.extra.cards, 1 do
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				end
			return true end}))
		end
	end
}
	
SMODS.Joker {
	key = 'nebula',
	loc_txt = {
		name = 'Nebula',
		text = {
			"When hand is played, before scoring,",
			"gains the {C:planet}level{} of played Poker Hand",
			"as {C:mult}+Mult{}",
			"{C:inactive}Currently {C:mult}+#1#{} Mult{}",
		}
	},
	config = { extra = { mult = 0 } },
	pos = { x = 0, y = 0 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].level 
		end
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				card = card,			
			}
		end
	end
}

SMODS.Joker {
	key = 'destroyer',
	loc_txt = {
		name = 'Destroyer',
		text = {
			"This joker gains {C:chips}+#1#{} Chips",
			"when a {C:planet}planet{} card is sold",
			"{C:inactive}Currently {C:chips}+#2#{} Chips{}"
		}
	},
	config = { extra = { chips_gain = 3, chips = 0 } },
	pos = { x = 2, y = 1 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Jokers1',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips_gain, card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				message = 'Upgraded!'
				colour = G.C.CHIPS
			return true end }))
		end
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				chip_mod = card.ability.extra.chips,
				card = card,			
			}
		end
	end
}

SMODS.Joker {
	key = 'baron',
	loc_txt = {
		name = 'Baron',
		text = {
			"This joker gains {X:mult,C:white}X#1#{} Mult",
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Currently {X:mult,C:white}X#2#{} Mult{}"
		}
	},
	config = { extra = { Xmult_gain = 0.5, Xmult = 1 } },
	pos = { x = 0, y = 0 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
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

SMODS.Joker {
	key = 'daredevil',
	loc_txt = {
		name = 'Daredevil',
		text = {
			"If blind was {C:attention}beaten{} in {C:attention}1{} hand,",
			"this joker gains {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}Currently {X:mult,C:white}X#2#{} Mult{}",
		}
	},
	config = { extra = { Xmult_gain = 1, Xmult = 1 } },
	pos = { x = 0, y = 0 },
	cost = 7,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
		local starting_hands = G.GAME.current_round.hands_left
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,	
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and G.GAME.current_round.hands_left == starting_hands - 1 then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

SMODS.Joker {
	key = 'the_multiverse',
	loc_txt = {
	name = 'The Multiverse',
	text = {
		"Allows you to have multiple", 
		"{C:purple}Ethereal{} Jokers",
		}
	},
	rarity = 3,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 8,
}
	
	-- Legendary
	
SMODS.Joker {
	key = 'blue_album',
	loc_txt = {
    name = 'Blue Album',
    text = {
		"This joker gains {X:mult,C:white}^#1#{} Mult", 
		"if hand is played while {C:attention}joker slots{}",
		"are {C:mult}not fully occupied{}",
		"{C:inactive}Currently {X:mult,C:white}^#2#{} Mult",
		"{C:inactive,s:0.5} original concept by hellory4n {}"
		}
	},
	config = { extra = { Emult_gain = 0.1, Emult = 1, jokers = getjokers() } },
	rarity = 4,
	atlas = 'Jokers1',
	pos = { x = 4, y = 0 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult } }
   end,
   add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_weezer")
		end
	end,
	calculate = function(self, card, context)
		if context.before then
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
				return true end }))				
				}
		end
	end
}

SMODS.Joker {
	key = 'hurley',
	loc_txt = {
		name = 'Hurley',
		text = {
			"Scoring {C:attention}10s{} have a",
			"{C:green}#2# in #3#{} chance to give {C:money}#1#${}",
			"{C:inactive,s:0.5} concept by therealten95 {}"
    }
  },
	config = { extra = { dollars = 100, odds = 10 } },
	rarity = 4,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 and pseudorandom('may_hurley') < G.GAME.probabilities.normal / card.ability.extra.odds then	
				return {
					card = context.other_card,
					dollars = 100,
				}
			end
		end
	end
}
	
SMODS.Joker {
	key = 'kids_drawing',
	loc_txt = {
		name = "Kid's Drawing",
		text = {
			"This joker creates {C:attention}#1#{} random {C:attention}consumables{}",
			"after hand is played"
		}
	},
	config = { extra = { consumables = 2 } },
	rarity = 4,
	atlas = 'Jokers1',
	pos = { x = 1, y = 2 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.consumables } }
	end,
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.play or context.blueprint then
			for i = 1,card.ability.extra.consumables, 1 do
				local forced_key = get_random_consumable("kids_drawing")
				local _card = create_card("Consumeables", G.consumables, nil, nil, nil, nil, forced_key.config.center_key, "kids_drawing")
				_card:add_to_deck()
				G.consumeables:emplace(_card)
				card:juice_up()
			end		
		end
	end
}
		
SMODS.Joker {
	key = '3d_joker',
	loc_txt = {
		name = '3D Joker',
		text = {
			"Played 3s give {X:mult,C:white}^#1#{} Mult",
		}
	},
	config = { extra = { Emult = 1.13 } },
	rarity = 4,
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
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
					return true end }))	
				}
			end
		end
	end
}

	-- Mythic
	
SMODS.Joker {
	key = 'universal_collapse',
	loc_txt = {
		name = 'Universal Collapse',
		text = {
			"Gains {X:mult,C:white}^#1#{} Mult when a joker is sold",
			"{C:inactive}Currently {X:mult,C:white}^#2#{} Mult{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult } }
	end,
	config = { extra = { Emult_gain = 0.1, Emult = 1 } },
	rarity = 'may_mythic',
	atlas = 'Jokers1',
	pos = { x = 3, y = 3 },
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
		if context.selling_card and context.card.ability.set == "Joker" and not context.card == self then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
				return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}


SMODS.Joker {
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
}

SMODS.Joker {
	key = 'diskus',
	loc_txt = {
    name = 'Diskus',
    text = {
		"When Blind is selected,",
		"create 1 {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} {C:attention}card{}.",
		"{C:attention}Jokers{} with any {C:dark_edition}Edition{} give {X:mult,C:white}^#1#{} Mult",
		"When {C:attention}a playing card{} is triggered, create {C:attentnion}#2#{} {C:dark_edition}Negative{} {C:purple}Wheel of Fortune{} card(s).",
		}
	},
	rarity = 'may_mythic',
	atlas = 'Jokers1',
	pos = { x = 3, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 100,
	config = { extra = { Emult = 1.5, cards = 1, } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
					for i=1, card.ability.extra.cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:setQty(1)
						wheel:set_edition({negative = true}, false, false)
					end
			return true end }))
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				for i=1, 5, 1 do
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
					wheel:setQty(1)
				end
			return true end }))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.MULT
			}
		end
	end
}

	-- Transcendent

SMODS.Joker {
	key = 'little_prince',
	loc_txt = {
		name = 'Little Prince',
		text = {
			"This joker gains {X:mult,C:white}^^#2#{} Mult{}", 
			"if played hand is a Royal Flush",
			"{C:inactive}Curerntly {X:mult,C:white}^^#1#{} Mult{}"
		}
	},
	config = { extra = { EEmult = 1, EEmult_gain = 0.1 } },
	rarity = 'may_transcendent',
	atlas = 'Jokers1',
	pos = { x = 2, y = 2 },
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

if conf.Mode == 1 then

SMODS.Joker {
	key = 'party_time',
	loc_txt = {
	name = 'Party Time',
	text = {
		"When this joker is triggered,", 
		"gain Transcendence level as {X:mult,C:white}^Mult{}",
		"{C:inactive} Curerntly {X:mult,C:white}^#1#{} Mult{}",
		}
	},
	config = { extra = { Emult = 2, trans = 0 } },
	rarity = 'may_transcendent',
	atlas = 'Jokers1',
	pos = { x = 0, y = 3 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.Emult = card.ability.extra.Emult + (G.ARGS.score_intensity.transcendence or 0)
			return {
				Emult_mod = card.ability.extra.Emult,
				message = "^"..card.ability.extra.Emult.." Mult",
				card = card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(1, 1)
				return true end }))				
			}
		end
	end
}

else

SMODS.Joker {
	key = 'party_time',
	loc_txt = {
	name = 'Party Time',
	text = {
		"{X:mult,C:white}#1##2##3##4#{} Mult",
		"When this joker is triggered,", 
		"if {C:dark_edition}Transcendence{} level is {C:attention}#5#{}",
		"increase {C:attention}arrow count{} and required {C:dark_edition}Transcendence{} level by {C:attention}1{}",
		"{C:inactive}Max Transcendence level of 9, max arrow count of 10{}"
		}
	},
	config = { extra = { arrow = 1, mult = 2, trlevel = 1 } },
	rarity = 'may_transcendent',
	atlas = 'Jokers1',
	pos = { x = 0, y = 3 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { "{", card.ability.extra.arrow, "}", card.ability.extra.mult, card.ability.extra.trlevel } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if (may.transcendence > card.ability.extra.trlevel-1) and card.ability.extra.trlevel < 10 then
				card.ability.extra.arrow = card.ability.extra.arrow + 1
				card.ability.extra.trlevel = card.ability.extra.trlevel + 1
			end
			return {
				hyper_mult = {card.ability.extra.arrow, card.ability.extra.mult},
				message = "{"..card.ability.extra.arrow.."}"..card.ability.extra.mult.." Mult",
				card = card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(1, 1 + (card.ability.extra.arrow/4))
				return true end }))	
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
			"Scoring {C:attention}10s{} give {X:money,C:white}x2${}",
			"{C:inactive,s:0.5} concept by therealten95 {}"
		}
	},
	rarity = 'may_transcendent',
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 1000,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then	
				return {
					message = 'x2$',
					colour = G.C.MONEY,
					card = context.other_card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						multmoney(2)
					return true end }))	
				}
			end
		end
	end
}

--[[SMODS.Joker {
  key = 'xfactor',
  loc_txt = {
    name = 'X-Factor',
    text = {
      "Gives the {C:dark_edition}factorial{} of", 
	  "{C:purple}played hand level{} as {C:mult}Xmult{}"
    }
  },
  rarity = 'may_transcendent',
  atlas = 'Jokers1',
  pos = { x = 2, y = 3 },
  cost = 1000,
  calculate = function(self, card, context)
 if context.joker_main and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
      return {
        Xmult_mod = to_big(fact(G.GAME.hands[context.scoring_name].level)),
        message = "X".. fact(G.GAME.hands[context.scoring_name].level).." Mult",
		card = card,
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			card:juice_up(3, 3)
			play_sound('may_factmult')
		return true end }))				
      }
    end
  end
}]]

SMODS.Joker {
	key = 'acum',
	loc_txt = {
		name = 'Acum',
		text = {
		"When hand is played, create a {C:dark_edition}Negative{}",
		"{C:attention}Grim{} card.",
		"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
		"And give {X:mult,C:white}^#2#{} Mult"
		}
	},
	config = { extra = { repetitions = 4, e_mult = 11 } },
	rarity = "may_transcendent",
	atlas = 'Jokers1',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
  		info_queue[#info_queue + 1] = {
			set = "Spectral",
			key = "c_grim",
		}
		return { vars = { card.ability.extra.repetitions, card.ability.extra.e_mult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition or context.blueprint and not context.repetition_only then
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
		if context.after or context.blueprint then
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
		if context.individual and context.cardarea == G.play then
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
			"This joker gains {X:chips,C:white}^^#1#{} Chips",
			"When a {C:planet}planet{} card is sold",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}"
		}
	},
	config = { extra = {EEchip_gain = 0.01, EEchip = 1} },
	pos = { x = 2, y = 3 },
	cost = 1000,
	rarity = 'may_transcendent',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Jokers1',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEchip_gain, card.ability.extra.EEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" then
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

else

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = 'Storm',
		text = {
			"This joker gains {X:chips,C:white}^^#1#{} Chips",
			"When a {C:planet}planet{} card is sold",
			"{C:inactive}Currently {X:chips,C:white}^^#2#{} Chips{}"
		}
	},
	config = { extra = {EEchip_gain = 0.1, EEchip = 1} },
	pos = { x = 2, y = 3 },
	cost = 1000,
	rarity = 'may_transcendent',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Jokers1',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEchip_gain, card.ability.extra.EEchip}}
    end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Planet" then
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
	atlas = 'Jokers1',
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
		"When hand is played, before scoring,",
		"gains half of the {C:planet}level{} of played Poker Hand",
		"as {X:mult,C:white}^Mult{}",
		"{C:inactive}Currently {X:mult,C:white}^#1#{} Mult{}",
		}
	},
	config = { extra = { Emult = 1 } },
	pos = { x = 0, y = 0 },
	cost = 1000,
	rarity = 'may_transcendent',
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Emult}}
    end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.Emult = card.ability.extra.Emult + (G.GAME.hands[context.scoring_name].level / 2)
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

	-- Interdimensional

SMODS.Joker {
	key = 'santa',
	loc_txt = {
		name = "Santa",
		text = {
			"This joker creates a random {C:dark_edition}Negative Legendary{} Joker",
			"if played hand is a {C:attention}Pair{}",
			"{X:mult,C:white}^^#2#{} Mult"
    }
  },
	config = { extra = { consumables = 8, EEmult = 8 } },
	rarity = 'may_interdimensional',
	atlas = 'Jokers1',
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 3 },
	cost = 20,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_st_bells")
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.consumables, card.ability.extra.EEmult } }
	end,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Pair']) or context.blueprint then
			play_sound("holo1")
			local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "may_santa")
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
				EEmult_mod = card.ability.extra.EEmult,
				message = '^^'.. card.ability.extra.EEmult .. ' Mult',
				colour = G.C.MULT,
			}
		end
	end
}
	
SMODS.Joker {
	key = 'acum_universum',
	loc_txt = {
		name = 'ACVM VNIVERSVM',
		text = {
			"{C:attention}All{} scoring cards are turned into {C:attention}Aces{}",
			"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
			"And give {X:mult,C:white}^^#2#{} Mult"
		}
	},
	config = { extra = { repetitions = 11, ee_mult = 11 } },
	rarity = "may_interdimensional",
	atlas = 'Jokers1',
	pos = { x = 4, y = 3 },
	soul_pos = { x = 5, y = 0 },
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
		if context.before then
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
		"When hand is played, before scoring,",
		"gains the {C:planet}level{} of played Poker Hand",
		"as {X:mult,C:white}^^Mult{}",
		"{C:inactive}Currently {X:mult,C:white}^^#1#{} Mult{}",
		}
	},
	config = { extra = { EEmult = 1 } },
	pos = { x = 0, y = 0 },
	cost = 6,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEmult}}
    end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.EEmult = card.ability.extra.EEmult + G.GAME.hands[context.scoring_name].level
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
		"When blind is selected,",
		"Turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
		"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
		"And give {X:mult,C:white}^^^#2#{} Mult"
		}
	},
	config = { extra = { repetitions = 22, eee_mult = 11 } },
	rarity = "may_ethereal",
	atlas = 'Jokers1',
	pos = { x = 3, y = 2 },
	soul_pos = { x = 4, y = 2 },
	cost = 10000,
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
		if context.setting_blind then
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
		"When hand is played, before scoring,",
		"gains half the {C:planet}level{} of played Poker Hand",
		"as {X:mult,C:white}^^^Mult{}",
		"{C:inactive}Currently {X:mult,C:white}^^^#1#{} Mult{}",
		"{C:inactive,s:0.5} original concept by pyleup {}"
		}
	},
	config = { extra = { EEEmult = 1 } },
	pos = { x = 0, y = 0 },
	cost = 10000,
	rarity = 'may_ethereal',
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEEmult}}
    end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.EEEmult = card.ability.extra.EEEmult + (G.GAME.hands[context.scoring_name].level / 2)
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

if wipmode then

SMODS.Joker {
	key = 'diskus_distruktum',
	loc_txt = {
		name = 'Diskus Distruktum',
		text = {
		"When blind is {C:attention}selected{}, create {C:attention}#1#{} {C:dark_edition}negative{} {C:purple}Wheel of Fortunes{}",
		"Amount increases by {C:attention}#2#{} when a {C:purple}Wheel of Fortune{} is used",
		"Jokers with an {C:dark_edition}edition{} give {X:purple,C:white}^^^#3#{} Mult & Chips",
		}
	},
	config = { extra = { blindamount = 10, scale = 1, EEEmultchips = 14 } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_ethereal',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
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
				colour = G.C.PURPLE
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(1, 1)
				local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				G.consumeables:emplace(wheel)
				wheel:add_to_deck()
				wheel:set_edition({negative = true}, false, false)
				wheel.ability.qty = card.ability.extra.blindamount
			return true end}))
		end
		if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' then
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
		"Played {C:attention}Aces{} give {X:purple,C:white}#2##1#‎Mult‎&‎Chips{}",
		"Number of arrows is set to {C:planet}level{} of played Poker Hand before scoring",
		"{C:inactive}Max arrow limit of ".. maxArrow-1 .."{}",
		"All {C:attention}Aces{} are retriggered a number of times equal to played Poker Hand {C:planet}level{}",
		"{C:inactive}Max retrigger limit of 500{}",
		"When Blind is selected, turn {C:attention}all{} cards in deck into {C:attention}Aces{}"
		}
	},
	config = { extra = { amount = 11 } },
	rarity = "may_hyperascendant",
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	cost = 11e11,
	config = { extra = { amount = 11 } },
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount, "{...}"}}
    end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			local b = 0
			if G.GAME.hands[context.scoring_name].level >= to_big(500) then
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
				if G.GAME.hands[context.scoring_name].level >= to_big(maxArrow) then
					a = maxArrow - 1
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
		if context.setting_blind then
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

else

SMODS.Joker {
	key = 'spadus',
	loc_txt = {
		name = 'Spadus',
		text = {
		"Played {C:attention}Aces{} give {X:purple,C:white}#2##1#‎Mult‎&‎Chips{}",
		"Number of arrows is set to {C:planet}level{} of played Poker Hand before scoring",
		"{C:inactive}Max arrow limit of ".. maxArrow-1 .."{}",
		"All {C:attention}Aces{} are retriggered a number of times equal to played Poker Hand {C:planet}level{}",
		"When Blind is selected, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
		},
	},
	config = { extra = { amount = 11 } },
	rarity = "may_hyperascendant",
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
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
				if G.GAME.hands[context.scoring_name].level >= to_big(maxArrow) then
					a = maxArrow - 1
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
		if context.setting_blind then
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

-- Decks

SMODS.Back {
	name = "AAAA deck",
	key = "AAAA deck",
	atlas = 'Jokers1',
	pos = { x = 1, y = 0 },
	config = {only_one_rank = 'Ace'},
	loc_txt = {
		name = "AAAA Deck",
		text = {
			"Start run with {C:attention}AAAA{}",
			"And a deck full of {C:attention}Aces{}",
			"Retrigger all played Aces {C:attention}4{} times"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
                for _, card in ipairs(G.playing_cards) do
					assert(SMODS.change_base(card, nil, self.config.only_one_rank))
				end
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
            local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_AAAA', 'may_AAAA deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
				return true
			end
		}))
	end
}

SMODS.Back {
	name = "Unstable Deck",
	key = "unstable_deck",
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "Unstable Deck",
		text = {
			"Start run with {C:dark_edition}Universal Collapse{}",
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
            local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_unstable_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound("may_thunder"..math.random(1,2))
		return true end}))
	end
}

SMODS.Back {
	name = "Ethereal deck",
	key = "etherealdeck",
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	config = {hands = 1, discards = 0, ante = 8, jslots = 1},
	loc_txt = {
		name = "Ethereal Deck",
		text = {
			"Start run with a random",
			"{X:dark_edition, C:purple}Ethereal{} {C:attention}Joker{},",
			"{C:chips}1 hand{}, {C:mult}0 discards{} and {C:attention}1 joker slot{}",
			"Start at {C:attention}Ante 8{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_etherealdeck")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
							G.jokers.config.card_limit = self.config.jslots
							play_sound('may_ethereal_joker')
							return true
						end
					end
				}))
	G.GAME.starting_params.discards = self.config.discards
	G.GAME.starting_params.hands = self.config.hands - 1
	ease_ante(self.config.ante - 1)
	end
}

SMODS.Back {
	name = "Transcendent deck",
	key = "transcendentdeck",
	atlas = 'Placeholder',
	pos = { x = 0, y = 0 },
	config = {hand = 1, discard = 1},
	loc_txt = {
		name = "Transcendent Deck",
		text = {
			"Start run with a random",
			"{C:dark_edition}Transcendent{} {C:attention}Joker{},",
			"{C:chips}-1 hand{} and {C:mult}discard{}"
		},
    },
	apply = function(self)
		G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							local card =
							create_card("Joker", G.jokers, nil, "may_transcendent", nil, nil, nil, "may_legendarydeck")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
							return true
						end
					end,
				}))
	G.GAME.starting_params.discards = 2
	G.GAME.starting_params.hands = 3
	end
}


-- Cryptid CM content
if SMODS.find_card('j_cry_dropshot') then

-- Cryptid Fusions


-- Cryptid Consumables

	-- Cryptid edition cards
	
SMODS.Consumable {
	key = 'astralcard',
	config = { extra = { emult = 1.1 } },
	loc_txt = {
		name = 'Astral Card',
		text = {
			'All hands gain {C:mult}^1.1 Mult{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	rarity = 'Rare',
	atlas = 'consumable',
	can_use = function(self, card)
		return jl.canuse()
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
			'All hands gain {C:chips}x2.5 Chips{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 7,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
	can_use = function(self, card)
		return jl.canuse()
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
		mult = 0,
		chips = 0
	},
	max = {
		mult = 30,
		chips = 150
	}
}

SMODS.Consumable {
	key = 'noisycard',
	config = { extra = { min_mult = noisy_stats.min.mult, max_mult = noisy_stats.max.mult, min_chips = noisy_stats.min.chips, max_chips = noisy_stats.max.chips } },
	loc_txt = {
		name = 'Noisy Card',
		text = {
			'All hands gain {C:purple}+??? Mult & Chips{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
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
				{ chips = may_obfuscatedtext(3) }
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
				{ mult = may_obfuscatedtext(3) }
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
				{ chips = may_obfuscatedtext(3) }
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
				{ mult = may_obfuscatedtext(3) }
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
			'All hands gain {C:attention}anywhere between x0.1 and x10{}',
			'{C:purple}Mult & Chips{} {C:inactive}(separately){}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
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
				{ chips = may_obfuscatedtext(3) }
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
				{ mult = may_obfuscatedtext(3) }
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
				{ chips = may_obfuscatedtext(3) }
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
				{ mult = may_obfuscatedtext(3) }
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
			'All hands gain {C:purple}x2 Mult & Chips{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
	can_use = function(self, card)
		return jl.canuse()
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
			'All hands gain {C:mult}+8 Mult{}',
			'Generates a {C:dark_edition}Jolly Surprise{}...'
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 8,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
	can_use = function(self, card)
		return jl.canuse()
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
			'{C:green}1 in 8{} chance to give all hands',
			'{C:mult}x3 Mult{}',
		}
	},
	set = 'editioncards',
	pos = { x = 1, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = true,
	atlas = 'consumable',
	can_use = function(self, card)
		return jl.canuse()
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


-- Cryptid Jokers

-- Interdimensional
SMODS.Joker {
	key = "hypersphere",
	loc_txt = {
    name = 'Hypersphere',
    text = {
	"{X:purple,C:white}^#1#pi{} Mult & Chips",
	"Scoring {C:attention}3s, Aces and 4s{}",
	"give {X:purple,C:white}^^#2#pi{} Mult & Chips"
    }
  },
	config = { extra = { EEmult = 1, EEchips = 1, Emult = 1, Echips = 1 } },
	pos = { x = 0, y = 0 },
	rarity = "may_interdimensional",
	cost = 1000 * math.pi,
	blueprint_compat = true,
	atlas = "Placeholder",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult, card.ability.extra.EEmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Echip_mod = card.ability.extra.Emult * math.pi,
				Emult_mod = card.ability.extra.Emult * math.pi,
				message = "^^"..card.ability.extra.EEmult.."pi Mult & Chips",
				colour = G.C.PURPLE,
				card = card,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(2, 2)
					play_sound('talisman_eemult')
				return true end }))	
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

if wipmode then

SMODS.Joker {
	key = 'mortuary',
	loc_txt = {
		name = 'Mortuary',
		text = {
		"{C:attention}+#1#{} joker slots",
		"Earn {C:money}$#2#{} at the {C:attention}end of round{}",
		"{X:purple,C:white}^^^#3#{} Mult & Chips",
		"{C:green}Saves you{} when losing if you earned at least {C:attention}50%{} of required score",
		"{C:mult}Self destructs{}"
		}
	},
	config = { extra = { slots = 45, dollars = 250, EEEmultchips = 1.25 } },
	pos = { x = 0, y = 0 },
	cost = 6,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.slots, card.ability.extra.dollars, card.ability.extra.EEEmultchips,}}
    end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				EEEmult_mod = card.ability.extra.EEEmultchips,
				EEEchip_mod = card.ability.extra.EEEmultchips,
				card = card,
				message = '^^^'.. card.ability.extra.EEEmultchips .. ' Mult & Chips',
				colour = G.C.PURPLE,
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					card:juice_up(1, 1)
				return true end }))			
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

if wipmode then

SMODS.Joker {
	key = 'aris_optima',
	loc_txt = {
		name = 'Artis Optima',
		text = {
		"{C:attention}Retriggers{} all {C:attention}jokers{} and {C:attention}playing cards{}",
		"{C:attention}#1#{} times{}",
		"{C:attention}Jokers{} and {C:attention}playing cards{} give {X:mult,C:white}^^#3#{} Mult when {C:attention}triggered{}"
		}
	},
	config = { extra = { amount = 20, EEmult = 2 } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_ethereal',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'Placeholder',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount, getjokers()*card.ability.extra.amount, card.ability.extra.EEmult,}}
    end,
    calculate = function(self, card, context)
		if context.post_trigger and not (context.other_context.blueprint_card or context.other_card) ~= self then
			return {
				EEmult = card.ability.extra.EEmult,
				card = context.other_context.blueprint_card or context.other_card,
			}
		end
		if context.individual and context.cardarea == G.play then
			return {
				EEmult = card.ability.extra.EEmult,
				card = context.other_card,
			}
		end
		if context.retrigger_joker_check and not context.retrigger_joker and not context.other_card ~= self then
			return {
				message = 'Again!',
				card = card,
				repetitions = card.ability.extra.amount
			}
		end
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			return {
				message = 'Again!',
				card = card,
				repetitions = card.ability.extra.amount
			}
		end
	end
}

end

end

-- Debug tools
if conf.Debug then

	local goog = to_big(1e100)
	
	SMODS.Keybind {
		key_pressed = 'f9',
		action = function(self)
			SMODS.restart_game()
		end
	}

	SMODS.Keybind {
		key_pressed = 'p',
		action = function(self)
			ease_dollars(to_number(to_big(goog:arrow(1, 10))))
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'v',
		action = function(self)
			multmoney(3)
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
		key_pressed = '5',
		action = function(self)
			conf.OmeganumUnrestrict = not config.OmeganumUnrestrict
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'y',
		action = function(self)
			create_card("yottacards", G.consumeables, nil, nil, true, true, nil, "may_dbg_ytc")
		end
	}
	
end

-- FJX tests

-- joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, condition, code, shake

FusionJokers.fusions:add_fusion('j_yorick', nil, nil, 'j_jolly', nil, nil, 'j_baron', 5, 'may_enchant', not hasethereal(), nil, 0.8)