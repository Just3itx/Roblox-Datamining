-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)

return React.memo(function(tbl1) -- name: PresetBorderlessGridButton
    local var1 = Foundation.Hooks.useTokens()
    local unicode = tbl1.unicode

    local onActivated = React.useCallback(function()
        tbl1.onActivated(unicode)
    end, { tbl1.onActivated, unicode })

    return React.createElement(Foundation.View, {
        LayoutOrder = tbl1.layoutOrder or 0,
        tag = "size-900-900"
    }, {
        Button = React.createElement(Foundation.View, {
            tag = "position-center-center anchor-center-center size-1100-1100 radius-medium",
            backgroundStyle = var1.Color.None,
            onActivated = onActivated,
            selection = { Selectable = true },
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.Background
            },
            ref = tbl1.buttonRef,
            testId = "PresetBorderlessGridButton"
        }, {
            Emoji = React.createElement(Foundation.Text, {
                Text = unicode,
                tag = "position-center-center anchor-center-center size-800-800 text-heading-medium text-align-x-center text-align-y-center content-default"
            })
        })
    })
end)
