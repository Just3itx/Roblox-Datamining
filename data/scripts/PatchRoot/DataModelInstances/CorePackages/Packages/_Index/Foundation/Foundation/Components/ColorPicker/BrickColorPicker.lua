-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local BrickColorConstants = require(Foundation.Components.ColorPicker.BrickColorConstants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local Wrappers = require(Foundation.Utility.Wrappers)
local Connection = Wrappers.Connection
local Signal = Wrappers.Signal

local function calculateGridRadius(num1: number)
    for i = 3, 20, 2 do
        local num2 = i * i
        local num3 = math.floor(i / 2)

        if num1 < num2 - num3 * (math.floor(i / 2) + 1) then
            return i - 2
        end
    end
    return 7
end

local function BottomRowSwatches(tbl1)
    local var1, var2 = React.useState(0)
    local ref = React.useRef(nil)

    React.useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        local num1 = math.round(current.AbsoluteSize.X)
        if num1 ~= var1 then
            var2(num1)
        end
        local var4 = Signal.Connect(current:GetPropertyChangedSignal("AbsoluteSize"), function()
            var2(math.round(current.AbsoluteSize.X))
        end)
        return function()
            Connection.Disconnect(var4)
        end
    end, { var1 })

    local tbl2 = ({})
    if var1 > 0 then
        local colorsLen = #tbl1.colors

        local var4 = var1 - tbl1.paddingHorizontal * 2
        local num1 = math.floor(var4 / colorsLen)
        local num2 = num1 * (colorsLen - 1)
        local var5 = tbl1.paddingHorizontal + math.floor((var4 - num2) / 2)

        for i, color in ipairs(tbl1.colors) do
            local xOffset = var5 + num1 * (i - 1)

            local str1 = `Swatch_{i}`
            tbl2[str1] = React.createElement(Image, {
                Size = UDim2.fromOffset(tbl1.swatchWidth, tbl1.swatchHeight),
                Position = UDim2.fromOffset(xOffset, tbl1.swatchCenterY),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = "component_assets/hexagon_24",
                imageStyle = {
                    Color3 = color.Color
                }
            })
        end
    end
    return React.createElement(View, { tag = "size-full", ref = ref }, tbl2)
end

local function BrickColorPicker(arg1)
    local var1 = useTokens()

    local size200 = var1.Size.Size_200
    local size350 = var1.Size.Size_350
    local size400 = var1.Size.Size_400
    local size100 = var1.Size.Size_100
    local size350_2 = var1.Size.Size_350
    local size400_2 = var1.Size.Size_400
    local size200_2 = var1.Size.Size_200

    local var2 = React.useMemo(function()
        return BrickColorConstants.MAIN
    end, {})

    local colors = React.useMemo(function()
        return BrickColorConstants.BOTTOM
    end, {})

    local var4 = React.useMemo(function()
        local gridRadius = calculateGridRadius(#var2)
        if not (gridRadius < 3) then
            return gridRadius
        end

        warn("BrickColorPicker: Calculated grid radius is too small, falling back to minimum")
        return 3
    end, {})

    local var5, var6 = React.useMemo(function()
        local tbl1 = {}

        local num1 = 1
        local var5 = var4
        local var6 = size200 + 1
        local var7 = size200
        local num2 = math.round(var6 * 1.5)

        for i = 0, var5 - 1 do
            for j = 0, 2 * var5 - 1 - 1 do
                local num3 = math.abs(math.floor(var5 / 2) - i)
                if not (num3 + math.abs(math.floor((2 * var5 - 1) / 2) - j) < var5) or i % 2 ~= j % 2 or not (num1 <= #var2) then
                    continue
                end
                local x = var7 * j
                local var9 = if num2 then num2 * i else math.round(var6 * 1.5 * i)
                table.insert(tbl1, { brickColor = var2[num1], x = x, y = var9 })

                num1 += 1
            end
        end

        local huge = math.huge
        local huge2 = -math.huge
        local huge3 = math.huge
        local huge4 = -math.huge

        for _, value in tbl1 do
            huge = math.min(huge, value.x - size350 / 2)
            huge2 = math.max(huge2, value.x + size350 / 2)
            huge3 = math.min(huge3, value.y - size400 / 2)
            huge4 = math.max(huge4, value.y + size400 / 2)
        end

        return tbl1, {
            width = huge2 - huge,
            height = huge4 - huge3,
            offset = Vector2.new(huge, huge3)
        }
    end, {
        var4,
        size200,
        var2,
        colors,
        var1.Size.Size_100,
        var1.Size.Size_50
    })

    local onActivated = React.useCallback(function(arg2, arg3)
        if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        local var7 = nil
        local huge = math.huge
        local var8 = arg3.Position.X - arg2.AbsolutePosition.X
        local var9 = arg3.Position.Y - arg2.AbsolutePosition.Y
        local var10 = var8 + var6.offset.X
        local var11 = var9 + var6.offset.Y

        for _, value in var5 do
            local var12 = (var10 - value.x) ^ 2 + (var11 - value.y) ^ 2
            if var12 < huge then
                var7 = value
                huge = var12
            end
        end

        if not var7 or not (huge < size200 * size200) then
            return
        end

        arg1.onBrickColorChanged(var7.brickColor)
        if arg1.onColorChanged then
            arg1.onColorChanged(var7.brickColor.Color)
        end
    end, {
        var5,
        var6,
        size200,
        arg1.onBrickColorChanged,
        arg1.onColorChanged
    })
    local var3 = React.useCallback(function(arg2, arg3)
        if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        local var8 = arg3.Position.X - arg2.AbsolutePosition.X
        local var9 = arg2.AbsoluteSize.X - 2 * size100
        local var10 = var8 - size100

        if not (var10 >= 0) or not (var10 <= var9) then
            return
        end

        local num1 = math.clamp(math.floor(var10 / var9 * #colors) + 1, 1, #colors)
        local var11 = colors[num1]
        arg1.onBrickColorChanged(var11)
        if arg1.onColorChanged then
            arg1.onColorChanged(var11.Color)
        end
    end, { colors, arg1.onBrickColorChanged, arg1.onColorChanged })

    local var9 = React.useCallback(function(tbl1, bool1: boolean)
        local uDim2 = UDim2.fromOffset(tbl1.x - var6.offset.X, tbl1.y - var6.offset.Y)

        local result = {}

        if bool1 then
            result.outline = React.createElement(Image, {
                Size = UDim2.fromOffset(size350 + size200_2, size400 + size200_2),
                Position = uDim2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = "component_assets/hexagon_24",
                imageStyle = var1.Color.System.Emphasis,
                ZIndex = 1
            })
        end

        result.hexagon = React.createElement(Image, {
            Size = UDim2.fromOffset(size350, size400),
            Position = uDim2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = "component_assets/hexagon_24",
            imageStyle = {
                Color3 = tbl1.brickColor.Color
            },
            ZIndex = 2
        })

        return result
    end, {
        var6.offset.X,
        var6.offset.Y,
        size350,
        size400,
        var1
    })

    local var10 = React.useCallback(function()
        local result = {}
        local value = arg1.selectedColor and arg1.selectedColor:getValue() or nil

        for value2, value3 in var5 do
            local bool1 = not (value == nil) and value == value3.brickColor.Color

            for value4, value5 in (var9(value3, bool1)) do
                result[`{value4}_{value2}`] = value5
            end
        end

        return result
    end, { arg1.selectedColor })

    return React.createElement(View, withCommonProps(arg1, { tag = "col align-x-center gap-small size-full-0 auto-y" }), {
        ColorGrid = React.createElement(View, {
            Size = UDim2.fromOffset(var6.width, var6.height),
            LayoutOrder = 1,
            onActivated = onActivated,
            stateLayer = {
                affordance = StateLayerAffordance.None
            }
        }, (var10())),
        BottomRow = React.createElement(View, {
            Size = UDim2.new(1, -var1.Size.Size_400, 0, var1.Size.Size_500),
            tag = "stroke-standard stroke-muted radius-circle bg-surface-100",
            LayoutOrder = 2,
            onActivated = var3,
            stateLayer = {
                affordance = StateLayerAffordance.None
            }
        }, {
            Swatches = React.createElement(BottomRowSwatches, {
                colors = colors,
                paddingHorizontal = size100,
                swatchWidth = size350_2,
                swatchHeight = size400_2,
                swatchCenterY = var1.Size.Size_250
            })
        })
    })
end

return BrickColorPicker
