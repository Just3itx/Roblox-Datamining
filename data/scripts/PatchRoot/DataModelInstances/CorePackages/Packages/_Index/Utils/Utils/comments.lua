-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}

local _types = require(script.Parent.types)

local GraphQL = require(scriptParentParent.GraphQL)

local visit = GraphQL.visit

local TokenKind = GraphQL.TokenKind

local _GraphQL = require(scriptParentParent.GraphQL)

local pushComment = nil
local isFieldDefinitionNode = nil
local getComment = nil
local getLeadingCommentBlock = nil
local dedentBlockStringValue = nil
local getBlockStringIndentation = nil
local isBlank = nil
local leadingWhitespace = nil

local String = LuauPolyfill.String

local tbl1 = {}
function module.resetComments()
    tbl1 = {}
end

function module.collectComment(arg1)
    local value = if typeof(arg1.name) == "table" then arg1.name.value else nil
    if value == nil then
        return
    end

    pushComment(arg1, value)

    local kind = arg1.kind
    if kind == "EnumTypeDefinition" then
        if Boolean.toJSBoolean(arg1.values) then
            for _, value2 in arg1.values do
                pushComment(value2, value, value2.name.value)
            end
        end

        return
    end

    if kind ~= "ObjectTypeDefinition" and kind ~= "InputObjectTypeDefinition" and kind ~= "InterfaceTypeDefinition"
        or not Boolean.toJSBoolean(arg1.fields)
    then
        return
    end

    for _, field in arg1.fields do
        pushComment(field, value, field.name.value)

        local toJsBoolean = Boolean.toJSBoolean
        local var1 = isFieldDefinitionNode(field)
        if Boolean.toJSBoolean(var1) then
            var1 = field.arguments
        end

        if not toJsBoolean(var1) then
            continue
        end

        for _, argument in field.arguments do
            pushComment(argument, value, field.name.value, argument.name.value)
        end
    end
end

pushComment = function(arg1, str1: string, str2: string?, str3: string?)
    local comment = getComment(arg1)

    if typeof(comment) ~= "string" or #comment == 0 then
        return
    end
    local tbl2 = { str1 }
    if Boolean.toJSBoolean(str2) then
        table.insert(tbl2, str2)

        if Boolean.toJSBoolean(str3) then
            table.insert(tbl2, str3)
        end
    end

    local var1 = Array.join(tbl2, ".")
    if not Boolean.toJSBoolean(tbl1[tostring(var1)]) then
        tbl1[tostring(var1)] = {}
    end

    table.insert(tbl1[var1], comment)
end

module.pushComment = pushComment
local function printComment(str1: string)
    return "\n# " .. str1:gsub("\n", "\n# ")
end

module.printComment = printComment

local function join(arg1, str1: string?)
    if Boolean.toJSBoolean(arg1) then
        return (Array.join(Array.filter(arg1, function(arg2)
            return Boolean.toJSBoolean(arg2)
        end), Boolean.toJSBoolean(str1) and str1 or ""))
    end
    return ""
end

local function hasMultilineItems(arguments) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = if typeof(arguments) == "table" then Array.some(arguments, function(arg1)
        return String.includes(arg1, "\n")
    end) else nil

    return not (var1 == nil) and var1
end

local function addDescription(leave: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1, tbl2, str1: string, arg2, arg3, arg4)
        local tbl3 = {}

        local var1 = Array.reduce(arg3, function(none, none2)
            if none2 ~= Object.None and Array.includes({ "fields", "arguments", "values" }, none2) and Boolean.toJSBoolean(none.name) then
                table.insert(tbl3, none.name.value)
            end
            return if none == Object.None then none2 else none[none2]
        end, arg4[1] or Object.None)

        local join2 = Array.join
        local filter = Array.filter

        local concat = Array.concat
        local tbl4 = {}
        local name = if typeof(var1) == "table" then var1.name else nil
        local value = if typeof(name) == "table" then (if typeof(var1) == "table" then var1.name else nil).value else nil
        local tbl5 = { value }
        local var2 = join2(filter(concat(tbl4, tbl3, tbl5), Boolean.toJSBoolean), ".")

        local tbl6 = {}

        if String.includes(tbl2.kind, "Definition") and Boolean.toJSBoolean(tbl1[var2]) then
            tbl6 = Array.concat(tbl6, tbl1[var2])
        end

        return (join(
            Array.concat({}, Array.map(tbl6, printComment), { tbl2.description or "", (leave(arg1, tbl2, str1, arg2, arg3, arg4)) }),
            "\n"
        ))
    end
end

local function indent(str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    if Boolean.toJSBoolean(str1) then
        return ("  %s"):format((str1:gsub("\n", "\n  ")))
    end
    return str1
end

local function block(arg1): string -- Luacid: Inlined by compiler; 11 call sites recovered
    if arg1 and #arg1 ~= 0 then
        return (("{\n%s\n}"):format(indent((join(arg1, "\n")))))
    end

    return ""
end

local function wrap(str1: string, arg1, str2: string?): string -- Luacid: Inlined by compiler; 23 call sites recovered
    if Boolean.toJSBoolean(arg1) then
        return str1 .. tostring(arg1) .. (Boolean.toJSBoolean(str2) and str2 or "")
    end

    return ""
end

local function printBlockString(str1: string, bool1: boolean?): string
    if bool1 == nil then
        bool1 = false
    end

    local var1 = str1:gsub("\"", "\\\"\"\"")
    if (str1:sub(1, 1) == " " or str1:sub(1, 1) == "\t") and String.indexOf(str1, "\n") == -1 then
        return ("\"\"\"%s\"\"\""):format((var1:gsub("\"$", "\"\n")))
    end
    local str2 = "\"\"\"\n%s\n\"\"\""

    if not Boolean.toJSBoolean(bool1) then
        var1 = indent(var1)
    end

    return str2:format(var1)
end

local tbl2 = {
    Name = {
        leave = function(_, arg1)
            return arg1.value
        end
    },
    Variable = {
        leave = function(_, arg1): string
            return "$" .. tostring(arg1.name)
        end
    },
    Document = {
        leave = function(_, arg1)
            return (join(arg1.definitions, "\n\n"))
        end
    },
    OperationDefinition = {
        leave = function(_, arg1): string
            local str1 = wrap("(", join(arg1.variableDefinitions, ", "), ")")
            return tostring((join({ arg1.operation, join({ arg1.name, str1 }), (join(arg1.directives, " ")) }, " "))) .. " " .. tostring(arg1.selectionSet)
        end
    },
    VariableDefinition = {
        leave = function(_, arg1): string
            local variable = arg1.variable
            local type = arg1.type
            local defaultValue = arg1.defaultValue
            local directives = arg1.directives
            return tostring(variable) .. ": " .. tostring(type) .. tostring((wrap(" = ", defaultValue, nil))) .. tostring((wrap(" ", join(directives, " "), nil)))
        end
    },
    SelectionSet = {
        leave = function(_, arg1): string
            return block(arg1.selections)
        end
    },
    Field = {
        leave = function(_, arg1)
            local alias = arg1.alias
            local name = arg1.name
            local arguments = arg1.arguments
            local directives = arg1.directives
            local selectionSet = arg1.selectionSet
            local var1 = wrap("", alias, ": ") .. name
            local var2 = var1 .. wrap("(", join(arguments, ", "), ")")

            if var2.length > 80 then
                var2 = var1 .. wrap("(\n", indent((join(arguments, "\n"))), "\n)")
            end

            return (join({ var2, join(directives, " "), selectionSet }, " "))
        end
    },
    Argument = {
        leave = function(_, arg1): string
            local name = arg1.name
            local value = arg1.value
            return tostring(name) .. ": " .. tostring(value)
        end
    },
    FragmentSpread = {
        leave = function(_, arg1): string
            local name = arg1.name
            local directives = arg1.directives
            return "..." .. tostring(name) .. tostring((wrap(" ", join(directives, " "), nil)))
        end
    },
    InlineFragment = {
        leave = function(_, arg1)
            local typeCondition = arg1.typeCondition
            local directives = arg1.directives
            local selectionSet = arg1.selectionSet
            return (join({ "...", wrap("on ", typeCondition, nil), join(directives, " "), selectionSet }, " "))
        end
    },
    FragmentDefinition = {
        leave = function(_, arg1): string
            local name = arg1.name
            local typeCondition = arg1.typeCondition
            local variableDefinitions = arg1.variableDefinitions
            local directives = arg1.directives
            local selectionSet = arg1.selectionSet
            local str1 = ("fragment %s%s "):format(tostring(name), (wrap("(", join(variableDefinitions, ", "), ")")))

            local str2 = tostring(typeCondition)
            local str3 = wrap("", join(directives, " "), " ")
            return str1 .. ("on %s %s"):format(str2, tostring(str3)) .. tostring(selectionSet)
        end
    },
    IntValue = {
        leave = function(_, arg1)
            return arg1.value
        end
    },
    FloatValue = {
        leave = function(_, arg1)
            return arg1.value
        end
    },
    StringValue = {
        leave = function(_, arg1)
            local value = arg1.value
            local block2 = arg1.block
            if Boolean.toJSBoolean(block2) then
                return printBlockString(value)
            end

            return "'" .. value:gsub("'", "\\'") .. "'"
        end
    },
    BooleanValue = {
        leave = function(_, arg1): string
            local value = arg1.value
            return if Boolean.toJSBoolean(value) then "true" else "false"
        end
    },
    NullValue = {
        leave = function(): string
            return "null"
        end
    },
    EnumValue = {
        leave = function(_, arg1)
            return arg1.value
        end
    },
    ListValue = {
        leave = function(_, arg1): string
            local values = arg1.values
            return "[" .. tostring((join(values, ", "))) .. "]"
        end
    },
    ObjectValue = {
        leave = function(_, arg1): string
            local fields = arg1.fields
            return "{" .. tostring((join(fields, ", "))) .. "}"
        end
    },
    ObjectField = {
        leave = function(_, arg1): string
            local name = arg1.name
            local value = arg1.value
            return tostring(name) .. ": " .. tostring(value)
        end
    },
    Directive = {
        leave = function(_, arg1): string
            local name = arg1.name
            local arguments = arg1.arguments
            return "@" .. tostring(name) .. tostring((wrap("(", join(arguments, ", "), ")")))
        end
    },
    NamedType = {
        leave = function(_, arg1)
            return arg1.name
        end
    },
    ListType = {
        leave = function(_, arg1): string
            return "[" .. tostring(arg1.type) .. "]"
        end
    },
    NonNullType = {
        leave = function(_, arg1): string
            return tostring(arg1.type) .. "!"
        end
    },
    SchemaDefinition = {
        leave = function(_, arg1)
            local directives = arg1.directives
            local operationTypes = arg1.operationTypes
            return (join({ "schema", join(directives, " "), (block(operationTypes)) }, " "))
        end
    },
    OperationTypeDefinition = {
        leave = function(_, arg1): string
            local operation = arg1.operation
            local type = arg1.type
            return tostring(operation) .. ": " .. tostring(type)
        end
    },
    ScalarTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            return (join({ "scalar", name, (join(directives, " ")) }, " "))
        end
    },
    ObjectTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local interfaces = arg1.interfaces
            local directives = arg1.directives
            local fields = arg1.fields
            return (join({ "type", name, wrap("implements ", join(interfaces, " & "), nil), join(directives, " "), (block(fields)) }, " "))
        end
    },
    FieldDefinition = {
        leave = function(_, arg1): string
            local name = arg1.name
            local arguments = arg1.arguments
            local type = arg1.type
            local directives = arg1.directives
            return tostring(name) .. (if hasMultilineItems(arguments) then wrap("(\n", indent((join(arguments, "\n"))), "\n)") else wrap("(", join(arguments, ", "), ")")) .. ": " .. tostring(type) .. wrap(" ", join(directives, " "), nil)
        end
    },
    InputValueDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local type = arg1.type
            local defaultValue = arg1.defaultValue
            local directives = arg1.directives
            return (join({ tostring(name) .. ": " .. tostring(type), wrap("= ", defaultValue, nil), (join(directives, " ")) }, " "))
        end
    },
    InterfaceTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local interfaces = arg1.interfaces
            local directives = arg1.directives
            local fields = arg1.fields
            return (join(
                {
                    "interface",
                    name,
                    wrap("implements ", join(interfaces, " & "), nil),
                    join(directives, " "),
                    (block(fields))
                },
                " "
            ))
        end
    },
    UnionTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local types = arg1.types
            return (join({ "union", name, join(directives, " "), (wrap("= ", join(types, " | "), nil)) }, " "))
        end
    },
    EnumTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local values = arg1.values
            return (join({ "enum", name, join(directives, " "), (block(values)) }, " "))
        end
    },
    EnumValueDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            return (join({ name, (join(directives, " ")) }, " "))
        end
    },
    InputObjectTypeDefinition = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local fields = arg1.fields
            return (join({ "input", name, join(directives, " "), (block(fields)) }, " "))
        end
    },
    DirectiveDefinition = {
        leave = function(_, arg1): string
            local name = arg1.name
            local arguments = arg1.arguments
            local repeatable = arg1.repeatable
            local locations = arg1.locations
            return "directive @"
                .. tostring(name)
                    .. tostring(
                        if Boolean.toJSBoolean((hasMultilineItems(arguments))) then wrap("(\n", indent((join(arguments, "\n"))), "\n)") else wrap("(", join(arguments, ", "), ")")
                    )
                        .. (if Boolean.toJSBoolean(repeatable) then " repeatable" else "") .. " on " .. tostring((join(locations, " | ")))
        end
    },
    SchemaExtension = {
        leave = function(_, arg1)
            local directives = arg1.directives
            local operationTypes = arg1.operationTypes
            return (join({ "extend schema", join(directives, " "), (block(operationTypes)) }, " "))
        end
    },
    ScalarTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            return (join({ "extend scalar", name, (join(directives, " ")) }, " "))
        end
    },
    ObjectTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local interfaces = arg1.interfaces
            local directives = arg1.directives
            local fields = arg1.fields
            return (join(
                {
                    "extend type",
                    name,
                    wrap("implements ", join(interfaces, " & "), nil),
                    join(directives, " "),
                    (block(fields))
                },
                " "
            ))
        end
    },
    InterfaceTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local interfaces = arg1.interfaces
            local directives = arg1.directives
            local fields = arg1.fields
            return (join(
                {
                    "extend interface",
                    name,
                    wrap("implements ", join(interfaces, " & "), nil),
                    join(directives, " "),
                    (block(fields))
                },
                " "
            ))
        end
    },
    UnionTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local types = arg1.types
            return (join({ "extend union", name, join(directives, " "), (wrap("= ", join(types, " | "), nil)) }, " "))
        end
    },
    EnumTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local values = arg1.values
            return (join({ "extend enum", name, join(directives, " "), (block(values)) }, " "))
        end
    },
    InputObjectTypeExtension = {
        leave = function(_, arg1)
            local name = arg1.name
            local directives = arg1.directives
            local fields = arg1.fields
            return (join({ "extend input", name, join(directives, " "), (block(fields)) }, " "))
        end
    }
}

local var1 = Array.reduce(Object.keys(tbl2), function(arg1, arg2)
    return (Object.assign({}, arg1, { [arg2] = { leave = addDescription(tbl2[arg2].leave) } }))
end, {})

function module.printWithComments(arg1)
    return (visit(arg1, var1))
end

isFieldDefinitionNode = function(arg1): boolean
    return arg1.kind == "FieldDefinition"
end

function module.getDescription(tbl3, tbl4)
    if tbl3.description ~= nil then
        return tbl3.description.value
    end
    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(if typeof(tbl4) == "table" then tbl4.commentDescriptions else nil) then
        return getComment(tbl3)
    end

    return nil
end

getComment = function(tbl3)
    local leadingCommentBlock = getLeadingCommentBlock(tbl3)
    if leadingCommentBlock ~= nil then
        return dedentBlockStringValue(("\n%s"):format(tostring(leadingCommentBlock)))
    end

    return nil
end

module.getComment = getComment

getLeadingCommentBlock = function(tbl3)
    local loc = tbl3.loc
    if not Boolean.toJSBoolean(loc) then
        return
    end

    local prev = loc.startToken.prev
    local tbl4 = {}

    while prev ~= nil
        and prev.kind == TokenKind.COMMENT
        and prev.next ~= nil
        and prev.prev ~= nil
        and prev.line + 1 == prev.next.line
        and prev.line ~= prev.prev.line do
        table.insert(tbl4, tostring(prev.value))
        prev = prev.prev
    end

    if #tbl4 > 0 then
        return (Array.join(Array.reverse(tbl4), "\n"))
    end

    return nil
end

module.getLeadingCommentBlock = getLeadingCommentBlock

dedentBlockStringValue = function(str1: string)
    local var2 = String.split(str1, { "\r\n", "\n", "\r" })

    local blockStringIndentation = getBlockStringIndentation(var2)
    if blockStringIndentation ~= 0 then
        local num1 = 2

        while num1 <= #var2 do
            var2[num1] = String.slice(var2[num1], blockStringIndentation + 1)

            num1 += 1
        end
    end

    while #var2 > 0 and isBlank(var2[1]) do
        table.remove(var2, 1)
    end

    while #var2 > 0 and isBlank(var2[#var2]) do
        table.remove(var2)
    end
    return Array.join(var2, "\n")
end
module.dedentBlockStringValue = dedentBlockStringValue

getBlockStringIndentation = function(arg1)
    local num1 = 2
    local var2 = nil
    local var3

    while num1 <= #arg1 do
        local var4 = arg1[num1]

        var3 = leadingWhitespace(var4)

        if var3 == #var4 then
            num1 += 1
        else
            if var2 == nil or var3 < var2 then
                if var3 == 0 then
                    return if var3 == nil then 0 else var3
                end
            else
                var3 = var2
            end

            num1 += 1
            var2 = var3
        end
    end

    var3 = var2
    return if var3 == nil then 0 else var3
end
module.getBlockStringIndentation = getBlockStringIndentation

leadingWhitespace = function(str1: string): number
    local num1 = 0

    while num1 < #str1 and (str1:sub(num1 + 1, num1 + 1) == " " or str1:sub(num1 + 1, num1 + 1) == "\t") do
        num1 += 1
    end
    return num1
end

isBlank = function(str1: string): boolean
    return leadingWhitespace(str1) == #str1
end

return module
