-- Custom Colors

G.C.MAY_RED = HEX('8c0303')

G.C.DARK_MAY_RED = HEX('a14343')

G.C.MAY_TINT_PROGRESS = HEX('000000')

may.C = {}
may.C.score = HEX('f024ff')
may.C.brown = HEX('946d54')
may.C.pure_black = HEX('000000')

SMODS.Gradient {
	key = 'col_mayhem_gradient',
	colours = {HEX('8c0303ff'), HEX('a14343ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_mayhem_gradient_dark1',
	colours = {mix_colours(HEX('8c0303ff'), HEX('000000'), 0.5), mix_colours(HEX('a14343ff'), HEX('000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_mayhem_gradient_dark2',
	colours = {mix_colours(HEX('8c0303ff'), HEX('00000000'), 0.5), mix_colours(HEX('a14343ff'), HEX('00000000'), 0.5)},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_transcendent',
	colours = {HEX('1d1649'), HEX('311649'), HEX('720c1f')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_demiurgic',
	colours = {HEX('6f00ff'), HEX('ff00fb'), HEX('182052'), HEX('00e1ff')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_prismatic',
	colours = {HEX('34eb9b'), HEX('ffe600'), HEX('2c2054')},
	interpolation = 'trig'
}

SMODS.Gradient {
	key = 'col_opalescent',
	colours = {HEX('a07ce2'), HEX('7c8ce2'), HEX('31173a')},
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
	key = 'col_huge_operator_alt',
	colours = {
		HEX('ff7300'), 
		HEX('fff700'), 
		HEX('00ff00'), 
		HEX('7300ff'), 
		HEX('ff00e1'), 
	},
	cycle = 10,
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

-- Hyperoperator formatting 

SMODS.Gradient {
	key = 'e_chips',
	colours = {G.C.CHIPS, mix_colours(G.C.CHIPS, HEX('ffffffff'), 0.6)},
	interpolation = 'trig', 
	cycle = 4
}

SMODS.Gradient {
	key = 'e_mult',
	colours = {G.C.MULT, mix_colours(G.C.MULT, HEX('ffffffff'), 0.6)},
	interpolation = 'trig',
	cycle = 4
}

SMODS.Gradient {
	key = 'e_chipsmult',
	colours = {G.C.PURPLE, mix_colours(G.C.PURPLE, HEX('ffffffff'), 0.6)},
	interpolation = 'trig', 
	cycle = 4
}

SMODS.Gradient {
	key = 'ee_chips',
	colours = {G.C.CHIPS, mix_colours(G.C.CHIPS, HEX('000000ff'), 0.65)},
	interpolation = 'trig', 
	cycle = 3.5
}

SMODS.Gradient {
	key = 'ee_mult',
	colours = {G.C.MULT, mix_colours(G.C.MULT, HEX('000000ff'), 0.5)},
	interpolation = 'trig',
	cycle = 3.5
}

SMODS.Gradient {
	key = 'ee_chipsmult',
	colours = {G.C.PURPLE, mix_colours(G.C.PURPLE, HEX('000000ff'), 0.65)},
	interpolation = 'trig', 
	cycle = 3.5
}

SMODS.Gradient {
	key = 'ee_chips_bg',
	colours = {HEX('000000'), mix_colours(G.C.CHIPS, HEX('000000ff'), 0.3)},
	interpolation = 'trig', 
	cycle = 8
}

SMODS.Gradient {
	key = 'ee_mult_bg',
	colours = {HEX('000000'), mix_colours(G.C.MULT, HEX('000000ff'), 0.3)},
	interpolation = 'trig', 
	cycle = 8
}

SMODS.Gradient {
	key = 'ee_chipsmult_bg',
	colours = {HEX('000000'), mix_colours(G.C.PURPLE, HEX('000000ff'), 0.3)},
	interpolation = 'trig', 
	cycle = 8
}

SMODS.Gradient {
	key = 'eee_chips',
	colours = {mix_colours(G.C.CHIPS, HEX('ffffffff'), 0.7), mix_colours(G.C.CHIPS, SMODS.Gradients.may_col_instability, 0.3)},
	interpolation = 'trig', 
	cycle = 3
}

SMODS.Gradient {
	key = 'eee_mult',
	colours = {mix_colours(G.C.MULT, HEX('ffffffff'), 0.7), mix_colours(G.C.MULT, SMODS.Gradients.may_col_instability, 0.3)},
	interpolation = 'trig', 
	cycle = 3
}

SMODS.Gradient {
	key = 'eee_chipsmult',
	colours = {mix_colours(G.C.PURPLE, HEX('ffffffff'), 0.7), mix_colours(G.C.PURPLE, SMODS.Gradients.may_col_instability, 0.3)},
	interpolation = 'trig', 
	cycle = 3
}

SMODS.Gradient {
	key = 'eee_chips_bg',
	colours = {mix_colours(G.C.CHIPS, HEX('000000ff'), 0.5), HEX('000000')},
	interpolation = 'trig', 
	cycle = 5
}

SMODS.Gradient {
	key = 'eee_mult_bg',
	colours = {mix_colours(G.C.MULT, HEX('000000ff'), 0.5), HEX('000000')},
	interpolation = 'trig', 
	cycle = 5
}

SMODS.Gradient {
	key = 'eee_chipsmult_bg',
	colours = {mix_colours(G.C.PURPLE, HEX('000000ff'), 0.5), HEX('000000')},
	interpolation = 'trig', 
	cycle = 5
}

SMODS.Gradient {
	key = 'hyper_chips',
	colours = {mix_colours(G.C.CHIPS, HEX('000000ff'), 0.9), HEX('000000')},
	interpolation = 'trig', 
	cycle = 4
}

SMODS.Gradient {
	key = 'hyper_mult',
	colours = {mix_colours(G.C.MULT, HEX('000000ff'), 0.9), HEX('000000')},
	interpolation = 'trig', 
	cycle = 4
}

SMODS.Gradient {
	key = 'hyper_chipsmult',
	colours = {mix_colours(G.C.PURPLE, HEX('000000ff'), 0.9), HEX('000000')},
	interpolation = 'trig', 
	cycle = 4
}

local vanf_lc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		vanf_lc()
	end
	G.ARGS.LOC_COLOURS.may_score = may.C.score
	G.ARGS.LOC_COLOURS.may_brown = may.C.brown
	G.ARGS.LOC_COLOURS.may_instability = SMODS.Gradients.may_col_instability
	G.ARGS.LOC_COLOURS.may_pure_black = may.C.pure_black
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
    G.C.HAND_LEVELS[18] = SMODS.Gradients.may_col_prismatic
    G.C.HAND_LEVELS[19] = SMODS.Gradients.may_col_demiurgic
	G.C.HAND_LEVELS[20] = SMODS.Gradients.may_col_opalescent
    G.C.HAND_LEVELS[21] = SMODS.Gradients.may_col_instability
	G.C.HAND_LEVELS[22] = SMODS.Gradients.may_col_huge_operator
    G.C.MAX_HAND_LEVEL_COLOR = #G.C.HAND_LEVELS
	return vanf_lc(_c, _default) 
end