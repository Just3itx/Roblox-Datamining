-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local React = require(DictationCoreParent.React)
local Foundation = require(DictationCoreParent.Foundation)

local CountdownRing = require(script.Parent.CountdownRing)

return React.memo(function(tbl1) -- name: StopCountdownButton
    local countdownProgress = tbl1.countdownProgress

    return React.createElement(Foundation.View, {
        tag = "auto-xy radius-circle",
        Visible = tbl1.Visible,
        LayoutOrder = tbl1.LayoutOrder,
        GroupTransparency = tbl1.transparencyValue
    }, {
        Progress = if countdownProgress == nil then nil else React.createElement(CountdownRing, { countdownProgress = countdownProgress }),
        Icon = React.createElement(Foundation.IconButton, {
            icon = Foundation.Enums.IconName.StopSmall,
            size = Foundation.Enums.InputSize.Small,
            variant = Foundation.Enums.ButtonVariant.Utility,
            isCircular = true,
            onActivated = tbl1.onActivated
        })
    })
end)
