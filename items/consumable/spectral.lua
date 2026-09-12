-- Spectral cards
	
SMODS.Consumable {
	set = 'Spectral',
	key = 'phantom',
	pos = { x = 0, y = 5 },
	config = { extra = { cards = 2 } }, 
	atlas = 'spectral',
	loc_txt = {
		name = 'Phantom',
		text = {
			{
				"Create {C:attention}#1#{} random", 
				"{C:spectral}Spectral Cards{}", 
				"{C:inactive}(Requires room){}"
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
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
	pos = { x = 1, y = 5 },
	config = { extra = { cards = 1 } }, 
	atlas = 'spectral',
	may_no_ankh = true,
	loc_txt = {
		name = 'Aeon', 
		text = {
			{
				"Create #1# {C:attention}copy{} of", 
				"the {C:attention}last{} {C:spectral}Spectral Card{}", 
				"{C:attention}used{} this run", 
				"{C:inactive}(Aeon and hidden Spectrals excluded, requires room){}"
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
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
	key = 'malfunction',
	set = 'Spectral',
	name = 'Malfunction',
	loc_txt = {
		name = "Malfunction",
		text = {
			{
				"Add an {C:attention}ERROR Seal{}",
				"to {C:attention}#1#{} selected",
				"card in your hand"
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
		}
	},
	config = { max_highlighted = 1, extra = "may_error_seal" },
	pos = { x = 2, y = 5 },
	atlas = 'spectral', 
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

--[[SMODS.Consumable {
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
}]] 

--[[SMODS.Consumable {
	key = 'warp',
	set = 'Spectral',
	loc_txt = {
		name = "Warp",
		text = {
			"{C:attention}+#1#{} Ante",
			"{C:planet}Levels up{} all {C:purple}Poker{}", 
			"{C:purple}Hands{} by {C:attention}+(Ante X #2#){} afterwards", 
			"{C:inactive}Currently +#3#{}"
		}
	},
	pos = { x = 3, y = 3 },
	config = { extra = { ante = 1, mul = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ante, card.ability.extra.mul, ((G.GAME.round_resets.ante or 1) + card.ability.extra.ante) * card.ability.extra.mul } }
	end,
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	show_ring_display = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		ease_ante(card.ability.extra.ante)
		may.level_up_all_hands(card, false, (G.GAME.round_resets.ante + card.ability.extra.ante) * card.ability.extra.mul)
	end
}]] 

SMODS.Consumable {
	key = 'nemesis',
	set = 'Spectral',
	loc_txt = {
		name = "Nemesis",
		text = {
			"{C:mult}Destroys{} a random {C:mult}non-{}{C:dark_edition}Fusion{} {C:attention}Joker{}", 
			"Earn {X:attention,C:white}X#1#{} its {C:money}sell value{} as {C:money}Interest{}"
		}
	},
	pos = { x = 2, y = 4 },
	config = { extra = { mul = 0.3 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		return { vars = { card.ability.extra.mul } }
	end,
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do 
			if not v:may_is_fusion() then
				return may.canuse()
			end
		end
		return false
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local pool = {}
		for k, v in pairs(G.jokers.cards) do 
			if not v:may_is_fusion() then
				table.insert(pool, v)
			end
		end
		local choice = pseudorandom_element(pool, pseudoseed('may_nemesis'))
		local value = choice.sell_cost * card.ability.extra.mul
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			choice:juice_up(0.3, 0.5)
			choice:start_dissolve()
			play_sound('card3') 
		return true end})) 
		may.ease_interest(-1, value)
	end
}

SMODS.Consumable {
	key = 'deal',
	set = 'Spectral',
	loc_txt = {
		name = "Deal",
		text = {
			"{C:attention}+#1#{} Joker Slot",
			"{C:mult}-#2#{} Consumable Slots"
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'may_spectral',
	cost = 4,
	config = { extra = { joker_slots = 1, consumable_slots = -2 } },
	unlocked = true,
	endless = true,
	can_use = function(self, card)
		return G.consumeables.config.card_limit >= math.abs(card.ability.extra.consumable_slots) and may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.joker_slots, math.abs(card.ability.extra.consumable_slots) } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.jokers:change_size(card.ability.extra.joker_slots)
		G.consumeables:change_size(card.ability.extra.consumable_slots)
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

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
	pos = { x = 5, y = 4 },
	atlas = 'spectral',
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
				seal = may.get_modifier_card(other.seal)
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
				    seal = may.get_modifier_card(other.seal)
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
			seal = may.get_modifier_card(other.seal)
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
			{
				"Convert all {C:attention}cards{}", 
				"{C:attention}held in hand{} into", 
				"{C:dark_edition}Stone Cards{}",
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
		}
	},
	pos = { x = 3, y = 5 },
	atlas = 'spectral',
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
			{
				"{C:attention}Randomize{} all cards {C:attention}held in hand{}",
				may.pager(40),
				"{C:attention}Each{} randomized {C:attention}card{} has",
				"a {C:green}#1# in #2#{} chance to",
				"give {C:money}+#3#{} Interest Cap",
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
		}
	},
	config = { extra = { odds = 3, interest_cap = 1 } },
	pos = { x = 4, y = 5 },
	atlas = 'spectral',
	cost = 4,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'interest')
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Vile")
		return { vars = { normal, odds, card.ability.extra.interest_cap } }
	end,
	use = function(self, card, area, copier)
		may.randomise(G.hand.cards, false)
		for k, v in pairs(G.hand.cards) do
			if SMODS.pseudorandom_probability(card, "may_vile", 1, card.ability.extra.odds, "Vile") then
				may.ease_interest_cap(-1, card.ability.extra.interest_cap)
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = '+'..card.ability.extra.interest_cap..' Interest Cap', colour = G.C.MONEY, delay = 0.45})
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
			{
				"{C:green}#1# in #2#{} chance to apply {C:dark_edition}Shimmering{},",
				"{C:dark_edition}Laminated{} or {C:dark_edition}Vignette{} to {C:attention}#3#{} selected",
				"{C:attention}playing card{}"
			}, 
			{
				"{C:inactive,E:1}Art by zikir8{}"
			}
		}
	},
	pos = { x = 5, y = 5 },
	atlas = 'spectral',
	cost = 4,
	unlocked = true,
	config = { extra = { cards = 1, odds = 2 } },
	can_use = function(self, card)
		for k, v in pairs(G.hand.highlighted) do
			if v.edition then
				return false
			end
		end
		return may.canuse() and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_vignette
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_shimmering
		info_queue[#info_queue + 1] = G.P_CENTERS.e_may_laminated
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Finalize")
		return { vars = { normal, odds, card.ability.extra.cards } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "may_finalize", 1, card.ability.extra.odds, "Finalize") then 
			for k, v in pairs(G.hand.highlighted) do
				v:set_edition(SMODS.poll_edition({guaranteed = true, options = {'e_may_vignette', 'e_may_laminated', 'e_may_shimmering'}}))
			end
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
				G.hand:unhighlight_all()
			return true end}))
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Spectral,
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
			"Create a {C:attention}random{} {C:chips}base{} {C:dark_edition}Fusable{} {C:attention}Joker{}", 
			"{C:mult}-#1#{} {C:money}Interest Cap{}", 
			"{C:inactive}Does not require room{}"
		}
	},
	pos = { x = 5, y = 3 },
	atlas = 'may_spectral',
	cost = 4,
	config = { extra = { interest_cap = -2 } },
	endless = true,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		return { vars = { math.abs(card.ability.extra.interest_cap) } }
	end, 
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function() 
			play_sound('timpani')
			local card2 = SMODS.create_card({set = 'Joker', attributes = {'base_fusable'}})
			card2:add_to_deck()
			G.jokers:emplace(card2)
			card:juice_up(0.3, 0.5)
		return true end}))
		may.ease_interest_cap(-1, card.ability.extra.interest_cap)
	end, 
	in_pool = function(self, args)
		return G.GAME.may_endless_mode and G.jokers.config.card_limit > 1, { allow_duplicates = false }
	end, 
}
	
SMODS.Consumable {
	key = 'astronomy',
	set = 'Spectral',
	loc_txt = {
		name = "Astronomy",
		text = {
			"{C:green}#1# in #2#{} chance", 
			"to gain a {C:planet}Meteor Tag{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'may_spectral',
	cost = 4,
	unlocked = true,
	config = { extra = { odds = 2 } }, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Astronomy")
		return { vars = { normal, odds } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "may_astronomy", 1, card.ability.extra.odds, "Astronomy") then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				add_tag(Tag('tag_meteor'))
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
		else 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Spectral,
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
		local amount = 0
		for i = 1, number do 
			if SMODS.pseudorandom_probability(card, "may_astronomy", 1, card.ability.extra.odds, "Astronomy") then
				amount = amount + 1
			end 
		end 
		if amount > 0 then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				for i = 1, amount do 
					add_tag(Tag('tag_meteor'))
				end
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
		else 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Spectral,
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
	end
}

--[[SMODS.Consumable {
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
}]] 

-- Spectral Tarots

SMODS.Consumable {
	key = 'hopeless',
	set = 'Spectral',
	loc_txt = {
		name = "The Hopeless",
		text = {
			"Create a {C:dark_edition}Negative{} copy of", 
			"the last {C:attention}Booster Pack{}", 
			"opened this run in your",
			"{C:attention}Consumable Slots{}",
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and G.GAME.may_last_booster
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local fool_c = G.GAME.may_last_booster and G.P_CENTERS[G.GAME.may_last_booster] or nil
		local last_booster = fool_c and localize { type = 'name_text', key = fool_c.key, set = 'Other' } or localize('k_none')
		if last_booster == 'ERROR' then 
			last_booster = localize { type = 'name_text', key = string.sub(fool_c.key or '', 1, -3), set = 'Other' }
		end
		local colour = (not fool_c) and G.C.RED or G.C.DARK_EDITION
		if fool_c then
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
							{ n = G.UIT.T, config = { text = ' ' .. last_booster .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
						}
					}
				}
			}
		}
		return { main_end = main_end }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local card2 = create_card('Booster', G.consumeables, nil, nil, nil, nil, G.GAME.may_last_booster, 'may_galileo')
			card2:add_to_deck()
			G.consumeables:emplace(card2)
			card:juice_up(0.3, 0.5)
			card2:set_edition('e_negative')
		return true end}))
	end,
	in_pool = function(self, args)
		return G.GAME.may_last_booster, { allow_duplicates = false }
	end 
}

SMODS.Consumable {
	key = 'theurgist',
	set = 'Spectral',
	loc_txt = {
		name = "The Theurgist",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {X:mult,C:white}+X#1#{} Mult with a",
			"{C:green}#2# in #3#{} chance to gain {C:money}+$#4#{}"
		}
	},
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { x_mult = 0.5, p_dollars = 5, odds = 4 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Theurgist")
		return { vars = { card.ability.extra.x_mult, normal, odds, card.ability.extra.p_dollars } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_mult..' Mult'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
			v.ability.perma_x_mult = (v.ability.perma_x_mult or 0) + card.ability.extra.x_mult
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
			if SMODS.pseudorandom_probability(card, "may_theurgist", 1, card.ability.extra.odds, "Theurgist") then
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.p_dollars..'$'}, colour = G.C.MONEY, delay = 0.45, sound = 'may_permabonus' })
				v.ability.perma_p_dollars = (v.ability.perma_p_dollars or 0) + card.ability.extra.p_dollars
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
					card:juice_up(0.3, 0.5)
				return true end}))
			end
		end
	end,
}

SMODS.Consumable {
	key = 'regality',
	set = 'Spectral',
	loc_txt = {
		name = "The Regality",
		text = {
			"Create {C:attention}#1#{}",
			"{C:planet}Meteor Tags{}",
		}
	},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { tags = 3 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
		return { vars = { card.ability.extra.tags } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			for i = 1, card.ability.extra.tags do
				add_tag(Tag('tag_meteor'))
			end
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'reign',
	set = 'Spectral',
	loc_txt = {
		name = "The Reign",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {X:mult,C:white}+X#1#{} Mult"
		}
	},
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { x_mult = 1 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_mult..' Mult'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
			v.ability.perma_x_mult = (v.ability.perma_x_mult or 0) + card.ability.extra.x_mult
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'dominus',
	set = 'Spectral',
	loc_txt = {
		name = "The Dominus",
		text = {
			"Create {C:attention}#1#{}",
			"{C:tarot}Charm Tags{}",
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { tags = 3 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_charm
		return { vars = { card.ability.extra.tags } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			for i = 1, card.ability.extra.tags do
				add_tag(Tag('tag_charm'))
			end
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'paladin',
	set = 'Spectral',
	loc_txt = {
		name = "The Paladin",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {X:chips,C:white}+X#1#{} Chips"
		}
	},
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { x_chips = 1 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_chips..' Chips'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus' })
			v.ability.perma_x_chips = (v.ability.perma_x_chips or 0) + card.ability.extra.x_chips
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'coalescent',
	set = 'Spectral',
	loc_txt = {
		name = "The Coalescent",
		text = {
			"Increase {C:money}Interest{} by a {C:attention}quarter{} of",
			"the number of {C:attention}unique Suits{} in full deck",
			may.pager(),
			"{C:dark_edition}Wild Cards{} are {C:mult}omitted{} when calculating",
			"the number and instead give {C:money}+#1#{} Interest Cap",
			may.pager(),
			"{C:inactive}Currently +#2# Interest and +#3# Interest Cap{}",
		}
	},
	pos = { x = 6, y = 0 },
	soul_pos = { x = 6, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { interest_cap = 2.5 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.playing_cards) do
			if not SMODS.has_no_suit(v) then
				return may.canuse()
			end
		end
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'interest')
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		local interest, interest_cap, found = 0, 0, {}
		if G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if not SMODS.has_no_suit(v) and not SMODS.has_any_suit(v) then
					if not table_hasvalue(found, v:may_get_suit()) then
						table.insert(found, v:may_get_suit())
						interest = interest + 0.25
					end
				else
					if SMODS.has_any_suit(v) then
						interest_cap = interest_cap + card.ability.extra.interest_cap
					end
				end
			end
		end
		return { vars = { card.ability.extra.interest_cap, interest, interest_cap } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local interest, interest_cap, found = 0, 0, {}
		for k, v in pairs(G.playing_cards) do
			if not SMODS.has_no_suit(v) and not SMODS.has_any_suit(v) then
				if not table_hasvalue(found, v:may_get_suit()) then
					table.insert(found, v:may_get_suit())
					interest = interest + 0.25
				end
			else
				if SMODS.has_any_suit(v) then
					interest_cap = interest_cap + card.ability.extra.interest_cap
				end
			end
		end
		G.E_MANAGER:add_event(Event({func = function() 
			card:juice_up(0.3, 0.5)
			play_sound('timpani')
		return true end}))
		may.ease_interest(-1, interest)
		if interest_cap > 0 then
			G.E_MANAGER:add_event(Event({func = function() 
				card:juice_up(0.3, 0.5)
				play_sound('timpani')
			return true end}))
			may.ease_interest_cap(-1, interest_cap)
		end
	end,
}

SMODS.Consumable {
	key = 'veneration',
	set = 'Spectral',
	loc_txt = {
		name = "The Veneration",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {X:mult,C:white}+X#1#{} held-in-hand Mult"
		}
	},
	pos = { x = 7, y = 0 },
	soul_pos = { x = 7, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { h_x_mult = 1 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_x_mult } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.h_x_mult..' Mult'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
			v.ability.perma_h_x_mult = (v.ability.perma_h_x_mult or 0) + card.ability.extra.h_x_mult
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'equity',
	set = 'Spectral',
	loc_txt = {
		name = "The Equity",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {X:mult,C:white}+X#1#{} Mult with a",
			"{C:green}#2# in #3#{} chance to be {C:mult}destroyed{}"
		}
	},
	pos = { x = 8, y = 0 },
	soul_pos = { x = 8, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { x_mult = 2, odds = 4 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Equity")
		return { vars = { card.ability.extra.x_mult, normal, odds } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			if SMODS.pseudorandom_probability(card, "may_theurgist", 1, card.ability.extra.odds, "Equity") then
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
					card:juice_up(0.3, 0.5)
					v:juice_up(0.3, 0.5)
				return true end}))
				SMODS.destroy_cards(v)
			else
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_mult..' Mult'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
				v.ability.perma_x_mult = (v.ability.perma_x_mult or 0) + card.ability.extra.x_mult
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
					card:juice_up(0.3, 0.5)
				return true end}))
			end
		end
	end,
}

SMODS.Consumable {
	key = 'entombed',
	set = 'Spectral',
	loc_txt = {
		name = "The Entombed",
		text = {
			"Sets {C:money}money{} to {C:money}Interest Cap{}",
			may.pager(),
			"{X:money,C:white}X#1#${} if {C:money}money{} is",
			"above or equal to {C:money}Interest Cap{}",
		}
	},
	pos = { x = 9, y = 0 },
	soul_pos = { x = 9, y = 3 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { x_dollars = 1.1 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_dollars } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		if G.GAME.dollars < G.GAME.interest_cap then
			G.E_MANAGER:add_event(Event({func = function() 
				card:juice_up(0.3, 0.5)
				play_sound('timpani')
			return true end}))
			ease_dollars(G.GAME.interest_cap - G.GAME.dollars)
		else
			G.E_MANAGER:add_event(Event({func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
			may.hypermoney(0, card.ability.extra.x_dollars)
		end
	end,
}

SMODS.Consumable {
	key = 'predestined',
	set = 'Spectral',
	loc_txt = {
		name = "Predestined",
		text = {
			"Apply random {C:dark_edition}Editions{}", 
			"to all owned {C:attention}Jokers{}", 
			"{C:inactive}Does not override existing Editions{}"
		}
	},
	pos = { x = 0, y = 1 },
	soul_pos = { x = 0, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do
			if not v.edition then
				return may.canuse()
			end
		end
		return false 
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.jokers.cards) do
			if not v.edition then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					v:set_edition(SMODS.poll_edition({ guaranteed = true, no_negative = true }), true)
					v:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
					play_sound('tarot1')
				return true end})) 
			end
		end
	end,
}

SMODS.Consumable {
	key = 'omniscient',
	set = 'Spectral',
	loc_txt = {
		name = "Omniscient",
		text = {
			"Select up to {C:attention}#1#{} cards", 
			"Sets their {C:attention}rank{} to the rank", 
			"of the {C:attention}leftmost{} selected card"
		}
	},
	pos = { x = 1, y = 1 },
	soul_pos = { x = 1, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { highlight = 5 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		local left 
		for k, v in ipairs(G.hand.cards) do 
			if table_hasvalue(G.hand.highlighted, v) then 
				left = v
				break 
			end
		end
		return may.canuse() and left and #G.hand.highlighted > 1 and #G.hand.highlighted <= (card.ability.extra.highlight + (card.area == G.hand and 1 or 0)) and not SMODS.has_no_rank(left)
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.highlight } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local left 
		for k, v in ipairs(G.hand.cards) do 
			if table_hasvalue(G.hand.highlighted, v) then 
				left = v
				break 
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= left then 
				local percent = 1.15 - (k - 0.999) / ((#G.hand.highlighted - 1) - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('card1', percent)
					v:flip()
					v:juice_up(0.3, 0.5)
				return true end})) 
			end
		end
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= left then
				local percent = 0.85 + (k-0.999)/((#G.hand.highlighted - 1)-0.998)*0.3
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					assert(SMODS.change_base(v, nil, SMODS.Ranks[left.base.value].key)) 
					play_sound('tarot2', percent)
					v:flip()
					v:juice_up(0.3, 0.5)
				return true end}))
			end
		end
	end,
}

SMODS.Consumable {
	key = 'retribution',
	set = 'Spectral',
	loc_txt = {
		name = "Retribution",
		text = {
			"{C:money}Sells{} all selected", 
			"{C:attention}playing cards{}", 
			"{C:inactive}Currently +$#1#{}"
		}
	},
	pos = { x = 2, y = 1 },
	soul_pos = { x = 2, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then
				return may.canuse() and #G.hand.highlighted > 0
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'sell_playing')
		local amount = 0
		if G.hand then 
			for k, v in pairs(G.hand.highlighted) do 
				if v ~= card then
					amount = amount + v:may_playing_sell_value()
				end
			end 
		end
		return { vars = { amount } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(G.hand.highlighted) do 
			v:sell_card()
		end
	end,
}

SMODS.Consumable {
	key = 'erasure',
	set = 'Spectral',
	loc_txt = {
		name = "Erasure",
		text = {
			"Select a {C:attention}playing card{}", 
			"All cards to the {C:attention}left{} of", 
			"that card will be {C:attention}converted{}", 
			"into that card,", 
			"with a {C:mult}limit{} of {C:attention}#1#{} cards", 
		}
	},
	pos = { x = 3, y = 1 },
	soul_pos = { x = 3, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { highlight = 3 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		local selected 
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				selected = v
				break
			end
		end
		local limit_reached = false
		if #G.hand.highlighted > (1 + (card.area ==G.hand and 1 or 0)) then 
			return false
		end
		for k, v in ipairs(G.hand.cards) do 
			if v == selected then
				limit_reached = k - 1 > card.ability.extra.highlight
				break
			end
		end
		return may.canuse() and not limit_reached and #G.hand.highlighted > 0 and selected ~= G.hand.cards[1]
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.highlight } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local selected 
		local targets = {}
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				selected = v
				break
			end
		end
		for k, v in ipairs(G.hand.cards) do 
			if v == selected then
				break
			else 
				table.insert(targets, v)
			end
		end 
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card1', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				SMODS.copy_card(selected, { new_card = v })
				play_sound('tarot2', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'equilibrium',
	set = 'Spectral',
	loc_txt = {
		name = "Equilibrium",
		text = {
			"{C:dark_edition}Balance{} {C:money}sell value{} of all", 
			"owned {C:mult}non-{}{C:dark_edition}Fusion Jokers{},", 
			"then increase {C:money}Interest Cap{}", 
			"by the {C:dark_edition}balanced{} amount", 
			"{C:inactive}Balanced amount is currently $#1#{}", 
		}
	},
	pos = { x = 4, y = 1 },
	soul_pos = { x = 4, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do 
			if v.sell_cost ~= 0 then
				return may.canuse()
			end
		end
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local bal = 0
		local num = 0
		if G.jokers then 
			for k, v in pairs(G.jokers.cards) do 
				if not v:may_is_fusion() then
					bal = bal + v.sell_cost
					num = num + 1
				end
			end
			bal = bal / num
		end
		return { vars = { bal } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local bal = 0
		local num = 0
		for k, v in pairs(G.jokers.cards) do 
			if not v:may_is_fusion() then
				bal = bal + v.sell_cost
				num = num + 1
			end
		end
		bal = bal / num
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			may.gong()
			card:juice_up(0.3, 0.5)
		return true end}))
		for k, v in pairs(G.jokers.cards) do
			if not v:may_is_fusion() then 
				v.sell_cost = bal
				G.E_MANAGER:add_event(Event({func = function()
					play_sound('timpani', 1, 0.6)
					v:juice_up(0.2, 0.3)
				return true end}))
			end
		end
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('timpani')
			card:juice_up(0.3, 0.5)
		return true end}))
		may.ease_interest_cap(-1, bal)
	end,
}

SMODS.Consumable {
	key = 'malicious',
	set = 'Spectral',
	loc_txt = {
		name = "The Malicious",
		text = {
			"All cards {C:attention}held in hand{}",
			"gain {C:money}+$#1#{} {C:attention}held-in-hand{}"
		}
	},
	pos = { x = 5, y = 1 },
	soul_pos = { x = 5, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { p_dollars = 7 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.p_dollars } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.cards) do
			card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+#'..card.ability.extra.p_dollars}, colour = G.C.MONEY, delay = 0.45, sound = 'may_permabonus' })
			v.ability.perma_h_p_dollars = (v.ability.perma_h_p_dollars or 0) + card.ability.extra.p_dollars
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function() 
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'citadel',
	set = 'Spectral',
	loc_txt = {
		name = "The Citadel",
		text = {
			"Create {C:attention}#1#{} {C:dark_edition}Stone Cards{} with", 
			"random {C:dark_edition}Editions{} and shuffle them", 
			"into your deck"
		}
	},
	pos = { x = 6, y = 1 },
	soul_pos = { x = 6, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { cards = 10 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.cards } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local created = {}
		for i = 1, card.ability.extra.cards do 
			local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
			new:set_ability(G.P_CENTERS.m_stone)
			new:set_edition(SMODS.poll_edition({ guaranteed = true, no_negative = true }))
			G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
				new:juice_up()
				play_sound('card1')
				play_sound('tarot1')
			return true end}))
			table.insert(created, new) 
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
}

SMODS.Consumable {
	key = 'supernova',
	set = 'Spectral',
	loc_txt = {
		name = "The Supernova",
		text = {
			"Convert all {C:mult}unselected{}",
			"cards {C:attention}held in hand{}", 
			"into {C:diamonds}Diamonds{}",
		}
	},
	pos = { x = 7, y = 1 },
	soul_pos = { x = 7, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { suit = 'Diamonds' } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted then 
				return may.canuse()
			end
		end 
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted and not v:is_suit(card.ability.extra.suit) then 
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card1', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				v:change_suit(card.ability.extra.suit)
				play_sound('tarot2', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'twilight',
	set = 'Spectral',
	loc_txt = {
		name = "The Twilight",
		text = {
			"Convert all {C:mult}unselected{}",
			"cards {C:attention}held in hand{}", 
			"into {C:clubs}Clubs{}",
		}
	},
	pos = { x = 8, y = 1 },
	soul_pos = { x = 8, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { suit = 'Clubs' } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted then 
				return may.canuse()
			end
		end 
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted and not v:is_suit(card.ability.extra.suit) then 
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card1', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				v:change_suit(card.ability.extra.suit)
				play_sound('tarot2', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'aurora',
	set = 'Spectral',
	loc_txt = {
		name = "The Aurora",
		text = {
			"Convert all {C:mult}unselected{}",
			"cards {C:attention}held in hand{}", 
			"into {C:hearts}Hearts{}",
		}
	},
	pos = { x = 9, y = 1 },
	soul_pos = { x = 9, y = 4 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { suit = 'Hearts' } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted then 
				return may.canuse()
			end
		end 
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted and not v:is_suit(card.ability.extra.suit) then 
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card1', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				v:change_suit(card.ability.extra.suit)
				play_sound('tarot2', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'jurisprudence',
	set = 'Spectral',
	loc_txt = {
		name = "Jurisprudence",
		text = {
			"Create {C:attention}#1#{}",
			"{C:attention}Buffoon Tags{}",
		}
	},
	pos = { x = 0, y = 2 },
	soul_pos = { x = 0, y = 5 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { tags = 3 } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_buffoon
		return { vars = { card.ability.extra.tags } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			for i = 1, card.ability.extra.tags do
				add_tag(Tag('tag_buffoon'))
			end
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'universe',
	set = 'Spectral',
	loc_txt = {
		name = "The Universe",
		text = {
			"Convert all {C:mult}unselected{}",
			"cards {C:attention}held in hand{}", 
			"into {C:spades}Spades{}",
		}
	},
	pos = { x = 1, y = 2 },
	soul_pos = { x = 1, y = 5 },
	atlas = 'spectraltarot',
	cost = 8,
	no_grc = true,
	hidden = true, 
	soul_set = 'Tarot', 
	config = { extra = { suit = 'Spades' } },
	soul_rate = 0.002,
	attributes = {
		'spectral_tarot',
	},
	unlocked = true,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted then 
				return may.canuse()
			end
		end 
		return false
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Tarot', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if not v.highlighted and not v:is_suit(card.ability.extra.suit) then 
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end})) 
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('card1', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				v:change_suit(card.ability.extra.suit)
				play_sound('tarot2', percent)
				v:flip()
				v:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}

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
			name = v[2],
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
		attributes = {
			'spectral_planet',
		},
		unlocked = true,
		show_ring_display = true,
		can_use = function(self, card)
			return may.canuse()
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = G.P_CENTERS[may.jovianhand(card.ability.extra.hand)]
			info_queue[#info_queue + 1] = G.P_CENTERS[may.saturnianhand(card.ability.extra.hand)]
			return { vars = { card.ability.extra.hand, card.ability.extra.level } }
		end,
		discovered = true,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge('Spectral Planet', get_type_colour(self or card.config, card), nil, 1.2)
		end,
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
		name = "Gray Hole",
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
	attributes = {
		'spectral_planet',
	},
	unlocked = true,
	show_ring_display = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level } }
	end,
	discovered = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
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
		name = "Galileo",
		text = {
			"Create {C:dark_edition}Negative{} copies of", 
			"the {C:attention}last{} {C:attention}5{} {C:planet}Planet Cards{}", 
			"used this run", 
		}
	},
	pos = { x = 3, y = 2 },
	atlas = 'spectral_planet',
	cost = 6,
	no_grc = true,
	hidden = true, 
	soul_set = 'Planet', 
	soul_rate = may.spectral_planet_rate,
	attributes = {
		'spectral_planet',
	},
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #(G.GAME.may_galileo_data or {}) > 0
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Planet', get_type_colour(self or card.config, card), nil, 1.2)
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
	in_pool = function(self, args)
		return #(G.GAME.may_galileo_data or {}) >= 5
	end 
}

SMODS.Consumable {
	key = 'icarus',
	set = 'Spectral',
	name = 'Icarus',
	loc_txt = {
		name = "Icarus",
		text = {
			"Levels up {C:attention}R{} {C:inactive}(#1#){} random {C:purple}Poker Hands{} by {C:chips}C{} {C:inactive}(#2#){}",
			may.pager(),
			"{C:attention}R{} is the number of cards {C:attention}held in hand{}",
			"{C:chips}C{} is the sum of card {C:attention}Nominal Chips{}", 
			"held in hand {X:attention,C:white}X0.05{}",
			may.pager(),
			"{C:inactive}Duplicate hands are allowed{}"
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
	reserve = true,
	attributes = {
		'spectral_planet',
	},
	unlocked = true,
	show_ring_display = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local c, r = 0, 0
		if G.hand and #G.hand.cards > 0 then
			for k, v in pairs(G.hand.cards) do
				c = c + v:may_get_nominal_chips() * 0.05
			end
			r = #G.hand.cards
		end
		return { vars = { r, c } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards > 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local c = 0
		for k, v in pairs(G.hand.cards) do
			c = c + v:may_get_nominal_chips() * 0.05
		end
		for i = 1, #G.hand.cards do
			level_up_hand(card, may.rndhand(), true, c)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('generic1')
			card:juice_up(0.3, 0.5)
		return true end}))
		may.h(number_format(#G.hand.cards)..' Hands', '...', '...', '')
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
		may.hlv('+'..number_format(c), true)
		delay(0.3)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local c = 0
		for k, v in pairs(G.hand.cards) do
			c = c + v:may_get_nominal_chips() * 0.05
		end
		for i = 1, #G.hand.cards * number do
			level_up_hand(card, may.rndhand(), true, c)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('generic1')
			card:juice_up(0.3, 0.5)
		return true end}))
		may.h(number_format(#G.hand.cards * number)..' Hands', '...', '...', '')
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
		may.hlv('+'..number_format(c), true)
		delay(0.3)
		may.ch()
	end,
}

SMODS.Consumable {
	key = 'demetrius',
	set = 'Spectral',
	name = 'Demetrius',
	loc_txt = {
		name = "Demetrius",
		text = {
			"{C:planet}Level up{} all {C:purple}Poker Hands{} by {C:attention}+#1#{}", 
			"per {C:attention}Rankless{} or {C:attention}Suitless{} card in full deck", 
			"{C:dark_edition}Stone Cards{} give {C:attention}+#2#{} levels instead", 
			"{C:inactive}Currently +#3# levels{}", 
		}
	},
	pos = { x = 4, y = 3 },
	config = { extra = { level1 = 0.05, level2 = 0.1 } },
	atlas = 'spectral_planet',
	cost = 6,
	no_grc = true, 
	hidden = true, 
	soul_set = 'Planet', 
	soul_rate = may.spectral_planet_rate, 
	attributes = {
		'spectral_planet',
	},
	unlocked = true,
	show_ring_display = true,
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
				amount = amount + (SMODS.has_enhancement(v, 'm_stone') and card.ability.extra.level2 or card.ability.extra.level1)
			end 
		end
		return { vars = { card.ability.extra.level1, card.ability.extra.level2, amount } }
	end,
	discovered = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Spectral Planet', get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in pairs(G.playing_cards) do 
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then 
				amount = amount + (SMODS.has_enhancement(v, 'm_stone') and card.ability.extra.level2 or card.ability.extra.level1)
			end 
		end
		may.level_up_all_hands(card, false, amount)
		may.ch()
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		for k, v in pairs(G.playing_cards) do 
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then 
				amount = amount + (SMODS.has_enhancement(v, 'm_stone') and card.ability.extra.level2 or card.ability.extra.level1)
			end 
		end
		may.level_up_all_hands(card, false, amount * number)
		may.ch()
	end, 
	in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do 
			if SMODS.has_no_rank(v) or SMODS.has_no_suit(v) then 
				return true, { allow_duplicates = false }
			end 
		end
		return false, { allow_duplicates = false }
	end
} 

-- Hidden Spectrals

SMODS.Consumable {
	key = 'clan',
	set = 'Spectral',
	name = 'Clan',
	loc_txt = {
		name = "Clan",
		text = {
			"{C:attention}Selects{} a random {C:dark_edition}Seal{} and applies", 
			"it to {C:attention}all{} cards {C:attention}held in hand{}", 
			may.pager(45), 
			"{C:mult}Overwrites{} {C:dark_edition}Seals{} of {C:attention}unselected{} cards,", 
			"if any"
		}
	},
	pos = { x = 3, y = 4 },
	soul_pos = { x = 4, y = 4 },
	atlas = 'may_spectral', 
	cost = 10,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	no_grc = true, 
	hidden = true,
	soul_rate = 0.005,
	use = function(self, card, area, copier)
		local choice = SMODS.poll_seal({ guaranteed = true })
		for k, v in pairs(G.hand.cards) do
			if not (v.seal and table_hasvalue(G.hand.highlighted, v)) then 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
					card:juice_up(0.3, 0.5)
					v:juice_up(0.3, 0.5)
					play_sound('tarot1')
				return true end})) 
				v:set_seal(choice)
			end
		end 
	end,
}

SMODS.Consumable {
	key = 'celestra',
	set = 'Spectral',
	name = 'Celestra',
	loc_txt = {
		name = "Celestra",
		text = {
			"Creates {C:dark_edition}Negative{} {C:chips}hand-specific{} {C:planet}Planet Cards{}", 
			"for each {C:green}discovered{} {C:purple}Poker Hand{}", 
			may.pager(),
			"Base of {C:attention}#1#{} {C:planet}Planet{}, additional {C:attention}#2#{} {C:planet}Planet{}", 
			"for every {C:attention}#3#{} times that", 
			"{C:purple}Poker Hand{} was {C:attention}played{} this run"
		}
	},
	config = { extra = { base = 1, add = 1, times = 2 } }, 
	pos = { x = 5, y = 0 },
	soul_pos = { x = 0, y = 1 },
	atlas = 'may_spectral',
	cost = 15,
	unlocked = true,
	immutable = true,
	endless = true, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.base, card.ability.extra.add, card.ability.extra.times } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	no_grc = true, 
	hidden = true,
	soul_rate = 0.003, 
	use = function(self, card, area, copier)
		for k, v in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(k) and may.planethand(k) then 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					local card2 = SMODS.add_card({ key = may.planethand(k) })
					card2:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
					play_sound('timpani')
					card2:set_edition('e_negative')
					card2:setQty(card.ability.extra.base + math.floor(v.played / card.ability.extra.times) * card.ability.extra.add)
				return true end})) 
			end
		end
	end,
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

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
		name = "{C:may_instability,E:may_transcendent_name}Genesis{}",
		text = {
			"Create a copy of {C:may_instability}Omniversal Catalyst{}",
			"{X:may_instability,C:white}X0.75{} Instability", 
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
		info_queue[#info_queue + 1] = G.P_CENTERS.j_may_omniversal_catalyst
		return { vars = { G.GAME.may_genesis_ante or 3 } }
	end,
	use = function(self, card, area, copier)
		G.GAME.may_genesis_ante = G.GAME.may_genesis_ante or 3
		G.GAME.rounds_since_genesis = 0
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
		    local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_omniversal_catalyst', 'may_genesis')
		    G.jokers:emplace(card2)
		    play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
		    card2:add_to_deck()
			card2:juice_up(0.6, 1)
			G.jokers:juice_up(0.3, 0.5)
			G.ROOM.jiggle = G.ROOM.jiggle + 5
		return true end})) 
		may.ease_instability(0, 0.75)
	end,
	in_pool = function(self, args)
		return #SMODS.find_card('j_may_omniversal_catalyst') == 0 and G.GAME.may_endless_mode --[[and G.GAME.may_tr1_reached]] and (G.GAME.rounds_since_genesis or 0) >= 6, {allow_duplicates = false}
	end
}