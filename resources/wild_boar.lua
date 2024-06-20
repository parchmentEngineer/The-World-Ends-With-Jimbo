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
	cost = 5,
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
	cost = 4,
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
			"Gains {C:mult}+#1#{} Mult after playing",
			"{C:attention}flushes{} of all four suits",
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

return{stuffToAdd = stuffToAdd}