-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local Foundation = require(GameJoinCardParent.Foundation)
local React = require(GameJoinCardParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens

local function ViewProfileLink(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        var3(hover == ControlState.Hover)
    end, {})

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        Name = "ViewProfileButton",
        Size = UDim2.new(1, 0, 0, var1.Size.Size_600),
        tag = "row align-x-center align-y-center",
        onActivated = tbl1.onActivated,
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        Label = React.createElement(FoundationText, {
            Text = if var2 then `<u>{tbl1.text}</u>` else tbl1.text,
            RichText = true,
            tag = "auto-xy text-title-medium text-align-x-center content-emphasis"
        })
    }
    return createElement(var5, tbl2, tbl3)
end

return ViewProfileLink
