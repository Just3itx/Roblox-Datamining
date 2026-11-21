-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local ColorGradientCircle = require(AvatarExperienceControlBarParent.AvatarExperienceCommon).Components.ColorGradientCircle

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)
local useHoverBinding = require(AvatarExperienceControlBar.Hooks.useHoverBinding)

local stateLayer = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function getHoverTransparency(arg1): number
    return if arg1 then 0 else 0.2
end

return React.forwardRef(function(tbl2, ref) -- name: ColorItem
    local var1 = useSemanticTokens()
    local var2, var3 = useHoverBinding()
    local var4 = if tbl2.size then tbl2.size else var1.defaultIconContainerSize
    local var5 = if tbl2.colorSize then tbl2.colorSize else var4
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        ref = ref,
        LayoutOrder = tbl2.LayoutOrder,
        stateLayer = stateLayer,
        onStateChanged = 0,
        onActivated = 0,
        AutomaticSize = 0,
        disabled = 0,
        selection = 0
    }

    if tbl2.disabled then
        var3 = nil
    end

    tbl3.onStateChanged = var3
    tbl3.onActivated = tbl2.onActivated
    tbl3.AutomaticSize = Enum.AutomaticSize.XY
    tbl3.disabled = tbl2.disabled
    tbl3.selection = {
        Selectable = tbl2.Selectable or false
    }

    return createElement(view, tbl3, {
        HoverHandler = React.createElement(Foundation.View, {
            Size = UDim2.fromOffset(var4, var4),
            GroupTransparency = var2:map(getHoverTransparency),
            backgroundStyle = var2:map(function(arg1)
                if arg1 then
                    return var1.hoverIconBackgroundStyle
                end

                if tbl2.isActive then
                    return var1.activeIconBackgroundStyle
                end

                return {
                    Color3 = var1.hoverIconBackgroundStyle.Color3,
                    Transparency = 1
                }
            end),
            tag = "padding-small radius-circle clip auto-xy"
        }, {
            ColorGradientCircle = React.createElement(ColorGradientCircle, {
                Colors = tbl2.colors,
                Size = UDim2.fromOffset(var5, var5),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            })
        })
    })
end)
