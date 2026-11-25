-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent
local React = require(VirtualEventsParent.React)
local Style = require(VirtualEventsParent.Style)
local useLocalization = require(VirtualEventsParent.Localization).Hooks.useLocalization
local Foundation = require(VirtualEventsParent.Foundation)
local useDesignTokens = Style.useDesignTokens
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FooterCornerButtonStyle = require(VirtualEventsParent.GameTile).FooterCornerButtonStyle

return function(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTokens()

    local var3 = useLocalization({
        notifyMe = "Feature.VirtualEvents.NotifyMe",
        unfollowEvent = "Feature.VirtualEvents.UnfollowEvent",
        joinEvent = "Feature.VirtualEvents.JoinEvent"
    })

    local color3 = var1.Color.ActionEmphasis.Background.Color3
    local color3_2 = var1.Color.ActionEmphasis.Foreground.Color3
    local joinEvent = var3.joinEvent
    if tbl1.buttonStyle == FooterCornerButtonStyle.Follow then
        color3 = var2.Color.ActionSubEmphasis.Background.Color3
        color3_2 = var2.Color.ActionSubEmphasis.Foreground.Color3
        joinEvent = var3.notifyMe
    elseif tbl1.buttonStyle == FooterCornerButtonStyle.Following then
        color3_2 = var2.Color.ActionStandard.Foreground.Color3
        joinEvent = var3.unfollowEvent
    end

    local bool1 = tbl1.buttonStyle == FooterCornerButtonStyle.Following
    local textTransparency = if tbl1.disabled then 0.5 else 0

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, var1.Size.Size_700),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        TextSize = var1.Size.Size_350,
        FontFace = normalizeFontFace(var2.Typography.HeadingSmall.Font),
        BackgroundColor3 = color3,
        TextColor3 = color3_2,
        AutoButtonColor = false,
        Text = joinEvent,
        BackgroundTransparency = if bool1 then 1 else textTransparency,
        TextTransparency = textTransparency,
        [React.Event.Activated] = tbl1.onActivated
    }
    local tbl3 = {
        EventButtonCorners = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Size.Size_200) }),
        OutlineFrame = 0
    }
    local element

    if bool1 then
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, -2, 1, -2),
                Position = UDim2.new(0, 1, 0, 1),
                BackgroundTransparency = 1
            },
            {
                OutlineCorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Size.Size_200 - 2) }),
                OutlineStroke = React.createElement("UIStroke", { Color = color3_2, Transparency = textTransparency, Thickness = 1 })
            }
        )
    else
        element = nil
    end

    tbl3.OutlineFrame = element
    return createElement(str1, tbl2, tbl3)
end
