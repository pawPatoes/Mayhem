-- Yotta Cards

SMODS.Consumable {
	key = 'cupiditas',
	set = 'yottacards',
	loc_txt = {
		name = "Cupiditas",
		text = {
			{
				"During a {C:attention}Blind{}, use for", 
				"{X:money,C:white}X1.75${} and {X:may_col_huge_operator_alt,C:white}#1#5{} Blind Size",
				"{C:inactive}G = #2#{}"
			},
			{
				"Rarely appears in place of {C:spectral}Spectral Cards{}", 
				"inside {C:attention}Booster Packs{}"
			}, 
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	atlas = 'yotta',
	cost = 50,
	unlocked = true,
	reserve = true, 
	immutable = true, 
	endless = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_global_op_tutorial", set = "Other" }
		return { vars = { '{G}', may.global_op() } }
	end, 
	can_use = function(self, card)
		return may.canuse() and G.STATE == G.STATES.SELECTING_HAND
	end,
	discovered = true,
	no_grc = true, 
	hidden = true,
	soul_rate = 0.01,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		may.hypermoney(0, 1.75, false)
		G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
			G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(may.global_op(), 5)
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
			play_sound('may_blind_size')
		return true end}))
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'planetae',
	set = 'yottacards',
	loc_txt = {
		name = "Planetae",
		text = {
			{
				"Use to {C:mult}destroy{} all held {C:planet}Planet Cards{}", 
				"and give {C:attention}all{} {C:purple}Poker Hands{} "..may.hyp(4, 'multchips', "+#2#0.2").." Chips & Mult", 
				"per {C:money}$0.5{} of {C:money}sell value{} destroyed cards had", 
				"{C:inactive}Currently #1# Chips & Mult {}"
			},
			{
				"Rarely appears in place of {C:planet}Planet Cards{}", 
				"inside {C:attention}Booster Packs{}"
			}, 
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	atlas = 'yotta',
	cost = 50,
	unlocked = true,
	reserve = true, 
	immutable = true,
	endless = true,
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'global_op')
		local amount = 0
		if G.consumeables then
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().set == 'Planet' then 
					amount = amount + v.sell_cost
				end 
			end 
		end
		return { vars = { may.generate_arrow_text(may.global_op())..tostring(1 + ((amount * 2) * 0.2)), '{G}' } }
	end, 
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' then 
				return may.canuse()
			end 
		end 
		return false 
	end,
	discovered = true,
	no_grc = true,
	hidden = true,
	soul_rate = 0.01,
	soul_set = 'Planet',
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Planet' then 
				amount = amount + v.sell_cost
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					v:start_dissolve()
					play_sound('card3')
				return true end}))
			end 
		end 
		may.hand_multchips_all(card, nil, false, {may.global_op(), 1 + ((amount * 2) * 0.2)}, {may.global_op(), 1 + ((amount * 2) * 0.2)})
		may.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'potestas',
	set = 'yottacards',
	loc_txt = {
		name = "Potestas",
		text = {
			{
				"{C:attention}Select a Joker{}, then use to", 
				"{C:mult}destroy{} it for various", 
				"{C:dark_edition}Score Operator{} {C:green}increases{}", 
				may.pager(),
				"{X:may_ethereal,C:white}Ethereal{}: +1, {X:may_prismatic,C:white}Prismatic{}: +2,",
				"{X:may_demiurgic,C:white}Demiurgic{}: +3, {X:may_transcendent,C:white}Transcendent{}: +10",
				may.pager(),
				"{C:attention}Joker{} must have one of the {C:attention}rarities{} above", 
				"Final {C:dark_edition}Score Operator{} is {C:mult}capped{} at {C:may_prismatic}G{}", 
				may.pager(),
				"{C:inactive}G = #1#{}"
			},
			{
				"Rarely appears in place of {C:retrocards}Retro Cards{}", 
				"inside {C:attention}Booster Packs{}"
			}, 
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	atlas = 'yotta',
	cost = 50,
	unlocked = true,
	reserve = true, 
	immutable = true, 
	endless = true,
	can_use = function(self, card)
		if G.jokers and #G.jokers.highlighted == 1 then 
			return may.canuse() and (((G.jokers.highlighted[1]:may_is_fusion() and G.jokers.highlighted[1]:gc().rarity ~= 'may_mythic') or G.jokers.highlighted[1]:gc().rarity == 'may_opalescent') and G.jokers.highlighted[1]:gc().rarity ~= 'may_paradoxical') 
		end 
		return false
	end,
	discovered = true,
	no_grc = true,
	hidden = true,
	soul_rate = 0.01,
	soul_set = 'retrocards',
	loc_vars = function(self, info_queue, card)
		may.tut_tip(info_queue, 'global_op')
		return { vars = { may.global_op() } }
	end,
	use = function(self, card, area, copier)
		local amount = 0
		if (G.jokers.highlighted[1]:may_is_fusion() and G.jokers.highlighted[1]:gc().rarity ~= 'may_mythic') or G.jokers.highlighted[1]:gc().rarity == 'may_opalescent' then
			if G.jokers.highlighted[1]:gc().rarity == 'may_ethereal' then 
				amount = amount + 1
			elseif G.jokers.highlighted[1]:gc().rarity == 'may_opalescent' or G.jokers.highlighted[1]:gc().rarity == 'may_demiurgic' then 
				amount = amount + 15
			elseif G.jokers.highlighted[1]:gc().rarity == 'may_prismatic' then 
				amount = amount + 2
			elseif G.jokers.highlighted[1]:gc().rarity == 'may_transcendent' then
				amount = amount + 10
			end 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				G.jokers.highlighted[1]:start_dissolve()
				play_sound('may_big_score1')
				G.ROOM.jiggle = G.ROOM.jiggle + 3
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			may.change_operator(math.min(amount, may.global_op() - may.get_score_operator()))
		return true end}))
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'speculum',
	set = 'yottacards',
	loc_txt = {
		name = "Speculum",
		text = {
			{
				"Use to create {C:attention}2{} {C:dark_edition}Negative{}",
				"copies of {C:attention}each unique consumable{}",
				"and {C:mult}pay{} {X:money,C:white}X3{} the consumable's default {C:money}price{}", 
				"{C:inactive}Other Speculums excluded{}", 
				"{C:inactive}Will lose $#1#{}"
			},
			{
				"Rarely appears in place of {C:dark_edition}Modifier Cards{}", 
				"inside {C:attention}Booster Packs{}"
			}, 
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	atlas = 'yotta',
	cost = 50,
	unlocked = true, 
	reserve = true, 
	immutable = true, 
	endless = true,
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().key ~= 'c_may_speculum' then 
				return may.canuse()
			end 
		end 
		return false
	end,
	discovered = true,
	no_grc = true,
	hidden = true,
	soul_rate = 0.01,
	soul_set = 'may_modifiercard',
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local amount = 0
		if G.consumeables then
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().key ~= 'c_may_speculum' then 
					amount = amount + v:gc().cost
				end 
			end 
		end 
		return { vars = { amount * 3 } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		if G.consumeables then
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().key ~= 'c_may_speculum' and not table_hasvalue(targets, v:gc().key) then 
					table.insert(targets, v:gc().key)
				end 
			end 
		end
		for k, v in pairs(targets) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				local card2 = create_card(G.P_CENTERS[v].set, G.consumeables, nil, nil, nil, nil, v, 'may_speculum')
				card2:setQty(2)
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				play_sound('timpani')
			return true end}))
			ease_dollars(-(G.P_CENTERS[v].cost * 3))
		end
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}

SMODS.Consumable {
	key = 'arnitikos',
	set = 'yottacards',
	loc_txt = {
		name = "Arnitikos",
		text = {
			{
				"Use to {C:mult}destroy{} selected {C:attention}consumables{}", 
				"and gain {C:attention}+1 Joker{} and {C:attention}Consumable Slot{}", 
				"but {C:mult}lose{} {C:attention}1 Hand Size{}", 
				"per {C:money}$3{} of {C:money}sell value{} destroyed cards had",
				"{C:inactive}Hand Size cannot go below 1{}",
				"{C:inactive}Currently +/-#1#{}", 
			},
			{
				"Rarely appears in place of {C:tarot}Tarot Cards{}", 
				"inside {C:attention}Booster Packs{}"
			}, 
			{
				"{C:inactive,E:1}Art by Grahkon{}"
			}
		}
	},
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 },
	atlas = 'yotta',
	cost = 50,
	unlocked = true,
	reserve = true, 
	immutable = true,
	endless = true,
	loc_vars = function(self, info_queue, card)
		local amount = 0
		if G.consumeables then
			for k, v in pairs(G.consumeables.highlighted) do
				if v ~= card then 
					amount = amount + v.sell_cost
				end 
			end 
		end
		return { vars = { math.floor(amount / 3) } }
	end, 
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.highlighted) do
			if v ~= card and v.sell_cost > 0 then 
				return may.canuse()
			end 
		 end 
		return false
	end,
	discovered = true,
	no_grc = true,
	hidden = true,
	soul_rate = 0.01,
	soul_set = 'Tarot',
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in pairs(G.consumeables.highlighted) do
			if v ~= card then 
				amount = amount + v.sell_cost
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					v:start_dissolve()
					play_sound('card3')
				return true end}))
			end 
		end 
		G.jokers:change_size(math.floor(amount / 3))
		G.consumeables:change_size(math.floor(amount / 3))
		G.hand:change_size(-math.min(math.floor(amount / 3), G.hand.config.card_limit - 1))
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}
