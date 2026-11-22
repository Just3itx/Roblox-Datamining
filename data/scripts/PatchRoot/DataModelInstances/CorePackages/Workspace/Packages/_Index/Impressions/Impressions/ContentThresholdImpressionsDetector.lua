-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local React = require(ImpressionsParent.React)
local useViewportBounds = require(ImpressionsParent.ViewportUtils).useViewportBounds

local function ContentThresholdImpressionsDetector(tbl1)
    local var1 = useViewportBounds()
    local var2 = React.useRef({})
    local var3 = React.useRef(0)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(tbl1.impressionsTag)

    local var6 = React.useCallback(function()
        local current = tbl1.containerRef.current
        if not current then
            return
        end

        local num1 = math.floor(tbl1.fullContentHeight)
        if num1 <= 0 or current.AbsoluteSize.Y == 0 then
            return
        end

        local absolutePositionY = current.AbsolutePosition.Y
        local var6 = absolutePositionY + current.AbsoluteSize.Y
        local maxY = (tbl1.viewportBoundsOffset
            and {
                min = var1.min + tbl1.viewportBoundsOffset.min,
                max = var1.max + tbl1.viewportBoundsOffset.max
            }
            or var1).max.Y

        if maxY <= 0 then
            return
        end

        local num2 = math.clamp(math.min(var6, maxY) - absolutePositionY, 0, num1) / num1

        local var7 = var3
        var7.current = math.max(var3.current, num2)

        local tbl2 = {}
        for k, threshold in tbl1.thresholds do
            if not var2.current[k] and threshold <= var3.current then
                var2.current[k] = true
                table.insert(tbl2, tbl1.thresholds[k])
            end
        end

        if #tbl2 > 0 then
            tbl1.sendImpressions(tbl2)
        end
    end, {
        tbl1.containerRef,
        tbl1.fullContentHeight,
        tbl1.thresholds,
        tbl1.viewportBoundsOffset,
        tbl1.sendImpressions,
        var1
    })

    local var7 = React.useCallback(function()
        if var4.current then
            task.cancel(var4.current)
        end
        var4.current = task.delay(0.2, function()
            var4.current = nil
            var6()
        end)
    end, { var6 })

    React.useEffect(function()
        if var5.current == tbl1.impressionsTag then
            return
        end

        var5.current = tbl1.impressionsTag
        var2.current = {}
        var3.current = 0
        var7()
    end, { tbl1.impressionsTag, var7 })

    React.useEffect(function()
        local current = tbl1.containerRef.current
        if not current then
            return nil
        end

        var7()

        local connection = current:GetPropertyChangedSignal("AbsolutePosition"):Connect(var7)
        local connection2 = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(var7)
        return function()
            if var4.current then
                task.cancel(var4.current)
                var4.current = nil
            end
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1.containerRef, var7 })

    return nil
end

return ContentThresholdImpressionsDetector
