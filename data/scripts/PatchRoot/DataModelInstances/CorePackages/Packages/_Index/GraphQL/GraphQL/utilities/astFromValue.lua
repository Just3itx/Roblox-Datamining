-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local luaUtils = scriptParentParent.luaUtils
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Error = LuauPolyfill.Error
local Number = LuauPolyfill.Number
local RegExp = require(scriptParentParentParent.RegExp)

local inspect = require(scriptParentParent.jsutils.inspect).inspect
local invariant = require(scriptParentParent.jsutils.invariant).invariant
local isObjectLike = require(scriptParentParent.jsutils.isObjectLike).isObjectLike
local isIteratableObject = require(scriptParentParent.jsutils.isIteratableObject).isIteratableObject

local _ast = require(scriptParentParent.language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind

local GraphQLID = require(scriptParentParent.type.scalars).GraphQLID
local definition = require(scriptParentParent.type.definition)
local isLeafType = definition.isLeafType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType

local null = require(luaUtils.null)
local isNillish = require(luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish

local var1 = nil

local function astFromValue(arg1, arg2)
    if isNonNullType(arg2) then
        local var2 = astFromValue(arg1, arg2.ofType)

        return if (not (var2 == nil or var2 == null) and var2.kind) == Kind.NULL then null else var2
    end

    if arg1 == null then
        return {
            kind = Kind.NULL
        }
    end

    if arg1 == nil then
        return null
    end

    if isListType(arg2) then
        local ofType = arg2.ofType

        if not isIteratableObject(arg1) then
            return astFromValue(arg1, ofType)
        end

        local values = {}

        for _, value in pairs(arg1) do
            local var2 = astFromValue(value, ofType)

            if isNotNillish(var2) then
                table.insert(values, var2)
            end
        end

        return {
            kind = Kind.LIST,
            values = values
        }
    end

    if isInputObjectType(arg2) then
        if not isObjectLike(arg1) then
            return null
        end

        local fields = {}

        for _, value in ipairs(arg2:getFields():values()) do
            local var2 = astFromValue(arg1[value.name], value.type)

            if not isNotNillish(var2) then
                continue
            end
            table.insert(fields, { kind = Kind.OBJECT_FIELD, name = { kind = Kind.NAME, value = value.name }, value = var2 })
        end

        return {
            kind = Kind.OBJECT,
            fields = fields
        }
    end

    if isLeafType(arg2) then
        local value = arg2:serialize(arg1)
        if isNillish2(value) then
            return null
        end

        if typeof(value) == "boolean" then
            return {
                kind = Kind.BOOLEAN,
                value = value
            }
        end

        if typeof(value) == "number" and Number.isFinite(value) then
            local str1 = tostring(value)

            return if var1:test(str1) then {
                kind = Kind.INT,
                value = str1
            } else {
                kind = Kind.FLOAT,
                value = str1
            }
        end
        if typeof(value) == "string" then
            if isEnumType(arg2) then
                return {
                    kind = Kind.ENUM,
                    value = value
                }
            end

            if arg2 == GraphQLID and var1:test(value) then
                return {
                    kind = Kind.INT,
                    value = value
                }
            end

            return {
                kind = Kind.STRING,
                value = value
            }
        end

        error(Error.new(("Cannot convert value to AST: %s."):format(inspect(value))))
    end

    invariant(false, "Unexpected input type: " .. inspect(arg2))
end

var1 = RegExp("^-?(?:0|[1-9][0-9]*)$")

return { astFromValue = astFromValue, NULL = null }
