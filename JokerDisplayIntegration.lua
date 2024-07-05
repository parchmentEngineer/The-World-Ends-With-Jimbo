jd_def = JokerDisplay.Definitions


-- D+B --------------------------------------------------------

-- Ice Blow
jd_def["j_twewy_iceBlow"] = {
    line_1 = {
        { text = "+",                              colour = lighten(G.C.RED, 0.1) },
        { ref_table = "card.joker_display_values", ref_value = "aDiscards", colour = lighten(G.C.RED, 0.1) },
    },
    line_2 = {
        { text = "(Discards)", colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 }
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
        { text = "+",                              colour = lighten(G.C.CHIPS, 0.1) },
        { ref_table = "card.joker_display_values", ref_value = "aHands", colour = lighten(G.C.CHIPS, 0.1) }
    },
    line_2 = {
        { text = "(Hands)", colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 }
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
    line_1 = {
        { text = "+",                              colour = lighten(G.C.BLUE, 0.2) },
        { ref_table = "card.joker_display_values", ref_value = "aHands", colour = lighten(G.C.BLUE, 0.2) }
    },
    line_2 = {
        { text = "(Hands) ",                colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
        { text = "(",                       colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
        { ref_table = "card.ability.extra", ref_value = "usesLeft",        colour = G.C.ORANGE, scale = 0.3 },
        { text = "/6)",                     colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    },

    calc_function = function(card)
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

        card.joker_display_values.aHands = text == "Straight" and 1 or 0
    end
}

-- End D+B----------------------------------------------------------


-- Dragon Couture --------------------------------------------------

--Self Found
jd_def["j_twewy_selfFound"] = {
    line_2 = {
        { text = "(+",                      colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.ability.extra", ref_value = "handSize",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { text = ")",                       colour = G.C.UI.TEXT_INACTIVE, scale = 0.35},
    }
}

-- One Stroke
jd_def["j_twewy_oneStroke"] = {
    line_2 = {
        { text = "(+",                      colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.ability.extra", ref_value = "handSize",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { text = ")",                       colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 }
    }
}

-- Swift Storm
jd_def["j_twewy_swiftStorm"] = {
    line_2 = {
        { text = "(+",                      colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.ability.extra", ref_value = "handSize",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { text = ")",                       colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 }
    }
}

-- Flames Apart
jd_def["j_twewy_flamesApart"] = {
    line_2 = {
        { text = "(",                              colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.joker_display_values", ref_value = "active_text",     scale = 0.35 },
        { text = ")",                              colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 }
    },

    calc_function = function(card)
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)

        card.joker_display_values.active = text == ("Straight Flush" or "Flush House" or "Flush Five" or "Five of a Kind") and true or false
        card.joker_display_values.active_text = card.joker_display_values.active and "Active!" or "Inactive"
    end,
    style_function = function(card, line_1, line_2)
        if line_2 then
            line_2.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
        return false
    end
}

-- Black Sky
jd_def["j_twewy_blackSky"] = {
    line_2 = {
        { text = "(+",                                                     colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.ability.extra", ref_value = "handSize",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { text = ")",                                                      colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 }
    }
}

-- Fiery Spirit
jd_def["j_twewy_fierySpirit"] = {
    line_2 = {
        { text = "(+",                                                     colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { ref_table = "card.ability.extra", ref_value = "handSize",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 },
        { text = ")",                                                      colour = G.C.UI.TEXT_INACTIVE, scale = 0.35 }
    }
}

-- End Dragon Couture ----------------------------------------------


-- Hip Snake -------------------------------------------------------

-- TODO: Add hip_snake Jokers

-- End Hip Snake ---------------------------------------------------


-- Jupiter of the Monkey -------------------------------------------

-- TODO: Add jupiter_of_the_monkey Jokers

-- End Jupiter of the Monkey ---------------------------------------


-- Lapin Angelique -------------------------------------------------

jd_def["j_twewy_lolitaBat"] = {
    line_1 = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xMult" }
            }
        }
    },
    line_2 = {
        { text = "(",                                                                  colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "inactive_text",        colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "timer_text",           colour = G.C.IMPORTANT,        scale = 0.3 },
        { ref_table = "card.joker_display_values", ref_value = "hands_remaining_text", colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
        { text = ")",                                                                  colour = G.C.UI.TEXT_INACTIVE, scale = 0.3 },
    },

    calc_function = function(card)
        card.joker_display_values.inactive = (card.ability.extra.timer == 0) and true or false

        card.joker_display_values.xMult = card.joker_display_values.inactive and 1 or card.ability.extra.xMult
        card.joker_display_values.inactive_text = card.joker_display_values.inactive and "Inactive!" or ""
        card.joker_display_values.timer_text = card.joker_display_values.inactive and "" or card.ability.extra.timer
        card.joker_display_values.hands_remaining_text = card.joker_display_values.inactive and "" or "/8"
    end,
}

-- End Lapin Angelique ---------------------------------------------