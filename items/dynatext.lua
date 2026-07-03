-- DynaText effects

SMODS.DynaTextEffect {
	key = 'transcendent_name', 
	func = function(dynatext, index, letter)
		letter.offset.y = (math.sin((index * 20) + G.TIMERS.REAL * 2) * 20)
		letter.offset.x = (letter.offset.x or 0) + (math.sin(-((index * 50) + G.TIMERS.REAL)) * 0.8)
	end
}

SMODS.DynaTextEffect {
	key = 'omniversal_name', 
	func = function(dynatext, index, letter)
		letter.offset.y = (math.cos((index * 20) + G.TIMERS.REAL * 4) * 10 + (may.conf.epileptic and 0 or math.tan(index + G.TIMERS.REAL)))
		letter.offset.x = (math.sin(-((index * 50) + G.TIMERS.REAL * 2)) * 0.4) - (may.conf.epileptic and 0 or math.tan(index + G.TIMERS.REAL * 0.4))
		letter.shader = "may_paradoxical_text"
	end
}

SMODS.DynaTextEffect {
	key = 'alex343xd_name', 
	func = function(dynatext, index, letter)
		letter.offset.y = (math.cos((index * 20) + G.TIMERS.REAL) * 25 + (may.conf.epileptic and 0 or math.tan(index + G.TIMERS.REAL)))
		letter.offset.x = (math.sin(-((index * 50) + G.TIMERS.REAL * 2)) * 0.5)
		letter.shader = "may_paradoxical_text"
	end
}