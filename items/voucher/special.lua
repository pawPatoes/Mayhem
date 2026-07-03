-- Special Vouchers

-- Endless Mode

SMODS.Voucher {
	key = 'endless_mode',
	loc_txt = {
		name = "{C:tarot}Endless Mode{}",
		text = {
		    {
			    "Begin {C:purple,E:1}Endless Mode{}", 
				may.pager(), 
				"{X:purple,C:white}Endless{} content may now {C:green}appear{}", 
				"{C:green}New{} {C:dark_edition}systems{} are introduced", 
				"Game {C:mult}difficulty{} is {C:mult}increased{}", 
				"You are {C:mult}not{} able to {C:mult}exit{} {C:purple,E:1}Endless Mode{}",
		    }, 
		    {
			    "Appears in {C:green}every shop{}",
				"during and after {C:attention}Ante 9{}",
		    }
		}
	},
	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 30,
	unlocked = true,
	may_unsellable_voucher = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	redeem = function(self, card)
		G.GAME.may_endless_mode = true
		win_game()
        G.GAME.won = true
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_demiurgic_joker')
		return true end}))
	end,
	special_voucher_behavior = function(self)
		return G.GAME.round_resets.ante >= 9
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end
}

-- Reconfigure

SMODS.Voucher {
	key = 'reconfigure',
	loc_txt = {
		name = "{C:green}Reconfigure{}",
		text = {
		    {
			    "You may {C:money}sell{} most {C:green}redeemed Vouchers{}", 
				"and {C:mult}disable{} their effects", 
				"{C:inactive}Some modded Vouchers may not behave as intended{}", 
				"{C:inactive,s:0.7}Click on a Voucher in Run Info >> Vouchers{}"
		    }, 
		    {
			    "Appears every {C:attention}15 rounds{}"
		    }
		}
	},
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 30,
	unlocked = true,
	endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 15 == 0
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end
}

-- Astronomy

SMODS.Voucher {
	key = 'astronomy_1',
	loc_txt = {
		name = "Astronomy {C:planet}I{}",
		text = {
		    {
			    "{C:purple}Poker Hand{} {C:planet}level ups{} are {C:green}doubled{}", 
				"{C:inactive}Only for positive amounts{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}"
		    }
		}
	},
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 }, 
	atlas = 'misc_voucher',
	cost = 25,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 1},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 0
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end
}

SMODS.Voucher {
	key = 'astronomy_2',
	loc_txt = {
		name = "Astronomy {C:chips}II{}",
		text = {
		    {
			    "When a {C:purple}Poker Hand{} is {C:planet}leveled up{},", 
				"it gains {X:attention,C:white}#1#{} of the {C:purple}Mult & Chips{}", 
				"of {C:attention}most played{} {C:purple}Poker Hand{}", 
				"{C:inactive}Ignores most played Poker Hand{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		}
	},
	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 }, 
	atlas = 'misc_voucher',
	cost = 100,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 2},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { '(level increase)%' } }
	end, 
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) and context.hand ~= may.favhand() then
		    may.hand_multchips(card, context.hand, context.instant, {-1, G.GAME.hands[may.favhand()].chips * (context.amount * 0.01)}, {-1, G.GAME.hands[may.favhand()].mult * (context.amount * 0.01)})
		end
	end,
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 1
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end
}

SMODS.Voucher {
	key = 'astronomy_3',
	loc_txt = {
		name = "Astronomy {C:mult}III{}",
		text = {
		    {
			    "{C:purple}Poker Hands{} gain {X:purple,C:white}#1#(1.1XL){} Chips & Mult ", 
			    "when {C:planet}leveled up{} by {C:chips}hand-specific{} {C:planet}Planet Cards{}", 
				"{C:planet}L{} is the {C:planet}level increase{}; the {C:purple}Chips & Mult{} modification", 
				"does {C:mult}not{} {C:attention}stack{} regularly per {Cplanet}level{}", 
				may.pager(), 
			    "{C:planet}Level ups{} applied to", 
				"{C:attention}most played{} {C:purple}Poker Hand{} are {C:green}quadrupled{}",
				may.pager(), 
				"{C:inactive}G = #2#{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 }, 
	atlas = 'misc_voucher',
	cost = 200,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 3},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_global_op_tutorial", set = "Other" }
		return { vars = { '{G}', may.global_op() } }
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			if context.other_card and ((context.other_card.has_attribute and context.other_card:has_attribute('hand_specific')) or may.has_card('v_may_astronomy_5')) then
				may.hand_multchips(context.other_card, context.hand, context.instant, {may.global_op(), 1.1 * context.amount}, {may.global_op(), 1.1 * context.amount})
			end
		end
	end, 
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 2
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_4',
	loc_txt = {
		name = "Astronomy {C:attention}IV{}",
		text = {
		    {
			    "When a {C:purple}Poker Hand{} is {C:planet}leveled up{},", 
				"{C:attention}calculates{} the {C:chips}average{} {C:planet}level{}", 
				"of all {C:green}discovered{} {C:purple}Poker Hands{}", 
				may.pager(), 
				"If the {C:purple}Poker Hand's{} {C:planet}level{}", 
				"is {C:green}above{} or {C:attention}equal{} to the {C:chips}average{},", 
				"it will gain {X:purple,C:white}#1#(2XL){} Chips & Mult", 
				"{C:planet}L{} is the {C:planet}level increase{}; the {C:purple}Chips & Mult{} modification", 
				"does {C:mult}not{} {C:attention}stack{} regularly per {Cplanet}level{}", 
				may.pager(), 
				"If it is {C:mult}below{} the {C:chips}average{}, it will gain", 
				"{X:green,C:white}X5{} more {C:planet}levels{}", 
				may.pager(), 
				"{C:inactive}G = #2#, average is currently #3#{}", 
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 400,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 4},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_global_op_tutorial", set = "Other" }
		local avg = 0
		local num = 0
		for k, v in pairs(G.GAME.hands) do 
			if SMODS.is_poker_hand_visible(k) then
				avg = avg + v.level
				num = num + 1
			end
		end
		avg = avg / num
		return { vars = { '{G}', may.global_op(), avg } }
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			local avg = 0
			local num = 0
			for k, v in pairs(G.GAME.hands) do 
				if SMODS.is_poker_hand_visible(k) then
					avg = avg + v.level
					num = num + 1
				end
			end
			avg = avg / num
			if G.GAME.hands[context.hand].level >= avg then
				may.hand_multchips(context.other_card, context.hand, context.instant, {may.global_op(), 2 * context.amount}, {may.global_op(), 2 * context.amount})
			end
		end
	end, 
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 3
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_5',
	loc_txt = {
		name = "Astronomy {C:green}V{}",
		text = {
		    {
			    "{C:attention}Both{} effects of {C:may_transcendent}Astronomy{} {C:mult}III{}", 
				"will be {C:green}applied{} for any {C:planet}level up{}", 
				may.pager(), 
				"When a {C:purple}Poker Hand{} is {C:planet}leveled up{},", 
				"earn {C:money}Interest{} equal to {X:attention,C:white}X0.001{} the {C:planet}level{} {C:green}increase{}", 
				"{C:inactive}Max of +(Current Interest X 5){}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 750,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 5},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = G.P_CENTERS.v_may_astronomy_3
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			may.ease_interest(-1, math.min(G.GAME.interest_amount, to_number(context.amount) * 0.001), context.instant)
		end
	end,
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 4
	end, 
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_6',
	loc_txt = {
		name = "Astronomy {C:may_score}VI{}",
		text = {
		    {
			    "{C:spectral}Black Hole{} {C:attention}replaces{} all", 
				"{C:chips}hand-specific{} {C:planet}Planet Cards{}", 
				may.pager(), 
				"{C:purple}Poker Hand{} {C:planet}level ups{} are {X:green,C:white}X50{} bigger", 
				"{C:inactive}Only for positive amounts{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 500,
	unlocked = true,
	endless = true,
	special_tier = {'astronomy', 6},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_black_hole
	end,
	special_voucher_behavior = function(self)
		return G.GAME.may_endless_mode and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 5
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_7',
	loc_txt = {
		name = "Astronomy {C:money}VII{}",
		text = {
		    {
				"{C:may_demiurgic}Level{} {C:purple}Chips & Mult{} will modify the {C:purple}Chips & Mult{}", 
				"of {C:purple}Poker Hands{} using {C:may_prismatic}G{} instead of {C:attention}adding{}", 
				"when {C:planet}leveling up{}", 
				may.pager(), 
				"{C:inactive}G = #1#{}", 
				"{C:inactive}Only for positive amounts{}", 
				"{C:inactive,s:0.7}Eg. Level up High Card >> #2##3# Chips instead of +#3# Chips{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 1200,
	unlocked = true,
	post_transcendent = true,
	special_tier = {'astronomy', 7},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		return { vars = { may.global_op(), '{'..may.global_op()..'}', G.GAME.hands['High Card'].l_chips } }
	end,
	special_voucher_behavior = function(self)
		return may.get_run_stage() == 'post-transcendent' and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 6
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_8',
	loc_txt = {
		name = "Astronomy {C:purple}VIII{}",
		text = {
		    {
			    "When a {C:purple}Poker Hand{} is {C:mult}leveled down{}", 
				"all {C:attention}other{} {C:purple}Poker Hands{} are {C:planet}leveled up{}", 
				"by {X:green,C:white}X125{} the {C:mult}lost{} {C:planet}levels{}", 
				may.pager(), 
				"{C:attention}Multiplier{} is increased to {X:green,C:white}X200{} if", 
				"{C:attention}most played{} {C:purple}Poker Hand{} is {C:mult}leveled down{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 400,
	unlocked = true,
	post_transcendent = true,
	special_tier = {'astronomy', 8},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) < to_big(0) then
			may.level_up_all_hands(context.other_card, context.hand, context.instant, math.abs(context.amount) * (context.hand == may.favhand() and 200 or 125))
		end 
	end, 
	special_voucher_behavior = function(self)
		return may.get_run_stage() == 'post-transcendent' and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 7
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_9',
	loc_txt = {
		name = "Astronomy {C:may_opalescent}IX{}",
		text = {
		    {
			    "{C:purple}Poker Hand{} {C:planet}level ups{} are", 
				"{C:dark_edition}exponentially{} {C:green}increased{}", 
				"based on how many {C:attention}times{}", 
				"you have {C:attention}played{} the {C:purple}Poker Hand{}", 
				"this run", 
				may.pager(), 
				"{C:inactive}Increases by ^(1 + (N X 0.025)){}", 
				"{C:inactive}N is the number of times you've played the hand{}", 
				"{C:inactive}Only for positive amounts{}", 
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 1000,
	unlocked = true,
	post_transcendent = true,
	special_tier = {'astronomy', 9},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		return { vars = {  may.global_op() } }
	end,
	special_voucher_behavior = function(self)
		return may.get_run_stage() == 'post-transcendent' and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 8
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

SMODS.Voucher {
	key = 'astronomy_10',
	loc_txt = {
		name = "Astronomy {C:may_demiurgic}X{}",
		text = {
		    {
				"{C:green}Increases{} any {C:purple}Poker Hand{} {C:planet}level up{}", 
				"using the following {C:attention}formula{}", 
				may.pager(), 
				"{C:planet}Levels{} = {C:planet}Levels{} {C:mult}X{} {C:attention}({}{C:may_prismatic}G{} {C:dark_edition}^{} {C:attention}(({}{C:planet}N{} {C:dark_edition}^{} {C:green}O{}{C:attention}){} {C:mult}X{} {C:attention}5)){}", 
				may.pager(), 
				"{C:planet}N{} is the {C:planet}level{} increase", 
				"{C:mult}before{} other {C:planet}Astronomy{} Vouchers have been {C:green}applied{}", 
				may.pager(), 
				"{C:green}O{} is the number of {C:attention}times{} you have",
				"{C:attention}played{} the {C:purple}Poker Hand{} this run", 
				may.pager(), 
				"{C:money}Dollars{} will be {C:green}increased{} by", 
				"{C:attention}({}{C:planet}N{} {C:mult}X{} {C:green}O{}{C:attention}){} when leveling up", 
				may.pager(), 
				"Before scoring, earn {X:attention,C:white}X0.1{} the played {C:purple}hand's{} {C:money}Dollars{}", 
				"as {C:money}Interest{}",
				may.pager(), 
				"{C:inactive}G = #1#{}"
		    }, 
		    {
			    "Appears every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 }, 
	atlas = 'misc_voucher',
	cost = 1650,
	unlocked = true,
	post_transcendent = true,
	special_tier = {'astronomy', 10},
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_global_op_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		return { vars = { may.global_op() } }
	end,
	calculate = function(self, card, context)
		if context.before and context.scoring_name then
			may.ease_interest(-1, (G.GAME.hands[context.scoring_name].dollars or 0) * 0.1)
		end
	end, 
	special_voucher_behavior = function(self)
		return may.get_run_stage() == 'post-transcendent' and G.GAME.round % 9 == 0 and may.get_highest_special_voucher_tier('astronomy') == 9
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,
}

-- Transcend

SMODS.Voucher {
	key = 'transcend_1',
	loc_txt = {
		name = "Transcend {C:purple}I{}",
		text = {
            {
			    "{C:purple}Poker hands{} gain {X:mult,C:white}X1.2{} Mult and {C:chips}+200{} Chips when",
			    "{C:planet}leveled up{}",
			    "{C:money}+1 Interest{}",
			    "{C:attention}+2 Joker Slots{}",
			    "{C:attention}+1{} {C:green}Voucher{} slot in {C:attention}shop{}"
            }, 
            {
                "Appears after all {C:green}Vanilla{}", 
                "{C:attention}Tier 1{} {C:green}Vouchers{} have been", 
                "{C:money}redeemed{} as well as {C:attention}previous{}", 
                "{C:may_interdimensional}Transcend Vouchers{}"
            } 
		}
	},
	pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0} }, 
	atlas = 'misc_voucher',
	cost = 30,
	unlocked = true,
    endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	requires = {
		'v_overstock_norm',
		'v_clearance_sale',
		'v_hone',
		'v_reroll_surplus',
		'v_crystal_ball',
		'v_telescope',
		'v_grabber',
		'v_wasteful',
		'v_tarot_merchant',
		'v_planet_merchant',
		'v_seed_money',
		'v_blank',
		'v_magic_trick',
		'v_hieroglyph',
		'v_directors_cut',
		'v_paint_brush',
	},
	redeem = function(self, card)
		may.ease_interest(-1, 1)
		G.jokers:change_size(2)
		SMODS.change_voucher_limit(1)
	end,
	unredeem = function(self, card)
		may.ease_interest(-1, -1)
		G.jokers:change_size(-2)
		SMODS.change_voucher_limit(-1)
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			may.hand_mod_multchips(context.hand, 'chips', -1, 200 * context.amount, context.instant)
            may.hand_mod_multchips(context.hand, 'mult', 0, 1.2 ^ context.amount, context.instant)
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Voucher {
	key = 'transcend_2',
	loc_txt = {
		name = "Transcend {C:attention}II{}",
		text = {
            {
			    "{C:attention}+1 card{}, {C:green}Voucher{} and {C:attention}Booster{} slot in {C:attention}shop{}",
			    "{C:money}-1 Reroll Price{}",
			    "{C:attention}+1{} {C:chips}Hand{}, {C:mult}Discard{}, {C:attention}Hand Size{} and {C:attention}Card Selection Limit{}",
			    "{C:attention}+3 Consumable Slots{}", 
            }, 
            {
                "Appears after all {C:green}Vanilla{}", 
                "{C:attention}Tier 2{} {C:green}Vouchers{} have been", 
                "{C:money}redeemed{} as well as {C:attention}previous{}", 
                "{C:may_interdimensional}Transcend Vouchers{}"
            }
		}
	},
	pos = { x = 3, y = 0 },
    soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0} },  
	atlas = 'misc_voucher',
	cost = 60,
	unlocked = true,
    endless = true, 
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_transcendent , nil, 1.2)
	end,
	requires = {
		'v_overstock_plus',
		'v_liquidation',
		'v_glow_up',
		'v_reroll_glut',
		'v_omen_globe',
		'v_observatory',
		'v_nacho_tong',
		'v_recyclomancy',
		'v_tarot_tycoon',
		'v_planet_tycoon',
		'v_money_tree',
		'v_antimatter',
		'v_illusion',
		'v_petroglyph',
		'v_retcon',
		'v_palette',
        'v_may_transcend_1'
	},
	redeem = function(self, card)
		G.consumeables:change_size(3)
		SMODS.change_voucher_limit(1)
		SMODS.change_booster_limit(1)
		change_shop_size(1)
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 1
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - 1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
		ease_hands_played(1)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
		ease_discard(1)
		G.hand:change_size(1)
		G.hand:change_max_highlight(1)
	end,
	unredeem = function(self, card)
		G.consumeables:change_size(-3)
		SMODS.change_voucher_limit(-1)
		SMODS.change_booster_limit(-1)
		change_shop_size(-1)
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + 1)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
		ease_hands_played(-1)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
		ease_discard(-1)
		G.hand:change_size(-1)
		G.hand:change_max_highlight(-1)
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}