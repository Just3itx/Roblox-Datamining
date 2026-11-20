-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local getNullableType = GraphQL.getNullableType
local isLeafType = GraphQL.isLeafType
local isListType = GraphQL.isListType
local isInputObjectType = GraphQL.isInputObjectType

local _types = require(script.Parent.types)

local function transformInputValue(arg1, arg2, arg3, arg4)
    if arg3 == nil then
        arg3 = nil
    end

    if arg4 == nil then
        arg4 = nil
    end

    if arg2 == nil then
        return arg2
    end
    local nullableType = getNullableType(arg1)
    if Boolean.toJSBoolean(isLeafType(nullableType)) then
        if arg3 ~= nil then
            return (arg3(nullableType, arg2))
        end

        return arg2
    elseif Boolean.toJSBoolean(isListType(nullableType)) then
        return Array.map(arg2, function(arg5)
            return transformInputValue(nullableType.ofType, arg5, arg3, arg4)
        end)
    elseif Boolean.toJSBoolean(isInputObjectType(nullableType)) then
        local fields = nullableType:getFields()
        local result = {}
        for value in arg2 do
            local field = fields[tostring(value)]
            if field ~= nil then
                result[tostring(value)] = transformInputValue(field.type, arg2[tostring(value)], arg3, arg4)
            end
        end

        if arg4 ~= nil then
            return (arg4(nullableType, result))
        end

        return result
    else
        return nil
    end
end
module.transformInputValue = transformInputValue
function module.serializeInputValue(arg1, arg2)
    return transformInputValue(arg1, arg2, function(arg3, arg4)
        local success, result = pcall(arg3.serialize, arg3, arg4)
        return if success then result else arg4
    end)
end

function module.parseInputValue(arg1, arg2)
    return transformInputValue(arg1, arg2, function(arg3, arg4)
        local success, result = pcall(arg3.parseValue, arg3, arg4)
        return if success then result else arg4
    end)
end

function module.parseInputValueLiteral(arg1, arg2)
    return transformInputValue(arg1, arg2, function(arg3, arg4)
        return arg3:parseLiteral(arg4, {})
    end)
end

return module
