-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Cryo = require(ServerDrivenUiParent.Cryo)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens

local SduiTextIconRow = require(ServerDrivenUi.Content.SduiTextIconRow)
local useCountdownSubtitleTextBinding = require(ServerDrivenUiParent.GameCollections).useCountdownSubtitleTextBinding

return React.memo(function(arg1) -- name: SduiCountdownTextIconRow
    local var1 = useTokens()

    local fontStyle = arg1.fontStyle or var1.Typography.BodyMedium
    local var3 = arg1.textColor or var1.Color.Content.Default.Color3
    local gap = arg1.gap or var1.Gap.XXSmall
    local iconWidth = arg1.iconWidth or var1.Size.Size_400
    local selectable = arg1.onActivated ~= nil

    local text = useCountdownSubtitleTextBinding(arg1.endTimestamp, arg1.formatStringHoursMinutes, arg1.defaultString)

    return React.createElement(
        SduiTextIconRow,
        Cryo.Dictionary.join({
            gap = gap,
            fontStyle = fontStyle,
            textColor = var3,
            textFlexMode = Enum.UIFlexMode.Shrink,
            icon = arg1.icon,
            iconWidth = iconWidth,
            iconColor = var3,
            selectable = selectable,
            testId = "--sdui-countdown-text-icon-row"
        }, arg1, { text = text })
    )
end)
