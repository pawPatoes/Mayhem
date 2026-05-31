-- Mythic Jokers

SMODS.Joker {
	key = 'wizard_university',
	loc_txt = {
		name = {'Wizard University', "{C:inactive,s:0.5}Mana Orb + Hierarchy{}"},
		text = {
			{
				"When {C:attention}hand is played{}, add",
				"{C:attention}random{} {C:dark_edition}Editions{} to all {C:attention}cards held in hand{}",
				"{C:attention}with{} an {C:dark_edition}Enhancement{} {C:attention}or{} {C:dark_edition}Seal{}",
				may.pager(),
				"Played {C:attention}cards{} with {C:dark_edition}Editions{} give {X:chips,C:white}^#1#{} Chips",
			},
            may.add_fusion_text('Aurora Rave', 'Planet Ibiza', may.get_condition('planet_ibiza')), 
			{
				"{C:inactive,E:1}Art by XZ0204{}"
			}
		}
	},
	rarity = "may_mythic",
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 7, y = 3 },
	soul_pos = { x = 8, y = 3 },
	config = { extra = { Echip = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Echip } }
	end,
	cost = 100,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			local found
			for k, v in ipairs(G.hand.cards) do
				if v.config.center ~= G.P_CENTERS.c_base and not v.edition then
					v:set_edition(poll_edition('may_wizard_university', nil, true, true), false, false)
					found = true
				end
			end
			if found then
				return {
					card = card,
					message = "Editions!",
					colour = G.C.DARK_EDITION
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition then
				return {
					Echip_mod = card.ability.extra.Echip,
					card = card,
					message = '^'..card.ability.extra.Echip..' Chips',
					colour = G.C.CHIPS
				}
			end
		end
		if context.forcetrigger then
			return {
				Echip_mod = card.ability.extra.Echip,
				card = card,
				message = '^'..card.ability.extra.Echip..' Chips',
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus',
	loc_txt = {
		name = {'Diskus', '{C:inactive,s:0.5}man + Wheel of Eternity{}'},
		text = {
			{
				"When {C:attention}Blind{} is {C:attention}selected{},",
				"create {C:attention}#1#{} {C:dark_edition}Negative{} copies of {C:purple}The Wheel of Fortune{}",
				may.pager(),
				"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:mult,C:white}^#2#{} Mult",
				may.pager(),
				"When {C:attention}a playing card{} is triggered, create {C:attention}#3#{} {C:dark_edition}Negative{} copies of {C:purple}The Wheel of Fortune{}",
			},
			may.add_fusion_text('Collectionist', 'Diskus Kollectum', may.get_condition('diskus_kollectum')),
		},	
	},
	rarity = 'may_mythic',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	custom_soul_anim = 'diskus_spin',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 100,
	config = { extra = { blindcards = 10, Emult = 1.4, cards = 2, } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.blindcards, card.ability.extra.Emult, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
					if Overflow then
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:setQty(card.ability.extra.cards)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					else
						for i=1, card.ability.extra.cards, 1 do
							local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
							G.consumeables:emplace(wheel)
							wheel:add_to_deck()
							wheel:set_edition({negative = true}, false, false)
						end
					end
			return true end}))
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.MULT,
				card = context.other_joker
			}
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'bedrock_joker',
	loc_txt = {
		name = {'Bedrock Joker', "{C:inactive,s:0.5}Marble Joker + Granite Joker{}"},
		text = {
			{
				"{X:chips,C:white}^#1#{} Chips",
				may.pager(),
                "When {C:attention}Blind{} is {C:attention}selected{},", 
				"create a {C:dark_edition}Negative{} copy of {C:spectral}Medusa{}",
				may.pager(),
                "After scoring, {C:mult}destroy{} all", 
				"{C:dark_edition}Stone Cards{} {C:attention}held in hand{} and gain", 
				"{X:chips,C:white}+^#2#{} Chips per destroyed card",
			},
            may.add_fusion_text('Stone Joker', 'Bismuth Joker', may.get_condition('bismuth_joker')), 
			{
				"{C:inactive,E:1}Art by Sertinho{}"
			}
		}
	},
	rarity = "may_mythic",
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 7, y = 4 },
	soul_pos = { x = 8, y = 4 },
	config = { extra = { Echip = 1, Echip_gain = 0.075, } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_medusa
		return { vars = { card.ability.extra.Echip, tostring(card.ability.extra.Echip_gain) } }
	end,
	cost = 100,
	calculate = function(self, card, context)
		if context.setting_blind then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_may_medusa', 'may_bedrock_joker')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
			return true end})) 
		end
        if context.after and not context.blueprint then 
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then 
                    SMODS.destroy_cards(v)
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "Echip",
                        scalar_value = "Echip_gain",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end 
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.Echip > 1 then
            return {
                e_chips = card.ability.extra.Echip, 
                card = card, 
            }
        end
	end
}

--[[if may.conf.content.WIP then

SMODS.Joker {
	key = 'jerrys_bait_shop',
	loc_txt = {
		name = "Jerry's Bait Shop",
		text = {
			{
				"{X:chips,C:white}X#1#{} Chips, earn {C:money}$#2#{} when opening a {C:attention}Booster Pack{}",
				"{C:attention}earned money increases{} by {C:money}$#3#{} every {C:attention}2 skipped Booster Packs{}",
				"When {C:attention}earned money{} reaches {C:money}$25{}, create an {C:dark_edition}Universal Collapse{} joker",
				"{C:inactive}(#4#, must have room, only works once){}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { Xchips = 7.5, dollars = 5, dollars_gain = 5, canupgrade = false, canspawn = true} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips, card.ability.extra.dollars, card.ability.extra.dollars_gain, 
		card.ability.extra.canupgrade and 'Active' or 'Inactive'} }
	end,
	rarity = 'may_mythic',
	misc_badge = may_wip_badge,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 10 },
	soul_pos = { x = 1, y = 10 },
	cost = 100,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xchip_mod = card.ability.extra.Xchips,
				card = card,
				message = 'X'..card.ability.extra.Xchips..' Chips',
				colour = G.C.CHIPS
			}
		end
		if context.open_booster and context.cardarea == G.jokers then
			return {
				dollars = card.ability.extra.dollars,
				card = card,
				message = '+'..card.ability.extra.dollars..'$',
				colour = G.C.MONEY
			}
		end
		if context.skipping_booster and context.cardarea == G.jokers then
			card.ability.extra.canupgrade = not card.ability.extra.canupgrade
			if card.ability.extra.canupgrade then
				card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
				if to_big(card.ability.extra.dollars) >= to_big(25) then
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.config.canspawn then
						G.E_MANAGER:add_event(Event({func = function()
							local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_jerrys_bait_shop')
							G.jokers:emplace(card2)
							card2:add_to_deck()
							play_sound("may_thunder"..math.random(1,2))
						return true end}))
						G.E_MANAGER:add_event(Event({func = function()
							card.config.canspawn = false
						return true end}))
					end
				return {
					message = 'Upgraded!',
					colour = G.C.MONEY
				}
				end
			end
		end
		if context.forcetrigger then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.config.canspawn then
				G.E_MANAGER:add_event(Event({func = function()
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_jerrys_bait_shop')
					G.jokers:emplace(card2)
					card2:add_to_deck()
					play_sound("may_thunder"..math.random(1,2))
				return true end}))
				G.E_MANAGER:add_event(Event({func = function()
					card.config.canspawn = false
				return true end}))
			end
		end
	end
}

end]] 