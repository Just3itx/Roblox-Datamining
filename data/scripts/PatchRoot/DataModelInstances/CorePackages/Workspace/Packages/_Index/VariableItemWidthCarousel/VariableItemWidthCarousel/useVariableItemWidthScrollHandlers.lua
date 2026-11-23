-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VariableItemWidthCarousel = script:FindFirstAncestor("VariableItemWidthCarousel")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local TweenService = game:GetService("TweenService")
local VariableItemWidthCarouselParent = VariableItemWidthCarousel.Parent

local React = require(VariableItemWidthCarouselParent.React)

local function clampTargetCanvasPosition(arg1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return Vector2.new(math.round(math.clamp(num1, 0, arg1.AbsoluteCanvasSize.X - arg1.AbsoluteSize.X)), 0)
end

function useVariableItemWidthScrollHandlers(tbl1, num1: number, func1: (...any) -> (...any), tbl2, num2: number?)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(0)
    local var3 = React.useRef(0)
    local var4, var5 = React.useState(false)
    local var6, var7 = React.useState(true)
    local var8, var9 = React.useState(Vector2.zero)
    local var10 = React.useMemo(function()
        local tbl3 = { [0] = 0 }
        for i, _ in ipairs(tbl1) do
            tbl3[i] = func1(i)
        end
        return tbl3
    end, { tbl1, func1 })

    React.useEffect(function()
        local connection = nil

        if tbl2.current then
            local current = tbl2.current

            var9(current.AbsoluteSize)

            connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var9(current.AbsoluteSize)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl2 })

    local var11 = React.useCallback(function(instance: Instance, vector2: Vector2)
        if var1.current then
            var1.current:Cancel()
        end
        var2.current = vector2.X
        if UserGameSettings.ReducedMotion then
            instance.CanvasPosition = vector2
            return
        end
        local tweenInfo = TweenInfo.new(num2 or 0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        var1.current = TweenService:Create(instance, tweenInfo, { CanvasPosition = vector2 }):Play()
    end, { UserGameSettings.ReducedMotion, num2 })

    local var12 = React.useCallback(function()
        local current = tbl2.current
        if current then
            var5(var2.current > 0)
            var7(var2.current < current.AbsoluteCanvasSize.X - var8.X)
            return
        end
        var5(false)
        var7(false)
    end, { var5, var7, var8 })

    local var13 = React.useCallback(function(_)
        local num3 = 0
        for i = #tbl1, 1, -1 do
            local var13 = var10[i]
            num3 += var13 + (var13 > 0 and num1 or 0)
            if var8.X <= num3 then
                return i
            end
        end
        return 1
    end, {
        tbl1,
        var10,
        num1,
        var8
    })
    local var14 = React.useCallback(function(arg1, num3: number)
        local x = var8.X
        local num4 = 0
        local current = var3.current
        local num5 = 0
        local num6 = 0
        for i = math.max(current, 1), #tbl1 do
            local var14 = var10[i]
            num6 += var14 + (var14 > 0 and num1 or 0)
            if x <= num6 then
                break
            end

            num5 += 1
        end
        local num7 = math.clamp(math.max(1, num5) * num3, -#tbl1, #tbl1)
        local var14 = current + num7
        local num8 = #tbl1

        for i = 0, math.clamp(var14, 0, num8) do
            local var15 = var10[i]
            num4 += var15 + (var15 > 0 and num1 or 0)
        end

        local num9 = math.clamp(current + num7, 0, var13(arg1))

        return clampTargetCanvasPosition(arg1, num4), num9
    end, {
        tbl1,
        var10,
        num1,
        clampTargetCanvasPosition,
        var13,
        var8
    })

    local var15 = React.useCallback(function()
        local current = tbl2.current
        if current then
            local var15, var16 = var14(current, -1)
            var3.current = var16
            var11(current, var15)
            var12()
        end
    end, { var11, var12, var14 })

    local var16 = React.useCallback(function()
        local current = tbl2.current
        if current then
            local var16, var17 = var14(current, 1)
            var3.current = var17
            var11(current, var16)
            var12()
        end
    end, { var11, var12, var14 })

    React.useEffect(var12, { var12 })

    return var15, var16, var4, var6, var12
end

return useVariableItemWidthScrollHandlers
