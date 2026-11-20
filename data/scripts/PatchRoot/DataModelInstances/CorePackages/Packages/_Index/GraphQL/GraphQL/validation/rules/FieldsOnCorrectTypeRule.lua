-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local jsutils = scriptParentParentParent.jsutils
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local didYouMean = require(jsutils.didYouMean).didYouMean
local suggestionList = require(jsutils.suggestionList).suggestionList
local naturalCompare = require(jsutils.naturalCompare).naturalCompare
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local definition = require(scriptParentParentParent.type.definition)
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isAbstractType = definition.isAbstractType

local getSuggestedFieldNames = nil
local getSuggestedTypeNames = nil

local module = {}

function module.FieldsOnCorrectTypeRule(arg1)
    return {
        Field = function(_, arg2)
            local parentType = arg1:getParentType()
            if not parentType or arg1:getFieldDef() then
                return
            end
            local schema = arg1:getSchema()
            local value = arg2.name.value

            local var1 = didYouMean("to use an inline fragment on", getSuggestedTypeNames(schema, parentType, value))

            if var1 == "" then
                var1 = didYouMean(getSuggestedFieldNames(parentType, value))
            end

            arg1:reportError(
                GraphQLError.new(("Cannot query field \"%s\" on type \"%s\"."):format(value, parentType.name) .. var1, arg2)
            )
        end
    }
end

getSuggestedTypeNames = function(arg1, arg2, arg3)
    if not isAbstractType(arg2) then
        return {}
    end

    local tbl1 = ({})
    local tbl2 = {}

    for _, value in ipairs(arg1:getPossibleTypes(arg2)) do
        if not value:getFields():get(arg3) then
            continue
        end

        tbl1[value] = true
        tbl2[value.name] = 1

        for _, value2 in ipairs(value:getInterfaces()) do
            if value2:getFields():get(arg3) then
                tbl1[value2] = true
                tbl2[value2.name] = (tbl2[value2.name] or 0) + 1
            end
        end
    end

    local tbl3 = {}
    for k, _ in pairs(tbl1) do
        table.insert(tbl3, k)
    end
    Array.sort(tbl3, function(arg4, arg5)
        local var1 = tbl2[arg5.name] - tbl2[arg4.name]
        if var1 ~= 0 then
            return var1
        elseif isInterfaceType(arg4) and arg1:isSubType(arg4, arg5) then
            return -1
        elseif isInterfaceType(arg5) and arg1:isSubType(arg5, arg4) then
            return 1
        end

        return naturalCompare(arg4.name, arg5.name)
    end)
    return Array.map(tbl3, function(arg4)
        return arg4.name
    end)
end

getSuggestedFieldNames = function(arg1, arg2)
    if not (isObjectType(arg1) or isInterfaceType(arg1)) then
        return {}
    end

    local var1 = arg1:getFields():keys()
    return suggestionList(arg2, var1)
end

return module
