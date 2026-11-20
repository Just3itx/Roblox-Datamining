-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)
local includes = require(scriptParent.includes)
local keys = require(scriptParent.keys)

local sort = table.sort

local function getDefaultCycles()
    return {
        visited = {},
        refs = {},
        nextRef = 1,
        omit = {}
    }
end

local function cycles(arg1, num1: number?, arg2)
    if num1 == -1 then
        return arg2
    end

    if typeof(arg1) ~= "table" then
        return nil
    end

    local var1 = arg2 or getDefaultCycles()

    if var1.visited[arg1] then
        if not var1.refs[arg1] then
            var1.refs[arg1] = var1.nextRef
            var1.nextRef += 1
        end
        return nil
    end

    var1.visited[arg1] = true

    local var2 = keys(arg1)
    sort(var2, function(arg3, arg4): boolean
        if typeof(arg3) == "number" and typeof(arg4) == "number" then
            return arg3 < arg4
        end

        return tostring(arg3) < tostring(arg4)
    end)

    for _, value in ipairs(var2) do
        local var3 = arg1[value]
        if includes(var1.omit, value) then
            continue
        end

        if num1 then
            cycles(value, num1 - 1, var1)
            cycles(var3, num1 - 1, var1)
        else
            cycles(value, nil, var1)
            cycles(var3, nil, var1)
        end
    end

    return var1
end

return cycles
