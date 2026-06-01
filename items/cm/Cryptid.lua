-- Cryptid cross-mod

-- Misc

-- Pointer blacklist
for k, v in ipairs(may.yotta_cards) do 
	Cryptid.pointerblistify(v, false)
	Cryptid.pointerblistify(v..'_asc', false)
end

for k, v in ipairs(may.can_be_ascended) do 
	Cryptid.pointerblistify('c_may_'..v..'_asc', false)
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
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hlv(removed_levels + to_big(1))
		G.GAME.hands[may.favhand()].level = to_big(removed_levels + to_big(1)):normalize()
		G.GAME.hands[may.favhand()].mult = to_big(G.GAME.hands[may.favhand()].mult) + (to_big(G.GAME.hands[may.favhand()].l_mult)*(G.GAME.hands[may.favhand()].level - to_big(1)))
		G.GAME.hands[may.favhand()].chips = to_big(G.GAME.hands[may.favhand()].chips) + (to_big(G.GAME.hands[may.favhand()].l_chips)*(G.GAME.hands[may.favhand()].level - to_big(1)))
		G.GAME.hands[may.favhand()].mult = G.GAME.hands[may.favhand()].mult:normalize()
		G.GAME.hands[may.favhand()].chips = G.GAME.hands[may.favhand()].chips:normalize()
		delay(1.3)
		may.ch()
	end
})

SMODS.Consumable:take_ownership('c_cry_pointer', {
	misc_badge = may_epic_badge
})

-- Cryptid Fusions

may.fusions:add_fusion('j_may_universal_collapse', nil, nil, 'j_cry_circulus_pistoris', nil, nil, 'j_may_hypersphere', 314159, 'may_interdimensional_joker', nil, 0.8)

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

--[[SMODS.Edition {
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
}]] 

if may.conf.content.Consumables then
-- Cryptid Consumables

	-- Cryptid edition cards
	
--[[SMODS.Consumable {
	key = 'astral_card',
	config = { extra = { e_mult = 1.1 } },
	loc_txt = {
		name = 'Astral Card',
		text = {
			'Gives all hands {X:mult,C:white}^#1#{} Mult',
		}
	},
	set = 'editioncards',
	pos = { x = 0, y = 0 },
	cost = 6,
	rarity = 5,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.e_mult } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('mult', 1, card.ability.extra.e_mult, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('mult', 1, card.ability.extra.e_mult*number, false, card)
	end
}

SMODS.Consumable {
	key = 'mosaic_card',
	config = { extra = { x_chips = 2.5 } },
	loc_txt = {
		name = 'Mosaic Card',
		text = {
			'Gives all hands {X:chips,C:white}X#1#{} Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 4, y = 0 },
	cost = 7,
	rarity = 5,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('chips', 0, card.ability.extra.x_chips, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('chips', 0, card.ability.extra.x_chips*number, false, card)
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
	key = 'noisy_card',
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
	rarity = 2,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
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
		may.hn("All Hands")
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
		may.hcm('+'..chips, nil, true)		
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
		may.hcm(nil, '+'..mult, true)		
		delay(0.5)
		may.ch()
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
		may.hn("All Hands")
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
		may.hcm('+???', nil, true)		
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
		may.hcm(nil, '+???', true)		
		delay(0.5)
		may.ch()
	end
}

SMODS.Consumable {
	key = 'glitched_card',
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
	rarity = 3,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
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
		may.hn("All Hands")
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
		may.hcm('X'..xchips, nil, true)		
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
		may.hcm(nil, 'X'..xmult, true)		
		delay(0.5)
		may.ch()
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
		may.hn("All Hands")
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
		may.hcm('x???', nil, true)		
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
		may.hcm(nil, 'x???', true)		
		delay(0.5)
		may.ch()
	end
}

SMODS.Consumable {
	key = 'oversaturated_card',
	config = { extra = { x_multchips = 2 } },
	loc_txt = {
		name = 'Oversaturated Card',
		text = {
			'Gives all hands {X:purple,C:white}X#1#{} Mult & Chips',
		}
	},
	set = 'editioncards',
	pos = { x = 6, y = 0 },
	cost = 6,
	rarity = 5,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_multchips } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('multchips', 0, card.ability.extra.x_multchips, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('multchips', 0, card.ability.extra.x_multchips*number, false, card)
	end
}

SMODS.Consumable {
	key = 'jolly_card',
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
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('mult', -1, card.ability.extra.mult, false, card)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_jolly', "may_jolly_card")
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
			play_sound('cry_e_jolly')
		return true end }))				

	end,
	bulk_use = function(self, card, area, copier, number)
	    may.hand_mod_multchips_all('mult', -1, card.ability.extra.mult*number, false, card)
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
		may.ch()
	end
}

SMODS.Consumable {
	key = 'fragile_card',
	config = { extra = { x_mult = 3, odds = 8 } },
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
	rarity = 2,
	unlocked = true,
	discovered = true,
	atlas = 'cry_editioncard',
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.x_mult } }
	end,
	use = function(self, card, area, copier)
		if pseudorandom('may_fragilecard') < G.GAME.probabilities.normal / card.ability.extra.odds and not card.ability.eternal then
			may.hand_mod_multchips_all('mult', 0, card.ability.extra.x_mult, false, card)
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
				amount = amount+1
			end
		end
		may.hand_mod_multchips_all('mult', 0, card.ability.extra.x_mult*amount, false, card)
	end
}]]

end

-- Cryptid Jokers

-- Exotic 

-- Only spawn rare and below jokers because i have trace amounts of sanity
--[[may.nanobot_choices = {
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
		name = {'Nanobot', "{C:dark_edition,s:0.6}N Joker"},
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
		if context.before and next(context.poker_hands['Three of a Kind']) and to_big(card.ability.extra.Echip) > to_big(2) then
			play_sound("holo1")
			local card = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_nanobot")
			card:set_edition({negative = true}, true, true)
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
		end
	end
}]]

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
			"{C:attention}Held{} in hand {C:attention}cards gain{} the {C:chips}Chips{}", 
			"of played {C:purple}Poker Hand{} as {X:chips,C:white}XChips{}",
			"{C:attention}Scoring cards gain{} the {C:mult}Mult{}", 
			"of {C:attention}most played{} {C:purple}Poker Hand{} as {X:mult,C:white}XMult{}",
			"{C:attention}Discarded cards{} apply their {X:mult,C:white}XMult{}", 
			"and {X:chips,C:white}XChips{} to {C:attention}most played{} {C:purple}Poker Hand{}", 
			"{C:inactive}#1#, {C:chips}#2#{} {C:inactive}&{} {C:mult}#3#{}"
		}
	},
	rarity = 'cry_exotic',
	atlas = 'cry_joker1',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0 } },
	blueprint_compat = true,
	cost = 50,
	loc_vars = function(self, info_queue, card)
        return { vars = { localize(may.favhand(), 'poker_hands'), G.GAME.hands[may.favhand()].chips, G.GAME.hands[may.favhand()].mult } }
	end,
	calculate = function(self, card, context)
		if context.individual then
			if context.cardarea == G.play then
				context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 1
				context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_chips) + to_big(G.GAME.hands[context.scoring_name].chips)
				return {
					message = 'Upgraded!',
					card = context.other_card,
					colour = G.C.MULT,
					sound = 'may_permabonus'
				}
			elseif context.cardarea == G.hand and not context.end_of_round then
				context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips or 1
				context.other_card.ability.perma_x_chips = to_big(context.other_card.ability.perma_x_chips) + to_big(G.GAME.hands[may.favhand()].chips)
				return {
					message = 'Upgraded!',
					card = context.other_card,
					colour = G.C.CHIPS, 
					sound = 'may_permabonus'
				}
			end
		end
		if context.discard then
			if to_big(context.other_card.ability.perma_x_chips) > to_big(1) then 
				may.hand_mod_multchips(may.favhand(), 'chips', 0, context.other_card.ability.perma_x_chips, false, card)
			end
			if to_big(context.other_card.ability.perma_x_mult) > to_big(1) then 
				may.hand_mod_multchips(may.favhand(), 'mult', 0, context.other_card.ability.perma_x_mult, false, card)
			end
		end
	end
}

SMODS.Joker {
	key = 'etericyclys',
	loc_txt = {
		name = 'Etericyclys',
		text = {
			"When a {C:attention}playing card{} is {C:mult}destroyed{}",
			"create {C:attention}#1#{} {C:dark_edition}Negative{} {C:attention}copies{} of it",
			"in the card's area",
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
						_card:set_edition({negative = true}, true)
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _card)
						v.area:emplace(_card)
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

-- Interdimensional
--[[SMODS.Joker {
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
	immutable = true,
	atlas = "cry_joker1",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_immutable", set = "Other" }
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
	immutable = true,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	misc_badge = may_wip_badge,
	atlas = 'placeholder',
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_immutable", set = "Other" }
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
}]] 

-- Ethereal

if may.conf.content.WIP then

--[[SMODS.Joker {
	key = 'artis_optima',
	loc_txt = {
		name = 'Artis Optima',
		text = {
			"{C:attention}Retriggers{} all {C:attention}Jokers{}",
			"{C:attention}#1#{} times{}",
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
				repetitions = card.ability.extra.amount
			}
		end
	end
}]]

end

-- Cryptid Decks

if may.conf.content.WIP and may.conf.Mode == 2 then

--[[SMODS.Back {
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
					if Overflow then
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
			change_operator(1)
		end
		-- Plasma Deck
		if context.final_scoring_step then
			hand_chips = mod_chips(math.floor((hand_chips + mult)/2))
			mult = mod_mult(math.floor((hand_chips + mult)/2))
			may.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
				ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
				may.a(localize('k_balanced'), 2, 1.4) 
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
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(0.3, 0.5)
			return true end}))
		end
	end
}]] 

end