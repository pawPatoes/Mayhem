-- MAYHEM CORE

-- Mayhem is no longer in a single file (at last). Practically everything is now loaded in other files, so nothing much to see here.
if not (Big and Big.arrow) then
	error('!! OMEGANUM NOT ENABLED. PLEASE REMOVE MAYHEM FROM YOUR MODS FOLDER, SET TALISMAN TO OMEGANUM AND MOVE MAYHEM BACK.')
end

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		deck = true,
		discard = true,
	},
}

maxArrow = 1e308

may = may or {}

may.version = SMODS.current_mod.version

may.info = { branch = 'main' }

-- Config
-- global for convenience and cross-mod whatevers
may.conf = SMODS.current_mod.config

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

SMODS.current_mod.debug_info = { Branch = may.info.branch } 

-- Bulk load modules

assert(SMODS.load_file("items/color.lua"))()
print('MAYHEM: ITEM color.lua loaded! (this file is loaded first for priority reasons)')

may.libs = {
	'fusion.lua', 'jenlib.lua', 'modtabs.lua', 'hooks.lua', 'miscbadges.lua', 'consumablevariants.lua',
    'hands.lua', 'timers.lua', 'calculationkeys.lua', 'omeganum.lua', 'areahighlight.lua', 'pools.lua',
    'menu.lua', 'misc.lua', 'transcendence.lua', 'ability.lua', 'display.lua', 'notification.lua', 
	'morespeeds.lua', 'noituus.lua'
}

for k, v in pairs(may.libs) do
	assert(SMODS.load_file("lib/"..v))()
	print('MAYHEM: LIB '..v..' loaded!')
end

may.items = {
	'audio.lua', 'atlas.lua', 'consumabletype.lua', 'miscbadge.lua', 'rarity.lua', 
	'pack.lua', 'hands.lua', 'stake.lua', 'edition.lua', 'enhancement.lua', 'seal.lua', 
	'joker/init.lua', 'consumable/upsidedown.lua', --[['consumable/ascended.lua',]] 'consumable/tarot.lua', 'consumable/planet.lua', 'consumable/spectral.lua',
	'consumable/yotta.lua', 'consumable/modifier.lua', 'consumable/retro.lua', 'blind.lua', 'achievement.lua', 'voucher/tier1_2.lua',
	'voucher/tier3.lua', 'voucher/tier4.lua', 'voucher/bundle.lua', 'voucher/misc.lua', 'joker/common.lua', 'joker/uncommon.lua',
	'joker/rare.lua', 'joker/epic.lua', 'joker/legendary.lua', 'joker/mystery.lua', 'joker/mythic.lua', 'joker/transcendent.lua',
	'joker/interdimensional.lua', 'joker/ethereal.lua', 'joker/surreal.lua', 'joker/hyperascendant.lua', 'vanillatweaks.lua', 'debug.lua',
	'tag.lua', 'deck.lua', 'scoreoperator.lua', 'taintedblind.lua', 'display.lua', 'voucher/tier3.lua', 
	'consumable/misc.lua'
}
-- Cross-mod
if #SMODS.find_mod('enf') ~= 0 then table.insert(may.items, 'cm/Engulf.lua') end
if #SMODS.find_mod('Fitxes') ~= 0 then table.insert(may.items, 'cm/Fitxes.lua') end
if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then table.insert(may.items, 'cm/Cryptid.lua') end
if #SMODS.find_mod('cartomancer') ~= 0 then table.insert(may.items, 'cm/Cartomancer.lua') end
if #SMODS.find_mod('GRM') ~= 0 and may.conf.CM.Grim then table.insert(may.items, 'cm/Grim.lua') end
if #SMODS.find_mod('BlindEditions') ~= 0 and may.conf.CM.BlindEditions then table.insert(may.items, 'cm/BlindEditions.lua') end
if #SMODS.find_mod('CardSleeves') ~= 0 then table.insert(may.items, 'cm/CardSleeves.lua') end

for k, v in pairs(may.items) do
	assert(SMODS.load_file("items/"..v))()
	print('MAYHEM: ITEM '..v..' loaded!')
end

-- Load gamesets last to overwrite content
assert(SMODS.load_file("lib/gameset.lua"))()
print('MAYHEM: LIB gameset.lua loaded! (this has priority over all other files)')
