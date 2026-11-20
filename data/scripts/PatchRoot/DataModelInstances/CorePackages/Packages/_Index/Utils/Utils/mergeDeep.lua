-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local tbl1 = {}

local isSymbol = require(scriptParentParent.Utils.jsHelpers).isSymbol

local isObject = nil

local function mergeDeep(arg1, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    local var1 = not Boolean.toJSBoolean(arg1[1]) and {} or arg1[1]

    local result = ({})

    for _, value in arg1 do
        local toJsBoolean = Boolean.toJSBoolean
        local var2 = isObject(var1)
        if Boolean.toJSBoolean(var2) then
            var2 = isObject(value)
        end

        if not toJsBoolean(var2) then
            continue
        end

        for value2 in value do
            if isSymbol(value2) then
                continue
            end

            if not Boolean.toJSBoolean(isObject(value[tostring(value2)]))
                or Array.indexOf(Object.keys(result), tostring(value2)) == -1
            then
                Object.assign(result, { [tostring(value2)] = value[tostring(value2)] })
            else
                result[value2] = mergeDeep({ result[value2], value[value2] }, bool1)
            end
        end
    end

    return result
end
tbl1.mergeDeep = mergeDeep

isObject = function(arg1)
    local var1 = Boolean.toJSBoolean(arg1)
    return var1 and typeof(arg1) == "table" and not (Array.isArray(arg1) and #arg1 > 0)
end

return tbl1
