-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map

local module = {}

local _GraphQL = require(scriptParentParentParent.GraphQL)

local mergeDirectives = require(script.Parent.directives).mergeDirectives

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local compareNodes = require(scriptParentParentParent.Utils).compareNodes

function module.mergeEnumValues(arg1, arg2, arg3)
    local toJsBoolean = Boolean.toJSBoolean
    local consistentEnumMerge = if typeof(arg3) == "table" then arg3.consistentEnumMerge else nil
    local tbl1

    if toJsBoolean(consistentEnumMerge) then
        tbl1 = {}
        if Boolean.toJSBoolean(arg1) then
            tbl1 = Array.concat(tbl1, arg1)
        end
    else
        tbl1 = arg2
        arg2 = arg1
    end

    local map = Map.new()

    if arg2 then
        for _, value in arg2 do
            map:set(value.name.value, value)
        end
    end

    if tbl1 then
        for _, value in tbl1 do
            local value2 = value.name.value
            if Boolean.toJSBoolean(map:has(value2)) then
                local var1 = map:get(value2)
                var1.description = Boolean.toJSBoolean(value.description) and value.description or var1.description
                var1.directives = mergeDirectives(value.directives, var1.directives)
            else
                map:set(value2, value)
            end
        end
    end

    local var1 = Array.concat({}, map:values())

    if arg3 and Boolean.toJSBoolean(arg3.sort) then
        Array.sort(var1, compareNodes)
    end
    return var1
end

return module
