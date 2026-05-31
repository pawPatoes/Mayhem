 -- Ascended consumables
 
AllowBulkUse('ascendedplanets')
AllowBulkUse('ascendedyottas')

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
		return may.canuse() and G.GAME.last_tarot_planet
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
			if Overflow then
				if card:getQty() then
					new:setQty(card:getQty()*5)
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
		return may.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse()
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
				new:set_edition({negative = true}, true)
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
		return may.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse()
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
	key = 'heirophant_asc',
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
		return may.canuse() and #G.hand.highlighted <= (10 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse() and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
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
		return may.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		may.hypermoney(0, 2, false)
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
		return may.canuse() and card.ability.extra.has_targets
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
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (to_number(G.GAME.hands['High Card'].level) or 1) } }
	end,
	use = function(self, card)
		local hand = 'High Card'
		may.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 2)
		delay(0.5)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand = 'High Card'
		may.th(hand)
		may.level_up_hand_hyper(card, hand, nil, 2*number)
		delay(0.5)
		may.ch()
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
		return may.canuse()
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
			"{X:purple,C:white}^^^3{} Mult & Chips"
		}
	},
	config = { amount = 3 },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('multchips', 3, self.config.amount, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('multchips', 2, self.config.amount*number, false, card)
	end,
}

SMODS.Consumable {
	key = 'cupiditas_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Cupiditas",
		text = {
			{
				"{X:money,C:white}^^1.2${}",
			},
			{
				"{C:inactive,E:1}art by Violet{}"
			}
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		may.hypermoney(2, 1.2, false)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hypermoney(2, 1.2*number, false)
	end,
}

SMODS.Consumable {
	key = 'potestas_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Potestas",
		text = {
			{
				"Increase {C:dark_edition}Score Operator{} level",
				"by {C:attention}2{}"
			},
			{
				"{C:inactive,E:1}art by Violet{}"
			}
		}
	},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	misc_badge = may_wip_badge,
	atlas = 'ascyotta',
	cost = 5000,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	misc_badge = may_wip_badge,
	use = function(self, card, area, copier)
		change_operator(G.GAME.hyper_operator or 2)
	end,
	bulk_use = function(self, card, area, copier, number)
		change_operator((G.GAME.hyper_operator or 2)*number)
	end,
}

SMODS.Consumable {
	key = 'speculum_asc',
	set = 'ascendedyottas',
	loc_txt = {
		name = "Ascended Speculum",
		text = {
			"Create {C:attention}15{} {C:dark_edition}Negative{} {C:attention}copies{} of",
			"{C:attention}every unique Consumable{} in your possesion",
			"{C:inactive}Speculum excluded{}"
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
		return may.canuse()
	end,
	discovered = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			local consumables = {}
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().key ~= 'c_may_speculum' then
					table.insert(consumables, {v:gc().key, v:gc().set})
				end
			end
			for k, v in pairs(consumables) do
				for i=1, 15, 1 do
					local card2 = create_card(v[2], G.consumeables, nil, nil, nil, nil, v[1], 'may_speculum')
					card2:start_materialize()
					card2:set_edition({negative = true}, true)
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				end
			end
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			local consumables = {}
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().key ~= 'c_may_speculum' then
					table.insert(consumables, {v:gc().key, v:gc().set})
				end
			end
			for k, v in pairs(consumables) do
				for i=1, 15*number, 1 do
					local card2 = create_card(v[2], G.consumeables, nil, nil, nil, nil, v[1], 'may_speculum')
					card2:start_materialize()
					card2:set_edition({negative = true}, true)
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				end
			end
		return true end}))
	end,
}

end