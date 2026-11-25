-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local RunService = game:GetService("RunService")

local Cryo = require(Songbird.Parent.Cryo)
local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)

local useCallback = React.useCallback
local useBinding = React.useBinding
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens
local useEventConnection = ReactUtils.useEventConnection

local tbl1 = {
    speed = 20,
    direction = Enum.TextDirection.LeftToRight
}

local function calculateInstances(num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == 0 then
        return 2
    end

    local num3 = math.max(math.ceil(num2 / num1) + 1, 2)
    return if num3 == num3 then num3 else 2
end

local function MarqueeScroller(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useTokens()
    local offset = if var1.padding then var1.padding else var2.Margin.Large
    local bool1 = var1.direction == Enum.TextDirection.LeftToRight

    local var3, var4 = useBinding(0)
    local var5, var6 = useState(Vector2.new(math.huge, math.huge))
    local var7, var8 = useState(Vector2.new(math.huge, math.huge))
    local var9 = var5.X + offset

    local var10 = useCallback(function(arg1)
        var6(arg1.AbsoluteSize)
    end, {})

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var8(arg1.AbsoluteSize)
    end, {})

    local tbl3 = ({})
    for layoutOrder = 1, calculateInstances(var5.X, var7.X) do
        local str1 = `Content{layoutOrder}`
        tbl3[str1] = React.createElement(
            Foundation.View,
            {
                tag = "auto-xy",
                onAbsoluteSizeChanged = if layoutOrder == 1 then var10 else nil,
                LayoutOrder = layoutOrder
            },
            var1.children
        )
    end
    useEventConnection(RunService.Heartbeat, function(arg1)
        if not (var1.speed > 0) then
            return
        end

        local var12 = var3:getValue() + var1.speed * arg1
        if var9 <= var12 then
            var12 -= var9
        end
        var4(var12)
    end, { var1.speed, var9 })

    return React.createElement(
        Foundation.View,
        {
            tag = "size-full auto-y clip",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            LayoutOrder = var1.LayoutOrder
        },
        {
            Scroller = React.createElement(Foundation.View, {
                tag = "auto-xy row data-testid=scroller",
                layout = {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, offset)
                },
                Position = var3:map(function(xOffset: number): UDim2
                    if bool1 then
                        return UDim2.new(0, xOffset * -1, 0, 0)
                    end
                    return UDim2.new(-1, xOffset, 0, 0)
                end)
            }, tbl3)
        }
    )
end

return MarqueeScroller
