-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent
local React = require(AuthSignupParent.React)
local Foundation = require(AuthSignupParent.Foundation)
local View = Foundation.View
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local AuthAnalytics = require(AuthSignupParent.AuthAnalytics)
local usernameSuggestionShown = AuthAnalytics.Events.usernameSuggestionShown
local EventStreamConstants = AuthAnalytics.EventStreamConstants

return function(tbl1)
    local tbl2 = ({})
    for i, text in ipairs(tbl1.suggestionUsernames) do
        tbl2[i] = React.createElement(Foundation.Pill, {
            text = text,
            onActivated = function()
                tbl1.onUsernameSelected(text)
            end,
            isDisabled = false
        })
    end

    React.useEffect(function()
        usernameSuggestionShown(
            tbl1.eventContext,
            tbl1.inputUsername,
            tbl1.suggestionUsernames,
            EventStreamConstants.Field.Username
        )
    end, {})

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = { ["size-full-1100 padding-y-small"] = true }
        },
        { React.createElement(Foundation.ScrollView, {
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.XY,
                    CanvasSize = UDim2.fromOffset(0, 0),
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    scrollBarVisibility = ScrollBarVisibility.None
                },
                tag = { ["row gap-small no-wrap size-full-1000"] = true }
            }, tbl2) }
    )
end
