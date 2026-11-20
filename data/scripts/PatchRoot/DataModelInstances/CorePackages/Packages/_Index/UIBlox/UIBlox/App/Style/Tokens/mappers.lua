-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParent.Parent.Parent.Parent

local Cryo = require(scriptParentParentParentParentParent.Cryo)

local _Types = require(script.Parent.Types)
local _StyleTypes = require(scriptParentParent.StyleTypes)

local function getOnHoverColor(background, arg1)
    local hover = arg1.Color.State.Hover

    if hover.Transparency == 1 then
        return {
            Color3 = background.Color3,
            Transparency = background.Transparency
        }
    end

    if background.Color3 == nil or background.Transparency == 1 then
        return {
            Color3 = hover.Color3,
            Transparency = hover.Transparency
        }
    end

    return {
        Color3 = background.Color3:Lerp(hover.Color3, 1 - hover.Transparency),
        Transparency = background.Transparency
    }
end

local tbl1 = {
    "Color",
    "Config",
    "DarkMode",
    "Ease",
    "LightMode",
    "Inverse",
    "Size",
    "Padding",
    "Margin",
    "Gap",
    "Gutter",
    "Radius",
    "Stroke",
    "LineHeight",
    "FontSize",
    "FontWeight",
    "Time",
    "Typography"
}

return {
    mapColorTokensToFoundation = function(arg1, arg2)
        arg1.Semantic.Color = Cryo.Dictionary.join(arg1.Semantic.Color, arg2.Semantic.Color)
        arg1.Global.Color = Cryo.Dictionary.join(arg1.Global.Color, arg2.Global.Color)
        arg1.Component = Cryo.Dictionary.join(arg1.Component, arg2.Component)

        return arg1
    end,
    mapThemeToFoundation = function(arg1, arg2)
        local tbl2 = {
            BackgroundDefault = arg2.Color.Surface.Surface_0,
            BackgroundContrast = arg2.Color.Surface.Surface_100,
            BackgroundMuted = arg2.Color.Surface.Surface_200,
            BackgroundUIDefault = arg2.Color.Surface.Surface_300,
            BackgroundUIContrast = arg2.Color.OverMedia.OverMedia_0,
            BackgroundOnHover = arg2.Color.State.Hover,
            BackgroundOnPress = arg2.Color.State.Press,
            UIDefault = arg2.Color.Shift.Shift_200,
            UIMuted = arg2.Color.Shift.Shift_100,
            UIEmphasis = arg2.Color.Shift.Shift_400,
            ContextualPrimaryDefault = arg2.Color.ActionEmphasis.Background,
            ContextualPrimaryOnHover = getOnHoverColor(arg2.Color.ActionEmphasis.Background, arg2),
            ContextualPrimaryContent = arg2.Color.ActionEmphasis.Foreground,
            SystemPrimaryDefault = arg2.Color.ActionSubEmphasis.Background,
            SystemPrimaryOnHover = getOnHoverColor(arg2.Color.ActionSubEmphasis.Background, arg2),
            SystemPrimaryContent = arg2.Color.ActionSubEmphasis.Foreground,
            IconDefault = arg2.Color.Content.Default,
            IconEmphasis = arg2.Color.Content.Emphasis,
            IconOnHover = arg2.Color.Content.Emphasis,
            TextEmphasis = arg2.Color.Content.Emphasis,
            TextDefault = arg2.Color.Content.Default,
            TextMuted = arg2.Color.Content.Muted,
            TextLink = arg2.Color.Content.Link,
            Divider = arg2.Color.Stroke.Emphasis,
            Overlay = arg2.Color.Common.Scrim,
            DropShadow = arg2.Color.Common.Shadow,
            NavigationBar = arg2.Color.Common.NavigationBar,
            PlaceHolder = arg2.Color.Common.Shimmer,
            OnlineStatus = arg2.Color.System.Success,
            OfflineStatus = arg2.Color.System.Neutral,
            Success = arg2.Color.System.Success,
            Alert = arg2.Color.System.Alert,
            Badge = arg2.Color.System.Contrast,
            BadgeContent = arg2.Inverse.Content.Emphasis
        }

        return (Cryo.Dictionary.join(arg1, Cryo.Dictionary.map(tbl2, function(arg3)
            return {
                Color = arg3.Color3,
                Transparency = arg3.Transparency
            }
        end)))
    end,
    addFoundationFlatKeys = function(arg1, arg2)
        for _, value in tbl1 do
            arg1[value] = arg2[value]
        end

        return arg1
    end
}
