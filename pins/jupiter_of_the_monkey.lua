-- == JUPITER OF THE MONKEY
-- == Tarots, planets, and spectral cards

local stuffToAdd = {}

-- Zantestu
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "zantestu",
	key = "zantestu",
	config = {extra = {}},
	pos = {x = 2, y = 3},
	loc_txt = {
		name = 'Zantestu',
		text = {
			"When you play a {C:attention}Straight{}",
			"with all four suits, gain",
			"a {C:tarot}Tarot{} and a {C:planet}Planet{}"
		}
	},
	rarity = 1,
	cost = 2,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Straight']) then
			local suits = {
				['Hearts'] = 0,
				['Diamonds'] = 0,
				['Spades'] = 0,
				['Clubs'] = 0
			}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name ~= 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = 1
					elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = 1
					elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = 1
					elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = 1 end
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = 1 end
				end
			end
			if suits["Hearts"] > 0 and
			suits["Diamonds"] > 0 and
			suits["Spades"] > 0 and
			suits["Clubs"] > 0 then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.0,
						func = (function()
							local card = create_card('Tarot', G.consumeables)
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end)})
					)
				end
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit - 1 then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.0,
						func = (function()
							local card = create_card('Planet', G.consumeables)
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end)})
					)
				end
				return {
					message = "Gained!",
					colour = G.C.SECONDARY_SET.Tarot
				}
			end
		end
	end
})

-- Unjo
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "unjo",
	key = "unjo",
	config = {extra = {skipsNeeded = 3, skipsLeft = 3}},
	pos = {x = 1, y = 3},
	loc_txt = {
		name = 'Unjo',
		text = {
			"After skipping {C:attention}#1#{}",
			"{C:purple}Arcana Packs{}, gain",
			"a {C:spectral}Spectral Tag{}",
			"{C:inactive}(#2# remaining){}"
		}
	},
	rarity = 1,
	cost = 2,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.skipsNeeded, center.ability.extra.skipsLeft}}
	end,
	calculate = function(self, card, context)
		if context.skipping_booster and G.STATE == G.STATES.TAROT_PACK then
			card.ability.extra.skipsLeft = card.ability.extra.skipsLeft - 1
			if card.ability.extra.skipsLeft == 0 then
				card.ability.extra.skipsLeft = card.ability.extra.skipsNeeded
				G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_ethereal'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						card:juice_up(0.3, 0.4)
                        return true
                    end)
                }))
			else
				G.E_MANAGER:add_event(Event({ func = function() 
					card_eval_status_text(card, 'extra', nil, nil, nil, {
						message = card.ability.extra.skipsLeft.." left!",
						colour = G.C.ATTENTION,
						delay = 0.45, 
						card = card
					}) 
					return true
				end}))
			end
		end
	end
})

-- Mitama
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "mitama",
	key = "mitama",
	config = {extra = {upgrades = 2}},
	pos = {x = 3, y = 3},
	loc_txt = {
		name = 'Mitama',
		text = {
			"Playing a {C:attention}poker hand{}",
			"you have not played this",
			"game upgrades it {C:attention}#1#{} times"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.upgrades}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and G.GAME.hands[context.scoring_name].played == 1 then
			level_up_hand(card, context.scoring_name, false, card.ability.extra.upgrades)
		end
	end
})

-- Izanagi
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "izanagi",
	key = "izanagi",
	config = {extra = {}},
	pos = {x = 4, y = 3},
	loc_txt = {
		name = 'Izanagi',
		text = {
			"Apply a {C:red}Red Seal{} to",
			"the leftmost card of the",
			"first hand each round"
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
        if context.cardarea == G.jokers and context.before and not context.blueprint and G.GAME.current_round.hands_played == 0 then
			play_sound('tarot1')
			--G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
			context.scoring_hand[1]:set_seal('Red', nil, true)
			--return true end }))

			return {
				message = "Sealed!",
				colour = G.C.RED,
				card = self
			}
		end
	end
})

-- Masamune
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "masamune",
	key = "masamune",
	config = {extra = {}},
	pos = {x = 5, y = 3},
	loc_txt = {
		name = 'Masamune',
		text = {
			"Gain a {C:tarot}Tarot{} card when",
			"you score a {C:attention}Lucky Card{}"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card.ability.effect == "Lucky Card"
		and context.cardarea == G.play
		and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local card = create_card('Tarot', G.consumeables)
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						end
					return true
				end)})
			)
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Tarot!", colour = G.C.SECONDARY_SET.Tarot})
				
		end
	end
})

-- Onikiri
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "onikiri",
	key = "onikiri",
	config = {extra = {bonusSlots = 3}},
	pos = {x = 6, y = 3},
	loc_txt = {
		name = 'Onikiri',
		text = {
			"{C:attention}+#1#{} consumable slots"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.bonusSlots}}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({func = function()
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.bonusSlots
			return true end }))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({func = function()
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.bonusSlots
			return true end }))
	end
})

return {stuffToAdd = stuffToAdd}