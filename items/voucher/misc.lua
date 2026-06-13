-- Miscellaneous Vouchers

-- Endless Mode

SMODS.Voucher {	key = 'endless_mode',	loc_txt = {		name = "{C:tarot}Endless Mode{}",		text = {
		    {			    "Begin {C:purple,E:1}Endless Mode{}", 
				may.pager(), 
				"{X:purple,C:white}Endless-Exclusive{} content may now {C:green}appear{}", 
				"{C:green}New{} {C:dark_edition}systems{} are introduced", 
				"Game {C:mult}difficulty{} is {C:mult}increased{}", 
				"You are {C:mult}not{} able to {C:mult}exit{} {C:purple,E:1}Endless Mode{}",		    }, 
		    {
			    "Appears in {C:green}every shop{}",
				"during and after {C:attention}Ante 9{}",
		    }
		}	},	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 2 }, 	atlas = 'misc_voucher',	cost = 30,	unlocked = true,
	may_unsellable_voucher = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,
	redeem = function(self, card)
		G.GAME.may_endless_mode = true
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_ethereal_joker')
		return true end}))
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end}

-- Reconfigure

SMODS.Voucher {	key = 'reconfigure',	loc_txt = {		name = "{C:green}Reconfigure{}",		text = {
		    {			    "You may {C:money}sell{} most {C:green}redeemed Vouchers{}", 
				"and {C:mult}disable{} their effects", 
				"{C:inactive}Some modded Vouchers may not behave as intended{}", 
				"{C:inactive,s:0.7}Click on a Voucher in Run Info >> Vouchers{}"		    }, 
		    {
			    "Appears in {C:purple,E:1}Endless Mode{}", 
			    "every {C:attention}15 rounds{}"
		    }
		}	},	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 }, 	atlas = 'misc_voucher',	cost = 30,	unlocked = true,
	endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end}

-- Astronomy

SMODS.Voucher {	key = 'astronomy_1',	loc_txt = {		name = "Astronomy {C:planet}I{}",		text = {
		    {			    "{C:purple}Poker Hand{} {C:planet}level ups{} are clamped",
			    "to be {C:green}at least 0{} and {C:green}doubled{}"		    }, 
		    {
			    "Appears in {C:purple,E:1}Endless Mode{}", 
			    "every {C:attention}9 rounds{}"
		    }
		}	},	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 }, 	atlas = 'misc_voucher',	cost = 35,	unlocked = true,
	endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end}

SMODS.Voucher {	key = 'astronomy_2',	loc_txt = {		name = "Astronomy {C:chips}II{}",		text = {
		    {			    "When a {C:purple}Poker Hand{} is {C:planet}leveled up{},", 
				"it gains {X:attention,C:white}#1#{} of the {C:purple}Mult & Chips{}", 
				"of {C:attention}most played{} {C:purple}Poker Hand{}", 
				"{C:inactive}Ignores most played Poker Hand{}"		    }, 
		    {
			    "Appears in {C:purple,E:1}Endless Mode{}", 
			    "every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		}	},	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 }, 	atlas = 'misc_voucher',	cost = 100,	unlocked = true,
	endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { '(level increase)%' } }
	end, 
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) and context.hand ~= may.favhand() then
		    may.hand_multchips(card, context.hand, context.instant, {-1, G.GAME.hands[may.favhand()].chips * (context.amount * 0.01)}, {-1, G.GAME.hands[may.favhand()].mult * (context.amount * 0.01)})
		end
	end,
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end}

SMODS.Voucher {	key = 'astronomy_3',	loc_txt = {		name = "Astronomy {C:mult}III{}",		text = {
		    {			    "{C:purple}Poker Hands{} gain {X:purple,C:white}^1.1{} Mult & Chips", 
			    "when {C:planet}leveled up{} by {C:chips}hand-specific{} {C:planet}Planet Cards{}", 
			    "{C:planet}Level ups{} applied to", 
				"{C:attention}most played{} {C:purple}Poker Hand{} are {C:green}quadrupled{}",		    }, 
		    {
			    "Appears in {C:purple,E:1}Endless Mode{}", 
			    "every {C:attention}9 rounds{}", 
			    "if {C:attention}previous{} {C:planet}Astronomy{} tiers have been {C:green}redeemed{}"
		    }
		} 	},	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 }, 	atlas = 'misc_voucher',	cost = 1350,	unlocked = true,
	endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,
	calculate = function(self, card, context)
		if context.level_up_hand and to_big(context.amount) > to_big(0) then
			if context.other_card and context.other_card.may_is_pool and 	context.other_card:may_is_pool('HandSpecific') then
				local factor = math.abs(context.amount) == 1 and to_big(1.1) or to_big(1.1) ^ math.abs(context.amount)
				may.hand_multchips(context.other_card, context.hand, context.instant, {1, factor}, {1, factor})
			end
		end
	end, 
    in_pool = function(self, args)
		return false, { allow_duplicates = false }
	end,}
-- TranscendSMODS.Voucher {	key = 'transcend_1',	loc_txt = {		name = "Transcend {C:purple}I{}",		text = {
            {			    "{C:purple}Poker hands{} gain {X:mult,C:white}X1.2{} Mult and {C:chips}+200{} Chips when",			    "{C:planet}leveled up{}",			    "{C:money}+1 Interest{}",			    "{C:attention}+2 Joker Slots{}",			    "{C:attention}+1{} {C:green}Voucher{} slot in {C:attention}shop{}"
            }, 
            {
                "Appears after all {C:green}Vanilla{}", 
                "{C:attention}Tier 1{} {C:green}Vouchers{} have been", 
                "{C:money}redeemed{} as well as {C:attention}previous{}", 
                "{C:may_interdimensional}Transcend Vouchers{}"
            } 		}	},	pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0} }, 	atlas = 'misc_voucher',	cost = 30,	unlocked = true,
    endless = true,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,	requires = {		'v_overstock_norm',		'v_clearance_sale',		'v_hone',		'v_reroll_surplus',		'v_crystal_ball',		'v_telescope',		'v_grabber',		'v_wasteful',		'v_tarot_merchant',		'v_planet_merchant',		'v_seed_money',		'v_blank',		'v_magic_trick',		'v_hieroglyph',		'v_directors_cut',		'v_paint_brush',	},	redeem = function(self, card)		may.ease_interest(-1, 1)		G.jokers:change_size(2)		SMODS.change_voucher_limit(1)	end,	unredeem = function(self, card)		may.ease_interest(-1, -1)		G.jokers:change_size(-2)		SMODS.change_voucher_limit(-1)	end,	calculate = function(self, card, context)		if context.level_up_hand and to_big(context.amount) > to_big(0) then			may.hand_mod_multchips(context.hand, 'chips', -1, 200 * context.amount, context.instant)
            may.hand_mod_multchips(context.hand, 'mult', 0, 1.2 ^ context.amount, context.instant)		end	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end}SMODS.Voucher {	key = 'transcend_2',	loc_txt = {		name = "Transcend {C:attention}II{}",		text = {
            {			    "{C:attention}+1 card{}, {C:green}Voucher{} and {C:attention}Booster{} slot in {C:attention}shop{}",			    "{C:money}-1 Reroll Price{}",			    "{C:attention}+1{} {C:chips}Hand{}, {C:mult}Discard{}, {C:attention}Hand Size{} and {C:attention}Card Selection Limit{}",			    "{C:attention}+3 Consumable Slots{}", 
            }, 
            {
                "Appears after all {C:green}Vanilla{}", 
                "{C:attention}Tier 2{} {C:green}Vouchers{} have been", 
                "{C:money}redeemed{} as well as {C:attention}previous{}", 
                "{C:may_interdimensional}Transcend Vouchers{}"
            }		}	},	pos = { x = 3, y = 0 },
    soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0} },  	atlas = 'misc_voucher',	cost = 60,	unlocked = true,
    endless = true, 
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Special Voucher', SMODS.Gradients.may_col_hyperascendant , nil, 1.2)
	end,	requires = {		'v_overstock_plus',		'v_liquidation',		'v_glow_up',		'v_reroll_glut',		'v_omen_globe',		'v_observatory',		'v_nacho_tong',		'v_recyclomancy',		'v_tarot_tycoon',		'v_planet_tycoon',		'v_money_tree',		'v_antimatter',		'v_illusion',		'v_petroglyph',		'v_retcon',		'v_palette',
        'v_may_transcend_1'	},	redeem = function(self, card)		G.consumeables:change_size(3)		SMODS.change_voucher_limit(1)		SMODS.change_booster_limit(1)		change_shop_size(1)		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 1        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - 1)		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1		ease_hands_played(1)		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1		ease_discard(1)		G.hand:change_size(1)		G.hand:change_max_highlight(1)	end,	unredeem = function(self, card)		G.consumeables:change_size(-3)		SMODS.change_voucher_limit(-1)		SMODS.change_booster_limit(-1)		change_shop_size(-1)		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + 1)		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1		ease_hands_played(-1)		G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1		ease_discard(-1)		G.hand:change_size(-1)		G.hand:change_max_highlight(-1)	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end}