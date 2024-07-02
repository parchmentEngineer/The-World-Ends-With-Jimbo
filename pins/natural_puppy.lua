-- == NATURAL PUPPY
-- == Playing card obtaining and buffinggg

local stuffToAdd = {}

-- Cutie Beam
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "cutieBeam",
	key = "cutieBeam",
	config = {extra = {}},
	pos = {x = 1, y = 9},
	loc_txt = {
		name = 'Cutie Beam',
		text = {
			"Played {C:attention}Wild Cards{} become {C:dark_edition}Polychrome{}",
			"When you gain this joker, gain",
			"two {C:dark_edition}Negative{} {C:attention}Lovers{} cards"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect == "Wild Card" and not (v.edition and v.edition.polychrome) then 
					faces[#faces+1] = v
					v:set_edition({polychrome = true}, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			if #faces > 0 then 
				return {
					message = "Cutie!",
					colour = G.C.CHIPS,
					card = self
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function() 
				for i=1,2 do
					local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_lovers')
					card:set_edition({negative = true}, true)
					card:add_to_deck()
					G.consumeables:emplace(card) 
				end
				return true
			end
		}))
	end
})

-- Playmate Beam
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "playmateBeam",
	key = "playmateBeam",
	config = {extra = {lastPlayed = 0, lastPlayedValue = 0}},
	pos = {x = 2, y = 9},
	loc_txt = {
		name = 'Playmate Beam',
		text = {
			"Cards in {C:attention}Standard Packs{}",
			"are the same rank as",
			"your last played {C:attention}High Card{}",
			"{C:inactive}(Currently: {C:attention}#1#{C:inactive}){}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.lastPlayed > 0 and center.ability.extra.lastPlayedValue or "None"}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.scoring_name == "High Card" then
				card.ability.extra.lastPlayed = context.other_card:get_id()
				card.ability.extra.lastPlayedValue = context.other_card.base.value
				G.GAME.twewy_playmate_beam = context.other_card.base.value
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.twewy_playmate_beam = 0
	end
})

-- Wonder Magnum
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "wonderMagnum",
	key = "wonderMagnum",
	config = {extra = {threeFound = false}},
	pos = {x = 3, y = 9},
	loc_txt = {
		name = 'Wonder Magnum',
		text = {
			"The first time you score",
			"a {C:attention}3{} each round, create",
			"{C:attention}3{} temporary copies of it"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and context.other_card:get_id() == 3 and not card.ability.extra.threeFound then
			if not context.blueprint then
				card.ability.extra.threeFound = true
			end
			G.deck.config.wonderMagnum = G.deck.config.wonderMagnum or {}
			for i = 1, 3 do
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					local _card = copy_card(context.other_card, nil, nil, 1)
					_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, _card)
					G.hand:emplace(_card)
					_card:start_materialize(nil, _first_dissolve)
					table.insert(G.deck.config.wonderMagnum, _card.unique_val)
					playing_card_joker_effects(new_cards)
				return true end }))
			end
			--card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Copied"})
		end
		if context.end_of_round and context.individual and not context.blueprint then
			card.ability.extra.threeFound = false
		end
	end
})

-- Innocence Beam
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "innocenceBeam",
	key = "innocenceBeam",
	config = {extra = {}},
	pos = {x = 5, y = 9},
	loc_txt = {
		name = 'Innocence Beam',
		text = {
			"When you score an {C:attention}unenhanced{}",
			"card, create a temporary copy",
			"of it with a random {C:attention}enhancement{}"
		}
	},
	rarity = 3,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and context.other_card.ability.effect == "Base" then
			G.deck.config.wonderMagnum = G.deck.config.wonderMagnum or {}
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
				local _card = copy_card(context.other_card, nil, nil, 1)
				local _abilities = {}
					for _, v in pairs(G.P_CENTERS) do
						if v.set == "Enhanced" then table.insert(_abilities, v)
					end
				end
				_card:set_ability(pseudorandom_element(_abilities, pseudoseed('innocenceBeam')), nil, false) 
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.hand:emplace(_card)
				_card:start_materialize(nil, _first_dissolve)
				table.insert(G.deck.config.wonderMagnum, _card.unique_val)
				playing_card_joker_effects(new_cards)
			return true end }))
		end
	end
})

-- Natural Magnum
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "naturalMagnum",
	key = "naturalMagnum",
	config = {extra = {usesLeft = 4}},
	pos = {x = 4, y = 9},
	loc_txt = {
		name = 'Natural Magnum',
		text = {
			"The next {C:attention}#1#{} times you",
			"score a {C:attention}face card{}, make a",
			"permanent copy of that card"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.usesLeft}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and context.other_card:is_face()
		and not context.blueprint and card.ability.extra.usesLeft > 0 then
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
				local _card = copy_card(context.other_card, nil, nil, 1)
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.hand:emplace(_card)
				_card:start_materialize(nil, _first_dissolve)
				playing_card_joker_effects(new_cards)
			return true end }))
			card.ability.extra.usesLeft = card.ability.extra.usesLeft - 1
			if card.ability.extra.usesLeft == 0 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Used up!"})
				destroyCard(card)
			end
		end
	end
})

-- Superfine Beam
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "superfineBeam",
	key = "superfineBeam",
	config = {extra = {}},
	pos = {x = 6, y = 9},
	loc_txt = {
		name = 'Superfine Beam',
		text = {
			"When you discard an {C:attention}enhanced{}",
			"card, create a temporary {C:attention}Ace{}",
			"with the same {C:attention}enhancement{}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		if context.discard then
			G.deck.config.wonderMagnum = G.deck.config.wonderMagnum or {}
			if context.other_card.ability.effect ~= "Base" then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					new_suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('superfine'))
					local _card = create_card("Base", G.pack_cards, nil, nil, nil, true, nil, 'superfine')
					local new_card = G.P_CARDS[new_suit.."_A"]
					_card:set_base(new_card)
					_card:set_ability(G.P_CENTERS[context.other_card.config.center.key])
					_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, _card)
					G.hand:emplace(_card)
					_card:start_materialize(nil, _first_dissolve)
					table.insert(G.deck.config.wonderMagnum, _card.unique_val)
					playing_card_joker_effects(new_cards)
				return true end }))
			end
		end
	end
})

-- Love Me Tether
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "loveMeTether",
	key = "loveMeTether",
	config = {extra = {usedThisHand = false}},
	pos = {x = 7, y = 9},
	loc_txt = {
		name = 'Love Me Tether',
		text = {
			"All {C:hearts}Hearts{} held in hand",
			"gain the {C:attention}Enhancement{} of",
			"your leftmost scored {C:hearts}Heart{}"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:is_suit("Hearts")
		and not card.ability.extra.usedThisHand
		and context.cardarea == G.play then
			card.ability.extra.usedThisHand = true
			if context.other_card.ability.effect ~= "Base" then
				for _, v in ipairs(G.hand.cards) do
					if v:is_suit("Hearts") then
						G.E_MANAGER:add_event(Event({
						func = function()
							v:set_ability(G.P_CENTERS[context.other_card.config.center.key])
							v:juice_up()
							return true
						end
					}))
					end
				end
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			card.ability.extra.usedThisHand = false
		end
	end
})

return {stuffToAdd = stuffToAdd}