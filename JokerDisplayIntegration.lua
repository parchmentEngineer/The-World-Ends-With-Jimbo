jd_def = JokerDisplay.Definitions


-- D+B Section --------------------------------------------------------

-- Ice Blow
jd_def["j_twewy_iceBlow"] = {
    line_2 = {
        {
            text = "(",
            colour = G.C.UI.TEXT_INACTIVE,
            scale = 0.3
        },
        {
            ref_table = "card.joker_display_values",
            ref_value = "active_text",
            scale = 0.3
        },
        {
            text = ")",
            colour = G.C.UI.TEXT_INACTIVE,
            scale = 0.3
        },
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

        card.joker_display_values.active_text = card.joker_display_values.active and "Active!" or "Inactive"
    end,

    style_function = function(card, line_1, line_2)
        if line_2 then
            line_2.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
        end
    end
}

------------------------------------------------------------------------