-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array

local function isObject(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "table" and not (Array.isArray(arg1) and #arg1 > 0)
end

local function mergeDeep(arg1, bool1: boolean?)
    local var1 = arg1[1] or {}
    local result = ({})

    for _, value in arg1 do
        if not (isObject(var1) and isObject(value)) then
            continue
        end

        for value2, value3 in value do
            if type(value3) ~= "table" or result[value2] == nil then
                Object.assign(result, { [value2] = value3 })
            else
                result[value2] = mergeDeep({ result[value2], value3 }, bool1)
            end
        end
    end

    return result
end

return mergeDeep
