-- Tainted Bosses

SMODS.Blind {
	key = 'tainted_ox',
	loc_txt = {
		name = 'The Bull',
		text = { 
			"X-1$ when playing", 
			"most played Poker Hand,", 
			"otherwise add money to", 
			"Blind Requirements" 
		}
	},
	press_play = function(self)
		if G.GAME.current_round.current_hand.handname == localize(may.favhand(), 'poker_hands') then 
			may.hypermoney(0, -1)
			SMODS.juice_up_blind()
		else 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.dollars
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
			return true end}))
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('b95b08'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 0},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_ox'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_needle',
	config = { discards = 0 }, 
	loc_txt = {
		name = 'The Lance',
		text = { 
			"Play only 1 Hand", 
			"Hand does not score", 
			"until all or 10", 
			"discards used", 
			"+3 Discards"
		}
	},
	set_blind = function(self)
		ease_hands_played(-(G.GAME.round_resets.hands - 1))
		ease_discard(3)
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		if self.config.discards >= 10 then
			return false
		else
			if G.GAME.current_round.discards_left > 0 then
				G.GAME.blind.triggered = true
				return true
			end
		end
		return false
	end,
	get_loc_debuff_text = function(self)
		return "Hand does not score until all or 10 Discards used"
	end,
	defeat = function(self)
		self.config.discards = 0
	end, 
	calculate = function(self, blind, context)
		if context.pre_discard then
			self.config.discards = self.config.discards + 1
		end 
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('5c6e31'),
	dollars = 15,
	mult = 2.5,
	atlas = "taintedblind",
	pos = {x = 0, y = 18},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_needle'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_wall',
	config = { activated = false }, 
	loc_txt = {
		name = 'The Fortress',
		text = { 
			"Huge Blind", 
			"Score of first played hand", 
			"is transferred to Blind Size"
		}
	},
	calculate = function(self, blind, context)
		if context.after and not self.config.activated then
			self.config.activated = true 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.chips
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				SMODS.juice_up_blind()
				play_sound('may_blind_size')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				G.GAME.chips = 0
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.2, 0.2)
				SMODS.juice_up_blind()
				play_sound('may_eqscore')
			return true end}))
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('8a59a5'),
	dollars = 15,
	mult = 10,
	atlas = "taintedblind",
	pos = {x = 0, y = 7},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_wall'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_flint',
	loc_txt = {
		name = 'The Mountain',
		text = { 
			"Base Mult - 1 is transferred", 
			"to base Chips, then", 
			"^0.75 base Chips",
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('e56a2f'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 22},
	endless = true, 
	tainted = true,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		return 1, (hand_chips + (mult - 1)) ^ 0.75, true
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_flint'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_manacle',
	config = { discards = 0, hand_size = 0 }, 
	loc_txt = {
		name = 'The Shackle',
		text = { 
			"Hand Size is", 
			"set to Card Selection", 
			"Limit"
		}
	},
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.setting_blind then
				self.config.hand_size = G.hand.config.card_limit
				G.hand:change_size(-G.hand.config.card_limit + G.hand.config.highlighted_limit)
			end
		end
	end,
	defeat = function(self)
		if not G.GAME.blind.disabled then
			G.hand:change_size(self.config.hand_size)
		end
	end, 
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('575757'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 6},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_manacle'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_head',
	loc_txt = {
		name = 'The Epicenter',
		text = { 
			"Hearts debuffed", 
			"and drawn face down", 
			"^2 Blind Size if", 
			"hand does not contain", 
			"at least 1 Heart", 
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('ac9db4'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 19},
	debuff = { suit = 'Hearts' }, 
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then 
				no_suit = true
				for k, v in pairs(G.play.cards) do 
					if v:is_suit(self.debuff.suit, true) then 
						no_suit = not no_suit 
						break 
					end 
				end 
				if no_suit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						G.GAME.blind.chips = G.GAME.blind.chips ^ 2
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						SMODS.juice_up_blind()
						play_sound('may_blind_size')
					return true end})) 
				end 
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and card:is_suit(self.debuff.suit, true) and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_head'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_window',
	loc_txt = {
		name = 'The Portal',
		text = { 
			"Diamonds debuffed", 
			"and drawn face down", 
			"^2 Blind Size if", 
			"hand does not contain", 
			"at least 1 Diamond", 
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('a9a295'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 4},
	debuff = { suit = 'Diamonds' }, 
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then 
				no_suit = true
				for k, v in pairs(G.play.cards) do 
					if v:is_suit(self.debuff.suit, true) then 
						no_suit = not no_suit 
						break 
					end 
				end 
				if no_suit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						G.GAME.blind.chips = G.GAME.blind.chips ^ 2
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						SMODS.juice_up_blind()
						play_sound('may_blind_size')
					return true end})) 
				end 
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and card:is_suit(self.debuff.suit, true) and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_window'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_goad',
	loc_txt = {
		name = 'The Spire',
		text = { 
			"Spades debuffed", 
			"and drawn face down", 
			"^2 Blind Size if", 
			"hand does not contain", 
			"at least 1 Spade", 
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('b95c96'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 11},
	debuff = { suit = 'Spades' }, 
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then 
				no_suit = true
				for k, v in pairs(G.play.cards) do 
					if v:is_suit(self.debuff.suit, true) then 
						no_suit = not no_suit 
						break 
					end 
				end 
				if no_suit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						G.GAME.blind.chips = G.GAME.blind.chips ^ 2
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						SMODS.juice_up_blind()
						play_sound('may_blind_size')
					return true end})) 
				end 
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and card:is_suit(self.debuff.suit, true) and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_goad'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_club',
	loc_txt = {
		name = 'The Mace',
		text = { 
			"Clubs debuffed", 
			"and drawn face down", 
			"^2 Blind Size if",
			"hand does not contain", 
			"at least 1 Club", 
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('b9cb92'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 2},
	debuff = { suit = 'Clubs' }, 
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then 
				no_suit = true
				for k, v in pairs(G.play.cards) do 
					if v:is_suit(self.debuff.suit, true) then 
						no_suit = not no_suit 
						break 
					end 
				end 
				if no_suit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						G.GAME.blind.chips = G.GAME.blind.chips ^ 2
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						SMODS.juice_up_blind()
						play_sound('may_blind_size')
					return true end})) 
				end 
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and card:is_suit(self.debuff.suit, true) and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_club'] >= 1, { allow_duplicates = true }
	end
}

--[[SMODS.Blind {
	key = 'tainted_serpent',
	loc_txt = {
		name = 'The Slither',
		text = { 
			"Draw only 1 card", 
			"when blind is selected", 
			"Draw 2 cards after", 
			"hand is played or discarding"
		}
	},
	calculate = function(self, blind, context)
		if context.drawing_cards then
			if (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
				return {
					cards_to_draw = 2
				}
			else 
				return {
					cards_to_draw = 1
				}
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('439a4f'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 13},
	endless = true, 
	tainted = true,
	modifies_draw = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_serpent'] >= 1, { allow_duplicates = true }
	end
}]]

SMODS.Blind {
	key = 'tainted_mark',
	loc_txt = {
		name = 'The Scar',
		text = { 
		    "Immediately discard all", 
			"face cards from full deck",
		}
	},
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.setting_blind then
				for k, v in pairs(G.playing_cards) do
					if v:is_face(true) then 
						draw_card(v.area, G.discard, 100, 'up', false, v)
					end
				end
			end
		end
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6a3847'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 21},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_mark'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_plant',
	loc_txt = {
		name = 'The Overgrowth',
		text = { 
			"Face Cards debuffed", 
			"and drawn face down", 
			"^2 Blind Size if",
			"hand does not contain", 
			"at least 1 Face Card", 
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('709284'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 17},
	debuff = { is_face = true }, 
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then 
				no_suit = true
				for k, v in pairs(G.play.cards) do 
					if v:is_face(true) then 
						no_suit = not no_suit 
						break 
					end 
				end 
				if no_suit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						G.GAME.blind.chips = G.GAME.blind.chips ^ 2
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						SMODS.juice_up_blind()
						play_sound('may_blind_size')
					return true end})) 
				end 
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and card:is_face(true) and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_plant'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_psychic',
	loc_txt = {
		name = 'The Thaumathurge',
		text = { 
		    "Must play exactly",
			"5 cards", 
			"Decreases by 1", 
			"after scoring", 
			"If required cards", 
			"reach 1, reset to 5",
			"and -1 Hand Size permanently",
		}
	},
	config = { cards = 5 },
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.after then
				G.GAME.blind.config.blind.config.cards = G.GAME.blind.config.blind.config.cards - 1
				if G.GAME.blind.config.blind.config.cards == 1 then 
					G.GAME.blind.config.blind.config.cards = 5
					G.hand:change_size(-1)
				end
			end
		end
	end,
	get_loc_debuff_text = function(self)
		return "Must play exactly "..G.GAME.blind.config.blind.config.cards.." cards"
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		return #cards ~= G.GAME.blind.config.blind.config.cards
	end,
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('efc03c'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 10},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_psychic'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_arm',
	loc_txt = {
		name = 'The Tentacle',
		text = { 
			"Halve level of", 
			"all Poker Hands"
		}
	},
    
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('6865f3'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.setting_blind then
				may.level_up_all_hands_hyper(blind, false, 0.5, 0)
			end
		end
	end,
	pos = {x = 0, y = 9},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_arm'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_wheel',
	loc_txt = {
		name = 'The Disk',
		text = { 
			"All cards drawn", 
			"face down", 
			"On play, each", 
			"card held in hand", 
			"has a fixed 1 in 3 chance", 
			"to be flipped"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('50bf7c'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 8},
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		if not blind.disabled then
			if context.before then 
				for k, v in ipairs(G.hand.cards) do
					if SMODS.pseudorandom_probability(blind, "may_tainted_wheel", 1, 3, "The Disk") then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v:flip()
							v:juice_up(0.3, 0.5)
							play_sound('card1')
						return true end})) 
					end 
				end
			end
		end
	end,
	stay_flipped = function(self, area, card)
        if area == G.hand and not G.GAME.blind.disabled then
            return true
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_plant'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_water',
	loc_txt = {
		name = 'The Tsunami',
		text = { 
			"Start with", 
			"0 discards",
			"Modified cards in", 
			"first hand drawn", 
			"are discarded"
		}
	},
    
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('c6e0eb'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.discards_sub = G.GAME.current_round.discards_left
                ease_discard(-blind.discards_sub)
            end
			if context.first_hand_drawn then
				G.E_MANAGER:add_event(Event({func = function()
				    for k, v in pairs(G.hand.cards) do
					    if v.config.center ~= G.P_CENTERS.c_base or v.seal or v.edition then
						    draw_card(v.area, G.discard, 100, 'up', false, v)
					    end 
				    end
				return true end}))
			end
        end
    end,
	pos = {x = 0, y = 12},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_water'] >= 1, { allow_duplicates = true }
	end
}

--[[SMODS.Blind {
	key = 'tainted_pillar',
	loc_txt = {
		name = 'The Skyscraper',
		text = { 
			"Cards previously played", 
			"this Ante are debuffed",
			"Played debuffed cards", 
			"return to deck after scoring"
		}
	},
    
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('7e6752'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and context.debuff_card.ability.played_this_ante then
                return {
                    debuff = true
                }
            end
			if context.after then 
				for k, v in pairs(G.play.cards) do
					if v.debuff then
						draw_card(v.area, G.deck, 100, 'up', false, v)
					end 
				end
			end
        end
    end,
	pos = {x = 0, y = 14},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_pillar'] >= 1, { allow_duplicates = true }
	end
}]]

SMODS.Blind {
	key = 'tainted_hook',
	loc_txt = {
		name = 'The Anchor',
		text = { 
			"Discard 4 random", 
			"cards held in hand on play", 
			"On discard, unselected cards", 
			"are discarded as well"
		}
	},
    
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('a84024'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({func = function()
					G.GAME.TAINTED_HOOK_DISCARDING = true
                    local any_selected = nil
                    local _cards = {}
                    for _, playing_card in ipairs(G.hand.cards) do
                        _cards[#_cards + 1] = playing_card
                    end
                    for i = 1, 4 do
                        if G.hand.cards[i] then
                            local selected_card, card_index = pseudorandom_element(_cards, 'vremade_hook')
                            G.hand:add_to_highlighted(selected_card, true)
                            table.remove(_cards, card_index)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                return true end}))
                blind.triggered = true
                delay(0.7)
                G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4)
						G.GAME.TAINTED_HOOK_DISCARDING = false
					return true end}))
                    play_sound('tarot2', 1, 0.4)
                return true end}))
                delay(0.4)
            end
        end
		if context.pre_discard then
			G.E_MANAGER:add_event(Event({func = function()
				if not G.GAME.TAINTED_HOOK_DISCARDING then
					local _cards = {}
					for _, playing_card in ipairs(G.hand.cards) do
						if not table_hasvalue(context.full_hand, playing_card) then
							_cards[#_cards + 1] = playing_card
						end
					end
					for i = 1, #_cards do
						if G.hand.cards[i] then
							draw_card(G.hand.cards[i].area, G.deck, 100, 'up', false, _cards[i])
							play_sound('card1', 1)
						end
					end
				end
			return true end}))
				blind.triggered = true
				delay(0.7)
				G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
					if not G.GAME.TAINTED_HOOK_DISCARDING then
						SMODS.juice_up_blind()
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
							play_sound('tarot2', 0.76, 0.4)
						return true end}))
						play_sound('tarot2', 1, 0.4)
					end
				return true end}))
			delay(0.4)
		end
    end,
	pos = {x = 0, y = 5},
	endless = true, 
	tainted = true,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_hook'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_tooth',
	loc_txt = {
		name = 'The Incisor',
		text = { 
			"Divide money by", 
			"the number of played",
			"cards + 1 before scoring"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('b52d2d'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 20},
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
		 if not blind.disabled then
            if context.before then
				may.hypermoney(0, 1 / (#G.play.cards + 1))
				blind.triggered = true
                G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4)
                    return true end}))
                play_sound('tarot2', 1, 0.4)
                return true end}))
                delay(0.4)
			end 
		end 
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_tooth'] >= 1, { allow_duplicates = true }
	end
}

--[[SMODS.Blind {
	key = 'tainted_house',
	loc_txt = {
		name = 'The Foundry',
		text = { 
			"First hand drawn is", 
			"discarded", 
			"Hand drawn afterwards", 
			"is drawn face down"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('5186a8'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 1},
	endless = true, 
	tainted = true,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
				if blind.prepped then
				    return {
                        stay_flipped = true
                    }
				else
					blind.prepped = true 
					G.E_MANAGER:add_event(Event({func = function()
						if #G.hand.cards > 0 then
						    for k, v in pairs(G.hand.cards) do 
							    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
								    v.highlighted = true
								    play_sound('card1')
								    draw_card(G.hand, G.discard, 100, 'down', false, v)
							    return true end}))
						    end
					    end
					return true end}))
				end
            end
        end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_house'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_fish',
	loc_txt = {
		name = 'The Marine',
		text = { 
			"X2 Hand Size",
			"Do not draw cards", 
			"after discarding", 
			"or playing hand"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('3e85bd'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 3},
	endless = true, 
	tainted = true,
	modifies_draw = true,
    calculate = function(self, blind, context)
		if context.setting_blind then
			local num = G.hand.config.card_limit 
			G.hand:change_size(num)
			G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + num
		end
        if context.drawing_cards then
			if (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
				return {
					cards_to_draw = 0
				}
			end
		end
    end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_house'] >= 1, { allow_duplicates = true }
	end
}]]

SMODS.Blind {
	key = 'tainted_eye',
	loc_txt = {
		name = 'The Gaze',
		text = { 
			"Only least played", 
			"Poker Hand scores",
			"(prioritizes lower", 
			"scoring hands)"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('4b71e4'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 15},
	endless = true, 
	tainted = true,
    debuff_hand = function(self, cards, hand, handname, check)
		if handname ~= lphand() then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	get_loc_debuff_text = function(self)
		return "Can only play "..localize(lphand(), 'poker_hands')
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_eye'] >= 1, { allow_duplicates = true }
	end
}

SMODS.Blind {
	key = 'tainted_mouth',
	loc_txt = {
		name = 'The Jaw',
		text = { 
			"Play 1 hand,", 
			"can only play", 
			"Poker Hand with", 
			"highest level"
		}
	},
	boss = {
		min = 1,
		max = 10
	}, 
	boss_colour = HEX('ae718e'),
	dollars = 15,
	mult = 5,
	atlas = "taintedblind",
	pos = {x = 0, y = 16},
	endless = true, 
	tainted = true,
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                local num = G.GAME.current_round.hands_left - 1
                ease_hands_played(-num)
            end 
		end
	end, 
    debuff_hand = function(self, cards, hand, handname, check)
		if handname ~= may.hihand() then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	get_loc_debuff_text = function(self)
		return "Can only play "..localize(may.hihand(), 'poker_hands')
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.GAME.bosses_used['bl_mouth'] >= 1, { allow_duplicates = true }
	end
}