-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local useTokens = require(Foundation.Providers.Style.useTokens)

local Components = Foundation.Components
local Constants = require(Foundation.Constants)
local Icon = require(Components.Icon)
local _Types = require(Foundation.Components.Types)
local View = require(Components.View)
local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local mapBindable = require(Foundation.Utility.mapBindable)

local useNumberInputVariants = require(Components.NumberInput.useNumberInputVariants)

local _InputSize = require(Foundation.Enums.InputSize)

local _IconSize = require(Foundation.Enums.IconSize)

local _InputVariant = require(Foundation.Enums.InputVariant)

local _NumberInputControlsVariant = require(Foundation.Enums.NumberInputControlsVariant)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local function IncrementButton(tbl1)
    local var1 = useTokens()

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, tbl1.radius),
            offset = var1.Size.Size_150,
            borderWidth = var1.Stroke.Thicker
        }
    end, { tbl1.radius, var1.Size.Size_150, var1.Stroke.Thicker })

    local createElement = React.createElement
    local var3 = View

    local tbl2 = {
        onActivated = tbl1.onActivated,
        isDisabled = not ReactIs.isBinding(tbl1.isDisabled) and tbl1.isDisabled,
        selection = {
            Selectable = mapBindable(tbl1.isDisabled, function(arg1): boolean
                return not arg1
            end)
        },
        stateLayer = {
            affordance = mapBindable(tbl1.isDisabled, function(arg1)
                return if arg1 then StateLayerAffordance.None else StateLayerAffordance.Background
            end)
        },
        cursor = cursor,
        cornerRadius = UDim.new(0, tbl1.radius),
        Size = UDim2.fromOffset(tbl1.size, tbl1.size),
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }

    local tbl3 = { Divider = 0, Icon = 0 }
    local element

    if tbl1.hasDivider then
        element = React.createElement(View, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0, 0.5),
            Size = UDim2.new(0, var1.Stroke.Standard, 1, 0),
            backgroundStyle = var1.Color.Stroke.Default,
            testId = `{tbl1.testId}--divider`
        })
    else
        element = nil
    end

    tbl3.Divider = element

    tbl3.Icon = React.createElement(Icon, {
        name = tbl1.icon,
        size = tbl1.iconSize,
        style = mapBindable(tbl1.isDisabled, function(arg1)
            return {
                Color3 = var1.Color.ActionUtility.Foreground.Color3,
                Transparency = if arg1 then blendTransparencies(var1.Color.ActionUtility.Foreground.Transparency, Constants.DISABLED_TRANSPARENCY) else var1.Color.ActionUtility.Foreground.Transparency
            }
        end),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        testId = `{tbl1.testId}--icon`
    })

    return createElement(var3, tbl2, tbl3)
end

local function IncrementControls(tbl1)
    local var1 = useTokens()
    local controls = useNumberInputVariants(var1, tbl1.size).controls

    return React.createElement(View, {
        tag = controls.tag,
        Size = UDim2.fromOffset(controls.width, controls.buttonSize),
        LayoutOrder = 1,
        testId = `{tbl1.testId}--increment-buttons`
    }, {
        ControlDecrement = React.createElement(IncrementButton, {
            icon = BuilderIcons.Icon.MinusSmall,
            iconSize = controls.iconSize,
            isDisabled = tbl1.decrement.isDisabled,
            onActivated = tbl1.decrement.onClick,
            radius = controls.radius,
            size = controls.buttonSize,
            LayoutOrder = 1,
            testId = `{tbl1.testId}--decrement`
        }),
        ControlIncrement = React.createElement(IncrementButton, {
            icon = BuilderIcons.Icon.PlusSmall,
            iconSize = controls.iconSize,
            hasDivider = tbl1.hasDivider,
            isDisabled = tbl1.increment.isDisabled,
            onActivated = tbl1.increment.onClick,
            radius = controls.radius,
            size = controls.buttonSize,
            LayoutOrder = 2,
            testId = `{tbl1.testId}--increment`
        })
    })
end

local function NumberInputControls(tbl1)
    return React.createElement(IncrementControls, tbl1)
end

return NumberInputControls
