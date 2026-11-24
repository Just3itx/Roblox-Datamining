-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)

return React.memo(function(tbl1) -- name: StopCountdown
    return React.createElement(Foundation.View, {
        tag = "auto-xy radius-circle",
        Visible = tbl1.Visible,
        LayoutOrder = tbl1.LayoutOrder,
        GroupTransparency = tbl1.transparencyValue
    }, {
        Progress = React.createElement(Foundation.Progress, {
            tag = "position-center-center anchor-center-center",
            shape = Foundation.Enums.ProgressShape.Circle,
            size = Foundation.Enums.ProgressSize.Medium,
            value = tbl1.countdownProgress:map(function(num1: number): number
                return math.clamp(num1, 0, 1) * 100
            end),
            ZIndex = 2
        }),
        Icon = React.createElement(Foundation.IconButton, {
            icon = Foundation.Enums.IconName.StopSmall,
            size = Foundation.Enums.InputSize.Small,
            variant = Foundation.Enums.ButtonVariant.Utility,
            isCircular = true,
            onActivated = tbl1.onActivated
        })
    })
end)
