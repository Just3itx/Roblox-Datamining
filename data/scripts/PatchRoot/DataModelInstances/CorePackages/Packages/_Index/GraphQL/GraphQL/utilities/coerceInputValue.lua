-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local jsutils = scriptParentParent.jsutils
local luaUtils = scriptParentParent.luaUtils

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Object = LuauPolyfill.Object

local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant
local didYouMean = require(jsutils.didYouMean).didYouMean
local isObjectLike = require(jsutils.isObjectLike).isObjectLike
local suggestionList = require(jsutils.suggestionList).suggestionList
local printPathArray = require(jsutils.printPathArray).printPathArray
local addPath = require(jsutils.Path).addPath

local instanceOf = require(jsutils.instanceOf)
local null = require(luaUtils.null)
local isNillish = require(luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish

local pathToArray = require(jsutils.Path).pathToArray
local isIteratableObject = require(jsutils.isIteratableObject).isIteratableObject
local GraphQLError = require(scriptParentParent.error.GraphQLError).GraphQLError

local definition = require(scriptParentParent.type.definition)

local isLeafType = definition.isLeafType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType

local coerceInputValueImpl = nil
local defaultOnError = nil

local function coerceInputValue(arg1, arg2, func1: ((...any) -> (...any))?)
    return coerceInputValueImpl(arg1, arg2, func1 or defaultOnError)
end

defaultOnError = function(arg1, arg2, arg3)
    local var1 = "Invalid value " .. inspect(arg2)
    if #arg1 > 0 then
        var1 ..= " at \"value" .. printPathArray(arg1) .. "\""
    end
    arg3.message = var1 .. ": " .. arg3.message
    error(arg3)
end

coerceInputValueImpl = function(arg1, arg2, callback: (...any) -> (...any), arg3)
    if isNonNullType(arg2) then
        if isNotNillish(arg1) then
            return coerceInputValueImpl(arg1, arg2.ofType, callback, arg3)
        end
        callback(
            pathToArray(arg3),
            arg1,
            GraphQLError.new("Expected non-nullable type \"" .. inspect(arg2) .. "\" not to be null.")
        )
        return
    end

    if isNillish2(arg1) then
        return null
    elseif isListType(arg2) then
        local ofType = arg2.ofType
        if isIteratableObject(arg1) then
            return Array.from(arg1, function(arg4, arg5)
                local var1 = addPath(arg3, arg5, nil)
                return coerceInputValueImpl(arg4, ofType, callback, var1)
            end)
        end

        return { coerceInputValueImpl(arg1, ofType, callback, arg3) }
    elseif isInputObjectType(arg2) then
        if isObjectLike(arg1) then
            local result = {}

            local fields = arg2:getFields()

            for _, value in ipairs(fields:values()) do
                local var1 = arg1[value.name]
                if var1 ~= nil then
                    result[value.name] = coerceInputValueImpl(var1, value.type, callback, addPath(arg3, value.name, arg2.name))
                elseif value.defaultValue ~= nil then
                    result[value.name] = value.defaultValue
                elseif isNonNullType(value.type) then
                    local var2 = inspect(value.type)
                    callback(
                        pathToArray(arg3),
                        arg1,
                        GraphQLError.new("Field \"" .. value.name .. "\" of required type \"" .. var2 .. "\" was not provided.")
                    )
                end
            end

            for _, value in ipairs(Object.keys(arg1)) do
                if not fields:get(value) then
                    local var1 = suggestionList(value, arg2:getFields():keys())
                    callback(
                        pathToArray(arg3),
                        arg1,
                        GraphQLError.new(("Field \"%s\" is not defined by type \"%s\".%s"):format(value, arg2.name, didYouMean(var1)))
                    )
                end
            end

            return result
        end

        callback(pathToArray(arg3), arg1, GraphQLError.new("Expected type \"" .. arg2.name .. "\" to be an object."))
    elseif isLeafType(arg2) then
        local success, result = pcall(arg2.parseValue, arg2, arg1)

        if not success then
            if instanceOf(result, GraphQLError) then
                callback(pathToArray(arg3), arg1, result)
                return
            end
            callback(
                pathToArray(arg3),
                arg1,
                GraphQLError.new("Expected type \"" .. arg2.name .. "\". " .. result.message, nil, nil, nil, nil, result)
            )

            return
        end

        if result == nil then
            callback(pathToArray(arg3), arg1, GraphQLError.new(("Expected type \"%s\"."):format(arg2.name)))
        end

        return result
    else
        invariant(false, "Unexpected input type: " .. inspect(arg2))
    end
end

return { coerceInputValue = coerceInputValue }
