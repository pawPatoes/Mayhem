-- Transcendence effects

-- Huge numbers required for Transcendence
-- They're constant for performance reasons
may.tr_constants = {
	goog = to_big(1e100),
	googchime = to_big(to_big(1e100):arrow(1, 10)),
	tr13 = to_big(to_big(1e100):arrow(1, 10)):arrow(5000, to_big(to_big(1e100):arrow(1, 10))),
	tr14 = to_big(to_big(1e100):arrow(1, 10)):arrow(10000, to_big(to_big(1e100):arrow(1, 10))),
	tr15 = to_big(to_big(1e100):arrow(1, 10)):arrow(50000, to_big(to_big(1e100):arrow(1, 10))),
	tr16 = to_big(to_big(1e100):arrow(1, 10)):arrow(100000, to_big(to_big(1e100):arrow(1, 10))),
	tr17 = to_big(to_big(1e100):arrow(1, 10)):arrow(500000, to_big(to_big(1e100):arrow(1, 10))),
	tr18 = to_big(to_big(1e100):arrow(1, 10)):arrow(1000000, to_big(to_big(1e100):arrow(1, 10))),
	-- Score display thresholds
	ui_t1 = Big:create(1e100),
	ui_t2 = Big:create(1e308),
	ui_t3 = Big:create(1e308) ^ 2,
	ui_t4 = Big:create(1e308):arrow(2, 2),
	ui_t5 = Big:create(1e308):arrow(3, 3),
	ui_t6 = Big:create(1e308):arrow(4, 3),
	ui_t7 = Big:create(1e308):arrow(5, 3),
	ui_t8 = Big:create(1e308):arrow(6, 3),
	ui_t9 = Big:create(1e308):arrow(7, 3),
	ui_t10 = Big:create(1e308):arrow(8, 3),
	ui_t11 = Big:create(1e308):arrow(9, 3),
	ui_t12 = Big:create(1e308):arrow(10, 3),
	ui_t13 = Big:create(1e308):arrow(100, 10),
	ui_t14 = Big:create(1e308):arrow(1000, 2),
	ui_t15 = Big:create(1e308):arrow(2000, 2),
	ui_t16 = Big:create(1e308):arrow(3000, 2),
	ui_t17 = Big:create(1e308):arrow(4000, 2),
	-- Chip total thresholds
	chip_t1 = Big:create(1e100):arrow(1, 100),
	chip_t2 = Big:create(1e100):arrow(2, 100),
	chip_t3 = Big:create(1e100):arrow(3, 100),
	chip_t4 = Big:create(1e100):arrow(4, 100),
	chip_t5 = Big:create(1e100):arrow(5, 100),
	chip_t6 = Big:create(1e100):arrow(6, 100),
	chip_t7 = Big:create(1e100):arrow(7, 100),
	chip_t8 = Big:create(1e100):arrow(8, 100),
	chip_t9 = Big:create(1e100):arrow(10, 100),
	chip_t10 = Big:create(1e100):arrow(30, 100),
	chip_t11 = Big:create(1e100):arrow(150, 100),
	chip_t12 = Big:create(1e100):arrow(800, 100),
	chip_t13 = Big:create(1e100):arrow(5000, 100),
}

may.tr_colors = {
    chips = HEX("009dff"),
    mult = HEX('FE5F55'),
    money = HEX('f3b958'),
    important = HEX('ff9a00'),
    gold = HEX('eac058'),
    orange = HEX('fda200'),
    bg_dark = HEX("7A9E9F"),
    purple = HEX('8867a5'),
    tr11 = HEX('241345'),
    tr12 = HEX('000000'),
    tr13 = HEX('e9a8ff'),
    tr16 = HEX('110000'),
    white = HEX('ffffff'),
    lavender = HEX('edc8fa'),
}

function may.get_transcendence_color(int)
	if int > 0 then
		if int >= 13 and math.random(30) == 1 and not may.conf.epileptic then
			return int > 13 and HEX('ffffff') or HEX('edc8fa')
		end
		if int <= 10 then
			return G.C.DARK_EDITION
		elseif int == 11 then
			return HEX('241345') --SMODS.Gradients.may_col_tran11
		elseif int == 12 or int == 14 or int == 15 then
			return HEX('000000')
		elseif int == 13 then
			return HEX('e9a8ff')
		elseif int >= 16 then
			return HEX('110000')
		end
	end
end

function may.get_transcendence(immediate, multchips)
	if immediate then 
		local score 
		local reqs = to_big(G.ARGS.score_intensity.required_score+1)
		if multchips and (type(multchips[1]) == 'number' or type(multchips[1]) == 'table') and (type(multchips[2]) == 'number' or type(multchips[2]) == 'table') then 
			score = to_big(G.GAME.current_scoring_calculation:func(multchips[1], multchips[2]))
		elseif (type(SMODS.get_scoring_parameter('chips', true)) == 'number' or type(SMODS.get_scoring_parameter('chips', true)) == 'table') and (type(SMODS.get_scoring_parameter('mult', true)) == 'number' or type(SMODS.get_scoring_parameter('mult', true)) == 'table') then
			score = G.ARGS.score_intensity.true_score
		else
			score = to_big(0)
		end 
		if score == to_big(0) or reqs == to_big(0) then 
			return 0
		end
		if to_big(score):gte(reqs*1e100) then 
			return 1
		elseif to_big(score):gte(reqs^1e100) then 
			return 2
		elseif to_big(score):gte(reqs:arrow(2, may.tr_constants.goog)) then 
			return 3
		elseif to_big(score):gte(reqs:arrow(3, may.tr_constants.goog)) then 
			return 4
		elseif to_big(score):gte(reqs:arrow(4, may.tr_constants.goog)) then 
			return 5
		elseif to_big(score):gte(reqs:arrow(5, may.tr_constants.goog)) then 
			return 6
		elseif to_big(score):gte(reqs:arrow(6, may.tr_constants.goog)) then 
			return 7
		elseif to_big(score):gte(reqs:arrow(7, may.tr_constants.googchime)) then 
			return 8
		elseif to_big(score):gte(reqs:arrow(10, may.tr_constants.googchime)) then 
			return 9
		elseif to_big(score):gte(reqs:arrow(75, may.tr_constants.googchime)) then 
			return 10
		elseif to_big(score):gte(reqs:arrow(200, may.tr_constants.googchime)) then 
			return 11
		elseif to_big(score):gte(reqs:arrow(1000, may.tr_constants.googchime)) then 
			return 12
		elseif to_big(score):gte(may.tr_constants.tr13) then 
			return 13
		elseif to_big(score):gte(may.tr_constants.tr14) then 
			return 14
		elseif to_big(score):gte(may.tr_constants.tr15) then 
			return 15
		elseif to_big(score):gte(may.tr_constants.tr16) then 
			return 16
		elseif to_big(score):gte(may.tr_constants.tr17) then 
			return 17
		end
		return 0
	else
		return may.transcendence 
	end
end
 
function may.calc_transcendence()
	if not G.ARGS.push.may_true_music_volume then
		G.ARGS.push.may_true_music_volume = G.SETTINGS.SOUND.music_volume
	end

	if may.conf.TrEffects > 1 and (may.transcendence == 0 or not G.hand or not G.hand.highlighted or (#G.hand.highlighted == 0 and G.STATE == G.STATES.SELECTING_HAND)) then
		if may._last_ease_tr ~= 0 then
			may._last_ease_tr = 0
			G.ROOM.may_permajiggle = 0
			if not #SMODS.find_mod('Cryptid') ~= 0 then
				transcendence_glitch = 0
			else
				glitched_intensity = 0
			end
			if not G.ROOM.may_override_crt then
				transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
				transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
				transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
				transcendence_glitch = 0
			end
			if may.conf.TrEffects > 2 then
				G.ARGS.spin.real = 0.3
				G.ARGS.spin.eased = 0.3
			end
		end
		return
	end

	if may.conf.TrEffects > 1 and is_number(SMODS.get_scoring_parameter('chips', true)) and is_number(SMODS.get_scoring_parameter('mult', true)) then
		if (may.transcendence or 0) > 0 and G.hand then
			if is_number(SMODS.get_scoring_parameter('chips', true)) and is_number(SMODS.get_scoring_parameter('mult', true)) and to_big(G.GAME.current_scoring_calculation:func(SMODS.get_scoring_parameter('chips', true), SMODS.get_scoring_parameter('mult', true), true)) > to_big(0) then
				local tr_changed = may.transcendence ~= may._last_ease_tr
				if tr_changed then
					may._last_ease_tr = may.transcendence

					if may.conf.TrParticles and G.transcendence_particles then
						G.transcendence_particles.colours[2] = may.get_transcendence_color(may.transcendence)
					end

					if may.conf.TrEffects > 2 then
						G.ARGS.spin.real = -math.log10(may.transcendence)
					end

					if may.transcendence < 10 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = may.transcendence / 4.5
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = may.transcendence
							else
								glitched_intensity = may.transcendence
							end
							transcendence_noise = may.conf.TrNoise and (may.transcendence / 30) or 0
							transcendence_crt = may.transcendence / 60
						end
					elseif may.transcendence == 10 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 10
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = -2
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 15
							else
								glitched_intensity = 15
							end
							transcendence_noise = may.conf.TrNoise and 0.4 or 0
							transcendence_crt = 0.2
						end
					elseif may.transcendence == 11 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 20
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = -5
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 70
							else
								glitched_intensity = 70
							end
							transcendence_noise = may.conf.TrNoise and 0.5 or 0
							transcendence_crt = 0.3
						end
					elseif may.transcendence == 12 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 0
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 0
							G.ARGS.spin.amount = 0
							G.ARGS.spin.eased = 0
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 100
							else
								glitched_intensity = 100
							end
							transcendence_noise = may.conf.TrNoise and 0.6 or 0
							transcendence_crt = 100
						end
					elseif may.transcendence == 13 then
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 0
							G.ARGS.spin.amount = 0
							G.ARGS.spin.eased = 0
						end
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 5
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 50
							else
								glitched_intensity = 50
							end
							transcendence_noise = may.conf.TrNoise and 0.1 or 0
							transcendence_crt = 0.2
						end
					elseif may.transcendence == 14 then
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 2
							G.ARGS.spin.amount = 2
							G.ARGS.spin.eased = 2
						end
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 20
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 90
							else
								glitched_intensity = 90
							end
							transcendence_noise = may.conf.TrNoise and 0.5 or 0
							transcendence_crt = 0.5
						end
					elseif may.transcendence == 15 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 0
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 1
							G.ARGS.spin.amount = 1
							G.ARGS.spin.eased = 1
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 1
							else
								glitched_intensity = 1
							end
							transcendence_noise = may.conf.TrNoise and 0.65 or 0
							transcendence_crt = 0.6
						end
					elseif may.transcendence == 16 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 3
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 3
							G.ARGS.spin.amount = 3
							G.ARGS.spin.eased = 3
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 200
							else
								glitched_intensity = 200
							end
							transcendence_noise = may.conf.TrNoise and 0.5 or 0
							transcendence_crt = 0.7
						end
					elseif may.transcendence == 17 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 4
						end
						if may.conf.TrEffects > 2 then
							G.ARGS.spin.real = 2
							G.ARGS.spin.amount = 2
							G.ARGS.spin.eased = 2
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if not #SMODS.find_mod('Cryptid') ~= 0 then
								transcendence_glitch = 500
							else
								glitched_intensity = 500
							end
							transcendence_noise = may.conf.TrNoise and 0.5 or 0
							transcendence_crt = 0.9
						end
					end
				end
			end
		end
	end
end

-- Score shakiness is slightly modified code from POLTERWORX 
G.FUNCS.hand_type_UI_set = function(e)
	local new_mult_text = number_format(G.GAME.current_round.current_hand[e.config.type] or SMODS.Scoring_Parameters[e.config.type].default_value)
	if new_mult_text ~= G.GAME.current_round.current_hand[e.config.text] then
		G.GAME.current_round.current_hand[e.config.text] = new_mult_text
		e.config.object.scale = scale_number(G.GAME.current_round.current_hand[e.config.type], 0.9, 1000)
		e.config.object:update_text()
		local comparison = to_big(G.GAME.current_round.current_hand[e.config.type])
		if not G.TAROT_INTERRUPT_PULSE then
			if comparison > may.tr_constants.ui_t17 then
				G.FUNCS.tsj_specific(e, 10, 640, false, true)
			elseif comparison > may.tr_constants.ui_t16 then
				G.FUNCS.tsj_specific(e, 10, 320, false, true)
			elseif comparison > may.tr_constants.ui_t15 then
				G.FUNCS.tsj_specific(e, 10, 160, false, true)
			elseif comparison > may.tr_constants.ui_t14 then
				G.FUNCS.tsj_specific(e, 10, 80, false, true)
			elseif comparison > may.tr_constants.ui_t13 then
				G.FUNCS.tsj_specific(e, 7.5, 40, false, true)
			elseif comparison > may.tr_constants.ui_t12 then
				G.FUNCS.tsj_specific(e, 5.5, 26, false, true)
			elseif comparison > may.tr_constants.ui_t11 then
				G.FUNCS.tsj_specific(e, 5, 24, false, true)
			elseif comparison > may.tr_constants.ui_t10 then
				G.FUNCS.tsj_specific(e, 4.5, 22, false, true)
			elseif comparison > may.tr_constants.ui_t9 then
				G.FUNCS.tsj_specific(e, 4, 20, false, true)
			elseif comparison > may.tr_constants.ui_t8 then
				G.FUNCS.tsj_specific(e, 3.5, 18, false, true)
			elseif comparison > may.tr_constants.ui_t7 then
				G.FUNCS.tsj_specific(e, 3, 16, false, true)
			elseif comparison > may.tr_constants.ui_t6 then
				G.FUNCS.tsj_specific(e, 2.5, 14, false, true)
			elseif comparison > may.tr_constants.ui_t5 then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
			elseif comparison > may.tr_constants.ui_t4 then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif comparison > may.tr_constants.ui_t3 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif comparison > may.tr_constants.ui_t2 then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif comparison > may.tr_constants.ui_t1 then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
			else
				if Talisman.cdataman then
					G.FUNCS.tsj_specific(e, 0, 0.4, false, true)
				else
				    G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10(is_number(G.GAME.current_round.current_hand[e.config.type]) and G.GAME.current_round.current_hand[e.config.type] or 1)))) 
				end
			end
		end
	end
end

G.FUNCS.hand_chip_total_UI_set = function(e)
	if to_big(G.GAME.current_round.current_hand.chip_total) < to_big(1) then
		G.GAME.current_round.current_hand.chip_total_text = ''
	else
		local new_chip_total_text = number_format(G.GAME.current_round.current_hand.chip_total)
		if new_chip_total_text ~= G.GAME.current_round.current_hand.chip_total_text then 
			e.config.object.scale = scale_number(G.GAME.current_round.current_hand.chip_total, 0.95, 100000000)
			
			G.GAME.current_round.current_hand.chip_total_text = new_chip_total_text
			local comparison = G.GAME.current_round.current_hand.chip_total
			if type(comparison) == 'number' then
				comparison = Big:create(comparison)
			elseif type(comparison) == 'string' then
				comparison = Big:create(1)
			end
			if comparison > may.tr_constants.chip_t13 then
				G.ROOM.jiggle = 4000
			elseif comparison > may.tr_constants.chip_t12 then
				G.ROOM.jiggle = 3200
			elseif comparison > may.tr_constants.chip_t11 then
				G.ROOM.jiggle = 2400
			elseif comparison > may.tr_constants.chip_t10 then
				G.ROOM.jiggle = 1600
			elseif comparison > may.tr_constants.chip_t9 then
				G.ROOM.jiggle = 1160
			elseif comparison > may.tr_constants.chip_t8 then
				G.ROOM.jiggle = 760
			elseif comparison > may.tr_constants.chip_t7 then
				G.ROOM.jiggle = 560
			elseif comparison > may.tr_constants.chip_t6 then
				G.ROOM.jiggle = 360
			elseif comparison > may.tr_constants.chip_t5 then
				G.ROOM.jiggle = 280
			elseif comparison > may.tr_constants.chip_t4 then
				G.ROOM.jiggle = 200
			elseif comparison > may.tr_constants.chip_t3 then
				G.ROOM.jiggle = 120
			elseif comparison > may.tr_constants.chip_t2 then
				G.ROOM.jiggle = 80
			elseif comparison > may.tr_constants.chip_t1 then
				G.ROOM.jiggle = 40
			end
			if comparison > may.tr_constants.chip_t10 then
				play_sound('may_big_score3', 1, 2)
			elseif comparison > may.tr_constants.chip_t7 then
				play_sound('may_big_score2', 1, 2)
			elseif comparison > may.tr_constants.chip_t2 then
				play_sound('may_big_score1', 1, 2)
			end
			if comparison > may.tr_constants.ui_t15 then
				G.FUNCS.tsj_specific(e, 10, 200, false, true)
			elseif comparison > may.tr_constants.ui_t14 then
				G.FUNCS.tsj_specific(e, 10, 100, false, true)
			elseif comparison > may.tr_constants.ui_t13 then
				G.FUNCS.tsj_specific(e, 7.5, 60, false, true)
			elseif comparison > may.tr_constants.ui_t12 then
				G.FUNCS.tsj_specific(e, 5.5, 33, false, true)
			elseif comparison > may.tr_constants.ui_t11 then
				G.FUNCS.tsj_specific(e, 5, 30, false, true)
			elseif comparison > may.tr_constants.ui_t10 then
				G.FUNCS.tsj_specific(e, 4.5, 27, false, true)
			elseif comparison > may.tr_constants.ui_t9 then
				G.FUNCS.tsj_specific(e, 4, 24, false, true)
			elseif comparison > may.tr_constants.ui_t8 then
				G.FUNCS.tsj_specific(e, 3.5, 21, false, true)
			elseif comparison > may.tr_constants.ui_t7 then
				G.FUNCS.tsj_specific(e, 3, 18, false, true)
			elseif comparison > may.tr_constants.ui_t6 then
				G.FUNCS.tsj_specific(e, 2.5, 15, false, true)
			elseif comparison > may.tr_constants.ui_t5 then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
			elseif comparison > may.tr_constants.ui_t4 then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif comparison > may.tr_constants.ui_t3 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif comparison > may.tr_constants.ui_t2 then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif comparison > may.tr_constants.ui_t1 then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
			else
				if Talisman.cdataman then
					G.FUNCS.tsj_specific(e, 0.2, 0.7, false, true)
				else 
				    G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log(is_number(G.GAME.current_round.current_hand.chip_total) and G.GAME.current_round.current_hand.chip_total or 1))))
				end
			end
			G.ARGS.hand_chip_total_UI_set = G.GAME.current_round.current_hand.chip_total
		end
	end
end

SMODS.DrawStep {
	key = 'transcendence_shake',
	order = -3000,
	func = function(self)
		if G.hand and may.conf.TrShakeCards then
			if (may.transcendence or 0) < 9 and (may.transcendence or 0) > 0 then
				if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
					self:juice_up(0.01, math.random(0, (may.transcendence or 0))/9)
				end
			else 
				if (may.transcendence or 0) == 9 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(math.random(-.5, .5), math.random(1, 3))
					end
				end
				if (may.transcendence or 0) == 10 or (may.transcendence or 0) == 16 or (may.transcendence or 0) == 17 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(math.random(-2, 0), 100)
					end
				end
				if (may.transcendence or 0) == 11 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(0, math.random(100, 800))
					end
				end
				if (may.transcendence or 0) == 12 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(0, 0.001)
					end
				end
				if (may.transcendence or 0) == 14 or (may.transcendence or 0) == 15 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(math.random(-.5, .5), math.random(1, 3))
					end
				end
				if (may.transcendence or 0) == 18 then
					if (self.area or {}) == G.hand or (self.area or {}) == G.jokers or (self.area or {}) == G.consumeables or (self.area or {}) == G.play or (self.area or {}) == G.deck then
						self:juice_up(math.random(-5, 5), 500)
					end
				end
			end
		end
	end
}

local do_calc_frames = 0
local original_hand_type_ui = G.FUNCS.hand_type_UI_set
G.FUNCS.hand_type_UI_set = function(e)
    local prev_text = G.GAME.current_round.current_hand[e.config.text]
    original_hand_type_ui(e)
    if G.GAME.current_round.current_hand[e.config.text] ~= prev_text then
        may.calc_transcendence()
    end
end

local last_count = nil
local was_tr_active = false
local upd = Game.update
function Game:update(dt)
    upd(self, dt)
    if G and G.GAME and G.GAME.blind then
        if G.hand and #G.hand.cards > 0 and (not may.booster()) and (not G.TAROT_INTERRUPT_PULSE) then
            if do_calc_frames > 0 then
                may.calc_transcendence()
                do_calc_frames = do_calc_frames - 1
            end
        end

        if G.hand and G.STATE == G.STATES.SELECTING_HAND then
            local count = #G.hand.highlighted
            if last_count ~= nil and count ~= last_count then
                do_calc_frames = 3
            end
            last_count = count
        end
		-- “holy poop” - fokuto, 2026
		local tr_active = (may.transcendence or 0) > 0 and G.hand and not (G.hand and G.hand.highlighted and #G.hand.highlighted == 0 and G.STATE == G.STATES.SELECTING_HAND)
		
		if was_tr_active and not tr_active then
			ease_background_colour_blind(G.STATE)
		end
		was_tr_active = tr_active
		
		local instant = may.conf.TrEffects == 5
		
		if (may.transcendence or 0) == 0 or not G.hand or not tr_active then
			G.C.DARK_EDITION[1] = 0.6+0.2*math.sin(G.TIMERS.REAL*1.3)
			G.C.DARK_EDITION[3] = 0.6+0.2*(1-math.sin(G.TIMERS.REAL*1.3))
			G.C.DARK_EDITION[2] = math.min(G.C.DARK_EDITION[3], G.C.DARK_EDITION[1])
			G.ARGS.LOC_COLOURS.dark_edition = G.C.DARK_EDITION

			if may.conf.TrParticles and G.transcendence_particles then
				G.transcendence_particles.fade_alpha = 1
			end

			if may.conf.TrEffects > 2 and (may.transcendence or 0) < 13 then
				if may.conf.TrParticles and G.transcendence_particles then
					G.transcendence_particles.colours[2] = may.get_transcendence_color(may.transcendence or 0)
					G.transcendence_particles.fade_alpha = 0.7 / (may.transcendence or 0)
					G.transcendence_particles.speed = (may.transcendence or 0) * 5
				end
				may.ease_colour(G.C.MONEY, may.tr_colors.money, instant)
				may.ease_colour(G.C.RED, may.tr_colors.mult, instant)
				may.ease_colour(G.C.BLUE, may.tr_colors.chips, instant)
				may.ease_colour(G.C.IMPORTANT, may.tr_colors.important, instant)
				may.ease_colour(G.C.GOLD, may.tr_colors.gold, instant)
				may.ease_colour(G.C.ORANGE, may.tr_colors.orange, instant)
				may.ease_colour(G.C.UI.BACKGROUND_DARK, may.tr_colors.bg_dark, instant)
				may.ease_colour(G.C.UI_CHIPS, may.tr_colors.chips, instant)
				may.ease_colour(G.C.UI_MULT, may.tr_colors.mult, instant)
				if #SMODS.find_mod('GRM') ~= 0 then
					may.ease_colour(G.C.PURPLE, may.tr_colors.purple, instant)
				end
			end
			if G.GAME.blind and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.NEW_ROUND) then
				may.ease_blind_colour(G.GAME.blind)
			end
		end
		if may.conf.TrEffects > 2 and (may.transcendence or 0) > 0 and tr_active then
			ease_background_colour({ new_colour = copy_table(may.get_transcendence_color(may.transcendence)), special_colour = G.C.BLACK, contrast = 2 })
			may.ease_colour(G.C.MONEY, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.RED, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.BLUE, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.IMPORTANT, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.GOLD, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.ORANGE, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.UI.BACKGROUND_DARK, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.UI_CHIPS, may.get_transcendence_color(may.transcendence), instant)
			may.ease_colour(G.C.UI_MULT, may.get_transcendence_color(may.transcendence), instant)
			if may.conf.TrParticles and G.transcendence_particles then
                G.transcendence_particles.colours[2] = may.get_transcendence_color(may.transcendence)
                G.transcendence_particles.fade_alpha = 0.7 / may.transcendence
                G.transcendence_particles.speed = may.transcendence * 5
            end
			
			if may.conf.TrEffects == 5 and G.GAME.blind then
				may.ease_blind_colour(G.GAME.blind, may.get_transcendence_color(may.transcendence))
			end
	
			if #SMODS.find_mod('GRM') ~= 0 then
				may.ease_colour(G.C.PURPLE, may.get_transcendence_color(may.transcendence), instant)
			end
		end
    end
    if G and G.GAME and G.ROOM then
        if G.ROOM.may_permajiggle and may.conf.TrShakeScreen then
            G.ROOM.jiggle = G.ROOM.jiggle + G.ROOM.may_permajiggle
        end
    end
	
	if G and not G.GAME then
        if not #SMODS.find_mod('Cryptid') ~= 0 then
			transcendence_glitch = 0
		else
			glitched_intensity = 0
		end
		transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
		transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
		transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
	end
    if G.hand and may.transcendence then
        if (may.transcendence or 0) < 10 and (may.transcendence or 0) > 0 and may.conf.TrEffects > 2 then
            if may.conf.TrShakeUI then
                G.hand_text_area.blind_chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
                G.hand_text_area.mult:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
                G.hand_text_area.chips:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
                G.hand_text_area.handname:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
                G.hand_text_area.hand_level:juice_up(0.01, math.random(-(may.transcendence or 0)/9, (may.transcendence or 0))/9)
            end
        elseif may.transcendence == 10 and may.conf.TrEffects > 2 then
            if may.conf.TrShakeUI then
                G.hand_text_area.blind_chips:juice_up(0.01, 100)
                G.hand_text_area.mult:juice_up(0.01, 100)
                G.hand_text_area.chips:juice_up(0.01, 100)
                G.hand_text_area.handname:juice_up(0.01, 100)
                G.hand_text_area.hand_level:juice_up(0.01, 100)
            end
        elseif may.transcendence == 11 then
            if may.conf.TrShakeUI and may.conf.TrEffects > 2 then
                G.hand_text_area.blind_chips:juice_up(0.01, 400)
                G.hand_text_area.mult:juice_up(0.01, 400)
                G.hand_text_area.chips:juice_up(0.01, 400)
                G.hand_text_area.handname:juice_up(0.01, 400)
                G.hand_text_area.hand_level:juice_up(0.01, 400)
            end
        end
    end
end

-- Initialize particles
local vanf_sb = G.FUNCS.select_blind
function G.FUNCS.select_blind(e)
	vanf_sb(e)
	if may.conf.TrParticles then
		if G.transcendence_particles then
			G.transcendence_particles:remove()
			G.transcendence_particles = nil
		end
		G.transcendence_particles = Particles(1, 1, 0, 0, {
			timer = 0.015,
			scale = 0.3,
			initialize = true,
			lifespan = 3,
			speed = 5,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = { G.C.BLACK, G.C.DARK_EDITION },
			fill = true
		})
		G.transcendence_particles.fade_alpha = 1
	end
end

local vanf_er = end_round
function end_round()
	if G.transcendence_particles then
		G.transcendence_particles:remove()
		G.transcendence_particles = nil
	end
	do_calc_frames = 3
	vanf_er()
end