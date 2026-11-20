-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Otter = require(scriptParentParentParentParent.Otter)

local Colors = require(scriptParentParent.Style.Colors)
local GenericSlider = require(scriptParentParentParent.Core.Slider.GenericSlider)
local Images = require(scriptParentParent.ImageSet.Images)

local tbl1 = { frequency = 5 }

local divideTransparency = require(scriptParentParentParent.Utility.divideTransparency)
local lerp = require(scriptParentParentParent.Utility.lerp)

local function makeAppSlider(arg1, arg2)
    local var1 = Roact.PureComponent:extend("AppSliderFor" .. arg1)

    var1.defaultProps = {
        textInputEnabled = false,
        stepInterval = 1,
        width = UDim.new(1, 0),
        customPressedKnobShadowTransparencyLower = 1
    }

    function var1.init(arg3)
        local pressedProgressLower, var3 = Roact.createBinding(0)
        arg3.pressedProgressLower = pressedProgressLower
        local pressedProgressUpper, var5 = Roact.createBinding(0)
        arg3.pressedProgressUpper = pressedProgressUpper
        local disabled, setDisabled = Roact.createBinding(arg3.props.isDisabled)
        arg3.disabled = disabled
        arg3.setDisabled = setDisabled
        local style, setStyle = Roact.createBinding(arg3.props.style)
        arg3.style = style
        arg3.setStyle = setStyle

        arg3.wasUnmounted = false

        local var10 = Roact.joinBindings({
            disabled = arg3.disabled,
            pressedProgressLower = arg3.pressedProgressLower,
            pressedProgressUpper = arg3.pressedProgressUpper,
            style = arg3.style
        })

        arg3.trackColor = var10:map(function(arg4)
            return arg4.style.Theme.UIMuted.Color
        end)

        arg3.trackTransparency = var10:map(function(arg4)
            return divideTransparency(arg4.style.Theme.UIMuted.Transparency, if arg4.disabled then 2 else 1)
        end)

        arg3.trackFillColor = var10:map(function(arg4)
            return arg4.style.Theme[arg1].Color
        end)

        arg3.trackFillTransparency = var10:map(function(arg4)
            return divideTransparency(arg4.style.Theme[arg1].Transparency, if arg4.disabled then 2 else 1)
        end)

        arg3.knobColorLower = var10:map(function(arg4)
            if arg4.disabled then
                return Colors.Pumice
            end

            local white = Color3.new(1, 1, 1)

            local pumice = Colors.Pumice
            if arg1 ~= "SystemPrimaryDefault" then
                pumice = arg4.style.Theme[arg1].Color
            end

            return white:lerp(pumice, arg4.pressedProgressLower)
        end)

        arg3.knobColorUpper = var10:map(function(arg4)
            if arg4.disabled then
                return Colors.Pumice
            end

            local white = Color3.new(1, 1, 1)

            local pumice = Colors.Pumice
            if arg1 ~= "SystemPrimaryDefault" then
                pumice = arg4.style.Theme[arg1].Color
            end

            return white:lerp(pumice, arg4.pressedProgressUpper)
        end)

        arg3.knobTransparency = var10:map(function(arg4)
            return divideTransparency(arg4.style.Theme[arg1].Transparency, if arg4.disabled then 2 else 1)
        end)

        arg3.knobShadowTransparencyLower = var10:map(function(arg4)
            if arg4.disabled then
                return 1
            end
            local customPressedKnobShadowTransparencyLower = arg3.props.customPressedKnobShadowTransparencyLower
            return lerp(arg4.style.Theme.DropShadow.Transparency, customPressedKnobShadowTransparencyLower, arg4.pressedProgressLower)
        end)

        arg3.knobShadowTransparencyUpper = var10:map(function(arg4)
            if arg4.disabled then
                return 1
            end
            return lerp(arg4.style.Theme.DropShadow.Transparency, 1, arg4.pressedProgressUpper)
        end)

        arg3.pressedMotorLower = Otter.createSingleMotor(0)
        arg3.pressedMotorLower:onStep(var3)

        arg3.pressedMotorUpper = Otter.createSingleMotor(0)
        arg3.pressedMotorUpper:onStep(var5)

        function arg3.onDragStartLower()
            if arg3.props.onDragStartLower then
                arg3.props.onDragStartLower()
            end

            if not arg3.wasUnmounted then
                arg3.pressedMotorLower:setGoal(Otter.spring(1, tbl1))
            end
        end

        function arg3.onDragStartUpper()
            if arg3.props.onDragStartUpper then
                arg3.props.onDragStartUpper()
            end

            if not arg3.wasUnmounted then
                arg3.pressedMotorUpper:setGoal(Otter.spring(1, tbl1))
            end
        end

        function arg3.onDragEnd()
            if arg3.props.onDragEnd then
                arg3.props.onDragEnd()
            end

            if not arg3.wasUnmounted then
                arg3.pressedMotorLower:setGoal(Otter.spring(0, tbl1))
                arg3.pressedMotorUpper:setGoal(Otter.spring(0, tbl1))
            end
        end
    end

    function var1.render(arg3)
        local props = arg3.props

        local knobColorLower = props.customKnobColorLower or arg3.knobColorLower

        local tbl2 = {
            min = props.min,
            max = props.max,
            stepInterval = props.stepInterval,
            isDisabled = props.isDisabled,
            width = props.width,
            position = props.position,
            anchorPoint = props.anchorPoint,
            layoutOrder = props.layoutOrder,
            onValueChanged = props.onValueChanged,
            onDragStartLower = arg3.onDragStartLower,
            onDragStartUpper = arg3.onDragStartUpper,
            onDragEnd = arg3.onDragEnd,
            trackImage = Images["component_assets/circle_16"],
            trackColor = arg3.trackColor,
            trackTransparency = arg3.trackTransparency,
            trackSliceCenter = Rect.new(8, 8, 8, 8),
            trackFillImage = Images["component_assets/circle_16"],
            trackFillColor = arg3.trackFillColor,
            trackFillTransparency = arg3.trackFillTransparency,
            trackFillSliceCenter = Rect.new(8, 8, 8, 8),
            knobImage = Images["component_assets/circle_28_padding_10"],
            knobColorLower = knobColorLower,
            knobColorUpper = arg3.knobColorUpper,
            knobTransparency = arg3.knobTransparency,
            knobImagePadding = 10,
            knobShadowImage = Images["component_assets/dropshadow_28"],
            knobShadowTransparencyLower = arg3.knobShadowTransparencyLower,
            knobShadowTransparencyUpper = arg3.knobShadowTransparencyUpper,
            [Roact.Ref] = props.forwardedRef,
            NextSelectionUp = props.NextSelectionUp,
            NextSelectionDown = props.NextSelectionDown,
            focusController = props.focusController,
            customTrack = props.customTrack,
            customKnobHeight = props.customKnobHeight,
            customKnobBorderSize = props.customKnobBorderSize,
            customKnobBorderColor = props.customKnobBorderColor,
            containerRef = props.containerRef
        }

        if arg2 then
            tbl2.upperValue = props.upperValue
            tbl2.lowerValue = props.lowerValue
        else
            tbl2.lowerValue = props.value
        end

        return Roact.createElement(GenericSlider, tbl2)
    end

    function var1.didMount(arg3)
        arg3.pressedMotorLower:start()
        arg3.pressedMotorUpper:start()
    end

    function var1.didUpdate(arg3, arg4)
        if arg4.style ~= arg3.props.style then
            arg3.setStyle(arg3.props.style)
        end

        if arg4.isDisabled == arg3.props.isDisabled then
            return
        end

        arg3.setDisabled(arg3.props.isDisabled)

        if arg3.props.isDisabled then
            arg3.pressedMotorLower:setGoal(Otter.spring(0, tbl1))
            arg3.pressedMotorUpper:setGoal(Otter.spring(0, tbl1))
        end
    end

    function var1.willUnmount(arg3)
        arg3.wasUnmounted = true

        arg3.pressedMotorLower:destroy()
        arg3.pressedMotorUpper:destroy()
    end

    return var1
end

return makeAppSlider
