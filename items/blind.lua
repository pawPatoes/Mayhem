-- Blinds

SMODS.Blind {
	key = 'inheritance',
	config = { canchange = true },
	loc_txt = {
		name = 'The Inheritance',
		text = { 
			"Base Chips is",
			"set to half of",
			"Base Mult"
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

--[[SMODS.Blind {
	key = 'half',
	config = { canchange = true },
	loc_txt = {
		name = 'The Half',
		text = { 
			"Mult is ignored",
			"when calculating",
			"score"
		}
    },
	disable = function(self)
		self.config.canchange = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('7A09FA'),
	dollars = 5,
	mult = 0.3,
	atlas = "blind",
	pos = {x = 0, y = 2},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}]] 

SMODS.Blind {
	key = 'strike',
	loc_txt = {
		name = 'The Strike',
		text = { 
			"Playing cards",
			"have negative",
            "Nominal Chips"
		}
    },
	disable = function(self)
		G.GAME.playing_card_multiplier = math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	defeat = function(self)
		G.GAME.playing_card_multiplier = math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	set_blind = function(self)
		G.GAME.playing_card_multiplier = -math.abs(G.GAME.playing_card_multiplier or 1)
	end,
	boss = {
		min = 1,
		max = 10
	}, 
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
	press_play = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (#G.hand.cards * 0.08))
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
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

--[[SMODS.Blind {
	key = 'philosopher',
	config = { safe_hands = {} },
	loc_txt = {
		name = 'The Philosopher',
		text = { 
			"You can only play",
			"4 random Poker Hands"
		}
    },
	debuff_hand = function(self, cards, hand, handname, check)
		if not table_hasvalue(self.config.safe_hands, handname) and not G.GAME.blind.disabled then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	set_blind = function(self)
		for i=1, 4, 1 do
			table.insert(self.config.safe_hands, may.rndhand())
		end
	end,
	disable = function(self)
		self.config.safe_hands = {}
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('bf00ff'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 4},
	in_pool = function(self)
		return G.GAME.round_resets.ante > 5
	end
}

SMODS.Blind {
	key = 'hourglass',
	config = { can_apply = true },
	loc_txt = {
		name = 'The Hourglass',
		text = { 
			"When hand is played,",
			"apply Eternal to a random",
			"Joker",
		}
    },
	disable = function(self)
		self.config.can_apply = false
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('9B59D6'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 5},
	press_play = function(self)
		if self.config.can_apply and #G.jokers.cards ~= 0 then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
				local joker = pseudorandom_element(G.jokers.cards, pseudoseed('may_hourglass'))
				play_sound("tarot1")
				joker:set_eternal(true)
			return true end}))
		end
	end,
}

-- After hand is played context (taken from Cryptid)
local vanf_gfep = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
	vanf_gfep(e)
	SMODS.calculate_context({after_play = true})
	G.GAME.blind:may_after_play()
end

function Blind:may_after_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.may_after_play and type(obj.may_after_play) == "function" then
			return obj:may_after_play()
		end
	end
end

SMODS.Blind {
	key = 'bug',
	config = { can_increase = true },
	loc_txt = {
		name = 'The Bug',
		text = { 
			"^^2 Blind Size",
			"if played hand reaches",
			"any Transcendence level"
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
	may_after_play = function(self)
		if G.GAME.chips >= G.GAME.blind.chips * 1e100 then
			local to_ease = G.GAME.blind.chips
			SMODS.juice_up_blind()
			G.E_MANAGER:add_event(Event({trigger = 'ease', blocking = false, ref_table = G.GAME.blind, ref_value = 'chips', 
			ease_to = to_big(get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2):arrow(2, 2),
			delay = 0.5, func = (function(t) 
				play_sound('may_blind_size')
				return math.floor(t) 
			end)}))
		end
	end,
}]]

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
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Candle',
		text = { 
			"Level down discarded",
			"Poker Hands by 3"
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
		if context.pre_discard then
			local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			level_up_hand(blind, text, nil, math.max(-3, -G.GAME.hands[text].level))
			may.ch()
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

--[[SMODS.Blind {
	key = 'fall',
	config = { can_decrease = true },
	loc_txt = {
		name = 'The Fall',
		text = { 
			"When hand is played,",
			"set the Nominal Chips multiplier",
			"of all cards in full deck",
			"to X0.01 the highest card rank",
			"in scoring hand",
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	calculate = function(self, blind, context)
		if context.before and self.config.can_decrease then
			local highest_rank = 0
			for k, v in pairs(context.scoring_hand) do
				if v:get_id() > highest_rank then
					highest_rank = v:get_id()
				end
			end
			for k, v in pairs(G.playing_cards) do
				v.ability.nominal_multiplier = highest_rank * 0.01
				if table_hasvalue(G.hand.cards, v) or table_hasvalue(G.play.cards, v) then
					v:juice_up()
					play_sound('may_nominal_chips')
				end
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
}]] 

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
	key = 'squid',
	loc_txt = {
		name = 'The Squid',
		text = { 
			"X0.5 Blind Size",
			"if played hand is Straight",
		}
    },
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	press_play = function(self)
		if G.GAME.current_round.current_hand.handname == localize("Straight", 'poker_hands') then
			G.GAME.blind.chips = G.GAME.blind.chips * 0.5
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			play_sound('may_blind_size')
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B626A2'),
	dollars = 5,
	mult = 3.5,
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

--[[SMODS.Blind {
	key = 'coffin',
	config = { can_debuff = true },
	loc_txt = {
		name = 'The Coffin',
		text = { 
			"Played cards are",
			"permanently debuffed",
			"after scoring"
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	calculate = function(self, blind, context)
		if context.after and self.config.can_debuff then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.75, func = function()
				for k, v in pairs(context.scoring_hand) do
					SMODS.debuff_card(v, true, 'may_coffin')
					v:juice_up()
				end
				play_sound('tarot1')
				SMODS.juice_up_blind()
			return true end}))
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
}]] 

--[[SMODS.Blind {
	key = 'fork',
	config = { can_debuff = true, debuffed = {} },
	loc_txt = {
		name = 'The Fork',
		text = { 
			"Discarding debuffs all",
			"cards held in hand",
			"that were not discarded",
		}
    },
	disable = function(self)
		self.config.can_debuff = false
	end,
	calculate = function(self, blind, context)
		if context.pre_discard and self.config.can_debuff then
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.75, func = function()
				for k, v in pairs(G.hand.cards) do
					if not table_hasvalue(context.full_hand, v) then
						SMODS.debuff_card(v)
						v:juice_up()
						table.insert(self.config.debuffed, v)
					end
				end
				play_sound('tarot1')
				SMODS.juice_up_blind()
			return true end}))
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('DAC651'),
	dollars = 5,
	mult = 2,
	atlas = "blind",
	pos = {x = 0, y = 16},
}]] 

SMODS.Blind {
	key = 'pole',
	loc_txt = {
		name = 'The Pole',
		text = { 
			"Only most played Poker Hand",
			"scores"
		}
    },
	debuff_hand = function(self, cards, hand, handname, check)
		if handname ~= may.favhand() then
			G.GAME.blind.triggered = true
			return true
		end
		return false
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
			"by 1 + X0.2 the sell value",
			"of a random Joker"
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
	config = { can_spawn = true },
	loc_txt = {
		name = 'The Branches',
		text = { 
			"If played hand is most played",
			"Poker Hand, fill empty",
			"Joker Slots with Eternal",
			"copies of Joker"
		}
    },
	disable = function(self)
		self.config.can_spawn = false
	end,
	calculate = function(self, blind, context)
		if context.before and G.GAME.current_round.current_hand.handname == may.favhand() then
			if self.config.can_spawn then
				for i=1, G.jokers.config.card_limit - #G.jokers.cards, 1 do
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_joker', 'may_trident')
					G.jokers:emplace(card2)
					play_sound('tarot1')
					card2:add_to_deck()
					card2:set_eternal(true)
				end
			end
		end
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
        return G.GAME.round_resets.ante > 4
    end
}

--[["SMODS.Blind {
	key = 'runaway',
	config = { multiplier = 300 },
	loc_txt = {
		name = 'The Runaway',
		text = { 
			"+#1#% Blind Size",
			"-30% per blind skipped this run",
		}
    },
	collection_loc_vars = function(self, info_queue, card)
		return { vars = { 300 } }
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (self.config.multiplier or 300) - ( G.GAME.skips * 30 ) } }
	end,
	disable = function(self)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('tarot1')
	end,
	set_blind = function(self)
		G.GAME.blind.chips = (get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2) * (((self.config.multiplier or 300) - ( G.GAME.skips * 30 )) * 0.01)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		play_sound('may_blind_size')
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
}]] 

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

--[[SMODS.Blind {
	key = 'trigonometry',
	config = { can_decrease = true, pre_decrease = 0 },
	loc_txt = {
		name = 'The Trigonometry',
		text = { 
			"Score Operator is",
			"temporarily set to +" 
		}
    },
	disable = function(self)
		self.config.can_decrease = false
	end,
	set_blind = function(self)
		self.config.pre_decrease = G.GAME.current_scoring_calculation_key
		SMODS.set_scoring_calculation('add')
	end,
	defeat = function(self)
		SMODS.set_scoring_calculation(self.config.pre_decrease or 'multiply')
	end, 
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('B94364'),
	dollars = 5,
	mult = 0.4,
	atlas = "blind",
	pos = {x = 0, y = 24},
}]] 

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