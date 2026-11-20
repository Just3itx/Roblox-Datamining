-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local tbl1 = {}

local Kind = require(scriptParentParent.GraphQL).Kind

local Error = LuauPolyfill.Error
local Number = LuauPolyfill.Number
local Object = LuauPolyfill.Object

local LuauRegExp = require(scriptParentParent.LuauRegExp)

local var1 = nil

local function isFinite(none) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): boolean
        local var2 = tonumber(none)

        return not Number.isNaN(var2) and var2 ~= math.huge and var2 ~= -math.huge or false
    end)
    return if success then result else false
end

local function astFromValueUntyped(value)
    if value == Object.None then
        return {
            kind = Kind.NULL
        }
    end

    if value == nil then
        return nil
    end

    if Boolean.toJSBoolean(Array.isArray(value)) then
        local values = {}
        for _, value in value do
            local var2 = astFromValueUntyped(value)
            if var2 ~= nil then
                table.insert(values, var2)
            end
        end
        return {
            kind = Kind.LIST,
            values = values
        }
    end

    if typeof(value) == "table" then
        local fields = {}
        for value2 in value do
            local var2 = value[tostring(value2)]
            local var3 = astFromValueUntyped(var2)
            if not Boolean.toJSBoolean(var3) then
                continue
            end

            table.insert(fields, { kind = Kind.OBJECT_FIELD, name = { kind = Kind.NAME, value = value2 }, value = var3 })
        end

        return {
            kind = Kind.OBJECT,
            fields = fields
        }
    end

    if typeof(value) == "boolean" then
        return {
            kind = Kind.BOOLEAN,
            value = value
        }
    end

    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(typeof(value) == "number" and isFinite(value)) then
        local str1 = tostring(value)

        return if Boolean.toJSBoolean(var1:test(str1)) then {
            kind = Kind.INT,
            value = str1
        } else {
            kind = Kind.FLOAT,
            value = str1
        }
    end

    if typeof(value) == "string" then
        return {
            kind = Kind.STRING,
            value = value
        }
    end

    error(Error.new(("Cannot convert value to AST: %s."):format(tostring(value))))
end
tbl1.astFromValueUntyped = astFromValueUntyped

var1 = LuauRegExp("^-?(?:0|[1-9][0-9]*)$")

return tbl1
