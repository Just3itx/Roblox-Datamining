-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local keyMapOrdered = require(scriptParentParent.luaUtils.keyMapOrdered).keyMapOrdered

local jsutils = scriptParentParent.jsutils
local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant
local naturalCompare = require(jsutils.naturalCompare).naturalCompare

local language = scriptParentParent.language
local print = require(language.printer).print
local visit = require(language.visitor).visit
local _ast = require(language.ast)

local type = scriptParentParent.type
local _schema = require(type.schema)

local definition = require(type.definition)

local isSpecifiedScalarType = require(type.scalars).isSpecifiedScalarType
local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local isNonNullType = definition.isNonNullType
local isListType = definition.isListType
local isNamedType = definition.isNamedType
local isRequiredArgument = definition.isRequiredArgument
local isRequiredInputField = definition.isRequiredInputField

local astFromValue = require(script.Parent.astFromValue).astFromValue

local findSchemaChanges = nil
local findTypeChanges = nil
local findDirectiveChanges = nil
local diff = nil
local findEnumTypeChanges = nil
local findUnionTypeChanges = nil
local findInputObjectTypeChanges = nil
local findFieldChanges = nil
local findImplementedInterfacesChanges = nil
local typeKindName = nil
local isChangeSafeForInputObjectFieldOrFieldArg = nil
local findArgChanges = nil
local isChangeSafeForObjectOrInterfaceField = nil
local stringifyValue = nil

local BreakingChangeType = Object.freeze({
    TYPE_REMOVED = "TYPE_REMOVED",
    TYPE_CHANGED_KIND = "TYPE_CHANGED_KIND",
    TYPE_REMOVED_FROM_UNION = "TYPE_REMOVED_FROM_UNION",
    VALUE_REMOVED_FROM_ENUM = "VALUE_REMOVED_FROM_ENUM",
    REQUIRED_INPUT_FIELD_ADDED = "REQUIRED_INPUT_FIELD_ADDED",
    IMPLEMENTED_INTERFACE_REMOVED = "IMPLEMENTED_INTERFACE_REMOVED",
    FIELD_REMOVED = "FIELD_REMOVED",
    FIELD_CHANGED_KIND = "FIELD_CHANGED_KIND",
    REQUIRED_ARG_ADDED = "REQUIRED_ARG_ADDED",
    ARG_REMOVED = "ARG_REMOVED",
    ARG_CHANGED_KIND = "ARG_CHANGED_KIND",
    DIRECTIVE_REMOVED = "DIRECTIVE_REMOVED",
    DIRECTIVE_ARG_REMOVED = "DIRECTIVE_ARG_REMOVED",
    REQUIRED_DIRECTIVE_ARG_ADDED = "REQUIRED_DIRECTIVE_ARG_ADDED",
    DIRECTIVE_REPEATABLE_REMOVED = "DIRECTIVE_REPEATABLE_REMOVED",
    DIRECTIVE_LOCATION_REMOVED = "DIRECTIVE_LOCATION_REMOVED"
})

local DangerousChangeType = Object.freeze({
    VALUE_ADDED_TO_ENUM = "VALUE_ADDED_TO_ENUM",
    TYPE_ADDED_TO_UNION = "TYPE_ADDED_TO_UNION",
    OPTIONAL_INPUT_FIELD_ADDED = "OPTIONAL_INPUT_FIELD_ADDED",
    OPTIONAL_ARG_ADDED = "OPTIONAL_ARG_ADDED",
    IMPLEMENTED_INTERFACE_ADDED = "IMPLEMENTED_INTERFACE_ADDED",
    ARG_DEFAULT_VALUE_CHANGE = "ARG_DEFAULT_VALUE_CHANGE"
})

local function findBreakingChanges(arg1, arg2)
    return (Array.filter(findSchemaChanges(arg1, arg2), function(arg3): boolean
        return BreakingChangeType[arg3.type] ~= nil
    end))
end

local function findDangerousChanges(arg1, arg2)
    return (Array.filter(findSchemaChanges(arg1, arg2), function(arg3): boolean
        return DangerousChangeType[arg3.type] ~= nil
    end))
end

findSchemaChanges = function(arg1, arg2)
    return Array.concat(findTypeChanges(arg1, arg2), findDirectiveChanges(arg1, arg2))
end

findDirectiveChanges = function(arg1, arg2)
    local directiveChanges = {}

    local var3 = diff(arg1:getDirectives(), arg2:getDirectives())

    for _, value in ipairs(var3.removed) do
        table.insert(
            directiveChanges,
            {
                type = BreakingChangeType.DIRECTIVE_REMOVED,
                description = ("%s was removed."):format(value.name)
            }
        )
    end
    for _, value in ipairs(var3.persisted) do
        local var4 = value[1]
        local var5 = value[2]
        local var6 = diff(var4.args, var5.args)

        for _, value2 in ipairs(var6.added) do
            if isRequiredArgument(value2) then
                table.insert(directiveChanges, {
                    type = BreakingChangeType.REQUIRED_DIRECTIVE_ARG_ADDED,
                    description = ("A required arg %s on directive %s was added."):format(value2.name, var4.name)
                })
            end
        end

        for _, value2 in ipairs(var6.removed) do
            table.insert(directiveChanges, {
                type = BreakingChangeType.DIRECTIVE_ARG_REMOVED,
                description = ("%s was removed from %s."):format(value2.name, var4.name)
            })
        end

        if var4.isRepeatable and not var5.isRepeatable then
            table.insert(directiveChanges, {
                type = BreakingChangeType.DIRECTIVE_REPEATABLE_REMOVED,
                description = ("Repeatable flag was removed from %s."):format(var4.name)
            })
        end

        for _, location in ipairs(var4.locations) do
            if table.find(var5.locations, location) == nil then
                table.insert(directiveChanges, {
                    type = BreakingChangeType.DIRECTIVE_LOCATION_REMOVED,
                    description = ("%s was removed from %s."):format(location, var4.name)
                })
            end
        end
    end

    return directiveChanges
end

findTypeChanges = function(arg1, arg2)
    local typeChanges = {}

    local var3 = diff(arg1:getTypeMap():values(), arg2:getTypeMap():values())

    for _, value in ipairs(var3.removed) do
        table.insert(typeChanges, {
            type = BreakingChangeType.TYPE_REMOVED,
            description = isSpecifiedScalarType(value)
                and ("Standard scalar %s was removed because it is not referenced anymore."):format(value.name)
                or ("%s was removed."):format(value.name)
        })
    end

    for _, value in ipairs(var3.persisted) do
        local var4 = value[1]
        local var5 = value[2]
        if isEnumType(var4) and isEnumType(var5) then
            for _, value2 in ipairs(findEnumTypeChanges(var4, var5)) do
                table.insert(typeChanges, value2)
            end
        elseif isUnionType(var4) and isUnionType(var5) then
            for _, value2 in ipairs(findUnionTypeChanges(var4, var5)) do
                table.insert(typeChanges, value2)
            end
        elseif isInputObjectType(var4) and isInputObjectType(var5) then
            for _, value2 in ipairs(findInputObjectTypeChanges(var4, var5)) do
                table.insert(typeChanges, value2)
            end
        elseif isObjectType(var4) and isObjectType(var5) then
            for _, value2 in ipairs(Array.concat(findFieldChanges(var4, var5), findImplementedInterfacesChanges(var4, var5))) do
                table.insert(typeChanges, value2)
            end
        elseif isInterfaceType(var4) and isInterfaceType(var5) then
            for _, value2 in ipairs(Array.concat(findFieldChanges(var4, var5), findImplementedInterfacesChanges(var4, var5))) do
                table.insert(typeChanges, value2)
            end
        elseif var4.new ~= var5.new then
            table.insert(typeChanges, {
                type = BreakingChangeType.TYPE_CHANGED_KIND,
                description = ("%s changed from %s to %s."):format(var4.name, typeKindName(var4), typeKindName(var5))
            })
        end
    end

    return typeChanges
end

findInputObjectTypeChanges = function(arg1, arg2)
    local inputObjectTypeChanges = {}

    local var3 = diff(arg1:getFields():values(), arg2:getFields():values())

    for _, value in ipairs(var3.added) do
        if isRequiredInputField(value) then
            table.insert(inputObjectTypeChanges, {
                type = BreakingChangeType.REQUIRED_INPUT_FIELD_ADDED,
                description = ("A required field %s on input type %s was added."):format(value.name, arg1.name)
            })
        else
            table.insert(inputObjectTypeChanges, {
                type = DangerousChangeType.OPTIONAL_INPUT_FIELD_ADDED,
                description = ("An optional field %s on input type %s was added."):format(value.name, arg1.name)
            })
        end
    end

    for _, value in ipairs(var3.removed) do
        table.insert(
            inputObjectTypeChanges,
            {
                type = BreakingChangeType.FIELD_REMOVED,
                description = ("%s.%s was removed."):format(arg1.name, value.name)
            }
        )
    end
    for _, value in ipairs(var3.persisted) do
        local var4 = value[1]
        local var5 = value[2]
        if isChangeSafeForInputObjectFieldOrFieldArg(var4.type, var5.type) then
            continue
        end

        local tbl1 = {
            type = BreakingChangeType.FIELD_CHANGED_KIND,
            description = 0
        }
        local name = arg1.name
        local name2 = var4.name
        local str1 = tostring(var4.type)
        local type2 = var5.type
        tbl1.description = ("%s.%s changed type from %s to %s."):format(name, name2, str1, tostring(type2))
        table.insert(inputObjectTypeChanges, tbl1)
    end

    return inputObjectTypeChanges
end

findUnionTypeChanges = function(arg1, arg2)
    local unionTypeChanges = {}
    local var3 = diff(arg1:getTypes(), arg2:getTypes())

    for _, value in ipairs(var3.added) do
        table.insert(unionTypeChanges, {
            type = DangerousChangeType.TYPE_ADDED_TO_UNION,
            description = ("%s was added to union type %s."):format(value.name, arg1.name)
        })
    end

    for _, value in ipairs(var3.removed) do
        table.insert(unionTypeChanges, {
            type = BreakingChangeType.TYPE_REMOVED_FROM_UNION,
            description = ("%s was removed from union type %s."):format(value.name, arg1.name)
        })
    end

    return unionTypeChanges
end

findEnumTypeChanges = function(arg1, arg2)
    local enumTypeChanges = {}
    local var3 = diff(arg1:getValues(), arg2:getValues())

    for _, value in ipairs(var3.added) do
        table.insert(enumTypeChanges, {
            type = DangerousChangeType.VALUE_ADDED_TO_ENUM,
            description = ("%s was added to enum type %s."):format(value.name, arg1.name)
        })
    end
    for _, value in ipairs(var3.removed) do
        table.insert(enumTypeChanges, {
            type = BreakingChangeType.VALUE_REMOVED_FROM_ENUM,
            description = ("%s was removed from enum type %s."):format(value.name, arg1.name)
        })
    end

    return enumTypeChanges
end

findImplementedInterfacesChanges = function(arg1, arg2)
    local implementedInterfacesChanges = {}

    local var3 = diff(arg1:getInterfaces(), arg2:getInterfaces())

    for _, value in ipairs(var3.added) do
        table.insert(implementedInterfacesChanges, {
            type = DangerousChangeType.IMPLEMENTED_INTERFACE_ADDED,
            description = ("%s added to interfaces implemented by %s."):format(value.name, arg1.name)
        })
    end

    for _, value in ipairs(var3.removed) do
        table.insert(implementedInterfacesChanges, {
            type = BreakingChangeType.IMPLEMENTED_INTERFACE_REMOVED,
            description = ("%s no longer implements interface %s."):format(arg1.name, value.name)
        })
    end

    return implementedInterfacesChanges
end

findFieldChanges = function(arg1, arg2)
    local fieldChanges = {}

    local var3 = diff(arg1:getFields():values(), arg2:getFields():values())

    for _, value in ipairs(var3.removed) do
        table.insert(
            fieldChanges,
            {
                type = BreakingChangeType.FIELD_REMOVED,
                description = ("%s.%s was removed."):format(arg1.name, value.name)
            }
        )
    end

    for _, value in ipairs(var3.persisted) do
        local var4 = value[1]
        local var5 = value[2]

        for _, value2 in ipairs(findArgChanges(arg1, var4, var5)) do
            table.insert(fieldChanges, value2)
        end

        if isChangeSafeForObjectOrInterfaceField(var4.type, var5.type) then
            continue
        end

        local tbl1 = {
            type = BreakingChangeType.FIELD_CHANGED_KIND,
            description = 0
        }
        local str1 = ("%s.%s changed type from "):format(arg1.name, var4.name)

        local str2 = tostring(var4.type)
        local type2 = var5.type
        tbl1.description = str1 .. ("%s to %s."):format(str2, tostring(type2))
        table.insert(fieldChanges, tbl1)
    end

    return fieldChanges
end

findArgChanges = function(arg1, arg2, arg3)
    local argChanges = {}
    local var3 = diff(arg2.args, arg3.args)

    for _, value in ipairs(var3.removed) do
        table.insert(argChanges, {
            type = BreakingChangeType.ARG_REMOVED,
            description = ("%s.%s arg %s was removed."):format(arg1.name, arg2.name, value.name)
        })
    end

    for _, value in ipairs(var3.persisted) do
        local var4 = value[1]
        local var5 = value[2]
        if not isChangeSafeForInputObjectFieldOrFieldArg(var4.type, var5.type) then
            local tbl1 = {
                type = BreakingChangeType.ARG_CHANGED_KIND,
                description = 0
            }
            local str1 = ("%s.%s arg %s has changed type from "):format(arg1.name, arg2.name, var4.name)
            local str2 = tostring(var4.type)
            local type2 = var5.type
            tbl1.description = str1 .. ("%s to %s."):format(str2, tostring(type2))
            table.insert(argChanges, tbl1)
        elseif var4.defaultValue ~= nil then
            if var5.defaultValue == nil then
                table.insert(argChanges, {
                    type = DangerousChangeType.ARG_DEFAULT_VALUE_CHANGE,
                    description = ("%s.%s arg %s defaultValue was removed."):format(arg1.name, arg2.name, var4.name)
                })
            else
                local var6 = stringifyValue(var4.defaultValue, var4.type)
                local var7 = stringifyValue(var5.defaultValue, var5.type)

                if var6 ~= var7 then
                    table.insert(argChanges, {
                        type = DangerousChangeType.ARG_DEFAULT_VALUE_CHANGE,
                        description = ("%s.%s arg %s has changed defaultValue from %s to %s."):format(arg1.name, arg2.name, var4.name, var6, var7)
                    })
                end
            end
        end
    end

    for _, value in ipairs(var3.added) do
        if isRequiredArgument(value) then
            table.insert(argChanges, {
                type = BreakingChangeType.REQUIRED_ARG_ADDED,
                description = ("A required arg %s on %s.%s was added."):format(value.name, arg1.name, arg2.name)
            })
        else
            table.insert(argChanges, {
                type = DangerousChangeType.OPTIONAL_ARG_ADDED,
                description = ("An optional arg %s on %s.%s was added."):format(value.name, arg1.name, arg2.name)
            })
        end
    end

    return argChanges
end

isChangeSafeForObjectOrInterfaceField = function(arg1, arg2)
    if isListType(arg1) then
        return isListType(arg2) and isChangeSafeForObjectOrInterfaceField(arg1.ofType, arg2.ofType)
            or isNonNullType(arg2) and isChangeSafeForObjectOrInterfaceField(arg1, arg2.ofType)
    end

    if isNonNullType(arg1) then
        return isNonNullType(arg2) and isChangeSafeForObjectOrInterfaceField(arg1.ofType, arg2.ofType)
    end

    return if isNamedType(arg2) and arg1.name == arg2.name then true else isNonNullType(arg2) and isChangeSafeForObjectOrInterfaceField(arg1, arg2.ofType)
end

isChangeSafeForInputObjectFieldOrFieldArg = function(arg1, arg2)
    if isListType(arg1) then
        return isListType(arg2) and isChangeSafeForInputObjectFieldOrFieldArg(arg1.ofType, arg2.ofType)
    end

    if isNonNullType(arg1) then
        return isNonNullType(arg2) and isChangeSafeForInputObjectFieldOrFieldArg(arg1.ofType, arg2.ofType)
            or not isNonNullType(arg2) and isChangeSafeForInputObjectFieldOrFieldArg(arg1.ofType, arg2)
    end

    return isNamedType(arg2) and arg1.name == arg2.name
end

typeKindName = function(arg1): string
    if isScalarType(arg1) then
        return "a Scalar type"
    end
    if isObjectType(arg1) then
        return "an Object type"
    end
    if isInterfaceType(arg1) then
        return "an Interface type"
    end
    if isUnionType(arg1) then
        return "a Union type"
    end
    if isEnumType(arg1) then
        return "an Enum type"
    end

    if isInputObjectType(arg1) then
        return "an Input type"
    end

    invariant(false, "Unexpected type: " .. inspect(arg1))

    return ""
end

stringifyValue = function(arg1, arg2)
    local var3 = astFromValue(arg1, arg2)

    invariant(var3 ~= nil)

    local var4 = visit(var3, {
        ObjectValue = function(_, arg3)
            local fields = Array.concat({}, arg3.fields)

            Array.sort(fields, function(arg4, arg5)
                return naturalCompare(arg4.name.value, arg5.name.value)
            end)

            return Object.assign({}, arg3, { fields = fields })
        end
    })

    return print(var4)
end

diff = function(arg1, arg2)
    local added = {}
    local removed = {}
    local persisted = {}
    local var3 = keyMapOrdered(arg1, function(arg3)
        return arg3.name
    end)
    local var4 = keyMapOrdered(arg2, function(arg3)
        return arg3.name
    end)

    for _, value in ipairs(arg1) do
        local var5 = var4:get(value.name)

        if var5 == nil then
            table.insert(removed, value)
        else
            table.insert(persisted, { value, var5 })
        end
    end
    for _, value in ipairs(arg2) do
        if var3:get(value.name) == nil then
            table.insert(added, value)
        end
    end

    return { added = added, persisted = persisted, removed = removed }
end

return {
    BreakingChangeType = BreakingChangeType,
    DangerousChangeType = DangerousChangeType,
    findBreakingChanges = findBreakingChanges,
    findDangerousChanges = findDangerousChanges
}
