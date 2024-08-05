local jd_def = JokerDisplay.Definitions

-- D+B --------------------------------------------------------

-- Ice Blow
jd_def["j_twewy_iceBlow"] = {
	text = {
		{ text = "+",                              colour = lighten(G.C.RED, 0.1) },
		{ ref_table = "card.joker_display_values", ref_value = "aDiscards",       colour = lighten(G.C.RED, 0.1) },
	},
	reminder_text = {
		{ text = "(Discards)" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

		if card.ability.extra.triggered or text == "Unknown" then
			card.joker_display_values.active = false
		else
			local faces = 0

			-- Loops through the scoring_hand and increments the face card counter
			for k, v in pairs(scoring_hand) do
				if v:is_face() then
					faces = faces + 1
				end
			end

			card.joker_display_values.active = (faces >= 3) and true or false
		end

		card.joker_display_values.aDiscards = card.joker_display_values.active and 3 or 0
	end,
}

-- Ice Risers
jd_def["j_twewy_iceRisers"] = {
	text = {
		{ text = "+",                              colour = lighten(G.C.CHIPS, 0.1) },
		{ ref_table = "card.joker_display_values", ref_value = "aHands",            colour = lighten(G.C.CHIPS, 0.1) },
	},
	reminder_text = {
		{ text = "(Hands)" },
	},

	calc_function = function(card)
		local hand = G.hand.highlighted
		local faces = false

		-- Checks the scoring_hand for a face card
		for k, v in pairs(hand) do
			if v:is_face() then
				faces = true
				break
			end
		end
		card.joker_display_values.active = (faces and G.GAME.current_round.discards_left > 0) and true or false
		card.joker_display_values.aHands = card.joker_display_values.active and 1 or 0
	end,
}

-- Straitjacket
jd_def["j_twewy_straitjacket"] = {
	text = {
		{ text = "+",                              colour = lighten(G.C.BLUE, 0.2) },
		{ ref_table = "card.joker_display_values", ref_value = "aHands",           colour = lighten(G.C.BLUE, 0.2) },
	},
	reminder_text = {
		{ text = "(Hands) " },
		{ text = "(" },
		{ ref_table = "card.ability.extra", ref_value = "usesLeft", colour = G.C.ORANGE },
		{ text = "/6)" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, _ = JokerDisplay.evaluate_hand(hand)

		card.joker_display_values.aHands = text == "Straight" and 1 or 0
	end,
}

-- End D+B----------------------------------------------------------

-- Dragon Couture --------------------------------------------------

--Self Found
jd_def["j_twewy_selfFound"] = {
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.ability.extra", ref_value = "handSize" },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 }
}

-- One Stroke
jd_def["j_twewy_oneStroke"] = {
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.ability.extra", ref_value = "handSize" },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 }
}

-- Swift Storm
jd_def["j_twewy_swiftStorm"] = {
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.ability.extra", ref_value = "handSize" },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 }
}

-- Flames Apart
jd_def["j_twewy_flamesApart"] = {
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "active_text" },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 },
	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, _ = JokerDisplay.evaluate_hand(hand)

		card.joker_display_values.active = text == "Straight Flush" or text == "Flush House" or text == "Flush Five" or text == "Five of a Kind"
		card.joker_display_values.active_text = card.joker_display_values.active and "Active!" or "Inactive"
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[2] then
			reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or
				G.C.UI.TEXT_INACTIVE
		end
		return false
	end,
}

-- Black Sky
jd_def["j_twewy_blackSky"] = {
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.ability.extra", ref_value = "handSize" },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 }
}

-- Fiery Spirit
jd_def["j_twewy_fierySpirit"] = {
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.ability.extra", ref_value = "handSize", },
		{ text = ")" },
	},
	reminder_text_config = { scale = 0.35 }
}

-- End Dragon Couture ----------------------------------------------

-- Hip Snake -------------------------------------------------------

-- TODO: Add hip_snake Jokers

-- End Hip Snake ---------------------------------------------------

-- Jupiter of the Monkey -------------------------------------------

-- TODO: Add jupiter_of_the_monkey Jokers

-- End Jupiter of the Monkey ---------------------------------------

-- Lapin Angelique -------------------------------------------------

-- Lolita Bat
jd_def["j_twewy_lolitaBat"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{
			ref_table = "card.joker_display_values",
			ref_value = "inactive_text",
		},
		{
			ref_table = "card.joker_display_values",
			ref_value = "timer_text",
			colour = G.C.IMPORTANT,
		},
		{
			ref_table = "card.joker_display_values",
			ref_value = "hands_remaining_text",
		},
		{ text = ")" },
	},

	calc_function = function(card)
		card.joker_display_values.inactive = (card.ability.extra.timer == 0) and true or false

		card.joker_display_values.xMult = card.joker_display_values.inactive and 1 or card.ability.extra.xMult
		card.joker_display_values.inactive_text = card.joker_display_values.inactive and "Inactive!" or ""
		card.joker_display_values.timer_text = card.joker_display_values.inactive and "" or card.ability.extra.timer
		card.joker_display_values.hands_remaining_text = card.joker_display_values.inactive and "" or "/8"
	end,
}

-- Skull Rabbit
jd_def["j_twewy_skullRabbit"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(<" },
		{ text = "$4" },
		{ text = ")" },
	},

	calc_function = function(card)
		card.joker_display_values.active = G.GAME.dollars < 5
	end,

	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[2] then
			reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.MONEY or
				G.C.UI.TEXT_INACTIVE
		end
	end,
}

-- Web Spider
jd_def["j_twewy_webSpider"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(Level 2)" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, _ = JokerDisplay.evaluate_hand(hand)

		card.joker_display_values.xMult = text
			and G.GAME.hands[text]
			and (G.GAME.hands[text].level == 2)
			and card.ability.extra.xMult
			or 1
	end,
}

-- Lolita Skull
jd_def["j_twewy_lolitaSkull"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.IMPORTANT },
		{ text = "/4)" },
	},

	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for k, v in ipairs(G.hand.cards) do
			if playing_hand or not v.highlighted then
				if not (v.facing == "back") and not v.debuff and v:is_suit("Hearts") then
					count = count + 1
				end
			end
		end

		card.joker_display_values.xMult = (count >= 4) and card.ability.extra.xMult or 1
		card.joker_display_values.count = count
	end,
}

-- Lolita Mic
jd_def["j_twewy_lolitaMic"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.ability.extra", ref_value = "lastDiscard", colour = G.C.IMPORTANT },
		{ text = ")" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, _ = JokerDisplay.evaluate_hand(hand)

		card.joker_display_values.xMult = text and (text == card.ability.extra.lastDiscard) and card.ability.extra.xMult
			or 1
	end,
}

-- Kaleidoscope
jd_def["j_twewy_kaleidoscope"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		-- Spades
		{ text = "(" },
		{ text = "S" },
		{ text = ")" },

		-- Clubs
		{ text = "(" },
		{ text = "C" },
		{ text = ")" },

		-- Hearts
		{ text = "(" },
		{ text = "H" },
		{ text = ")" },

		-- Diamonds
		{ text = "(" },
		{ text = "D" },
		{ text = ")" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local _, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

		local count = 0

		-- Loops through each card in the scoring_hand and compares
		-- its suit to the suits in the last scored hand (Indicated by card.ability.extra.progressList)
		for i, v in ipairs(scoring_hand) do
			for k, w in pairs(card.ability.extra.progressList) do
				if v:is_suit(k .. "") and not w then
					count = count + JokerDisplay.calculate_card_triggers(v, scoring_hand)
				end
			end
		end

		card.joker_display_values.xMult = tonumber(string.format("%.2f", card.ability.extra.xMult ^ count))
	end,

	style_function = function(card, text, reminder_text, extra)
		if reminder_text then
			if reminder_text.children[2] then
				reminder_text.children[2].config.colour = card.ability.extra.progressList.Spades and
				lighten(G.C.SUITS.Spades, 0.35) or G.C.UI.TEXT_INACTIVE
			end
			if reminder_text.children[5] then 
				reminder_text.children[5].config.colour = card.ability.extra.progressList.Clubs and
				lighten(G.C.SUITS.Clubs, 0.35) or G.C.UI.TEXT_INACTIVE 
			end
			if reminder_text.children[8] then 
				reminder_text.children[8].config.colour = card.ability.extra.progressList.Hearts
					and lighten(G.C.SUITS.Hearts, 0.35)
					or G.C.UI.TEXT_INACTIVE
			end
			if reminder_text.children[11] then 
				reminder_text.children[11].config.colour = card.ability.extra.progressList.Diamonds
					and lighten(G.C.SUITS.Diamonds, 0.35)
					or G.C.UI.TEXT_INACTIVE
			end
		end
	end,
}

-- Lolita Chopper
jd_def["j_twewy_lolitaChopper"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xMult" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{
			ref_table = "card.joker_display_values",
			ref_value = "most_played_hand",
			colour = G.C.IMPORTANT,
		},
		{ text = ")"},
	},

	calc_function = function(card)
		if next(G.GAME.hands) then
			local play_count = 0
			local most_played = nil
			for k, v in pairs(G.GAME.hands) do
			   if v.played >= play_count then
				  play_count = v.played
				  most_played = k
			   end
			end
			local equal_count = 0
			for k, v in pairs(G.GAME.hands) do
			   if v.played == play_count then
				  equal_count = equal_count + 1
			   end
			end
			local all_equal = equal_count == #G.GAME.hands
			card.joker_display_values.most_played_hand = all_equal and "All"
					 or (equal_count > 1 and "Multiple") or localize(most_played, 'poker_hands')
		 end
	end,
}

-- End Lapin Angelique ---------------------------------------------

-- Mus Rattus ------------------------------------------------------

-- Storm Warning
jd_def["j_twewy_stormWarning"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.ability.extra", ref_value = "chips" },
	},
	text_config = { colour = G.C.CHIPS }
}

-- Candle Service
jd_def["j_twewy_candleService"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.joker_display_values", ref_value = "chips"},
	},
	text_config = { colour = G.C.CHIPS },
	reminder_text = {
		{ text = "("},
		{ ref_table = "card.ability.extra", ref_value = "played",          colour = G.C.IMPORTANT },
		{ text = "/" },
		{ ref_table = "card.ability.extra", ref_value = "req"},
		{ text = ")" },
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

		local played = 0

		if text ~= "Unknown" then
			for k, v in pairs(scoring_hand) do
				if v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 4 or v:get_id() == 5 then
					played = played + JokerDisplay.calculate_card_triggers(v, scoring_hand, false)
				end
			end
		end

		local triggers_when_played = math.floor(played / card.ability.extra.req) + 
			((card.ability.extra.played - (played % card.ability.extra.req)) < 0 and 1 or 0)
		local triggers = next(G.play.cards) and triggers_when_played or math.floor((played + card.ability.extra.played) / card.ability.extra.req)

		card.joker_display_values.chips = card.ability.extra.chips * triggers
	end,
}

-- Aqua Monster
jd_def["j_twewy_aquaMonster"] = {
	reminder_text = {
		{ text = "("},
		{
			ref_table = "card.joker_display_values",
			ref_value = "active_text",
		},
		{ text = ")"},
	},

	calc_function = function(card)
		local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
		local _, poker_hands, _ = JokerDisplay.evaluate_hand(hand)

		card.joker_display_values.active = poker_hands and poker_hands["Three of a Kind"] and next(poker_hands["Three of a Kind"]) and true or false
		card.joker_display_values.active_text = card.joker_display_values.active and "Active!" or "Inactive"
	end,

	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[2] then
			reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
		end
	end,
}

-- End Mus Rattus --------------------------------------------------
