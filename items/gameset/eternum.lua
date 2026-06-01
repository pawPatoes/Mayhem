-- ETERNUM changes

-- Item Changes
SMODS.Consumable:take_ownership('c_may_shaman', {
	loc_txt = {
		name = 'The Shaman', 
		text = {
			{
				"Create {C:attention}#1# random{}",
				"{C:spectral}Spectral Card{}",
				"{C:inactive}(requires room){}"
			},
			{
				"{C:inactive,E:1}Original idea by _TeKKen_{}"
			}
		}
	}, 
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 ))
	end, 
	config = { extra = { cards = 1 } }, 
	use = function(self, card, copier)
		for i=1, card.ability.extra.cards do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then 
					play_sound('timpani')
					local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_shaman')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end 
	end
})

SMODS.Joker:take_ownership('j_may_daredevil', {
	rarity = 3
})

SMODS.Joker:take_ownership('j_may_hurley', {
	config = { extra = { dollars = 50, odds = 10 } },
	rarity = may.epic_key
})

SMODS.Joker:take_ownership('j_may_3d_joker', {
	config = { extra = { Emult = 1.3 } }, 
})

SMODS.Joker:take_ownership('j_may_nebula', {
	loc_txt = {
		name = 'Nebula',
		text = {
			{
				"When hand is played, {C:attention}before scoring{},",
				"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
				"as {C:mult}+Mult{}",
				"{C:inactive}Currently {C:mult}+#1#{} {C:inactive}Mult{}",
			},
			may.add_fusion_text('Universal Collapse', 'Cosmos', '{C:planet}Level up{} a {C:purple}Poker Hand{} to {C:planet}level{} {C:attention}100{}')
		}
	},
	config = { extra = { mult = 0 } }, 
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
})

SMODS.Joker:take_ownership('j_may_collectors_edition', {
	loc_txt = {
		name = 'Collector\'s Edition',
		text = {
			{
				"{X:mult,C:white}^^#1#{} Mult if",
				"{C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			},
			may.add_fusion_text('Diskus Kollectum', 'Diskus Kollectum Maximus', '{C:attention}Holding{} at least {C:attention}140{} copies of {C:purple}The Wheel of Fortune{}')
		}
	},
	config = { extra = { EEmult = 1.05 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.EEmult } }
	end,
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
})

SMODS.Joker:take_ownership('j_may_cosmos', {
	loc_txt = {
		name = {'Cosmos', "{C:inactive,s:0.5}Universal Collapse + Cosmos{}"},
		text = {
			{
				"When hand is played, {C:attention}before scoring{},",
				"{C:attention}gains half{} of the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^Mult{}",
				"{C:inactive}Currently {X:mult,C:white}^#1#{} Mult{}",
			},
			may.add_fusion_text('Universal Collapse', 'Kepler', '{C:planet}Level up{} a {C:purple}Poker Hand{} to {C:planet}level{} {C:attention}650{}'),
		}
	},
	config = { extra = { Emult = 1 } }, 
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
})

SMODS.Joker:take_ownership('j_may_kepler', {
	loc_txt = {
		name = {'Kepler', "{C:inactive,s:0.5}Cosmos + Universal Collapse{}"},
		text = {
			{
				"When hand is played, {C:attention}before scoring{},",
				"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^^Mult{}",
				"{C:inactive}Currently {X:mult,C:white}^^#1#{} Mult{}",
			},
			may.add_fusion_text('Universal Collapse', 'Kepler\'s Dream', '{C:planet}Level up{} a {C:purple}Poker Hand{} to {C:planet}level{} {C:attention}2000{}'),
		}
	},
	config = { extra = { EEmult = 1 } },
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
			}
		end
		if context.forcetrigger then
			card.ability.extra.EEmult = card.ability.extra.EEmult + (G.GAME.hands[context.scoring_name or 'High Card'].level or 0)
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card,
			}
		end
	end
})

SMODS.Joker:take_ownership('j_may_keplers_dream', {
	loc_txt = {
		name = {'Kepler\'s Dream', "{C:inactive,s:0.5}Universal Collapse + Kepler{}"},
		text = {
			{
				"When hand is played, {C:attention}before scoring{},",
				"{C:attention}gains{} the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^^^Mult{}",
				"{C:inactive}Currently {X:mult,C:white}^^^#1#{} Mult{}",
			},
			may.add_fusion_text('ACVM MVLTIPLEXVM', 'Spadus', '{C:planet}Level up{} a {C:purple}Poker Hand{} to {C:planet}level{} {C:attention}25,000{}'),
			{
				"{C:inactive,E:1}Original concept by pyleup{}",
			},
		}
	},
	config = { extra = { EEEmult = 1 } },
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
})

-- Exclusive content 

--[[SMODS.Consumable {
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
	rarity = 6,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ee_chips } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('chips', 2, card.ability.extra.ee_chips, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('chips', 2, to_big(card.ability.extra.ee_chips):arrow(3, number), false, card)
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
	rarity = 7,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hyper_chips, card.ability.extra.eee_mult } }
	end,
	use = function(self, card, area, copier)
		may.hand_mod_multchips_all('chips', 4, card.ability.extra.hyper_chips, false, card)
		may.hand_mod_multchips_all('mult', 3, card.ability.extra.eee_mult, false, card)
	end,
	bulk_use = function(self, card, area, copier, number)
		may.hand_mod_multchips_all('chips', 4, to_big(card.ability.extra.hyper_chips):arrow(5, number), false, card)
		may.hand_mod_multchips_all('mult', 3, to_big(card.ability.extra.eee_mult):arrow(4, number), false, card)
	end
}]]

SMODS.Back {
	name = "Unstable Deck",
	key = "unstable_deck",
	atlas = 'deck',
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = "Unstable Deck",
		text = {
			"Start run with {C:dark_edition,T:j_may_universal_collapse}Universal Collapse{}",
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
	name = "Power Deck",
	key = "power_deck",
	atlas = 'deck',
	pos = { x = 5, y = 1 },
	loc_txt = {
		name = "Power Deck",
		text = {
			"{C:green}1 in 10{} chance to",
			"{C:attention}increase{} {C:dark_edition}Score Operator{} level by {C:attention}1{}",
			"after {C:attention}hand{} is {C:attention}played{}"
		},
	},
	calculate = function(self, back, context)
		if context.after and pseudorandom('may_power_deck') < G.GAME.probabilities.normal / 10 then
			change_operator(1)
		end
	end
}

if may.conf.content.WIP  then

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
	pos = { x = 2, y = 2 },
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
	pos = { x = 3, y = 0 },
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
			may.hcm(hand_chips, mult)
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
			may.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				G.GAME.may_override_monitor_colors = true
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
			may.hn("Other Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_eqchip')
			return true end}))
			may.hc('='..balanced, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_eqmult')
			return true end}))
			may.hm('='..balanced, true)
			delay(0.5)
			may.hn(previous)
			may.hcm(mult, hand_chips)
			G.E_MANAGER:add_event(Event({func = (function()
				local text = localize('k_balanced')
				play_sound('gong', 0.94, 0.3)
				play_sound('gong', 0.94*1.5, 0.2)
				play_sound('tarot1', 1.5)
				play_sound('may_hyperoperator', 1.5)
				G.GAME.may_override_monitor_colors = true
				ease_colour(G.C.UI_CHIPS, G.C.EDITION)
				ease_colour(G.C.UI_MULT, G.C.EDITION)
				may.a(localize('k_balanced'), 2, 1.4) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
				return true end}))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
					G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
				return true end}))
				may.set_hand_level(nil, G.GAME.current_round.current_hand.handname, true, balanced)
			return true end)}))
		end
	end
}

--[[SMODS.Back {
	name = "Celestial Hierarchy Deck",
	key = "celestial_hierarchy_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	misc_badge = may_transcendent_badge,
	loc_txt = {
		name = "Celestial Hierarchy Deck",
		text = {
			"{C:attention}All{} possible {C:attention}consumables{} are {C:dark_edition}Ascended{}",
		},
	},
	-- Logic is handled in the actual empowered consumable function
}]]

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
			"of {C:spectral}The Soul{} and {C:spectral}Genesis{}",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			G.consumeables.config.card_limit = 1e100
			local soul = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_soul', "may_sandbox_deck")
			soul:add_to_deck()
			G.consumeables:emplace(soul)
			soul:set_edition({negative = true}, true)
			local genesis = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_may_genesis', "may_sandbox_deck")
			genesis:add_to_deck()
			G.consumeables:emplace(genesis)
			genesis:set_edition({negative = true}, true)
		return true end}))
	end,
	calculate = function(self, card, context)
		if context.open_booster then
			G.GAME.pack_choices = G.GAME.pack_size
		end
	end
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
	extra_cost = 1717,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				ee_chips = self.config.ee_chips
			}
		end
	end, 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = true }
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
	config = { hyper_chips = {4, 1.57}, eee_mult = 15.7 },
	in_shop = true,
	weight = .001,
	extra_cost = 100000,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				hyper_chips = self.config.hyper_chips,
				eee_mult = self.config.eee_mult
			}
		end
	end, 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = true }
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
			"{C:mult}#1# hands{} played",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 },
	config = { hands = -2 },
	atlas = 'may_special_spectral',
	misc_badge = may_rare_badge,
	endless = true,
	cost = 10,
	no_grc = true,
	unlocked = true,
	hidden = true,
	soul_rate = 0.02,
	can_use = function(self, card)
		return may.canuse() and G.GAME.round_resets.hands > 2 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
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
	end, 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}