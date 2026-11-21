-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)
local ArgCheck = require(CollectionViewsParent.ArgCheck)

local function useScrollButtonHandlers(tbl1, num1: number, bool1: boolean, num2: number, arg1, num3: number, num4: number?)
    ArgCheck.assert(num2 >= 1)
    ArgCheck.assert(num1 >= 0)

    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState(bool1)

    local var5 = React.useRef(0)
    local num5 = math.max(0, num1 - num2)

    local var6 = React.useRef(nil)

    local var7 = React.useCallback(function(num6: number?)
        local var7 = var5
        var7.current = math.max(0, math.min(num5, num6))
        return var5.current
    end, { num5, var5 })

    local var8 = React.useCallback(function()
        if not bool1 then
            var2(false)
            var4(false)
            return
        end
        var2(var5.current > 0)
        var4(var5.current < num5)
    end, { bool1, num5, var5 })

    local var9 = React.useCallback(function(num6: number, bool2: boolean?)
        local current = tbl1.current
        if current == nil then
            return
        end

        local x = num6 * (arg1:getValue().X + num3)
        local canvasPosition = current.CanvasPosition
        local vector2 = Vector2.new(x, canvasPosition.Y)
        if not bool2 or UserGameSettings.ReducedMotion then
            current.CanvasPosition = vector2
            var8()
            return
        end

        if var6.current then
            var6.current:Cancel()
        end
        var6.current = TweenService:Create(
            current,
            TweenInfo.new(num4 or 0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut),
            { CanvasPosition = vector2 }
        ):Play()
    end, {
        var8,
        arg1,
        num3,
        var6,
        num4,
        tbl1
    })

    local var10 = React.useCallback(function()
        local var10 = var7(var5.current - num2)
        var9(var10, true)
    end, {
        var9,
        var7,
        num2,
        var5
    })
    local var11 = React.useCallback(function()
        local var11 = var7(var5.current + num2)
        var9(var11, true)
    end, {
        var9,
        var7,
        num2,
        var5
    })

    React.useEffect(function()
        var7(var5.current)
        if bool1 then
            var9(var5.current)
        end
        var8()
    end, { var7, var9, bool1 })

    React.useEffect(function()
        if not bool1 then
            return nil
        end

        local tbl2 = {}
        if tbl1.current ~= nil then
            local current = tbl1.current

            local canvasSizeChanged = current:GetPropertyChangedSignal("CanvasSize")

            table.insert(tbl2, canvasSizeChanged:Connect(function()
                var7(var5.current)
                var9(var5.current)
                var8()
            end))

            local canvasPositionChanged = current:GetPropertyChangedSignal("CanvasPosition")

            table.insert(tbl2, canvasPositionChanged:Connect(function()
                var7(var5.current)
                var8()
            end))
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {
        var9,
        var5,
        tbl1,
        bool1,
        var7
    })

    return var10, var11, var1, var3
end

return useScrollButtonHandlers
