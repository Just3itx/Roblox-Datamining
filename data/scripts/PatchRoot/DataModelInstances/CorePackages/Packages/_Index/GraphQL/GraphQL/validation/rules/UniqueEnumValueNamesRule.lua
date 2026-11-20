-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Map = require(scriptParentParentParentParent.LuauPolyfill).Map

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local isEnumType = require(scriptParentParentParent.type.definition).isEnumType

local module = {}

function module.UniqueEnumValueNamesRule(arg1)
    local schema = arg1:getSchema()

    local var1 = schema and schema:getTypeMap() or Map.new()
    local tbl1 = ({})

    local function checkValueUniqueness(_, arg2): boolean
        local value = arg2.name.value

        if not tbl1[value] then
            tbl1[value] = {}
        end

        local values = arg2.values or {}
        local var2 = tbl1[value]

        for _, value2 in ipairs(values) do
            local value3 = value2.name.value

            local var3 = var1:get(value)
            if isEnumType(var3) and var3:getValue(value3) then
                arg1:reportError(
                    GraphQLError.new(
                        ("Enum value \"%s.%s\" already exists in the schema. It cannot also be defined in this type extension."):format(
                            value,
                            value3
                        ),
                        value2.name
                    )
                )
            elseif var2[value3] then
                arg1:reportError(
                    GraphQLError.new(
                        ("Enum value \"%s.%s\" can only be defined once."):format(value, value3),
                        { var2[value3], value2.name }
                    )
                )
            else
                var2[value3] = value2.name
            end
        end

        return false
    end

    return { EnumTypeDefinition = checkValueUniqueness, EnumTypeExtension = checkValueUniqueness }
end

return module
