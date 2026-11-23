-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local Types = require(script.Parent.Types)

local ChipGroup = Foundation.ChipGroup
local ChipGroupVariant = Foundation.Enums.ChipGroupVariant
local ChipSize = Foundation.Enums.ChipSize
local Divider = Foundation.Divider
local View = Foundation.View

local SuggestionType = Types.SuggestionType

local tbl1 = {
    [SuggestionType.GameCard] = Foundation.Enums.IconName.Controller,
    [SuggestionType.StartParty] = Foundation.Enums.IconName.ThreePeople
}

return React.memo(function(tbl2) -- name: SmartSuggestionsChipRow
    local chips = ({})
    for k, suggestion in tbl2.suggestions do
        local tbl4 = {
            text = suggestion.display_text,
            leading = tbl1[suggestion.type],
            onActivated = 0
        }

        function tbl4.onActivated()
            tbl2.onActivated(suggestion)
        end

        chips[k] = tbl4
    end

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col gap-small size-full-0 auto-y clip",
        testId = "SmartSuggestionsChipRow--clip"
    }, {
        Divider = React.createElement(Divider, { LayoutOrder = 1, testId = "SmartSuggestionsChipRow--divider" }),
        ChipGroup = React.createElement(ChipGroup, {
            chips = chips,
            LayoutOrder = 2,
            size = ChipSize.Medium,
            variant = ChipGroupVariant.Row,
            testId = "SmartSuggestionsChipRow"
        })
    })
end)
