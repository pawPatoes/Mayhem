-- Tier 3 Vouchers

SMODS.Voucher {
	key = 'power_trip',
	loc_txt = {
		name = "Power Trip",
		text = {
			"{X:"..may.epic_key..",C:white}Epic{} Jokers will", 
			"appear {X:green,C:white}X4{} more frequently",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_natural_selection'},
	redeem = function(self, card)
		G.GAME[may.epic_key..'_mod'] = G.GAME[may.epic_key..'_mod'] * 4
	end,
	unredeem = function(self, card)
		G.GAME[may.epic_key..'_mod'] = G.GAME[may.epic_key..'_mod'] / 4
	end,
}

SMODS.Voucher {
	key = 'booster_cataclysm',
	loc_txt = {
		name = "Booster Cataclysm",
		text = {
			"{C:attention}+2{} {C:green}Booster Packs{} in shop",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	requires = {'v_may_booster_overabundance'},
	redeem = function(self, card)
		SMODS.change_booster_limit(2)
	end,
	unredeem = function(self, card)
		SMODS.change_booster_limit(-2)
	end,
}

SMODS.Voucher {
	key = 'trifecta',
	loc_txt = {
		name = "Trifecta",
		text = {
			"{C:spectral}Spectral Cards{} may appear in {C:attention}shop{}"
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	cost = 10,
	unlocked = true,
	voucher_sellable = true,
	requires = {'v_may_extended_selection'},
	redeem = function(self, card)
		G.GAME.spectral_rate = 4
	end,
	unredeem = function(self, card)
		G.GAME.spectral_rate = 0
	end,
}

SMODS.Voucher {
	key = 'quasar',
	loc_txt = {
		name = "Quasar",
		text = {
			"{C:attention}Quintuple{} the {C:may_demiurgic}Level{} {C:purple}Mult & Chips{}",
			"of {C:attention}all{} {C:purple}Poker Hands{}",
		}
	},
	pos = { x = 2, y = 0 },
	atlas = 'placeholder_voucher',
	requires = {'v_may_meteor'},
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		return { vars = {} }
	end,
	redeem = function(self, card)
		may.hand_lvl_multchips_all(card, false, {0, 5}, {0, 5})
		may.ch()
		may.refresh_score_operator()
	end
}
