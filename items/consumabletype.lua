-- Consumable Types

SMODS.ConsumableType {
	key = 'may_modifiercard',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = G.C.DARK_EDITION,
	default = 'c_may_mult_card',
	loc_txt = {
		collection = 'Modifier Cards',
		name = 'Modifier Card',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'retrocards',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('1b7500'),
	default = 'c_may_easter_egg',
	loc_txt = {
		collection = 'Retro Cards',
		name = 'Retro',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'yottacards',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.YELLOW,
	loc_txt = {
		collection = 'Yotta Cards',
		name = 'Yotta',
	},
	default = 'c_may_potestas',
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'may_misc',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = G.C.GREY,
	default = 'c_may_present',
	loc_txt = {
		collection = 'Miscellaneous',
		name = 'Miscellaneous',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'upside_down_tarots',
	collection_rows = {5, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('7dc99a'),
	default = 'c_may_strength_upsd',
	loc_txt = {
		collection = 'TaraT CaraCs',
		name = 'TaraT',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'upside_down_planets',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('dbe398'),
	default = 'c_may_pluto_upsd',
	loc_txt = {
		collection = 'PlaalP CaraCs',
		name = 'PlaalP',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'upside_down_spectrals',
	collection_rows = {4, 5},
	primary_colour = G.C.BLACK,
	secondary_colour = HEX('ff00d4'),
	default = 'c_may_incantation_upsd',
	loc_txt = {
		collection = 'SpecepS CaraCs',
		name = 'SpecepS',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

--[[if may.conf.content.WIP then

SMODS.ConsumableType {
	key = 'ascendedtarots',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = SMODS.Gradients.may_col_asc_tarot,
	loc_txt = {
		collection = 'Ascended Tarots',
		name = 'Ascended Tarot',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedplanets',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.BLUE,
	loc_txt = {
		collection = 'Ascended Planets',
		name = 'Ascended Planet',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedspectrals',
	collection_rows = {6, 6},
	primary_colour = G.C.DARK_EDITION,
	secondary_colour = G.C.SECONDARY_SET.Spectral,
	loc_txt = {
		collection = 'Ascended Spectrals',
		name = 'Ascended Spectral',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

SMODS.ConsumableType {
	key = 'ascendedyottas',
	collection_rows = {6, 6},
	primary_colour = G.C.BLACK,
	secondary_colour = SMODS.Gradients.may_col_asc_yotta,
	loc_txt = {
		collection = 'Ascended Yotta Cards',
		name = 'Ascended Yotta Card',
	},
	shop_rate = 0,
	can_stack = true,
	can_divide = true,
}

end]]