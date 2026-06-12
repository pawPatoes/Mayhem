-- Retro cards 

SMODS.Consumable {
	key = 'easter_egg',
	config = { extra = { jokers = 1, mul = 1.5 } },
	loc_txt = {
		name = 'EASTER_EGG',
		text = {
			"Create {C:attention}#1# random{} {X:mult,C:white}Rare{} {C:attention}Joker{}",
			"if you have used {C:attention}#2#{} {C:money}Yotta Cards{} this run,",
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Yotta Cards used this run{}", 
			"{C:inactive}Requirement rounds up{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
	display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	endless = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('yottacards') >= ((G.GAME.may_retro_stats or {}).easter_egg or 2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.jokers, ((G.GAME.may_retro_stats or {}).easter_egg or 2), card.ability.extra.mul, may.ctu('yottacards') } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.extra.jokers, G.jokers.config.card_limit - #G.jokers.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.jokers.config.card_limit > #G.jokers.cards then
					play_sound('timpani')
					local card2 = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'may_easter_egg')
					card2:add_to_deck()
					G.jokers:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.easter_egg = math.ceil((G.GAME.may_retro_stats.easter_egg or 2) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Consumable {
	key = '1_up',
	config = { extra = { dollars = 25, mul = 1.75 } },
	loc_txt = {
		name = '1-UP',
		text = {
			"{C:money}+$#1#{} if you have used", 
			"{C:attention}#2#{} {C:spectral}Spectral Cards{} this run,",
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Spectral Cards used this run{}", 
			"{C:inactive}Requirement rounds up{}"
		}
	},
	set = 'retrocards',
	pos = { x = 2, y = 0 },
	display_size = { w = 71, h = 71 },  
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('Spectral') >= ((G.GAME.may_retro_stats or {}).one_up or 5)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, ((G.GAME.may_retro_stats or {}).one_up or 5), card.ability.extra.mul, may.ctu('Spectral') } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			play_sound('timpani')
		return true end}))
		ease_dollars(card.ability.extra.dollars)
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.one_up = math.ceil((G.GAME.may_retro_stats.one_up or 5) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'}) 
	end,
}

SMODS.Consumable {
	key = 'lootbox',
	config = { extra = { cards = 5, mul = 1.75 } },
	loc_txt = {
		name = 'LOOTBOX',
		text = {
			"Create {C:attention}#1#{} random {C:attention}Consumables{}", 
			"if you have {C:money}redeemed{} {C:attention}#2#{} {C:green}Vouchers{},",
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Vouchers redeemed this run{}", 
			"{C:inactive}Does not require room{}",
			"{C:inactive}Requirement rounds up{}"
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 1 },
	display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and #(G.vouchers.cards or {}) >= ((G.GAME.may_retro_stats or {}).lootbox or 5)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, ((G.GAME.may_retro_stats or {}).lootbox or 5), card.ability.extra.mul, #((G.vouchers or {}).cards or {}) } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			for i = 1, card.ability.extra.cards do
				local choice = may.random_consumable('may_inverted_seal_card')
				local card2 = create_card(choice.set, G.consumables, nil, nil, nil, nil, choice.key, "may_inverted_seal_card")
				card2:add_to_deck()
				G.consumeables:emplace(card2)
			end
			play_sound('may_bundle')
			card:juice_up(0.5, 0.3)
		return true end})) 
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.lootbox = math.ceil((G.GAME.may_retro_stats.lootbox or 5) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'upgrade',
	config = { extra = { cards = 4, mul = 2 } },
	loc_txt = {
		name = 'UPGRADE',
		text = {
			"Create {C:attention}#1#{} random {C:dark_edition}Modifier Card{}",
			"if you have used {C:attention}#2#{} {C:planet}Planet Cards{},", 
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Planet Cards used this run{}", 
			"{C:inactive}Requires room{}", 
			"{C:inactive}Requirement rounds up{}"
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 2 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('Planet') >= ((G.GAME.may_retro_stats or {}).upgrade or 10)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, ((G.GAME.may_retro_stats or {}).upgrade or 10), card.ability.extra.mul, may.ctu('Planet') } }
	end,
	use = function(self, card, area, copier)
		for i = 1, card.ability.extra.cards do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, 'may_upgrade')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.upgrade = math.ceil((G.GAME.may_retro_stats.upgrade or 10) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'savescum',
	config = { extra = { copies = 2, mul = 1.5 } },
	loc_txt = {
		name = 'SAVESCUM',
		text = {
			"Create {C:attention}#1#{} {C:dark_edition}Negative{} copies of",
			"the {C:attention}last consumable{} {C:money}sold{} this run", 
			"with {C:mult}$0{} {C:money}sell value{}", 
			"if you have {C:mult}skipped{} {C:attention}#2# Booster Packs{},", 
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Booster Packs skipped this run{}", 
			"{C:inactive}Requirement rounds up{}", 
			"{C:inactive}SAVESCUM excluded{}"
		}
	},
	set = 'retrocards',
	pos = { x = 3, y = 1 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and G.GAME.may_last_consumable_sold and (G.GAME.may_last_consumable_sold ~= 'c_may_savescum') and (G.GAME.may_packs_skipped or 0) >= ((G.GAME.may_retro_stats or {}).savescum or 5)
	end,
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.may_last_consumable_sold and G.P_CENTERS[G.GAME.may_last_consumable_sold] or nil
		local may_last_consumable_sold = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
		local colour = ((not fool_c) or G.GAME.may_last_consumable_sold == 'c_may_savescum') and G.C.RED or G.C.SECONDARY_SET.retrocards
		if fool_c and may_last_consumable_sold ~= 'c_may_savescum' then
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
							{ n = G.UIT.T, config = { text = ' ' .. may_last_consumable_sold .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
						}
					}
				}
			}
		}
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.copies, ((G.GAME.may_retro_stats or {}).savescum or 5), card.ability.extra.mul, (G.GAME.may_packs_skipped or 0) }, main_end = main_end }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local card2 = create_card(G.P_CENTERS[G.GAME.may_last_consumable_sold].set, G.consumeables, nil, nil, nil, nil, G.GAME.may_last_consumable_sold, 'may_savescum')
			card2:add_to_deck()
			G.consumeables:emplace(card2)
			card2:set_edition('e_negative')
			card2:setQty(card.ability.extra.copies)
			card2.sell_cost = 0
			card:juice_up(0.3, 0.5)
		return true end}))
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.savescum = math.ceil((G.GAME.may_retro_stats.savescum or 5) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'gamble',
	config = { extra = { chips = 2, mul = 1.4 } },
	loc_txt = {
		name = 'GAMBLE',
		text = {
			"Gives all {C:purple}Poker Hands{} {X:chips,C:white}X#1#{} Chips",
			"if you have used {C:attention}#2#{} copies of", 
			"{C:tarot}The Wheel of Fortune{} used this run,",
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# WoFs used this run{}", 
			"{C:inactive}Requirement rounds up{}", 
		}
	},
	set = 'retrocards',
	pos = { x = 3, y = 0 },
	display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.cu('c_wheel_of_fortune') >= ((G.GAME.may_retro_stats or {}).gamble or 4)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { card.ability.extra.chips, ((G.GAME.may_retro_stats or {}).gamble or 4), card.ability.extra.mul, may.cu('c_wheel_of_fortune') } }
	end,
	use = function(self, card, area, copier)
		may.hand_multchips_all(card, nil, false, {0, card.ability.extra.chips})
		may.ch()
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.gamble = math.ceil((G.GAME.may_retro_stats.gamble or 4) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'glitch',
	config = { extra = { cards = 4, mul = 1.5 } },
	loc_txt = {
		name = 'G{s:1.3}LIT{}CH{s:0.7}HH{}{s:1.3}CH{}',
		text = {
			"Create {C:attention}#1# random{} playing cards",
			"with {C:dark_edition}ERROR Seal{} and shuffle them into your deck", 
			"if you have used {C:attention}#2#{} {C:retrocards}Retro Cards{} this run,", 
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Retro Cards used this run{}", 
			"{C:inactive}Requirement rounds up{}", 
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 1 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('retrocards') >= ((G.GAME.may_retro_stats or {}).glitch or 5)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals.may_error_seal
		return { vars = { card.ability.extra.cards, ((G.GAME.may_retro_stats or {}).glitch or 5), card.ability.extra.mul, may.ctu('retrocards') } }
	end,
	use = function(self, card, area, copier)
		local created = {}
		for i = 1, card.ability.extra.cards do
			local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.retrocards})
			table.insert(created, new)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('card1')
				card:juice_up(0.3, 0.5)
			return true end}))
		end
		for k, v in pairs(created) do
			v:set_seal('may_error_seal', false, false)
		end
		for k, v in pairs(created) do
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				G.play:remove_card(v)
				v:add_to_deck()
				G.deck:emplace(v)
				play_sound('card1')
			return true end})) 
		end
		SMODS.calculate_context({ playing_card_added = true, cards = created })
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.glitch = math.ceil((G.GAME.may_retro_stats.glitch or 5) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'wrong_warp',
	config = { extra = { tags = 5, mul = 1.3 } },
	loc_txt = {
		name = 'WRONG_WARP',
		text = {
			"Create {C:attention}#1# random Tags{}",
			"if you have {C:attention}skipped #2#{} Blinds,", 
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Blinds skipped this run{}", 
			"{C:inactive}Requirement rounds up{}", 
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 2 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and G.GAME.skips >= ((G.GAME.may_retro_stats or {}).wrong_warp or 3)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.tags, ((G.GAME.may_retro_stats or {}).wrong_warp or 3), card.ability.extra.mul, G.GAME.skips } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('may_bundle')
			for i = 1, card.ability.extra.tags do
				may.random_tag()
			end
			card:juice_up(0.3, 0.5)
		return true end}))
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.wrong_warp = math.ceil((G.GAME.may_retro_stats.wrong_warp or 3) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end
}

SMODS.Consumable {
	key = 'out_of_bounds',
	config = { extra = { slots = 1, mul = 2 } },
	loc_txt = {
		name = 'OUT_OF_BOUNDS',
		text = {
			"{C:green}+#1#{} {C:attention}Joker Slot{}",
			"if you have {C:money}sold{} {C:attention}#2# Jokers{},", 
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Jokers sold this run{}", 
			"{C:inactive}Requirement rounds up{}", 
		}
	},
	set = 'retrocards',
	pos = { x = 2, y = 1 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and (G.GAME.may_jokers_sold or 0) >= ((G.GAME.may_retro_stats or {}).out_of_bounds or 6)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots, ((G.GAME.may_retro_stats or {}).out_of_bounds or 6), card.ability.extra.mul, (G.GAME.may_jokers_sold or 0) } }
	end,
	use = function(self, card, area, copier)
		G.jokers:change_size(card.ability.extra.slots)
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			card:juice_up(0.3, 0.5)
		return true end}))
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.out_of_bounds = math.ceil((G.GAME.may_retro_stats.out_of_bounds or 6) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}

SMODS.Consumable {
	key = 'bossfight',
	config = { extra = { tags = 3, mul = 1.75 } },
	loc_txt = {
		name = 'BOSSFIGHT',
		text = {
			"Gives {C:attention}#1# Ethereal Tags{}",
			"if you have {C:green}defeated{} {C:attention}#2# Boss Blinds{},",
			"then {C:attention}increase{} {C:mult}requirement{} by {X:retrocards,C:white}X#3#{}", 
			may.pager(55),
			"{C:inactive}#4# Bosses defeated this run{}", 
			"{C:inactive}Requirement rounds up{}", 
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 0 },
	display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and (G.GAME.may_bosses_defeated or 0) >= ((G.GAME.may_retro_stats or {}).bossfight or 4)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
		return { vars = { card.ability.extra.tags, ((G.GAME.may_retro_stats or {}).bossfight or 4), card.ability.extra.mul, (G.GAME.may_bosses_defeated or 0) } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('may_bundle')
			card:juice_up(0.3, 0.5)
			for i = 1, card.ability.extra.tags do 
				add_tag(Tag('tag_ethereal')) 
			end
		return true end}))
		G.GAME.may_retro_stats = G.GAME.may_retro_stats or {}
		G.GAME.may_retro_stats.bossfight = math.ceil((G.GAME.may_retro_stats.bossfight or 4) * card.ability.extra.mul)
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Increased!", colour = G.C.SECONDARY_SET.retrocards, delay = 0.45, sound = 'may_forcetrigger'})
	end,
}