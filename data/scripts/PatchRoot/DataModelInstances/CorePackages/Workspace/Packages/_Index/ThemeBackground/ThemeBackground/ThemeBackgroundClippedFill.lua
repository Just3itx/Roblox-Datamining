-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)

local ThemeBackgroundFill = require(scriptParent.ThemeBackgroundFill)

local function ThemeBackgroundClippedFill(tbl1)
    local clipRight = tbl1.clipRight
    local overscan = tbl1.overscan

    local var1, var2 = React.useBinding(0)
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        local current = var3.current
        if current == nil then
            return
        end
        local value = var1:getValue()
        local var4 = current.AbsoluteSize.X + value
        local num1 = math.clamp(current.AbsolutePosition.X + var4 - clipRight, 0, var4)
        if num1 ~= value then
            var2(num1)
        end
    end, { var1, clipRight })

    local ref = React.useCallback(function(current)
        var3.current = current
        var4()
    end, { var4 })

    React.useLayoutEffect(var4, { var4 })

    local createElement = React.createElement

    local tbl2 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(-overscan, -overscan),
        Size = var1:map(function(num1: number): UDim2
            return UDim2.new(1, overscan * 2 - num1, 1, overscan * 2)
        end),
        ZIndex = 0,
        ref = ref,
        [React.Change.AbsolutePosition] = var4,
        [React.Change.AbsoluteSize] = var4
    }

    return createElement("Frame", tbl2, {
        ThemeBackground = React.createElement(ThemeBackgroundFill, {
            image = tbl1.image,
            baseColor = tbl1.baseColor,
            onPageChanged = tbl1.onPageChanged,
            Size = var1:map(function(xOffset: number): UDim2
                return UDim2.new(1, xOffset, 1, 0)
            end)
        })
    })
end

return ThemeBackgroundClippedFill
