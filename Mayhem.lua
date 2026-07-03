-- MAYHEM CORE

may = may or {}
may.version = SMODS.current_mod.version
may.info = { branch = 'main' }
SMODS.current_mod.debug_info = { Branch = may.info.branch } 
may.conf = SMODS.current_mod.config

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

-- Bulk load modules

assert(SMODS.load_file("items/color.lua"))()
print('MAYHEM: ITEM color.lua loaded!')

may.libs = {
	'fusion.lua', 'jenlib.lua', 'modtabs.lua', 'hooks.lua', 'miscbadges.lua', 'consumablevariants.lua',
    'hands.lua', 'timers.lua', 'calculationkeys.lua', 'omeganum.lua', 'unredeem.lua', 'pools.lua',
    'menu.lua', 'misc.lua', 'transcendence.lua', 'ability.lua', 'display.lua', 'notification.lua', 
	'noituus.lua', 'ui.lua', 'drawstep.lua',
}

for k, v in ipairs(may.libs) do
	assert(SMODS.load_file("lib/"..v))()
	print('MAYHEM: LIB '..v..' loaded!')
end

may.items = {
	'audio.lua', 'attribute.lua', 'atlas.lua', 'consumabletype.lua', 'miscbadge.lua', 
	'rarity.lua', 'pack.lua', 'shader.lua', 'edition.lua', 'enhancement.lua', 'seal.lua', 
	'dynatext.lua', 'consumable/upsidedown.lua', --[['consumable/ascended.lua',]] 'consumable/tarot.lua', 'consumable/planet.lua', 'consumable/spectral.lua',
	'consumable/yotta.lua', 'consumable/modifier.lua', 'consumable/retro.lua', 'blind.lua', 'voucher/tier1_2.lua', 'hands.lua', 
	'voucher/tier3.lua', 'voucher/tier4.lua', 'voucher/bundle.lua', 'voucher/special.lua', 'joker/common.lua', 'joker/uncommon.lua',
	'joker/rare.lua', 'joker/epic.lua', 'joker/legendary.lua', 'joker/paradoxical.lua', 'joker/mythic.lua', 'joker/ethereal.lua',
	'joker/prismatic.lua', 'joker/demiurgic.lua', --[['joker/opalescent.lua',]] 'joker/transcendent.lua', 'vanillatweaks.lua', 'debug.lua',
	'tag.lua', 'deck.lua', 'scoreoperator.lua', 'taintedblind.lua', 'display.lua', 'voucher/tier3.lua', 
	'consumable/misc.lua', --[['stake.lua',]]
}
-- Cross-mod
may.cross_mod = {
	'enf',
	'Fitxes',
	'Cryptid', 
	'cartomancer', 
	'GRM', 
	'BlindEditions', 
	--'CardSleeves', 
	'Spectrallib'
}

for k, v in pairs(may.cross_mod) do
	if #SMODS.find_mod(v) ~= 0 then 
		table.insert(may.items, 'cm/'..v..'.lua')
	end
end

for k, v in ipairs(may.items) do
	assert(SMODS.load_file("items/"..v))()
	print('MAYHEM: ITEM '..v..' loaded!')
end