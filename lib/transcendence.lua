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
}

function may.get_transcendence_color(int)
	if int > 0 then
		if int >= 13 and math.random(20) == 1 and not may.conf.epileptic then
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
	if may.conf.TrEffects > 1 and (type(SMODS.get_scoring_parameter('chips', true)) == 'number' or type(SMODS.get_scoring_parameter('chips', true)) == 'table') and (type(SMODS.get_scoring_parameter('mult', true)) == 'number' or type(SMODS.get_scoring_parameter('mult', true)) == 'table') then 
		if may.transcendence > 0 and G.hand then
			if ((type(SMODS.get_scoring_parameter('chips', true)) == 'number' or type(SMODS.get_scoring_parameter('chips', true)) == 'table') and (type(SMODS.get_scoring_parameter('mult', true)) == 'number' or type(SMODS.get_scoring_parameter('mult', true)) == 'table')) and to_big(G.GAME.current_scoring_calculation:func(SMODS.get_scoring_parameter('chips', true), SMODS.get_scoring_parameter('mult', true), true)) > to_big(0) then 
				if may.transcendence > 0 then
					if may.conf.TrParticles and G.transcendence_particles then
						G.transcendence_particles.colours[2] = may.get_transcendence_color(may.transcendence)
					end
					if not G.GAME.may_override_monitor_colors then
						may.ease_colour(G.C.UI_MULT, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.UI_CHIPS, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
					end
					if may.conf.TrEffects > 2 then
						ease_background_colour({ new_colour = copy_table(may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5), special_colour = G.C.BLACK, contrast = 2 })
						if may.conf.TrParticles then
						    G.transcendence_particles.fade_alpha = 0.7 / may.transcendence
						    G.transcendence_particles.speed = may.transcendence * 5
						end
						may.ease_colour(G.C.MONEY, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)	
						may.ease_colour(G.C.RED, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.BLUE, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.IMPORTANT, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.GOLD, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.ORANGE, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						may.ease_colour(G.C.UI.BACKGROUND_DARK, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						if #SMODS.find_mod('GRM') ~= 0 then
							may.ease_colour(G.C.PURPLE, may.get_transcendence_color(may.transcendence), may.conf.TrEffects == 5)
						end
						G.ARGS.spin.real = -math.log10(may.transcendence) 
					end
					if may.transcendence < 10 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = (may.transcendence or 0)/4.5
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = may.transcendence
							else
								glitched_intensity = may.transcendence
							end
							transcendence_noise = may.conf.TrNoise and (may.transcendence/30) or 0
							transcendence_crt = may.transcendence/60
						end
					elseif may.transcendence == 10 then
						if may.conf.TrShakeScreen then
							G.ROOM.may_permajiggle = 10
						end
						if may.conf.TrEffects > 2 then 
							G.ARGS.spin.real = -2
						end
						if may.conf.TrEffects >= 4 and not G.ROOM.may_override_crt then
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
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
							if #SMODS.find_mod('Cryptid') == 0 then
								transcendence_glitch = 500
							else
								glitched_intensity = 500
							end
							transcendence_noise = may.conf.TrNoise and 0.5 or 0
							transcendence_crt = 0.9
						end
					end
				else
					if not G.GAME.may_override_monitor_colors then
						may.ease_colour(G.C.UI_CHIPS, HEX("009dff"), may.conf.TrEffects == 5)
						may.ease_colour(G.C.UI_MULT, HEX('FE5F55'), may.conf.TrEffects == 5)
						may.ease_colour(G.C.RED, HEX('FE5F55'), may.conf.TrEffects == 5)
						may.ease_colour(G.C.BLUE, HEX("009dff"), may.conf.TrEffects == 5)
					end
					may.ease_colour(G.C.BLUE, HEX("009dff"), may.conf.TrEffects == 5)
					may.ease_colour(G.C.MONEY, HEX('f3b958'), may.conf.TrEffects == 5)
					may.ease_colour(G.C.RED, HEX('f3b958'), may.conf.TrEffects == 5)
					may.ease_colour(G.C.IMPORTANT, HEX('ff9a00'), may.conf.TrEffects == 5)
					may.ease_colour(G.C.GOLD, HEX('eac058'), may.conf.TrEffects == 5)
					may.ease_colour(G.C.ORANGE, HEX('fda200'), may.conf.TrEffects == 5)
					may.ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), may.conf.TrEffects == 5)
					G.C.DARK_EDITION[1] = 0.6+0.2*math.sin(G.TIMERS.REAL*1.3)
					G.C.DARK_EDITION[3] = 0.6+0.2*(1- math.sin(G.TIMERS.REAL*1.3))
					G.C.DARK_EDITION[2] = math.min(G.C.DARK_EDITION[3], G.C.DARK_EDITION[1])
					G.ARGS.LOC_COLOURS.dark_edition = G.C.DARK_EDITION
					if #SMODS.find_mod('GRM') ~= 0 then
						may.ease_colour(G.C.PURPLE, HEX('8867a5'), may.conf.TrEffects == 5)
					end
					if #SMODS.find_mod('Cryptid') == 0 then
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
					G.transcendence_particles.fade_alpha = 0
                    G.transcendence_particles:fade(0, 0)
				end
			end
		end
		if may.transcendence == 0 or not G.hand then 
			if not G.GAME.may_override_monitor_colors then
				may.ease_colour(G.C.UI_CHIPS, HEX("009dff"), may.conf.TrEffects == 5)
				may.ease_colour(G.C.UI_MULT, HEX('FE5F55'), may.conf.TrEffects == 5)
				may.ease_colour(G.C.RED, HEX('FE5F55'), may.conf.TrEffects == 5)
				may.ease_colour(G.C.BLUE, HEX("009dff"), may.conf.TrEffects == 5)
			end
			may.ease_colour(G.C.MONEY, HEX('f3b958'), may.conf.TrEffects == 5)
			may.ease_colour(G.C.RED, HEX('FE5F55'), may.conf.TrEffects == 5)
			may.ease_colour(G.C.IMPORTANT, HEX('ff9a00'), may.conf.TrEffects == 5)
			may.ease_colour(G.C.GOLD, HEX('eac058'), may.conf.TrEffects == 5)
			may.ease_colour(G.C.ORANGE, HEX('fda200'), may.conf.TrEffects == 5)
			may.ease_colour(G.C.UI.BACKGROUND_DARK, HEX("7A9E9F"), may.conf.TrEffects == 5)
			G.C.DARK_EDITION[1] = 0.6+0.2*math.sin(G.TIMERS.REAL*1.3)
			G.C.DARK_EDITION[3] = 0.6+0.2*(1- math.sin(G.TIMERS.REAL*1.3))
			G.C.DARK_EDITION[2] = math.min(G.C.DARK_EDITION[3], G.C.DARK_EDITION[1])
			G.ARGS.LOC_COLOURS.dark_edition = G.C.DARK_EDITION
			G.ROOM.may_permajiggle = 0
			if #SMODS.find_mod('GRM') ~= 0 then
				may.ease_colour(G.C.PURPLE, HEX('8867a5'), may.conf.TrEffects == 5)
			end
			if #SMODS.find_mod('Cryptid') == 0 then
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
			ease_background_colour_blind(G.STATES.DRAW_TO_HAND)
			if G.transcendence_particles then
			    G.transcendence_particles.fade_alpha = 1
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
			if to_big(comparison) > Big:create(1e308):arrow(4000, 2) then
				G.FUNCS.tsj_specific(e, 10, 640, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(3000, 2) then
				G.FUNCS.tsj_specific(e, 10, 320, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(2000, 2) then
				G.FUNCS.tsj_specific(e, 10, 160, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 80, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 7.5, 40, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 5.5, 26, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(9, 3) then
				G.FUNCS.tsj_specific(e, 5, 24, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(8, 3) then
				G.FUNCS.tsj_specific(e, 4.5, 22, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(7, 3) then
				G.FUNCS.tsj_specific(e, 4, 20, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(6, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 18, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 16, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 14, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif to_big(comparison) > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif to_big(comparison) > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif to_big(comparison) > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
			else
				G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log10((type(G.GAME.current_round.current_hand[e.config.type]) == 'number' or type(G.GAME.current_round.current_hand[e.config.type]) == 'table') and G.GAME.current_round.current_hand[e.config.type] or 1))))
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
			if to_big(comparison) > Big:create(1e100):arrow(1, 100) then
				G.ROOM.jiggle = 40
			elseif to_big(comparison) > Big:create(1e100):arrow(2, 100) then
				G.ROOM.jiggle = 80
			elseif to_big(comparison) > Big:create(1e100):arrow(3, 100) then
				G.ROOM.jiggle = 120
			elseif to_big(comparison) > Big:create(1e100):arrow(4, 100) then
				G.ROOM.jiggle = 200
			elseif to_big(comparison) > Big:create(1e100):arrow(5, 100) then
				G.ROOM.jiggle = 280
			elseif to_big(comparison) > Big:create(1e100):arrow(6, 100) then
				G.ROOM.jiggle = 360
			elseif to_big(comparison) > Big:create(1e100):arrow(7, 100) then
				G.ROOM.jiggle = 560
			elseif to_big(comparison) > Big:create(1e100):arrow(8, 100) then
				G.ROOM.jiggle = 760
			elseif to_big(comparison) > Big:create(1e100):arrow(10, 100) then
				G.ROOM.jiggle = 1160
			elseif to_big(comparison) > Big:create(1e100):arrow(30, 100) then
				G.ROOM.jiggle = 1600
			elseif to_big(comparison) > Big:create(1e100):arrow(150, 100) then
				G.ROOM.jiggle =  2400
			elseif to_big(comparison) > Big:create(1e100):arrow(800, 100) then
				G.ROOM.jiggle = 3200
			elseif to_big(comparison) > Big:create(1e100):arrow(5000, 100) then
				G.ROOM.jiggle = 4000
			end
			if to_big(comparison) > Big:create(1e100):arrow(30, 100) then 
				play_sound('may_big_score3', 1, 2)
			elseif to_big(comparison) > Big:create(1e100):arrow(7, 100) then
				play_sound('may_big_score2', 1, 2)
			elseif to_big(comparison) > Big:create(1e100):arrow(2, 100) then
				play_sound('may_big_score1', 1, 2)
			end
			if to_big(comparison) > Big:create(1e308):arrow(2000, 2) then
				G.FUNCS.tsj_specific(e, 10, 200, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(1000, 2) then
				G.FUNCS.tsj_specific(e, 10, 100, false, true)
			elseif to_big(comparison) > Big:create(1e308):arrow(100, 10) then
				G.FUNCS.tsj_specific(e, 7.5, 60, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(10, 3) then
				G.FUNCS.tsj_specific(e, 5.5, 33, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(9, 3) then
				G.FUNCS.tsj_specific(e, 5, 30, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(8, 3) then
				G.FUNCS.tsj_specific(e, 4.5, 27, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(7, 3) then
				G.FUNCS.tsj_specific(e, 4, 24, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(6, 3) then
				G.FUNCS.tsj_specific(e, 3.5, 21, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(5, 3) then
				G.FUNCS.tsj_specific(e, 3, 18, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(4, 3) then
				G.FUNCS.tsj_specific(e, 2.5, 15, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(3, 3) then
				G.FUNCS.tsj_specific(e, 2, 12, false, true)
				--play_sound('may_big_number_set')
			elseif to_big(comparison) > Big:create(1e308):arrow(2, 2) then
				G.FUNCS.tsj_specific(e, 1.35, 9, false, true)
			elseif to_big(comparison) > Big:create(1e308) ^ 2 then
				G.FUNCS.tsj_specific(e, 1, 5, false, true)
			elseif to_big(comparison) > Big:create(1e308) then
				G.FUNCS.tsj_specific(e, 0.75, 3, false, true)
			elseif to_big(comparison) > Big:create(1e100) then
				G.FUNCS.tsj_specific(e, 0.5, 1.5, false, true)
				G.FUNCS.text_super_juice(e, math.max(0,math.floor(math.log((type(G.GAME.current_round.current_hand.chip_total) == 'number' or type(G.GAME.current_round.current_hand.chip_total) == 'table') and G.GAME.current_round.current_hand.chip_total or 1))))
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

local upd = Game.update
function Game:update(dt)
	upd(self, dt)
	if G and G.GAME then
		if G.GAME.blind and G.hand and #G.hand.cards > 0 and (not may.booster()) and (not G.TAROT_INTERRUPT_PULSE) then
			if (dt > 0 and math.ceil(G.TIMERS.REAL) * 10 % 2 == 0) then
				G.E_MANAGER:add_event(Event({trigger = 'before', blocking = false, func = function()
					may.calc_transcendence()
				return true end}), 'other')
			end
		end
	end
	if not G.GAME then
		if #SMODS.find_mod('Cryptid') == 0 then
			transcendence_glitch = 0
		else
			glitched_intensity = 0
		end
		transcendence_noise = 0.001*(G.SETTINGS.GRAPHICS.crt*0.3)/100
		transcendence_crt = 0.16*(G.SETTINGS.GRAPHICS.crt*0.3)/100
		transcendence_bloom = G.SETTINGS.GRAPHICS.bloom - 1
	end
	if G.ROOM and G.ROOM.may_permajiggle and may.conf.TrShakeScreen then 
		G.ROOM.jiggle = G.ROOM.jiggle + G.ROOM.may_permajiggle
	end
	if G.hand and may.transcendence then 
		if may.transcendence < 10 and may.conf.TrEffects > 2 then
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
		--[[if not may.conf.epileptic and may.transcendence >= 10 and (G.ROOM.may_tr_flashing == true) then
			G.C.DARK_EDITION = HEX('ffffff')
			G.ROOM.may_tr_flashing = false
		end]] 
	end
end

-- Initialize particles
local vanf_sb = G.FUNCS.select_blind
function G.FUNCS.select_blind(e)
	vanf_sb(e)
	if may.conf.TrParticles then
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
	G.transcendence_particles = nil
	vanf_er()
end