--- STEAMODDED HEADER
--- MOD_NAME: The World Ends With Jimbo
--- MOD_ID: TWEWY
--- PREFIX: twewy
--- MOD_AUTHOR: [parchmentEngineer]
--- MOD_DESCRIPTION: Adds jokers inspired by the brands and pins of The World Ends With You
--- BADGE_COLOUR: 814BA8

----------------------------------------------
------------MOD CODE -------------------------

local mod_path = ''..SMODS.current_mod.path
local stuffToAdd = {}

table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "blank",
	key = "blank",
	config = {extra = {}},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = 'Name',
		text = {
			"Text"
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

	end
})

-- Testing card back
table.insert(stuffToAdd, {
	object_type = "Back",
	name = "testing",
	key = "testing",
	config = {twetyTesting = true, consumables = {'c_hanged_man', 'c_justice'}},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = "Testing",
		text = {
			"Testing"
		}
	},
	atlas = "jokers"
})

-- Sprite Atlas
table.insert(stuffToAdd, {
	object_type = "Atlas",
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
})

-- == MUS RATTUS
-- == Chips and bonus cards

-- Storm Warning
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "stormWarning",
	key = "stormWarning",
	config = {extra = {chips = 0, chipGain = 30}},
	pos = {x = 5, y = 0},
	loc_txt = {
		name = 'Storm Warning',
		text = {
			"{C:chips}+#1#{} Chips when any card",
			"is sold, {C:attention}resets{} when",
			"any card is bought",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chipGain, center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipGain
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
		elseif context.buying_card and not context.blueprint and card.ability.extra.chips > 0 and context.card.ability.set ~= "Voucher" then
			card.ability.extra.chips = 0
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset!"})
		elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
	end
})

-- Candle Service
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "candleService",
	key = "candleService",
	config = {extra = {chips = 250, played = 0, req = 8}},
	pos = {x = 1, y = 0},
	loc_txt = {
		name = 'Candle Service',
		text = {
			"Every eighth scoring",
			"{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{} gives",
			"you {C:chips}+#1#{} Chips",
			"{C:inactive}(Currently #2#/#3#){}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips, center.ability.extra.played, center.ability.extra.req}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() <= 5
		and context.other_card:get_id() >= 2
		and context.cardarea == G.play then
			if card.ability.extra.played >= card.ability.extra.req-1 then
				card.ability.extra.played = 0
				return {
					chips = card.ability.extra.chips,
					card = card
				}
			else
				card.ability.extra.played = card.ability.extra.played + 1
				return { 
					extra = {
						message = card.ability.extra.played.."/"..card.ability.extra.req,
						colour = G.C.FILTER
					},
					card = card
				}
			end
		end
	end
})

-- Aqua Monster
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaMonster",
	key = "aquaMonster",
	config = {extra = {}},
	pos = {x = 2, y = 0},
	loc_txt = {
		name = 'Aqua Monster',
		text = {
			"All scoring cards become",
			"{C:attention}Bonus Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if true then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_bonus, nil, true)
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
					message = "Splash!",
					colour = G.C.CHIPS,
					card = self
				}
			end
		end
	end
})

-- Aqua Ghost
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaGhost",
	key = "aquaGhost",
	config = {extra = {}},
	pos = {x = 3, y = 0},
	loc_txt = {
		name = 'Aqua Ghost',
		text = {
			"All scoring cards become",
			"{C:dark_edition}Foil Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if true then 
					faces[#faces+1] = v
					v:set_edition({foil = true}, nil, true)
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
					message = "Splash!",
					colour = G.C.CHIPS,
					card = self
				}
			end
		end
	end
})

-- Aqua Demon
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaDemon",
	key = "aquaDemon",
	config = {extra = {chips = 666}},
	pos = {x = 4, y = 0},
	loc_txt = {
		name = 'Aqua Demon',
		text = {
			"{C:chips}+#1#{} Chips if played",
			"hand contains",
			"a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and next(context.poker_hands['Three of a Kind']) then 
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
	end
})

-- == WILD BOAR
-- == Mult and mult cards

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
	config = {extra = {mult = 0, multGain = 15, progress = "_ _ _ _", 
		progressList = {spades = false, clubs = false, hearts = false, diamonds = false}
	}},
	pos = {x = 4, y = 1},
	loc_txt = {
		name = 'Fly Line',
		text = {
			"Gains {C:mult}+#1#{} Mult after playing",
			"{C:attention}flushes{} in all four suits",
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
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect ~= "Wild Card" then 
					if v:is_suit('Spades') then card.ability.extra.progressList.spades = true end
					if v:is_suit('Clubs') then card.ability.extra.progressList.clubs = true end
					if v:is_suit('Hearts') then card.ability.extra.progressList.hearts = true end
					if v:is_suit('Diamonds') then card.ability.extra.progressList.diamonds = true end
				end
			end
			local newProgress = ""
			local pList = card.ability.extra.progressList
			if pList.spades then newProgress = newProgress.."S " else newProgress = newProgress.."_ " end
			if pList.hearts then newProgress = newProgress.."H " else newProgress = newProgress.."_ " end
			if pList.clubs then newProgress = newProgress.."C " else newProgress = newProgress.."_ " end
			if pList.diamonds then newProgress = newProgress.."D" else newProgress = newProgress.."_" end
			local sendMessage = newProgress ~= card.ability.extra.progress
			card.ability.extra.progress = newProgress
			if pList.spades and pList.hearts and pList.clubs and pList.diamonds then
				card.ability.extra.progress = "_ _ _ _"
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
			elseif sendMessage then 
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

-- == DRAGON COUTURE
-- == Card draw and hand size

-- Self Found, Others Lost
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "selfFound",
	key = "selfFound",
	config = {extra = {handSize = 0, handSizeBuff = 2}},
	pos = {x = 1, y = 2},
	loc_txt = {
		name = 'Self Found, Others Lost',
		text = {
			"Gain {C:attention}+#1#{} hand size next round",
			"whenever you {C:attention}reroll{} the shop",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} hand size)"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSizeBuff, center.ability.extra.handSize}}
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.handSize = card.ability.extra.handSize + card.ability.extra.handSizeBuff
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
		end
		
		if context.ending_shop and not context.blueprint then
			G.hand:change_size(card.ability.extra.handSize)
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			G.hand:change_size(-card.ability.extra.handSize)
			card.ability.extra.handSize = 0
		end
	end
})

-- One Grain, Infinite Promise
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "oneGrain",
	key = "oneGrain",
	config = {extra = {toDraw = 4, inRound = false}},
	pos = {x = 3, y = 2},
	loc_txt = {
		name = 'One Grain, Infinite Promise',
		text = {
			"Whenever you use a {C:attention}consumable{}",
			"during a round, draw {C:attention}#1#{} cards"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.toDraw}}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and #G.hand.cards>0 and card.ability.extra.inRound then
			local card_count = card.ability.extra.toDraw
			for i=1, card_count do
				draw_card(G.deck,G.hand, i*100/card_count,nil, nil , nil, 0.07)
				G.E_MANAGER:add_event(Event({func = function() G.hand:sort() return true end}))
			end
		end
		
		if context.first_hand_drawn and not context.blueprint then
			card.ability.extra.inRound = true
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			card.ability.extra.inRound = false
		end
	end
})

-- One Stroke, Vast Wealth
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "oneStroke",
	key = "oneStroke",
	config = {extra = {perDollar = 20, handSize = 0, handSizeMax = 10}},
	pos = {x = 2, y = 2},
	loc_txt = {
		name = 'One Stroke, Vast Wealth',
		text = {
			"{C:attention}+1{} hand size for every {C:money}$#1#{}",
			"you have, to a maximum of {C:attention}+#3#{}",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} hand size)"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.perDollar, center.ability.extra.handSize, center.ability.extra.handSizeMax}}
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local oldMax = card.ability.extra.handSize
			card.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars) / card.ability.extra.perDollar), card.ability.extra.handSizeMax))
			if card.ability.extra.handSize ~= oldMax then
				G.hand:change_size(card.ability.extra.handSize - oldMax)
			end
		end
	end
})

-- Swift Storm, Swift End
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "swiftStorm",
	key = "swiftStorm",
	config = {extra = {handSize = 0, handSizeBuff = 7}},
	pos = {x = 4, y = 2},
	loc_txt = {
		name = 'Swift Storm, Swift End',
		text = {
			"{C:attention}+#1#{} hand size on the",
			"{C:attention}final hand{} of each round"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSizeBuff}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main or context.debuffed_hand then
			if G.GAME.current_round.hands_left == 1 then
				if card.ability.extra.handSize == 0 then
					card.ability.extra.handSize = card.ability.extra.handSizeBuff
					G.hand:change_size(card.ability.extra.handSize)
				end
			else
				G.hand:change_size(-card.ability.extra.handSize)
				card.ability.extra.handSize = 0
			end
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			G.hand:change_size(-card.ability.extra.handSize)
			card.ability.extra.handSize = 0
		end
	end
})

-- Flames Apart, Foes Aflame
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "flamesApart",
	key = "flamesApart",
	config = {extra = {}},
	pos = {x = 5, y = 2},
	loc_txt = {
		name = 'Flames Apart, Foes Aflame',
		text = {
			"When you play a {C:attention}Straight Flush{} or",
			"a {C:attention}secret hand{}, draw your {C:dark_edition}entire deck{}"
		}
	},
	rarity = 3,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint and 
		(next(context.poker_hands['Straight Flush']) or next(context.poker_hands['Five of a Kind']) or
		next(context.poker_hands['Flush House']) or next(context.poker_hands['Flush Five']))  then
			local toDraw = #G.deck.cards
			for i=1, toDraw do
				draw_card(G.deck,G.hand, i*100/toDraw ,true, card , nil, 0.07)
				G.E_MANAGER:add_event(Event({func = function() card:juice_up(0.3, 0.4) return true end}))
				G.E_MANAGER:add_event(Event({func = function() G.hand:sort() return true end}))
			end
		end
	end
})


-- == LAPIN ANGELIQUE
-- == xMult, Steel and Glass cards


-- Spider's Silk
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "spiderSilk",
	key = "spiderSilk",
	config = {extra = {}},
	pos = {x = 1, y = 4},
	loc_txt = {
		name = "Spider's Silk",
		text = {
			"Played {C:attention}Steel{} cards become {C:attention}Glass{}",
			"Held {C:attention}Glass{} cards become {C:attention}Steel{}"
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
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect == "Steel Card" then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_glass, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			for k, v in ipairs(G.hand.cards) do
				if v.ability.effect == "Glass Card" then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_steel, nil, true)
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
					message = "Woven",
					card = self
				}
			end
		end
	end
})

-- Lolita Bat
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lolitaBat",
	key = "lolitaBat",
	config = {extra = {timer = 0, timerMax = 8, xMult = 3.5}},
	pos = {x = 2, y = 4},
	loc_txt = {
		name = 'Lolita Bat',
		text = {
			"{X:mult,C:white} X#1# {} Mult for the",
			"next {C:attention}#2#{} hands after",
			"using a {C:spectral}Spectral{} card",
			"{C:inactive}(#3#){}"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMult, center.ability.extra.timerMax, center.ability.extra.timer == 0 and "Inactive!" or center.ability.extra.timer.." hands remaining" }}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.timer > 0 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
		
		if context.cardarea == G.jokers and context.after and card.ability.extra.timer > 0 and not context.blueprint then
			card.ability.extra.timer = card.ability.extra.timer - 1
			return {
				message = card.ability.extra.timer.." remaining"
			}
		end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == "Spectral" then
				card.ability.extra.timer = card.ability.extra.timerMax
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Active!"})
			end
		end
	end
})

-- Skull Rabbit
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "skullRabbit",
	key = "skullRabbit",
	config = {extra = {xMult = 1, xMultGain = 0.1}},
	pos = {x = 3, y = 4},
	loc_txt = {
		name = 'Skull Rabbit',
		text = {
			"Gains {X:mult,C:white} X#1# {} Mult",
			"when hand is played",
			"with {C:money}$4{} or less",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult){}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMultGain, center.ability.extra.xMult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if G.GAME.dollars <= 4 then
				card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMultGain
			end
			return {
				message = "Upgrade!"
			}
		end
	
		if context.cardarea == G.jokers and context.joker_main then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
	end
})

-- == PEGASO
-- == Gaining and manipulating money

-- Thunder Pawn
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "thunderPawn",
	key = "thunderPawn",
	config = {extra = {profit = 2}},
	pos = {x = 1, y = 5},
	loc_txt = {
		name = 'Thunder Pawn',
		text = {
			"Gain {C:money}$#1#{} each round",
			"{C:attention}+1{} card slot in shop"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.profit}}
	end,
	calculate = function(self, card, context)

	end
})

-- Lightning Rook
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lightningRook",
	key = "lightningRook",
	config = {extra = {sellGain = 5}},
	pos = {x = 2, y = 5},
	loc_txt = {
		name = 'Lightning Rook',
		text = {
			"Gains {C:money}$#1#{} of sell",
			"value whenever an",
			"{C:attention}Ace{} is scored"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.sellGain}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() == 14
		and context.cardarea == G.play then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.sellGain
			card:set_cost()
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			})
		end
	end
})

-- Excalibur
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "excalibur",
	key = "excalibur",
	config = {extra = {newPrice = 1}},
	pos = {x = 3, y = 5},
	loc_txt = {
		name = 'Excalibur',
		text = {
			"Set the price of",
			"{C:dark_edition}everything{} in the",
			"shop to {C:money}$#1#{}",
			"{C:inactive}(Except for rerolls){}"
		}
	},
	rarity = 3,
	cost = 10,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.newPrice}}
	end,
	calculate = function(self, card, context)
		
	end
})

-- == JUPITER OF THE MONKEY
-- == Tarots, planets, and spectral cards

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
	cost = 5,
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
	cost = 5,
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

-- == HIP SNAKE
-- == Skips and tags

-- Long Live The Ice
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "longLiveTheIce",
	key = "longLiveTheIce",
	config = {extra = {chips = 50, dollars = 2, flipside = false}},
	pos = {x = 1, y = 6},
	loc_txt = {
		name = 'Long Live The Ice',
		text = {
			"When you play a hand,",
			"{V:1}#3#: {C:chips}+#1#{V:1} chips{}",
			"{V:2}#4#: Gain {C:money}$#2#{}",
			"Swap effects on blind skip"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
				return {vars = {
			center.ability.extra.chips,
			center.ability.extra.dollars,
			center.ability.extra.flipside and "Inactive" or "Active",
			center.ability.extra.flipside and "Active" or "Inactive",
			colours = {
				center.ability.extra.flipside and G.C.UI.TEXT_INACTIVE or G.C.UI.TEXT_DARK,
				center.ability.extra.flipside and G.C.UI.TEXT_DARK or G.C.UI.TEXT_INACTIVE
			}
		}}
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			card.ability.extra.flipside = not card.ability.extra.flipside
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = "Flip!",
				card = card
			}) 
		end
		
		if context.cardarea == G.jokers and context.joker_main then
			if not card.ability.extra.flipside then
				return {
					message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
					chip_mod = card.ability.extra.chips,
				}
			else
				ease_dollars(card.ability.extra.dollars)
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
				G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
				return {
					message = localize('$')..card.ability.extra.dollars,
					dollars = card.ability.extra.dollars,
					colour = G.C.MONEY
				}
			end
		end
	end
})

-- Sizzling Gaze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "sizzlingGaze",
	key = "sizzlingGaze",
	config = {extra = {tagsToMake = 5, triggeredThisHand = false}},
	pos = {x = 2, y = 6},
	loc_txt = {
		name = 'Sizzling Gaze',
		text = {
			"If your hand is a {C:attention}Pair{}",
			"of {C:attention}Aces{} and no other",
			"cards, destroy them and",
			"gain {C:attention}#1#{} random tags"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.tagsToMake}}
	end,
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint and #context.full_hand == 2
		and context.full_hand[1]:get_id() == 14 and context.full_hand[2]:get_id() == 14 then
			if not card.ability.extra.triggeredThisHand then
				card.ability.extra.triggeredThisHand = true
				G.E_MANAGER:add_event(Event({
					func = (function()
						for i=1,5 do
							if G.FORCE_TAG then return G.FORCE_TAG end
							local _pool, _pool_key = get_current_pool('Tag', nil, nil, nil)
							local _tag_name = pseudorandom_element(_pool, pseudoseed(_pool_key))
							local it = 1
							while _tag_name == 'UNAVAILABLE' or _tag_name == "tag_double" or _tag_name == "tag_orbital" do
								it = it + 1
								_tag_name = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
							end
					
							G.GAME.round_resets.blind_tags = G.GAME.round_resets.blind_tags or {}
							local _tag = Tag(_tag_name, nil, G.GAME.blind)
							add_tag(_tag)
							play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
							play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						end
						return true
					end)
				}))
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+5 Tags"})
			end
			return true
		end
		
		if context.remove_playing_cards then
			card.ability.extra.triggeredThisHand = false
		end
		return nil
	end
})

-- Eyes Full of Hope
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "eyesFullOfHope",
	key = "eyesFullOfHope",
	config = {extra = {bonusConsumable = 0}},
	pos = {x = 3, y = 6},
	loc_txt = {
		name = 'Eyes Full of Hope',
			text = {
			"When you skip a {C:attention}Blind{},",
			"gain a {C:tarot}Tarot{} card and",
			"{C:attention}+1{} consumable slot",
			"{C:inactive}(Currently {C:attention}+#1#{C:inactive} slots){}"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.bonusConsumable}}
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			card.ability.extra.bonusConsumable = card.ability.extra.bonusConsumable + 1,
			
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
			
			G.E_MANAGER:add_event(Event({func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
				return true end }))
			
			G.E_MANAGER:add_event(Event({ func = function() 
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = "+1 Tarot",
					card = card
				}) 
				return true
			end}))
		end
	end
})

-- == Tigre Punks
-- == Card destruction and sacrifice

-- Thanx
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "thanx",
	key = "thanx",
	config = {extra = {}},
	pos = {x = 1, y = 7},
	loc_txt = {
		name = 'Thanx',
		text = {
			"Destroy all scored",
			"{C:attention}face{} cards"
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
		if context.destroying_card and not context.blueprint and context.destroying_card:is_face() then
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Thanx"})
			return true
		end
	end
})

-- Demon's Hatred
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "demonsHatred",
	key = "demonsHatred",
	config = {extra = {mult = 0, multGain = 3, multMax = 24}},
	pos = {x = 2, y = 7},
	loc_txt = {
		name = "Demon's Hatred",
		text = {
			"Gains {C:mult}+#1#{} Mult per hand",
			"Destroys a random joker",
			"on blind selection if this",
			"has {C:mult}#3#{} or more Mult",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.multGain, center.ability.extra.mult, center.ability.extra.multMax}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.setting_blind and not card.getting_sliced and not context.blueprint and card.ability.extra.mult > card.ability.extra.multMax then
			local destructable_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
			end
			local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('madness')) or nil

			if joker_to_destroy and not (context.blueprint_card or card).getting_sliced then 
				joker_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({func = function()
					(context.blueprint_card or card):juice_up(0.8, 0.8)
					joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
				return true end }))
			end
			if not (context.blueprint_card or card).getting_sliced then
				card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = "Hatred!"})
			end
		end
	end
})

-- LIVE!
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "live",
	key = "live",
	config = {extra = {countdown = 4, countdownMax = 4}},
	pos = {x = 3, y = 7},
	loc_txt = {
		name = "LIVE!",
		text = {
			"After destroying {C:attention}#1#{} more",
			"cards, all scoring cards in your",
			"next hand become {C:dark_edition}Holographic{}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.countdown}}
	end,
	calculate = function(self, card, context)
		if context.cards_destroyed and not context.blueprint then
			local removed = 0
			for k, v in ipairs(context.glass_shattered) do
				removed = removed + 1
			end
			if removed > 0 then
				card.ability.extra.countdown = card.ability.extra.countdown - removed
				if card.ability.extra.countdown < 0 then
					card.ability.extra.countdown = 0
				end
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.countdown.." left"})
				if card.ability.extra.countdown == 0 then
					local eval = function(card) return (card.ability.extra.countdown == 0) and not G.RESET_JIGGLES end
					juice_card_until(card, eval, true)
				end
			end

			return
		end
		
		if context.remove_playing_cards and not context.blueprint then
            local removed = 0
			for k, v in ipairs(context.removed) do
				removed = removed + 1
			end
			if removed > 0 then
				card.ability.extra.countdown = card.ability.extra.countdown - removed
				if card.ability.extra.countdown < 0 then
					card.ability.extra.countdown = 0
				end
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.countdown.." left"})
				if card.ability.extra.countdown == 0 then
					local eval = function(card) return (card.ability.extra.countdown == 0) end
					juice_card_until(card, eval, true)
				end
			end
			return
		end
	
		if context.cardarea == G.jokers and context.before and card.ability.extra.countdown == 0 and not context.blueprint then
			card.ability.extra.countdown = card.ability.extra.countdownMax
			for k, v in ipairs(context.scoring_hand) do
				v:set_edition({holo = true}, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
			end
			return {
				message = "LIVE!",
				colour = G.C.MULT,
				card = self
			}
		end
	end
})


for k,v in pairs(stuffToAdd) do
	if v.name ~= "blank" and v.name ~= "testing" then
	-- 
		SMODS[v.object_type](v)
	end
end


local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.twetyTesting then 
		G.E_MANAGER:add_event(Event({
			func = function()
				for _,tempName in ipairs({"mitama", "longLiveTheIce", "live", "demonsHatred", "thanx"}) do
					local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_twewy_'..tempName, nil)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
				return true
			end
		}))
	end
end

local Card_calculate_dollar_bonus = Card.calculate_dollar_bonus
function Card.calculate_dollar_bonus(self)
	Card_calculate_dollar_bonus(self)
	if self.ability.set == "Joker" then
        if self.ability.name == 'thunderPawn' then
            return self.ability.extra.profit
        end
	end
end	

local Original_ease_dollars = ease_dollars
function ease_dollars(mod, instant)
	Original_ease_dollars(mod, instant)
	for k,v in ipairs(SMODS.find_card("j_twewy_oneStroke", true)) do
		local oldMax = v.ability.extra.handSize
		v.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars + mod) / v.ability.extra.perDollar), v.ability.extra.handSizeMax))
		if v.ability.extra.handSize ~= oldMax then
			G.hand:change_size(v.ability.extra.handSize - oldMax)
		end
	end
end

local Card_add_to_deck_ref = Card.add_to_deck 
function Card.add_to_deck(self, from_debuff)
	if not self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' or self.ability.name == 'swiftStorm' then
			G.hand:change_size(self.ability.extra.handSize)
		end
		
		if self.ability.name == 'oneStroke' then
			self.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars) / self.ability.extra.perDollar), self.ability.extra.handSizeMax))
			G.hand:change_size(self.ability.extra.handSize)
		end
		
		if self.ability.name == 'thunderPawn' then
			G.E_MANAGER:add_event(Event({func = function()
				change_shop_size(1)
				return true end }))
		end
		
		if self.ability.name == 'eyesFullOfHope' then
			G.E_MANAGER:add_event(Event({func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.ability.extra.bonusConsumable
				return true end }))
		end

	end
	Card_add_to_deck_ref(self, from_debuff)
end

local Card_remove_from_deck_ref = Card.remove_from_deck 
function Card.remove_from_deck(self, from_debuff)
	if self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' 
		or self.ability.name == 'oneStroke' or self.ability.name == 'swiftStorm' then
			G.hand:change_size(-self.ability.extra.handSize)
		end
		
		if self.ability.name == 'thunderPawn' then
			G.GAME.twewy_thunderPawn_resetShop = true
		end

		if self.ability.name == 'eyesFullOfHope' then
			G.E_MANAGER:add_event(Event({func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.ability.extra.bonusConsumable
				return true end }))
		end


	end
	Card_remove_from_deck_ref(self, from_debuff)
end

local G_FUNCS_reroll_shop = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_reroll_shop(e)
end

local G_FUNCS_toggle_shop = G.FUNCS.toggle_shop
function G.FUNCS.toggle_shop(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_toggle_shop(e)
end

local G_FUNCS_cash_out = G.FUNCS.cash_out
function G.FUNCS.cash_out(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_cash_out(e)
end

local Card_set_cost = Card.set_cost
function Card.set_cost(self)
	Card_set_cost(self)
	for k,v in ipairs(SMODS.find_card("j_twewy_excalibur")) do
		self.cost = v.ability.extra.newPrice
	end
	
end

function destroyCard(card)
	G.E_MANAGER:add_event(Event({
		func = function()
			play_sound('tarot1')
			card.T.r = -0.2
			card:juice_up(0.3, 0.4)
			card.states.drag.is = true
			card.children.center.pinch.x = true
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
				func = function()
						G.jokers:remove_card(card)
						card:remove()
						card = nil
					return true; end})) 
			return true
		end
	})) 
end

-- == Scrapped Ideas
-- == Most still work, they're just not good ideas

-- Kewl Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "kewlLinescrapped",
	key = "kewlLinescrapped",
	config = {extra = {handSize = -1, mult = 8}},
	pos = {x = 1, y = 1},
	loc_txt = {
		name = 'Kewl Line',
		text = {
			"{C:red}#1#{} hand size, {C:mult}+#2#{} Mult",
			"Scored {C:attention}8s{} double both",
			"values until end of round"
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
			G.hand:change_size(card.ability.extra.handSize)
			card.ability.extra.mult = card.ability.extra.mult * 2
			card.ability.extra.handSize = card.ability.extra.handSize * 2
			return { 
				extra = {
					message = "Double!",
					colour = G.C.FILTER
				},
				card = card
			}
		end
		
		if context.cardarea == G.jokers and context.joker_main then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint and card.ability.extra.mult > 8 then
			G.hand:change_size(-card.ability.extra.handSize-1)
			card.ability.extra.mult = 8
			card.ability.extra.handSize = -1
			return {
				message = localize('k_reset'),
				colour = G.C.RED
			}
		end
	end
})

-- Dope Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "dopeLinescrapped",
	key = "dopeLinescrapped",
	config = {extra = {mult = 1}},
	pos = {x = 2, y = 1},
	loc_txt = {
		name = 'Dope Line',
		text = {
			"If your scoring hand",
			"has an {C:attention}Ace{}, {C:mult}+#1#{} Mult",
			"and {C:red}destroy{} this joker.",
			"Value doubles every round"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			local aces = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 14 then aces = aces + 1 end
			end
			if aces >= 1 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
					mult_mod = card.ability.extra.mult
				}
			end
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult * 2
			return {
				message = 'Doubled!',
				colour = G.C.RED
			}
		end
	end
})

-- Wild Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "wildLinescrapped",
	key = "wildLinescrapped",
	config = {extra = {mult = 4}},
	pos = {x = 3, y = 1},
	loc_txt = {
		name = 'Wild Line',
		text = {
			"{C:mult}+#1#{} Mult",
			"Doubles when a {C:attention}Mult Card{}",
			"is scored, but breaks after",
			"going over {C:mult}128{} mult"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
	
		if context.individual
		and context.other_card.ability.effect == "Mult Card"
		and context.cardarea == G.play then
			card.ability.extra.mult = card.ability.extra.mult * 2
			if card.ability.extra.mult > 128 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				}))
				return {
					message = localize('Broken!'),
					colour = G.C.FILTER
				}
			else
				return { 
					extra = {
						message = "Double!",
						colour = G.C.FILTER
					},
					card = card
				}
			end
		end
	
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult <= 128 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
	end
})

-- Swift Storm, Swift End
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "swiftStormScrapped",
	key = "swiftStormScrapped",
	config = {extra = {handSize = 4, handSizeLoss = 1}},
	pos = {x = 4, y = 2},
	loc_txt = {
		name = 'Swift Storm, Swift End',
		text = {
			"{C:attention}+4{} hand size, permanently drops",
			"to {C:attention}+#2#{} hand size if you don't",
			"skip the {C:attention}Small{} or {C:attention}Big Blind{}",
			"{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSize, center.ability.extra.handSizeLoss}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not context.blind.boss and card.ability.extra.handSize == 4 then
			G.hand:change_size(-(card.ability.extra.handSize - card.ability.extra.handSizeLoss))
			card.ability.extra.handSize = card.ability.extra.handSizeLoss
		end
	end
})

-- Sizzling Gaze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "sizzlingGazeScrapped",
	key = "sizzlingGaze",
	config = {extra = {payouts = 4}},
	pos = {x = 2, y = 6},
	loc_txt = {
		name = 'Sizzling Gaze',
		text = {
			"The next {C:attention}#1#{} times you",
			"play a {C:attention}Full House{}, gain",
			"the {C:attention}tag{} for this blind",
			"{C:inactive}(Currently: #2#){}",
			"{C:inactive}Not actually 100% implemented{}"
		}
	},
	rarity = 1,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.payouts, "Uncommon Tag"}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Full House']) then
			local _tag = Tag('tag_uncommon')
            add_tag(_tag)
			if not context.blueprint then
				card.ability.extra.payouts = card.ability.extra.payouts - 1
			end
		end
	end
})

