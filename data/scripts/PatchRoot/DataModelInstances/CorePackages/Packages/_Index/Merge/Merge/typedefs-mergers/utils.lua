-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local instanceof = LuauPolyfill.instanceof
local module = {}
local GraphQL = require(scriptParentParentParent.GraphQL)

local Source = GraphQL.Source
local Kind = GraphQL.Kind
function module.isStringTypes(arg1): boolean
    return typeof(arg1) == "string"
end

function module.isSourceTypes(arg1)
    return instanceof(arg1, Source)
end

function module.extractType(arg1)
    while arg1.kind == Kind.LIST_TYPE or arg1.kind == "NonNullType" do
        arg1 = arg1.type
    end

    return arg1
end

function module.isWrappingTypeNode(arg1): boolean
    return arg1.kind ~= Kind.NAMED_TYPE
end

local function isListTypeNode(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == Kind.LIST_TYPE
end
module.isListTypeNode = isListTypeNode
local function isNonNullTypeNode(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == Kind.NON_NULL_TYPE
end
module.isNonNullTypeNode = isNonNullTypeNode
local function printTypeNode(arg1)
    if Boolean.toJSBoolean(not not isListTypeNode(arg1)) then
        return ("[%s]"):format(printTypeNode(arg1.type))
    elseif Boolean.toJSBoolean(not not isNonNullTypeNode(arg1)) then
        return ("%s!"):format(printTypeNode(arg1.type))
    end

    return arg1.name.value
end

module.printTypeNode = printTypeNode
local CompareVal = { A_SMALLER_THAN_B = -1, A_EQUALS_B = 0, A_GREATER_THAN_B = 1 }

module.CompareVal = CompareVal

function module.defaultStringComparator(str1: string?, str2: string?)
    if str1 == nil and str2 == nil then
        return CompareVal.A_EQUALS_B
    end

    if str1 == nil then
        return CompareVal.A_SMALLER_THAN_B
    end

    if str2 == nil then
        return CompareVal.A_GREATER_THAN_B
    end

    if str1 < str2 then
        return CompareVal.A_SMALLER_THAN_B
    end

    if str2 < str1 then
        return CompareVal.A_GREATER_THAN_B
    end

    return CompareVal.A_EQUALS_B
end

return module
