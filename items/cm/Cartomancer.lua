-- Cartomancer compatibility
-- Fix flames on bignum blind size
if #SMODS.find_mod('cartomancer') ~= 0 then
	function Cartomancer.get_flames_intensity(preview)
		local value
		if preview then
			value = Cartomancer._INTERNAL_gasoline
		elseif Cartomancer.SETTINGS.flames_relative_intensity then
			if (type(SMODS.get_scoring_parameter('chips', true)) == 'number' or type(SMODS.get_scoring_parameter('chips', true)) == 'table') and (type(SMODS.get_scoring_parameter('mult', true)) == 'number' or type(SMODS.get_scoring_parameter('mult', true)) == 'table') then
				G.ARGS.score_intensity.true_score = to_big(G.GAME.current_scoring_calculation:func(SMODS.get_scoring_parameter('chips', true), SMODS.get_scoring_parameter('mult', true), true))
			else
				G.ARGS.score_intensity.true_score = to_big(0)
			end
			value = math.min(500, math.max(0., math.log(G.ARGS.score_intensity.true_score/to_big(G.ARGS.score_intensity.required_score) + 5, 5)))
		else
			value = math.max(0., math.log(G.ARGS.score_intensity.earned_score, 5) - 2)
		end
		if value == math.huge or not value or value == nan then
			value = big_numbah
		end

		if Cartomancer.SETTINGS.flames_intensity_vanilla then
			return value
		end
		return math.min(math.max(
			math.min(value, Cartomancer.SETTINGS.flames_intensity_max),
			Cartomancer.SETTINGS.flames_intensity_min
		), 150)
	end
end