-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local module = {}
local Kind = require(scriptParentParent.GraphQL).Kind

local astFromType = require(script.Parent.astFromType).astFromType

function module.updateArgument(tbl1, tbl2, tbl3, value: string, str1: string, arg1, arg2)
    tbl1[tostring(value)] = {
        kind = Kind.ARGUMENT,
        name = {
            kind = Kind.NAME,
            value = value
        },
        value = {
            kind = Kind.VARIABLE,
            name = {
                kind = Kind.NAME,
                value = str1
            }
        }
    }
    tbl2[tostring(str1)] = {
        kind = Kind.VARIABLE_DEFINITION,
        variable = {
            kind = Kind.VARIABLE,
            name = {
                kind = Kind.NAME,
                value = str1
            }
        },
        type = astFromType(arg1)
    }
    if arg2 ~= nil then
        tbl3[tostring(str1)] = arg2
        return
    end

    if Array.indexOf(Object.keys(tbl3), tostring(str1)) ~= -1 then
        tbl3[tostring(str1)] = nil
    end
end

function module.createVariableNameGenerator(tbl1)
    local num1 = 0
    return function(str1: string)
        local var1

        repeat
            var1 = ("_v%s_%s"):format(tostring(num1), str1)
            num1 += 1
        until Array.indexOf(Object.keys(tbl1), tostring(var1)) == -1

        return var1
    end
end

return module
