-- Gamesets

may.mode = may.conf.Mode

if may.conf.Mode == 2 then
	SMODS.current_mod.display_name = "Eternum"
	SMODS.current_mod.name = "Mayhem (Eternum Mode)"
	SMODS.current_mod.badge_colour = SMODS.Gradients.may_col_eternum_green
    assert(SMODS.load_file("items/gameset/eternum.lua"))()
	print('MAYHEM: ITEM gameset/eternum.lua loaded!')
else
    SMODS.current_mod.badge_colour = SMODS.Gradients.may_col_mayhem_gradient
end