-- Legendary Jokers

local BA_messages = {
	"What's with these homies dissing my girl?",
	"Where i come from is a piece of crap",
	"Why do they gotta front?",
	"but it weer :blue_heart:",
	"What did we ever do to these guys",
	"That made them so violent?",
	"In the mini-mall",
	"5 Pcs. Tweezer Set",
	"It's a crying shame I'm all alone",
	"Why bother?",
	"This happened to be twice before"
}
	
SMODS.Joker {
	key = 'blue_album',
	loc_txt = {
		name = 'Blue Album',
		text = {
			{
				"This Joker {C:attention}gains{} {X:mult,C:white}^#1#{} Mult", 
				"if hand is played while {C:attention}Joker Slots{}",
				"are {C:mult}not{} {C:attention}fully occupied{}",
				may.pager(30),
				"{C:inactive}Currently {X:mult,C:white}^#2#{} {C:inactive}Mult{}",
				may.pager(30),
				"{C:inactive,E:1,s:0.7}#3#{}",
			},
			{
				"{C:inactive,E:1}Original concept by hellory4n{}"
			},
		}
	},
	config = { extra = { Emult_gain = 0.01, Emult = 1 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 2, y = 6 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult, BA_messages[math.random(#BA_messages)] } }
   end,
   add_to_deck = function(self, card, from_debuff)
		if (not from_debuff) and may.conf.JokerEffects then
			play_sound("may_weezer")
		end
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
				return {
					card = card,
					message = "Upgraded!",
					colour = G.C.MULT
				}
			end
		end
		if context.joker_main and card.ability.extra.Emult > 1 then
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				play_sound('may_weezer')
			return true end}))
			return {
				Emult_mod = card.ability.extra.Emult,
				message = "What's with these homies dissing my ^"..card.ability.extra.Emult.." Mult",
				card = card,
				colour = G.C.RED,	
			}
		end
		if context.forcetrigger then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				card = card,
				message = "Upgraded!",
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'mr_nacho',
	loc_txt = {
		name = 'Mr. Nacho',
		text = {
			"Other {C:attention}Food Jokers{} give {X:money,C:white}X#1#${}",
			may.pager(30), 
            "{C:inactive,E:1,s:0.7}He doesn't say much, else his fabulous mustache will be ruined{}"
		}
	},
	config = { extra = { Xdollars = 1.3 } },
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 1, y = 13 },
	soul_pos = { x = 2, y = 13 },
	pools = { Food = true },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xdollars } }
	end,
	calculate = function(self, card, context)
		if context.other_joker and may.is_food(context.other_joker) and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "X"..card.ability.extra.Xdollars.."$",
				x_dollars = card.ability.extra.Xdollars,
				card = context.other_joker,
				colour = G.C.MONEY
			}
		end
		if context.forcetrigger then
			return {
				message = "X"..card.ability.extra.Xdollars.."$",
				x_dollars = card.ability.extra.Xdollars,
				card = card,
				colour = G.C.MONEY
			}
		end
	end
}

SMODS.Joker {
	key = 'doggo',
	loc_txt = {
		name = {'DOGGO', "{C:dark_edition,s:0.7}Content creator insert:{} {C:may_ethereal,u:may_ethereal,s:0.7}TheUnseenExplosion{}"},
		text = {
			{
				"When a {C:attention}Queen of Hearts{} is {C:attention}discarded{},",
				"create {C:attention}#3#{} {C:dark_edition}Negative{} copies of",
				"the {C:attention}last consumable{} used this run",
				may.pager(), 
				"{C:green}#1# in #2#{} chance to {C:attention}increase{} number",
				"of copies by {C:attention}#4#{} afterwards",
				may.pager(), 
				"{C:inactive}Hidden & Ascended cosnumables, Yotta Cards,{}",
				"{C:inactive}Rare and above Planets excluded{}", 
				may.pager(), 
                "{C:inactive,E:1,s:0.7}Woof!{}"
			},
			{
				"{C:inactive,E:1}Original character art by TheUnseenExplosion{}",
				"{C:inactive,E:1}Original idea by TheUnseenExplosion{}",
			},
		}
	},
	config = { extra = { odds = 6, copies = 2, copies_scale = 1 } },
	rarity = 4,
	atlas = '003_temp',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		local normal, odds = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "DOGGO")
		return { vars = { normal, odds, card.ability.extra.copies, card.ability.extra.copies_scale } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_doggo_spawn", 1, 2)
		end
	end,
	calculate = function(self, card, context)
		if context.discard and context.other_card:get_id() == 12 and context.other_card:is_suit('Hearts') then
			if G.GAME.last_consumable then
				if (not G.P_CENTERS[G.GAME.last_consumable].hidden) and (not (G.P_CENTERS[G.GAME.last_consumable].set == 'ascendedtarots' or G.P_CENTERS[G.GAME.last_consumable].set == 'ascendedplanets' or G.P_CENTERS[G.GAME.last_consumable].set == 'ascendedspectrals' or G.P_CENTERS[G.GAME.last_consumable].set == 'yottacards')) and (not ((G.P_CENTERS[G.GAME.last_consumable].planet_rarity or 1) >= 2)) then
					G.E_MANAGER:add_event(Event({delay = 0.1, func = function()
						local new = create_card(G.P_CENTERS[G.GAME.last_consumable].set, G.consumeables, nil, nil, nil, nil, G.GAME.last_consumable, nil)
						new:setQty(card.ability.extra.copies)
						new.no_forced_edition = true
						new:set_edition('e_negative', true)
						new.no_forced_edition = nil
						new:add_to_deck()
						G.consumeables:emplace(new)
						play_sound('may_doggo_success'..math.random(1, 3))
						play_sound('timpani')
						card:juice_up()
					return true end}))
				end
			end
			if SMODS.pseudorandom_probability(card, "may_doggo", (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "DOGGO") then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "copies",
					scalar_value = "copies_scale",
				})
			end
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "copies",
				scalar_value = "copies_scale",
			})
		end
	end
}

SMODS.Joker {
	key = 'thatch',
	loc_txt = {
		name = 'Thatch',
		text = {
            {
			    "{C:money}$#1#{} / {C:attention}$#2#{}", 
				may.pager(),
				"When {C:money}money{} is {C:green}increased{}, this {C:attention}Joker's{} {C:money}money{}", 
				"counter {C:green}increases{} by a {C:mult}quarter{} of the {C:money}increase{}", 
				may.pager(),
                "When {C:money}money{} {C:attention}requirement{} is reached, adds", 
				"{C:attention}#3#{} {C:dark_edition}Negative{} regular {C:green}Voucher{}", 
				"and {C:attention}#4#{} {C:dark_edition}Negative{} {C:attention}Booster Packs{} to {C:attention}Consumable Slots{},", 
				"{C:mult}resets{} and {C:mult}increases{} {C:money}money{} {C:attention}requirement{} by {X:money,C:white}^1.15{}", 
				may.pager(),
				"{C:inactive}Max 100 triggers per money change{}",
				"{C:inactive}Will not activate if current money{}", 
				"{C:inactive}or money change is bigger than ee308{}", 
			    "{C:inactive}Duplicate Vouchers may appear{}",
				may.pager(), 
                "{C:inactive,E:1,s:0.7}Ye call this grog? I can still feel me face.{}",
            }, 
            {
                "{C:inactive,E:1}Character from Brawlhalla{}"
            }
		}
	},
	config = { extra = { money = 0, money_req = 20, voucher = 1, pack = 2, increase = 1.15 } },
	rarity = 4,
	atlas = 'joker2',
	pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 }, 
    immutable = true, 
	blueprint_compat = false,
	demicoloncompat = false,
	cost = 20,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.money_req, card.ability.extra.voucher, card.ability.extra.pack, card.ability.extra.increase } }
	end,
	calculate = function(self, card, context)
		if (not context.blueprint) and (context.money_altered and to_big(context.amount) > to_big(0) and to_big(context.amount) < Big.create(self, 'ee308') and to_big(G.GAME.dollars) < Big.create(self, 'ee308')) then
			card.ability.extra.money = card.ability.extra.money + (context.amount * 0.25)
			local triggers = 0
			while to_big(card.ability.extra.money) > to_big(card.ability.extra.money_req) do
				card.ability.extra.money = card.ability.extra.money - card.ability.extra.money_req
				card.ability.extra.money_req = card.ability.extra.money_req ^ card.ability.extra.increase
				triggers = triggers + 1
				if triggers > 100 then
					break
				end
			end
			for i = 1, triggers do
				for v = 1, card.ability.extra.voucher do
				    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					    local card2 = create_card('Voucher', G.consumeables, nil, nil, nil, nil, nil, 'may_thatch')
					    card2:set_edition({negative = true}, false, false)
						card2:add_to_deck() 
					    G.consumeables:emplace(card2)
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
					return true end}))
				end
				for p = 1, card.ability.extra.pack do
				    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					    local card2 = create_card('Booster', G.consumeables, nil, nil, nil, nil, nil, 'may_thatch')
					    card2:set_edition({negative = true}, false, false)
					    G.consumeables:emplace(card2)
					    card2:add_to_deck()
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
					return true end}))
				end
			end
			return {
				message = triggers == 0 and localize('k_upgrade_ex') or "Activated! (x"..triggers..")",
				message_card = card,
			}
		end
	end, 
}

SMODS.Joker {
	key = 'artso',
	loc_txt = {
		name = 'Artso',
		text = {
			{
				"Played {C:attention}Spades{} have a {C:green}#1# in #2#{} chance",
				"to give {X:chips,C:white}^^#3#{} Chips",
				may.pager(), 
				"{C:mult}Unstable{} near {C:attention}Blueprints{}",
				may.pager(), 
				"{C:inactive,E:1,s:0.7}tUrk e sandwiC!!{}"
			},
			{
				"{C:inactive,E:1}Character art by silly_goober_0nthewall (Discord){}"
			}
		}
	},
	config = { extra = { odds = 8.42, EEchip = 1.02 } },
	rarity = 4,
	atlas = '003_temp',
	blueprint_compat = false,
	demicoloncompat = true,
	immutable = true,
    endless = true, 
	pos = { x = 4, y = 2 },
	soul_pos = { x = 6, y = 2 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_blueprint']
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.EEchip } }
	end,
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if context.other_card:is_suit('Spades') then
				if pseudorandom('may_artso') < G.GAME.probabilities.normal / card.ability.extra.odds then
					return {
						ee_chips = card.ability.extra.EEchip,
					}
				end
			end
		end
		if context.joker_main and not context.blueprint then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().key == 'j_blueprint' then
					v:start_dissolve()
				end
			end
		end
		if context.forcetrigger then
			return {
				ee_chips = card.ability.extra.EEchip,
			}
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}



SMODS.Joker {
	key = 'corey',
	loc_txt = {
		name = 'Corey',
		text = {
			{
				"{X:mult,C:white}X#1#{} Mult",
				may.pager(), 
			    "{C:dark_edition}Shadow Cards{} {C:green}trigger{} while {C:attention}held in hand{} or {C:attention}in deck{}", 
				may.pager(), 
				"When a card is {C:mult}discarded{}, gain", 
				"{X:attention,C:white}X#2#{} its {C:mult}+Mult{} as {X:mult,C:white}XMult{} and {C:mult}set it to 0{}", 
				may.pager(), 
				"{C:inactive,E:1,s:0.7}Embrace the void and it'll embrace whats left of you.{}"
			},
			{
				"{C:inactive,E:1}Art by Violet{}"
			}
		}
	},
	config = { extra = { x_mult = 1, mult = 0.01, temp_scale = 0 } },
	rarity = 4,
	atlas = 'joker2',
	blueprint_compat = false,
	demicoloncompat = false,
	pos = { x = 2, y = 5 },
	soul_pos = { x = 3, y = 5 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_shadow']
		return { vars = { card.ability.extra.x_mult, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.discard and (context.other_card.ability.perma_mult or 0) ~= 0 then 
			card.ability.extra.temp_scale = context.other_card.ability.perma_mult * card.ability.extra.mult
			context.other_card.ability.perma_mult = 0
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "temp_scale",
				scaling_message = {
                    colour = G.C.MULT, 
					message = localize('k_upgrade_ex'),
				}
			})
			return {
				message = '=0 Mult', 
				sound = 'may_eqmult', 
				card = context.other_card, 
			}
		end
		if context.joker_main and card.ability.extra.x_mult > 1 then 
			return {
				x_mult = card.ability.extra.x_mult, 
				card = card,
			}
		end
	end, 
}

SMODS.Joker {
	key = 'santa',
	loc_txt = {
		name = "Santa",
		text = {
			{
				"Creates a {C:mult,E:1}Present{} {C:attention}before scoring{}", 
				"if played {C:purple}Poker Hand{} is {C:attention}Pair{}",
				may.pager(50),
				"{C:inactive}Requires room{}",
				may.pager(50),
				"{C:inactive,s:0.7,E:1}Ho-ho-ho!{}",
			},
			{
				"{C:inactive,E:1}Music from Rolling Sky by Cheetah Mobile{}"
			}
		}
	},
	rarity = 4,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 1, y = 6 },
	soul_pos = { x = 5, y = 3 },
	cost = 20,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_st_bells")
		end
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_present
	end,
	calculate = function(self, card, context)
		if context.before and context.scoring_name == 'Pair' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then 
				    play_sound('timpani')
				    play_sound('may_st_hohoho')
				    SMODS.add_card({ key = 'c_may_present' })
					card:juice_up(0.3, 0.5)
				end
			return true end}))	
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('timpani')
				SMODS.add_card({ key = 'c_may_present' })
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'doomsday_device',
	loc_txt = {
		name = 'Doomsday Device',
		text = {
            {
			    "{C:may_surreal,s:2,E:1}??????{}",
                "{C:dark_edition,X:black}#1#/15{}", 
				may.pager(30), 
                "{C:inactive,E:1,s:0.7}h{}",
            }, 
            {
                "{C:inactive,E:1}Character art by @silly_goober_0nthewall (Discord){}"
            }
		}
	},
	config = { extra = { Xmult = 1.5 } },
	rarity = 4,
	atlas = 'temp_doomsdaydevice',
	pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 }, 
    immutable = true, 
    endless = true, 
	cost = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.may_instability or 0 } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then 
            if context.card:gc().key == 'j_may_universal_collapse' then
                may.hand_mod_multchips_all('mult', 0, card.ability.extra.Xmult, false, card)
            end 
        end
		if context.end_of_round and context.game_over == false and context.main_eval then
			if (G.GAME.may_instability or 0) >= 15 then
                G.E_MANAGER:add_event(Event({delay = 0.1, func = function() 
                    play_sound('may_big_score1')
                    play_sound('may_hyperascendant_joker', 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 1
                    card:juice_up(2, 2)
                    card:set_ability(G.P_CENTERS['j_may_doomsday_device_ascended'])
                    card:set_cost() 
                    if may.conf.Mode == 1 then 
                        may.add_round_timer(6, 'ethereal_fuse')
                        may.a('Ethereal scaling will activate in 6 rounds!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1) 
                    end
                return true end}))
			end 
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}