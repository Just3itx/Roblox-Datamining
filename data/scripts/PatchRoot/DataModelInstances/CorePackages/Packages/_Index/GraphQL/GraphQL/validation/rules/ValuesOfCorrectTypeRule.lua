-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local language = scriptParentParentParent.language
local jsutils = scriptParentParentParent.jsutils

local instanceOf = require(jsutils.instanceOf)
local keyMap = require(jsutils.keyMap).keyMap
local inspect = require(jsutils.inspect).inspect
local didYouMean = require(jsutils.didYouMean).didYouMean
local suggestionList = require(jsutils.suggestionList).suggestionList
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local print = require(language.printer).print
local definition = require(scriptParentParentParent.type.definition)
local isLeafType = definition.isLeafType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType
local isRequiredInputField = definition.isRequiredInputField
local getNullableType = definition.getNullableType
local getNamedType = definition.getNamedType

local module = {}

local isValidValueNode = nil

function module.ValuesOfCorrectTypeRule(arg1)
    return {
        ListValue = function(_, arg2)
            local nullableType = getNullableType(arg1:getParentInputType())
            if not isListType(nullableType) then
                isValidValueNode(arg1, arg2)
                return false
            end
        end,
        ObjectValue = function(_, arg2)
            local namedType = getNamedType(arg1:getInputType())
            if not isInputObjectType(namedType) then
                isValidValueNode(arg1, arg2)
                return false
            end

            local var1 = keyMap(arg2.fields, function(arg3)
                return arg3.name.value
            end)

            for _, value in ipairs(namedType:getFields():values()) do
                if not var1[value.name] and isRequiredInputField(value) then
                    local var2 = inspect(value.type)
                    arg1:reportError(
                        GraphQLError.new(
                            ("Field \"%s.%s\" of required type \"%s\" was not provided."):format(namedType.name, value.name, var2),
                            arg2
                        )
                    )
                end
            end
        end,
        ObjectField = function(_, arg2)
            local namedType = getNamedType(arg1:getParentInputType())
            if not arg1:getInputType() and isInputObjectType(namedType) then
                local var1 = suggestionList(arg2.name.value, namedType:getFields():keys())

                arg1:reportError(
                    GraphQLError.new(
                        ("Field \"%s\" is not defined by type \"%s\"."):format(arg2.name.value, namedType.name) .. didYouMean(var1),
                        arg2
                    )
                )
            end
        end,
        NullValue = function(_, arg2)
            local inputType = arg1:getInputType()
            if isNonNullType(inputType) then
                arg1:reportError(
                    GraphQLError.new(("Expected value of type \"%s\", found %s."):format(inspect(inputType), print(arg2)), arg2)
                )
            end
        end,
        EnumValue = function(_, arg2)
            return isValidValueNode(arg1, arg2)
        end,
        IntValue = function(_, arg2)
            return isValidValueNode(arg1, arg2)
        end,
        FloatValue = function(_, arg2)
            return isValidValueNode(arg1, arg2)
        end,
        StringValue = function(_, arg2)
            return isValidValueNode(arg1, arg2)
        end,
        BooleanValue = function(_, arg2)
            return isValidValueNode(arg1, arg2)
        end
    }
end

isValidValueNode = function(arg1, arg2)
    local inputType = arg1:getInputType()
    if not inputType then
        return
    end

    local namedType = getNamedType(inputType)

    if not isLeafType(namedType) then
        local var1 = inspect(inputType)
        arg1:reportError(GraphQLError.new(("Expected value of type \"%s\", found %s."):format(var1, print(arg2)), arg2))

        return
    end

    xpcall(function()
        if namedType:parseLiteral(arg2, nil) == nil then
            local var1 = inspect(inputType)

            arg1:reportError(GraphQLError.new(("Expected value of type \"%s\", found %s."):format(var1, print(arg2)), arg2))
        end
    end, function(arg3)
        local var1 = inspect(inputType)
        if instanceOf(arg3, GraphQLError) then
            arg1:reportError(arg3)
            return
        end
        arg1:reportError(
            GraphQLError.new(
                ("Expected value of type \"%s\", found %s; "):format(var1, print(arg2)) .. arg3.message,
                arg2,
                nil,
                nil,
                nil,
                arg3
            )
        )
    end)
end

return module
