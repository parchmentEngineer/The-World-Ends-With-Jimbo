-- == HIP SNAKE
-- == Skips and tags

local stuffToAdd = {}

-- Long Live The Ice
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "longLiveTheIce",
	key = "longLiveTheIce",
	config = {extra = {skipsThisAnte = 0}},
	pos = {x = 1, y = 6},
	loc_txt = {
		name = 'Long Live The Ice',
		text = {
			"When you skip both blinds",
			"in a single ante, disable",
			"that ante's {C:attention}Boss Blind{}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {}
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			card.ability.extra.skipsThisAnte = card.ability.extra.skipsThisAnte + 1
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = card.ability.extra.skipsThisAnte.."/2",
				card = card
			}) 
		end
		
		if context.first_hand_drawn and G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then
			if card.ability.extra.skipsThisAnte >= 2 then
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
				G.GAME.blind:disable()
			end
			card.ability.extra.skipsThisAnte = 0
		end
	end
})

-- Sizzling Gaze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "sizzlingGazeScrapped",
	key = "sizzlingGazeScrapped",
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

--return {stuffToAdd = {}}
return {stuffToAdd = stuffToAdd}