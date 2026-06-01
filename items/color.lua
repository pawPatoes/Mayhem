-- Custom Colors

G.C.MAY_RED = HEX('8c0303')

G.C.DARK_MAY_RED = HEX('a14343')

SMODS.Gradient {
	key = 'col_eternum_green',
	colours = {G.C.GREEN, HEX('6aa35dff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_mayhem_gradient',
	colours = {HEX('8c0303ff'), HEX('a14343ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_eternum_green_dark1',
	colours = {mix_colours(G.C.GREEN, HEX('000000'), 0.5), mix_colours(HEX('6aa35dff'), HEX('000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_mayhem_gradient_dark1',
	colours = {mix_colours(HEX('8c0303ff'), HEX('000000'), 0.5), mix_colours(HEX('a14343ff'), HEX('000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_eternum_green_dark2',
	colours = {mix_colours(G.C.GREEN, HEX('00000000'), 0.5), mix_colours(HEX('6aa35dff'), HEX('00000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_mayhem_gradient_dark2',
	colours = {mix_colours(HEX('8c0303ff'), HEX('00000000'), 0.5), mix_colours(HEX('a14343ff'), HEX('00000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_hyperascendant',
	colours = {HEX('ff0000'), HEX('fbff00'), HEX('ff6200'), HEX('ff6200'), HEX('2bff00')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_ethereal',
	colours = {HEX('6f00ff'), HEX('ff00fb'), HEX('182052'), HEX('00e1ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_interdimensional',
	colours = {HEX('34eb9b'), HEX('ffe600'), HEX('2c2054')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_surreal',
	colours = {HEX('baf5ca'), HEX('21001b'), HEX('d1c436')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_asc_tarot',
	colours = {HEX('fc8403'), HEX('ff7300')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_asc_yotta',
	colours = {HEX('5900ff'), HEX('481182')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_big_operator',
	colours = {
	HEX('ff0000'), 
	HEX('000000'), 
	HEX('ff7300'), 
	HEX('000000'), 
	HEX('fff700'), 
	HEX('000000'), 
	HEX('00ff00'), 
	HEX('000000'), 
	HEX('0000ff'), 
	HEX('000000'), 
	HEX('7300ff'), 
	HEX('000000'), 
	HEX('ff00e1'), 
	HEX('000000'), 
	},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_huge_operator',
	colours = {
	HEX('ff0000'), 
	HEX('ff7300'), 
	HEX('fff700'), 
	HEX('00ff00'), 
	HEX('0000ff'), 
	HEX('7300ff'), 
	HEX('ff00e1'), 
	},
	cycle = 1.75,
	interpolation = 'linear'
}

SMODS.Gradient {
	key = 'col_tran11',
	colours = {
	HEX('ff0000'), 
	HEX('ff7300'), 
	HEX('fff700'), 
	HEX('00ff00'), 
	HEX('0000ff'), 
	HEX('7300ff'), 
	HEX('ff00e1'), 
	},
	cycle = 0.1,
	interpolation = 'linear'
}

SMODS.Gradient {
	key = 'col_may_wip_badge',
	colours = {HEX('000000'), HEX('ffb700')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_instability',
	colours = {HEX('7357ff'), HEX('537044'), HEX('96e1ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_e_omega',
	colours = {HEX('000000'), HEX('5c0000')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_e_otherworldly',
	colours = {HEX('020629'), HEX('96e1ff'), HEX('e1ffc2')},
	interpolation = 'trig'
}

may.C = {}
may.C.score = HEX('f024ff')

local vanf_lc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		vanf_lc()
	end
	G.ARGS.LOC_COLOURS.may_score = may.C.score
	G.ARGS.LOC_COLOURS.may_instability = SMODS.Gradients.may_col_instability
    -- more hand level colors
    G.C.HAND_LEVELS[8] = G.C.PALE_GREEN
    G.C.HAND_LEVELS[9] = G.C.VOUCHER
    G.C.HAND_LEVELS[10] = G.C.BOOSTER
    G.C.HAND_LEVELS[11] = G.C.CHANCE
    G.C.HAND_LEVELS[12] = G.C.ETERNAL
    G.C.HAND_LEVELS[13] = G.C.PERISHABLE
    G.C.HAND_LEVELS[14] = G.C.GOLD
    G.C.HAND_LEVELS[15] = G.C.CHIPS
    G.C.HAND_LEVELS[16] = G.C.EDITION
    G.C.HAND_LEVELS[17] = G.C.DARK_EDITION
    G.C.HAND_LEVELS[18] = SMODS.Gradients.may_col_interdimensional
    G.C.HAND_LEVELS[19] = SMODS.Gradients.may_col_ethereal
	G.C.HAND_LEVELS[20] = SMODS.Gradients.may_col_surreal 
    G.C.HAND_LEVELS[21] = SMODS.Gradients.may_col_hyperascendant
    G.C.MAX_HAND_LEVEL_COLOR = #G.C.HAND_LEVELS
	return vanf_lc(_c, _default) 
end