-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local useTokens = require(Foundation.Providers.Style.useTokens)

local function truncatePath(tbl1, num1: number) -- Luacid: Inlined by compiler; 4 call sites recovered
    local result = ({})
    for i = 1, num1 do
        if tbl1[i] then
            result[i] = tbl1[i]
        end
    end
    return result
end

local function buildPath<T>(tbl1, num1: number, arg1: T): {T} -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = truncatePath(tbl1, num1 - 1)
    tbl2[num1] = arg1
    return tbl2
end

local function useSubmenuHover()
    local var1 = useTokens()
    local time100 = var1.Time.Time_100
    local time300 = var1.Time.Time_300

    local var2, var3 = React.useState({})
    local var4 = React.useRef({})
    local var5 = React.useRef(nil)
    local var6 = React.useRef(nil)

    var4.current = var2

    local var7 = React.useCallback(function()
        if var5.current then
            task.cancel(var5.current)
            var5.current = nil
        end
        if var6.current then
            task.cancel(var6.current)
            var6.current = nil
        end
    end, {})

    local openAtDepth = React.useCallback(function(num1: number, arg1, bool1: boolean?)
        var7()

        if var4.current[num1] == arg1 then
            return
        end

        if bool1 then
            var3(function(tbl1)
                local path = buildPath(tbl1, num1, arg1)
                return path
            end)

            return
        end

        var5.current = task.delay(time100, function()
            var3(function(tbl1)
                local path = buildPath(tbl1, num1, arg1)
                return path
            end)

            var5.current = nil
        end)
    end, { var7, time100 })

    local closeAtDepth = React.useCallback(function(num1: number)
        var7()

        if #var4.current < num1 then
            return
        end

        var6.current = task.delay(time300, function()
            var3(function(tbl1)
                if #tbl1 < num1 then
                    return tbl1
                end
                return truncatePath(tbl1, num1 - 1)
            end)
            var6.current = nil
        end)
    end, { var7, time300 })

    local reset = React.useCallback(function()
        var7()
        var3({})
    end, { var7 })

    React.useEffect(function()
        return function()
            if var5.current then
                task.cancel(var5.current)
            end
            if var6.current then
                task.cancel(var6.current)
            end
        end
    end, {})

    return {
        openPath = var2,
        openAtDepth = openAtDepth,
        closeAtDepth = closeAtDepth,
        reset = reset
    }
end

return useSubmenuHover
