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


return {stuffToAdd = stuffToAdd}