-- Attributes

-- key, default objects, aliases
may.attributes = {
	{'hand_specific', {
		'c_mercury', 'c_venus', 'c_earth', 'c_mars', 
		'c_jupiter', 'c_saturn', 'c_uranus', 'c_neptune', 
		'c_pluto', 'c_ceres', 'c_eris', 'c_planet_x', 
		'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Sydan', 'c_cry_Lapio', 
		'c_cry_Kaikki', 'c_cry_perkele', 'c_cry_voxel'
	}, nil}, 
	
	{'wheel', nil, nil}, 
	{'stone', {
		'j_marble', 'j_stone'
	}, nil}, 
	{'sauce', nil, nil}, 
	{'danny_h', nil, nil}, 
	
	{'spacecraft', nil, nil},
	{'spectral_planet', nil, nil},
	{'ring_system', nil, nil}, 
	{'jovian_moon', nil, nil}, 
	{'saturnian_moon', nil, nil}, 
	
	{'modifier_card', nil, nil}, 
	{'retro', nil, nil}, 
	
	{'voucher_bundle', nil, nil},
	
	{'emult', nil, nil}, 
	{'echips', nil, nil}, 
	{'eemult', nil, nil}, 
	{'eechips', nil, nil}, 
	{'eeemult', nil, nil}, 
	{'eeechips', nil, nil},
	{'hypermult', nil, nil}, 
	{'hyperchips', nil, nil},
	
	{'eblindsize', nil, nil}, 
	{'eeblindsize', nil, nil},
	{'eeeblindsize', nil, nil}, 
	{'hyperblindsize', nil, nil},
	
	{'base_fusable', nil, nil}, 
	{'fusion', nil, nil}, 
	{'fusable', nil, nil}, 
}

for k, v in pairs(may.attributes) do
	SMODS.Attribute {
		key = v[1],
		keys = v[2] or {},
		alias = v[3] or {}
	}
end