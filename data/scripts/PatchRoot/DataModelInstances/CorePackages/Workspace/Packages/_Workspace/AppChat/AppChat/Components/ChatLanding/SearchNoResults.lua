-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function SearchNoResults(tbl1)
    local var1 = useLocalization({ noChatFound = "Feature.Chat.Label.NoChatFound" })

    local var2 = useTokens()
    local uDim = UDim.new(0, var2.Padding.Large)

    return React.createElement(View, {
        tag = "col align-x-center align-y-center gap-small size-full",
        padding = {
            top = UDim.new(0, (tbl1.topPadding or 0) + var2.Padding.Large),
            bottom = uDim,
            left = uDim,
            right = uDim
        }
    }, {
        SearchNoResultsMessage = React.createElement(
            FoundationText,
            {
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-default",
                Text = var1.noChatFound
            }
        )
    })
end
return SearchNoResults
