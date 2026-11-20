-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local function calculateBounds(virtualizedItems, num1: number, num2: number): Vector3
    num2 = math.max(num2, 0)

    local num3 = 0

    local x = 0
    local y = 0

    for k, virtualizedItem in virtualizedItems do
        if num3 <= num2 then
            x = k
        end

        num3 += virtualizedItem.height

        if not (num2 <= num3) then
            k = y
        end

        if num2 + num1 <= num3 then
            y = k
            break
        end

        y = k
    end

    return Vector3.new(x, y)
end

local function useVirtualizedList(tbl1)
    local var1, var2 = React.useState(0)
    local var3, var4 = React.useState(function(): Vector3
        return (calculateBounds(tbl1.virtualizedItems, var1, 0))
    end)

    local var5 = React.useRef(0)
    local var6 = React.useCallback(function(current: number)
        if var5.current == current then
            return
        end

        var5.current = current
        var4((calculateBounds(tbl1.virtualizedItems, var1, current)))
    end, { var1, tbl1.virtualizedItems })

    React.useEffect(function()
        local current = tbl1.scrollingFrameRef.current
        if current == nil then
            return
        end

        var2(current.AbsoluteWindowSize.Y)
        var6(current.CanvasPosition.Y)

        local connection = current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
            var2(current.AbsoluteWindowSize.Y)
        end)

        local connection2 = current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            var6(current.CanvasPosition.Y)
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var6 })

    local yOffset = React.useMemo(function()
        local num1 = 0

        for _, virtualizedItem in tbl1.virtualizedItems do
            num1 += virtualizedItem.height
        end

        return num1
    end, { tbl1.virtualizedItems })

    React.useEffect(function()
        local current = tbl1.scrollingFrameRef.current
        if current then
            current.CanvasSize = UDim2.new(1, 0, 0, yOffset)
        end
    end, { yOffset })

    React.useLayoutEffect(function()
        var4((calculateBounds(tbl1.virtualizedItems, var1, var5.current)))
    end, { var1, tbl1.virtualizedItems })

    local var7 = React.useCallback(function(key: string)
        local current = tbl1.scrollingFrameRef.current
        assert(current ~= nil, "VirtualizedList has not been mounted yet")

        local y = 0

        for _, virtualizedItem in tbl1.virtualizedItems do
            if virtualizedItem.key == key then
                current.CanvasPosition = Vector2.new(0, y)
                return
            end

            y += virtualizedItem.height
        end
    end, { tbl1.virtualizedItems })

    local tbl2 = ({})
    local yOffset2 = 0

    for i = 1, var3.X - 1 do
        local virtualizedItem = tbl1.virtualizedItems[i]
        if virtualizedItem == nil then
            break
        end

        yOffset2 += virtualizedItem.height
    end

    for i = var3.X, var3.Y do
        local virtualizedItem = tbl1.virtualizedItems[i]
        if virtualizedItem == nil then
            break
        end

        local key = virtualizedItem.key
        tbl2[key] = React.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(0, yOffset2),
            Size = UDim2.new(1, 0, 0, virtualizedItem.height)
        }, tbl1.renderItem(virtualizedItem))

        yOffset2 += virtualizedItem.height
    end

    return tbl2, var7
end

return useVirtualizedList
