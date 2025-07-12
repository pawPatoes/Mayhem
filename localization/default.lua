-- this is just for CardSleeves and overwriting other descriptions
return {
    descriptions = {
		Spectral = {
			c_cry_pointer = {
				name = "POINTER://",
				text = {
					"Create a card",
					"of {C:cry_code}your choice",
					"{C:inactive,s:0.8}(Mythic and above Jokers, Yotta Cards and",
					"Empowered Consumables excluded)",
				},
			},
		},
		Joker = {
			j_jolly = {
				name = "Jolly Joker",
				text = {
					"{C:mult}+#1#{} Mult if played",
					"hand contains",
					"a {C:attention}Pair{}",
					may.add_fusion_text('Universal Collapse')
				},
			},
			j_cry_circulus_pistoris = {
				name = "Circulus Pistoris",
				text = {
					"{X:dark_edition,C:white}^#1#{} Chips and {X:dark_edition,C:white}^#1#{} Mult",
					"if {C:attention}exactly{} #2#",
					"hand#<s>2# remaining",
					may.add_fusion_text('Universal Collapse')
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
			may_ape_tutorial = {
				name = "Aperiotion",
				text = {
					"{C:attention}#1# = a#2#a{}",
					"{E:2,s:1.5}Examples{}",
					"{X:chips,C:white}#3#{} would preform",
					"{C:attention}#4#{} on {C:chips}Chips{} by {C:chips}Chips{} (Chips#4#Chips)"
				},
			},
			may_expofact_tutorial = {
				name = "Exponential Factorial",
				text = {
					"a^! = a^a-1^a-2^a-3...",
					"{s:2}Examples{}",
					"5^! = 5^4^3^2",
				},
			},
			may_superfactorial_tutorial = {
				name = "Superfactorial (Pickover)",
				text = {
					"a$ = a!^^a!",
					"{s:2}Examples{}",
					"5$ = 5!^^5! = 120^^120",
				},
			},
			may_factorexation_tutorial = {
				name = "Factorexation",
				text = {
					"a/ = a!^^2",
					"{s:2}Examples{}",
					"5/ = 5!^^2 = 120^^2",
				},
			},
			may_nest_fact_tutorial = {
				name = "Nested Factorial",
				text = {
					"Mayhem represents nested factorials",
					"as a!!!!! (correctly, it should be ((((a!)!)!)!)!)",
					"If there are too many factorials,",
					"the number of factorials is added",
					"in a parentheses after the symbol",
					"{s:2}Examples{}",
					"5!(10) = 5!!!!!!!!!! (10 factorials)",
					"{C:attention}This applies to all other factorial-based operations{}"
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
		may_cry_plus_universal = '+1 Consumable/Voucher',
		v_dictionary = {
            mult_xp = "X#1# XP",
			hyp_xp = "#1##2# XP",
        },
	}
}