-- this is just for CardSleeves, tutorials and notifications
return {
	descriptions = {
		Mod = {
			mayhem = {
				name = 'Mayhem', 
				text = {
					--[["{C:dark_edition}Fuse{} compatible {C:attention}Jokers{} in {C:attention}long fusion chains{}", 
					"to get new {C:may_ethereal,E:1}much more powerful{} Jokers and {C:mult,E:1}break Balatro{}",
					"{C:may_col_mayhem_gradient}Mayhem{} {C:mult,E:1}will however fight back{}", 
					"Play on {C:may_col_eternum_green,E:1}Eternum Mode{} if you want to", 
					"{C:mult,E:1}watch the game crumble{} {C:dark_edition,E:1}unimpeded{}",]] 
					"Ever thought {C:attention,E:1}Balatro{} runs are {C:mult}too short{}?", 
					"{C:may_col_mayhem_gradient,E:1}Mayhem{} adds {C:green}elaborate{} {C:attention}Joker{} {C:may_col_instability}fusion chains{}, resulting in", 
					"{C:may_surreal,E:1}omnipotent{} {C:attention}Jokers{} capable of scoring {C:may_interdimensional,E:1}incomprehensibly large numbers{}",
					"That, however, {C:mult}doesn't{} mean you will not face any {C:mult,E:1}challenges{}",
					"Play on {C:may_col_eternum_green,E:1}Eternum{} mode if you just want to watch the game {C:attention,E:1}burn{}", 
					" ",
					"{C:green,E:1,s:2}Thanks for playing!{}", 
				} 
			}, 
		}, 
		Spectral = {
			c_cry_pointer = {
				name = "POINTER://",
				text = {
					"Create a card",
					"of {C:cry_code}your choice",
					"{C:inactive,s:0.8}(Mythic and above Jokers, Yotta Cards and",
					"{C:inactive,s:0.8}Empowered Consumables excluded){}",
				},
			},
		},
		Sleeve = {
			sleeve_may_orange_sleeve = {
				name = "Orange Sleeve",
				text = { "{C:attention}+#1# Hand Size{}" }
			},
			sleeve_may_orange_sleeve_alt = {
				name = "Orange Sleeve",
				text = { "{C:attention}+#1# Hand Size{}" }
			},
			
			sleeve_may_purple_sleeve = {
				name = "Purple Sleeve",
				text = { 
					"You can select {C:green}1 more card{}",
					"from {C:attention}Booster Packs{}"
				}
			},
			sleeve_may_purple_sleeve_alt = {
				name = "Purple Sleeve",
				text = { 
					"You can select {C:green}all cards{}",
					"from {C:attention}Booster Packs{}"
				}
			},
			
			sleeve_may_pink_sleeve = {
				name = "Pink Sleeve",
				text = { 
					"{X:attention,C:white}X#1#{} Blind size"
				}
			},
			sleeve_may_pink_sleeve_alt = {
				name = "Pink Sleeve",
				text = { 
					"{X:attention,C:white}X0.5{} Boss Blind size"
				}
			},
			
			sleeve_may_lime_sleeve = {
				name = "Lime Sleeve",
				text = { 
					"{C:attention}+1{} {C:green}Voucher{} slot in {C:atention}shop{}"
				}
			},
			sleeve_may_lime_sleeve_alt = {
				name = "Lime Sleeve",
				text = { 
					"{C:attention}+1{} {C:green}Voucher{} slot",
					"in {C:atention}shop{}",
					"Apply {C:attention}Copper Seal{} to {C:attention}all cards{} in deck",
					"when {C:attention}blind{} is {C:attention}selected{}",
				}
			},
			
			sleeve_may_brown_sleeve = {
				name = "Brown Sleeve",
				text = { 
					"{C:attention}Playing cards{} give {X:attention,C:white}X10{} more {C:chips}Chips{}"
				}
			},
			sleeve_may_brown_sleeve_alt = {
				name = "Brown Sleeve",
				text = { 
					"{C:attention}Playing cards{} give {X:chips,C:white}XChips{} based on their rank"
				}
			},
			
			sleeve_may_gray_sleeve = {
				name = "Gray Sleeve",
				text = { 
					"All {C:attention}cards{} in deck start with",
					"a {C:attention}random{} {C:dark_edition}seal{}",
				}
			},
			sleeve_may_gray_sleeve_alt = {
				name = "Gray Sleeve",
				text = { 
					"All {C:attention}cards{} in deck start with",
					"a {C:attention}random{} {C:dark_edition}seal{}",
					"When {C:attention}blind{} is {C:attention}selected{}, apply {C:dark_edition}seals{}",
					"to {C:attention}all cards{} in deck {C:attention}without{} one",
				}
			},
			
			sleeve_may_turqoise_sleeve = {
				name = "Turqoise Sleeve",
				text = { 
					"All {C:attention}cards{} in {C:attention}shop{} are",
					"{C:attention}25%{} {C:money}cheaper{}"
				}
			},
			sleeve_may_turqoise_sleeve_alt = {
				name = "Turqoise Sleeve",
				text = { 
					"All {C:attention}cards{} in {C:attention}shop{} are",
					"{C:attention}25%{} {C:money}cheaper{}",
					"Bought {C:attention}items{} have a fixed {C:green}1 in 5{} chance",
					"to be {C:attention}refunded{}"
				}
			},
			
			sleeve_may_blurple_sleeve = {
				name = "Blurple Sleeve",
				text = { 
					"Start run with a {C:attention}random{}",
					"{X:mult,C:white}Rare{} {C:attention}joker{}"
				}
			},
			sleeve_may_blurple_sleeve_alt = {
				name = "Blurple Sleeve",
				text = { 
					"Start run with a {C:attention}random{}",
					"{X:legendary,C:white}Legendary{} {C:attention}joker{}"
				}
			},
			
			sleeve_may_monochrome_sleeve = {
				name = "Monochrome Sleeve",
				text = { 
					"Start run with {C:attention}5{} {C:dark_edition}Negative{}",
					"copies of a {C:attention}random{} {X:green,C:white}Uncommon{} {C:attention}joker{}"
				}
			},
			sleeve_may_monochrome_sleeve_alt = {
				name = "Monochrome Sleeve",
				text = { 
					"When {C:attention}Boss Blind{} is {C:attention}selected{},",
					"create a {C:attention}random{} {C:dark_edition}Negative{}",
					"{X:uncommon,C:white}Uncommon{} {C:attention}Joker{}"
				}
			},
			
			sleeve_may_rainbow_sleeve = {
				name = "Rainbow Sleeve",
				text = { 
					"{C:attention}+1{} {C:chips}hand{}, {C:mult}discard{} and {C:attention}hand size{}",
					"{X:attention,C:white}X0.9{} blind size",
					"Start with an {C:attention}extra{} {C:money}$10{}",
					"and a random {X:mult,C:white}Rare{} {C:attention}Joker{}",
				}
			},
			sleeve_may_rainbow_sleeve_alt = {
				name = "Rainbow Sleeve",
				text = { 
					"All {C:attention}cards{} in {C:attention}shop{} are",
					"{C:attention}25%{} {C:money}cheaper{}",
					"{C:attention}Playing cards{} give {X:attention,C:white}X10{} more {C:chips}Chips{}",
					"All {C:attention}cards{} in deck start with",
					"a {C:attention}random{} {C:dark_edition}seal{}",
					"You can select {C:green}1 more card{}",
					"from {C:attention}Booster Packs{}",
					"Earn {C:money}$1{} per {C:mult}discard{} at the",
					"{C:attention}end of round{}"
				}
			},
			
			sleeve_may_aaaa_sleeve = {
				name = "AAAA Sleeve",
				text = { 
					"Start run with {C:attention}AAAA{}",
					"and a deck of only {C:attention}Aces{}",
				}
			},
			sleeve_may_aaaa_sleeve_alt = {
				name = "AAAA Sleeve",
				text = { 
					"Start run with {C:dark_edition}Acum{}",
				}
			},
			
			sleeve_may_unstable_sleeve = {
				name = "Unstable Sleeve",
				text = { 
					"Start run with {C:dark_edition}Universal Collapse{}",
				}
			},
			sleeve_may_unstable_sleeve_alt = {
				name = "Unstable Sleeve",
				text = { 
					"{C:spectral}Genesis{} will {C:attention}not{}",
					"{C:attention}increase Ante{} when used"
				}
			},
			
			sleeve_may_stellar_sleeve = {
				name = "Stellar Sleeve",
				text = { 
					"When {C:attention}Blind{} is {C:attention}selected{}",
					"create a {C:dark_edition}Negative{} copy of {C:attention}Matakka{}",
				}
			},
			sleeve_may_stellar_sleeve_alt = {
				name = "Stellar Sleeve",
				text = { 
					"{C:purple}Poker Hands{} gain {X:purple,C:white}X2{}",
					"{C:may_interdimensional}Level{} Mult & Chips",
					"when {C:planet}leveled up{}",
				}
			},
			
			sleeve_may_mythic_sleeve = {
				name = "Mythic Sleeve",
				text = { 
					"Start run with a random",
					"{X:may_mythic,C:white}Mythic{} {C:attention}Joker{}",
				}
			},
			sleeve_may_mythic_sleeve_alt = {
				name = "Mythic Sleeve",
				text = { 
					"{X:may_mythic,C:white}Mythic{} {C:attention}Jokers{} give {X:mult,C:white}^^3{} Mult",
				}
			},
			
			sleeve_may_transcendent_sleeve = {
				name = "Transcendent Sleeve",
				text = { 
					"Start run with a random",
					"{X:dark_edition,C:white}Transcendent{} {C:attention}Joker{}",
					"{C:chips}-1 hand{} and {C:mult}discard{}"
				}
			},
			sleeve_may_transcendent_sleeve_alt = {
				name = "Transcendent Sleeve",
				text = { 
					"Start run with an additional random",
					"{X:may_interdimensional,C:white}Interdimensional{} {C:attention}Joker{}",
				}
			},
			
			sleeve_may_surreal_sleeve = {
				name = "Surreal Sleeve",
				text = { 
					"Start run with a random",
					"{X:may_surreal,C:white}Surreal{} {C:attention}Joker{}",
					"{C:chips}-2 hands{}"
				}
			},
			sleeve_may_surreal_sleeve_alt = {
				name = "Surreal Sleeve",
				text = { 
					"{C:spectral}Prestige{} has {C:green}no secondary effects{}"
				}
			},
			
			sleeve_may_interdimensional_sleeve = {
				name = "Interdimensional Sleeve",
				text = { 
					"Start run with a random",
					"{X:may_interdimensional,C:white}Interdimensional{} {C:attention}Joker{}",
					"{C:chips}-1 hand{}, {C:mult}discard{}, {C:attention}Hand Size{} and {C:attention}Joker Slot{}"
				}
			},
			sleeve_may_interdimensional_sleeve_alt = {
				name = "Interdimensional Sleeve",
				text = { 
					"{C:spectral}Macrocosm{} creates",
					"{X:may_interdimensional,C:white}Interdimensional{} {C:attention}Jokers{}"
				}
			},
			
			sleeve_may_ethereal_sleeve = {
				name = "Ethereal Sleeve",
				text = { 
					"Start run with a random",
					"{X:may_ethereal,C:white}Ethereal{} {C:attention}Joker{}",
					"{C:chips}-2 hands{}, {C:mult}-2 discards{} and {C:attention}-3 joker slots{}",
				}
			},
			sleeve_may_ethereal_sleeve_alt = {
				name = "Ethereal Sleeve",
				text = { 
					"{C:attention}Disables{} the {C:mult}downsides{}",
					"of {C:dark_edition}Ethereal Deck{}"
				}
			},
			
			sleeve_may_power_sleeve = {
				name = "Power Sleeve",
				text = { 
					"{C:green}1 in 10{} chance to",
					"{C:attention}increase{} {C:dark_edition}score operator{} level by {C:attention}1{}",
					"after {C:attention}hand{} is {C:attention}played{}"
				}
			},
			sleeve_may_power_sleeve_alt = {
				name = "Power Sleeve",
				text = { 
					"When {C:attention}Boss Blind{} is {C:attention}selected{},",
					"{C:attention}increase{} {C:dark_edition}score operator{} level by {C:attention}1{}",
				}
			},
			
			sleeve_may_centurion_sleeve = {
				name = "Centurion Sleeve",
				text = { 
					"Start run with {C:attention,T:v_may_increment}Increment{},",
					"{C:attention,T:v_may_increase}Increase{}, {C:attention,T:v_may_stardust}Stardust{}",
					"and {C:attention,T:v_may_meteor}Meteor{}",
					"All {C:purple}Poker Hands{} start at",
					"{C:planet}Level{} {C:attention}3{} and with",
					"{X:purple,C:white}X2{} Mult & Chips",
					"{X:attention,C:white}X5{} {C:attention}Boss Blind{} Size",
				}
			},
			sleeve_may_centurion_sleeve_alt = {
				name = "Centurion Sleeve",
				text = { 
					"Start run with {C:attention,T:v_may_powerful}Powerful{},", 
					"{C:attention,T:v_may_unstoppable}Unstoppable{}, {C:attention,T:v_may_food_chain}Food Chain{} and", 
					"{C:attention,T:v_may_natural_selection}Natural Selection{}", 
					"{X:may_score,C:white}X2{} Score", 
					"{X:attention,C:white}X4{} {C:attention}Small Blind{} and", 
					"{C:attention}Big Blind{} Size"
				}
			},
		},
		Spectral = {
			c_cry_pointer = {
				name = "POINTER://",
				text = {
					"Create a card",
					"of {C:cry_code}your choice{}",
					"{C:inactive,s:0.8}(POINTER://, Rare Edition Cards, Exotic and above Jokers,",
					"Yotta Cards and Empowered Consumables excluded)",
				},
			},
		},
		Back = {
			b_cry_antimatter = {
				name = "Antimatter Deck",
				text = {
					"Applies the {C:legendary,E:1}upsides{}",
					"of {C:attention}every{} {C:spectral}Cryptid{} and",
					"{C:green}Vanilla{} deck",
				},
			},
		},
		Other = {
			may_modocation_tutorial = {
				name = "Modocation",
				text = {
					"aYb = aXb+(1+log10(a)Xa)",
					"{C:inactive}Idea by Superb Thing{}"
				},
			},
			may_ccd_tutorial = {
				name = "CCD (Consumable Card in Deck)",
				text = {
					"{C:dark_edition}CCDs{} are {C:attention}playing cards{}",
					"that have a {C:attention}consumable{}",
					"applied to them as",
					"an {C:dark_edition}Enhancement{}",
					"{C:attention}Using{} a {C:dark_edition}CCD{}",
					"{C:mult}removes{} it from {C:attention}your deck{}"
				},
			},
			may_level_multchips_tutorial = {
				name = "Level Mult/Chips",
				text = {
					"{C:may_ethereal}Level{} {C:mult}Mult{}/{C:chips}Chips{} is",
					"the {C:mult}Mult{}/{C:chips}Chips{} a", 
					"{C:purple}Poker Hand{} gains",
					"when it is {C:planet}leveled up{}"
				},
			},
			may_hand_score_tutorial = {
				name = "Poker Hand Score",
				text = {
					"If a {C:purple}Poker Hand{} has",
					"{C:may_score}Score{}, it is",
					"applied {C:attention}after scoring{},",
					"adding it over the {C:attention}initial{}",
					"{C:attention}points{} you earned"
				},
			},
			may_hand_dollars_tutorial = {
				name = "Poker Hand Dollars",
				text = {
					"If a {C:purple}Poker Hand{} has {C:money}Dollars{}",
					"you {C:green}earn{} them as",
					"{C:money}money{} {C:attention}before scoring{}",
					"if you {C:attention}play{}",
					"that {C:purple}Poker Hand{}"
				},
			},
			may_interest_tutorial = {
				name = "Interest",
				text = {
					"{C:money}Interest{} is the number of", 
					"dollars you gain per {C:money}$5{}",
					"you have at {C:money}cashout{}", 
					"{C:attention}Considered{} money when calculating", 
					"{C:money}Interest{} is {C:mult}capped{} at your {C:money}Interest Cap{}", 
					"{C:inactive}3.2 Interest, $15 owned -> +$9.6{}"
				},
			},
			may_ultrablind = {
				name = "UltraBlind",
				text = {
					"Special powerful {C:attention}Boss Blind{} that can appear",
					"after {C:attention}Ante 8{}",
					"{C:inactive,s:0.7,E:1}Be careful...{}"
				},
			},
			
			may_enf_cosmic = {
				name = "Consumable Cosmic Ability",
				text = {
					"Creates {C:dark_edition}Negative{} copies of the {C:planet}Planet Cards{}", 
					"corresponding to the {C:purple}Poker Hands{}", 
					"that are {C:planet}leveled up{}"
				},
			},
			may_enf_inverted = {
				name = "Consumable Inverted Ability",
				text = {
					"{C:money}+0.01 Interest{}"
				},
			},
			may_enf_twilight = {
				name = "Consumable Twilight Ability",
				text = {
					"{C:purple}Mult & Chips{} will {C:mult}not{} {C:green}scale{}"
				},
			},
			may_enf_laminated = {
				name = "Consumable Laminated Ability",
				text = {
					"Considered {C:attention}card area{} is", 
					"your {C:attention}Consumable Slots{}"
				},
			},
			
			may_enf_hydra = {
				name = "Hydra Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_moon = {
				name = "Moon Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_satellite = {
				name = "Satellite Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_galileo = {
				name = "Galileo Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_sun = {
				name = "Sun Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_dysnomia = {
				name = "Dysnomia Edition Ability",
				text = {
					"Created {C:attention}cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_matakka = {
				name = "Matakka Edition Ability",
				text = {
					"Created {X:legendary,C:white}Legendary{} {C:planet}Planet Cards{} have", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_chronos = {
				name = "Chronos Edition Ability",
				text = {
					"Triggered {C:planet}Planet Cards{} gain", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			}, 
			may_enf_umbriel = {
				name = "Umbriel Edition Ability",
				text = {
					"Creates the {C:attention}Tag{} corresponding", 
					"to {C:attention}card's{} {C:dark_edition}Edition{}", 
				},
			}, 
			may_enf_gersemi = {
				name = "Gersemi Edition Ability",
				text = {
					"Enhanced {C:attention}cards{} will gain", 
					"{C:attention}this cards{} {C:dark_edition}Edition{}"
				},
			},
			may_enf_rings = {
				name = "Ring Systems Edition Ability",
				text = {
					"{C:dark_edition}Edition{} will be {C:green}applied{}",
					"to next {C:purple}Poker Hand{} {C:planet}leveled up{}",
				},
			},
		},
	},
	dictionary = {
		may_cry_plus_edition_card = '+1 Edtion Card',
		may_cry_plus_retro_card = '+1 Retro Card',
		may_cry_plus_yotta = '+1 Yotta Card',
		may_cry_plus_voucher = '+1 Voucher',
		may_cry_plus_booster = '+1 Booster Pack',
		may_cry_plus_universal = '+1 Consumable',
		may_cry_plus_fusable = '+1 Fusable',
		v_dictionary = {
			mult_xp = "X#1# XP",
			hyp_xp = "#1##2# XP",
		},
	}, 
	misc = {
		dictionary = {
			may_notif_slaythejokers_1 = 'Slay the Jokers warning', 
		    may_notif_stj_d1 = 'If you are a content creator,', 
		    may_notif_stj_d2 = 'make sure your STJ is at the absolute latest commit', 
		    may_notif_stj_d3 = 'and not a stable release (eg. 0.2) as it is not compatible.', 
			may_notif_stj_d4 = 'You may also want to check the "For content creators" section on Mayhem\'s repository.',
			
			may_notif_cryptid_1 = 'Cryptid notice', 
		    may_notif_cry_d1 = 'Mayhem may not work as intended with Cryptid, expect bugs and crashes.', 
		    may_notif_cry_d2 = 'Playing both at the same time is also not recommended', 
		    may_notif_cry_d3 = 'if you want the intended experience, despite the cross-mod.',
			
			may_notif_amulet_1 = 'Amulet/cdataman notice', 
		    may_notif_amulet_d1 = 'Mayhem is compatible with Amulet/cdataman,', 
		    may_notif_amulet_d2 = 'however using it instead of Talisman is not recommended as', 
		    may_notif_amulet_d3 = 'certain Mayhem features will not work as intended (eg Transcendence).',
			
			may_notif_smods_1 = 'Steamodded notice', 
		    may_notif_smods_d1 = 'Mayhem is incredibly unstable with Steamodded 1221a.', 
		    may_notif_smods_d2 = 'It is recommended you use SMODS 1224a and above,', 
		    may_notif_smods_d3 = 'as crashes will be frequent.',
			
			may_notif_welcome_1 = 'Welcome to Mayhem!', 
		    may_notif_welcome_d1 = 'This is your first time playing Mayhem! Thanks!', 
			may_notif_welcome_d2 = 'Until a proper tutorial is added, you should consult the wiki', 
			may_notif_welcome_d3 = 'to understand the mod\'s mechanics and settings.', 
		    may_notif_welcome_d4 = 'The mod has a lot of crazy effects, so specific vanilla configurations', 
		    may_notif_welcome_d5 = 'are recommended. Would you like to set them as such?', 
			
			may_n_yes = 'Yes', 
			may_n_no = 'No',
		}
	}
}