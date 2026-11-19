-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local HttpService = game:GetService("HttpService")

local module = {}

local var1 = nil
local var2 = nil
local isField = nil

local _types = require(script.Parent.types)
local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local InvariantError = require(scriptParentParentParent.jsutils.invariant).InvariantError
local isNonNullObject = require(script.Parent.Parent.common.objects).isNonNullObject
local fragments = require(script.Parent.fragments)
local objectKeysForEach = require(scriptParentParentParent.luaUtils.objectKeysForEach)

local getFragmentFromSelection = fragments.getFragmentFromSelection

function module.makeReference(str1: string)
    return {
        __ref = tostring(str1)
    }
end

function module.isReference(arg1): boolean
    return type(arg1) == "table" and type(arg1.__ref) == "string"
end

function module.isDocumentNode(arg1)
    local var3 = isNonNullObject(arg1)
    return var3 and arg1.kind == "Document" and Array.isArray(arg1.definitions)
end

local function isStringValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "StringValue"
end

local function isBooleanValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "BooleanValue"
end

local function isIntValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "IntValue"
end

local function isFloatValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "FloatValue"
end

local function isVariable(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "Variable"
end

local function isObjectValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "ObjectValue"
end

local function isListValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "ListValue"
end

local function isEnumValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "EnumValue"
end

local function isNullValue(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "NullValue"
end

local function valueToObjectRepresentation(arg1, arg2, arg3, arg4)
    if isIntValue(arg3) or isFloatValue(arg3) then
        local value = arg2.value
        arg1[value] = tonumber(arg3.value)
        return
    end

    if isBooleanValue(arg3) or isStringValue(arg3) then
        arg1[arg2.value] = arg3.value
        return
    end

    if isObjectValue(arg3) then
        local tbl1 = {}
        Array.map(arg3.fields, function(arg5)
            valueToObjectRepresentation(tbl1, arg5.name, arg5.value, arg4)
            return nil
        end)
        arg1[arg2.value] = tbl1
        return
    end

    if isVariable(arg3) then
        local var3 = (arg4 or {})[arg3.name.value]

        arg1[arg2.value] = var3
        return
    end

    if isListValue(arg3) then
        arg1[arg2.value] = Array.map(arg3.values, function(arg5)
            local tbl1 = {}
            valueToObjectRepresentation(tbl1, arg2, arg5, arg4)
            return tbl1[arg2.value]
        end)

        return
    end

    if isEnumValue(arg3) then
        arg1[arg2.value] = arg3.value
        return
    end

    if isNullValue(arg3) then
        arg1[arg2.value] = nil
        return
    end
    local error = error
    local new = InvariantError.new
    local value = arg2.value
    local kind = arg3.kind
    error(
        new(
            tostring(("The inline argument \"%s\" of kind \"%s\""):format(value, kind)) .. "is not supported. Use variables instead of inline arguments to overcome this limitation."
        )
    )
end

module.valueToObjectRepresentation = valueToObjectRepresentation

function module.storeKeyNameFromField(arg1, arg2)
    local var3 = nil
    if arg1.directives then
        var3 = {}
        Array.forEach(arg1.directives, function(arg3)
            var3[arg3.name.value] = {}

            if not arg3.arguments then
                return
            end

            Array.forEach(arg3.arguments, function(arg4)
                local name = arg4.name
                local value = arg4.value
                valueToObjectRepresentation(var3[arg3.name.value], name, value, arg2)
            end)
        end)
    end

    local var4 = nil
    if arg1.arguments and #arg1.arguments > 0 then
        var4 = {}
        Array.forEach(arg1.arguments, function(arg3)
            local name = arg3.name
            local value = arg3.value
            valueToObjectRepresentation(var4, name, value, arg2)
        end)
    end

    return var1(arg1.name.value, var4, var3)
end

local tbl1 = {
    "connection",
    "include",
    "skip",
    "client",
    "rest",
    "export"
}

var1 = Object.assign(setmetatable({}, {
    __call = function(_, str1: string, tbl2, arg1)
        if tbl2 and arg1 and arg1.connection and arg1.connection.key then
            if not (arg1.connection.filter and #arg1.connection.filter > 0) then
                return arg1.connection.key
            end

            local var3 = not arg1.connection.filter and {} or arg1.connection.filter

            Array.sort(var3, nil)

            local tbl3 = ({})
            Array.forEach(var3, function(arg2)
                tbl3[arg2] = tbl2[arg2]
            end)

            return ("%s(%s)"):format(arg1.connection.key, var2(tbl3))
        end

        local str2 = str1

        if tbl2 then
            local var3 = var2(tbl2)
            str2 ..= ("(%s)"):format(var3)
        end

        if arg1 then
            objectKeysForEach(arg1, function(arg2)
                if Array.indexOf(tbl1, arg2) ~= -1 then
                    return
                end

                if arg1[arg2] and next(arg1[arg2]) ~= nil then
                    str2 ..= ("@%s(%s)"):format(arg2, var2(arg1[arg2]))
                else
                    str2 ..= ("@%s"):format(arg2)
                end
            end)
        end

        return str2
    end
}), {
    setStringify = function<T>(_, arg1: T): T
        local var3 = var2
        var2 = arg1
        return var3
    end
})

module.getStoreKeyName = var1

var2 = function(input) -- name: stringify
    if not isNonNullObject(input) then
        return HttpService:JSONEncode(input)
    end
    local var3 = Array.map(Array.sort(Object.keys(input), nil), function<T>(arg1: T): {T}
        return { arg1, var2(input[arg1]) }
    end)

    if Array.isArray(input) then
        return ("[%s]"):format(Array.join(Array.map(var3, function<T>(tbl2: {T}): T
            return tbl2[2]
        end), ","))
    end

    return ("{%s}"):format(Array.join(Array.map(var3, function(arg1): string
        return ("\"%s\":%s"):format(arg1[1], arg1[2])
    end), ","))
end

function module.argumentsObjectFromField(arg1, tbl2)
    if not (arg1.arguments and #arg1.arguments > 0) then
        return nil
    end

    local result = {}
    Array.forEach(arg1.arguments, function(arg2)
        local name = arg2.name
        local value = arg2.value
        valueToObjectRepresentation(result, name, value, tbl2)
    end)
    return result
end

local function resultKeyNameFromField(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.alias then arg1.alias.value else arg1.name.value
end

module.resultKeyNameFromField = resultKeyNameFromField

local function getTypenameFromResult(tbl2, arg1, arg2)
    if typeof(tbl2.__typename) == "string" then
        return tbl2.__typename
    end

    for _, selection in ipairs(arg1.selections) do
        if isField(selection) then
            if selection.name.value == "__typename" then
                return tbl2[resultKeyNameFromField(selection)]
            end
        else
            local typenameFromResult = getTypenameFromResult(tbl2, getFragmentFromSelection(selection, arg2).selectionSet, arg2)

            if typeof(typenameFromResult) == "string" then
                return typenameFromResult
            end
        end
    end
    return nil
end
module.getTypenameFromResult = getTypenameFromResult

isField = function(arg1): boolean
    return arg1.kind == "Field"
end
module.isField = isField

function module.isInlineFragment(arg1): boolean
    return arg1.kind == "InlineFragment"
end

return module
