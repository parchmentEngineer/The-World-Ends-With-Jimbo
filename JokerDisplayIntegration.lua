jd_def = JokerDisplay.Definitions


-- D+B Section --------------------------------------------------------

-- Ice Blow
jd_def["j_twewy_iceBlow"] = {
    line_1 = {
        {
            text = "+",
            colour = lighten(G.C.RED, 0.1)
        },
        {
            ref_table = "card.joker_display_values",
            ref_value = "aDiscards",
            colour = lighten(G.C.RED, 0.1)
        },
    },
    line_2 = {

        {
            text = "(Discards)",
            colour = G.C.UI.TEXT_INACTIVE,
            scale = 0.3
        }
    },

    calc_function = function(card)
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local _, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

        if card.ability.extra.triggered then
            card.joker_display_values.active = false
        else
            local faces = 0

            -- Loops through the scoring_hand and increments the face card counter
            for k, v in pairs(scoring_hand) do
                if not v.debuff and v:is_face() then
                    faces = faces + 1
                end
            end

            card.joker_display_values.active = (faces >= 3) and true or false
        end
        
        card.joker_display_values.aDiscards = card.joker_display_values.active and 3 or 0
    end
}

-- Ice Risers
jd_def["j_twewy_iceRisers"] = {
    line_1 = {
        {
            text = "+",
            colour = lighten(G.C.CHIPS, 0.1)
        },
        {
            ref_table = "card.joker_display_values",
            ref_value = "aHands",
            colour = lighten(G.C.CHIPS, 0.1)
        }
    },
    line_2 = {
        {
            text = "(Hands)",
            colour = G.C.UI.TEXT_INACTIVE,
            scale = 0.3
        }
    },

    calc_function = function(card)
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local faces = false

        -- Checks the scoring_hand for a face card
        for k, v in pairs(hand) do
            if v:is_face() and not v.debuff then
                faces = true
                break
            end
        end

        card.joker_display_values.active = (faces and G.GAME.current_round.discards_left > 0) and true or false
        card.joker_display_values.aHands = card.joker_display_values.active and 1 or 0
    end
}

-- Straitjacket
jd_def["j_twewy_straitjacket"] = {
    line_2 = {
        {
            text = "(",
            colour = G.C.UI.TEXT_INACTIVE
        },
        {
            ref_table = "card.ability.extra",
            ref_value = "usesLeft",
            colour = G.C.ORANGE
        },
        {
            text = " Uses Left)",
            colour = G.C.UI.TEXT_INACTIVE
        }  
    },
}

-- End D+B Section----------------------------------------------------------



