-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local React = require(VideoUtilsParent.React)

local Foundation = require(VideoUtilsParent.Foundation)
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function RoundIconButton(tbl1)
    local var1 = useTokens()

    return React.createElement(
        View,
        {
            tag = "auto-xy bg-over-media-100 radius-circle padding-medium",
            AnchorPoint = tbl1.AnchorPoint,
            Position = tbl1.Position,
            ZIndex = tbl1.ZIndex,
            onActivated = tbl1.onActivated,
            selection = tbl1.Selectable ~= nil and {
                Selectable = tbl1.Selectable
            } or nil
        },
        {
            Icon = React.createElement(Icon, { name = tbl1.icon, size = IconSize.Medium, style = var1.Color.Content.Emphasis })
        }
    )
end

return RoundIconButton
