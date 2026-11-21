-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local ReactOtter = require(AvatarExperienceControlBarParent.ReactOtter)
local Tooltip = require(AvatarExperienceControlBar.Components.Tooltip)
local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local FFlagAXAddToolTipToIconItemMenu = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXAddToolTipToIconItemMenu
local FFlagAXMigrateBuilderIcons = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons

local isBuilderIcon = Foundation.Utility.isBuilderIcon
local IconVariant = Foundation.Enums.IconVariant

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)
local useHoverBinding = require(AvatarExperienceControlBar.Hooks.useHoverBinding)

local var1 = if FFlagAXMigrateBuilderIcons then Foundation.Enums.IconName.X else "icons/navigation/close"
local tbl1 = { dampingRatio = 1, frequency = 5 }

return React.forwardRef(function(tbl2, ref) -- name: IconItem
    local var2 = useSemanticTokens()
    local var3, onStateChanged = useHoverBinding()

    local var5, var6 = ReactOtter.useAnimatedBinding(0)

    local isActive = tbl2.isActive or false
    local var7 = if tbl2.size then tbl2.size else var2.defaultIconContainerSize
    local var8 = if tbl2.iconSize then tbl2.iconSize elseif FFlagAXMigrateBuilderIcons then var2.defaultLegacyIconSize else var2.defaultIconSize
    local var9 = if tbl2.activeIcon then tbl2.activeIcon else var1
    local variant = if FFlagAXMigrateBuilderIcons then if tbl2.activeIconVariant then tbl2.activeIconVariant else IconVariant.Regular else nil
    local var11 = if tbl2.activeIconSize then tbl2.activeIconSize elseif var9 == var1 then var2.closeIconSize else var8

    React.useEffect(function()
        if tbl2.animate then
            var6(ReactOtter.spring(if isActive then 1 else 0, tbl1))
            return
        end
        var6((ReactOtter.instant(if isActive then 1 else 0)))
    end, { isActive, tbl2.animate })

    if not FFlagAXAddToolTipToIconItemMenu then
        local createElement = React.createElement
        local view = Foundation.View
        local tbl3 = {
            Size = UDim2.new(0, var7, 0, var7),
            onStateChanged = onStateChanged,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            tag = "radius-circle",
            onActivated = tbl2.onActivated,
            disabled = tbl2.disabled,
            ref = ref,
            LayoutOrder = tbl2.LayoutOrder
        }
        local tbl4 = { Icon = 0, ActiveIcon = 0 }
        local createElement2 = React.createElement
        local view2 = Foundation.View

        local tbl5 = {
            Size = UDim2.fromScale(1, 1),
            Visible = not not (not tbl2.isActive or tbl2.animate),
            backgroundStyle = if tbl2.disabled then nil else var3:map(function(arg1)
                return {
                    Color3 = var2.hoverIconBackgroundStyle.Color3,
                    Transparency = if arg1 then var2.hoverIconBackgroundStyle.Transparency else 1
                }
            end),
            tag = FFlagAXMigrateBuilderIcons
                and {
                    ["radius-circle position-center-center anchor-center-center clip"] = true,
                    ["row align-x-center align-y-center"] = isBuilderIcon(tbl2.icon)
                }
                or "radius-circle position-center-center anchor-center-center clip"
        }

        local tbl6 = { IconImage = 0 }
        local var12

        if FFlagAXMigrateBuilderIcons and isBuilderIcon(tbl2.icon) then
            local createElement3 = React.createElement
            local icon = Foundation.Icon

            local tbl7 = {
                name = tbl2.icon,
                size = var5:map(function(num1: number): number
                    return math.round((1 - num1) * var8)
                end),
                variant = if tbl2.iconVariant then tbl2.iconVariant else IconVariant.Regular,
                style = {
                    Color3 = var2.contentForegroundStyle.Color3,
                    Transparency = if tbl2.disabled then var2.contentDisabledTransparency else var2.contentForegroundStyle.Transparency
                },
                tag = "position-center-center anchor-center-center content-emphasis"
            }

            var12 = createElement3(icon, tbl7)
        else
            local createElement3 = React.createElement
            local image = Foundation.Image

            local tbl7 = {
                Image = tbl2.icon,
                Size = var5:map(function(num1: number): UDim2
                    local num2 = math.round((1 - num1) * var8)
                    return UDim2.fromOffset(num2, num2)
                end),
                imageStyle = {
                    Color3 = var2.contentForegroundStyle.Color3,
                    Transparency = if tbl2.disabled then var2.contentDisabledTransparency else var2.contentForegroundStyle.Transparency
                },
                tag = "position-center-center anchor-center-center content-emphasis"
            }

            var12 = createElement3(image, tbl7)
        end

        tbl6.IconImage = var12
        tbl4.Icon = createElement2(view2, tbl5, tbl6)
        local var13

        if isActive or tbl2.animate then
            local createElement3 = React.createElement
            local view3 = Foundation.View

            local tbl7 = {
                Size = UDim2.fromScale(1, 1),
                GroupTransparency = var5:map(function(num1: number): number
                    return 1 - num1
                end),
                backgroundStyle = if tbl2.disabled then nil else var3:map(function(arg1)
                    return if arg1 then var2.hoverIconBackgroundStyle else var2.activeIconBackgroundStyle
                end),
                tag = FFlagAXMigrateBuilderIcons
                    and {
                        ["radius-circle position-center-center anchor-center-center clip"] = true,
                        ["row align-x-center align-y-center"] = isBuilderIcon(var9)
                    }
                    or "radius-circle position-center-center anchor-center-center clip"
            }

            local tbl8 = {
                ActiveIconImage = if FFlagAXMigrateBuilderIcons and isBuilderIcon(var9) then React.createElement(Foundation.Icon, {
                    name = var9,
                    size = var5:map(function(num1: number): number
                        return math.round((1 - num1) * var8)
                    end),
                    variant = variant,
                    tag = "position-center-center anchor-center-center clip content-emphasis"
                }) else React.createElement(Foundation.Image, {
                    Image = var9,
                    Size = var5:map(function(num1: number): UDim2
                        local num2 = math.round(num1 * var11)
                        return UDim2.fromOffset(num2, num2)
                    end),
                    tag = "position-center-center anchor-center-center clip content-emphasis"
                })
            }

            var13 = createElement3(view3, tbl7, tbl8)
        else
            var13 = nil
        end

        tbl4.ActiveIcon = var13
        return createElement(view, tbl3, tbl4)
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        Size = UDim2.new(0, var7, 0, var7),
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row align-x-center align-y-center"
    }
    local tbl4 = { TooltipIconItem = 0 }
    local createElement2 = React.createElement
    local var12 = Tooltip
    local toolTipConfig = tbl2.toolTipConfig
    local createElement3 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        Size = UDim2.new(0, var7, 0, var7),
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "radius-circle",
        onActivated = tbl2.onActivated,
        disabled = tbl2.disabled,
        ref = ref,
        LayoutOrder = tbl2.LayoutOrder
    }
    local tbl6 = { Icon = 0, ActiveIcon = 0 }
    local createElement4 = React.createElement
    local view3 = Foundation.View

    local tbl7 = {
        Size = UDim2.fromScale(1, 1),
        Visible = not not (not tbl2.isActive or tbl2.animate),
        backgroundStyle = if tbl2.disabled then nil else var3:map(function(arg1)
            return {
                Color3 = var2.hoverIconBackgroundStyle.Color3,
                Transparency = if arg1 then var2.hoverIconBackgroundStyle.Transparency else 1
            }
        end),
        tag = FFlagAXMigrateBuilderIcons
            and {
                ["radius-circle position-center-center anchor-center-center clip"] = true,
                ["row align-x-center align-y-center"] = isBuilderIcon(tbl2.icon)
            }
            or "radius-circle position-center-center anchor-center-center clip"
    }

    local tbl8 = { IconImage = 0 }
    local var13

    if FFlagAXMigrateBuilderIcons and isBuilderIcon(tbl2.icon) then
        local createElement5 = React.createElement
        local icon = Foundation.Icon

        local tbl9 = {
            name = tbl2.icon,
            size = var5:map(function(num1: number): number
                return math.round((1 - num1) * var8)
            end),
            variant = if tbl2.iconVariant then tbl2.iconVariant else IconVariant.Regular,
            style = {
                Color3 = var2.contentForegroundStyle.Color3,
                Transparency = if tbl2.disabled then var2.contentDisabledTransparency else var2.contentForegroundStyle.Transparency
            },
            tag = "position-center-center anchor-center-center content-emphasis"
        }

        var13 = createElement5(icon, tbl9)
    else
        local createElement5 = React.createElement
        local image = Foundation.Image

        local tbl9 = {
            Image = tbl2.icon,
            Size = var5:map(function(num1: number): UDim2
                local num2 = math.round((1 - num1) * var8)
                return UDim2.fromOffset(num2, num2)
            end),
            imageStyle = {
                Color3 = var2.contentForegroundStyle.Color3,
                Transparency = if tbl2.disabled then var2.contentDisabledTransparency else var2.contentForegroundStyle.Transparency
            },
            tag = "position-center-center anchor-center-center content-emphasis"
        }

        var13 = createElement5(image, tbl9)
    end

    tbl8.IconImage = var13
    tbl6.Icon = createElement4(view3, tbl7, tbl8)
    local var14

    if isActive or tbl2.animate then
        local createElement5 = React.createElement
        local view4 = Foundation.View

        local tbl9 = {
            Size = UDim2.fromScale(1, 1),
            GroupTransparency = var5:map(function(num1: number): number
                return 1 - num1
            end),
            backgroundStyle = if tbl2.disabled then nil else var3:map(function(arg1)
                return if arg1 then var2.hoverIconBackgroundStyle else var2.activeIconBackgroundStyle
            end),
            tag = FFlagAXMigrateBuilderIcons
                and {
                    ["radius-circle position-center-center anchor-center-center clip"] = true,
                    ["row align-x-center align-y-center"] = isBuilderIcon(var9)
                }
                or "radius-circle position-center-center anchor-center-center clip"
        }

        local tbl10 = { ActiveIconImage = 0 }
        local element

        if FFlagAXMigrateBuilderIcons and isBuilderIcon(var9) then
            local createElement6 = React.createElement
            local icon = Foundation.Icon

            local tbl11 = {
                name = var9,
                size = var5:map(function(num1: number): number
                    return math.round(num1 * var8)
                end),
                variant = variant,
                style = {
                    Color3 = var2.contentForegroundStyle.Color3,
                    Transparency = if tbl2.disabled then var2.contentDisabledTransparency else var2.contentForegroundStyle.Transparency
                },
                tag = "size-full-full position-center-center anchor-center-center content-emphasis"
            }

            element = createElement6(icon, tbl11)
        else
            element = React.createElement(Foundation.Image, {
                Image = var9,
                Size = var5:map(function(num1: number): UDim2
                    local num2 = math.round(num1 * var11)
                    return UDim2.fromOffset(num2, num2)
                end),
                tag = "position-center-center anchor-center-center clip content-emphasis"
            })
        end

        tbl10.ActiveIconImage = element
        var14 = createElement5(view4, tbl9, tbl10)
    else
        var14 = nil
    end

    tbl6.ActiveIcon = var14
    tbl4.TooltipIconItem = createElement2(var12, toolTipConfig, createElement3(view2, tbl5, tbl6))
    return createElement(view, tbl3, tbl4)
end)
