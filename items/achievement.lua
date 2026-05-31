-- Achievements

SMODS.Achievement {
	key = 'keplers_nightmare',
	loc_txt = {
		name = "Kepler's Nightmare",
		description = {
			"Level up a Poker Hand",
			"to level 1e30"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 1, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "upgrade_hand" and to_big(args.level):gt(to_big(1e30)) then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'big_hundred',
	loc_txt = {
		name = "Big Hundred",
		description = {
			"Reach Ante 100"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 3, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == "ante_up" and args.ante >= 100 then
			return true
		end
	end,
}

SMODS.Achievement {
	key = 'money_mouth',
	loc_txt = {
		name = ":money_mouth:",
		description = {
			"Have $e1000"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 2, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'money' and G.GAME.dollars >= to_big(1e100):arrow(1, 10) then
			return true
		end
	end,
}

--[[SMODS.Achievement {
	key = 'the_one',
	loc_txt = {
		name = "The One",
		description = {
			"Have a deck of 1 card"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 4, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'modify_deck' and #G.playing_cards == 1 then
			return true
		end
	end,
}]]

SMODS.Achievement {
	key = 'i_think_thats_enough',
	loc_txt = {
		name = "I think that's enough",
		description = {
			"Win a run with 30 Jokers"
		},
	},
	atlas = 'may_achievement',
	pos = { x = 5, y = 0 },
	hidden_pos = { x = 0, y = 0 },
	bypass_all_unlocked = true,
	earned = false,
	hidden_name = true,
	unlock_condition = function(self, args)
		if args.type == 'win' and #G.jokers.cards >=30 then
			return true
		end
	end,
}