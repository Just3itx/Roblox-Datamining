-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local jsutils = scriptParentParent.jsutils
local language = scriptParentParent.language

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local coerceToTable = LuauPolyfill.coerceToTable

local null = require(scriptParentParent.luaUtils.null)

local _ObjMap = require(jsutils.ObjMap)

local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant
local keyValMap = require(jsutils.keyValMap).keyValMap

local Kind = require(language.kinds).Kind
local _ast = require(language.ast)

local function valueFromASTUntyped(arg1, arg2)
    if arg1.kind == Kind.NULL then
        return null
    end

    if arg1.kind == Kind.INT then
        return tonumber(arg1.value, 10)
    end

    if arg1.kind == Kind.FLOAT then
        return tonumber(arg1.value)
    end
    if arg1.kind == Kind.STRING or arg1.kind == Kind.ENUM or arg1.kind == Kind.BOOLEAN then
        return arg1.value
    end

    if arg1.kind == Kind.LIST then
        return Array.map(arg1.values, function(arg3)
            return valueFromASTUntyped(arg3, arg2)
        end)
    end

    if arg1.kind == Kind.OBJECT then
        return coerceToTable(keyValMap(arg1.fields, function(arg3)
            return arg3.name.value
        end, function(arg3)
            return valueFromASTUntyped(arg3.value, arg2)
        end))
    end

    if arg1.kind == Kind.VARIABLE then
        return arg2 and arg2[arg1.name.value]
    end

    invariant(false, "Unexpected value node: " .. inspect(arg1))

    error("Unexpected value node: " .. inspect(arg1))
end

return { valueFromASTUntyped = valueFromASTUntyped }
