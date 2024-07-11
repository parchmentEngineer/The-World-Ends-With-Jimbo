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

-- Vacu Squeeze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "vacuSqueezeScrapped",
	key = "vacuSqueezeScrapped",
	config = {extra = {retriggers = 4}},
	pos = {x = 2, y = 10},
	loc_txt = {
		name = 'Vacu Squeeze',
		text = {
			"If your scoring hand has only",
			"one {C:attention}face card{}, retrigger it {C:attention}#1#{} times"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.retriggers}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.other_card:is_face()
		and context.cardarea == G.play then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then 
					faces[#faces+1] = v
				end
			end
			if #faces == 1 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.retriggers,
					card = card
				}
			end
		end
	end
})

-- Impact Warning
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "impactWarningScrapped",
	key = "impactWarningScrapped",
	config = {extra = {chips = 0, chipsGain = 50}},
	pos = {x = 8, y = 0},
	loc_txt = {
		name = 'Impact Warning',
		text = {
			"This joker gains {C:chips}+#1#{} Chips",
			"when a {C:planet}Planet{} card is used",
			"{C:attention}Resets{} on playing a {C:attention}Level 1{} hand",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chipsGain, center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and G.GAME.hands[context.scoring_name].level == 1 and card.ability.extra.chips > 0 then
			card.ability.extra.chips = 0
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset!"})
		end
		
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == "Planet" then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipsGain
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
					chip_mod = card.ability.extra.chips,
				})
			end
		end
	end
})

-- Long Live The Ice
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "longLiveTheIceScrapped",
	key = "longLiveTheIceScrapped",
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

-- Love Me Tether
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "loveMeTetherScrapped",
	key = "loveMeTetherScrapped",
	config = {extra = {}},
	pos = {x = 7,  y = 9},
	loc_txt = {
		name = 'Love Me Tether',
		text = {
			"After scoring, if your scored",
			"hand had exactly {C:attention}1{} {C:hearts}Heart{}, set",
			"the rank of all scored cards",
			"equal to that {C:hearts}Heart's{} rank"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		local heartsVal = -1
		if context.cardarea == G.jokers and context.after then
			for k,v in pairs(context.scoring_hand) do
				if v:is_suit("Hearts") then
					if heartsVal == -1 then
						heartsVal = v.base.id
					else
						heartsVal = -2
					end
				end
			end
			if heartsVal > 0 then
				for k,v in pairs(context.scoring_hand) do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
						local _card = v
						local suit_prefix = string.sub(_card.base.suit, 1, 1)..'_'
						local rank_suffix = heartsVal
						if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
						elseif rank_suffix == 10 then rank_suffix = 'T'
						elseif rank_suffix == 11 then rank_suffix = 'J'
						elseif rank_suffix == 12 then rank_suffix = 'Q'
						elseif rank_suffix == 13 then rank_suffix = 'K'
						elseif rank_suffix == 14 then rank_suffix = 'A'
						end
						_card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
						_card:juice_up()
					return true end }))
				end
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3,func = function()
					card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Tethered!"})
				return true end }))
				for k,v in pairs(context.scoring_hand) do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
						v:juice_up()
					return true end }))
				end
			end
		end	
	end
})

-- Whirlygig Juggle
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "whirlygigJuggle",
	key = "whirlygigJuggle",
	config = {extra = {retriggers = 1}},
	pos = {x = 3, y = 10},
	loc_txt = {
		name = 'Whirlygig Juggle',
		text = {
			"When you play a {C:attention}Straight{},",
			"retrigger the lowest value",
			"card {C:attention}#1#{} time#2# and increase the",
			"number of retriggers by {C:attention}1{}"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.retriggers, center.ability.extra.retriggers == 1 and '' or 's'}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.cardarea == G.play
		and next(context.poker_hands['Straight']) then
			print("Test")
			local lowestVal = 99
			local lowestId = -1
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() <= lowestVal then
					lowestVal = v:get_id()
					lowestId = v.unique_val
					print(lowestVal.." has ID "..lowestId)
				end
			end
			if context.other_card.unique_val == lowestId then
				card.ability.extra.retriggers = card.ability.extra.retriggers + 1
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.retriggers-1,
					card = card
				}
			end
		end
	end
})

table.insert(stuffToAdd, {
	object_type = "Back",
	name = "lapinAngeliqueScrapped",
	key = "lapinAngeliqueScrapped",
	config = {},
	pos = {x = 0, y = 4},
	loc_txt = {
		name = "Lapin Angelique",
		text = {
			"All cards in your deck",
			"are {C:attention}Steel Cards{}, but",
			"{C:attention}Steel Cards{} (don't) only",
			"give {X:mult,C:white} X1.1 {} Mult"
		}
	},
	atlas = "jokers",
	apply = function(self)
	 G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
					v:set_ability(G.P_CENTERS.m_steel, nil, true)
				end
            return true
            end
        }))
	end
})

-- Lazy Bomber
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lazyBomberScrapped",
	key = "lazyBomberScrapped",
	config = {extra = {mult = 40, timerMax = 3, timer = 0}},
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

-- Love Me Tether
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "loveMeTetherScrapped2",
	key = "loveMeTetherScrapped2",
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

-- Playmate Beam
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "playmateBeamScrapped",
	key = "playmateBeamScrapped",
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