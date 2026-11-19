-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local Dropdown = require(Foundation.Components.Dropdown)
local NumberInput = require(Foundation.Components.NumberInput)
local TextInput = require(Foundation.Components.TextInput)
local View = require(Foundation.Components.View)

local ColorInputMode = require(Foundation.Enums.ColorInputMode)

local InputSize = require(Foundation.Enums.InputSize)
local NumberInputControlsVariant = require(Foundation.Enums.NumberInputControlsVariant)

local colorInputUtils = require(Foundation.Components.ColorPicker.colorInputUtils)
local colorUtils = require(Foundation.Components.ColorPicker.colorUtils)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function createNumberInputElement(arg1, controlsVariant, tbl1: {LayoutOrder: number, label: string, size: any, testId: string, width: UDim})
    local value = arg1.value:getValue()

    if value ~= nil then
        return React.createElement(
            NumberInput,
            Dash.join({
                value = value,
                onChanged = function(num1: number)
                    arg1.handler(num1, arg1.component)
                end,
                controlsVariant = controlsVariant,
                minimum = arg1.minimum or 0,
                maximum = arg1.maximum or 255,
                step = arg1.step or 1,
                precision = arg1.precision or 0
            }, tbl1)
        )
    end

    return React.createElement(
        NumberInput,
        Dash.join({
            value = -1,
            onChanged = function(num1: number)
                if num1 ~= -1 then
                    arg1.handler(num1, arg1.component)
                end
            end,
            controlsVariant = controlsVariant,
            minimum = arg1.minimum or 0,
            maximum = arg1.maximum or 255,
            step = arg1.step or 1,
            precision = arg1.precision or 0,
            formatAsString = function(_: number): string
                return ""
            end
        }, tbl1)
    )
end

local function renderInput(_, arg1, layoutOrder: number, str1: string, testId: string?)
    local str2 = if str1 == arg1.key:lower() then "" else `-{arg1.key:lower()}`
    local tbl1 = {
        size = InputSize.XSmall,
        label = "",
        width = UDim.new(1, 0),
        LayoutOrder = layoutOrder,
        testId = `{testId}-{str1}{str2}`
    }

    if arg1.key ~= ColorInputMode.Hex then
        return React.createElement(
            View,
            { tag = "grow-1 size-0-full", LayoutOrder = layoutOrder },
            {
                Input = createNumberInputElement(arg1, NumberInputControlsVariant.None, tbl1)
            }
        )
    end

    return React.createElement(View, { tag = "grow-1 size-0-full", LayoutOrder = layoutOrder }, {
        Input = React.createElement(TextInput, {
            text = arg1.value:getValue(),
            onChanged = function(str3: string)
                arg1.handler(str3, arg1.component)
            end,
            placeholder = arg1.placeholder or "#000000",
            size = InputSize.XSmall,
            label = "",
            width = UDim.new(1, 0),
            testId = `{testId}-{str1}`
        })
    })
end

local tbl1 = {
    alpha = React.createBinding(1)
}

local function ColorInputs(arg1)
    local var1 = arg1.availableModes or {
        ColorInputMode.RGB,
        ColorInputMode.HSV,
        ColorInputMode.Hex,
        ColorInputMode.Brick
    }
    local var2 = withDefaults(arg1, tbl1)
    local var3 = useTokens()
    local value = var2.mode or ColorInputMode.RGB
    local color = var2.color
    local alpha = var2.alpha

    local var5 = React.useCallback(function(arg2)
        if var2.onColorChanged then
            var2.onColorChanged(arg2)
        end
    end, { var2.onColorChanged })

    local onAlphaChanged = var2.onAlphaChanged
    local bool1 = var2.onAlphaChanged ~= nil

    local var6 = color:map(function(arg2)
        if colorUtils.isPartialHSV(arg2) then
            return { r = nil, g = nil, b = nil }
        end
        local var6 = colorUtils.toColor3(arg2)
        return {
            r = math.round(var6.R * 255),
            g = math.round(var6.G * 255),
            b = math.round(var6.B * 255)
        }
    end)

    local var7 = color:map(function(arg2)
        if type(arg2) == "table" then
            return {
                h = arg2.H,
                s = arg2.S,
                v = arg2.V
            }
        end

        local var7, var8, var9 = arg2:ToHSV()
        return {
            h = math.round(var7 * 360),
            s = math.round(var8 * 100),
            v = math.round(var9 * 100)
        }
    end)

    local var8 = var6:map(function(tbl2): string
        if tbl2.r ~= nil and tbl2.g ~= nil and tbl2.b ~= nil then
            return string.format("#%02X%02X%02X", tbl2.r, tbl2.g, tbl2.b)
        end
        return ""
    end)

    local var9 = React.useCallback(function(num1: number, str1: string?)
        local num2 = math.clamp(num1, 0, 255)

        local var9 = table.clone(var6:getValue())
        var9[str1] = num2

        if var9.r == nil or var9.g == nil or var9.b == nil then
            return
        end

        local color3 = Color3.fromRGB(var9.r, var9.g, var9.b)
        var5(color3)
    end, { var6, var5 })

    local var10 = React.useCallback(function(num1: number)
        if onAlphaChanged then
            onAlphaChanged(num1)
        end
    end, { onAlphaChanged })

    local var11 = React.useCallback(function(num1: number, str1: string?)
        local var11 = table.clone(var7:getValue())

        if var11[str1] == nil and num1 == 0 then
            return
        end
        var11[str1] = math.clamp(num1, 0, if str1 == "h" then 360 else 100)

        local color3 = Color3.fromHSV(var11.h / 360, (var11.s or 100) / 100, (var11.v or 100) / 100)
        var5(color3)
    end, { var7, var5 })

    local var12 = React.useCallback(function(str1: string)
        local var12 = str1:gsub("#", ""):upper()

        if not var12:match("^%x%x%x%x%x%x$") then
            return
        end

        local red = tonumber(var12:sub(1, 2), 16)
        local green = tonumber(var12:sub(3, 4), 16)
        local blue = tonumber(var12:sub(5, 6), 16)

        if red and green and blue then
            local color3 = Color3.fromRGB(red, green, blue)
            var5(color3)
        end
    end, { var5 })

    local items = React.useMemo(function()
        local tbl2 = {
            {
                id = ColorInputMode.RGB,
                text = ColorInputMode.RGB
            },
            {
                id = ColorInputMode.HSV,
                text = ColorInputMode.HSV
            },
            {
                id = ColorInputMode.Hex,
                text = ColorInputMode.Hex
            },
            {
                id = ColorInputMode.Brick,
                text = ColorInputMode.Brick
            }
        }

        if bool1 then
            table.insert(tbl2, 2, { id = ColorInputMode.RGBA, text = ColorInputMode.RGBA })
        end

        local var13 = var1
        if not var13 then
            return tbl2
        end

        local result = {}

        for _, value in tbl2 do
            local id = value.id
            for _, value2 in var13 do
                if id == value2 or id == ColorInputMode.RGBA and value2 == ColorInputMode.RGB and bool1 then
                    table.insert(result, value)
                    break
                end
            end
        end

        return result
    end, { bool1 })

    React.useEffect(function()
        if value == ColorInputMode.RGBA and not bool1 and var2.onModeChanged then
            var2.onModeChanged(ColorInputMode.RGB)
        end
    end, { value, bool1 })

    local function func1()
        if value ~= ColorInputMode.Brick then
            local var14 = colorInputUtils.createInputConfigs(var6, var7, var8, alpha, var9, var11, var12, var10, var3)[value]
            if not var14 then
                return nil
            end
            local result = {}
            for i, value2 in ipairs(var14) do
                result[value2.key .. "Input"] = renderInput(var3, value2, i, value:lower(), var2.testId)
            end
            return result
        end

        return {
            BrickColorName = React.createElement(View, {
                tag = "grow-1 size-0-full",
                LayoutOrder = 1
            }, {
                Input = React.createElement(TextInput, {
                    text = BrickColor.new(color:getValue()).Name,
                    onChanged = function() end,
                    isDisabled = true,
                    size = InputSize.XSmall,
                    label = "",
                    width = UDim.new(1, 0),
                    testId = `{var2.testId}-brick-name`
                })
            })
        }
    end

    local createElement = React.createElement
    local var14 = View
    local var15 = withCommonProps(var2, { tag = "row gap-xsmall size-full-600" })

    return createElement(
        var14,
        var15,
        Dash.join({
            ModeDropdown = if #items > 1 then React.createElement(Dropdown.Root, {
                items = items,
                value = value,
                onItemChanged = function(arg2)
                    if var2.onModeChanged then
                        var2.onModeChanged(arg2)
                    end
                end,
                size = InputSize.XSmall,
                label = "",
                width = UDim.new(0, var3.Size.Size_1600),
                testId = `{var2.testId}--mode-dropdown`
            }) else nil
        }, (func1()))
    )
end

return ColorInputs
