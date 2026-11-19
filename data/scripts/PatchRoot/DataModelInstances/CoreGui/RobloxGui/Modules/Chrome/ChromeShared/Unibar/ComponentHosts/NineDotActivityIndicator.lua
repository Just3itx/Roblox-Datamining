-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)

local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local View = Foundation.View

local function NineDotActivityIndicator(tbl1)
    if not tbl1.visible or tbl1.hasNotificationBadge then
        return nil
    end

    return React.createElement(
        View,
        {
            Position = tbl1.position,
            tag = "anchor-top-left auto-xy padding-xxsmall radius-circle bg-surface-0",
            testId = "nine-dot-activity-indicator"
        },
        {
            Indicator = React.createElement(StatusIndicator, { variant = StatusIndicatorVariant.Emphasis })
        }
    )
end

return NineDotActivityIndicator
