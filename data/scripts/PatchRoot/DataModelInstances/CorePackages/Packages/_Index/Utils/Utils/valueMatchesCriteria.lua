-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local instanceof = LuauPolyfill.instanceof

local LuauRegExp = require(scriptParentParent.LuauRegExp)

local tbl1 = {}

local function valueMatchesCriteria(arg1, arg2)
    if arg1 == nil then
        return arg1 == arg2
    elseif Array.isArray(arg1) then
        return Array.isArray(arg2) and Array.every(arg1, function(arg3, arg4)
            return valueMatchesCriteria(arg3, arg2[arg4])
        end)
    elseif typeof(arg1) == "table" then
        return typeof(arg2) == "table" and Boolean.toJSBoolean(arg2) and Array.every(Object.keys(arg2), function(arg3)
            return valueMatchesCriteria(arg1[arg3], arg2[arg3])
        end)
    elseif instanceof(arg2, LuauRegExp) then
        return arg2:test(arg1)
    end
    return arg1 == arg2
end
tbl1.valueMatchesCriteria = valueMatchesCriteria
return tbl1
