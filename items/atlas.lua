-- Atlases

-- key, path, px, py, animated, frames
may.atlases = {
	{"modicon", "may_icon.png", 32, 32},
	
	{"ccd_thing", "ccd_thing.png", 71, 95}, 
	
	{"tag", "tag.png", 34, 34},
	
	{"stake", "stake.png", 29, 29},
	
	{"placeholder", "placeholder.png", 71, 95},
	{"placeholder_vouchert4", "placeholder_vouchert4.png", 71, 95}, 
	{"placeholder_voucher", "placeholder_voucher.png", 71, 95}, 
	{"placeholder_booster", "placeholder_booster.png", 71, 95}, 
	{"ascyotta_placeholder", "ascyotta_placeholder.png", 71, 95}, 
	
	{"joker1", "joker1.png", 71, 95}, 
	{"joker2", "joker2.png", 71, 95}, 
	
	{"display", "display.png", 49, 49}, 
	
	{"tarot", "tarot.png", 71, 95}, 
	{"planet", "planet.png", 71, 95}, 
	{"jovianmoon", "jovianmoon.png", 65, 95}, 
	{"saturnianmoon", "saturnianmoon.png", 71, 95}, 
	{"spectral", "spectral.png", 71, 95},  
	{"spectral_planet", "spectral_planet.png", 71, 95}, 
	{"yotta", "yotta.png", 71, 95},  
	{"present", "present.png", 71, 71},  
	{"retro", "retro.png", 71, 71},   
	{"modifier", "modifier.png", 71, 95}, 
	{"upside_down", "upside_down.png", 71, 95}, 
	{"asc_tarot", "asc_tarot.png", 65, 95}, 
	{"ascyotta", "ascendedyotta.png", 71, 95},  
	
	{"voucher", "voucher.png", 71, 95}, 
	{"misc_voucher", "misc_voucher.png", 71, 95}, 
	{"voucher_bundle", "voucher_bundle.png", 71, 95}, 
	
	{"blind", "blind.png", 34, 34, true, 21},  
	{"ultrablind", "ultrablind.png", 34, 34, true, 21}, 
	{"taintedblind", "taintedblind.png", 34, 34, true, 21}, 
	
	{"booster", "booster.png", 71, 95}, 
	
	{"enhancement", "enhancement.png", 71, 95}, 
	{"seal", "seal.png", 71, 95}, 
	
	{"achievement", "achievement.png", 63, 63}, 
	
	{"deck", "deck.png", 71, 95}, 
}

for k, v in pairs(may.atlases) do
	SMODS.Atlas {
		key = v[1],
		path = v[2],
		px = v[3],
		py = v[4],
		atlas_table = v[5] and 'ANIMATION_ATLAS' or nil,
		frames = v[5] and (v[6] or 21) or nil,
	}
end