-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local _Types = require(script.Parent.Types)
local SmartSuggestionsChipRow = require(script.Parent.SmartSuggestionsChipRow)
local useSmartSuggestions = require(script.Parent.useSmartSuggestions)

return React.memo(function(tbl1) -- name: SmartSuggestionsChipRowContainer
    local var1 = useSmartSuggestions(tbl1.conversationId, tbl1.sendMessage, tbl1.sendGameLinkChatMessage)
    local suggestions = tbl1.suggestions or var1.suggestions

    if #suggestions == 0 or var1.areSuggestionsDismissed then
        return nil
    end

    return React.createElement(
        SmartSuggestionsChipRow,
        {
            LayoutOrder = tbl1.LayoutOrder,
            suggestions = suggestions,
            onActivated = var1.onActivated
        }
    )
end)
