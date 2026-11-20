-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Map = require(scriptParentParentParentParent.LuauPolyfill).Map

local isNotNillish = require(scriptParentParentParent.luaUtils.isNillish).isNotNillish

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local definition = require(scriptParentParentParent.type.definition)
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isInputObjectType = definition.isInputObjectType

local module = {}

local hasField = nil

function module.UniqueFieldDefinitionNamesRule(arg1)
    local schema = arg1:getSchema()

    local var1 = schema and schema:getTypeMap() or Map.new()
    local tbl1 = ({})

    local function checkFieldUniqueness(_, arg2): boolean
        local value = arg2.name.value

        if not tbl1[value] then
            tbl1[value] = {}
        end

        local var2 = arg2.fields or {}
        local var3 = tbl1[value]

        for _, value2 in ipairs(var2) do
            local value3 = value2.name.value

            if hasField(var1:get(value), value3) then
                arg1:reportError(
                    GraphQLError.new(
                        ("Field \"%s.%s\" already exists in the schema. It cannot also be defined in this type extension."):format(
                            value,
                            value3
                        ),
                        value2.name
                    )
                )
            elseif var3[value3] then
                arg1:reportError(
                    GraphQLError.new(("Field \"%s.%s\" can only be defined once."):format(value, value3), { var3[value3], value2.name })
                )
            else
                var3[value3] = value2.name
            end
        end

        return false
    end

    return {
        InputObjectTypeDefinition = checkFieldUniqueness,
        InputObjectTypeExtension = checkFieldUniqueness,
        InterfaceTypeDefinition = checkFieldUniqueness,
        InterfaceTypeExtension = checkFieldUniqueness,
        ObjectTypeDefinition = checkFieldUniqueness,
        ObjectTypeExtension = checkFieldUniqueness
    }
end

hasField = function(arg1, str1: string)
    if isObjectType(arg1) or isInterfaceType(arg1) or isInputObjectType(arg1) then
        return isNotNillish(arg1:getFields():get(str1))
    end
    return false
end

return module
