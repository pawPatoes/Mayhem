-- Blinds

SMODS.Blind {
	key = 'inheritance',
	config = { canchange = true },
	loc_txt = {
		name = 'The Inheritance',
		text = { 
			"Base Chips is",
			"set to half of",
			"base Mult"
		}
    },
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if self.config.canchange then
			local new_chips = math.max(math.floor(mult/2 + 0.5))
			return mult, new_chips, true
		else
			return mult, hand_chips, false
		end
	end,
	disable = function(self)
		self.config.canchange = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('94FDFF'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 1},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 3
	end
}

SMODS.Blind {
	key = 'half',
	loc_txt = {
		name = 'The Half',
		text = { 
			"Halve hands", 
			"and discards", 
			"(rounds down)"
		} 
    },
	set_blind = function(self)
		ease_hands_played(-math.ceil(G.GAME.round_resets.hands * 0.5))
		ease_discard(-math.ceil(G.GAME.round_resets.discards * 0.5))
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('7A09FA'),
	dollars = 5,
	mult = 1,
	atlas = "blind",
	pos = {x = 0, y = 2},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'strike',
	loc_txt = {
		name = 'The Strike',
		text = { 
			"Played cards", 
			"multiply base Chips", 
			"by X0.85"
		}
    },
	boss = {
		min = 1,
		max = 10
	}, 
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		return mult, hand_chips * (0.85 ^ #cards), true
	end,
	boss_colour = HEX('D3FC7E'),
	dollars = 5,
	mult = 1.5,
	atlas = "blind",
	pos = {x = 0, y = 0},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'crowd',
	config = { canincrease = true },
	loc_txt = {
		name = 'The Crowd',
		text = { 
			"Held in hand cards",
			"give +X0.08 Blind Size"
		}
    },
	disable = function(self)
		self.config.canincrease = false
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (#G.hand.cards * 0.08))
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
		return mult, hand_chips, false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A90000'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 3},
}

SMODS.Blind {
	key = 'philosopher',
	loc_txt = {
		name = 'The Philosopher',
		text = { 
			"+1 Hand Size", 
			"Numbered cards", 
			"are debuffed"
		}
    },
	set_blind = function(self)
		G.hand:change_size(1)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 1
	end, 
	recalc_debuff = function(self, card, from_blind)
		return card.area ~= G.jokers and SMODS.is_playing_card(card) and not card:is_face()
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('bf00ff'),
	dollars = 5,
	mult = 1.5,
	atlas = "blind",
	pos = {x = 0, y = 4},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'hourglass',
	loc_txt = {
		name = 'The Hourglass',
		text = { 
			"Apply Eternal to", 
			"rightmost non-Eternal",
			"Joker when selected"
		}
    },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('9B59D6'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 5},
	set_blind = function(self)
    	for i = #G.jokers.cards, 1, -1 do
            if not SMODS.is_eternal(G.jokers.cards[i]) then
            	joker = G.jokers.cards[i]
            	break
        	end
        end
    	if joker then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
				joker:juice_up(0.3, 0.5)
				play_sound("tarot1")
				joker:set_eternal(true)
				SMODS.juice_up_blind()
            return true end}))
		end
	end,
}

SMODS.Blind {
	key = 'bug',
	loc_txt = {
		name = 'The Bug',
		text = { 
			"Cards without",
			"Enhancements, Editions", 
			"or Seals are debuffed", 
		}
    },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('FF9757'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 6},
	recalc_debuff = function(self, card, from_blind)
		return SMODS.has_enhancement(card, 'c_base') and not card.edition and not card.seal
	end, 
	in_pool = function(self)
		return G.GAME.round_resets.ante > 6
	end
}

SMODS.Blind {
	key = 'calculator',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Calculator',
		text = { 
			"Gain score of", 
            "base Mult & Chips", 
            "of played hand", 
            "as Blind Size"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('36AE8D'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 7},
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.current_scoring_calculation:func(SMODS.get_scoring_parameter('chips', true), SMODS.get_scoring_parameter('mult', true), true)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
		return mult, hand_chips, false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'candle',
	config = { hands = {} },
	loc_txt = {
		name = 'The Candle',
		text = { 
			"-1 hand when discarding", 
			"-1 discard before scoring"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('C24040'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 8},
	calculate = function(self, blind, context)
		if blind.disabled then return end 
		
		if context.pre_discard then
			ease_hands_played(-1)
			SMODS.juice_up_blind()
		end
		if context.before then
			ease_discard(-1)
			SMODS.juice_up_blind()
		end
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'cement',
	config = { canincrease = true },
	loc_txt = {
		name = 'The Cement',
		text = { 
			"+1% Blind requirements",
			"for every card in",
			"full deck",
		}
    },
	disable = function(self)
		self.config.canincrease = false
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	set_blind = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (#G.deck.cards * 0.01))
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A8B5B2'),
	dollars = 5,
	mult = 1.5,
	atlas = "blind",
	pos = {x = 0, y = 9},
}

SMODS.Blind {
	key = 'charge',
	config = { canincrease = true, multiplier = 1.3 },
	loc_txt = {
		name = 'The Charge',
		text = { 
			"X#1# Blind Size when",
			"hand is played",
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 1.3 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.multiplier or 1.3 } }
	end,
	disable = function(self)
		self.config.canincrease = false
	end,
	press_play = function(self)
		if self.config.canincrease then
			G.GAME.blind.chips = G.GAME.blind.chips * self.config.multiplier
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			play_sound('may_blind_size')
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('5A76D7'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 10},
}

SMODS.Blind {
	key = 'fall',
	loc_txt = {
		name = 'The Fall',
		text = { 
			"Temporarily decrease", 
			"Hand Size by 1 after", 
			"each hand"
		}
    },
	calculate = function(self, blind, context)
		if blind.disabled then return end 
		
		if context.after then 
			if not blind.disabled then
				G.hand:change_size(-1)
				G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) - 1
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('429058'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 11},
}

SMODS.Blind {
	key = 'fifth',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Fifth',
		text = { 
			"X0.2 base Chips"
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if self.config.can_decrease then
			return mult, hand_chips*0.2, true
		else
			return mult, hand_chips, false
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('FDADDE'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 12},
}

SMODS.Blind {
	key = 'aquatic',
	loc_txt = {
		name = 'The Aquatic',
		text = { 
			"Temporarily offsets", 
			"rank of all cards in", 
			"full deck by -1"
		}
    },
	set_blind = function(self)
		for k, v in pairs(G.playing_cards) do 
			assert(SMODS.modify_rank(v, -1))
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1', 0.5)
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
	end, 
	defeat = function(self)
		for k, v in pairs(G.playing_cards) do 
			assert(SMODS.modify_rank(v, 1))
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1', 0.75)
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B626A2'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 13},
}

SMODS.Blind {
	key = 'paw',
	config = { pre_hands = 0, pre_size = 0 },
	loc_txt = {
		name = 'The Paw',
		text = { 
			"Hand Size and Hands",
			"are swapped"
		}
    },
	disable = function(self)
		ease_hands_played(self.config.pre_hands - G.GAME.round_resets.hands)
		G.hand:change_size(self.config.pre_size - G.hand.config.card_limit)
	end,
	set_blind = function(self)
		self.config.pre_hands = G.GAME.round_resets.hands
		self.config.pre_size = G.hand.config.card_limit
		G.hand:change_size(G.GAME.round_resets.hands - G.hand.config.card_limit)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (G.GAME.round_resets.hands - G.hand.config.card_limit)
		ease_hands_played(G.hand.config.card_limit - G.GAME.round_resets.hands)
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('2BACA9'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 14},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 3
	end
}

SMODS.Blind {
	key = 'coffin',
	config = { can_debuff = true },
	loc_txt = {
		name = 'The Coffin',
		text = { 
			"Randomly discards 25%",
			"of your deck when selected,", 
			"rounded down"
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	set_blind = function(self)
		for i = 1, math.floor(#G.playing_cards * 0.25) do 
			local card = pseudorandom_element(G.deck.cards, pseudoseed('may_coffin'))
			draw_card(card.area, G.discard, 100, 'up', false, v)
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('77744F'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 15},
}

SMODS.Blind {
	key = 'fork',
	config = { can_debuff = true, debuffed = {} },
	loc_txt = {
		name = 'The Fork',
		text = { 
			"Discards all", 
			"cards with an Enhancement,", 
			"Seal or Edition from full deck", 
			"when selected"
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	set_blind = function(self)
		for k, v in pairs(G.playing_cards) do
			if v.edition or v.seal or not SMODS.has_enhancement(v, 'c_base') then 
				draw_card(v.area, G.discard, 100, 'up', false, v)
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('DAC651'),
	dollars = 5,
	mult = 1.5,
	atlas = "blind",
	pos = {x = 0, y = 16},
}

SMODS.Blind {
	key = 'pole',
	loc_txt = {
		name = 'The Pole',
		text = { 
			"Only most played",
			"Poker Hand scores"
		}
    },
	debuff_hand = function(self, cards, hand, handname, check)
		if handname ~= may.favhand() then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	get_loc_debuff_text = function(self)
		return "Only "..localize(may.favhand(), 'poker_hands').." scores"
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6158B3'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 17},
}

SMODS.Blind {
	key = 'loanshark',
	loc_txt = {
		name = 'The Loanshark',
		text = { 
			"Multiply blind size",
			"by X(1 + 20% the sell value",
			"of a random Joker)"
		}
    },
	set_blind = function(self)
		if #G.jokers.cards ~= 0 then
			G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * (1 + (pseudorandom_element(G.jokers.cards, pseudoseed('may_loanshark')).sell_cost * 0.2))
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			play_sound('may_blind_size')
		end
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('8B5D41'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 18},
}

SMODS.Blind {
	key = 'branches',
	loc_txt = {
		name = 'The Branches',
		text = { 
			"Lose all empty",
			"Joker and Consumable Slots", 
			"when selected"
		}
    },
	set_blind = function(self)
		G.jokers:change_size(-(G.jokers.config.card_limit - #G.jokers.cards))
		G.consumeables:change_size(-(G.consumeables.config.card_limit - #G.consumeables.cards))
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6B5B4C'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 19},
    in_pool = function(self, args)
        return G.GAME.round_resets.ante > 5
    end
}

SMODS.Blind {
	key = 'runaway',
	loc_txt = {
		name = 'The Runaway',
		text = { 
			"#1# Blind Size",
			"unless a Blind was", 
			"skipped this Ante", 
			"G is your highest hyperoperator"
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { '{G}4' } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { '{G}4' } }
	end,
	set_blind = function(self)
		if not G.GAME.may_runaway then
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(may.global_op(), 4)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				play_sound('may_blind_size') 
			return true end}))
		end
	end, 
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('0C0293'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 20},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'downpour',
	config = { can_convert = true },
	loc_txt = {
		name = 'The Downpour',
		text = { 
			"When hand is played,",
			"each card held in hand has",
			"a #1# in 4 chance to",
			"be debuffed"
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 1 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	disable = function(self)
		self.config.can_convert = false
	end,
	calculate = function(self, blind, context)
		if context.before and self.config.can_convert then
			for k, v in pairs(G.hand.cards) do
				if pseudorandom('may_downpour') < G.GAME.probabilities.normal / 4 then
					G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
						play_sound("tarot1")
						v:juice_up()
						v:set_debuff(true)
						SMODS.juice_up_blind()
					return true end}))
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B8F8B8'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 21},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.Blind {
	key = 'silence',
	config = { dollars = -1 },
	loc_txt = {
		name = 'The Silence',
		text = { 
			"Lose $1 when hand is played",
			"per remaining hand and discard"
		}
    },
	press_play = function(self)
		ease_dollars(-(G.GAME.current_round.discards_left + G.GAME.current_round.hands_left))
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('C6C6C6'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 22},
}

SMODS.Blind {
	key = 'bomb',
	config = { can_destroy = true },
	loc_txt = {
		name = 'The Bomb',
		text = { 
			"Destroy played cards",
			"with Enhancements after scoring",
		}
    },
	disable = function(self)
		self.config.can_destroy = false
	end,
	calculate = function(self, blind, context)
		if context.after and self.config.can_destroy then
			for k, v in pairs(G.play.cards) do
				if v.config.center.key ~= 'c_base' then
					G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
						SMODS.destroy_cards(v)
					return true end}))
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('A5B97D'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 23},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 2
	end
}

SMODS.Blind {
	key = 'abstract',
	config = { can_decrease = true, pre_decrease = 0 },
	loc_txt = {
		name = 'The Abstract',
		text = { 
			"Hand must contain", 
			"a Suitless or Rankless", 
			"card"
		}
    },
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B94364'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 24},
	get_loc_debuff_text = function(self)
		return "Hand must contain a Suitless or Rankless card"
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		for k, v in pairs(cards) do
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then 
				return false
			end
		end
		return true
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 6
	end
}

	-- UltraBlinds

--[[SMODS.Blind{
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
		return G.GAME.round_resets.ante > 8 or G.GAME.may_ultrablind_premature
	end
}

SMODS.Blind{
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
		return G.GAME.round_resets.ante > 8 or G.GAME.may_ultrablind_premature
	end
}

SMODS.Blind{
    loc_txt = {
		name = 'Superiority Complex',
		text = { 
			'Cannot play most played Poker Hand',
			'Blind size is multiplied by the level',
			'of most played Poker Hand'
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
		if handname == may.favhand() and not G.GAME.blind.disabled then
			G.GAME.blind.triggered = true
			return true
		end
	return false
	end,
	get_loc_debuff_text = function(self)
		return "Cannot play "..may.favhand()
	end,
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * get_mphand_level()
		play_sound('may_blind_size')
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 4
		play_sound('tarot1')
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8 or G.GAME.may_ultrablind_premature
	end
}

SMODS.Blind{
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
	mult = 1e32,
	disable = function(self)
		self.chips = get_blind_amount(G.GAME.round_resets.ante)*4
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8 or G.GAME.may_ultrablind_premature
	end
}

SMODS.Blind{
    loc_txt = {
		name = 'Downwards Spiral',
		text = { 
			'When hand is played,', 
			'-1 Score Operator level',
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
		if self.config.candecrease then
			change_operator(-1)
		end
	end,

	disable = function(self)
		self.config.candecrease = false
	end,
	in_pool = function(self)
		return G.GAME.round_resets.ante > 8 or G.GAME.may_ultrablind_premature
	end
}]] 