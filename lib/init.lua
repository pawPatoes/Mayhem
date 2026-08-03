-- In(n)it

may.version = SMODS.current_mod.version
may.conf = SMODS.current_mod.config

SMODS.current_mod.badge_colour = SMODS.Gradients.may_col_mayhem_gradient
SMODS.current_mod.display_name = {"Mayhem", SMODS.current_mod.version}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		deck = true,
		discard = true,
	},
}

if Talisman.forced_features then
	Talisman.forced_features.force_omeganum()
	Talisman.forced_features.force_bigante()
else
	if not (Big and Big.arrow) then
		error('!! OMEGANUM NOT ENABLED. PLEASE REMOVE MAYHEM FROM YOUR MODS FOLDER, SET TALISMAN TO OMEGANUM AND MOVE MAYHEM BACK.')
	end
end

maxArrow = 1e308

-- These are used everywhere
function table_hasvalue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function may.get_position(tab, item)
    for k, v in pairs(tab) do 
        if v == item then
            return k
        end
    end
    return 0
end
