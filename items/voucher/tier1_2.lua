-- Tier 1 and 2 Vouchers

SMODS.Voucher {
	key = 'food_chain',
	loc_txt = {
		name = "Food Chain",
		text = {
			"{X:mult,C:white}Rare{} Jokers are {X:attention,C:white}X2{} more common",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod*2
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod/2
	end,
}

SMODS.Voucher {
	key = 'natural_selection',
	loc_txt = {
		name = "Natural Selection",
		text = {
			"{X:mult,C:white}Rare{} Jokers are {X:attention,C:white}X3{} more common",
			"{X:green,C:white}Uncommon{} Jokers are {X:attention,C:white}X2{} more common",
		}
	},
	pos = { x = 3, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	requires = {'v_may_food_chain'},
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod*3
		G.GAME.uncommon_mod = G.GAME.uncommon_mod*2
	end,
	unredeem = function(self, card)
		G.GAME.rare_mod = G.GAME.rare_mod/3
		G.GAME.uncommon_mod = G.GAME.uncommon_mod/2
	end,
}


SMODS.Voucher {
	key = 'booster_surplus',
	loc_txt = {
		name = "Booster Surplus",
		text = {
			"{C:attention}+1{} {C:green}Booster Pack{} in shop",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		SMODS.change_booster_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-1)
	end,
}

SMODS.Voucher {
	key = 'booster_overabundance',
	loc_txt = {
		name = "Booster Overabundance",
		text = {
			"{C:attention}+1{} {C:green}Booster Pack{} in shop",
		}
	},
	pos = { x = 1, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_booster_surplus'},
	redeem = function(self, card)
		SMODS.change_booster_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-1)
	end,
}


SMODS.Voucher {
	key = 'big_boosters',
	loc_txt = {
		name = "Big Boosters",
		text = {
			"Future {C:green}Booster Packs{} have", 
            "{C:attention}+1{} card"
		}
	},
	pos = { x = 2, y = 3 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
	end,
	unredeem = function(self, card)
		G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - 1
	end,
}

SMODS.Voucher {
	key = 'huge_boosters',
	loc_txt = {
		name = "Huge Boosters",
		text = {
			"Future {C:green}Booster Packs{} have", 
            "{C:attention}+1{} card"
		}
	},
	pos = { x = 3, y = 3 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true, 
	requires = {'v_may_big_boosters'},
	redeem = function(self, card)
		G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
	end,
	unredeem = function(self, card)
		G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - 1
	end,
} 


if may.conf.Mode == 1 then

SMODS.Voucher {
	key = 'voucher_surplus',
	loc_txt = {
		name = "Voucher Surplus",
		text = {
			"{C:attention}+1{} {C:green}Voucher{} in shop",
			"{C:mult}-1{} {C:green}Booster Pack{} in shop"
		}
	},
	pos = { x = 6, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		SMODS.change_voucher_limit(1)
		SMODS.change_booster_limit(-1)
	end,
	unredeem = function(self, card)
		SMODS.change_voucher_limit(-1)
		SMODS.change_booster_limit(1)
	end,
}

else

SMODS.Voucher {
	key = 'voucher_surplus',
	loc_txt = {
		name = "Voucher Surplus",
		text = {
			"{C:attention}+1{} {C:green}Voucher{} in shop",
		}
	},
	pos = { x = 6, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	redeem = function(self, card)
		SMODS.change_voucher_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_voucher_limit(-1)
	end,
}

end

if may.conf.Mode == 1 then

SMODS.Voucher {
	key = 'voucher_overabundance',
	loc_txt = {
		name = "Voucher Overabundance",
		text = {
			"{C:attention}+1{} {C:green}Voucher{} in shop",
			"{C:mult}-1{} {C:green}Booster Pack{} in shop"
		}
	},
	pos = { x = 5, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	requires = {'v_may_voucher_surplus'},
	redeem = function(self, card)
		SMODS.change_voucher_limit(1)
		SMODS.change_booster_limit(-1)
	end,
	unredeem = function(self, card)
		SMODS.change_voucher_limit(-1)
		SMODS.change_booster_limit(1)
	end,
}

else

SMODS.Voucher {
	key = 'voucher_overabundance',
	loc_txt = {
		name = "Voucher Overabundance",
		text = {
			"{C:attention}+1{} {C:green}Voucher{} in shop",
		}
	},
	pos = { x = 5, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	requires = {'v_may_voucher_surplus'},
	redeem = function(self, card)
		SMODS.change_voucher_limit(1)
	end,
	unredeem = function(self, card)
		SMODS.change_voucher_limit(-1)
	end,
}

end


SMODS.Voucher {
	key = 'varied_selection',
	loc_txt = {
		name = "Varied Selection",
		text = {
			"{C:dark_edition}Modifier Cards{} may appear in {C:attention}shop{}",
		}
	},
	pos = { x = 4, y = 0 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		G.GAME.may_modifiercard_rate = 1.4
	end,
	unredeem = function(self, card)
		G.GAME.may_modifiercard_rate = 0
	end,
}

SMODS.Voucher {
	key = 'extended_selection',
	loc_txt = {
		name = "Extended Selection",
		text = {
			"{C:retrocards}Retro Cards{} may appear in {C:attention}shop{}",
		}
	},
	pos = { x = 0, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	requires = {'v_may_varied_selection'},
	redeem = function(self, card)
		G.GAME.retrocards_rate = 1.3
	end,
	unredeem = function(self, card)
		G.GAME.retrocards_rate = 0
	end,
}


SMODS.Voucher {
	key = 'stardust',
	loc_txt = {
		name = "Stardust",
		text = {
			"{C:purple}Poker hands{} gain {C:mult}+5{} Mult and {C:chips}+15{} Chips when",
			"{C:planet}leveled up{}"
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0)	then
			may.hand_multchips(context.other_card, context.hand, context.instant, {-1, (15 * context.amount)}, {-1, (5 * context.amount)})
		end
	end
}

SMODS.Voucher {
	key = 'meteor',
	loc_txt = {
		name = "Meteor",
		text = {
			"{C:purple}Poker hands{} gain {X:purple,C:white}X1.02{} Mult & Chips when",
			"{C:planet}leveled up{}"
		}
	},
	pos = { x = 3, y = 1 },
	atlas = 'voucher',
	cost = 10,
	requires = {'v_may_stardust'},
	unlocked = true,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			may.hand_multchips(context.other_card, context.hand, context.instant, {0, (1.02 ^ context.amount)}, {0, (1.02 ^ context.amount)})
		end
	end
}


SMODS.Voucher {
	key = 'investment',
	loc_txt = {
		name = "Investment",
		text = {
			"{C:money}+1 Interest{}",
		}
	},
	pos = { x = 0, y = 1 },
	atlas = 'may_voucher',
	cost = 10,
	unlocked = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
    end,
	redeem = function(self, card)
		may.ease_interest(-1, 1)
	end,
	unredeem = function(self, card)
		may.ease_interest(-1, -1)
	end,
}

SMODS.Voucher {
	key = 'business',
	loc_txt = {
		name = "Business",
		text = {
			"{C:money}+1 Interest{}",
		}
	},
	pos = { x = 1, y = 1 },
	atlas = 'may_voucher',
	requires = {'v_may_investment'},
	cost = 10,
	unlocked = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
    end,
	redeem = function(self, card)
		may.ease_interest(-1, 1)
	end,
	unredeem = function(self, card)
		may.ease_interest(-1, -1)
	end,
}


SMODS.Voucher {
	key = 'spicy',
	loc_txt = {
		name = "Spicy",
		text = {
			"{C:attention}+1 Ante{}",
			"{C:attention}+2 Hand Size{}"
		}
	},
	pos = { x = 3, y = 0 },
	atlas = '003_temp',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		ease_ante(1)
		G.hand:change_size(2)
	end,
	unredeem = function(self, card)
		ease_ante(-1)
		G.hand:change_size(-2)
	end,
}

SMODS.Voucher {
	key = 'hot',
	loc_txt = {
		name = "Hot",
		text = {
			"{C:attention}+1 Ante{}",
			"{C:attention}+1{} {C:green}Voucher{} in Shop"
		}
	},
	pos = { x = 1, y = 0 },
	atlas = '003_temp',
	requires = {'v_may_spicy'},
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	redeem = function(self, card)
		ease_ante(1)
		SMODS.change_voucher_limit(1)
	end,
	unredeem = function(self, card)
		ease_ante(-1)
		SMODS.change_voucher_limit(-1)
	end,
}


SMODS.Voucher {
	key = 'powerful',
	loc_txt = {
		name = "Powerful",
		text = {
			"{X:mult,C:white}X#1#{} Mult after scoring",
		}
	},
	pos = { x = 4, y = 1 },
	atlas = 'may_voucher',
	config = { extra = { x_mult = 1.5 } },
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('multhit2')
			return true end}))
			return {
				x_mult = card.ability.extra.x_mult,
				remove_default_message = true,
			}
		end
	end
}

SMODS.Voucher {
	key = 'unstoppable',
	loc_txt = {
		name = "Unstoppable",
		text = {
			"{X:chips,C:white}X#1#{} Chips after scoring",
		}
	},
	pos = { x = 5, y = 1 },
	atlas = 'may_voucher',
	config = { extra = { x_chips = 2.5 } },
	cost = 10,
	unlocked = true,
	requires = {'v_may_powerful'},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_xchip')
			return true end}))
			return {
				x_chips = card.ability.extra.x_chips,
				remove_default_message = true,
			}
		end
	end
}


SMODS.Voucher {
	key = 'increment',
	loc_txt = {
		name = "Increment",
		text = {
			"Played {C:attention}cards gain{}",
			"{C:mult}+#1#{} Mult {C:attention}before scoring{}",
		}
	},
	pos = { x = 4, y = 0 },
	atlas = '003_temp',
	config = { extra = { mult = 1 } },
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.before then 
			for k, v in pairs(G.play.cards) do
				v.ability.perma_mult = (v.ability.perma_mult or 0) + card.ability.extra.mult
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Upgraded!', colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
			end
		end
	end
}

SMODS.Voucher {
	key = 'increase',
	loc_txt = {
		name = "Increase",
		text = {
			"Played {C:attention}cards gain{}",
			"{C:chips}+#1#{} Chips {C:attention}before scoring{}",
			"{C:attention}Increases{} by {C:chips}#2#{} {C:attention}per card{} played",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = '003_temp',
	config = { extra = { chips = 5, chips_gain = 0.1 } },
	cost = 10,
	unlocked = true,
	requires = {'v_may_increment'},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chips_gain * #G.play.cards)
			for k, v in pairs(G.play.cards) do
				v.ability.perma_bonus = (v.ability.perma_bonus or 0) + card.ability.extra.chips
				card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Upgraded!', colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus' })
			end
		end
	end
}


SMODS.Voucher {
	key = 'misprint',
	loc_txt = {
		name = "Misprint",
		text = {
			"{C:inactive,E:1}Art by by @silly_goober_0nthewall (Discord){}"
		}
	},
	pos = { x = 0, y = 2 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	loc_vars = function(self, info_queue, card)
		return { main_start = {
            {n = G.UIT.O, config = { object = DynaText({
                string = { 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.DARK_EDITION }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.RED }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.YELLOW }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.BLUE }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = SMODS.Gradients.may_col_ethereal }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = SMODS.Gradients.may_col_hyperascendant }, 
                },
                colours = { G.C.UI.TEXT_DARK },
                pop_in_rate = 10,
                silent = true,
                random_element = true,
                pop_delay = 0.2011,
                scale = 0.32,
                min_cycle_time = 0
            })}},
        } }
	end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
            play_sound('may_error_seal')
		return true end}))
        for i=1, 15 do
            may.h(may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)))
        end
        may.ch()
    end, 
	calculate = function(self, card, context)
		if context.before then
			local choice = pseudorandom('may_misprint', 1, 5)
            if choice == 1 then 
                level_up_hand(nil, context.scoring_name, false, pseudorandom('may_misprint', 0.1, 1))
            elseif choice == 2 then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				    play_sound('multhit1')
			    return true end}))
			    return {
				    mult = pseudorandom('may_misprint', 10, 20),
				    remove_default_message = true,
			    }
            elseif choice == 3 then 
                may.ease_interest(-1, pseudorandom('may_misprint', 0.02, 0.1))
            elseif choice == 4 then
                ease_dollars(pseudorandom('may_misprint', 2, 7))
            else
                SMODS.add_card { set = 'Tarot', key_append = 'may_misprint' }
            end
		end
	end
}

SMODS.Voucher {
	key = 'error',
	loc_txt = {
		name = "{C:mult,s:0.2}E{}{C:may_interdimensional,s:1.1}r{} {C:dark_edition,s:0.5}R{}{C:chips,X:edition,s:1.5}o{}{C:inactive,s:0.7}r{}",
		text = {
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
    requires = {'v_may_misprint'}, 
	loc_vars = function(self, info_queue, card)
		return { main_start = {
            {n = G.UIT.O, config = { object = DynaText({
                string = { 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.DARK_EDITION }, 
                    { string = may.obfuscatedtext(math.random(7, 10)), colour = G.C.RED }, 
                    { string = may.obfuscatedtext(math.random(5, 9)), colour = G.C.YELLOW }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.BLUE }, 
                    { string = may.obfuscatedtext(math.random(1, 10)), colour = SMODS.Gradients.may_col_ethereal }, 
                    { string = may.obfuscatedtext(math.random(5, 19)), colour = SMODS.Gradients.may_col_hyperascendant }, 
                },
                colours = { G.C.UI.TEXT_DARK },
                pop_in_rate = 99999,
                silent = true,
                random_element = true,
                pop_delay = (may.conf.epileptic and 0.7) or 0,
                scale = 0.32,
                min_cycle_time = 0
            })}},
            {n = G.UIT.O, config = { object = DynaText({
                string = { 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.DARK_EDITION }, 
                    { string = may.obfuscatedtext(math.random(7, 10)), colour = G.C.RED }, 
                    { string = may.obfuscatedtext(math.random(5, 9)), colour = G.C.YELLOW }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.BLUE }, 
                    { string = may.obfuscatedtext(math.random(1, 10)), colour = SMODS.Gradients.may_col_ethereal }, 
                    { string = may.obfuscatedtext(math.random(5, 19)), colour = SMODS.Gradients.may_col_hyperascendant }, 
                },
                colours = { G.C.UI.TEXT_DARK },
                pop_in_rate = 700,
                silent = true,
                random_element = true,
                pop_delay = 0.4,
                scale = 0.32,
                min_cycle_time = 0
            })}},
            {n = G.UIT.O, config = { object = DynaText({
                string = { 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.DARK_EDITION }, 
                    { string = may.obfuscatedtext(math.random(7, 10)), colour = G.C.RED }, 
                    { string = may.obfuscatedtext(math.random(5, 9)), colour = G.C.YELLOW }, 
                    { string = may.obfuscatedtext(math.random(5, 10)), colour = G.C.BLUE }, 
                    { string = may.obfuscatedtext(math.random(1, 10)), colour = SMODS.Gradients.may_col_ethereal }, 
                    { string = may.obfuscatedtext(math.random(5, 19)), colour = SMODS.Gradients.may_col_hyperascendant }, 
                },
                colours = { G.C.UI.TEXT_DARK },
                pop_in_rate = 4,
                silent = true,
                random_element = true,
                pop_delay = 1,
                scale = 0.32,
                min_cycle_time = 0
            })}},
        } }
	end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
            play_sound('may_error_seal')
		return true end}))
        for i=1, 15 do
            may.h(may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)), may.obfuscatedtext(math.random(4, 7)))
        end
        may.ch()
    end, 
	calculate = function(self, card, context)
		if context.before then
			local choice = pseudorandom('may_misprint', 1, 5)
            if choice == 1 then 
                SMODS.add_card({ set = 'Planet', key_append = 'may_error' })
            elseif choice == 2 then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				    play_sound('talisman_echip')
			    return true end}))
			    return {
				    e_chip = pseudorandom('may_misprint', 1.01, 1.09),
				    remove_default_message = true,
			    }
            elseif choice == 3 then 
                ease_discard(1)
            elseif choice == 4 then
                G.hand:change_size(1)
				G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 1
            else
                SMODS.add_card { set = 'Spectral', key_append = 'may_error' }
            end
		end
	end
}


SMODS.Voucher {
	key = 'astronomy',
	loc_txt = {
		name = "Astronomy",
		text = {
			"Future {C:planet}Celestial Packs{}", 
            "have {C:attention}+1{} {C:green}card{} and {C:green}choice{}"
		}
	},
	pos = { x = 4, y = 3 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_jumbo_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_mega_1
	end,
	redeem = function(self)
        G.GAME.may_pack_bonuses = G.GAME.may_pack_bonuses or {}
        G.GAME.may_pack_bonuses.Celestial = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.Celestial.cards = (G.GAME.may_pack_bonuses.Celestial.cards or 0) + 1
        G.GAME.may_pack_bonuses.Celestial.choices = (G.GAME.may_pack_bonuses.Celestial.choices or 0) + 1
    end, 
    unredeem = function(self)
        G.GAME.may_pack_bonuses = G.GAME.may_pack_bonuses or {}
        G.GAME.may_pack_bonuses.Celestial = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.Celestial.cards = (G.GAME.may_pack_bonuses.Celestial.cards or 0) - 1
        G.GAME.may_pack_bonuses.Celestial.choices = (G.GAME.may_pack_bonuses.Celestial.choices or 0) - 1
    end
}

SMODS.Voucher {
	key = 'orbit',
	loc_txt = {
		name = "Orbit",
		text = {
			"When {C:attention}Boss Blind{} is", 
            "defeated, gain {C:attention}2{} {C:planet}Meteor Tags{}"
		}
	},
	pos = { x = 5, y = 3 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
    requires = {'v_may_astronomy'}, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then 
            for i=1, 2 do 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    add_tag(Tag('tag_meteor'))
                    play_sound('tarot1')
                return true end}))
            end 
        end
    end
}


SMODS.Voucher {
	key = 'card_merchant',
	loc_txt = {
		name = "Card Merchant",
		text = {
			"Future {C:attention}Standard Packs{}", 
            "and {C:money}Premium Packs{}",
            "have {C:attention}+2{} {C:green}cards{} and {C:attention}+1{} {C:green}choice{}"
		}
	},
	pos = { x = 0, y = 4 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_jumbo_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_mega_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_premium1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_jumbo_premium1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_mega_premium1
	end,
	redeem = function(self)
        G.GAME.may_pack_bonuses = G.GAME.may_pack_bonuses or {}
        G.GAME.may_pack_bonuses.Standard = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.Standard.cards = (G.GAME.may_pack_bonuses.Standard.cards or 0) + 2
        G.GAME.may_pack_bonuses.Standard.choices = (G.GAME.may_pack_bonuses.Standard.choices or 0) + 1
        G.GAME.may_pack_bonuses.may_premium = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.may_premium.cards = (G.GAME.may_pack_bonuses.may_premium.cards or 0) + 2
        G.GAME.may_pack_bonuses.may_premium.choices = (G.GAME.may_pack_bonuses.may_premium.choices or 0) + 1
    end, 
    unredeem = function(self)
        G.GAME.may_pack_bonuses = G.GAME.may_pack_bonuses or {}
        G.GAME.may_pack_bonuses.Standard = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.Standard.cards = (G.GAME.may_pack_bonuses.Standard.cards or 0) - 2
        G.GAME.may_pack_bonuses.Standard.choices = (G.GAME.may_pack_bonuses.Standard.choices or 0) - 1
        G.GAME.may_pack_bonuses.may_premium = G.GAME.may_pack_bonuses.Celestial or {}
        G.GAME.may_pack_bonuses.may_premium.cards = (G.GAME.may_pack_bonuses.may_premium.cards or 0) - 2
        G.GAME.may_pack_bonuses.may_premium.choices = (G.GAME.may_pack_bonuses.may_premium.choices or 0) - 1
    end 
}

SMODS.Voucher {
	key = 'card_tycoon',
	loc_txt = {
		name = "Card Tycoon",
		text = {
			"Future {C:attention}Standard Packs{}", 
            "are {C:green}replaced{} with equivalent", 
            "{C:money}Premium Packs{}"
		}
	},
	pos = { x = 1, y = 4 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
    requires = {'v_may_card_merchant'}, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_jumbo_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_mega_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_premium1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_jumbo_premium1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_may_b_mega_premium1
	end,
}

SMODS.Voucher {
	key = 'upside_down_merchant',
	loc_txt = {
		name = "Upside Down Merchant",
		text = {
			"{C:dark_edition}Upside Down{} Consumables", 
			"will appear {X:attention,C:white}35%{} more {C:green}frequently{}",
			may.pager(), 
			"{C:inactive}#1# in #2# >> #1# in #3#{}"
		}
	},
	pos = { x = 2, y = 4 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, (G.GAME.may_upsd_rate or 80), (G.GAME.may_upsd_rate or 80) - ((G.GAME.may_upsd_rate or 80) * 0.35) } }
	end,
	redeem = function(self)
		G.GAME.may_upsd_rate = (G.GAME.may_upsd_rate or 80) - ((G.GAME.may_upsd_rate or 80) * 0.35)
	end 
}

SMODS.Voucher {
	key = 'upside_down_tycoon',
	loc_txt = {
		name = "Upside Down Tycoon",
		text = {
			"{C:dark_edition}Upside Down{} Consumables", 
			"will appear {X:attention,C:white}50%{} more {C:green}frequently{}", 
			may.pager(55), 
			"{C:inactive}#1# in #2# >> #1# in #3#{}"
		}
	},
	pos = { x = 3, y = 4 },
	atlas = 'voucher',
	cost = 10,
	unlocked = true,
	requires = { 'v_may_upside_down_merchant' }, 
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, (G.GAME.may_upsd_rate or 80), (G.GAME.may_upsd_rate or 80) - ((G.GAME.may_upsd_rate or 80) * 0.5) } }
	end,
	redeem = function(self)
		G.GAME.may_upsd_rate = (G.GAME.may_upsd_rate or 80) - ((G.GAME.may_upsd_rate or 80) * 0.5)
	end 
}