-- Yotta Cards

if not may.yottarate then
	if may.conf.Mode == 1 then
		may.yottarate = 0.01
	else
		may.yottarate = 0.03
	end
end

SMODS.Consumable {
	key = 'cupiditas',
	set = 'yottacards',
	loc_txt = {
		name = "Cupiditas",
		text = {
			{
				"During a {C:attention}Blind{}, use for", 
				"{X:money,C:white}^1.2${} and {X:attention,C:white}^5{} Blind Requirements"
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
	can_use = function(self, card)
		return may.canuse() and G.STATE == G.STATES.SELECTING_HAND
	end,
	discovered = true,
    no_grc = true, 
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
		may.hypermoney(1, 1.2, false)
        G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
			G.GAME.blind.chips = G.GAME.blind.chips ^ 5
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
				"and give {C:attention}all{} {C:purple}Poker Hands{} {X:purple,C:white}^0.05{} Mult & Chips", 
				"per {C:money}$0.5{} of {C:money}sell value{} destroyed cards had", 
				"{C:inactive}Currently ^#1# Mult & Chips{}"
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
        local amount = 0
        if G.consumeables then
            for k, v in pairs(G.consumeables.cards) do
                if v:gc().set == 'Planet' then 
                    amount = amount + v.sell_cost
                end 
            end 
        end
        return { vars = { 1 + ((amount * 2) * 0.05) } }
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
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
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
        may.hand_mod_multchips_all('multchips', 1, 1 + ((amount * 2) * 0.05), false, card)
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
				"{X:may_transcendent,C:white}Ethereal{}: +1, {X:may_interdimensional,C:white}Prismatic{}: +2,",
				"{X:may_ethereal,C:white}Demiurgic{}: +3, {X:may_hyperascendant,C:white}Transcendent{}: +10, {X:may_surreal,C:white}Opalescent{}: +15",
				"{C:attention}Joker{} must have one of the {C:attention}rarities{} above"
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
            return may.canuse() and (((G.jokers.highlighted[1]:may_is_fusion() and G.jokers.highlighted[1]:gc().rarity ~= 'may_mythic') or G.jokers.highlighted[1]:gc().rarity == 'may_surreal') and G.jokers.highlighted[1]:gc().rarity ~= 'may_mystery') 
        end 
        return false
	end,
	discovered = true,
    no_grc = true,
	hidden = true,
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
	use = function(self, card, area, copier)
        local amount = 0
        if (G.jokers.highlighted[1]:may_is_fusion() and G.jokers.highlighted[1]:gc().rarity ~= 'may_mythic') or G.jokers.highlighted[1]:gc().rarity == 'may_surreal' then
            if G.jokers.highlighted[1]:gc().rarity == 'may_transcendent' then 
                amount = amount + 1
            elseif G.jokers.highlighted[1]:gc().rarity == 'may_surreal' or G.jokers.highlighted[1]:gc().rarity == 'may_ethereal' then 
                amount = amount + 15
            elseif G.jokers.highlighted[1]:gc().rarity == 'may_interdimensional' then 
                amount = amount + 2
            elseif G.jokers.highlighted[1]:gc().rarity == 'may_hyperascendant' then
                amount = amount + 10
            end 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                G.jokers.highlighted[1]:start_dissolve()
                play_sound('may_big_score1', 0.5, 1)
                G.ROOM.jiggle = G.ROOM.jiggle + 3
            return true end}))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            if G.GAME.current_scoring_calculation_key ~= 'talisman_hyper' and SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + amount > 2 then 
                G.GAME.current_scoring_calculation_key = 'talisman_hyper'
                change_operator(amount-2)
            else 
                change_operator(amount)
            end
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
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
    loc_vars = function(self, info_queue, card)
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
				card2:start_materialize()
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
	soul_rate = may.yottarate,
	soul_set = 'Spectral',
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
