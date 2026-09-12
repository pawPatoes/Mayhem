-- Decks

SMODS.Back {
	name = "Orange deck",
	key = "orange_deck",
	atlas = 'deck',
	pos = { x = 2, y = 1 },
	config = {hand_size = 1},
	loc_txt = {
		name = "Orange Deck",
		text = {
			"{C:attention}+1{} Hand Size"
		},
	},
}

SMODS.Back {
	name = "Purple deck",
	key = "purple_deck",
	atlas = 'deck',
	pos = { x = 0, y = 2 },
	config = {choices = 1},
	loc_txt = {
		name = "Purple Deck",
		text = {
			"You can select {C:green}1{} more {C:attention}card{}",
			"from {C:attention}Booster Packs{}"
		},
	},
	apply = function(self)
		G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1
	end
}

SMODS.Back {
	name = "Pink deck",
	key = "pink_deck",
	atlas = 'deck',
	pos = { x = 4, y = 1 },
	config = {size = 0.8},
	loc_txt = {
		name = "Pink Deck",
		text = {
			"{X:attention,C:white}X0.8{} Blind size"
		},
	},
	apply = function(self)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.size
	end
}

SMODS.Back {
	name = "Lime deck",
	key = "lime_deck",
	atlas = 'deck',
	pos = { x = 0, y = 1 },
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
	pos = { x = 1, y = 0 },
	config = {mult = 5},
	loc_txt = {
		name = "Brown Deck",
		text = {
			"Playing cards give {C:mult}+Mult{}", 
			"equal to {X:attention,C:white}20%{} of their", 
			"{C:attention}Nominal Chips{} when scored"
		},
	},
	calculate = function(self, back, context)
		if context.individual and context.cardarea == G.play then 
			if not SMODS.has_no_rank(context.other_card) and context.other_card.base.nominal ~= 0 then 
				return {
					mult = context.other_card.base.nominal * 0.2, 
					message_card = context.other_card, 
					cars = context.other_card
				}
			end
		end
	end, 
}

SMODS.Back {
	name = "Gray deck",
	key = "gray_deck",
	atlas = 'deck',
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = "Gray Deck",
		text = {
			"All {C:attention}cards{} in deck start with",
			"a {C:attention}random{} {C:dark_edition}Seal{}",
			"{C:inactive,E:1,s:0.7}actually its grey !!!{}"
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
	name = "Turquoise deck",
	key = "turquoise_deck",
	atlas = 'deck',
	pos = { x = 3, y = 2 },
	config = {discount = 25},
	loc_txt = {
		name = "Turquoise Deck",
		text = {
			"All {C:attention}cards{} in {C:attention}shop{} are",
			"{X:green,C:white}25%{} {C:money}cheaper{}"
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
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "Blurple Deck",
		text = {
			"Start run with a {C:attention}random{}",
			"{X:mult,C:white}Rare{} {C:attention}Joker{}", 
			"and with {C:attention}+1{} Ante"
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'blurple_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
			ease_ante(1)
		return true end}))
	end
}

SMODS.Back {
	name = "Monochrome deck",
	key = "monochrome_deck",
	atlas = 'deck',
	pos = { x = 1, y = 1 },
	config = { amount = 2 },
	loc_txt = {
		name = "Monochrome Deck",
		text = {
			"Start run with {C:attention}2{} {C:dark_edition,T:e_negative}Negative{}",
			"copies of a {C:attention}random{} {X:green,C:white}Uncommon{} {C:attention}Joker{}"
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
			card2:set_edition({negative = true}, false, false)
			G.jokers:emplace(card2)
			card2:add_to_deck()
			for i = 1, self.config.amount - 1 do
				local copy = copy_card(card2, nil)
				G.jokers:emplace(copy)
				copy:add_to_deck()
				copy:set_edition({negative = true}, false, false)
			end
			play_sound('holo1')
		return true end}))
	end
}

SMODS.Back {
	name = (#SMODS.find_mod('MoreFluff') ~= 0 and "Spectrum Deck" or "Rainbow Deck"),
	key = "rainbow_deck",
	atlas = 'deck',
	pos = { x = 1, y = 2 },
	config = { hands = 1, discards = 1, hand_size = 1, size_mod = 1.65, dollars = 5 },
	loc_txt = {
		name = (#SMODS.find_mod('MoreFluff') ~= 0 and "Spectrum Deck" or "Rainbow Deck"),
		text = {
			"{C:green}+1{} {C:chips}hand{}, {C:mult}discard{} and {C:attention}Hand Size{}",
			"{X:attention,C:white}X1.65{} Blind Size"
		},
	}, 
}

--[[SMODS.Back {
	name = "AAAA Deck",
	key = "aaaa_deck",
	atlas = 'joker1',
	pos = { x = 4, y = 5 },
	config = {rank = 'Ace'},
	loc_txt = {
		name = "AAAA Deck",
		text = {
			"Start run with {C:attention,T:j_may_aaaa}AAAA{}",
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
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_aaaa', 'may_aaaa_deck')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}

SMODS.Back {
	name = "Osmium deck",
	key = "osmium_deck",
	atlas = 'placeholder',
	pos = { x = 4, y = 2 },
	config = { joker_slot = -3 }, 
	loc_txt = {
		name = "Osmium Deck",
		text = {
			"All {C:attention}consumables{} have",
			"{C:dark_edition,T:e_may_metallic}Metallic Edition{}",
			"{C:mult}-3{} Joker Slots and",
			"Consumable Slots"
		},
	},
	apply = function(self)
		G.GAME.may_osmium_deck = true
		G.E_MANAGER:add_event(Event({func = function()
			G.consumeables:change_size(-3)
		return true end}))
	end,
}]]

SMODS.Back {
	name = "Centurion Deck",
	key = "centurion_deck",
	atlas = 'placeholder',
	config = { vouchers = { 'v_may_increment', 'v_may_increase', 'v_may_stardust', 'v_may_meteor' } },
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = "Centurion Deck",
		text = {
			"Start run with {C:attention,T:v_may_increment}Increment{},",
			"{C:attention,T:v_may_increase}Increase{}, {C:attention,T:v_may_stardust}Stardust{}",
			"and {C:attention,T:v_may_meteor}Meteor{}",
			"All {C:purple}Poker Hands{} start at",
			"{C:planet}Level{} {C:attention}3{} and with",
			"{X:purple,C:white}X2{} Mult & Chips",
			"{X:attention,C:white}X10{} {C:attention}Boss Blind{} Size",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			may.level_up_all_hands(card, true, 2)
			for k, v in pairs(G.GAME.hands) do
				v.mult = v.mult * 2
				v.chips = v.chips * 2
			end
		return true end}))
	end,
	calculate = function(self, back, context)
		if context.setting_blind and G.GAME.blind.boss then
			G.GAME.blind.chips = G.GAME.blind.chips * 10
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
			play_sound('may_blind_size')
			delay(0.4)
		end
	end
}

SMODS.Back {
	name = "Phantasm Deck",
	key = "phantasm_deck",
	atlas = 'deck',
	pos = { x = 3, y = 1 },
	loc_txt = {
		name = "Phantasm Deck",
		text = {
			"Start run with {C:attention}3{} {C:attention,T:tag_charm}Charm Tags{}",
			"and {C:attention,T:tag_ethereal}Ethereal Tags{}",
			"in alternating order",
			"Starting {C:money}Interest{} is {C:mult}negative{}"
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			for i=1, 3, 1 do
				add_tag(Tag('tag_charm'))
				add_tag(Tag('tag_ethereal'))
			end
			G.GAME.interest_amount = -G.GAME.interest_amount
		return true end}))
	end
}

SMODS.Back {
	name = "DeeD",
	key = "deed",
	atlas = 'deck',
	pos = { x = 0, y = 3 }, 
	config = { vouchers = { 'v_may_upside_down_merchant', 'v_may_upside_down_tycoon' } }, 
	loc_txt = {
		name = "DeeD",
		text = {
			"Start run with", 
			"{C:attention,T:v_may_upside_down_merchant}Upside Down Merchant{} and", 
			"{C:attention,T:v_may_upside_down_tycoon}Upside Down Tycoon{}"
		},
	},
}

SMODS.Back {
	name = "Desmos Deck",
	key = "desmos_deck",
	atlas = 'deck',
	pos = { x = 1, y = 3 },
	loc_txt = {
		name = "Desmos Deck",
		text = {
			"{C:attention}Start{} with {C:dark_edition}Score Operator{}",
			"set to {C:attention}DSM{}",
			"{C:may_score}Score{}=(({C:chips}Chips{}+({C:mult}Mult{}X(1+log10({C:chips}Chips{}))))X{C:chips}Chips{})^0.8", 
			"{C:inactive,E:1}Art by Grahkon{}"
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			SMODS.set_scoring_calculation('may_desmos')
		return true end}))
	end
}

SMODS.Back {
	name = "Iron Deck",
	key = "iron_deck",
	atlas = 'deck',
	pos = { x = 5, y = 0 },
	config = { discards = -1 }, 
	loc_txt = {
		name = "Iron Deck",
		text = {
			"{C:mult}-1 Discard{}", 
			"{C:purple}Poker Hands{} formed", 
			"with {C:attention}at least 5 cards{}", 
			"start with {X:purple,C:white}X3{}", 
			"{C:may_demiurgic}Level{} Mult & Chips"
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local hands = {}
			for k, v in pairs(G.GAME.hands) do
				local scoring = 0
				for k2, v2 in pairs(v.example) do
					if v2[2] then 
						scoring = scoring + 1
					end 
					if scoring >= 5 then
						table.insert(hands, k)
						break 
					end
				end
			end 
			for k, v in pairs(hands) do 
				G.GAME.hands[v].l_mult = G.GAME.hands[v].l_mult * 3
				G.GAME.hands[v].l_chips = G.GAME.hands[v].l_chips * 3
			end
		return true end}))
	end
}

SMODS.Back {
	name = "Modified Deck",
	key = "modified_deck",
	atlas = 'deck',
	config = { vouchers = { 'v_may_varied_selection' } },
	pos = { x = 5, y = 2 },
	loc_txt = {
		name = "Modified Deck",
		text = {
			"Start run with {C:attention,T:v_may_varied_selection}Varied Selection{}",
			"When {C:attention}Blind{} is {C:attention}selected{},", 
			"create a {C:attention}random{}", 
			"{C:dark_edition,T:e_negative}Negative{} {C:dark_edition}Modifier Card{}"
		},
	},
	calculate = function(self, back, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, 'may_modified_deck')
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card2:juice_up(0.3, 0.5)
			return true end}))
		end
	end, 
	draw = function(self, card, layer)
		card.children.center:draw_shader('holo', nil, card.ARGS.send_to_shader)
	end
}

SMODS.Back {
	name = "Twilight deck",
	key = "twilight_deck",
	atlas = 'deck',
	pos = { x = 2, y = 3 },
	config = {hand_size = 2},
	loc_txt = {
		name = "Twilight Deck",
		text = {
			"{C:purple}+2 Card Selection Limit{}",
			"and {C:attention}+2 Hand size{}", 
			"{C:mult}Discard{} all cards {C:attention}held{}", 
			"{C:attention}in hand{} after scoring",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			G.hand:change_max_highlight(2)
		return true end}))
	end, 
	calculate = function(self, back, context)
		if context.final_scoring_step then 
			if #G.hand.cards > 0 then
				for k, v in pairs(G.hand.cards) do 
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
						v.highlighted = true
						play_sound('card1')
						draw_card(G.hand, G.discard, 100, 'down', false, v)
					return true end}))
				end
			end
		end
	end
}

--[[SMODS.Back {
	name = "Pulse Deck",
	key = "pulse_deck",
	atlas = 'placeholder',
	misc_badge = may_wip_badge,
	pos = { x = 4, y = 2 }, 
	config = { joker_slot = -2 }, 
	loc_txt = {
		name = "Pulse Deck",
		text = {
			"{C:attention}Retrigger{} leftmost and", 
			"rightmost Jokers {C:attention}2{} times",
			"{C:mult}-2{} Joker Slots"
		},
	},
	calculate = function(self, back, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and (context.other_card == G.jokers.cards[1] or context.other_card == G.jokers.cards[#G.jokers.cards]) then
			return {
				repetitions = 2,
				card = back, 
				message = 'Again!'
			}
		end
	end
}]] 

SMODS.Back {
	name = "Test Deck",
	key = "test_deck",
	atlas = 'deck',
	pos = { x = 0, y = 0 },
	config = { vouchers = { 'v_may_reconfigure', 'v_grabber' } },
	loc_txt = {
		name = "Test Deck",
		text = {
			"If you are seeing this, i forgot",
			"to get rid of this before releasing the update", 
			"Please ignore this deck."
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			level_up_hand(nil, 'High Card', true, to_big(to_big(1e100):arrow(1, 10)):arrow(5005, to_big(to_big(1e100):arrow(1, 10))))
			ease_dollars(9999)
			--add_skill_xp(99999)
			--for i = 1, 25 do 
				--local new = SMODS.add_card({ set = 'Planet' })
				--new:set_edition(SMODS.poll_edition({ guaranteed = true }))
			--end
			SMODS.add_card({ key = 'j_may_acum' })
			for i = 1, 5 do
				SMODS.add_card({ key = 'c_may_erasure', area = G.consumeables })
				SMODS.add_card({ key = 'c_aura' })
				SMODS.add_card({ key = 'c_talisman' })
				SMODS.add_card({ key = 'c_may_pickaxe' })
			end
		return true end})) 
	end, 
}