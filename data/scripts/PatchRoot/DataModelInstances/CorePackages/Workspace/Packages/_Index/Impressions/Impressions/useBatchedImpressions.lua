-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local React = require(ImpressionsParent.React)

local function useBatchedImpressions(tbl1)
    local var1 = React.useRef({})
    local var2 = React.useRef(nil)
    local var3 = React.useRef({})
    local var4 = React.useRef({})
    local var5 = React.useRef(0)
    local var6 = React.useRef(tbl1.onFlush)
    var6.current = tbl1.onFlush

    local var7 = React.useCallback(function()
        if #var1.current == 0 then
            return
        end

        local current = var6.current
        if not current then
            var1.current = {}
            var4.current = {}
            return
        end

        local tbl2 = {}
        for _, value in var1.current do
            var3.current[value.key] = true
            table.insert(tbl2, value.item)
        end

        if #tbl2 > 0 then
            var5.current += 1
            current(tbl2, var5.current)
        end

        var1.current = {}
        var4.current = {}
    end, {})

    local addImpression = React.useCallback(function(key: string, num1: number, arg1)
        if not key or not num1 or var3.current[key] or var4.current[key] then
            return
        end

        local var8 = tbl1.mapItem(key, num1, arg1)
        if not var8 then
            return
        end

        var4.current[key] = true
        table.insert(var1.current, { key = key, item = var8 })

        if var2.current then
            pcall(task.cancel, var2.current)
        end
        var2.current = task.delay(tbl1.batchTimeMs * 0.001, var7)
    end, { tbl1.batchTimeMs, tbl1.mapItem, var7 })

    React.useEffect(function()
        return function()
            if var2.current then
                pcall(task.cancel, var2.current)
            end
            var2.current = nil
            var7()
        end
    end, { var7 })

    return React.useMemo(function()
        return { addImpression = addImpression }
    end, { addImpression })
end

return useBatchedImpressions
