-- Timers
-- Functions when timers elapsed are defined in may.timer_functions['function_key']

may.timer_functions = {}

may.timer_functions['mythic_scale'] = function()
	G.GAME.may_mythic_scaling = (G.GAME.may_mythic_scaling or 0) + 1
	may.a('Mythic Scaling activated! (Round 60 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['transcendent_scale'] = function()
	G.GAME.may_transcendent_scaling = (G.GAME.may_transcendent_scaling or 0) + 1
	may.a('Ethereal Scaling activated! (Round 120 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['interdimensional_scale'] = function()
	G.GAME.may_interdimensional_scaling = (G.GAME.may_interdimensional_scaling or 0) + 1
	may.a('Prismatic Scaling activated! (Round 150 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['ethereal_scale'] = function()
	G.GAME.may_ethereal_scaling = (G.GAME.may_ethereal_scaling or 0) + 1
	may.a('Demiurgic Scaling activated! (Round 210 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['hyperascendant_scale'] = function()
	G.GAME.may_hyperascendant_scaling = (G.GAME.may_hyperascendant_scaling or 0) + 1
	may.a('Transcendent Scaling activated! (Round 300 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end


may.timer_functions['mythic_scale_warning'] = function()
	may.a('Mythic Scaling will activate in 3 rounds! (Round 60 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['transcendent_scale_warning'] = function()
	may.a('Ethereal Scaling will activate in 3 rounds! (Round 120 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['interdimensional_scale_warning'] = function()
	may.a('Prismatic Scaling will activate in 3 rounds! (Round 150 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['ethereal_scale_warning'] = function()
	may.a('Demiurgic Scaling will activate in 3 rounds! (Round 210 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['hyperascendant_scale_warning'] = function()
	may.a('Transcendent Scaling will activate in 3 rounds! (Round 300 threshold)', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end


may.timer_functions['mythic_fuse'] = function()
	G.GAME.may_mythic_scaling = (G.GAME.may_mythic_scaling or 0) + 1
	may.a('Mythic Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['transcendent_fuse'] = function()
	G.GAME.may_transcendent_scaling = (G.GAME.may_transcendent_scaling or 0) + 1
	may.a('Ethereal Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['surreal_get'] = function()
	G.GAME.may_surreal_scaling = (G.GAME.may_surreal_scaling or 0) + 1
	may.a('Opalescent Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['interdimensional_fuse'] = function()
	G.GAME.may_interdimensional_scaling = (G.GAME.may_interdimensional_scaling or 0) + 1
	may.a('Prismatic Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['ethereal_fuse'] = function()
	G.GAME.may_ethereal_scaling = (G.GAME.may_ethereal_scaling or 0) + 1
	may.a('Demiurgic Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

may.timer_functions['hyperascendant_fuse'] = function()
	G.GAME.may_hyperascendant_scaling = (G.GAME.may_hyperascendant_scaling or 0) + 1
	may.a('Transcendent Scaling activated!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
end

-- rounds, function when timer elapses
function may.add_round_timer(rounds, func)
	G.GAME.may_timers = G.GAME.may_timers or {}
	local generated = {rounds = rounds, func = func}
	table.insert(G.GAME.may_timers, generated)
end