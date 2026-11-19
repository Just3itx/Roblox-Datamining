-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:29Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local BrickColorPicker = require(Foundation.Components.ColorPicker.BrickColorPicker)
local ColorInputMode = require(Foundation.Enums.ColorInputMode)
local ColorInputs = require(Foundation.Components.ColorPicker.ColorInputs)
local ColorSlider = require(Foundation.Components.ColorPicker.ColorSlider)
local ColorSliderType = require(Foundation.Enums.ColorSliderType)
local SVPicker = require(Foundation.Components.ColorPicker.SVPicker)
local View = require(Foundation.Components.View)

local colorUtils = require(Foundation.Components.ColorPicker.colorUtils)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Types = require(Foundation.Components.Types)

local tbl1 = {
    initialAlpha = 1,
    initialMode = ColorInputMode.RGB,
    testId = "--foundation-color-picker"
}

local function resolveInitialHSV(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "table" then
        return arg1.H / 360, (arg1.S or 100) / 100, (arg1.V or 100) / 100
    end
    return arg1:ToHSV()
end

local function ColorPicker(arg1)
    local availableModes = arg1.availableModes or {
        ColorInputMode.RGB,
        ColorInputMode.HSV,
        ColorInputMode.Hex,
        ColorInputMode.Brick
    }
    local var2 = withDefaults(arg1, tbl1)
    local color3 = useTokens().Color.Extended.Magenta.Magenta_700.Color3

    local var3 = var2.initialColor or color3

    local color, var5 = React.useBinding(var3)
    local var6, var7, var8 = resolveInitialHSV(var3)
    local var9, var10 = React.useBinding(var6)
    local saturation, var12 = React.useBinding(var7)
    local value, var14 = React.useBinding(var8)
    local var15, var16 = React.useBinding(var2.initialAlpha or 1)
    local mode, onModeChanged = React.useState(var2.initialMode or ColorInputMode.RGB)

    local var19 = color:map(colorUtils.toColor3)

    local var20 = color:map(function(arg2): boolean
        return not colorUtils.isPartialHSV(arg2)
    end)

    local var21 = React.useRef(false)

    React.useEffect(function()
        local initialMode = var2.initialMode

        if not initialMode then
            return
        end

        local bool1 = false
        for _, value in availableModes do
            if value == initialMode then
                bool1 = true
                break
            end
        end

        if not bool1 then
            warn(`ColorPicker: initialMode {initialMode} is not in availableModes. Using first available mode.`)
            onModeChanged(availableModes[1])
        end
    end, { var2.initialMode })

    local var22 = React.useCallback(function(color3_2: Color3, arg2)
        var5(color3_2)
        var2.onColorChanged(color3_2, arg2)
    end, { var2.onColorChanged })

    local onValueChanged = React.useCallback(function(arg2)
        var16(arg2)
        if var2.onAlphaChanged then
            var2.onAlphaChanged(arg2)
        end
    end, { var2.onAlphaChanged })

    local onBrickColorChanged = React.useCallback(function(arg2)
        var22(arg2.Color, arg2)
    end, { var22 })

    local bool1 = var2.onAlphaChanged ~= nil

    local var25 = React.useCallback(function(arg2)
        var22(arg2, nil)
    end, { var22 })

    local var26 = React.useCallback(
        colorUtils.createHSVUpdateHandler(var10, var12, var14, var25, var21),
        {
            var25,
            var10,
            var12,
            var14,
            var5
        }
    )
    local onColorChanged = React.useCallback(
        colorUtils.createColorInputChangeHandler(var25, var21, var10, var12, var14),
        {
            var25,
            var21,
            var10,
            var12,
            var14
        }
    )
    React.useEffect(function()
        local var28, var29, var30 = var19:getValue():ToHSV()
        var10(var28)
        var12(var29)
        var14(var30)
    end, {})

    local createElement = React.createElement
    local var28 = View
    local var29 = withCommonProps(var2, { tag = "col gap-small size-full-0 auto-y padding-small" })

    local tbl2 = {
        ColorInputs = React.createElement(ColorInputs, {
            color = color,
            alpha = var15,
            onColorChanged = onColorChanged,
            onAlphaChanged = if bool1 then onValueChanged else nil,
            mode = mode,
            onModeChanged = onModeChanged,
            availableModes = availableModes,
            LayoutOrder = 1,
            testId = `{var2.testId}--input`
        }),
        BrickPicker = if mode == ColorInputMode.Brick then React.createElement(BrickColorPicker, {
            selectedColor = var19,
            onBrickColorChanged = onBrickColorChanged,
            LayoutOrder = 2,
            testId = `{var2.testId}--brick-picker`
        }) else nil,
        SVPickerContainer = 0,
        HueSlider = 0,
        AlphaSlider = 0
    }
    local element

    if mode == ColorInputMode.Brick then
        element = nil
    else
        element = React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 156),
            LayoutOrder = 2
        }, {
            SVPicker = React.createElement(SVPicker, {
                hue = var9,
                saturation = saturation,
                value = value,
                onChanged = function(arg2, arg3)
                    var26(var9:getValue(), arg2, arg3)
                end,
                onDragStarted = var2.onDragStarted,
                onDragEnded = var2.onDragEnded,
                showSelectionKnob = var20:getValue(),
                testId = `{var2.testId}--sv-picker`
            })
        })
    end

    tbl2.SVPickerContainer = element

    tbl2.HueSlider = if mode == ColorInputMode.Brick then nil else React.createElement(ColorSlider, {
        sliderType = ColorSliderType.Hue,
        value = var9,
        onValueChanged = function(arg2)
            var26(arg2, saturation:getValue(), value:getValue())
        end,
        onDragStarted = var2.onDragStarted,
        onDragEnded = var2.onDragEnded,
        LayoutOrder = 3,
        testId = `{var2.testId}--hue-slider`
    })

    tbl2.AlphaSlider = if bool1 then React.createElement(ColorSlider, {
        sliderType = ColorSliderType.Alpha,
        value = var15,
        baseColor = var19,
        onValueChanged = onValueChanged,
        onDragStarted = var2.onDragStarted,
        onDragEnded = var2.onDragEnded,
        LayoutOrder = 4,
        testId = `{var2.testId}--alpha-slider`
    }) else nil
    return createElement(var28, var29, tbl2)
end

return ColorPicker
