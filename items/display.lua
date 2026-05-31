-- Display cards

SMODS.ConsumableType {
	key = 'may_display',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = SMODS.Gradients.may_col_mayhem_gradient,
	default = 'c_may_ring_display',
	loc_txt = {
		collection = 'Displays',
		name = 'Display',
	},
	shop_rate = 0,
	can_stack = false,
	can_divide = false,
	no_collection = true,
	may_hide_default = true,
}

-- Ring Display
SMODS.Consumable {
	set = 'may_display',
	key = 'ring_display',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	display_size = { w = 49, h = 49 },
	atlas = 'display',
	loc_txt = {
		name = 'Ring Bonuses',
		text = {
			{
				"Bonuses for next {C:purple}Poker Hand{}",
				"that is {C:planet}leveled up{}:",
			},
			{
				"{C:mult}+#1#{} Mult | {C:chips}+#2#{} Chips",
				"{C:mult}+#3#{} {C:may_ethereal}Level{} Mult | {C:chips}+#4#{} {C:may_ethereal}Level{} Chips",
				"{C:may_score}+#5#{} Score | {C:money}+#6#{} Dollars",
				"{C:planet}+#7#{} additional levels",
			},
		}
	},
	can_use = function(self, card)
		return false
	end,
	no_collection = true,
	may_permanent = true,
	no_grc = true,
	no_doe = true,
	loc_vars = function(self, info_queue, card)
		if G.GAME.may_ring_bonuses then
			return { vars = { (G.GAME.may_ring_bonuses.mult or 0), (G.GAME.may_ring_bonuses.chips or 0), (G.GAME.may_ring_bonuses.lev_mult or 0), (G.GAME.may_ring_bonuses.lev_chips or 0), (G.GAME.may_ring_bonuses.score or 0), (G.GAME.may_ring_bonuses.dollars or 0), (G.GAME.may_ring_bonuses.levels or 0), } }
		end
	end,
}