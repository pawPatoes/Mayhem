-- Planet cards

SMODS.Consumable {
	set = 'Planet',
	key = 'proxima_centauri',
	config = { hand_type = 'may_Royal Flush' },
	pos = { x = 4, y = 0 },
	atlas = 'planet',
	attributes = {
		'hand_specific'
	}, 
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
	key = 'deimos',
	config = { hand_type = 'may_Bulwark' },
	pos = { x = 2, y = 1 },
	atlas = 'planet',
	attributes = {
		'hand_specific'
	}, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Martian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	process_loc_text = function(self)
		local target_text = G.localization.descriptions[self.set]['c_mercury'].text
		SMODS.Consumable.process_loc_text(self)
		G.localization.descriptions[self.set][self.key].text = target_text
	end,
	generate_ui = 0,
	loc_txt = {
		['en-us'] = {
			name = 'Deimos'
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
	no_ring_display = true,
	loc_txt = {
		name = 'Sun',
		text = {
			"Create {C:attention}#1#{} random", 
			"{C:planet}Planet Cards{}", 
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
	no_ring_display = true, 
	loc_txt = {
		name = 'Dysnomia', 
		text = {
			"Create #1# {C:attention}copy{} of", 
			"the {C:attention}last{} {C:planet}Planet Card{}", 
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
					if G.consumeables.config.card_limit > #G.consumeables.cards and (G.GAME.last_planet or 'c_may_dysnomia') ~= 'c_may_dysnomia' then
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
	no_ring_display = true,
	loc_txt = {
		name = 'Charon',
		text = {
			"Add the {C:attention}Nominal Chips{} of all {C:attention}cards{}",
			"{C:attention}held in hand{} to the {C:chips}Chips{} of",
			"all {C:purple}Poker Hands{}",
			"{C:inactive}Currently #1# Chips{}"
		}
	},
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		local amt = 0
		if G.hand and G.hand.cards then 
			for k, v in pairs(G.hand.cards) do 
				amt = amt + v:may_get_nominal_chips()
			end
		end
		return { vars = { amt } }
	end,
	use = function(self, card)
		local amount = 0
		for k, v in pairs(G.hand.cards) do
			if v:may_get_nominal_chips() then
				amount = amount + v:may_get_nominal_chips()
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = (v:may_get_nominal_chips() > 0 and '+' or '-')..number_format(math.abs(v:may_get_nominal_chips())), colour = G.C.CHIPS, delay = 0.1, sound = 'chips1'})
				G.E_MANAGER:add_event(Event({func = function()
					v:juice_up(0.3, 0.4)
				return true end}))
			end
		end
		may.a((amount > 0 and '+' or '-')..number_format(math.abs(amount)), 2, 1.5, G.C.CHIPS, 'may_positive')
		may.hand_multchips_all(card, nil, false, {-1, amount})
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
		delay(0.2)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		for k, v in pairs(G.hand.cards) do
			if v:may_get_nominal_chips() then
				amount = amount + v:may_get_nominal_chips()
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = (v:may_get_nominal_chips() > 0 and '+' or '-')..math.abs(v:may_get_nominal_chips()), colour = G.C.CHIPS, delay = 0.1, sound = 'chips1'})
				G.E_MANAGER:add_event(Event({func = function()
					v:juice_up(0.3, 0.4)
				return true end}))
			end
		end
		may.a((amount > 0 and '+' or '-')..math.abs(number_format(amount)), 2, 1.5, G.C.CHIPS, 'may_positive')
		may.hand_multchips_all(card, nil, false, {-1, amount * number})
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, number, true)
			end
		end
		delay(0.2)
		may.ch()
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'hydra',
	pos = { x = 3, y = 1 },
	atlas = 'planet',
	config = { extra = { planets = 3 } },
	no_ring_display = true, 
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
			"{C:inactive}#1#{}",
		}
	},
	ignore_allplanets = true,
	endless = true,
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
		SMODS.calculate_context({ playing_card_added = true, cards = created })
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
		SMODS.calculate_context({ playing_card_added = true, cards = created })
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and may.planethand(may.favhand()), {allow_duplicates = false}
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'xiangliu',
	pos = { x = 2, y = 3 },
	atlas = 'planet',
	config = { extra = { levels = 3 } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Gonggongan Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Xiangliu',
		text = {
			"{C:planet}Levels up{} the {C:green}discovered{} {C:purple}Poker Hand{}", 
			"with the {C:mult}lowest{} level by {C:attention}#1#{}", 
			"{C:inactive}Will level up #2#{}", 
			"{C:inactive,s:0.7}Prioritizes lower scoring hands{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		local hand = 'High Card'
		local lowest_level = 'n/a'
		for _, v in ipairs(G.handlist) do
			if (type(lowest_level) == 'string' or G.GAME.hands[v].level <= lowest_level) and SMODS.is_poker_hand_visible(v) then
				hand = v
				lowest_level = G.GAME.hands[v].level
			end
		end
		return { vars = { card.ability.extra.levels, localize(hand, 'poker_hands') } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		local lowest_level = 'n/a'
		for _, v in ipairs(G.handlist) do
			if (type(lowest_level) == 'string' or G.GAME.hands[v].level <= lowest_level) and SMODS.is_poker_hand_visible(v) then
				hand = v
				lowest_level = G.GAME.hands[v].level
			end
		end
		may.th(hand)
		level_up_hand(card, hand, false, card.ability.extra.levels)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, number do 
			local hand = 'High Card'
			local lowest_level = 'n/a'
			for _, v in ipairs(G.handlist) do
				if (type(lowest_level) == 'string' or G.GAME.hands[v].level <= lowest_level) and SMODS.is_poker_hand_visible(v) then
					hand = v
					lowest_level = G.GAME.hands[v].level
				end
			end
			level_up_hand(card, hand, true, card.ability.extra.levels)
		end
		may.h('Lowest Level Hands', '...', '...', '')
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
		may.hlv('+?', true)
		delay(1.3)
		may.ch()
	end
}


SMODS.Consumable {
	set = 'Planet',
	key = 'haumea',
	pos = { x = 4, y = 1 },
	config = { extra = { mul = 2 } },
	atlas = 'planet',
	no_ring_display = true, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Haumea',
		text = {
			"Gain {X:green,C:white}X#1#{} the {C:money}Dollars{} of a",
			"random {C:purple}Poker Hand{}",
			"as {C:money}Money"
		}
	},
	can_use = function(self, card)
		return may.canuse() and G.GAME.round_resets.ante ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'hand_dollars')
		return { vars = { card.ability.extra.mul } }
	end,
	use = function(self, card)
		local hand = may.rndhand()
		may.th(hand)
		if G.GAME.hands[hand].dollars then
			ease_dollars(G.GAME.hands[hand].dollars * card.ability.extra.mul)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('timpani')
				card:juice_up(0.3, 0.5)
			return true end}))
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Planet,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                    silent = true
                })
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end}))
		end
		may.ch()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, hand, card.edition, 1)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, number, 1 do
			amount = 0
			local hand = may.rndhand()
			if G.GAME.hands[hand].dollars then
				amount = amount + (G.GAME.hands[hand].dollars * card.ability.extra.mul)
			end
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1)
				may.ch()
			end 
		end
		if amount > 0 then
			may.a('+'..math.abs(number_format(amount))..' Dollars', 2, 1.5, G.C.MONEY, 'may_positive')
			ease_dollars(amount)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('timpani')
				card:juice_up(0.3, 0.5)
			return true end}))
			may.ch()
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Planet,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                    silent = true
                })
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end}))
		end
	end,
}

--[[SMODS.Consumable {
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
	end,
	in_pool = function(self, args)
		return to_big(G.GAME.hands[may.favhand()].level) >= to_big(7) and G.GAME.may_endless_mode, {allow_duplicates = false}
	end
}]]

SMODS.Consumable {
	set = 'Planet',
	key = 'namaka',
	pos = { x = 2, y = 2 },
	config = { extra = { odds = 3, dollars = 0.25 } },
	atlas = 'planet',
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Haumean Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	no_ring_display = true, 
	loc_txt = {
		name = 'Namaka',
		text = {
			"Each {C:green}discovered{} {C:purple}Poker Hand{} has a", 
			"{C:green}#1# in #2#{} chance to gain", 
			"{C:money}+#3#{} Dollars",
		}
	},
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Namaka")
		return { vars = { normal, odds, card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		local hands = {}
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) and SMODS.pseudorandom_probability(card, "may_namaka", 1, card.ability.extra.odds, "Namaka") then
				table.insert(hands, k)
			end
		end
		if #hands > 0 then
			for k, v in pairs(hands) do
				may.hand_mod_dollars(card, v, true, -1, card.ability.extra.dollars)
				if may.conf.hand_speed < 3 then
					may.th(v)
				end
				if Engulf and card.edition then 
					Engulf.EditionHand(card, v, card.edition, 1, may.conf.hand_speed < 3)
				end
			end 
			if may.conf.hand_speed < 3 then
				may.h('Random Hands', '...', '---', '...')
				G.GAME.may_override_monitor_colors = true
				may.cosmetic_score_operator('', {0, 0, 0, 0})
				G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
					ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					G.TAROT_INTERRUPT_PULSE = true
					play_sound('coin3')
					card:juice_up(0.8, 0.5)
				return true end}))
				may.hc('+'..card.ability.extra.dollars, true)
				delay(0.2)
				may.hc('...', false)
				delay(1.3)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.1)
					G.GAME.may_override_monitor_colors = nil
				return true end}))
				G.E_MANAGER:add_event(Event({func = function()
					G.TAROT_INTERRUPT_PULSE = nil
				return true end}))
				may.refresh_score_operator()
				may.ch()
			end
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				attention_text({
					text = localize('k_nope_ex'),
					scale = 1.3,
					hold = 1.4,
					major = card,
					backdrop_colour = G.C.SECONDARY_SET.Planet,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
					offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
					silent = true
				})
				G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
					play_sound('tarot2', 0.76, 0.4)
				return true end}))
				play_sound('tarot2', 1, 0.4)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local hands = {}
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) then
				table.insert(hands, {k, 0})
			end
		end
		for k, v in pairs(hands) do
			for i = 1, number do
				if SMODS.pseudorandom_probability(card, "may_namaka", 1, card.ability.extra.odds, "Namaka") then
					v[2] = v[2] + 1
				end
			end
		end
		local to_exclude = {}
		for k, v in pairs(hands) do
			if v[2] == 0 then
				table.insert(to_exclude, v)
			end
		end
		for k, v in pairs(to_exclude) do
			for k2, v2 in pairs(hands) do
				if v == v2 then
					table.remove(hands, k2)
				end
			end
		end
		if #hands > 0 then
			for k, v in pairs(hands) do
				may.hand_mod_dollars(card, v[1], true, -1, card.ability.extra.dollars * v[2])
				if may.conf.hand_speed < 3 then
					may.th(v[1])
					may.hlv('X'..v[2])
					delay(0.2)
				end
				if Engulf and card.edition then 
					Engulf.EditionHand(card, v[1], card.edition, v[2], may.conf.hand_speed < 3)
				end
			end 
			if may.conf.hand_speed < 3 then
				may.h('Random Hands', '...', '---', '...')
				G.GAME.may_override_monitor_colors = true
				may.cosmetic_score_operator('', {0, 0, 0, 0})
				G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
					ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					G.TAROT_INTERRUPT_PULSE = true
					play_sound('coin3')
					card:juice_up(0.8, 0.5)
				return true end}))
				may.hc('+...', true)
				delay(0.2)
				may.hc('...', false)
				delay(1.3)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.1)
					G.GAME.may_override_monitor_colors = nil
				return true end}))
				G.E_MANAGER:add_event(Event({func = function()
					G.TAROT_INTERRUPT_PULSE = nil
				return true end}))
				may.refresh_score_operator()
				may.ch()
			end
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				attention_text({
					text = localize('k_nope_ex'),
					scale = 1.3,
					hold = 1.4,
					major = card,
					backdrop_colour = G.C.SECONDARY_SET.Planet,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
					offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
					silent = true
				})
				G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
					play_sound('tarot2', 0.76, 0.4)
				return true end}))
				play_sound('tarot2', 1, 0.4)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'pallas',
	pos = { x = 4, y = 2 },
	atlas = 'planet',
	cost = 3,
	loc_txt = {
		name = 'Pallas',
		text = {
			"{C:planet}Level up{} {C:attention}3{} random", 
			"{C:purple}Poker Hands{}", 
			"{C:inactive,s:0.7}One hand may be selected multiple times{}"
		} 
	},
	immutable = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card)
		for i = 1, 3 do 
			level_up_hand(card, may.rndhand(), false, 1)
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, 3 * number do 
			level_up_hand(card, may.rndhand(), number > 4, 1)
		end
		if number > 4 then 
			may.h('Random Hands', '...', '...', '')
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
			may.hlv('+1', true)
			delay(1.3)
			may.ch()
		end
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'varda',
	pos = { x = 5, y = 4 },
	atlas = 'planet',
	cost = 3,
	loc_txt = {
		name = 'Varda',
		text = {
			"{C:mult}Destroys{} a selected {C:dark_edition}modified{} {C:attention}playing card{}",
			"in exchange for {C:planet}Planet Cards{}",
			may.pager(),
			"Base of {C:mult}0{} {C:planet}Planets{}, additional {C:planet}Planets{}",
			"given based on the {C:attention}rarity{}",
			"of its {C:dark_edition}Enhancement{}, {C:dark_edition}Edition{} and/or {C:dark_edition}Seal{}",
			"Increases {C:dark_edition}exponentially{} if card is",
			"{C:green}heavily{} {C:dark_edition}modified{}",
			may.pager(),
			"{C:inactive}Currently #1# Planet Cards{}",
			"{C:inactive}Does not require room{}",
		} 
	},
	immutable = true,
	reserve = true, 
	endless = true, 
	can_use = function(self, card)
		for k, v in pairs(G.hand.highlighted) do
			if v ~= card then
				return may.canuse() and #G.hand.highlighted <= (card.area == G.hand and 2 or 1) and may.varda_amount(v) > 0
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_varda", set = "Other" } 
		end 
		local selected
		if G.hand then
			for k, v in pairs(G.hand.highlighted) do
				if v ~= card then
					selected = v
					break
				end
			end
		end
		return { vars = { (selected and #G.hand.highlighted <= (card.area == G.hand and 2 or 1)) and may.varda_amount(selected) or 'NaN' } }
	end,
	use = function(self, card)
		local selected
		for k, v in pairs(G.hand.highlighted) do
			if v ~= card then
				selected = v
				break
			end
		end
		local amount = may.varda_amount(selected)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('card3')
			card:juice_up(0.3, 0.5)
			selected:juice_up(0.3, 0.5)
		return true end}))
		SMODS.destroy_cards(selected)
		for i = 1, amount do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
				local card2 = SMODS.add_card({ set = 'Planet' })
				card2:juice_up(0.3, 0.5)
				play_sound('timpani')
				card:juice_up(0.3, 0.5)
				if Engulf and card.edition then 
					card2:set_edition(card.edition.key)
				end
			return true end}))
		end
	end,
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'parthenope',
	pos = { x = 3, y = 0 },
	config = { extra = { amount = 1.05 } },
	atlas = 'planet',
	cost = 3,
	no_ring_display = true,
	loc_txt = {
		name = 'Parthenope',
		text = {
			"{X:purple,C:white}X#1#{} Chips & Mult", 
			"of all {C:purple}Poker Hands{}", 
			may.pager(50),
			"If {C:planet}Astronomy{} {C:green}V{} is redeemed,", 
			"gives "..may.hyp(4, "multchips", "#2##4#").." Chips & Mult instead", 
			"{C:inactive}G = #3#{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		--info_queue[#info_queue + 1] = G.P_CENTERS.v_may_astronomy_5
		may.tut_tip(info_queue, 'global_op')
		return { vars = { card.ability.extra.amount, '{G}', may.global_op(), card.ability.extra.amount * 1.5 } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card)
		may.hand_multchips_all(card, nil, false, {may.has_card('v_may_astronomy_5') and may.global_op() or 0, card.ability.extra.amount * (may.has_card('v_may_astronomy_5') and 1.5 or 1)}, {may.has_card('v_may_astronomy_5') and may.global_op() or 0, card.ability.extra.amount * (may.has_card('v_may_astronomy_5') and 1.5 or 1)})
		may.ch()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
	end, 
	bulk_use = function(self, card, area, copier, number)
		may.hand_multchips_all(card, nil, false, {may.has_card('v_may_astronomy_5') and may.global_op() or 0, card.ability.extra.amount * (may.has_card('v_may_astronomy_5') and 1.5 or 1), number}, {may.has_card('v_may_astronomy_5') and may.global_op() or 0, card.ability.extra.amount * (may.has_card('v_may_astronomy_5') and 1.5 or 1), number})
		may.ch()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, number, true)
			end
		end
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'hiiaka',
	pos = { x = 4, y = 4 },
	atlas = 'planet',
	config = { extra = { Xchips = 0.25 } },
	ignore_allplanets = true,
	no_ring_display = true, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Haumean Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Hi\'iaka',
		text = {
			"{C:mult}Destroy{} all {C:attention}Suitless{} or {C:attention}Rankless{} cards in {C:attention}full deck{}",
			"{X:chips,C:white}+X#1#{} Chips {C:attention}per{} destroyed {C:attention}card{} to",
			"all {C:purple}Poker Hands{}",
			"{C:inactive}Currently X#2# Chips{}",
		}
	},
	can_use = function(self, card)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then
				return may.canuse()
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		local amount = 0
		for k, v in pairs(G.playing_cards or {}) do	
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then
				amount = amount + 1
			end
		end
		return { vars = { card.ability.extra.Xchips, 1 + (card.ability.extra.Xchips * amount), } }
	end,
	use = function(self, card)
		local found = {}
		local destroy = not (may.has_card('j_may_cement_joker') or may.has_card('j_may_eternity_stone') or may.has_card('j_may_rock_of_paramountcy') or may.has_card('j_may_zodium_calamitas'))
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then
				if destroy then
					draw_card(v.area, G.consumeables, 100, 'up', false, v)
				end
				table.insert(found, v)
			end
		end
		local amount = #found
		delay(0.5)
		if destroy then 
			for k, v in pairs(found) do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('card3')
					v:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
				return true end}))
				SMODS.destroy_cards(v)
			end
		end
		may.hand_multchips_all(card, nil, false, {0, 1 + (amount * card.ability.extra.Xchips)})
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
		may.ch()
	end,
	in_pool = function(self, args)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then
				return true, {allow_duplicates = false}
			end
		end
		return false, {allow_duplicates = false}
	end
}

--[[SMODS.Consumable {
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
			if to_big(G.GAME.hands[hand2].level) > to_big(1) then
				level_up_hand(card, hand2, true, card.ability.extra.other)
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
}]]

SMODS.Consumable {
	set = 'Planet',
	key = 'gersemi',
	config = { extra = { planets = 1 } },
	pos = { x = 5, y = 0 },
	atlas = 'planet',
	reserve = true,
	ignore_allplanets = true,
	may_persist_after_use = true,
	no_ring_display = true, 
	loc_txt = {
		name = 'Gersemi',
		text = {
			"Use to {C:mult}destroy{} selected {C:planet}Planet Cards{},", 
			"after which this card will {C:green}allow{} you", 
			"to apply {C:attention}random{} {C:dark_edition}Seals{} to selected cards", 
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
		if Engulf and card.edition then
			info_queue[#info_queue + 1] = { key = "may_enf_gersemi", set = "Other" } 
		end
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
	no_ring_display = true, 
	soul_rate = 0,
	loc_txt = {
		name = 'Gersemi {C:green}(Active){}',
		text = {
			"Apply {C:attention}random{} {C:dark_edition}Seals{} to", 
			"{C:attention}#1#{} selected cards in hand"
		}
	},
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.extra.targets + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		if Engulf and card.edition then
			info_queue[#info_queue + 1] = { key = "may_enf_gersemi", set = "Other" } 
		end
		return { vars = { card.ability.extra.targets } }
	end,
	use = function(self, card)
		local targets = {}
		for k, v in pairs(G.hand.highlighted) do
			if v ~= card then 
				table.insert(targets, v)
			end 
		end
		for i=1, #targets do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
				if Engulf and card.edition then
					targets[i]:set_edition(card.edition.key)
				end
				targets[i]:set_seal(SMODS.poll_seal({guaranteed = true}))
				play_sound('tarot1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.hand:unhighlight_all()
		return true end}))
	end,
}

--[[SMODS.Consumable {
	set = 'Planet',
	key = 'mangas',
	pos = { x = 1, y = 0 },
	atlas = 'planet',
	no_ring_display = true, 
	loc_txt = {
		name = 'Mangas',
		text = {
			"Gain the {C:attention}number{} of times", 
			"a random {C:purple}Poker Hand{} was played", 
			"this run {C:green}+ 1{} as {C:money}money{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card)
		local hand = may.rndhand()
		may.th(hand)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('timpani')
			card:juice_up(0.3, 0.5)
		return true end}))
		ease_dollars(G.GAME.hands[hand].played + 1)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, hand, card.edition, 1)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local total = 0
		for i=1, number, 1 do
			local hand = may.rndhand(hand)
			total = total + (G.GAME.hands[hand].played + 1)
			if Engulf and card.edition then 
				Engulf.EditionHand(card, hand, card.edition, 1, true)
			end
		end
		may.h('Random Hands', '...', '...', '')
		may.hlv('TOTAL '..total)
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('timpani')
			card:juice_up(0.3, 0.5)
		return true end}))
		ease_dollars(total)
		may.ch()
	end
}]] 

SMODS.Consumable {
	set = 'Planet',
	key = 'deucalion',
	loc_txt = {
		name = 'Deucalion',
		text = {
			"{X:purple,C:white}X#1#{} {C:may_demiurgic}Level{} Chips & Mult", 
			"of all {C:purple}Poker Hands{}"
		}
	},
	pos = { x = 0, y = 3 },
	atlas = 'planet',
	config = { extra = { amount = 1.1 } },
	unlocked = true,
	discovered = true,
	no_ring_display = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Dwarf Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'level_multchips')
		return { vars = { card.ability.extra.amount } }
	end,
	use = function(self, card, area, copier)
		may.hand_lvl_multchips_all(card, false, {0, card.ability.extra.amount}, {0, card.ability.extra.amount})
		may.ch()
		may.refresh_score_operator()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
	end, 
	bulk_use = function(self, card, area, copier, number)
		may.hand_lvl_multchips_all(card, false, {0, card.ability.extra.amount ^ number}, {0, card.ability.extra.amount ^ number})
		may.ch()
		may.refresh_score_operator()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, number, true)
			end
		end
	end, 
}

SMODS.Consumable {
	set = 'Planet',
	key = 'callisto',
	loc_txt = {
		name = 'Callisto',
		text = {
			"{X:purple,C:white}X#1#{} {C:may_demiurgic}Level{} Chips & Mult", 
			"of most played {C:purple}Poker Hand{}", 
			"{C:inactive}#2#{}"
		}
	},
	pos = { x = 6, y = 0 },
	atlas = 'planet',
	config = { extra = { amount = 1.15 } },
	unlocked = true,
	discovered = true,
	no_ring_display = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Jovian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'level_multchips')
		return { vars = { card.ability.extra.amount, localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card, area, copier)
		may.hand_lvl_multchips(card, may.favhand(), false, {0, card.ability.extra.amount}, {0, card.ability.extra.amount})
		if Engulf and card.edition then 
			may.refresh_score_operator()
			Engulf.EditionHand(card, may.favhand(), card.edition, 1, false)
		end 
		may.ch()
		may.refresh_score_operator()
	end, 
	bulk_use = function(self, card, area, copier, number)
		may.hand_lvl_multchips(card, may.favhand(), false, {0, card.ability.extra.amount ^ number}, {0, card.ability.extra.amount ^ number})
		if Engulf and card.edition then 
			may.refresh_score_operator()
			Engulf.EditionHand(card, may.favhand(), card.edition, number, false)
		end
		may.ch()
		may.refresh_score_operator()
	end, 
}

--[[SMODS.Consumable {
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
}]]

SMODS.Consumable {
	set = 'Planet',
	key = 'quac_n7',
	pos = { x = 5, y = 2 },
	atlas = 'planet',
	config = { extra = { amount1 = 2, amount2 = 1 } },
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Former Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	cost = 3,
	endless = true,
	loc_txt = {
		name = 'QUAC-N7',
		text = {
			"{C:mult}Level down{} {C:attention}most played{}", 
			"{C:purple}Poker Hand{} by {C:attention}#1#{}", 
			may.pager(45),
			"{C:planet}Level up{} all {C:attention}other{}", 
			"{C:purple}Poker Hands{} by {C:attention}#2#{}", 
			may.pager(45),
			"{C:inactive}Will level down #3#{}"
		}
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount1, card.ability.extra.amount2, localize(may.favhand(), 'poker_hands') } }
	end,
	use = function(self, card, copier)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), false, -card.ability.extra.amount1)
		may.level_up_all_hands(card, false, card.ability.extra.amount2, may.favhand())
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.th(may.favhand())
		level_up_hand(card, may.favhand(), false, -card.ability.extra.amount1 * number)
		may.level_up_all_hands(card, false, card.ability.extra.amount2 * number, may.favhand())
		may.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
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
			"and {C:green}distribute{} its {C:attention}former{} {C:planet}level{}", 
			"across all other {C:green}discovered{} {C:purple}Poker Hands{}", 
		}
	},
	ignore_allplanets = true,
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
	key = 'vanth',
	pos = { x = 5, y = 3 },
	atlas = 'planet',
	cost = 3,
	config = { extra = { amount = 0.075 } }, 
	loc_txt = {
		name = 'Vanth',
		text = {
			"{C:planet}Levels up{} each {C:purple}Poker Hand{}", 
			"by {C:attention}+#1#{} for every time", 
			"it was {C:attention}played{} this run", 
			"{C:inactive}Max of +3 levels{}"
		} 
	},
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount..'' } }
	end, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Orcian Moon', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card)
		for k, v in pairs(G.GAME.hands) do 
			level_up_hand(card, k, true, math.min(v.played * card.ability.extra.amount, 3))
		end
		if may.conf.hand_speed < 2 then 
			may.h('Played Hands', '...', '...', '')
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
			may.hlv('+?', true)
			delay(1.3)
			may.ch()
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.GAME.hands) do 
			level_up_hand(card, k, true, math.min(v.played * card.ability.extra.amount, 3) * number)
		end
		if may.conf.hand_speed < 2 then 
			may.h('Played Hands', '...', '...', '')
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
			may.hlv('+?', true)
			delay(1.3)
			may.ch()
		end
	end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'moon',
	pos = { x = 1, y = 3 },
	config = { extra = { planets = 3 } },
	atlas = 'planet',
	ignore_allplanets = true,
	no_ring_display = true, 
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
}

	-- Spacecraft

SMODS.Consumable {
	set = 'Planet',
	key = 'satellite',
	pos = { x = 1, y = 4 },
	config = { extra = { planets = 3 } },
	atlas = 'planet',
	ignore_allplanets = true,
	no_ring_display = true, 
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
	attributes = {
		'spacecraft'
	}, 
	use = function(self, card)
		for i = 1, card.ability.extra.planets do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, SMODS.poll_object({ type = 'hand_specific', guaranteed = true }), 'may_satellite')
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
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, SMODS.poll_object({ type = 'hand_specific', guaranteed = true }), 'may_satellite')
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
	no_ring_display = true, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_txt = {
		name = 'Rings of Jupiter',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:mult}+#1#{} {C:may_demiurgic}Level{} Mult and {C:chips}+#2#{} {C:may_demiurgic}Level{} Chips"
		}
	},
	attributes = {
		'ring_system'
	}, 
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
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + 1
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, 1})
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.lev_mult = (G.GAME.may_ring_bonuses.lev_mult or 0) + (card.ability.extra.lev_mult * number)
		G.GAME.may_ring_bonuses.lev_chips = (G.GAME.may_ring_bonuses.lev_chips or 0) + (card.ability.extra.lev_chips * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + number
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, number})
			end
		end
	end
}

SMODS.Consumable {
	set = 'Planet',
	key = 'rings_of_saturn',
	pos = { x = 3, y = 2 },
	atlas = 'planet',
	config = { extra = { score = 1000, dollars = 0.1 } },
	no_ring_display = true, 
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Ring System', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	no_ring_display = true, 
	loc_txt = {
		name = 'Rings of Saturn',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:may_score}+#1#{} Score and {C:money}+#2#{} Dollars"
		}
	},
	attributes = {
		'ring_system'
	},  
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
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + 1
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, 1})
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.score = (G.GAME.may_ring_bonuses.score or 0) + (card.ability.extra.score * number)
		G.GAME.may_ring_bonuses.dollars = (G.GAME.may_ring_bonuses.dollars or 0) + (card.ability.extra.dollars * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + number
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, number})
			end
		end
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
	no_ring_display = true, 
	loc_txt = {
		name = 'Rings of Uranus',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{}", 
			"is {C:planet}leveled up{} by an additional {C:attention}#1#{}"
		}
	},
	attributes = {
		'ring_system'
	}, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.levels, } }
	end,
	use = function(self, card)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.levels = (G.GAME.may_ring_bonuses.levels or 0) + card.ability.extra.levels
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + 1
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, 1})
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.levels = (G.GAME.may_ring_bonuses.levels or 0) + (card.ability.extra.levels * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + number
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, number})
			end
		end
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
	no_ring_display = true, 
	loc_txt = {
		name = 'Rings of Neptune',
		text = {
			"{C:attention}Next{} {C:planet}leveled up{} {C:purple}Poker Hand{} gains", 
			"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips"
		}
	},
	attributes = {
		'ring_system'
	}, 
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
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + 1
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, 1})
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.GAME.may_ring_bonuses = G.GAME.may_ring_bonuses or {}
		G.GAME.may_ring_bonuses.mult = (G.GAME.may_ring_bonuses.mult or 0) + (card.ability.extra.mult * number)
		G.GAME.may_ring_bonuses.chips = (G.GAME.may_ring_bonuses.chips or 0) + (card.ability.extra.chips * number)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Activated!', colour = get_type_colour(self or card.config, card), delay = 0.45})
		if Engulf and card.edition then
			local added
			G.GAME.may_ring_bonuses.editions = G.GAME.may_ring_bonuses.editions or {}
			for k, v in pairs(G.GAME.may_ring_bonuses.editions) do
				if v[1] == card.edition.key then
					v[2] = v[2] + number
					added = true
					break
				end
			end
			if not added then
				table.insert(G.GAME.may_ring_bonuses.editions, {card.edition.key, number})
			end
		end
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
		no_ring_display = true, 
		loc_txt = {
			name = v[2],
			text = {
				{
					"{C:purple,E:2,s:1.2}#1#{}",
					"{X:chips,C:white,E:1}#4#{} {C:inactive,E:2}&{} {X:mult,C:white,E:1}#5#{}"
				},
				{
					"Give {C:attention}#1#{} {C:mult}+#2#{} {C:may_demiurgic}Level{} Mult", 
					"and {C:chips}+#3#{} {C:may_demiurgic}Level{} Chips"
				},
			}
		},
		attributes = {
			'jovian_moon'
		}, 
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
			return { vars = { localize(card.ability.extra.hand, 'poker_hands'), card.ability.extra.lev_mult, card.ability.extra.lev_chips, G.GAME.hands[card.ability.extra.hand].l_chips, G.GAME.hands[card.ability.extra.hand].l_mult } }
		end,
		use = function(self, card)
			may.hand_lvl_multchips(card, card.ability.extra.hand, false, {-1, card.ability.extra.lev_chips}, {-1, card.ability.extra.lev_mult})
			if Engulf and card.edition then 
				may.refresh_score_operator()
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
			end
			may.ch()
			may.refresh_score_operator()
		end,
		bulk_use = function(self, card, area, copier, number)
			may.hand_lvl_multchips(card, card.ability.extra.hand, false, {-1, card.ability.extra.lev_chips * number}, {-1, card.ability.extra.lev_mult * number})
			if Engulf and card.edition then 
				may.refresh_score_operator()
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
			end
			may.ch()
			may.refresh_score_operator()
		end,
		in_pool = function(self, args)
			return G.GAME.hands[v[3]] and to_big(G.GAME.hands[v[3]].level) >= to_big(6) and SMODS.is_poker_hand_visible(v[3]) and G.GAME.hands[v[3]].played >= 1, {allow_duplicates = false}
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
		no_ring_display = true, 
		loc_txt = {
			name = v[2],
			text = {
				{
					"{C:purple,E:2,s:1.2}#1#{}",
					"{X:money,C:white,E:1}#4#{} {C:inactive,E:2}&{} {X:may_score,C:white,E:1}#5#{}"
				}, 
				{
					"Give {C:attention}#1#{} {C:money}+#2#{} Dollars",
					"and {C:may_score}+#3#{} Score"
				},
			}
		},
		attributes = {
			'saturnian_moon'
		}, 
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "may_hand_score_tutorial", set = "Other" }
			info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
			return { vars = { localize(card.ability.extra.hand, 'poker_hands'), card.ability.extra.dollars, card.ability.extra.score, (G.GAME.hands[card.ability.extra.hand].dollars or 0), (G.GAME.hands[card.ability.extra.hand].score or 0) } }
		end,
		use = function(self, card)
			may.hand_mod_score_dollars_composite(card, card.ability.extra.hand, false, {-1, card.ability.extra.score}, {-1, card.ability.extra.dollars})
			if Engulf and card.edition then 
				may.refresh_score_operator()
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
			end
			may.ch()
			may.refresh_score_operator()
		end,
		bulk_use = function(self, card, area, copier, number)
			may.hand_mod_score_dollars_composite(card, card.ability.extra.hand, false, {-1, card.ability.extra.score * number}, {-1, card.ability.extra.dollars * number})
			if Engulf and card.edition then 
				may.refresh_score_operator()
				Engulf.EditionHand(card, card.ability.extra.hand, card.edition, 1)
			end
			may.ch()
			may.refresh_score_operator()
		end,
		in_pool = function(self, args)
			return G.GAME.hands[v[3]] and to_big(G.GAME.hands[v[3]].level) >= to_big(12) and SMODS.is_poker_hand_visible(v[3]) and G.GAME.hands[v[3]].played >= 3 and G.GAME.may_endless_mode, {allow_duplicates = false}
		end
	}
end

-- Rare Planets

--[[SMODS.Consumable {
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
			"{X:purple,C:white}X#1#{} {C:may_demiurgic}Level{} Mult & Chips of {C:attention}most played{}",
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
		may.hand_lvl_multchips(card, may.favhand(), false, {0, card.ability.extra.amount}, {0, card.ability.extra.amount})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_lvl_multchips(card, may.favhand(), false, {0, card.ability.extra.amount ^ number}, {0, card.ability.extra.amount ^ number})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
		end
		may.ch()
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
		may.hand_multchips_all(card, may.favhand(), false, {-1, G.GAME.hands[may.favhand()].chips}, {-1, G.GAME.hands[may.favhand()].mult})
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number, true)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_multchips_all(card, may.favhand(), false, {-1, G.GAME.hands[may.favhand()].chips * number}, {-1, G.GAME.hands[may.favhand()].mult * number})
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number, true)
		end
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
		may.hand_multchips(card, may.favhand(), false, {-1, chips}, {-1, mult})
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local mult = 0
		local chips = 0 
		for i=1, 2 * number, 1 do
			local hand = may.rndhand(may.favhand())
			if i < 10 then
				may.th(hand)
			end
			mult = mult + G.GAME.hands[hand].mult
			chips = chips + G.GAME.hands[hand].chips
			delay(0.3)
		end
		may.hand_multchips(card, may.favhand(), false, {-1, chips}, {-1, mult})
		delay(0.5)
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
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
			"to the {C:chips}Chips{} and {C:may_demiurgic}Level{} {C:chips}Chips{}", 
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
		may.hand_multchips_all(card, nil, false, {-1, amount})
		may.hand_lvl_multchips_all(card, false, {-1, amount})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end 
		end
		may.refresh_score_operator()
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		if G.GAME.blind then
			for k, v in pairs(G.playing_cards) do 
				amount = amount + v:may_get_nominal_chips()
			end 
		end
		may.hand_multchips_all(card, nil, false, {-1, amount * number})
		may.hand_lvl_multchips_all(card, false, {-1, amount * number})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			for k, v in pairs(G.GAME.hands) do
				Engulf.EditionHand(card, k, card.edition, number, true)
			end 
		end
		may.refresh_score_operator()
		may.ch()
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
		may.hand_multchips(card, may.favhand(), false, {-1, may.get_all_ph_chips(G.GAME.hands[may.favhand()]):mul(4)}, {-1, may.get_all_ph_mult(G.GAME.hands[may.favhand()]):mul(4)})
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_multchips(card, may.favhand(), false, {-1, may.get_all_ph_chips(G.GAME.hands[may.favhand()]):mul(4 * number)}, {-1, may.get_all_ph_mult(G.GAME.hands[may.favhand()]):mul(4 * number)})
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, number)
		end
		may.ch()
	end,
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
			"{C:attention}Balance{} the {C:planet}level{}, {C:may_demiurgic}Level{} {C:mult}Mult{}, {C:may_demiurgic}Level{} {C:chips}Chips{},",
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
		may.hand_lvl_multchips(card, may.favhand(), false, {-1, balanced - G.GAME.hands[may.favhand()].l_chips}, {-1, balanced - G.GAME.hands[may.favhand()].l_mult})
		may.refresh_score_operator()
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
			"{X:purple,C:white}^5{} {C:may_demiurgic}Level{} Mult & Chips of",
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
		may.hand_lvl_multchips(card, may.favhand(), false, {1, 5}, {1, 5})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_lvl_multchips(card, may.favhand(), false, {1, 5}, {1, 5})
		may.refresh_score_operator()
		if Engulf and card.edition then 
			Engulf.EditionHand(card, may.favhand(), card.edition, 1)
		end
		may.ch()
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
		may.hand_multchips_all(card, nil, false, {1, 10}, {1, 10})
		for k, v in pairs(G.GAME.hands) do
			if Engulf and card.edition then 
				Engulf.EditionHand(card, k, card.edition, 1, true)
			end
		end
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local factor = math.abs(number) == 1 and 10 or to_big(10) ^ math.abs(number)
		may.hand_multchips_all(card, nil, false, {1, factor}, {1, factor})
		for k, v in pairs(G.GAME.hands) do
			if Engulf and card.edition then 
				Engulf.EditionHand(card, k, card.edition, number, true)
			end
		end
		may.ch()
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
}]]