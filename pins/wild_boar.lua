-- == WILD BOAR
-- == Mult and mult cards

local stuffToAdd = {}

-- Kewl Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "kewlLine",
	key = "kewlLine",
	config = {extra = {handSize = -2, mult = 24}},
	pos = {x = 1, y = 1},
	loc_txt = {
		name = 'Kewl Line',
		text = {
			"{C:attention}#1#{} hand size",
			"Scored {C:attention}8s{} give {C:mult}+#2#{} Mult",
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSize, center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() == 8
		and context.cardarea == G.play then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end
})

-- Dope Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "dopeLine",
	key = "dopeLine",
	config = {extra = {}},
	pos = {x = 2, y = 1},
	loc_txt = {
		name = 'Dope Line',
		text = {
			"At end of round, {C:attention}destroy{}",
			"this joker and all cards held",
			"in hand become {C:attention}Mult Cards{}"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			for k, v in ipairs(G.hand.cards) do
				v:set_ability(G.P_CENTERS.m_mult, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
			end
			destroyCard(card)
			return {
				message = 'Dope!',
				colour = G.C.RED,
				delay = 1
			}
		end
	end
})

-- Wild Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "wildLine",
	key = "wildLine",
	config = {extra = {}},
	pos = {x = 3, y = 1},
	loc_txt = {
		name = 'Wild Line',
		text = {
			"Retrigger all",
			"{C:attention}Mult Cards{}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.other_card.ability.effect == "Mult Card"
		and context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
	end
})

-- Fly Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "flyLine",
	key = "flyLine",
	config = {extra = {mult = 0, multGain = 25, progress = "_ _ _ _", 
		progressList = {spades = false, clubs = false, hearts = false, diamonds = false}
	}},
	pos = {x = 4, y = 1},
	loc_txt = {
		name = 'Fly Line',
		text = {
			--"Gains {C:mult}+#1#{} Mult after playing",
			--"{C:attention}flushes{} of all four suits",
			--"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			--"{C:inactive}(Progress: {V:1}#3# {V:2}#4# {V:3}#5# {V:4}#6#{C:inactive}){}",
			"This joker gains {C:mult}+#1#{} Mult",
			"after 4 {C:attention}Flushes{} of",
			"different suits are played",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			"{C:inactive}(Progress: {V:1}#3# {V:2}#4# {V:3}#5# {V:4}#6#{C:inactive}){}",
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {
			center.ability.extra.multGain,
			center.ability.extra.mult,
			center.ability.extra.progressList.spades and "S" or "_",
			center.ability.extra.progressList.hearts and "H" or "_",
			center.ability.extra.progressList.clubs and "C" or "_",
			center.ability.extra.progressList.diamonds and "D" or "_",
			colours = {
				center.ability.extra.progressList.spades and G.C.BLACK or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.hearts and G.C.RED or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.clubs and G.C.BLACK or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.diamonds and G.C.RED or G.C.UI.TEXT_INACTIVE,
			}
		}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Flush']) and not context.blueprint then
			local suit = ""
			local changed = false
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect ~= "Wild Card" then 
					if v:is_suit('Spades') then 
						card.ability.extra.progressList.spades = true
						changed = true
					end
					if v:is_suit('Hearts') then 
						card.ability.extra.progressList.hearts = true
						changed = true
					end
					if v:is_suit('Clubs') then 
						card.ability.extra.progressList.clubs = true
						changed = true
					end
					if v:is_suit('Diamonds') then 
						card.ability.extra.progressList.diamonds = true
						changed = true
					end
				end
			end
			local pList = card.ability.extra.progressList
			if pList.spades and pList.hearts and pList.clubs and pList.diamonds then
				card.ability.extra.progressList.spades = false
				card.ability.extra.progressList.clubs = false
				card.ability.extra.progressList.hearts = false
				card.ability.extra.progressList.diamonds = false
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
				return {
					message = "Upgrade!",
					color = G.C.MULT,
					card = self
				}
			elseif changed then 
				return {
					message = "Progress!",
					card = self
				}
			end
		end
	end
})

-- Fresh Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "freshLine",
	key = "freshLine",
	config = {extra = {mult = 0, multGain = 8}},
	pos = {x = 5, y = 1},
	loc_txt = {
		name = 'Fresh Line',
		text = {
			"{C:mult}+#1#{} Mult for each",
			"discarded {C:attention}face{} card,",
			"resets each round",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.multGain, center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.discard
		and not context.other_card.debuff
		and context.other_card:is_face() and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
			return {
				message = localize('k_upgrade_ex'),
				card = self,
				colour = G.C.MULT
			}
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint and card.ability.extra.mult > 0 then
			card.ability.extra.mult = 0
			return {
				message = localize('k_reset'),
				colour = G.C.RED
			}
		end
	end
})

-- Microcosmic Pull
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "microcosmicPull",
	key = "microcosmicPull",
	config = {extra = {cardsNeeded = 1, mult = 20}},
	pos = {x = 6, y = 1},
	loc_txt = {
		name = 'Microcosmic Pull',
		text = {
			"If you play a hand with",
			"exactly {C:attention}#1#{} card#3#, {C:mult}+#2#{} Mult",
			"and {C:attention}+1{} to cards needed",
			"to trigger this effect",
			"{C:inactive}(Rolls over after 5){}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.cardsNeeded, center.ability.extra.mult, center.ability.extra.cardsNeeded == 1 and "" or "s"}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and #context.full_hand == card.ability.extra.cardsNeeded then
			card.ability.extra.cardsNeeded = card.ability.extra.cardsNeeded + 1
			if card.ability.extra.cardsNeeded > 5 then
				card.ability.extra.cardsNeeded = 1
			end
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
	end
})

-- Lazy Bomber
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lazyBomber",
	key = "lazyBomber",
	config = {extra = {mult = 30, timerMax = 3, timer = 0}},
	pos = {x = 8, y = 1},
	loc_txt = {
		name = 'Lazy Bomber',
		text = {
			--"{C:mult}+#1#{} Mult exactly {C:attention}#2#{} hands",
			--"after using a {C:tarot}tarot{} card",
			"When you use a {C:tarot}Tarot{} card,",
			"starts a countdown for {C:attention}#2#{} hands",
			"{C:mult}+#1#{} Mult on the hand the countdown ends",
			"{C:inactive}(#3#){}"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {
			center.ability.extra.mult,
			center.ability.extra.timerMax,
			center.ability.extra.timer == 1 and "Active!" or (center.ability.extra.timer == 0 and "Inactive!" or (center.ability.extra.timer-1).." hands remaining") }}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.timer == 1 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.cardarea == G.jokers and context.after and card.ability.extra.timer > 0 and not context.blueprint then
			card.ability.extra.timer = card.ability.extra.timer - 1
			if card.ability.extra.timer == 1 then
				local eval = function(card) return (card.ability.extra.timer == 1) end
				juice_card_until(card, eval, true)
				return {
					message = "Gonna blow!"
				}
			end
			if card.ability.extra.timer == 0 then
				return {
					message = "Inactive!"
				}
			end
			return {
				message = (card.ability.extra.timer-1).." remaining"
			}
		end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == "Tarot" then
				card.ability.extra.timer = card.ability.extra.timerMax
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = (card.ability.extra.timer-1).." remaining"})
			end
		end
	end
})

-- Diss
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "diss",
	key = "diss",
	config = {extra = {mult = 0, multGain = 30}},
	pos = {x = 7, y = 1},
	loc_txt = {
		name = 'Diss',
		text = {
			"This joker gains {C:mult}+#1#{} Mult",
			"if played hand triggers",
			"the {C:attention}Boss Blind{} effect",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	rarity = 3,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.multGain, center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and (card.ability.extra.mult > 0 or G.GAME.blind.triggered) then
			if G.GAME.blind.triggered then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
			end
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
	end
})

return{stuffToAdd = stuffToAdd}