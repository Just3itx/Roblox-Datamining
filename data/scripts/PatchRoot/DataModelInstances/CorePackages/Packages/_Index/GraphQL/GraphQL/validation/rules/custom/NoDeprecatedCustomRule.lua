-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local invariant = require(scriptParentParentParentParent.jsutils.invariant).invariant
local GraphQLError = require(scriptParentParentParentParent.error.GraphQLError).GraphQLError
local definition = require(scriptParentParentParentParent.type.definition)
local getNamedType = definition.getNamedType
local isInputObjectType = definition.isInputObjectType

local module = {}

function module.NoDeprecatedCustomRule(arg1)
    return {
        Field = function(_, arg2)
            local fieldDef = arg1:getFieldDef()
            local deprecationReason = fieldDef and fieldDef.deprecationReason
            if fieldDef and deprecationReason ~= nil then
                local parentType = arg1:getParentType()
                invariant(parentType ~= nil)
                arg1:reportError(
                    GraphQLError.new(("The field %s.%s is deprecated. %s"):format(parentType.name, fieldDef.name, deprecationReason), arg2)
                )
            end
        end,
        Argument = function(_, arg2)
            local argument = arg1:getArgument()
            local deprecationReason = argument and argument.deprecationReason
            if not argument or deprecationReason == nil then
                return
            end

            local directive = arg1:getDirective()
            if directive ~= nil then
                arg1:reportError(
                    GraphQLError.new(
                        ("Directive \"@%s\" argument \"%s\" is deprecated. %s"):format(directive.name, argument.name, deprecationReason),
                        arg2
                    )
                )
                return
            end

            local parentType = arg1:getParentType()
            local fieldDef = arg1:getFieldDef()
            invariant(not (parentType == nil) and fieldDef ~= nil)
            arg1:reportError(
                GraphQLError.new(
                    ("Field \"%s.%s\" argument \"%s\" is deprecated. %s"):format(
                        parentType.name,
                        fieldDef.name,
                        argument.name,
                        deprecationReason
                    ),
                    arg2
                )
            )
        end,
        ObjectField = function(_, arg2)
            local namedType = getNamedType(arg1:getParentInputType())
            if not isInputObjectType(namedType) then
                return
            end
            local var1 = namedType:getFields():get(arg2.name.value)

            local deprecationReason = var1 and var1.deprecationReason
            if deprecationReason ~= nil then
                arg1:reportError(
                    GraphQLError.new(("The input field %s.%s is deprecated. %s"):format(namedType.name, var1.name, deprecationReason), arg2)
                )
            end
        end,
        EnumValue = function(_, arg2)
            local enumValue = arg1:getEnumValue()
            local deprecationReason = enumValue and enumValue.deprecationReason
            if enumValue and deprecationReason ~= nil then
                local namedType = getNamedType(arg1:getInputType())
                invariant(namedType ~= nil)
                arg1:reportError(
                    GraphQLError.new(
                        ("The enum value \"%s.%s\" is deprecated. %s"):format(namedType.name, enumValue.name, deprecationReason),
                        arg2
                    )
                )
            end
        end
    }
end

return module
