-- Decks

local stuffToAdd = {}

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "musRattus",
	key = "musRattus",
	config = {},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = "Mus Rattus",
		text = {
			"Begin with your {C:attention}2s{}",
			"as {C:dark_edition}Foil{} {C:blue}Bonus{} {C:attention}Cards{}"
		}
	},
	atlas = "jokers",
	apply = function(self)
	 G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v:get_id() == 2 then
						v:set_edition({foil = true}, true)
						v:set_ability(G.P_CENTERS.m_bonus, nil, true)
						--v:set_seal('Red', nil, true)
					end
                end
            return true
            end
        }))
	end
})

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "d+b",
	-- key = "d+b",
	-- config = {},
	-- pos = {x = 0, y = 11},
	-- loc_txt = {
		-- name = "D+B",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "tigrePunks",
	-- key = "tigrePunks",
	-- config = {},
	-- pos = {x = 0, y = 7},
	-- loc_txt = {
		-- name = "Tigre Punks",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "lapinAngelique",
	key = "lapinAngelique",
	config = {consumables = {'c_chariot', 'c_justice'}},
	pos = {x = 0, y = 4},
	loc_txt = {
		name = "Lapin Angelique",
		text = {
			"{C:attention}Steel{} and {C:attention}Glass{} cards",
			"gain {X:mult,C:white} X0.1 {} Mult every",
			"time they trigger",
			"Start with a {C:attention}Chariot{} and {C:attention}Justice{}"
		}
	},
	atlas = "jokers",
	apply = function(self)
		G.GAME.twewy_lapinAngelique = true
	end
})

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "dragonCouture",
	-- key = "dragonCouture",
	-- config = {},
	-- pos = {x = 0, y = 2},
	-- loc_txt = {
		-- name = "Dragon Couture",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "hipSnake",
	-- key = "hipSnake",
	-- config = {},
	-- pos = {x = 0, y = 6},
	-- loc_txt = {
		-- name = "Hip Snake",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "pegaso",
	-- key = "pegaso",
	-- config = {},
	-- pos = {x = 0, y = 5},
	-- loc_txt = {
		-- name = "Pegaso",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "sheepHeavenly",
	key = "sheepHeavenly",
	config = {consumables = {'c_deja_vu', 'c_deja_vu'}},
	pos = {x = 0, y = 10},
	loc_txt = {
		name = "Sheep Heavenly",
		text = {
			"After playing a card with",
			"a {C:red}Red Seal{}, move that",
			"seal to the leftmost",
			"card held in hand",
			"Start with two {C:attention}Deja Vus{}"
		}
	},
	atlas = "jokers",
	apply = function(self)
		G.GAME.twewy_sheepHeavenlyDeck = true
	end
})

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "juptierOfTheMonkey",
	key = "juptierOfTheMonkey",
	config = {consumables = {'c_emperor'}},
	pos = {x = 0, y = 3},
	loc_txt = {
		name = "Jupiter of the Monkey",
		text = {
			"Reroll all held {C:tarot}Tarot{}",
			"cards into new random",
			"{C:tarot}Tarot{} cards each round",
			"Start with an {C:attention}Emperor{}"
		}
	},
	atlas = "jokers",
	trigger_effect = function(self, args)
		if args.context == 'eval' and G.GAME.last_blind then
			for k,v in ipairs(G.consumeables.cards) do
				if v.ability.set == "Tarot" then
					G.E_MANAGER:add_event(Event({
						func = (function()
							local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'jupes')
							if v.edition and v.edition.negative then
								card:set_edition({negative = true}, true)
							end
							card:add_to_deck()
							G.consumeables:emplace(card)
							return true
						end)
					}))
					destroyCard(v)
				end
			end
		end
	end
})

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "pavoReal",
	key = "pavoReal",
	config = {joker_slot = -2},
	pos = {x = 0, y = 8},
	loc_txt = {
		name = "Pavo Real",
		text = {
			"{C:attention}-2{} Joker slots",
			"Gain a {C:dark_edition}Negative{} Tag",
			"after each {C:attention}Boss Blind{}",
			"if you have 6 or less Jokers"
		}
	},
	atlas = "jokers",
	trigger_effect = function(self, args)
		if args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss and #G.jokers.cards <= 6 then
			G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_negative'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
		end
	end
})

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "naturalPuppy",
	key = "naturalPuppy",
	config = {},
	pos = {x = 0, y = 9},
	loc_txt = {
		name = "Natural Puppy",
		text = {
			"{C:attention}Standard Packs{} contain",
			"only {C:attention}face cards{} and",
			"allow you to choose",
			"{C:attention}1{} more card"
		}
	},
	atlas = "jokers",
	apply = function(self)
		G.GAME.twewy_naturalPuppyDeck = true
	end
})

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "wildBoar",
	-- key = "wildBoar",
	-- config = {},
	-- pos = {x = 0, y = 1},
	-- loc_txt = {
		-- name = "Wild Boar",
		-- text = {
			-- "Effect"
		-- }
	-- },
	-- atlas = "jokers",
-- })

return{stuffToAdd = stuffToAdd}