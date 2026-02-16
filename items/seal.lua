-- Seals

SMODS.Seal {
	key = 'copper_seal',
	loc_txt = {
		name = 'Copper Seal',
		label = 'Copper Seal',
		text = {
			"{C:mult}Destroy{} {C:attention}this card{}",
			"to redeem a {C:attention}random{} regular {C:green}Voucher{}"
		}
	},
	atlas = 'seal',
	pos = { x = 0, y = 0 },
	badge_colour = HEX('995b37'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.cardarea ~= G.discard and table_hasvalue(context.removed, card) then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				may.voucher(may.get_next_voucher_key())
			return true end}))
		end
	end,
	draw = function(self, card, layer)
		G.shared_seals["may_copper_seal"].role.draw_major = card
		G.shared_seals["may_copper_seal"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["may_copper_seal"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

SMODS.Seal {
	key = 'lime_seal',
	loc_txt = {
		name = 'Lime Seal',
		label = 'Lime Seal',
		text = {
			"{X:chips,C:white}X#1#{} Chips",
			"{C:attention}Increases{} by {X:chips,C:white}+X0.1{} when {C:mult}discarded{}"
		}
	},
	atlas = 'seal',
	pos = { x = 3, y = 0 },
	config = { x_chips = 1.4 },
	badge_colour = HEX('acf097'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.seal.x_chips } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_chips = card.ability.seal.x_chips
			}
		end
		if context.discard and context.other_card == card then
			card.ability.seal.x_chips = card.ability.seal.x_chips + 0.1
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

SMODS.Seal {
	key = 'inverted_seal',
	loc_txt = {
		name = 'Inverted Seal',
		label = 'Inverted Seal',
		text = {
			"{C:green}#1# in 8{} chance to",
			"{C:attention}create{} a {C:dark_edition}Negative{} {C:attention}copy{} of a {C:attention}random{}",
			"held {C:attention}consumable{} at the {C:attention}end of round{}",
			"if this card is {C:attention}held in hand{}"
		}
	},
	atlas = 'seal',
	pos = { x = 4, y = 0 },
	badge_colour = HEX('ff6200'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal } }
	end, 
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.hand and #G.consumeables.cards > 0 then
			if pseudorandom('may_inverted_seal') < G.GAME.probabilities.normal / 8 then
                local targets = {}
                for k, v in pairs(G.consumeables.cards) do 
                    if (not v:gc().hidden) and (not v:gc().no_doe) and (not v:gc().no_grc) then 
                        table.insert(targets, v)
                    end
                end
                if #targets > 0 then
				    local target = pseudorandom_element(targets, pseudoseed("may_inverted_seal"))
				    G.E_MANAGER:add_event(Event({func = function()
					    local card_copy = copy_card(target, nil)
						card_copy:setQty(1)
					    card_copy:set_edition({negative = true}, true)
					    card_copy:add_to_deck()
					    G.consumeables:emplace(card_copy)
					    card:juice_up()
				    return true end}))
                end
			end
		end
	end
}

SMODS.Seal {
	key = 'orange_seal',
	loc_txt = {
		name = 'Orange Seal',
		label = 'Orange Seal',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"{C:attention}Increases{} by {X:mult,C:white}+X0.1{} when {C:attention}played{}"
		}
	},
	atlas = 'seal',
	pos = { x = 5, y = 0 },
	badge_colour = HEX('ff5900'),
	config = { x_mult = 1.4 },
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.seal.x_mult } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = card.ability.seal.x_mult
			}
		end
		if context.before and context.cardarea == G.play then
			card.ability.seal.x_mult = card.ability.seal.x_mult + 0.1
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
		end
	end
}

SMODS.Seal {
	key = 'pink_seal',
	loc_txt = {
		name = 'Pink Seal',
		label = 'Pink Seal',
		text = {
			"{X:planet,C:white}X1.25{} level of {C:attention}played{}", 
			"{C:purple}Poker Hand{} but {X:money,C:white}X0.85${}", 
			"after {C:attention}scoring{} if played"
		}
	},
	atlas = 'seal',
	pos = { x = 6, y = 0 },
	badge_colour = HEX('ff00ea'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.after then
			may.level_up_hand_hyper(card, context.scoring_name, nil, 1.25, 0)
			return {
				x_dollars = 0.85
			}
		end
	end
}

SMODS.Seal {
	key = 'silver_seal',
	loc_txt = {
		name = 'Silver Seal',
		label = 'Silver Seal',
		text = {
			"{X:mult,C:white}X1.2{} Mult if {C:attention}held in hand{}",
			"Additional {X:mult,C:white}+X0.3{} Mult for every card",
			"with {C:attention}Silver Seal{} held in hand"
		}
	},
	atlas = 'seal',
	pos = { x = 7, y = 0 },
	badge_colour = HEX('ababab'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.main_scoring then
			local bonus = 0
			for k, v in pairs(G.hand.cards) do
				if v.seal == 'may_silver_seal' then 
					bonus = bonus + 1
				end
			end
			 return {
				x_mult = 1.2 + (bonus * 0.3),
				card = card
			}
		end
	end,
	draw = function(self, card, layer)
		G.shared_seals["may_silver_seal"].role.draw_major = card
		G.shared_seals["may_silver_seal"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["may_silver_seal"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

SMODS.Seal {
	key = 'white_seal',
	loc_txt = {
		name = 'White Seal',
		label = 'White Seal',
		text = {
			"{X:attention,C:white}X10{} Nominal Chips"
		}
	},
	atlas = 'seal',
	pos = { x = 8, y = 0 },
	badge_colour = HEX('ffffff'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if card then
			card.ability.nominal_multiplier = 10
		end
	end
}

SMODS.Seal {
	key = 'yellow_seal',
	loc_txt = {
		name = 'Yellow Seal',
		label = 'Yellow Seal',
		text = {
			"{C:green}#1# in 3{} chance to create a",
			"{C:attention}random{} {C:spectral}Spectral{} card when",
			"this card is {C:attention}retriggered{}",
			"{C:inactive}(requires room){}"
		}
	},
	atlas = 'seal',
	pos = { x = 9, y = 0 },
	badge_colour = HEX('fbff00'),
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal } }
	end, 
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if not card.yellow_seal_check then
				card.yellow_seal_check = true
				G.E_MANAGER:add_event(Event({func = function()
					if card then
						card.yellow_seal_check = nil
					end
				return true end }))
			else
				if pseudorandom('may_yellow_seal') < G.GAME.probabilities.normal / 3 then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						if G.consumeables.config.card_limit > #G.consumeables.cards then
							play_sound('timpani')
							local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_yellow_seal')
							card2:add_to_deck()
							G.consumeables:emplace(card2)
							card:juice_up(0.3, 0.5)
						end
					return true end }))
				end
			end
		end
	end
}

SMODS.Seal {
	key = 'black_seal',
	loc_txt = {
		name = 'Black Seal',
		label = 'Black Seal',
		text = {
			"{X:chips,C:white}+X0.2{} Chips for every card",
			"with {C:attention}Black Seal{} in full deck",
			"{C:inactive}Currently {X:chips,C:white}X#1#{} {C:inactive}Chips{}",
		}
	},
	atlas = 'seal',
	pos = { x = 10, y = 0 },
	badge_colour = HEX('000000'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	loc_vars = function(self, info_queue, card)
		local amount = 1
		for k, v in pairs(G.playing_cards or {}) do
			if v.seal == 'may_black_seal' then 
				amount = amount + 0.2
			end
		end
		return { vars = { number_format(amount) } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			local amount = 1
			for k, v in pairs(G.playing_cards) do
				if v.seal == 'may_black_seal' then 
					amount = amount + 0.2
				end
			end
			 return {
				x_chips = amount,
				card = card
			}
		end
	end,
}

SMODS.Seal {
	key = 'error_seal',
	loc_txt = {
		name = 'ERROR Seal',
		label = 'ERROR Seal',
		text = {
			"nil"
		}
	},
	atlas = 'seal',
	pos = { x = 1, y = 0 },
	badge_colour = HEX('ffffff'),
	weight = 0,
	sound = { sound = 'may_error_seal', per = 1.2, vol = 0.3 },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			local operation = math.floor(pseudorandom('may_error_seal')*10)
			if operation == 1 then
				return {
					x_dollars = pseudorandom('may_error_seal', 1, 1.35)
				}
			elseif operation > 9 then
				return {
					ease_dollars = pseudorandom('may_error_seal', 1, 10)
				}
			elseif operation > 8 then
				return {
					ease_discard(0.1)
				}
			elseif operation > 7 then
				return {
					mult = pseudorandom('may_error_seal', 1, 100),
				}
			elseif operation > 6 then
				return {
					e_mult = pseudorandom('may_error_seal', 1, 1.25),
				}
			elseif operation > 5 then
				return {
					e_chips = pseudorandom('may_error_seal', 1, 1.25),
				}
			elseif operation > 4 then
				return {
					x_mult = pseudorandom('may_error_seal', 1, 3),
				}
			elseif operation > 3 then
				return {
					x_chips = pseudorandom('may_error_seal', 1, 3),
				}
			elseif operation > 2 then
				return {
					mult = pseudorandom('may_error_seal', 1, 100),
				}
			elseif operation > 1 then
				return {
					chips = pseudorandom('may_error_seal', 1, 200),
				}
			elseif operation < 1 then
				return {
					ease_hands_played(0.2)
				}
			end
		end
	end
}