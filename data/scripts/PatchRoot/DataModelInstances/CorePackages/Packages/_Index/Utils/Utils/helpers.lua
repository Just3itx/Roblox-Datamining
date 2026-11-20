-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object

local module = {}

local parse = require(scriptParentParent.GraphQL).parse

local LuauRegExp = require(scriptParentParent.LuauRegExp)

function module.asArray(arg1)
    return if Boolean.toJSBoolean(Array.isArray(arg1)) then arg1 elseif Boolean.toJSBoolean(arg1) then { arg1 } else {}
end

local var1 = LuauRegExp("\\.[a-zA-Z0-9]+$")

function module.isDocumentString(arg1)
    if typeof(arg1) ~= "string" then
        return false
    end

    if Boolean.toJSBoolean(var1:test(arg1)) then
        return false
    end

    local success, result = pcall(function(): boolean
        parse(arg1)
        return true
    end)
    return if success then result else false
end

local var2 = LuauRegExp("[‘“!%^<=>`]")

function module.isValidPath(arg1): boolean
    return typeof(arg1) == "string" and not Boolean.toJSBoolean(var2:test(arg1))
end

local function compareStrings(arg1, arg2): number -- Luacid: Inlined by compiler; 1 call site recovered
    if tostring(arg1) < tostring(arg2) then
        return -1
    end

    if tostring(arg1) > tostring(arg2) then
        return 1
    end

    return 0
end

module.compareStrings = compareStrings

local function nodeToString(arg1)
    local value = if Array.indexOf(Object.keys(arg1), "alias") == -1 or typeof(arg1.alias) ~= "table" then nil else arg1.alias.value

    if value == nil and Array.indexOf(Object.keys(arg1), "name") ~= -1 then
        if typeof(arg1.name) == "table" then
            value = arg1.name.value
        else
            value = nil
        end
    end
    if value == nil then
        value = arg1.kind
    end
    return value
end
module.nodeToString = nodeToString
function module.compareNodes(arg1, arg2, func1: ((...any) -> (...any))?)
    local var3 = nodeToString(arg1)
    local var4 = nodeToString(arg2)
    if typeof(func1) == "function" then
        return func1(var3, var4)
    end

    return compareStrings(var3, var4)
end

function module.isSome(none): boolean
    return not (none == nil) and none ~= Object.None
end

function module.assertSome(arg1, str1: string?): boolean
    local var3 = if str1 == nil then "Value should be something" else str1
    if arg1 == nil then
        error(Error.new(var3))
    end

    return true
end

return module
