-- More Nopeus speeds

function G.UIDEF.nopeus_options()
	local speeds = create_option_cycle({label = localize('b_set_gamespeed'), scale = 0.8, options = {0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.5, 3, 3.5, 4, 8, 16, 32, 64, 128, 256, 512, 800, 1024, 1500, 2048, 3000, 5096, 8000, 10192}, opt_callback = 'change_gamespeed', current_option = (
		G.SETTINGS.GAMESPEED == 0.25 and 1 or
		G.SETTINGS.GAMESPEED == 0.5 and 2 or
		G.SETTINGS.GAMESPEED == 0.75 and 3 or
		G.SETTINGS.GAMESPEED == 1 and 4 or
		G.SETTINGS.GAMESPEED == 1.25 and 5 or
		G.SETTINGS.GAMESPEED == 1.5 and 6 or
		G.SETTINGS.GAMESPEED == 1.75 and 7 or
		G.SETTINGS.GAMESPEED == 2 and 8 or
		G.SETTINGS.GAMESPEED == 2.5 and 9 or
		G.SETTINGS.GAMESPEED == 3 and 10 or
		G.SETTINGS.GAMESPEED == 3.5 and 11 or
		G.SETTINGS.GAMESPEED == 4 and 12 or
		G.SETTINGS.GAMESPEED == 8 and 13 or
		G.SETTINGS.GAMESPEED == 16 and 14 or
		G.SETTINGS.GAMESPEED == 32 and 15 or
		G.SETTINGS.GAMESPEED == 64 and 16 or
		G.SETTINGS.GAMESPEED == 128 and 17 or
		G.SETTINGS.GAMESPEED == 256 and 18 or
		G.SETTINGS.GAMESPEED == 512 and 19 or
		G.SETTINGS.GAMESPEED == 800 and 20 or
		G.SETTINGS.GAMESPEED == 1024 and 21 or
		G.SETTINGS.GAMESPEED == 1500 and 22 or
		G.SETTINGS.GAMESPEED == 2048 and 23 or
		G.SETTINGS.GAMESPEED == 3000 and 24 or
		G.SETTINGS.GAMESPEED == 5096 and 25 or
		G.SETTINGS.GAMESPEED == 8000 and 26 or
		G.SETTINGS.GAMESPEED == 10192 and 27 or
		3
	)})
	return speeds
end