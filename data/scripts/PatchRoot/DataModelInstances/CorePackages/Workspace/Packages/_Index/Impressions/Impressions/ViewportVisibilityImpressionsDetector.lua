-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local React = require(ImpressionsParent.React)
local useViewportBounds = require(ImpressionsParent.ViewportUtils).useViewportBounds

local function ViewportVisibilityImpressionsDetector(tbl1)
    local var1 = useViewportBounds()
    local threshold = tbl1.threshold or 0.5
    local var2 = React.useRef(false)
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        if var2.current then
            return
        end

        local current = tbl1.targetRef.current
        if not current or not current.Visible or current.AbsoluteSize.X == 0 or current.AbsoluteSize.Y == 0 then
            return
        end

        local absolutePositionX = current.AbsolutePosition.X
        local num1 = math.min(absolutePositionX + current.AbsoluteSize.X, var1.max.X)

        if math.max(0, num1 - math.max(absolutePositionX, var1.min.X)) <= 0 then
            return
        end

        local absolutePositionY = current.AbsolutePosition.Y
        if math.max(0, math.min(absolutePositionY + current.AbsoluteSize.Y, var1.max.Y) - math.max(absolutePositionY, var1.min.Y)) / current.AbsoluteSize.Y >= threshold then
            var2.current = true
            tbl1.onImpression()
        end
    end, {
        tbl1.targetRef,
        tbl1.onImpression,
        threshold,
        var1
    })
    local var5 = React.useCallback(function()
        if var3.current then
            task.cancel(var3.current)
        end
        var3.current = task.delay(0.2, function()
            var3.current = nil
            var4()
        end)
    end, { var4 })

    React.useEffect(function()
        local current = tbl1.targetRef.current
        if not current then
            return nil
        end

        var5()

        local connection = current:GetPropertyChangedSignal("AbsolutePosition"):Connect(var5)
        local connection2 = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(var5)
        local connection3 = current:GetPropertyChangedSignal("Visible"):Connect(var5)
        return function()
            if var3.current then
                task.cancel(var3.current)
                var3.current = nil
            end
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { tbl1.targetRef, var5 })

    return nil
end

return ViewportVisibilityImpressionsDetector
