-- Grim cross-mod

-- Custom XP sound and XP hyperoperations
-- overwriting because grim likes being annoying
function add_skill_xp(amount, card, message_, no_mod, arrow)
	if G.GAME then
		local message = true
		if message_ ~= nil then
			message = message_
		end
		if not no_mod then
			amount = get_modded_xp(amount)
		end
		if not arrow then arrow = -1 end
		if arrow == -1 then
			G.GAME.skill_xp = G.GAME.skill_xp + amount
		else
			G.GAME.skill_xp = to_number(to_big(G.GAME.skill_xp):arrow(arrow, amount))
		end
		check_for_unlock({type = 'skill_check', total_xp = G.GAME.skill_xp})
		if skill_active("sk_grm_ghost_1") then
			G.GAME.ghost_skill_xp = G.GAME.ghost_skill_xp + amount
			if G.GAME.ghost_skill_xp > 200 then
				local spectrals = math.floor(G.GAME.ghost_skill_xp / 200)
				G.GAME.ghost_skill_xp = G.GAME.ghost_skill_xp - (200 * spectrals)
				spectrals = math.min(spectrals, G.consumeables.config.card_limit - #G.consumeables.cards)
				if spectrals > 0 then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.0,
						func = (function()
								spectrals = math.min(spectrals, G.consumeables.config.card_limit - #G.consumeables.cards)
								if spectrals > 0 then
									for i = 1, spectrals do
										local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'ghost')
										card:add_to_deck()
										G.consumeables:emplace(card)
									end
								end
								return true
						end)}))
				end
			end
		end
		if card and message and (amount ~= 0) then
			if arrow == -1 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='gain_xp',vars={amount}},colour = G.C.PURPLE, delay = 0.45})
			elseif arrow == 0 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='mult_xp',vars={amount}},colour = G.C.PURPLE, delay = 0.45})
			else
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='hyp_xp',vars={may.generate_arrow_text(arrow), amount}},colour = G.C.PURPLE, delay = 0.45})
			end
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('may_grim_xp', 1, 0.8)
				return true end}))
			end
		end
	end
end

if not SMODS.ObjectTypes.H then
	SMODS.ObjectType {
		key = 'H',
		default = 'j_may_h',
		cards = {},
	}
end


function may.is_h(card, below_legendary)
	local center = type(card) == "string" and G.P_CENTERS[card] or (card.config and card.config.center)
	if not center then return false end
	if not below_legendary then
		if center.pools and center.pools.H then
			return true
		end
	else
		if center.pools and center.pools.H and type(center.rarity) == 'number' and center.rarity < 4 then
			return true
		end
	end
end

-- Grim Atlases

SMODS.Atlas {
	key = 'grm_joker1',
	path = 'cm/GRM/grm_joker1.png',
	px = 71,
	py = 95
}

-- Grim sounds

SMODS.Sound({key = 'grim_xp', path = 'grim_xp.ogg'})

-- Grim Jokers

-- Common

SMODS.Joker {
	key = 'faulty_joker',
	loc_txt = {
		name = 'Faulty Joker',
		text = {
			{
				"{C:purple}+#1#{} XP if played hand",
				"contains a {C:attention}#2#{}",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { XP = 50, hand = 'Pair' } },
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 3, y = 1 },
	blueprint_compat = true,
	cost = 3,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.XP, card.ability.extra.hand } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if context.poker_hands ~= nil and (context.poker_hands[card.ability.extra.hand] and next(context.poker_hands[card.ability.extra.hand])) then
				add_skill_xp(card and card.ability.extra.XP or 50, card)
			end
		end
		if context.forcetrigger then
			add_skill_xp(card and card.ability.extra.XP or 50, card)
		end
	end
}

--[[SMODS.Joker {
	key = 'hurry',
	loc_txt = {
		name = 'Hurry',
		text = {
			{
				"{C:chips}+#1#{} Chips if played hand is {C:attention}High Card{}",
				"{C:attention}Increases{} by {C:chips}#2#{} for {C:attention}each unscored card{} in played hand",
				"Create a {C:dark_edition}Faulty Joker{} when {C:chips}Chips{} reach {C:chips}#3#{}",
				"{C:inactive}(#4#, requires room){}",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { chips = 16, chips_gain = 16, requirement = 160, active = true } },
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 0, y = 1 },
	blueprint_compat = true,
	cost = 4,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.requirement, card.ability.extra.active and 'Active' or 'Inactive' } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.current_round.current_hand.handname == localize("High Card", 'poker_hands') then
				return {
					hand_chips = card.ability.extra.chips,
					colour = G.C.CHIPS,
					card = card,
				}
			end
		end
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local cards = 0
			for k, v in ipairs(context.scoring_hand) do
				v.may_hurry_incompat = true
			end
			for k, v in ipairs(context.full_hand) do
				if not v.may_hurry_incompat then
					cards = cards + 1
					G.E_MANAGER:add_event(Event({func = function()
						v:juice_up()
					return true end}))
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v.may_hurry_incompat = nil
			end
			card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chips_gain * cards)
			if card.ability.extra.chips >= card.ability.extra.requirement and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.ability.extra.active then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hurry')
				G.jokers:emplace(card2)
				play_sound('holo1')
				card2:add_to_deck()
				card.ability.extra.active = false
			end
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card,
			}
		end
		if context.forcetrigger then
			return {
				hand_chips = card.ability.extra.chips,
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end
}

if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then

SMODS.Joker {
	key = 'hate',
	loc_txt = {
		name = {'Hate', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"{C:may_ethereal}Force-trigger{} all {C:dark_edition}Faulty Jokers{}",
				"if played hand is {C:attention}High Card{}",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	rarity = 1,
	atlas = 'grm_joker1',
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = {} }
	end,
	blueprint_compat = true,
	pools = { H = true },
	cost = 4,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.current_hand.handname == localize("High Card", 'poker_hands') or context.forcetrigger then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:gc().key == 'j_may_faulty_joker' then
					if Cryptid.demicolonGetTriggerable(G.jokers.cards[i])[1] then
						local results = Cryptid.forcetrigger(G.jokers.cards[i], context)
						if results and results.jokers then
							results.jokers.message = localize("cry_demicolon")
							results.jokers.colour = G.C.RARITY.cry_epic
							results.jokers.sound = "cry_demitrigger"
							return results.jokers
						end
						return {
							message = localize("cry_demicolon"),
							colour = G.C.RARITY.cry_epic,
							sound = "cry_demitrigger",
						}
					end
				end
			end
		end
	end
}

end

-- Uncommon

SMODS.Joker {
	key = 'minimalistic_h',
	loc_txt = {
		name = {'Minimalistic H', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"{X:purple,C:white}X#1#{} XP if hand contains only {C:attention}1 card{}",
				"{C:mult}without{} a {C:attention}suit or rank{}",
				"{C:mult}Self destructs{}",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { X_XP = 2 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 1, y = 1 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.X_XP } }
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers or context.forcetrigger then
			if #G.play.cards == 1 then
				if SMODS.has_no_suit(G.play.cards[1]) and SMODS.has_no_rank(G.play.cards[1]) then
					add_skill_xp(card and card.ability.extra.X_XP or 2, card, nil, nil, 0)
					G.E_MANAGER:add_event(Event({func = function()
						self = card
						play_sound('tarot1')
						message = "Faded!"
						self:juice_up(0.3, 0.4)
						self.states.drag.is = true
						self.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
							G.jokers:remove_card(self)
							self:remove()
							self = nil
						return true end})) 
					return true end}))
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'hexing',
	loc_txt = {
		name = {'Hexing', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"Make an {C:dark_edition}Amber Faulty Joker{} when an",
				"{C:dark_edition}H{} {C:attention}Joker{} is {C:attention}sold{}",
				"{C:mult}Self destructs{} after {C:attention}#1# triggers{}",
				"{C:inactive}(requires room){}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { triggers = 3 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 3, y = 0 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_may_amber']
		return { vars = { card.ability.extra.triggers } }
	end,
	calculate = function(self, card, context)
		if (context.selling_card and context.card.ability.set == "Joker" and may.is_h(context.card) and not context.blueprint) or context.forcetrigger then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hexing')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({may_amber = true}, false, false)
			card.ability.extra.triggers = card.ability.extra.triggers - 1
			if card.ability.extra.triggers <= 0 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
					play_sound('tarot1')
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
			end
		end
	end
}

-- Rare

SMODS.Joker {
	key = 'horned_melon',
	loc_txt = {
		name = {'Horned Melon', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"{C:attention}Gains{} {C:purple}+#1#{} XP when a {C:dark_edition}Food Joker{} is {C:attention}sold{}",
				"{C:inactive}Currently{} {C:purple}+#2#{} {C:inactive}XP{}",
			},
			{
				"{C:inactive,E:1}original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { XP_gain = 50, XP = 0 } },
	rarity = 2,
	atlas = 'grm_joker1',
	pos = { x = 4, y = 0 },
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	pools = { H = true, Food = true, },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.XP_gain, card.ability.extra.XP } }
	end,
	calculate = function(self, card, context)
		if (context.selling_card and context.card.ability.set == "Joker" and may.is_food(context.card) and not context.blueprint) or context.forcetrigger then
			card.ability.extra.XP = card.ability.extra.XP + card.ability.extra.XP_gain
			return {
				message = 'Upgraded!',
				colour = G.C.PURPLE,
				card = card,
			}
		end
		if context.joker_main then
			add_skill_xp(card and card.ability.extra.XP or 0, card)
		end
	end
}

SMODS.Joker {
	key = 'h',
	loc_txt = {
		name = {'H', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"Make {C:attention}#1#{} {C:dark_edition}Foil Faulty Jokers{} after {C:attention}#2# High Cards{} are played,",
				"then {C:attention}increase{} the number of {C:dark_edition}Faulty Jokers{} and {C:attention}High Cards{} by {C:attention}#3#{}",
				"{C:inactive}#4# High Cards played so far, requires room{}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		},
	},
	rarity = 3,
	atlas = 'grm_joker1',
	pos = { x = 1, y = 0 },
	config = { extra = { faulty = 1, high_card = 5, increase = 1, played = 0} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
		return { vars = {card.ability.extra.faulty, card.ability.extra.high_card, card.ability.extra.increase, card.ability.extra.played} }
	end,
	blueprint_compat = true,
	cost = 18,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.before and G.GAME.current_round.current_hand.handname == localize("High Card", 'poker_hands') then
			card.ability.extra.played = card.ability.extra.played + 1
			if card.ability.extra.played == math.floor(card.ability.extra.high_card) then
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
					for i=1, card.ability.extra.faulty, 1 do
						local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_faulty_joker', 'may_hexing')
						G.jokers:emplace(card2)
						card2:add_to_deck()
						card2:set_edition({foil = true}, false, false)
					end
				end
				card.ability.extra.high_card = card.ability.extra.high_card + card.ability.extra.increase
				card.ability.extra.faulty = card.ability.extra.faulty + card.ability.extra.increase
				return {
					message = 'Upgraded!',
					card = card,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'h_lowercase',
	loc_txt = {
		name = {'h', "{C:dark_edition,s:0.6}H Joker"},
		text = {
			{
				"{X:purple,C:white}X#1#{} XP when {C:dark_edition}Faulty Joker{} is {C:attention}sold{}",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_immutable", set = "Other" }
		info_queue[#info_queue + 1] = G.P_CENTERS['j_may_faulty_joker']
		return { vars = { card.ability.extra.X_XP } }
	end,
	config = { extra = { X_XP = 1.8 } },
	rarity = 3,
	atlas = 'grm_joker1',
	immutable = true,
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { H = true },
	pos = { x = 0, y = 0 },
	cost = 18,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and context.card:gc().key == 'j_may_faulty_joker' then
			add_skill_xp(card and card.ability.extra.X_XP or 1.8, card, nil, nil, 0)
		end
		if context.forcetrigger then
			add_skill_xp(card and card.ability.extra.X_XP or 1.8, card, nil, nil, 0)
		end
	end
}]]