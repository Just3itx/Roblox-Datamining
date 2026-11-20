-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local HttpService = game:GetService("HttpService")

local _ast = require(script.Parent.ast)

local visit = require(script.Parent.visitor).visit
local printBlockString = require(script.Parent.blockString).printBlockString

local var1 = nil

local join = nil
local block = nil
local wrap = nil
local indent = nil

local hasMultilineItems = nil

local function print_(arg1)
    return visit(arg1, { leave = var1 })
end

local function addDescription(arg1)
    return function(_, arg2)
        return join({ arg2.description, arg1(arg2) }, "\n")
    end
end

var1 = {
    Name = function(_, arg1)
        return arg1.value
    end,
    Variable = function(_, arg1): string
        return "$" .. tostring(arg1.name)
    end,
    Document = function(_, arg1)
        return join(arg1.definitions, "\n\n") .. "\n"
    end,
    OperationDefinition = function(_, arg1)
        local operation = arg1.operation
        local name = arg1.name
        local var2 = wrap("(", join(arg1.variableDefinitions, ", "), ")")
        local var3 = join(arg1.directives, " ")
        local selectionSet = arg1.selectionSet

        if not name and (not var3 or var3 == "") and (not var2 or var2 == "") and operation == "query" then
            return selectionSet
        end

        return join({ operation, join({ name, var2 }), var3, selectionSet }, " ")
    end,
    VariableDefinition = function(_, arg1)
        local variable = arg1.variable
        local type = arg1.type
        local defaultValue = arg1.defaultValue
        local directives = arg1.directives
        return tostring(variable) .. ": " .. tostring(type) .. wrap(" = ", defaultValue) .. wrap(" ", join(directives, " "))
    end,
    SelectionSet = function(_, arg1)
        return block(arg1.selections)
    end,
    Field = function(_, arg1)
        local alias = arg1.alias
        local name = arg1.name
        local arguments = arg1.arguments
        local directives = arg1.directives
        local selectionSet = arg1.selectionSet
        local var2 = wrap("", alias, ": ") .. tostring(name)
        local var3 = var2 .. wrap("(", join(arguments, ", "), ")")

        local var4 = utf8.len(var3)
        assert(var4 ~= nil, "invalid utf8 string")

        if var4 > 80 then
            var3 = var2 .. wrap("(\n", indent(join(arguments, "\n")), "\n)")
        end

        return join({ var3, join(directives, " "), selectionSet }, " ")
    end,
    Argument = function(_, arg1): string
        local name = arg1.name
        local value = arg1.value
        return tostring(name) .. ": " .. tostring(value)
    end,
    FragmentSpread = function(_, arg1)
        local name = arg1.name
        local directives = arg1.directives
        return "..." .. tostring(name) .. wrap(" ", join(directives, " "))
    end,
    InlineFragment = function(_, arg1)
        local typeCondition = arg1.typeCondition
        local directives = arg1.directives
        local selectionSet = arg1.selectionSet

        return join({ "...", wrap("on ", typeCondition), join(directives, " "), selectionSet }, " ")
    end,
    FragmentDefinition = function(_, arg1)
        local name = arg1.name
        local typeCondition = arg1.typeCondition
        local variableDefinitions = arg1.variableDefinitions
        local directives = arg1.directives
        local selectionSet = arg1.selectionSet

        return "fragment " .. tostring(name) .. wrap("(", join(variableDefinitions, ", "), ")") .. " " .. "on " .. tostring(typeCondition) .. " " .. wrap("", join(directives, " "), " ") .. tostring(selectionSet)
    end,
    IntValue = function(_, arg1)
        return arg1.value
    end,
    FloatValue = function(_, arg1)
        return arg1.value
    end,
    StringValue = function(_, arg1, str1: string)
        local value = arg1.value
        if arg1.block then
            return (printBlockString(value, if str1 == "description" then "" else "  "))
        end

        return (HttpService:JSONEncode(value))
    end,
    BooleanValue = function(_, arg1): string
        return if arg1.value then "true" else "false"
    end,
    NullValue = function(_, _): string
        return "null"
    end,
    EnumValue = function(_, arg1)
        return arg1.value
    end,
    ListValue = function(_, tbl1)
        local values = tbl1.values
        return "[" .. join(values, ", ") .. "]"
    end,
    ObjectValue = function(_, tbl1)
        local fields = tbl1.fields
        return "{" .. join(fields, ", ") .. "}"
    end,
    ObjectField = function(_, tbl1)
        return tbl1.name .. ": " .. tbl1.value
    end,
    Directive = function(_, arg1)
        local name = arg1.name
        local arguments = arg1.arguments
        return "@" .. tostring(name) .. wrap("(", join(arguments, ", "), ")")
    end,
    NamedType = function(_, arg1)
        return arg1.name
    end,
    ListType = function(_, arg1): string
        return "[" .. tostring(arg1.type) .. "]"
    end,
    NonNullType = function(_, arg1): string
        return tostring(arg1.type) .. "!"
    end,
    SchemaDefinition = addDescription(function(arg1)
        local directives = arg1.directives
        local operationTypes = arg1.operationTypes

        return join({ "schema", join(directives, " "), block(operationTypes) }, " ")
    end),
    OperationTypeDefinition = function(_, arg1): string
        local operation = arg1.operation
        local type = arg1.type
        return tostring(operation) .. ": " .. tostring(type)
    end,
    ScalarTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local directives = arg1.directives

        return join({ "scalar", name, join(directives, " ") }, " ")
    end),
    ObjectTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local interfaces = arg1.interfaces
        local directives = arg1.directives
        local fields = arg1.fields
        return join({ "type", name, wrap("implements ", join(interfaces, " & ")), join(directives, " "), block(fields) }, " ")
    end),
    FieldDefinition = addDescription(function(arg1)
        local name = arg1.name
        local arguments = arg1.arguments
        local type = arg1.type
        local directives = arg1.directives
        return tostring(name) .. (if hasMultilineItems(arguments) then wrap("(\n", indent(join(arguments, "\n")), "\n)") else wrap("(", join(arguments, ", "), ")")) .. ": " .. tostring(type) .. wrap(" ", join(directives, " "))
    end),
    InputValueDefinition = addDescription(function(arg1)
        local name = arg1.name
        local type = arg1.type
        local defaultValue = arg1.defaultValue
        local directives = arg1.directives
        return join({ tostring(name) .. ": " .. tostring(type), wrap("= ", defaultValue), join(directives, " ") }, " ")
    end),
    InterfaceTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local interfaces = arg1.interfaces
        local directives = arg1.directives
        local fields = arg1.fields

        return join({ "interface", name, wrap("implements ", join(interfaces, " & ")), join(directives, " "), block(fields) }, " ")
    end),
    UnionTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local directives = arg1.directives
        local types = arg1.types

        return join({ "union", name, join(directives, " "), if not types or #types == 0 then "" else "= " .. join(types, " | ") }, " ")
    end),
    EnumTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local directives = arg1.directives
        local values = arg1.values

        return join({ "enum", name, join(directives, " "), block(values) }, " ")
    end),
    EnumValueDefinition = addDescription(function(arg1)
        local name = arg1.name
        local directives = arg1.directives

        return join({ name, join(directives, " ") }, " ")
    end),
    InputObjectTypeDefinition = addDescription(function(arg1)
        local name = arg1.name
        local directives = arg1.directives
        local fields = arg1.fields

        return join({ "input", name, join(directives, " "), block(fields) }, " ")
    end),
    DirectiveDefinition = addDescription(function(arg1)
        local name = arg1.name
        local arguments = arg1.arguments
        local repeatable = arg1.repeatable
        local locations = arg1.locations
        return "directive @"
            .. tostring(name) .. (if hasMultilineItems(arguments) then wrap("(\n", indent(join(arguments, "\n")), "\n)") else wrap("(", join(arguments, ", "), ")")) .. (if repeatable then " repeatable" else "") .. " on " .. join(locations, " | ")
    end),
    SchemaExtension = function(_, arg1)
        local directives = arg1.directives
        local operationTypes = arg1.operationTypes

        return join({ "extend schema", join(directives, " "), block(operationTypes) }, " ")
    end,
    ScalarTypeExtension = function(_, arg1)
        local name = arg1.name
        local directives = arg1.directives

        return join({ "extend scalar", name, join(directives, " ") }, " ")
    end,
    ObjectTypeExtension = function(_, arg1)
        local name = arg1.name
        local interfaces = arg1.interfaces
        local directives = arg1.directives
        local fields = arg1.fields

        return join({ "extend type", name, wrap("implements ", join(interfaces, " & ")), join(directives, " "), block(fields) }, " ")
    end,
    InterfaceTypeExtension = function(_, arg1)
        local name = arg1.name
        local interfaces = arg1.interfaces
        local directives = arg1.directives
        local fields = arg1.fields

        return join(
            {
                "extend interface",
                name,
                wrap("implements ", join(interfaces, " & ")),
                join(directives, " "),
                block(fields)
            },
            " "
        )
    end,
    UnionTypeExtension = function(_, arg1)
        local name = arg1.name
        local directives = arg1.directives
        local types = arg1.types

        return join(
            {
                "extend union",
                name,
                join(directives, " "),
                if not types or #types == 0 then "" else "= " .. join(types, " | ")
            },
            " "
        )
    end,
    EnumTypeExtension = function(_, arg1)
        local name = arg1.name
        local directives = arg1.directives
        local values = arg1.values

        return join({ "extend enum", name, join(directives, " "), block(values) }, " ")
    end,
    InputObjectTypeExtension = function(_, arg1)
        local name = arg1.name
        local directives = arg1.directives
        local fields = arg1.fields

        return join({ "extend input", name, join(directives, " "), block(fields) }, " ")
    end
}

join = function(arg1, str1: string?)
    str1 = str1 or ""
    if arg1 then
        return Array.join(Array.filter(arg1, function(arg2): boolean | string
            return tostring(arg2) and arg2 ~= ""
        end), str1)
    end

    return ""
end

block = function(arg1)
    return wrap("{\n", indent(join(arg1, "\n")), "\n}")
end

wrap = function(str1: string, arg1, str2: string?): string
    if arg1 == nil or arg1 == "" then
        return ""
    end

    return str1 .. tostring(arg1) .. tostring(str2 or "")
end

indent = function(str1: string): string
    local var2 = str1:gsub("\n", "\n  ")
    return wrap("  ", var2)
end

local function isMultiline(str1: string): boolean
    return string.find(tostring(str1), "\n") ~= nil
end

hasMultilineItems = function(arg1)
    return not (arg1 == nil) and Array.some(arg1, isMultiline)
end

return { print = print_ }
