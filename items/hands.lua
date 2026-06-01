-- Hands

SMODS.PokerHand {
    key = 'Royal Flush',
    chips = 110,
    mult = 9,
    l_chips = 60,
    l_mult = 10,
	visible = false,
    example = {
        { 'S_A', true },
        { 'S_K', true },
        { 'S_Q', true },
        { 'S_J', true },
        { 'S_T', true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Royal Flush',
            description = {
                'A Straight Flush that has an Ace and a 10'
            }
        }
    },
    evaluate = function(parts, hand)
        if next(parts._flush) and next(parts._straight) then
            local _strush = SMODS.merge_lists(parts._flush, parts._straight)
            local royal = true
            for j = 1, #_strush do
                local rank = SMODS.Ranks[_strush[j].base.value]
                royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
            end
            if royal then return {_strush} end
        end
    end,
}

may.bulwark_key = (#SMODS.find_mod('unik') ~= 0 and 'unik_bulwark' or 'may_Bulwark')

if #SMODS.find_mod('Cryptid') ~= 0 then 
	may.bulwark_key = 'cry_Bulwark'
end

if (#SMODS.find_mod('Cryptid') == 0) and (#SMODS.find_mod('unik') == 0) then 

SMODS.PokerHand {
	key = "Bulwark",
	visible = false,
	chips = 100,
	mult = 4,
	l_chips = 50,
	l_mult = 1,
	example = {
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
	},
    loc_txt = {
        ['en-us'] = {
            name = 'Bulwark',
            description = {
                '5 Stone Cards in the same hand',
                '{C:inactive}Taken from Cryptid{}'
            }
        }
    },
	evaluate = function(parts, hand)
		local stones = {}
		for k, v in ipairs(hand) do
			if v.config.center_key == "m_stone" then
				stones[#stones + 1] = v
			end
		end
		return #stones >= 5 and { stones } or {}
	end,
}

end