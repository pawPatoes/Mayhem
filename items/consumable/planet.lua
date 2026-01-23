-- Planet cards

may.rare_planet_rate = 0.003
may.legendary_planet_rate = 0.0003
may.mythic_planet_rate = 0.00006

may.rare_planets = {
	'c_may_vespia',
	'c_may_stos',
	'c_may_triton',
	'c_may_yryx',
	'c_may_pallas', 
	'c_may_parthenope'
}

may.legendary_planets = {
	'c_may_kivaaritehdas',
	'c_may_quac_n7',
	'c_may_opolisis',
	'c_may_en_7b',
}

may.mythic_planets = {
	'c_may_amadeus',
	'c_may_eryndra',
	'c_may_gaea',
	'c_may_matakka'
}

SMODS.Consumable {
	set = 'Planet',
	key = 'proxima_centauri',
	config = { hand_type = 'may_Royal Flush' },
	pos = { x = 4, y = 0 },
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
	},
	in_pool = function(self, args)
		return SMODS.is_poker_hand_visible(self.config.hand_type), {allow_duplicates = false}
	end
}

if (#SMODS.find_mod('Cryptid') == 0) and (#SMODS.find_mod('unik') == 0) then

SMODS.Consumable {
	set = 'Planet',
	key = 'demetrius',
	config = { hand_type = 'may_Bulwark' },
	pos = { x = 4, y = 4 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet?', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	process_loc_text = function(self)
		local target_text = G.localization.descriptions[self.set]['c_mercury'].text
		SMODS.Consumable.process_loc_text(self)
		G.localization.descriptions[self.set][self.key].text = target_text
	end,
	generate_ui = 0,
	loc_txt = {
		['en-us'] = {
			name = 'Demetrius'
		}
	},
	in_pool = function(self, args)
		return SMODS.is_poker_hand_visible(self.config.hand_type), {allow_duplicates = false}
	end
}

end

SMODS.Consumable {
	set = 'Planet',
	key = 'sun',
	pos = { x = 3, y = 4 },
	config = { extra = { cards = 2 } }, 
	atlas = 'planet',
	ignore_allplanets = true,
	loc_txt = {
		name = 'Sun',
		text = {
			"Create {C:attention}#1#{} random", 
			"{X:common,C:white}Common{} {C:planet}Planet Cards{}", 
			"{C:inactive}(Requires room){}"
		}
	},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Star', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 ))
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_sun", set = "Other" } 
		end
		return { vars = { card.ability.extra.cards } }
	end, 
	use = function(self, card)
		for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_sun')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then 
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
		delay(0.6)
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(card.ability.extra.cards * number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_sun')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then 
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
		delay(0.6)
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'dysnomia',
	pos = { x = 2, y = 4 },
	config = { extra = { cards = 1 } }, 
	atlas = 'planet',
	ignore_allplanets = true,
	loc_txt = {
		name = 'Dysnomia', 
		text = {
			"Create #1# {C:attention}copy{} of", 
			"the {C:attention}last{} {X:common,C:white}Common{} {C:planet}Planet Card{}", 
			"{C:attention}used{} this run", 
			"{C:inactive}(Dysnomia excluded, requires room){}"
		}
	}, 
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.last_planet and G.P_CENTERS[G.GAME.last_planet] or nil
		local last_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
		local colour = ((not fool_c) or (G.GAME.last_planet or 'c_may_dysnomia') == 'c_may_dysnomia') and G.C.RED or G.C.GREEN
		if fool_c and (G.GAME.last_planet or 'c_may_dysnomia') ~= 'c_may_dysnomia' then
			info_queue[#info_queue + 1] = fool_c
		end
		local main_end = {
			{
				n = G.UIT.C,
				config = { align = "bm", padding = 0.02 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
						nodes = {
							{ n = G.UIT.T, config = { text = ' ' .. last_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
						}
					}
				}
			}
		}
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_dysnomia", set = "Other" } 
		end 
		return { vars = { card.ability.extra.cards or 1 }, main_end = main_end }
	end, 
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Eridian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, copier)
		for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			if (G.GAME.last_planet or 'c_may_dysnomia') ~= 'c_may_dysnomia' then
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    if G.consumeables.config.card_limit > #G.consumeables.cards then
					    play_sound('timpani')
					    local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_planet, 'may_dysnomia')
					    card2:add_to_deck()
					    G.consumeables:emplace(card2)
					    card:juice_up(0.3, 0.5)
					    if Engulf and card.edition then 
						    card2:set_edition(card.edition.key)
					    end
				    end
			    return true end}))
			end
		end
		delay(0.6)
	end,
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 )) and (G.GAME.last_planet or 'c_may_dysnomia') ~= 'c_may_dysnomia'
	end,
}

--[[SMODS.Consumable {
	set = 'Planet',
	key = 'chronos',
	pos = { x = 0, y = 0 },
	atlas = 'planet',
	endless = true,
	ignore_allplanets = true,
	loc_txt = {
		name = 'Chronos',
		text = {
			"{C:may_interdimensional}Force-trigger{} all held {C:planet}Planet Cards{}",
			"{C:inactive}(If possible, Chronos and Dysnomia excluded){}"
		}
	},
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' and (v:gc().can_use == nil or v:gc().can_use) and (v:gc().key ~= 'c_may_chronos' and v:gc().key ~= 'c_may_dysnomia') then
				return may.canuse()
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_chronos", set = "Other" } 
		end
		return {}
	end, 
	use = function(self, card)
		G.GAME.may_no_dissolve_after_use = true
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' and (v:gc().can_use == nil or v:gc().can_use) and (v:gc().key ~= 'c_may_chronos' and v:gc().key ~= 'c_may_dysnomia') then
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Force-triggered!', colour = SMODS.Gradients.may_col_interdimensional, delay = 0.45, sound = 'may_forcetrigger' })
				G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.2, func = function()
					card:juice_up(0.3, 0.5)
				return true end}))
			end
			if v:gc().set == 'Planet' and (v:gc().key ~= 'c_may_chronos' and v:gc().key ~= 'c_may_dysnomia') and (v:gc().can_use == nil or v:gc().can_use) then
				G.FUNCS.use_card({ config = { ref_table = v } })
				if Engulf and card.edition and not v.edition then
					v:set_edition(card.edition.key)
				end
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
			G.GAME.may_no_dissolve_after_use = nil
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_no_dissolve_after_use = true
		for i=1, number, 1 do
			for k, v in pairs(G.consumeables.cards) do
			    if v:gc().set == 'Planet' and (v:gc().can_use == nil or v:gc().can_use) and (v:gc().key ~= 'c_may_chronos' and v:gc().key ~= 'c_may_dysnomia') then
				    card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Force-triggered!', colour = SMODS.Gradients.may_col_interdimensional, delay = 0.45, sound = 'may_forcetrigger' })
				    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.2, func = function()
					    card:juice_up(0.3, 0.5)
				    return true end}))
			    end
			    if v:gc().set == 'Planet' and (v:gc().key ~= 'c_may_chronos' and v:gc().key ~= 'c_may_dysnomia') and (v:gc().can_use == nil or v:gc().can_use) then
				    G.FUNCS.use_card({ config = { ref_table = v } })
				    if Engulf and card.edition and not v.edition then
					    v:set_edition(card.edition.key)
				    end
			    end
		    end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
			G.GAME.may_no_dissolve_after_use = nil
		return true end}))
	end,
	in_pool = function(self, args)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' then
				return G.GAME.may_endless_mode, {allow_duplicates = false}
			end
		end
		return false, {allow_duplicates = false}
	end
}]]

SMODS.Consumable {
	set = 'Planet',
	key = 'charon',
	pos = { x = 1, y = 2 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Plutonian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	reserve = true,
	loc_txt = {
		name = 'Charon',
		text = {
			"Add the {C:attention}Nominal Chips{} of all {C:attention}cards{}",
			"{C:attention}held in hand{} to the {C:chips}Chips{} of",
			"a {C:attention}random{} {C:purple}Poker Hand{}",
		}
	},
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	use = function(self, card)
		local hand = may.rndhand()
		local amount = 0
		for k, v in pairs(G.hand.cards) do
			amount = amount + v:may_get_nominal_chips()
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = (v:may_get_nominal_chips() > 0 and '+' or '-')..number_format(math.abs(v:may_get_nominal_chips())), colour = G.C.CHIPS, delay = 0.1, sound = 'chips1'})
			G.E_MANAGER:add_event(Event({func = function()
				v:juice_up(0.3, 0.4)
			return true end}))
		end
		may.a((amount > 0 and '+' or '-')..number_format(math.abs(amount)), 2, 1.5, G.C.CHIPS, 'may_positive')
		may.hand_mod_multchips(hand, 'chips', -1, amount, false, card)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, hand, card.edition, 1)
			may.ch()
		end
		delay(0.2)
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		for k, v in pairs(G.hand.cards) do
			amount = amount + v:may_get_nominal_chips()
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = (v:may_get_nominal_chips() > 0 and '+' or '-')..math.abs(v:may_get_nominal_chips()), colour = G.C.CHIPS, delay = 0.1, sound = 'chips1'})
			G.E_MANAGER:add_event(Event({func = function()
				v:juice_up(0.3, 0.4)
			return true end}))
		end
		may.a((amount > 0 and '+' or '-')..math.abs(number_format(amount)), 2, 1.5, G.C.CHIPS, 'may_positive')
		for i = 1, number do
			local hand = may.rndhand()
			may.hand_mod_multchips(hand, 'chips', -1, amount, true, card)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1)
				may.ch()
			end
		end
		may.h('Random Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc((amount > 0 and '+' or '-')..math.abs(number_format(amount)), true)
		delay(0.2)
		may.ch()
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'hydra',
	pos = { x = 3, y = 1 },
	atlas = 'planet',
	config = { extra = { planets = 4 } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Plutonian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Hydra',
		text = {
			"Create #2# {C:dark_edition}CCDs{} of the",
			"{C:planet}Planet Card{} {C:attention}corresponding{}",
			"to {C:attention}most played{} {C:purple}Poker Hand{} and",
			"shuffle them into your {C:attention}deck{}",
			"{C:inactive}#1# (defaults to Tartarus)",
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_ccd_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_tartarus
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_hydra", set = "Other" } 
		end
		return { vars = { localize(may.favhand(), 'poker_hands'), card.ability.extra.planets } }
	end,
	use = function(self, card)
		local created = {}
		local planet = may.planethand(may.favhand()) or 'c_may_tartarus'
		for i=1, card.ability.extra.planets, 1 do
			local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
			if Engulf and card.edition then
				new:set_edition(card.edition.key)
			end
			G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
				new:juice_up()
				play_sound('card1')
				play_sound('tarot1')
			return true end}))
			table.insert(created, new)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for k, v in pairs(created) do
			local percent = 1.15 - (k - 0.999) / (#created - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(created) do
			v:set_ability(planet, nil, true)
		end
		for k, v in pairs(created) do
			local percent = 0.85 + (k - 0.999) / (#created - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(created) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				v:add_to_deck()
				G.play:remove_card(v)
				G.deck:emplace(v)
				play_sound('card1')
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local planet = may.planethand(may.favhand()) or 'c_may_tartarus'
		local created = {}
		for i=1, card.ability.extra.planets*number, 1 do
			local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
			if Engulf and card.edition then
				new:set_edition(card.edition.key)
			end
			G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
				new:juice_up()
				play_sound('card1')
			return true end})) 
			table.insert(created, new)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for k, v in pairs(created) do
			local percent = 1.15 - (k - 0.999) / (#created - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(created) do
			v:set_ability(planet, nil, true)
		end
		for k, v in pairs(created) do
			local percent = 0.85 + (k - 0.999) / (#created - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(created) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				v:add_to_deck()
				G.play:remove_card(v)
				G.deck:emplace(v)
				play_sound('card1')
			return true end}))
		end
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'xiangliu',
	pos = { x = 2, y = 3 },
	atlas = 'planet',
	ignore_allplanets = true,
	config = { extra = { levels = 3, cards = 3 } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Gonggongan Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Xiangliu',
		text = {
			"{C:planet}Level up{} {C:attention}most played{} {C:purple}Poker Hand{} by {C:attention}#1#{}",
			"Create and shuffle {C:attention}#2#{} {C:mult}unmodified{}",
			"{C:attention}playing cards{} into your {C:attention}deck{}",
			"{C:inactive}Will level up #3#{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.levels, card.ability.extra.cards, localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card)
		local created = {}
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), false, card.ability.extra.levels)
		for i=1, card.ability.extra.cards, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
				local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
				new:juice_up()
				play_sound('card1')
				table.insert(created, new)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
			for k, v in pairs(created) do
				if v ~= card then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
						v:add_to_deck()
						G.play:remove_card(v)
						G.deck:emplace(v)
						play_sound('card1')
					return true end}))
				end
			end
		return true end}))
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local created = {}
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), false, card.ability.extra.levels*number)
		for i=1, card.ability.extra.cards*number, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
				local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
				new:juice_up()
				play_sound('card1')
				table.insert(created, new)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
			for k, v in pairs(created) do
				if v ~= card then 
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
						v:add_to_deck()
						G.play:remove_card(v)
						G.deck:emplace(v)
						play_sound('card1')
					return true end}))
				end
			end
		return true end}))
		may.ch()
	end
}


SMODS.Consumable {
	set = 'Planet',
	key = 'haumea',
	pos = { x = 4, y = 1 },
	atlas = 'planet',
	endless = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Haumea',
		text = {
			"Gain the {C:money}Dollars{} of a",
			"{C:attention}random{} {C:purple}Poker Hand{} as {C:money}Interest{}",
		}
	},
	can_use = function(self, card)
		return may.canuse() and G.GAME.round_resets.ante ~= 0
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
    end,
	use = function(self, card)
		local hand = may.rndhand()
		may.th(hand)
		if G.GAME.hands[hand].dollars then
			may.ease_interest(-1, G.GAME.hands[hand].dollars)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..G.GAME.hands[hand].dollars..' Interest'}, colour = G.C.DOLLARS, delay = 0.45})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				card:juice_up(0.3, 0.5)
			return true end}))
		else
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'No Dollars!'}, colour = G.C.MULT, delay = 0.45})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				card:juice_up(0.3, 0.5)
				play_sound('tarot2')
			return true end}))
		end
		may.ch()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, hand, card.edition, 1)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, number, 1 do
			amount = 0
			local hand = may.rndhand()
			may.th(hand)
			if G.GAME.hands[hand].dollars then
				may.ease_interest(-1, G.GAME.hands[hand].dollars)
				amount = amount + G.GAME.hands[hand].dollars
			end
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1)
				may.ch()
			end 
		end
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..amount..' Interest'}, colour = G.C.DOLLARS, delay = 0.45})
		may.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'umbriel',
	pos = { x = 0, y = 2 },
	atlas = 'planet',
	config = { extra = { level = -3 } },
	endless = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Uranian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Umbriel',
		text = {
			"{C:mult}Level down{} {C:attention}most played{} {C:purple}Poker Hand{} by {C:attention}#1#{}",
			"Create a {C:attention}Meteor Tag{}",
			"{C:inactive}#2#, lv. #3#{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS['tag_meteor']
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_umbriel", set = "Other" } 
			info_queue[#info_queue + 1] = G.P_TAGS[may.get_edition_tag(card.edition.key, 'tag_foil')]
		end
		return { vars = { math.abs(card.ability.extra.level), localize(may.favhand(), 'poker_hands'), G.GAME.hands[may.favhand()].level } }
	end,
	can_use = function(self, card)
		return may.canuse() and to_big(G.GAME.hands[may.favhand()].level) >= to_big(3)
	end,
	use = function(self, card)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), nil, card.ability.extra.level)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			add_tag(Tag('tag_meteor'))
		return true end}))
		may.ch()
		if Engulf and card.edition then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				add_tag(Tag(may.get_edition_tag(card.edition.key, 'tag_foil')))
			return true end})) 
		end
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		local amount = to_number(math.floor(G.GAME.hands[may.favhand()].level / math.abs(card.ability.extra.level)))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			for i=1, math.min(500, amount), 1 do
				add_tag(Tag('tag_meteor'))
			end 
		return true end}))
		local copy = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_umbriel', nil)
		G.consumeables:emplace(copy)
		copy:add_to_deck()
		copy:setQty(amount)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), nil, card.ability.extra.level * amount)
		if Engulf and card.edition then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				for i=1, amount do 
					add_tag(Tag(may.get_edition_tag(card.edition.key, 'tag_foil')))
				end
			return true end})) 
		end
		may.ch()
	end,]] 
	in_pool = function(self, args)
		return to_big(G.GAME.hands[may.favhand()].level) >= to_big(7) and G.GAME.may_endless_mode, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'namaka',
	pos = { x = 2, y = 2 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Haumean Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Namaka',
		text = {
			"{C:chips}=#1#{} Chips of all {C:purple}Poker Hands{}",
			"with their {C:chips}Chips{} {C:mult}less than{} {C:chips}#1#{}",
			"{C:attention}Scales{} exponentially per use",
			"{C:inactive}(Max of =50000, scales by (nX1.7)^1.02 rounded down){}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.may_namaka_amount or 30 } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		G.GAME.may_namaka_amount = G.GAME.may_namaka_amount or 30
		for k, v in pairs(G.GAME.hands) do
			if to_big(v.chips) < to_big(G.GAME.may_namaka_amount) then 
				may.hand_mod_multchips(k, 'chips', 'eq', G.GAME.may_namaka_amount, true, card)
				if Engulf and card.edition then 
					Engulf.EditionHand(card, k, card.edition, 1, true)
				end
			end 
		end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		may.h('All Hands', '...', '...', '...')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
			card:juice_up(1, 1)
		return true end}))
		may.hc('='..G.GAME.may_namaka_amount, true)
		may.ch()
		delay(0.5)
		G.GAME.may_namaka_amount = math.floor(math.min(50000, (G.GAME.may_namaka_amount * 1.7) ^ 1.02))
		if G.GAME.may_namaka_amount == 50000 then
			G.GAME.may_namaka_cap = true
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_namaka_amount = G.GAME.may_namaka_amount or 30
		for i=1, number, 1 do
			if G.GAME.may_namaka_amount < 50000 then
				G.GAME.may_namaka_amount = math.floor(math.min(50000, (G.GAME.may_namaka_amount * 1.7) ^ 1.02))
			else
				break
			end
		end
		for k, v in pairs(G.GAME.hands) do
			if to_big(v.chips) < to_big(G.GAME.may_namaka_amount) then 
				may.hand_mod_multchips(k, 'chips', 'eq', G.GAME.may_namaka_amount, true, card)
				if Engulf and card.edition then 
					Engulf.EditionHand(card, k, card.edition, 1, true)
				end
			end 
		end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		may.h('All Hands', '...', '...', '...')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
			card:juice_up(1, 1)
		return true end}))
		may.hc('='..G.GAME.may_namaka_amount, true)
		may.ch()
		delay(0.5)
		if G.GAME.may_namaka_amount == 50000 then
			G.GAME.may_namaka_cap = true
		end
	end,
	in_pool = function(self, args)
		return not G.GAME.may_namaka_cap, {allow_duplicates = false}
	end
}


SMODS.Consumable {
	set = 'Planet',
	key = 'deimos',
	pos = { x = 2, y = 1 },
	atlas = 'planet',
	config = { extra = { Xchips = 0.2, cards = 0 } },
	ignore_allplanets = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Martian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Deimos',
		text = {
			"{C:mult}Destroy{} all {C:attention}Stone Cards{} in {C:attention}full deck{}",
			"{X:chips,C:white}+X#1#{} Chips {C:attention}per{} destroyed {C:attention}card{} to",
			"{C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will give #2#{} {X:chips,C:white}X#3#{} {C:inactive}Chips{}",
		}
	},
	can_use = function(self, card)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v, "m_stone") then
				return may.canuse()
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.Xchips, may.favhand(), 1 + (card.ability.extra.Xchips * card.ability.extra.cards), } }
	end,
	use = function(self, card)
		local found = 0
		--[[for k, v in pairs(G.deck.cards) do
			if SMODS.has_enhancement(v, "m_stone") then
				draw_card(G.deck, G.hand, 100, 'up', false, v)
				found = found + 1
			end
		end
		for k, v in pairs(G.discard.cards) do
			if SMODS.has_enhancement(v, "m_stone") then
				draw_card(G.discard, G.hand, 100, 'up', false, v)
				found = found + 1
			end
		end
		for k, v in pairs(G.consumeables.cards) do
			if SMODS.has_enhancement(v, "m_stone") then
				draw_card(G.consumeables, G.hand, 100, 'up', false, v)
				found = found + 1
			end
		end
		for k, v in pairs(G.jokers.cards) do
			if SMODS.has_enhancement(v, "m_stone") then
				draw_card(G.jokers, G.hand, 100, 'up', false, v)
				found = found + 1
			end
		end
		for k, v in pairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				local percent = math.max(0.01, 1.15 + (k-0.999)/(#G.hand.cards-0.998)*0.3)
				if SMODS.has_enhancement(v, "m_stone") then
					v.highlighted = true
					play_sound('card1', percent)
				end
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				if SMODS.has_enhancement(v, "m_stone") then
					v:start_dissolve()
				end
			return true end}))
		end]]
		for k, v in pairs(G.playing_cards) do	
			if SMODS.has_enhancement(v, "m_stone") then
				if (not next(SMODS.find_card('j_may_cement_joker'))) and (not next(SMODS.find_card('j_may_rocco_pfilosofia'))) and (not next(SMODS.find_card('j_may_infinity_stone'))) and (not next(SMODS.find_card('j_may_zodium_calamitas'))) then 
					SMODS.destroy_cards({v})
				end
				found = found + 1
			end
		end
		may.hand_mod_multchips(may.favhand(), 'chips', 0, 1 + (found * card.ability.extra.Xchips), false, card)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		local found = 0
		for k, v in pairs(G.playing_cards) do	
			if SMODS.has_enhancement(v, "m_stone") then
				found = found + 1
				if (not next(SMODS.find_card('j_may_cement_joker'))) and (not next(SMODS.find_card('j_may_rocco_pfilosofia'))) and (not next(SMODS.find_card('j_may_infinity_stone'))) and (not next(SMODS.find_card('j_may_galaxy_eater'))) then 
					SMODS.destroy_cards({v})
				end
			end
		end
		may.hand_mod_multchips(may.favhand(), 'chips', 0, found * card.ability.extra.Xchips, false, card)
		local copy = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_demetrius', nil)
		G.consumeables:emplace(copy)
		copy:add_to_deck()
		copy:setQty(number - 1)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,]]
	update = function(self, card, dt)
		local count = 0
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v, "m_stone") then
				count = count + 1
			end
		end
		card.ability.extra.cards = count
	end,
	in_pool = function(self, args)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v, "m_stone") then
				return true, {allow_duplicates = false}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'tartarus',
	config = { extra = { mphand = 2, other = -1 } },
	pos = { x = 1, y = 1 },
	atlas = 'planet',
	loc_txt = {
		name = 'Tartarus',
		text = {
			"{C:planet}Levels up{} {C:attention}most played{}",
			"{C:purple}Poker Hand{} by {C:attention}#1#{}",
			"{C:mult}Decreases level{} of another {C:attention}2 random{}",
			"{C:purple}Poker Hands{} by {C:attention}#2#{}",
			"{C:inactive}Will level up #3#{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mphand, math.abs(card.ability.extra.other), localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card)
		local hand = may.favhand()
		may.th(hand)
		level_up_hand(card, hand, nil, card.ability.extra.mphand)
		delay(0.5)
		for i=1, 2, 1 do
			local hand2 = may.rndhand(hand)
			may.th(hand2)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, card.ability.extra.other)
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot2')
				return true end}))
			end
			delay(1.3)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = may.favhand()
		may.th(hand)
		level_up_hand(card, hand, nil, card.ability.extra.mphand*number)
		delay(0.5)
		for i=1, number*2, 1 do
			local hand2 = may.rndhand(hand)
			if to_number(G.GAME.hands[hand2].level) > 1 then
				level_up_hand(card, hand2, nil, card.ability.extra.other)
			end
		end
		may.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('-', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.h(nil, nil, nil, card.ability.extra.other)
		delay(1.3)
		may.ch()
	end,
	in_pool = function(self, args)
		local sum = 0
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) then
				sum = sum + v.level
				if to_big(sum) >= to_big(15) then
					return true, {allow_duplicates = false}
				end
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'gersemi',
	config = { extra = { planets = 1 } },
	pos = { x = 5, y = 0 },
	atlas = 'planet',
	reserve = true,
	ignore_allplanets = true,
	may_persist_after_use = true,
	loc_txt = {
		name = 'Gersemi',
		text = {
			"Use to {C:mult}destroy{} selected {C:planet}Planet Cards{},", 
			"after which this card will {C:green}allow{} you", 
			"to apply {C:attention}random{} {C:dark_edition}Enhancements{} to selected cards", 
			"held in hand per {C:attention}#1#{} {C:planet}Planet Card{} {C:mult}destroyed{}"
		}
	},
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.highlighted) do
			if v:gc().set == 'Planet' and v ~= card then
				return may.canuse()
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.planets } }
	end,
	use = function(self, card)
		local count = 0
		for k, v in pairs(G.consumeables.highlighted) do
			if v:gc().set == 'Planet' and v ~= self then
				count = count + v:getQty()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					v:start_dissolve()
					v:juice_up(0.3, 0.5)
					play_sound('card3')
				return true end})) 
			end
		end 
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			card:juice_up(0.3, 0.5)
			play_sound('card1')
			play_sound('generic1')
			card:flip()
		return true end})) 
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
			card:set_ability(G.P_CENTERS['c_may_gersemi_active'])
			card.ability.extra.targets = count
			card:juice_up(0.3, 0.5)
			play_sound('card1')
			play_sound('may_positive')
			card:flip()
		return true end}))
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
			if card.area then
			    card.area:remove_card(card)
		    end
			G.consumeables:emplace(card)
			card.ability.extra.targets = count
			play_sound('card1')
		return true end}))
	end,
	in_pool = function(self, args)
		return G.GAME.round >= 6, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'gersemi_active',
	config = { extra = { targets = 0 } },
	pos = { x = 5, y = 1 },
	atlas = 'planet',
	ignore_allplanets = true,
	no_merge = true,
	no_collection = true, 
	no_grc = true,
	no_doe = true, 
	hidden = true, 
	soul_rate = 0,
	loc_txt = {
		name = 'Gersemi {C:green}(Active){}',
		text = {
			"Apply {C:attention}random{} {C:dark_edition}Enhancements{} to", 
			"{C:attention}#1#{} selected cards in hand"
		}
	},
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.extra.targets + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.targets } }
	end,
	use = function(self, card)
		local targets = {}
		for k, v in pairs(G.hand.highlighted) do
			if v ~= card then 
				table.insert(targets, v)
			end 
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets do
		local percent = 1.15 - (i-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		delay(0.2)
		for i=1, #targets do
			local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' and not v.overrides_base_rank then
                    cen_pool[#cen_pool + 1] = v
                end
            end
            local enhancement = pseudorandom_element(cen_pool, 'may_gersemi') 
			local percent = 0.85 + (i-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				targets[i]:flip()
				targets[i]:set_ability(enhancement, true, nil)
				play_sound('tarot2', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.hand:unhighlight_all()
		return true end}))
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'mangas',
	pos = { x = 1, y = 0 },
	atlas = 'planet',
	loc_txt = {
		name = 'Mangas',
		text = {
			"Gain {C:green}double{} the {C:planet}level{} of a",
			"{C:attention}random{} {C:purple}Poker Hand{} as {C:money}money{}",
			"then set it's {C:planet}level{} to {C:mult}1{}", 
            "{C:inactive}Max of +$#1#{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
    loc_vars =function(self, info_queue, card)
		if G.GAME.blind then
            return { vars = { math.max(100, to_big(G.GAME.dollars) * to_big(10)) } }
		else 
			return { vars = { '(current money X 10) or 100, whichever is bigger' } }
		end
    end, 
	use = function(self, card)
		local hand = may.rndhand()
		local amount = math.min(to_big((G.GAME.hands[hand].level or 1) * 2), math.max(to_big(G.GAME.dollars) * to_big(10), 100))
		may.th(hand)
		if to_big(G.GAME.hands[hand].level or 1) > to_big(1) then
			may.set_hand_level(card, hand, nil, 1)
		else
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Level 1 or below!'}, colour = G.C.MULT, delay = 0.45})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
			    play_sound('tarot2')
			return true end}))
		end
		ease_dollars(amount)
		may.ch()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, hand, card.edition, 1)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local total = 0
		for i=1, number, 1 do
			local hand = may.rndhand(hand)
			total = total + math.min(to_big(G.GAME.hands[hand].level or 1) * 2), to_big(math.max(to_big(100), to_big(G.GAME.dollars) * to_big(10)))
			may.set_hand_level(card, hand, true, 1)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1, true)
			end
		end
		may.h('Random Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eq_level')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hlv(1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot2')
			card:juice_up(0.8, 0.5)
		return true end}))
		ease_dollars(total)
		may.ch()
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'deucalion',
	loc_txt = {
		name = 'Deucalion',
		text = {
			"{C:planet}Levels up{} all {C:red}undiscovered{}", 
			"{C:purple}Poker Hands{} by {C:attention}#1#{}",
		}
	},
	pos = {x = 0, y = 3 },
	atlas = 'planet',
	config = { extra = { amount = 1 } },
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		for k, v in pairs(G.GAME.hands) do
			if not SMODS.is_poker_hand_visible(k) then
				return may.canuse()
			end
		end
		return false 
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount } }
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			if not SMODS.is_poker_hand_visible(k) then
				level_up_hand(card, k, true, card.ability.extra.amount)
			end
		end
		may.h('Undiscovered Hands', '...', '...', '')
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
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hlv('+'..card.ability.extra.amount, true)
		delay(1.3)
		may.ch()
	end, 
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			if not SMODS.is_poker_hand_visible(k) then
				level_up_hand(card, k, true, card.ability.extra.amount * number)
			end
		end
		may.h('Undiscovered Hands', '...', '...', '')
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
		may.hlv('+'..card.ability.extra.amount*number, true)
		delay(1.3)
		may.ch()
	end, 
	in_pool = function(self, args)
		for k, v in pairs(G.GAME.hands) do
			if not SMODS.is_poker_hand_visible(k) then
				return true
			end
		end
		return false  
	end 
 }

SMODS.Consumable {
	set = 'Planet',
	key = 'planet_wee',
	config = { extra = { amount = 2 } },
	pos = { x = 0, y = 1 },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Wee Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Planet Wee',
		text = {
			"{C:planet}Levels up{} {C:attention}lowest scoring{}",
			"{C:purple}Poker Hand{} by {C:attention}#1#{}",
			"{C:inactive}(Will level up #2#){}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, localize(may.ls_hand(), 'poker_hands') } }
	end,
	use = function(self, card)
		may.th(may.ls_hand())
		level_up_hand(card, may.ls_hand(), nil, card.ability.extra.amount)
		delay(0.5)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(number, 100) do
			level_up_hand(card, may.ls_hand(), true, card.ability.extra.amount)
		end
		-- Bulk using over 100 times would be atrocious on performance, but i don't want to waste the excess consumables so here you go
		if math.max(0, number - 100) > 0 then
			may.level_up_all_hands(card, true, math.max(0, number - 100) * card.ability.extra.amount * 0.01)
		end
		may.h('Lowest scoring Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		may.hm('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		may.hc('+', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		may.hlv('+'..card.ability.extra.amount, true)
		delay(1.3)
		may.ch()
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
		    "Set the {C:planet}level{} of", 
			"a {C:attention}random{} {C:purple}Poker Hand{} to {C:mult}1{}",
			"and {C:green}distribute{} it's {C:attention}former{} {C:planet}level{}", 
			"across all other {C:green}discovered{} {C:purple}Poker Hands{}", 
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card)
		local hand = may.rndhand()
		may.th(hand)
		local hands = 0
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) then 
				hands = hands + 1
			end 
		end
		local amount = to_big(G.GAME.hands[hand].level or 1) / to_big(hands)
		if to_big(G.GAME.hands[hand].level or 1) > to_big(1) then
			may.set_hand_level(card, hand, nil, 1)
		else
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Level 1 or below!'}, colour = G.C.MULT, delay = 0.45})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
			    play_sound('tarot2')
			return true end}))
		end
		may.level_up_all_hands(card, false, amount, hand)
	end,
	bulk_use = function(self, card, area, copier, number)
		local total = 0
		local hands = 0
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) then 
				hands = hands + 1
			end 
		end
		for i=1, number, 1 do
			local hand = may.rndhand(hand)
			total = to_big(G.GAME.hands[hand].level or 1) / to_big(hands)
			may.set_hand_level(card, hand, true, 1)
			may.level_up_all_hands(card, true, total, hand) 
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1, true)
			end
		end
		may.h('Random Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eq_level')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hlv(1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hlv('+???')
		may.ch()
	end, 
	in_pool = function(self, args)
		local sum = 0
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) then
				sum = sum + v.level
				if to_big(sum) >= to_big(15) then
					return true, {allow_duplicates = false}
				end
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'moon',
	pos = { x = 1, y = 3 },
	config = { extra = { planets = 4 } },
	atlas = 'planet',
	ignore_allplanets = true,
	loc_txt = {
		name = 'Moon',
		text = {
			"{C:mult}Destroy{} {C:attention}rightmost consumable{}", 
            "and create {C:attention}#1#{} random", 
			"{C:planet}Planet Cards{} in its place", 
			"if that {C:attention}consumable{} is a {C:planet}Planet Card{}", 
			"{C:inactive}Does not require room, cannot destroy itself{}"
		}
	},
	can_use = function(self, card)
		return may.canuse() and #G.consumeables.cards > 0 and G.consumeables.cards[#G.consumeables.cards] ~= card and G.consumeables.cards[#G.consumeables.cards]:gc().set == 'Planet'
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_moon", set = "Other" } 
		end
		return { vars = { card.ability.extra.planets } }
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Terran Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() 
			if G.consumeables.cards[#G.consumeables.cards] then 
			    G.consumeables.cards[#G.consumeables.cards]:juice_up(0.3, 0.5)
			    if G.consumeables.cards[#G.consumeables.cards]:getQty() > 1 then
				    G.consumeables.cards[#G.consumeables.cards]:setQty(G.consumeables.cards[#G.consumeables.cards]:getQty() - 1)
			    else
				    G.consumeables.cards[#G.consumeables.cards]:start_dissolve()
			    end
			    play_sound('card3')
			    card:juice_up(0.3, 0.5)
			end
		return true end})) 
		for i = 1, card.ability.extra.planets do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_moon')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
				if Engulf and card.edition then
					card2:set_edition(card.edition.key)
				end
			return true end}))
		end
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		local copy = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_umbriel', nil)
		G.consumeables:emplace(copy)
		copy:add_to_deck()
		if #G.consumeables.cards > 0 and G.consumeables.cards[#G.consumeables.cards] ~= card and G.consumeables.cards[#G.consumeables.cards]:gc().set == 'Planet' then 
			copy:setQty(number - 1)
		else 
			copy:setQty(number)
		end
		if #G.consumeables.cards > 0 and G.consumeables.cards[#G.consumeables.cards] ~= card and G.consumeables.cards[#G.consumeables.cards]:gc().set == 'Planet' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() 
				G.consumeables.cards[#G.consumeables.cards]:juice_up(0.3, 0.5)
				G.consumeables.cards[#G.consumeables.cards]:start_dissolve()
				play_sound('card3')
				card:juice_up(0.3, 0.5)
			return true end})) 
			for i = 1, card.ability.extra.planets do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_moon')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then
						card2:set_edition(card.edition.key)
					end
				return true end}))
			end
		end
	end]] 
}

	-- Spacecraft

SMODS.Consumable {
	set = 'Planet',
	key = 'satellite',
	pos = { x = 1, y = 4 },
	config = { extra = { planets = 3 } },
	atlas = 'planet',
	ignore_allplanets = true,
	loc_txt = {
		name = 'Satellite',
		text = {
			{
				"Create {C:attention}#1# random{} {C:chips}hand-specific{} {C:planet}Planet Cards{}",
				"with {C:mult}0{} {C:money}sell value",
				"{C:inactive}(Requires room){}",
			}, 
			{
				"{C:inactive,E:1}Art by mags{}"
			}
		}
	},
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 ))
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_satellite", set = "Other" } 
		end
		return { vars = { card.ability.extra.planets } }
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spacecraft', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	pools = { Spacecraft = true }, 
	use = function(self, card)
		for i = 1, card.ability.extra.planets do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					play_sound('timpani')
					local card2 = create_card('HandSpecific', G.consumeables, nil, nil, nil, nil, nil, 'may_satellite')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card2.sell_cost = 0
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, card.ability.extra.planets * number do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					play_sound('timpani')
					local card2 = create_card('HandSpecific', G.consumeables, nil, nil, nil, nil, nil, 'may_satellite')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card2.sell_cost = 0
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
	end
}

	-- Ring Systems
	
SMODS.Consumable {
	set = 'Planet',
	key = 'rings_of_jupiter',
	pos = { x = 3, y = 3 },
	atlas = 'planet',
	config = { extra = { lev_mult = 2, lev_chips = 15, } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Rings of Jupiter',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:mult}+#1#{} {C:may_ethereal}Level{} Mult and {C:chips}+#2#{} {C:may_ethereal}Level{} Chips"
		}
	},
	pools = { RingSystem = true }, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		return { vars = { card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
	end,
	use = function(self, card)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.lev_mult = (G.GAME.may_ring_bonuses.lev_mult or 0) + card.ability.extra.lev_mult
		G.GAME.may_ring_bonuses.lev_chips = (G.GAME.may_ring_bonuses.lev_chips or 0) + card.ability.extra.lev_chips
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.lev_mult = (G.GAME.may_ring_bonuses.lev_mult or 0) + (card.ability.extra.lev_mult * number)
		G.GAME.may_ring_bonuses.lev_chips = (G.GAME.may_ring_bonuses.lev_chips or 0) + (card.ability.extra.lev_chips * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'rings_of_saturn',
	pos = { x = 3, y = 2 },
	atlas = 'planet',
	config = { extra = { score = 800, dollars = 0.1 } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Rings of Saturn',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:may_score}+#1#{} Score and {C:money}+#2#{} Dollars"
		}
	},
	pools = { RingSystem = true }, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_hand_score_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		return { vars = { card.ability.extra.score, card.ability.extra.dollars } }
	end,
	use = function(self, card)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.score = (G.GAME.may_ring_bonuses.score or 0) + card.ability.extra.score
		G.GAME.may_ring_bonuses.dollars = (G.GAME.may_ring_bonuses.dollars or 0) + card.ability.extra.dollars
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.score = (G.GAME.may_ring_bonuses.score or 0) + (card.ability.extra.score * number)
		G.GAME.may_ring_bonuses.dollars = (G.GAME.may_ring_bonuses.dollars or 0) + (card.ability.extra.dollars * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'rings_of_uranus',
	pos = { x = 4, y = 3 },
	atlas = 'planet',
	config = { extra = { levels = 0.8, } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Rings of Uranus',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{}", 
			"is {C:planet}leveled up{} by an additional {C:attention}#1#{}"
		}
	},
	pools = { RingSystem = true }, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.levels, } }
	end,
	use = function(self, card)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.levels = (G.GAME.may_ring_bonuses.levels or 0) + card.ability.extra.levels
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.levels = (G.GAME.may_ring_bonuses.levels or 0) + (card.ability.extra.levels * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end
} 

SMODS.Consumable {
	set = 'Planet',
	key = 'rings_of_neptune',
	pos = { x = 0, y = 4 },
	atlas = 'planet',
	config = { extra = { mult = 4, chips = 25, } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Rings of Neptune',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips"
		}
	},
	pools = { RingSystem = true }, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, } }
	end,
	use = function(self, card)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.mult = (G.GAME.may_ring_bonuses.mult or 0) + card.ability.extra.mult
		G.GAME.may_ring_bonuses.chips = (G.GAME.may_ring_bonuses.chips or 0) + card.ability.extra.chips
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.mult = (G.GAME.may_ring_bonuses.mult or 0) + (card.ability.extra.mult * number)
		G.GAME.may_ring_bonuses.chips = (G.GAME.may_ring_bonuses.chips or 0) + (card.ability.extra.chips * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Activated!'}, colour = get_type_colour(self or card.config, card), delay = 0.45})
	end
}

	-- Jovian Moons
	-- key, name, hand, level mult, level chips, x pos, y pos
may.jovian_moons = {
	{'amalthea', 'Amalthea', 'Pair', 1, 7, 1, 0},
	{'metis', 'Metis', 'Three of a Kind', 1, 10, 4, 1},
	{'iocaste', 'Iocaste', 'Full House', 1, 12, 2, 1},
	{'ganymede', 'Ganymede', 'Four of a Kind', 1, 15, 4, 0},
	{'europa', 'Europa', 'Flush', 1, 7, 3, 0},
	{'io', 'Io', 'Straight', 1, 15, 1, 1},
	{'adrastea', 'Adrastea', 'Two Pair', 1, 10, 0, 0},
	{'themisto', 'Themisto', 'Straight Flush', 2, 20, 2, 2},
	{'thebe', 'Thebe', 'High Card', 1, 2, 0, 2},
	{'leda', 'Leda', 'Five of a Kind', 1, 17, 3, 1},
	{'himalia', 'Himalia', 'Flush House', 2, 20, 0, 1},
	{'ersa', 'Ersa', 'Flush Five', 1, 25, 2, 0},
	{'thelxinoe', 'Thelxinoe', 'may_Royal Flush', 5, 30, 1, 2},
	{'valetudo', 'Valetudo', may.bulwark_key, 1, 25, 3, 2},
}

for k, v in pairs(may.jovian_moons) do
	SMODS.Consumable {
		set = 'Planet',
		key = v[1],
		config = { jovian_hand = v[3], extra = { hand = v[3], lev_mult = v[4], lev_chips = v[5], } },
		pos = { x = v[6], y = v[7] },
		display_size = { w = 65, h = 95 },
		atlas = 'jovianmoon',
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
		end,
		cost = 3,
		loc_txt = {
			name = v[2],
			text = {
				"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_ethereal}Level{} Mult", 
				"and {C:chips}+#3#{} {C:may_ethereal}Level{} Chips"
			}
		},
		pools = { JovianMoon = true }, 
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
			return { vars = { localize(card.ability.extra.hand, 'poker_hands'), card.ability.extra.lev_mult, card.ability.extra.lev_chips, } }
		end,
		use = function(self, card)
			may.hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult)
			may.hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
				may.ch()
			end
		end,
		bulk_use = function(self, card, area, copier, number)
			may.hand_mod_lvl_multchips(card.ability.extra.hand, 'mult', -1, card.ability.extra.lev_mult*number)
			may.hand_mod_lvl_multchips(card.ability.extra.hand, 'chips', -1, card.ability.extra.lev_chips*number)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, number)
				may.ch()
			end 
		end,
		in_pool = function(self, args)
			return to_big(G.GAME.hands[v[3]].level) >= to_big(6) and SMODS.is_poker_hand_visible(v[3]) and G.GAME.hands[v[3]].played >= 1, {allow_duplicates = false}
		end
	}
end

	-- Saturnian Moons
	-- same as jovian moons, lev_mult = score, lev_chips = dollars, x, y
may.saturnian_moons = {
	{'enceladus', 'Enceladus', 'Pair', 240, 0.4, 1, 0},
	{'tethys', 'Tethys', 'Three of a Kind', 1080, 0.5, 6, 0},
	{'dione', 'Dione', 'Full House', 1960, 0.8, 2, 0},
	{'iapetus', 'Iapetus', 'Four of a Kind', 5040, 1, 3, 0},
	{'titan', 'Titan', 'Flush', 1680, 0.4, 7, 0},
	{'mimas', 'Mimas', 'Straight', 1440, 0.6, 5, 0},
	{'hyperion', 'Hyperion', 'Two Pair', 480, 0.45, 4, 0},
	{'phoebe', 'Phoebe', 'Straight Flush', 9600, 1.5, 0, 0},
	{'janus', 'Janus', 'High Card', 60, 0.2, 0, 0},
	{'epimetheus', 'Epimetheus', 'Five of a Kind', 17280, 2, 0, 0},
	{'prometheus', 'Prometheus', 'Flush House', 23520, 2.5, 0, 0},
	{'pandora', 'Pandora', 'Flush Five', 30720, 3, 0, 0}, 
	{'siarnaq', 'Siarnaq', 'may_Royal Flush', 11880, 5, 0, 0},
	{'atlas', 'Atlas', may.bulwark_key, 30505, 2.5, 0, 0},
}

for k, v in pairs(may.saturnian_moons) do
	SMODS.Consumable {
		set = 'Planet',
		key = v[1],
		config = { saturnian_hand = v[3], extra = { hand = v[3], dollars = v[5], score = v[4], } },
		pos = { x = v[6], y = v[7] },
		atlas = 'saturnianmoon',
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge('Saturnian Moon', get_type_colour(self or card.config, card), nil, 1.2)
		end,
		cost = 3,
		loc_txt = {
			name = v[2],
			text = {
				"Give {C:attention}#1#{} {C:money}+#2#{} Dollars",
				"and {C:may_score}+#3#{} Score"
			}
		},
		pools = { SaturnianMoon = true }, 
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "may_hand_score_tutorial", set = "Other" }
			info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
			return { vars = { localize(card.ability.extra.hand, 'poker_hands'), card.ability.extra.dollars, card.ability.extra.score, } }
		end,
		use = function(self, card)
			may.hand_mod_dollars(card.ability.extra.hand, -1, card.ability.extra.dollars)
			may.hand_mod_score(card.ability.extra.hand, -1, card.ability.extra.score)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
				may.ch()
			end
		end,
		bulk_use = function(self, card, area, copier, number)
			may.hand_mod_dollars(card.ability.extra.hand, -1, card.ability.extra.dollars*number)
			may.hand_mod_score(card.ability.extra.hand, -1, card.ability.extra.score*number)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, number)
				may.ch()
			end
		end,
		in_pool = function(self, args)
			return to_big(G.GAME.hands[v[3]].level) >= to_big(12) and SMODS.is_poker_hand_visible(v[3]) and G.GAME.hands[v[3]].played >= 3 and G.GAME.may_endless_mode, {allow_duplicates = false}
		end
	}
end

-- Rare Planets

SMODS.Consumable {
	set = 'Planet',
	key = 'vespia',
	config = { extra = { amount = 20 } },
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
			"by {C:attention}20{}",
			"{C:inactive}Will level up #2#{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), nil, card.ability.extra.amount)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), nil, card.ability.extra.amount*number)
		may.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'triton',
	config = { extra = { amount = 8 } },
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
			"{C:inactive}Will upgrade #2#{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		return { vars = { card.ability.extra.amount, localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card)
		may.hand_mod_lvl_multchips(may.favhand(), 'multchips', 0, card.ability.extra.amount)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_lvl_multchips(may.favhand(), 'multchips', 0, card.ability.extra.amount ^ number)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
			may.ch()
		end
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'yryx',
	config = { extra = { hands = 3, amount = 15 } },
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
			"by {C:attention}#1#{}",
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, card.ability.extra.hands } }
	end,
	use = function(self, card)
		for i=1, card.ability.extra.hands, 1 do
			local hand = may.rndhand()
			may.th(hand)
			level_up_hand(card, hand, nil, card.ability.extra.amount)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, card.ability.extra.hands*number, 1 do
			local hand = may.rndhand()
			may.th(hand)
			level_up_hand(card, hand, nil, card.ability.extra.amount)
		end
		may.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'stos',
	pos = { x = 0, y = 0 },
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
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { localize(may.favhand(), 'poker_hands'), G.GAME.hands[may.favhand()].mult, G.GAME.hands[may.favhand()].chips } }
	end,
	use = function(self, card)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[may.favhand()] then
				G.GAME.hands[k].chips = G.GAME.hands[k].chips + to_big(G.GAME.hands[may.favhand()].chips)
				G.GAME.hands[k].mult = G.GAME.hands[k].mult + to_big(G.GAME.hands[may.favhand()].mult)
				if Engulf and card.edition then 
					Engulf.EditionHand(card, k, card.edition, 1, true)
					may.ch()
				end
			end
		end
		may.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('+'..number_format(to_big(G.GAME.hands[may.favhand()].chips)), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('+'..number_format(to_big(G.GAME.hands[may.favhand()].mult)), true)
		delay(0.5)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= G.GAME.hands[may.favhand()] then
				G.GAME.hands[k].chips = G.GAME.hands[k].chips + to_big(G.GAME.hands[may.favhand()].chips):mul(number)
				G.GAME.hands[k].mult = G.GAME.hands[k].mult + to_big(G.GAME.hands[may.favhand()].mult):mul(number)
				if Engulf and card.edition then 
					Engulf.EditionHand(card, k, card.edition, number, true)
					may.ch()
				end
			end
		end
		may.h('Other Hands', '...', '...', '')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('+'..number_format(to_big(G.GAME.hands[may.favhand()].chips):mul(number)), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('+'..number_format(to_big(G.GAME.hands[may.favhand()].mult):mul(number)), true)
		delay(0.5)
		may.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'vanathos',
	pos = { x = 2, y = 0 },
	atlas = 'rareplanet',
	cost = 10,
	planet_rarity = 2,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Stosian Moon', get_type_colour(self or card.config, card), nil, 1.2)
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
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card)
		local mult = 0
		local chips = 0 
		for i=1, 2, 1 do
			local hand = may.rndhand(may.favhand())
			may.th(hand)
			mult = mult + G.GAME.hands[hand].mult
			chips = chips + G.GAME.hands[hand].chips
			delay(0.3)
		end
		G.GAME.hands[may.favhand()].mult = G.GAME.hands[may.favhand()].mult + mult
		G.GAME.hands[may.favhand()].chips = G.GAME.hands[may.favhand()].chips + chips
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('+'..number_format(chips), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('+'..number_format(mult), true)
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local mult = 0
		local chips = 0 
		for i=1, 2*number, 1 do
			local hand = may.rndhand(may.favhand())
			may.th(hand)
			mult = mult + G.GAME.hands[hand].mult
			chips = chips + G.GAME.hands[hand].chips
			delay(0.3)
		end
		G.GAME.hands[may.favhand()].mult = G.GAME.hands[may.favhand()].mult + mult
		G.GAME.hands[may.favhand()].chips = G.GAME.hands[may.favhand()].chips + chips
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hc('+'..number_format(chips), true)
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('multhit1')
			card:juice_up(0.8, 0.5)
		return true end}))
		may.hm('+'..number_format(mult), true)
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
			may.ch()
		end
		may.ch()
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'parthenope',
	pos = { x = 1, y = 1 },
	config = { extra = { amount = 0.5 } },
	atlas = 'rareplanet',
	planet_rarity = 2,
	cost = 10,
	loc_txt = {
		name = 'Parthenope',
		text = {
			"{C:planet}Level up{} all {C:purple}Poker Hands{}", 
			"by {X:attention,C:white}X#1#{} the {C:planet}level{}", 
			"of {C:attention}most played{} {C:purple}Poker Hand{},", 
			"{C:mult}except{} {C:attention}most played{} {C:purple}Poker Hand{}", 
			"{C:inactive}#2#, will level up by #3#{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet", 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount, localize(may.favhand(), 'poker_hands'), G.GAME.hands[may.favhand()].level * card.ability.extra.amount } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	use = function(self, card)
		may.level_up_all_hands(card, false, G.GAME.hands[may.favhand()].level * card.ability.extra.amount, may.favhand())
	end,
	bulk_use = function(self, card, area, copier, number)
		may.level_up_all_hands(card, false, G.GAME.hands[may.favhand()].level * card.ability.extra.amount * number, may.favhand())
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'pallas',
	pos = { x = 2, y = 1 },
	atlas = 'rareplanet',
	planet_rarity = 2,
	cost = 10,
	loc_txt = {
		name = 'Pallas',
		text = {
			"Add the {C:attention}Nominal Chips{}", 
			"of {C:attention}all cards{} in full deck", 
			"to the {C:chips}Chips{} and {C:may_ethereal}Level{} {C:chips}Chips{}", 
			"of {C:attention}all{} {C:purple}Poker Hands{}", 
			"{C:inactive}#1# Nominal Chips{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet", 
	loc_vars = function(self, info_queue, card)
		local amount = 0
		if G.GAME.blind then
			for k, v in pairs(G.playing_cards) do 
				amount = amount + v:may_get_nominal_chips()
			end 
		end
		return { vars = { amount } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Rare', G.C.RARITY[3], nil, 1.2)
	end,
	use = function(self, card)
		local amount = 0
		if G.GAME.blind then
			for k, v in pairs(G.playing_cards) do 
				amount = amount + v:may_get_nominal_chips()
			end 
		end
		may.hand_mod_multchips_all('chips', - 1, amount, false, card)
		may.hand_mod_lvl_multchips_all('chips', - 1, amount, false, card)
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		if G.GAME.blind then
			for k, v in pairs(G.playing_cards) do 
				amount = amount + v:may_get_nominal_chips()
			end 
		end
		may.hand_mod_multchips_all('chips', - 1, amount * number, false, card)
		may.hand_mod_lvl_multchips_all('chips', - 1, amount * number, false, card)
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, number, true)
			end 
		end
	end,
	in_pool = function(self, args)
		return #G.playing_cards >= 40, {allow_duplicates = false}
	end
}

-- Legendary planets

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
	endless = true,
	loc_txt = {
		name = 'Kivaaritehdas',
		text = {
			"{C:attention}Adds quadruple{} the {C:purple}Mult & Chips{} of {C:attention}every{} {C:purple}Poker Hand{}",
			"to your {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will give #1# {C:mult}#2#{} {C:inactive}Mult and {C:chips}#3#{} {C:inactive}Chips{}",
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { localize(may.favhand(), 'poker_hands'), number_format(may.get_all_ph_mult(G.GAME.hands[may.favhand()]):mul(4)), number_format(may.get_all_ph_chips(G.GAME.hands[may.favhand()]):mul(4)) } }
	end,
	use = function(self, card)
		G.GAME.hands[may.favhand()].mult = G.GAME.hands[may.favhand()].mult + may.get_all_ph_mult(G.GAME.hands[may.favhand()]):mul(4)
		G.GAME.hands[may.favhand()].chips = G.GAME.hands[may.favhand()].chips + may.get_all_ph_chips(G.GAME.hands[may.favhand()]):mul(4)
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end }))				
		may.hc('+'..number_format(may.get_all_ph_mult(may.favhand()):mul(4)), true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))				
		may.hm('+'..number_format(may.get_all_ph_chips(may.favhand()):mul(4)), true)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.hands[may.favhand()].mult = G.GAME.hands[may.favhand()].mult + (may.get_all_ph_mult(G.GAME.hands[may.favhand()]):mul(4):mul(number))
		G.GAME.hands[may.favhand()].chips = G.GAME.hands[may.favhand()].chips + (may.get_all_ph_chips(G.GAME.hands[may.favhand()]):mul(4):mul(number))
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('chips'..math.random(1, 2))
			card:juice_up(1, 1)
		return true end }))				
		may.hc('+'..number_format(may.get_all_ph_mult(may.favhand()):mul(4):mul(number)), true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))	
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('multhit1')
			card:juice_up(1, 1)
		return true end }))				
		may.hm('+'..number_format(may.get_all_ph_mult(may.favhand()):mul(4):mul(number)), true)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
			may.ch()
		end
		may.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end 
}

SMODS.Consumable {
	set = 'Planet',
	key = 'quac_n7',
	pos = {x = 2, y = 1 },
	soul_pos = {x = 3, y = 1 },
	atlas = 'legendaryplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Former Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Legendary', G.C.RARITY[4], nil, 1.2)
	end,
	cost = 30,
	planet_rarity = 3,
	endless = true,
	loc_txt = {
		name = 'QUAC-N7',
		text = {
			"Set the {C:planet}level{} of {C:attention}every other{} {C:purple}Poker Hand{}",
			"to {C:attention}triple{} the {C:planet}level{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}#1#, will set level of Poker Hands to #2#{}",
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { localize(may.favhand(), 'poker_hands'), number_format(G.GAME.hands[may.favhand()].level:mul(3)) } }
	end,
	use = function(self, card)
		may.set_all_hand_levels(card, false, G.GAME.hands[may.favhand()].level * 3, may.favhand())
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				if k ~= may.favhand() then 
					Engulf.EditionHand(card, k, card.edition, 1, true)
					may.ch()
				end
			end
		end
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		may.set_all_hand_levels(card, false, G.GAME.hands[may.favhand()].level * 3, may.favhand())
		local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_quac_n7', 'may_quac_n7')
		card2:add_to_deck()
		G.consumeables:emplace(card2)
		card2:setQty(number - 1)
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				if k ~= may.favhand() then 
					Engulf.EditionHand(card, k, card.edition, 1, true)
					may.ch()
				end
			end
		end
	end,]] 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
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
	endless = true,
	loc_txt = {
		name = 'Opolisis',
		text = {
			"Set the {C:planet}level{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"to {C:attention}quintuple{} the combined {C:planet}level{} of {C:attention}all other{} {C:purple}Poker Hands{}",
			"{C:inactive}Will set level of #1# to #2#{}",
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		local level = 0
		for k, v in pairs(G.GAME.hands) do
			if k ~= may.favhand() then
			    level = level + v.level
			end
		end
		level = level * 5
		return { vars = { localize(may.favhand(), 'poker_hands'), number_format(level) } }
	end,
	use = function(self, card)
		local level = 0
		for k, v in pairs(G.GAME.hands) do
			if k ~= may.favhand() then
			    level = level + v.level
			end
		end
		level = level * 5
		may.set_hand_level(card, may.favhand(), false, level)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		may.set_hand_level(card, may.favhand(), false, may.get_all_ph_level(may.favhand()) * 5 )
		local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_opolisis', 'may_opolisis')
		card2:add_to_deck()
		G.consumeables:emplace(card2)
		card2:setQty(number - 1)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,]] 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
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
	endless = true,
	loc_txt = {
		name = 'EN-7B',
		text = {
			"{C:attention}Balance{} the {C:planet}level{}, {C:may_ethereal}Level{} {C:mult}Mult{}, {C:may_ethereal}Level{} {C:chips}Chips{},",
			"{C:mult}Mult{} and {C:chips}Chips{} of {C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will set values of #1# to #2#{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.rare_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		return { vars = { localize(may.favhand(), 'poker_hands'), (G.GAME.hands[may.favhand()].level + G.GAME.hands[may.favhand()].l_mult + G.GAME.hands[may.favhand()].l_chips + G.GAME.hands[may.favhand()].mult + G.GAME.hands[may.favhand()].chips) / 5 } }
	end,
	use = function(self, card)
		local balanced = (G.GAME.hands[may.favhand()].level + G.GAME.hands[may.favhand()].l_mult + G.GAME.hands[may.favhand()].l_chips + G.GAME.hands[may.favhand()].mult + G.GAME.hands[may.favhand()].chips) / 5
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eq_level')
		return true end}))
		may.hlv(balanced)
		G.GAME.hands[may.favhand()].level = balanced
		may.hand_mod_lvl_multchips(may.favhand(), 'mult', -1, balanced - G.GAME.hands[may.favhand()].l_mult)
		may.hand_mod_lvl_multchips(may.favhand(), 'chips', -1, balanced - G.GAME.hands[may.favhand()].l_chips)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		may.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		G.GAME.hands[may.favhand()].chips = balanced
		may.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqmult')
		return true end}))
		G.GAME.hands[may.favhand()].mult = balanced
		may.hm('='..balanced, true)
		delay(1.3)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
	end,
	--[[bulk_use = function(self, card, area, copier, number)
		local balanced
		for i=1, number, 1 do
			balanced = (G.GAME.hands[may.favhand()].level + G.GAME.hands[may.favhand()].l_mult + G.GAME.hands[may.favhand()].l_chips + G.GAME.hands[may.favhand()].mult + G.GAME.hands[may.favhand()].chips) / 5
			 if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1, true)
			end 
		end
		may.th(may.favhand())
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eq_level')
		return true end}))
		may.hlv(balanced)
		G.GAME.hands[may.favhand()].level = balanced
		may.hand_mod_lvl_multchips(may.favhand(), 'mult', -1, balanced - G.GAME.hands[may.favhand()].l_mult)
		may.hand_mod_lvl_multchips(may.favhand(), 'chips', -1, balanced - G.GAME.hands[may.favhand()].l_chips)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		may.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqchip')
		return true end}))
		G.GAME.hands[may.favhand()].chips = balanced
		may.hc('='..balanced, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('may_eqmult')
		return true end}))
		G.GAME.hands[may.favhand()].mult = balanced
		may.hm('='..balanced, true)
		delay(1.3) 
		may.ch()
	end,]]
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
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
	endless = true,
	loc_txt = {
		name = 'Amadeus',
		text = {
			"{C:attention}Quintuple{} the {C:planet}level{} of {C:attention}every{} {C:purple}Poker Hand{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.mythic_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		may.level_up_all_hands_hyper(card, false, 5, 0)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.level_up_all_hands_hyper(card, false, 5 ^ number, 0)
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'eryndra',
	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	endless = true,
	loc_txt = {
		name = 'Eryndra',
		text = {
			"{X:purple,C:white}^5{} {C:may_ethereal}Level{} Mult & Chips of",
			"{C:attention}most played{} {C:purple}Poker Hand{}",
			"{C:inactive}Will upgrade #1#{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.mythic_planet_rate,
	soul_set = "Planet",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		return { vars = { localize(may.favhand(), 'poker_hands') } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		may.hand_mod_lvl_multchips(may.favhand(), 'multchips', 1, 5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_lvl_multchips(may.favhand(), 'multchips', 1, to_big(5):arrow(2, number))
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
			may.ch()
		end
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'gaea',
	pos = {x = 2, y = 0 },
	soul_pos = {x = 3, y = 0 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Giga Planet', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	endless = true,
	loc_txt = {
		name = 'Gaea',
		text = {
			"{X:purple,C:white}^10{} Mult & Chips of {C:attention}every{} {C:purple}Poker Hand{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.mythic_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(1, 10)
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(1, 10)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		may.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_echip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4
		return true end }))
		may.hc('^10', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1
		return true end }))
		may.hm('^10', true)
		may.ch()
		delay(0.5)
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do
			G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(1, to_big(10):arrow(2, number))
			G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(1, to_big(10):arrow(2, number))
			if Engulf and card.edition then 
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		may.hn("All Hands")
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_echip')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1.4
		return true end }))
		may.hc('^'..10*number, true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('talisman_emult')
			card:juice_up(1, 1)
			G.ROOM.jiggle = G.ROOM.jiggle + 1
		return true end }))
		may.hm('^'..10*number, true)
		may.ch()
		delay(0.5)
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'matakka',
	pos = {x = 0, y = 1 },
	soul_pos = {x = 1, y = 1 },
	atlas = 'mythicplanet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Planet System', get_type_colour(self or card.config, card), nil, 1.2)
		badges[2] = create_badge('Mythic', G.C.FILTER, nil, 1.2)
	end,
	cost = 80,
	planet_rarity = 4,
	endless = true,
	ignore_allplanets = true,
	loc_txt = {
		name = 'Matakka',
		text = {
			"Creates {C:attention}5 random{} {C:dark_edition}Negative{} {X:mult,C:white}Rare{}",
			"{C:planet}Planet Cards{} and {C:attention}2{} {X:legendary,C:white}Legendary{} {C:planet}Planet Cards{}",
			"{C:inactive}Requires room{}"
		}
	},
	no_grc = true,
	hidden = true,
	soul_rate = may.mythic_planet_rate,
	soul_set = "Planet",
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_matakka", set = "Other" } 
		end
		return {}
	end, 
	use = function(self, card)
		for i=1, 5, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_matakka')), 'may_matakka')
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
		for i=1, 2, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_matakka')), 'may_matakka')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, 5*number, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_matakka')), 'may_matakka')
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
		for i=1, 2*number, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_matakka')), 'may_matakka')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
					if Engulf and card.edition then
						card2:set_edition(card.edition.key)
					end
				end
			return true end}))
		end
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}