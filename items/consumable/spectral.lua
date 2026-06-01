-- Spectral cards
	
SMODS.Consumable {
	set = 'Spectral',
	key = 'phantom',
	pos = { x = 2, y = 2 },
	config = { extra = { cards = 2 } }, 
	atlas = 'placeholder',
	loc_txt = {
		name = 'Phantom',
		text = {
			"Create {C:attention}#1#{} random", 
			"{C:spectral}Spectral Cards{}", 
			"{C:inactive}(Requires room){}"
		}
	},
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 ))
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end, 
	use = function(self, card)
		for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_phantom')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
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
					local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_phantom')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
		delay(0.6)
	end,
}

SMODS.Consumable {
	set = 'Spectral',
	key = 'aeon',
	pos = { x = 2, y = 2 },
	config = { extra = { cards = 1 } }, 
	atlas = 'placeholder',
	loc_txt = {
		name = 'Aeon', 
		text = {
			"Create #1# {C:attention}copy{} of", 
			"the {C:attention}last{} {C:spectral}Spectral Card{}", 
			"{C:attention}used{} this run", 
			"{C:inactive}(Aeon and hidden Spectrals excluded, requires room){}"
		}
	}, 
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.last_spectral and G.P_CENTERS[G.GAME.last_spectral] or nil
		local last_spectral = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
		local colour = ((not fool_c) or (G.GAME.last_spectral or 'c_may_aeon') == 'c_may_aeon') and G.C.RED or G.C.GREEN
		if fool_c and (G.GAME.last_spectral or 'c_may_aeon') ~= 'c_may_aeon' then
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
							{ n = G.UIT.T, config = { text = ' ' .. last_spectral .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
						}
					}
				}
			}
		}
		return { vars = { card.ability.extra.cards or 1 }, main_end = main_end }
	end, 
	use = function(self, card, copier)
		for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, G.GAME.last_spectral, 'may_aeon')
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
	can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 )) and (G.GAME.last_spectral or 'c_may_aeon') ~= 'c_may_aeon'
	end,
}
    
SMODS.Consumable {
	key = 'amnesia',
	set = 'Spectral',
	name = 'Amnesia',
	loc_txt = {
		name = "Amnesia",
		text = {
			"Add a {C:attention}Copper Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_copper_seal" },
	pos = { x = 0, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'apathy',
	set = 'Spectral',
	name = 'Apathy',
	loc_txt = {
		name = "Apathy",
		text = {
			"Add an {C:attention}Inverted Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_inverted_seal" },
	pos = { x = 1, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'fury',
	set = 'Spectral',
	name = 'Fury',
	loc_txt = {
		name = "Fury",
		text = {
			"Add an {C:attention}Orange Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_orange_seal" },
	pos = { x = 5, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'bargaining',
	set = 'Spectral',
	name = 'Bargaining',
	loc_txt = {
		name = "Bargaining",
		text = {
			"Add a {C:attention}Pink Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_pink_seal" },
	pos = { x = 3, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'conglomerate',
	set = 'Spectral',
	name = 'Conglomerate',
	loc_txt = {
		name = "Conglomerate",
		text = {
			"Add a {C:attention}Silver Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_silver_seal" },
	pos = { x = 1, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'canvas',
	set = 'Spectral',
	name = 'Canvas',
	loc_txt = {
		name = "Canvas",
		text = {
			"Add a {C:attention}White Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_white_seal" },
	pos = { x = 4, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'dream',
	set = 'Spectral',
	name = 'Dream',
	loc_txt = {
		name = "Dream",
		text = {
			"Add a {C:attention}Yellow Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_yellow_seal" },
	pos = { x = 4, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'mesmerize',
	set = 'Spectral',
	name = 'Mesmerize',
	loc_txt = {
		name = "Mesmerize",
		text = {
			"Add a {C:attention}Lime Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_lime_seal" },
	pos = { x = 4, y = 2 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'dependency',
	set = 'Spectral',
	name = 'Dependency',
	loc_txt = {
		name = "Dependency",
		text = {
			"Add a {C:attention}Black Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_black_seal" },
	pos = { x = 3, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'terminal_lucidity',
	set = 'Spectral',
	name = 'Terminal Lucidity',
	loc_txt = {
		name = "Terminal Lucidity",
		text = {
			"Add an {C:may_ethereal,E:1}ERROR Seal{}",
			"to {C:attention}#1#{} selected",
			"card in your hand"
		}
	},
	config = { max_highlighted = 1, extra = "may_error_seal" },
	pos = { x = 2, y = 3 },
	soul_pos = { x = 4, y = 3 },
	atlas = 'may_spectral',
	misc_badge = may_rare_badge,
	cost = 8,
	hidden = true,
	soul_rate = 0.005,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra]
		return { vars = { card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i=1, #G.hand.highlighted, 1 do
			local conv_card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				conv_card:set_seal(card.ability.extra, nil, true)
			return true end}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'delirium',
	set = 'Spectral',
	loc_txt = {
		name = "Delirium",
		text = {
            {
			    "Convert all held {C:attention}consumables{}",
			    "{C:attention}into{} {C:dark_edition}CCDs{} then draw them",
			    "to {C:attention}your hand{}",
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		}
	},
	pos = { x = 0, y = 4 },
	atlas = 'spectral',
	cost = 4,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_ccd_tutorial", set = "Other" }
		return { vars = {} }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.consumeables.cards ~= 0 and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local keys = {}
		local created = {}
		for k, v in pairs(G.consumeables.cards) do
			for i=1, v:getQty(), 1 do
				table.insert(keys, v:gc().key)
			end
		end
		for k, v in pairs(G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card3')
				v:juice_up()
				v:start_dissolve()
			return true end}))
		end
		for i=1, #keys, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
				new:set_ability(keys[i], true, nil)
				new:juice_up()
				play_sound('generic1')
				table.insert(created, new)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			for k, v in pairs(created) do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					table.insert(G.playing_cards, v)
					v:add_to_deck()
					G.play:remove_card(v)
					G.hand:emplace(v)
					play_sound('card1')
				return true end}))
			end
		return true end}))
	end
}

SMODS.Consumable {
	key = 'warp',
	set = 'Spectral',
	loc_txt = {
		name = "Warp",
		text = {
			"{C:attention}#2# Ante{}",
			may.pager(35),
			"Only works if you have {C:attention}at least{} {C:money}$#1#{}", 
			"{C:money}Price{} {C:mult}doubles{} when used"
		}
	},
	pos = { x = 3, y = 3 },
	config = { extra = { ante = -1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.may_warp_price or 30, card.ability.extra.ante } }
	end,
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and to_big(G.GAME.dollars) > to_big(G.GAME.may_warp_price or 30)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.GAME.may_warp_price = (G.GAME.may_warp_price or 30) * 2
		ease_ante(card.ability.extra.ante)
	end
}

SMODS.Consumable {
	key = 'deal',
	set = 'Spectral',
	loc_txt = {
		name = "Deal",
		text = {
			"{C:attention}+#1# Joker Slots{}",
			"{X:money,C:white}X#2#${}"
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	config = { extra = { slots = 2, x_dollars = 0.5 } },
	unlocked = true,
	endless = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots, card.ability.extra.x_dollars } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.jokers:change_size(card.ability.extra.slots)
		may.hypermoney(0, card.ability.extra.x_dollars, false)
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

--[[SMODS.Consumable {
	key = 'morph',
	set = 'Spectral',
	name = 'Morph',
	loc_txt = {
		name = "Morph",
		text = {
			"Convert all {C:attention}selected{} {C:dark_edition}Enhanced{} playing cards",
			"into random {C:spectral}Spectral{} {C:dark_edition}CCD{}s",
			may.pager(40),
			"{C:green}#1# in #2#{} chance to",
			"apply {C:dark_edition}Negative{} to each card",
		}
	},
	config = { extra = { odds = 2 } },
	pos = { x = 2, y = 2 },
	atlas = 'placeholder',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		local count = 0
		for k, v in pairs(G.hand.highlighted) do
			if not SMODS.has_enhancement(v, 'c_base') then
				count = count + 1
			end
		end
		return may.canuse() and count == #G.hand.highlighted and #G.hand.highlighted > 0
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'may_ccd_tutorial', set = 'Other' }
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		local normal, odds = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "Morph")
		return { vars = { normal, odds } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #G.hand.highlighted, 1 do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				G.hand.highlighted[i]:flip()
				play_sound('card1', percent)
				G.hand.highlighted[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #G.hand.highlighted, 1 do
			G.hand.highlighted[i]:set_ability(may.random_consumable('may_morph', nil, 'c_may_morph', G.P_CENTER_POOLS.Spectral, true), nil, true)
		end
		for i=1, #G.hand.highlighted, 1 do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				G.hand.highlighted[i]:flip()
				play_sound('card1', percent)
				G.hand.highlighted[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #G.hand.highlighted, 1 do
			if SMODS.pseudorandom_probability(card, "may_morph", 1, card.ability.extra.odds, "Morph") then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function() 
					G.hand.highlighted[i]:set_edition({negative = true}, true)
					play_sound('tarot1', percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
				return true end}))
			end
		end
	end,
}]]

SMODS.Consumable {
	key = 'morph',
	set = 'Spectral',
	name = 'Morph',
	loc_txt = {
		name = "Morph",
		text = {
			"{C:attention}Select{} a {C:dark_edition}modified{} {C:attention}playing card{}", 
			"Create {C:dark_edition}Negative{} copies of",
			"the {C:dark_edition}Modifier Cards{}", 
			"{C:attention}corresponding{} to its {C:dark_edition}modifiers{},", 
			"then {C:mult}remove{} them", 
			may.pager(45),
			"{C:inactive,s:0.7}Modifier Cards are still WIP, so some modifiers{}", 
			"{C:inactive,s:0.7}will not be converted!{}"
		}
	},
	config = { extra = { odds = 2 } },
	pos = { x = 2, y = 6 },
	atlas = '003_temp',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		if other then
			local edition 
			local enhancement 
			local seal
			if other.edition then
				edition = may.get_modifier_card(other.edition.key)
			end
			if other.config.center ~= G.P_CENTERS.c_base then
				enhancement = may.get_modifier_card(other.config.center.key)
			end
			if other.seal then 
				seal = may.get_modifier_card(other.seal.key)
			end
		    if edition or seal or enhancement then
			    return may.canuse() and #G.hand.highlighted <= (1 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0) and (other.config.center ~= G.P_CENTERS.c_base or other.seal or other.edition)
		    end 
		end
	    return false
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		if G.GAME.blind and G.hand then
		    local other
		    for k, v in pairs(G.hand.highlighted) do 
			    if v ~= card then 
				    other = v
			    end 
		    end
		    local edition 
		    local enhancement 
		    local seal
		    if other then
			    if other.edition then
				    edition = may.get_modifier_card(other.edition.key)
			    end
			    if other.config.center ~= G.P_CENTERS.c_base then
				    enhancement = may.get_modifier_card(other.config.center.key)
			    end
			    if other.seal then 
				    seal = may.get_modifier_card(other.seal.key)
			    end
			    if edition then
				    info_queue[#info_queue + 1] = G.P_CENTERS[edition]
			    end
			    if enhancement then
				    info_queue[#info_queue + 1] = G.P_CENTERS[enhancement]
			    end
			    if seal then
				    info_queue[#info_queue + 1] = G.P_CENTERS[seal]
			    end
		    end
		end
	end,
	use = function(self, card, area, copier)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		local edition 
		local enhancement 
		local seal
		if other.edition then
			edition = may.get_modifier_card(other.edition.key)
		end
		if other.config.center ~= G.P_CENTERS.c_base then
			enhancement = may.get_modifier_card(other.config.center.key)
		end
		if other.seal then 
			seal = may.get_modifier_card(other.seal.key)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
			other:flip()
			play_sound('card1')
			other:juice_up(0.3, 0.3)
		return true end}))
		other:set_ability('c_base', nil, true)
		other:set_edition(nil)
		other:set_seal(nil)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
			other:flip()
			play_sound('tarot1')
			other:juice_up(0.3, 0.3)
		return true end})) 
		if enhancement then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			    local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, enhancement, 'may_morph')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
				card:juice_up(0.3, 0.5)
				play_sound('timpani')
			return true end}))
		end 
		if edition then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			    local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, edition, 'may_morph')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
				card:juice_up(0.3, 0.5)
				play_sound('timpani')
			return true end}))
		end 
		if seal then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			    local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, seal, 'may_morph')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
				card:juice_up(0.3, 0.5)
				play_sound('timpani')
			return true end}))
		end 
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.hand:unhighlight_all()
		return true end}))
	end, 
}

SMODS.Consumable {
	key = 'medusa',
	set = 'Spectral',
	name = 'Medusa',
	loc_txt = {
		name = "Medusa",
		text = {
			"Convert all {C:attention}cards{}", 
			"{C:attention}held in hand{} into", 
			"{C:dark_edition}Stone Cards{}",
		}
	},
	pos = { x = 2, y = 2 },
	atlas = 'placeholder',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #G.hand.cards, 1 do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				G.hand.cards[i]:flip()
				play_sound('card1', percent)
				G.hand.cards[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #G.hand.cards, 1 do
			G.E_MANAGER:add_event(Event({func = function()
			    G.hand.cards[i]:set_ability(G.P_CENTERS['m_stone'], nil, true)
			return true end}))
		end
		for i=1, #G.hand.cards, 1 do
			local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				G.hand.cards[i]:flip()
				play_sound('tarot2', percent)
				G.hand.cards[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'vile',
	set = 'Spectral',
	name = 'Vile',
	loc_txt = {
		name = "Vile",
		text = {
			"{C:attention}Randomize{} all cards {C:attention}held in hand{}",
			may.pager(40),
			"{C:attention}Each{} randomized {C:attention}card{} has",
			"a {C:green}#1# in #2#{} chance to",
			"give {X:money,C:white}X#3#${}",
		}
	},
	config = { extra = { odds = 3, x_dollars = 1.1 } },
	pos = { x = 2, y = 2 },
	atlas = 'placeholder',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "Vile")
		return { vars = { normal, odds, card.ability.extra.x_dollars } }
	end,
	use = function(self, card, area, copier)
		may.randomise(G.hand.cards, false)
		for k, v in pairs(G.hand.cards) do
			if SMODS.pseudorandom_probability(card, "may_vile", G.GAME.probabilities.normal, card.ability.extra.odds, "Vile") then
				may.hypermoney(0, card.ability.extra.x_dollars, false)
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'X'..card.ability.extra.x_dollars..'$', colour = G.C.MONEY, delay = 0.45})
			end
		end
	end,
}

--[[SMODS.Consumable {
	key = 'roulette',
	set = 'Spectral',
	name = 'Roulette',
	loc_txt = {
		name = "Roulette",
		text = {
			"{C:attention}Randomize{} all cards {C:attention}in full deck{}",
		}
	},
	pos = { x = 2, y = 2 },
	atlas = 'placeholder',
	cost = 6,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and G.hand.cards
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.randomise(G.deck.cards, true)
		may.randomise(G.discard.cards, true)
		may.randomise(G.hand.cards, false)
	end,
}]] 

SMODS.Consumable {
	key = 'finalize',
	set = 'Spectral',
	name = 'Finalize',
	loc_txt = {
		name = "Finalize",
		text = {
			"Apply {C:dark_edition}Alloy{}, {C:dark_edition}Dichromatic{}",
			"or {C:dark_edition}Inverted{} to {C:attention}#1#{} selected",
			"{C:attention}playing card{}"
		}
	},
	pos = { x = 2, y = 2 },
	atlas = 'placeholder',
	cost = 4,
	unlocked = true,
	config = { extra = { cards = 1 } },
	endless = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.highlighted) do
			if v.edition then
				return false
			end
		end
		return may.canuse() and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_alloy
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_dichromatic
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_inverted
		return { vars = { card.ability.extra.cards } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.highlighted) do
			v:set_edition(pseudorandom_element({'e_may_alloy', 'e_may_dichromatic', 'e_may_inverted'}, pseudoseed('may_finalize')))
		end
		G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
			G.hand:unhighlight_all()
		return true end}))
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'starfall',
	set = 'Spectral',
	name = 'Starfall',
	loc_txt = {
		name = "Starfall",
		text = {
			{
			    "Gain {C:money}money{} equal to",
			    "the {C:attention}number of times{}",
			    "{C:attention}most played{} {C:purple}Poker Hand{}",
			    "{C:attention}was played{} this run",
			    "{C:inactive}Will give $#1#{}"
			},
			{
				"{C:inactive,E:1}Art by s_n_i_p_e_r.{}"
			}
		}
	},
	pos = { x = 1, y = 4 },
	atlas = 'spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and G.GAME.hands[may.favhand()].played > 0
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.hands[may.favhand()].played } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			card:juice_up(0.3, 0.5)
		return true end}))
		ease_dollars(G.GAME.hands[may.favhand()].played)
	end,
}

SMODS.Consumable {
	key = 'potent',
	set = 'Spectral',
	loc_txt = {
		name = "Potent",
		text = {
			"Create {C:attention}#1#{} {C:dark_edition}Negative{} {C:mult}Perishable{}", 
			"copy of {C:attention}Blueprint{} with", 
			"{C:mult}0{} {C:money}sell value{}", 
			may.pager(50), 
			"{C:mult}Does not work{} if you", 
			"own {C:attention}#2#{} or more copies of {C:attention}Blueprint{}",
		}
	},
	pos = { x = 5, y = 3 },
	atlas = 'may_spectral',
	cost = 4,
	config = { extra = { copies = 1 } },
	endless = true,
	unlocked = true,
	can_use = function(self, card)
		local found = 0
		for k, v in pairs(G.jokers.cards or {}) do
			if v:gc().key == 'j_blueprint' then 
				found = found + 1
			end 
		end
		return found < 4 + (G.GAME.may_potent_limit or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.copies, 4 + (G.GAME.may_potent_limit or 0) } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, card.ability.extra.copies do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() 
				play_sound('timpani')
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_blueprint', 'may_potent')
				card2:add_to_deck()
				G.jokers:emplace(card2)
				card:juice_up(0.3, 0.5)
				card2:set_edition('e_negative')
				card2:set_perishable(true)
				card2.sell_cost = 0
			return true end}))
		end
	end, 
	in_pool = function(self, args)
		local prints = 0
		for k, v in pairs(G.jokers.cards) do 
			if v:gc().key == 'j_blueprint' then 
				prints = prints + 1
			end 
			if prints > 3 + (G.GAME.may_potent_limit or 0) then 
				return false, { allow_duplicates = false }
			end 
		end 
		return true, { allow_duplicates = false }
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}
if may.conf.Mode == 2 then
	
SMODS.Consumable {
	key = 'astronomy',
	set = 'Spectral',
	loc_txt = {
		name = "Astronomy",
		text = {
			"Creates {C:attention}#1# random{} {X:mult,C:white}Rare{} {C:planet}Planet{} Card",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	config = { planets = 1 },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.planets or self.config.planets } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(card.ability.planets*number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_astronomy')), 'may_astronomy')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'celestra',
	set = 'Spectral',
	loc_txt = {
		name = "Celestra",
		text = {
			"Creates {C:attention}#1# random{} {X:legendary,C:white}Legendary{} {C:planet}Planet{} Card",
			"{C:inactive}(requires room){}"
		}
	},
	pos = { x = 5, y = 0 },
	soul_pos = { x = 0, y = 1 },
	atlas = 'may_spectral',
	cost = 8,
	hidden = true,
	soul_rate = 0.05,
	soul_set = 'Spectral',
	config = { planets = 1 },
	unlocked = true,
	misc_badge = may_uncommon_badge,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.planets or self.config.planets } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(card.ability.planets*number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.legendary_planets, pseudoseed('may_celestra')), 'may_celestra')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end, 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

end

-- Spectral Planets
may.spectral_planet_rate = 0.005

-- key, display name, hand, x, y
may.generic_spectral_planets = {
	{'mercurius', 'Mercurius', 'Pair', 0, 0}, 
	{'venos', 'Venös', 'Three of a Kind', 1, 0}, 
	{'terra', 'Terra', 'Full House', 2, 0},
	{'marte', 'Martë', 'Four of a Kind', 3, 0}, 
	{'iupiterus', 'Iupiterus', 'Flush', 4, 0}, 
	{'saturnus', 'Saturnus', 'Straight', 0, 1}, 
	{'uranos', 'Uranös', 'Two Pair', 1, 1}, 
	{'neptunus', 'Neptunus', 'Straight Flush', 2, 1}, 
	{'ploto', 'Plotö', 'High Card', 3, 1}, 
	{'nonuvus', 'Nonuvus', 'Five of a Kind', 4, 1}, 
	{'ceves', 'Cevës', 'Flush House', 0, 2}, 
	{'eres', 'Ëres', 'Flush Five', 1, 2}, 
}

for k, v in pairs(may.generic_spectral_planets) do
	SMODS.Consumable {
		key = v[1],
		set = 'Spectral',
		name = v[2],
		loc_txt = {
			name = {v[2], "{C:dark_edition,s:0.7}Spectral Planet{}"}, 
			text = {
				"Use the {C:planet}Jovian Moon{} and {C:planet}Saturnian Moon{}",
				"of {C:attention}#1#{} then",
				"{C:planet}level up{} {C:attention}#1#{} by {C:attention}#2#{}"
			}
		},
		pos = { x = v[4], y = v[5] },
		config = { extra = { hand = v[3], level = 5 } },
		atlas = 'spectral_planet',
		cost = 6,
		no_grc = true,
		hidden = true, 
		endless = true, 
		soul_set = 'Planet', 
		soul_rate = may.spectral_planet_rate,
		pools = { SpectralPlanet = true }, 
		unlocked = true,
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.hand, card.ability.extra.level } }
		end,
		discovered = true,
		use = function(self, card, area, copier)
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('card3')
				local card2 = create_card('Planet', G.play, nil, nil, nil, nil, may.jovianhand(card.ability.extra.hand), 'may_'..v[1])
				card:juice_up(0.3, 0.5)
				G.play:emplace(card2)
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('card3')
				local card2 = create_card('Planet', G.play, nil, nil, nil, nil, may.saturnianhand(card.ability.extra.hand), 'may_'..v[1])
				card:juice_up(0.3, 0.5)
				G.play:emplace(card2)
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in pairs(G.play.cards) do
					if v ~= card then 
						v:use_consumeable(G.play)
						play_sound('generic1')
						v:juice_up(0.3, 0.5)
					end
				end
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				may.th(card.ability.extra.hand)
				level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.level)
				may.ch()
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in pairs(G.play.cards) do
					if v ~= card then 
						v:start_dissolve()
					end
				end
			return true end}))
		end,
		in_pool = function(self, args)
			return SMODS.is_poker_hand_visible(v[3]) and G.GAME.may_endless_mode, { allow_duplicates = false }
		end, 
	}
end

SMODS.Consumable {
	key = 'gray_hole',
	set = 'Spectral',
	name = 'Gray Hole',
	loc_txt = {
		name = {"Gray Hole", "{C:dark_edition,s:0.7}Spectral Planet{}"}, 
		text = {
			"{C:planet}Level up{} a {C:attention}random{}", 
			"{C:purple}Poker Hand{} by {C:attention}#1#{}"
		}
	},
	pos = { x = 2, y = 2 },
	config = { extra = { level = 7 } },
	atlas = 'spectral_planet',
	cost = 6,
	no_grc = true, 
	hidden = true, 
	soul_set = 'Planet', 
	soul_rate = may.spectral_planet_rate, 
	pools = { SpectralPlanet = true }, 
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local hand = may.rndhand()
		may.th(hand)
		level_up_hand(card, hand, false, card.ability.extra.level)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		for i=1, number do 
			level_up_hand(card, may.rndhand(), true, card.ability.extra.level)
		end 
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
		may.hlv('+'..card.ability.extra.level, true)
		delay(1.3)
		may.ch()
	end
} 

SMODS.Consumable {
	key = 'galileo',
	set = 'Spectral',
	name = 'Galileo',
	loc_txt = {
		name = {"Galileo", "{C:dark_edition,s:0.7}Spectral Planet{}"}, 
		text = {
			"Create {C:dark_edition}Negative{} copies of", 
			"the {C:attention}last{} {C:attention}5{} {X:common,C:white}Common{} {C:planet}Planet Cards{}", 
			"used this run", 
			"{C:inactive}Will create fewer if less than{}", 
			"{C:inactive}5 Planet Cards were used this run{}"
		}
	},
	pos = { x = 3, y = 2 },
	atlas = 'spectral_planet',
	cost = 6,
	no_grc = true,
	hidden = true, 
	soul_set = 'Planet', 
	soul_rate = may.spectral_planet_rate,
	pools = { SpectralPlanet = true }, 
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #(G.GAME.may_galileo_data or {}) > 0
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		if Engulf and card.edition then 
			info_queue[#info_queue + 1] = { key = "may_enf_galileo", set = "Other" } 
		end
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.may_galileo_data) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
				local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, v, 'may_galileo')
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
				card2:set_edition((Engulf and card.edition) and card.edition.key or 'e_negative')
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'icarus',
	set = 'Spectral',
	name = 'Icarus',
	loc_txt = {
		name = {"Icarus", "{C:dark_edition,s:0.7}Spectral Planet{}"}, 
		text = {
            "Each card {C:attention}held in hand{}", 
			"levels up {C:attention}R{} random {C:purple}Poker Hands{}", 
			"by {C:chips}C{}",
			may.pager(50),
			"{C:attention}R{} is the card's {C:attention}rank{}", 
			"{C:chips}C{} is the card's total {C:chips}+Chips{}", 
            "{X:attention,C:white}X0.02{}",
			may.pager(50),
			"{C:inactive}R for modded ranks is 15{}", 
			"{C:inactive}Ignores rankless cards{}"
		}
	},
	pos = { x = 4, y = 2 },
	atlas = 'spectral_planet',
	cost = 6,
	no_grc = true,
	hidden = true, 
	soul_set = 'Planet', 
	soul_rate = may.spectral_planet_rate,
	immutable = true,
	pools = { SpectralPlanet = true }, 
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards > 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			if v:may_get_nominal_chips() then
			    local R = v:get_id() or 15
			    if type(R) ~= 'number' then 
				    R = 15
			    end
			    local C = (v:may_get_nominal_chips() + (v.ability.perma_bonus or 0)) * 0.02
			    for i = 1, R do
				    level_up_hand(v, may.rndhand(), true, C)
			    end
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				    play_sound('generic1')
				    card:juice_up(0.3, 0.5)
			    return true end}))
			    may.h(number_format(R)..' Hands', '...', '...', '')
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hm('+', true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hc('+', true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hlv('+'..number_format(C), true)
				delay(1.3)
				may.ch()
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for k, v in pairs(G.hand.cards) do
			if v:may_get_nominal_chips() then
			    local R = v:get_id() or 15
			    if type(R) ~= 'number' then 
				    R = 15
			    end
                R = R * number
			    local C = (v:may_get_nominal_chips() + (v.ability.perma_bonus or 0)) * 0.02
			    for i = 1, R do
				    level_up_hand(v, may.rndhand(), true, C)
			    end
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				    play_sound('generic1')
				    card:juice_up(0.3, 0.5)
			    return true end}))
			    may.h(number_format(R)..' Hands', '...', '...', '')
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hm('+', true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hc('+', true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot1')
					v:juice_up(0.8, 0.5)
				return true end}))
				may.hlv('+'..number_format(C), true)
				delay(1.3)
				may.ch()
		    end
		end
	end,
}

-- Rare Spectrals

--[[SMODS.Consumable {
	key = 'prestige',
	set = 'Spectral',
	loc_txt = {
		name = "Prestige",
		text = {
			"{C:mult}Destroy{} all {X:may_hyperascendant,C:white}HyperAscendant{} Jokers",
            "Set {C:money}money{} to {C:money}$4{}",
            "For {C:attention}every{} {C:mult}destroyed{} Joker:", 
			may.pager(),
			"Create a {C:attention}random{} {X:may_surreal,C:white}Surreal{} Joker",
			may.pager(),
            "{C:attention}+1 Mega Buffoon Pack{} in future shops", 
			may.pager(),
            "{C:attention}+5{} Joker Slots",
			may.pager(),
            "{X:money,C:white}+X5{} money gain", 
			may.pager(),
            "{X:money,C:white}X0.75{} Fusion prices", 
			may.pager(),
            "{C:green}Reset{} all {X:may_hyperascendant,C:white}HyperAscendant{} {C:dark_edition}Scaling{}",
			may.pager(),
			"{C:mult}Set{} {C:dark_edition}Score Operator{} to {C:mult}X{}", 
			may.pager(),
            "Created {C:attention}Jokers{} will activate", 
            "{X:may_surreal,C:white}Surreal{} {C:dark_edition}Scaling{} after {C:attention}10 rounds{}", 
            "{C:inactive}(Does not require room){}"
		}
	},
	pos = { x = 5, y = 2 },
	soul_pos = { x = 0, y = 3, extra = { x = 1, y = 3 }},
	atlas = 'may_spectral',
	cost = 125,
	no_grc = true,
	hidden = true,
	endless = true, 
	soul_rate = 0.03,
	soul_set = 'Spectral',
	misc_badge = may_epic_badge,
	unlocked = true,
	can_use = function(self, card)
		if G.GAME.may_surreal_sleeve_alt then
			return may.canuse() and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		else
			return may.canuse()
		end
	end,
	discovered = true,
	use = function(self, card, area, copier)
        local amount = 0
		ease_dollars(-(G.GAME.dollars - 4))
		local _first_dissolve = nil
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == 'may_hyperascendant' then
                amount = amount + 1
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
                return true end}))
			end
		end
		G.GAME.may_hyperascendant_scaling = 0
        G.GAME.may_mega_boosters = (G.GAME.may_mega_boosters or 0) + amount
        G.jokers:change_size(5 * amount)
        G.GAME.may_money_multiplier = (G.GAME.may_money_multiplier or 0) + (5 * amount) 
        for i=1, amount do 
            G.GAME.may_fusion_price_multiplier = (G.GAME.may_fusion_price_multiplier or 1) * 0.75 
		    G.E_MANAGER:add_event(Event({trigger = "after",delay = 0.4,func = function()
			    local card2 = create_card('Joker', G.jokers, nil, 'may_surreal', nil, nil, nil, 'may_prestige')
			    G.jokers:emplace(card2)
			    play_sound('may_thunder'..math.random(1,2), 1, 0.75)
			    play_sound('may_surreal_joker', 1, 0.75)
			    card2:add_to_deck()
			    card2:juice_up(1,1)
		    return true end}))
		    may.add_round_timer(10, 'surreal_get')
        end
		SMODS.set_scoring_calculation('multiply')
		may.a('Surreal scaling(s) will activate in 10 rounds!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
	end,
	in_pool = function(self, args)
        if G.jokers.cards then
            for k, v in pairs(G.jokers.cards) do 
                if v:gc().rarity == 'may_hyperascendant' then
                    return G.GAME.round > 30 and G.GAME.may_endless_mode, {allow_duplicates = false}
                end 
            end 
        end
	end
}]] 

SMODS.Consumable {
	key = 'genesis',
	set = 'Spectral',
	name = 'Genesis',
	loc_txt = {
		name = "Genesis",
		text = {
			"Create a copy of {C:dark_edition}Universal Collapse{}",
			"{X:may_instability,C:white}X0.5{} Instability and {X:attention,C:white}X#1#{} Ante", 
			"{X:attention,C:white}X2{} {X:attention,C:white}XAnte{} when used",
			"{C:inactive}Requires room{}"
		}
	},
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 },
	atlas = 'may_spectral',
	misc_badge = may_uncommon_badge,
	cost = 17,
	unlocked = true,
	endless = true,
	custom_soul_anim = function(self, layer)
		--[[local scale_mod = math.sin(G.TIMERS.REAL / 3) / 6
		local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) + 0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2 + (math.random(-500, 500) / 10000)]]
		
		local scale_mod = 0.05 + 0.03 * math.sin(22 * G.TIMERS.REAL) + 0.15 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 20) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
		local rotate_mod = 0.05 + 0.08 * math.cos(22 * G.TIMERS.REAL) + 0.6 * math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL + 1)) * math.pi * 25) * (0.7 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3

		self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, nil, nil, 0.6)
		self.children.floating_sprite:draw_shader('dissolve',nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end,
	can_use = function(self, card)
		return may.canuse() and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	discovered = true,
	no_grc = true, 
	hidden = true,
	soul_rate = 0.3,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_may_universal_collapse
		return { vars = { G.GAME.may_genesis_ante or 1.5 } }
	end,
	use = function(self, card, area, copier)
		G.GAME.may_genesis_ante = G.GAME.may_genesis_ante or 1.5
		G.GAME.rounds_since_genesis = 0
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
		    local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
		    G.jokers:emplace(card2)
		    play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		    card2:add_to_deck()
			card2:juice_up(0.6, 1)
			G.jokers:juice_up(0.3, 0.5)
			G.ROOM.jiggle = G.ROOM.jiggle + 5
			G.GAME.may_genesis_ante = G.GAME.may_genesis_ante * 2
		return true end})) 
		may.ease_instability(0, 0.5)
		if not G.GAME.may_unstable_sleeve_alt then
			ease_ante(G.GAME.round_resets.ante * (G.GAME.may_genesis_ante - 1))
		end 
	end,
	in_pool = function(self, args)
		return #SMODS.find_card('j_may_universal_collapse') == 0 and G.GAME.may_endless_mode --[[and G.GAME.may_tr1_reached]] and (G.GAME.rounds_since_genesis or 0) >= 6, {allow_duplicates = false}
	end
}