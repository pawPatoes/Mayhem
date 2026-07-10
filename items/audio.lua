-- SFX

-- key, path, volume
may.sounds = {
	{'e_amber', 'edition/e_amber.ogg'}, 
	{'e_nostalgic', 'edition/e_nostalgic.ogg'}, 
	{'e_techno', 'edition/e_techno.ogg'},
	{'e_antimatter', 'edition/e_antimatter.ogg'},
	{'e_hypnotic', 'edition/e_hypnotic.ogg'},
	{'e_omega', 'edition/e_omega.ogg'},
	{'e_reverse', 'edition/e_reverse.ogg'},
	{'e_wavy', 'edition/e_wavy.ogg'},
	{'e_misprint', 'edition/e_misprint.ogg'},
	{'e_otherworldly', 'edition/e_otherworldly.ogg'},
	{'e_shimmering', 'edition/e_shimmering.ogg'},
	{'e_cosmic', 'edition/e_cosmic.ogg'},
	{'e_print', 'edition/e_print.ogg'},
	{'e_goldfoil', 'edition/e_goldfoil.ogg'},
	{'e_radioactive', 'edition/e_radioactive.ogg'},
	{'e_bitcrush', 'edition/e_bitcrush.ogg'},
	{'e_neon', 'edition/e_neon.ogg'},
	{'e_vignette', 'edition/e_vignette.ogg'},
	{'e_laminated', 'edition/e_laminated.ogg'},
	{'e_inverted', 'edition/e_inverted.ogg'},
	{'e_alloy', 'edition/e_alloy.ogg'},
	{'e_dichromatic', 'edition/e_dichromatic.ogg'},
	{'e_magenta', 'edition/e_magenta.ogg'},
	{'e_light', 'edition/e_light.ogg'},
	{'e_metallic', 'edition/e_metallic.ogg'},
	{'e_twilight', 'edition/e_twilight.ogg'},
	
	{'weezer', 'joker/weezer.ogg'},
	{'st_hohoho', 'joker/santa/hohoho.ogg'},
	{'st_bells', 'joker/santa/santa_bells.ogg'},
	{'doggo_spawn', 'joker/doggo/spawn.ogg'},
	{'doggo_success1', 'joker/doggo/success1.ogg'},
	{'doggo_success2', 'joker/doggo/success2.ogg'},
	{'doggo_success3', 'joker/doggo/success3.ogg'},
	{'ah_yes_the_store', 'joker/ah_yes_the_store.ogg'}, 
	{'cake_spawn', 'joker/anniversary_cake/spawn.ogg'},
	{'cake_activate', 'joker/anniversary_cake/activate.ogg'},
	{'cake_destroy', 'joker/anniversary_cake/destroy.ogg'},
	
	{'omniversal_catalyst', 'joker/omniversal_catalyst/spawn.ogg'}, 
	{'instability_increase', 'joker/omniversal_catalyst/instability_increase.ogg'}, 
	{'instability_threshold', 'joker/omniversal_catalyst/instability_threshold.ogg'}, 
	
	{'yotta', 'consumable/yotta.ogg'},
	{'bundle', 'consumable/bundle.ogg'},
	{'upside_down', 'consumable/upside_down.ogg'},
	{'boost', 'boost.ogg'},
	{'rare_planet', 'consumable/planet/rare_planet.ogg'},
	{'legendary_planet', 'consumable/planet/legendary_planet.ogg'},
	{'mythic_planet', 'consumable/planet/mythic_planet.ogg'},
	
	{'increase_operator', 'increase_operator.ogg'},
	{'decrease_operator', 'decrease_operator.ogg'},
	{'error', 'error.ogg'},
	{'ascended_yotta', 'consumable/ascended_yotta.ogg'},
	{'error_seal', 'error_seal.ogg'},
	{'hyperoperator', 'hyperoperator.ogg'},
	{'lvl_multchips', 'lvl_multchips.ogg'},
	{'blind_size', 'blind_size.ogg'},
	{'nominal_chips', 'nominal_chips.ogg'},
	{'eq_level', 'level/eq_level.ogg'},
	{'permabonus', 'permabonus.ogg', 0.6},
	{'event', 'event.ogg', 1.5},
	{'forcetrigger', 'forcetrigger.ogg'},
	{'demitrigger', 'demitrigger.ogg'},
	{'positive', 'positive.ogg'},
	{'thunder1', 'thunder1.ogg'},
	{'thunder2', 'thunder2.ogg'}, 
	
	{'big_score1', 'big_score1.ogg'}, 
	{'big_score2', 'big_score2.ogg'},
	{'big_score3', 'big_score3.ogg'},
	
	{'hyper_selection_limit', 'hyper_selection_limit.ogg'},
	{'hyper_joker_slots', 'hyper_joker_slots.ogg'},
	{'hyper_consumable_slots', 'hyper_consumable_slots.ogg'},
	
	{'c_ascended', 'consumable/ascended.ogg'},
	
	{'intro_pad', 'intro_pad.ogg'}, 
	
	{'mythic_joker', 'rarity/mythic_joker.ogg'},
	{'ethereal_joker', 'rarity/ethereal_joker.ogg'},
	{'opalescent_joker', 'rarity/opalescent_joker.ogg'},
	{'prismatic_joker', 'rarity/prismatic_joker.ogg'},
	{'demiurgic_joker', 'rarity/demiurgic_joker.ogg'},
	{'transcendent_joker', 'rarity/transcendent_joker.ogg'},
	
	{'tran0', 'tran/tran0.ogg'},
	{'tran1', may.conf.LegacyTr1 and 'tran/tran1_old.ogg' or 'tran/tran1.ogg'},
	{'tran2', 'tran/tran2.ogg'},
	{'tran3', 'tran/tran3.ogg'},
	{'tran4', 'tran/tran4.ogg'},
	{'tran5', 'tran/tran5.ogg'},
	{'tran6', 'tran/tran6.ogg'},
	{'tran7', 'tran/tran7.ogg'},
	{'tran8', 'tran/tran8.ogg'},
	
	{'eqscore', 'operation/EqualsScore.ogg'},
	{'addscore', 'operation/AdditiveScore.ogg'},
	{'xscore', 'operation/MultiplicativeScore.ogg'},
	{'escore', 'operation/ExponentialScore.ogg'},
	{'eescore', 'operation/TetrationalScore.ogg'},
	{'eeescore', 'operation/PentationalScore.ogg'},
	{'hexscore', 'operation/HexationalScore.ogg'},
	
	{'eboth', 'operation/ExponentialMultChips.ogg'},
	{'eeboth', 'operation/TetrationalMultChips.ogg'},
	{'eeeboth', 'operation/PentationalMultChips.ogg'},
	{'hexboth', 'operation/HexationalMultChips.ogg'},
	
	{'x_level', 'level/x_level.ogg'},
	{'e_level', 'level/e_level.ogg'},
	{'ee_level', 'level/ee_level.ogg'},
	{'eee_level', 'level/eee_level.ogg'},
	{'hex_level', 'level/hex_level.ogg'},
	
	{'mdcmult', 'operation/ModocativeMult.ogg'},
	{'mdcchip', 'operation/ModocativeChips.ogg'},
	
	{'bigmoney', 'hugemoney.ogg'},
	
	{'eqmult', 'operation/EqualsMult.ogg'},
	{'hexmult', 'operation/HexationalMult.ogg'},
	{'hepmult', may.conf.intense_hyperoperations and 'operation/HeptationalMult.ogg' or 'operation/tame/HeptationalMult.ogg'},
	{'octmult', may.conf.intense_hyperoperations and 'operation/OctationalMult.ogg' or 'operation/tame/OctationalMult.ogg'},
	{'ennmult', may.conf.intense_hyperoperations and 'operation/EnneationalMult.ogg' or 'operation/tame/EnneationalMult.ogg'},
	{'decmult', may.conf.intense_hyperoperations and 'operation/DecationalMult.ogg' or 'operation/tame/DecationalMult.ogg'},
	{'undmult', may.conf.intense_hyperoperations and 'operation/UndecationalMult.ogg' or 'operation/tame/UndecationalMult.ogg'},
	{'doemult', may.conf.intense_hyperoperations and 'operation/DoedecationalMult.ogg' or 'operation/tame/DoedecationalMult.ogg'},
	{'tremult', may.conf.intense_hyperoperations and 'operation/TredecationalMult.ogg' or 'operation/tame/TredecationalMult.ogg'},
	
	{'eqchip', 'operation/EqualsChips.ogg'},
	{'hexchip', 'operation/HexationalChips.ogg'},
	{'hepchip', may.conf.intense_hyperoperations and 'operation/HeptationalChips.ogg' or 'operation/tame/HeptationalChips.ogg'},
	{'octchip', may.conf.intense_hyperoperations and 'operation/OctationalChips.ogg' or 'operation/tame/OctationalChips.ogg'},
	{'ennchip', may.conf.intense_hyperoperations and 'operation/EnneationalChips.ogg' or 'operation/tame/EnneationalChips.ogg'},
	{'decchip', may.conf.intense_hyperoperations and 'operation/DecationalChips.ogg' or 'operation/tame/DecationalChips.ogg'},
	{'undchip', may.conf.intense_hyperoperations and 'operation/UndecationalChips.ogg' or 'operation/tame/UndecationalChips.ogg'},
	{'doechip', may.conf.intense_hyperoperations and 'operation/DoedecationalChips.ogg' or 'operation/tame/DoedecationalChips.ogg'},
	{'trechip', may.conf.intense_hyperoperations and 'operation/TredecationalChips.ogg' or 'operation/tame/TredecationalChips.ogg'},
}

for k, v in pairs(may.sounds) do 
	SMODS.Sound({
		key = v[1],
		path = v[2],
		volume = v[3] or 1
	})
end

-- Music

SMODS.Sound({
	key = "music_santa",
	path = "music/music_santa.ogg",
	pitch = 1,
	volume = 0.55,
	sync = true,
	select_music_track = function()
		return (#SMODS.find_card('j_may_santa') > 0  and may.conf.Santamusic and (may.transcendence or 0) < 9) and 100.2 or false
	end,
})

SMODS.Sound({
	key = "music_poker",
	path = "music/music_poker.ogg",
	pitch = 1,
    volume = 0.3,
	sync = false,
	select_music_track = function()
		return (#SMODS.find_card('j_may_poker') > 0  and may.conf.Pokermusic and (may.transcendence or 0) < 9) and 100.2 or false
	end,
})

SMODS.Sound({
	key = "music_party",
	path = "music/music_party.ogg",
	volume = .9,
	pitch = 1,
	sync = true,
	select_music_track = function()
		if G.GAME and not G.GAME.blind then
			return ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 8) and 0 or false
		end 
		if may.conf.party_music_everywhere then
			for k, v in pairs((G.jokers or {cards = {}}).cards) do 
				if v:may_is_fusion() and v:gc().rarity ~= 'may_hyperascendant' and v:gc().rarity ~= 'may_surreal' then 
					return (may.conf.Partymusic and (may.transcendence or 0) < 9 ) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 8) and 0 or false
				end 
			end 
		else 
		    return ((#SMODS.find_card('j_may_party_time') > 0 or #SMODS.find_card('j_may_aurora_rave') > 0 or #SMODS.find_card('j_may_planet_ibiza') > 0 ) and not ((#SMODS.find_card('j_may_rondo_discoteca') > 0) and may.conf.Ibizamusic) and may.conf.Partymusic and (may.transcendence or 0) < 9 ) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 8) and 100.6 or false
		end
	end,
	volume = 0.7
})

SMODS.Sound({
	key = "music_rondo_discoteca",
	path = "music/music_rondo_discoteca.ogg",
	pitch = 1,
    volume = 1.1,
	sync = true,
	select_music_track = function()
		return ((#SMODS.find_card('j_may_rondo_discoteca') > 0) and may.conf.Ibizamusic and (may.transcendence or 0) < 9) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 9) and 100.7
	end,
})

SMODS.Sound({
	key = "music_mayhem",
	path = "music/music_mayhem.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (not may.conf.menu_music == 9 or may.conf.menu_music == 2 or may.conf.menu_music == 1) and (G.GAME and not G.GAME.blind) and 0
	end,
})

SMODS.Sound({
	key = "music_eternum",
	path = "music/music_eternum.ogg",
	pitch = 1,
	volume = .85,
	sync = true,
	select_music_track = function()
		return may.conf.menu_music == 3 and (G.GAME and not G.GAME.blind) and 0
	end,
})

SMODS.Sound({
	key = "music_opalescent",
	path = "music/music_opalescent.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		local found_surreal
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_surreal' then
					found_surreal = true
				end
			end
		end
		return (found_surreal and (may.conf.Surrealmusic and (may.transcendence or 0) < 9)) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 10) and 100.5
	end
})

SMODS.Sound({
	key = "music_opalescent_shop",
	path = "music/music_opalescent_shop.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		local found_surreal
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_opalescent' then
					found_surreal = true
				end
			end
		end
		return (found_surreal and (may.conf.Surrealmusic and (may.transcendence or 0) < 9)) and G.shop and not may.booster() or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 17) and 100.5
	end
})

SMODS.Sound({
	key = "music_transcendent",
	path = "music/music_transcendent.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		local found_hyperascendant
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_transcendent' then
					found_hyperascendant = true
				end
			end
		end
		return (found_hyperascendant and (may.conf.Hyperascendantmusic and (may.transcendence or 0) < 9) and G.STATE ~= G.STATES.SHOP and not may.booster() and not G.shop) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 6) and 100.6
	end
})

SMODS.Sound({
	key = "music_transcendent_shop",
	path = "music/music_transcendent_shop.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		local found_hyperascendant
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_transcendent' then
					found_hyperascendant = true
				end
			end
		end
		return (found_hyperascendant and (may.conf.Hyperascendantshopmusic and (may.transcendence or 0) < 9)) and G.shop and not may.booster() or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 16) and 100.6
	end
})

SMODS.Sound({
	key = "music_fusion",
	path = "music/music_fusion.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		if G.GAME and not G.GAME.blind then
			return ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 13) and 0 or false
		end
		if G.GAME and G.GAME.blind and G.GAME.blind.config.blind.tainted and may.conf.Taintedmusic then
			return false
		end
		local found_surreal
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_surreal' then
					found_surreal = true
				end
			end
		end
		local found_hyperascendant
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_hyperascendant' then
					found_hyperascendant = true
				end
			end
		end
		if found_surreal or found_hyperascendant or ((#SMODS.find_card('j_may_party_time') > 0 or #SMODS.find_card('j_may_aurora_rave') > 0 or #SMODS.find_card('j_may_planet_ibiza') > 0 ) and may.conf.Partymusic) then
			return false
		end
		for k, v in pairs((G.jokers or {cards = {}}).cards) do 
			if v:may_is_fusion() and v:gc().rarity ~= 'may_hyperascendant' and v:gc().rarity ~= 'may_surreal' then 
				return (may.conf.Fusionmusic and (may.transcendence or 0) < 9 ) and (not may.conf.party_music_everywhere) and G.STATE ~= G.STATES.SHOP and not may.booster() and not G.shop and 100.4
			end 
		end 
	end,
})

SMODS.Sound({
	key = "music_fusion_shop",
	path = "music/music_fusion_shop.ogg",
	pitch = 1,
	volume = 0.45,
	sync = true,
	select_music_track = function()
		if G.GAME and not G.GAME.blind then
			return ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 15) and 0 or false
		end
		if G.GAME and G.GAME.blind and G.GAME.blind.config.blind.tainted and may.conf.Taintedmusic then
			return false
		end
		local found_surreal
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_surreal' then
					found_surreal = true
				end
			end
		end
		local found_hyperascendant
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_hyperascendant' then
					found_hyperascendant = true
				end
			end
		end
		if found_surreal or found_hyperascendant or ((#SMODS.find_card('j_may_party_time') > 0 or #SMODS.find_card('j_may_aurora_rave') > 0 or #SMODS.find_card('j_may_planet_ibiza') > 0 ) and may.conf.Partymusic) then
			return false
		end
		for k, v in pairs((G.jokers or {cards = {}}).cards) do 
			if v:may_is_fusion() and v:gc().rarity ~= 'may_hyperascendant' and v:gc().rarity ~= 'may_surreal' then 
				return (may.conf.Fusionshopmusic and (may.transcendence or 0) < 9 ) and (not may.conf.party_music_everywhere) and G.shop and not may.booster() and 100.4 or false
			end 
		end 
	end,
})


SMODS.Sound({
	key = "music_modifier",
	path = "music/music_modifier.ogg",
	pitch = 1,
	volume = 1.1,
	sync = true,
	select_music_track = function()
		return (G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == "may_modifiercard" and may.conf.Editionmusic) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 7) and 0
	end
})

SMODS.Sound({
	key = "music_retrocard",
	path = "music/music_retro.ogg",
	pitch = 1,
	volume = 0.9,
	sync = true,
	select_music_track = function()
		return (G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == "retrocards" and may.conf.Editionmusic) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 11) and 0
	end
})

SMODS.Sound({
	key = "music_fusion_pack",
	path = "music/music_fusion_pack.ogg",
	pitch = 1,
	volume = 0.9,
	sync = true,
	select_music_track = function()
		return (G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == "fusion" and may.conf.Fusionpackmusic) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 14) and 0
	end
})

SMODS.Sound({
	key = "music_yotta",
	path = "music/music_yotta.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		local found_yotta = false
		if G.pack_cards and G.pack_cards.cards then
			for k, v in pairs(G.pack_cards.cards) do
				if v:gc().set == 'yottacards' then
					found_yotta = true
				end
			end
		end
		return (found_yotta and may.conf.Yottamusic) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 4) and 0
	end
})

SMODS.Sound({
	key = "music_ultrablind",
	path = "music/music_ultrablind.ogg",
	pitch = 1,
	volume = 1.1,
	sync = true,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and G.GAME.blind.config.blind.ultra and may.conf.Ultrablindmusic) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 5) and (may.transcendence or 0) < 9 and 100.1
	end
})

SMODS.Sound({
	key = "music_tainted",
	path = "music/music_tainted.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return (G.GAME and G.GAME.blind and G.GAME.blind.config.blind.tainted and may.conf.Taintedmusic and (may.transcendence or 0) < 9) or ((G.GAME and not G.GAME.blind) and may.conf.menu_music == 12) and 100.1
	end
})

SMODS.Sound({
	key = "music_tran9",
	path = "tran/tran9.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 9 and may.conf.TrAudio ~= 0
	end,
	volume = 2
})

SMODS.Sound({
	key = "music_tran10",
	path = "tran/tran10.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 10 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran11",
	path = "tran/tran11.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 11 and may.conf.TrAudio ~= 0
	end,
	volume = 2
})

SMODS.Sound({
	key = "music_tran12",
	path = "tran/tran12.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 12 and may.conf.TrAudio ~= 0
	end,
	volume = 3
})

SMODS.Sound({
	key = "music_tran13",
	path = "tran/tran13.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 13 and may.conf.TrAudio ~= 0
	end,
	volume = 3
})

SMODS.Sound({
	key = "music_tran14",
	path = "tran/tran14.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 14 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran15",
	path = "tran/tran15.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 15 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran16",
	path = "tran/tran16.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 16 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})

SMODS.Sound({
	key = "music_tran17",
	path = "tran/tran17.ogg",
	pitch = 1,
	sync = true,
	select_music_track = function()
		return G.ARGS.score_intensity and G.ARGS.score_intensity.transcendence == 17 and may.conf.TrAudio ~= 0
	end,
	volume = 4
})