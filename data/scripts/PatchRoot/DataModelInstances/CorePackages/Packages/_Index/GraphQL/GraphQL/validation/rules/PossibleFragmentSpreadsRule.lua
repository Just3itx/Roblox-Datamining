-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local inspect = require(scriptParentParentParent.jsutils.inspect).inspect
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local isCompositeType = require(scriptParentParentParent.type.definition).isCompositeType
local utilities = scriptParentParentParent.utilities
local typeFromAST = require(utilities.typeFromAST).typeFromAST
local doTypesOverlap = require(utilities.typeComparators).doTypesOverlap

local module = {}

local getFragmentType = nil

function module.PossibleFragmentSpreadsRule(arg1)
    return {
        InlineFragment = function(_, arg2)
            local type = arg1:getType()
            local parentType = arg1:getParentType()

            if isCompositeType(type) and isCompositeType(parentType) and not doTypesOverlap(arg1:getSchema(), type, parentType) then
                local var1 = inspect(parentType)
                local var2 = inspect(type)

                arg1:reportError(
                    GraphQLError.new(
                        ("Fragment cannot be spread here as objects of type \"%s\" can never be of type \"%s\"."):format(var1, var2),
                        arg2
                    )
                )
            end
        end,
        FragmentSpread = function(_, arg2)
            local value = arg2.name.value
            local fragmentType = getFragmentType(arg1, value)
            local parentType = arg1:getParentType()
            if fragmentType and parentType and not doTypesOverlap(arg1:getSchema(), fragmentType, parentType) then
                local var1 = inspect(parentType)
                local var2 = inspect(fragmentType)
                arg1:reportError(
                    GraphQLError.new(
                        ("Fragment \"%s\" cannot be spread here as objects of type \"%s\" can never be of type \"%s\"."):format(
                            value,
                            var1,
                            var2
                        ),
                        arg2
                    )
                )
            end
        end
    }
end

getFragmentType = function(arg1, str1: string)
    local fragment = arg1:getFragment(str1)
    if fragment then
        local var1 = typeFromAST(arg1:getSchema(), fragment.typeCondition)
        if isCompositeType(var1) then
            return var1
        end
    end

    return nil
end

return module
