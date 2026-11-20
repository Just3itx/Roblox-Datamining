-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtils = script:FindFirstAncestor("ReactUtils")

local React = require(ReactUtils.Parent.React)

local function shallowEqual(current, current2)
    if current == current2 then
        return true
    end

    if typeof(current) ~= typeof(current2) then
        return false
    end

    if typeof(current) ~= "table" then
        return current == current2
    end

    assert(typeof(current2) == "table", "Luau")

    if #current ~= #current2 then
        return false
    end

    for value in current do
        if current[value] ~= current2[value] then
            return false
        end
    end

    for value in current2 do
        if current[value] ~= current2[value] then
            return false
        end
    end

    return true
end

local function useStagnatingState(value, current)
    local var1 = React.useRef(current)
    local var2 = React.useRef(0)

    if not shallowEqual(var1.current, current) then
        var1.current = current
        var2.current += 1
    end

    local var3, var4 = React.useState({ tick = var2.current, value = value })

    local var5 = React.useCallback(function(arg1)
        if typeof(arg1) ~= "function" then
            var4({ tick = var2.current, value = arg1 })

            return
        end

        var4(function(arg3)
            local var5 = if arg3.tick == var2.current then arg3.value else value
            return {
                tick = var2.current,
                value = arg1(var5)
            }
        end)
    end, { value })

    return if var3.tick == var2.current then var3.value else value, var5
end

return useStagnatingState
