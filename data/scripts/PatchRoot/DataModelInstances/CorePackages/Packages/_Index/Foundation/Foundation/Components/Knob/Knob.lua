-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _BuilderIcons = require(FoundationParent.BuilderIcons)
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local Components = Foundation.Components
local Constants = require(Foundation.Constants)
local Icon = require(Components.Icon)
local _Types = require(Components.Types)
local View = require(Components.View)

local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local mapBindable = require(Foundation.Utility.mapBindable)
local useBindable = require(Foundation.Utility.useBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useKnobVariants = require(script.Parent.useKnobVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext
local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local tbl1 = {
    size = require(Foundation.Enums.InputSize).Medium,
    hasShadow = true,
    isDisabled = false,
    testId = "--foundation-knob"
}

return React.memo(function(arg1) -- name: Knob
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePresentationContext()
    local var4 = useKnobVariants(var2, var1.size, var3 and var3.colorNamespace == ColorNamespace.Inverse)

    local style = var1.style or var4.knob.style
    local groupTransparency = mapBindable(style, function(arg2)
        return arg2.Transparency or 0
    end)

    local var6 = useBindable(if var1.stroke then var1.stroke.Transparency else nil)
    local var7 = useBindable(style)
    local var8 = useBindable(var4.knob.style)

    local var9 = React.useMemo(function()
        local size = var4.knob.size
        local var9

        if var1.stroke and var1.stroke.Thickness then
            if ReactIs.isBinding(var1.stroke.Thickness) then
                return var1.stroke.Thickness:map(function(num1: number)
                    return size - UDim2.fromOffset(num1 * 2, num1 * 2)
                end)
            end

            local thickness = var1.stroke.Thickness
            local uDim2 = UDim2.fromOffset(thickness * 2, thickness * 2)
            var9 = size - uDim2
        else
            var9 = size
        end

        return var9
    end, { var4, var1.stroke })

    local createElement = React.createElement
    local var10 = View
    local var11 = withCommonProps(var1, { Size = var4.knob.size, isDisabled = var1.isDisabled })

    local tbl2 = { Icon = 0, Shadow = 0 }
    local var12

    if var1.icon then
        local createElement2 = React.createElement
        local var13 = View
        local tbl3 = {
            tag = var4.knob.tag,
            Size = var9,
            ZIndex = 4,
            backgroundStyle = var4.iconContainer.backgroundStyle
        }

        var12 = createElement2(
            var13,
            tbl3,
            React.createElement(Icon, {
                name = var1.icon.name,
                variant = var1.icon.variant,
                style = if var1.isDisabled then var8:map(function(arg2)
                    return {
                        Color3 = arg2.Color3,
                        Transparency = blendTransparencies(arg2.Transparency, Constants.DISABLED_TRANSPARENCY)
                    }
                end) else var4.knob.style,
                size = var4.knob.iconSize,
                testId = `{var1.testId}--icon`
            })
        )
    else
        local createElement2 = React.createElement
        local var13 = View
        local tbl3 = {
            tag = var4.knob.tag,
            backgroundStyle = 0,
            Size = 0,
            stroke = 0,
            ZIndex = 4,
            testId = 0
        }

        if var1.isDisabled then
            style = var7:map(function(arg2)
                return {
                    Color3 = arg2.Color3,
                    Transparency = blendTransparencies(arg2.Transparency, Constants.DISABLED_TRANSPARENCY)
                }
            end)
        end

        tbl3.backgroundStyle = style

        tbl3.Size = var9
        tbl3.stroke = var6:map(function(arg2)
            local stroke = var1.stroke

            if var1.stroke and arg2 ~= nil and var1.isDisabled then
                stroke = Dash.join(stroke, { Transparency = blendTransparencies(arg2, Constants.DISABLED_TRANSPARENCY) })
            end

            return stroke
        end):getValue()

        tbl3.testId = `{var1.testId}--circle`
        var12 = createElement2(var13, tbl3)
    end

    tbl2.Icon = var12

    tbl2.Shadow = if var1.hasShadow and not var1.isDisabled then React.createElement(View, {
        tag = "position-center-center anchor-center-center radius-circle shadow-raised-100",
        GroupTransparency = groupTransparency,
        Size = var9,
        Visible = mapBindable(groupTransparency, function(num1: number): boolean
            return num1 < 1
        end),
        ZIndex = 3,
        testId = `{var1.testId}--shadow`
    }) else nil

    return createElement(var10, var11, tbl2)
end)
