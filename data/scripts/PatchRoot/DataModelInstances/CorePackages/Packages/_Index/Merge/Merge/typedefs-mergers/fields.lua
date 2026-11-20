-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error

local module = {}

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local _GraphQL = require(scriptParentParentParent.GraphQL)

local utils = require(script.Parent.utils)

local extractType = utils.extractType
local isWrappingTypeNode = utils.isWrappingTypeNode
local isListTypeNode = utils.isListTypeNode
local isNonNullTypeNode = utils.isNonNullTypeNode
local printTypeNode = utils.printTypeNode

local mergeDirectives = require(script.Parent.directives).mergeDirectives
local compareNodes = require(scriptParentParentParent.Utils).compareNodes
local mergeArguments = require(script.Parent.arguments).mergeArguments

local preventConflicts = nil
local safeChangeForFieldType = nil

local function fieldAlreadyExists(arg1, arg2, arg3): boolean
    local var1 = Array.find(arg1, function(arg4): boolean
        return arg4.name.value == arg2.name.value
    end)

    if var1 and not (arg3 and Boolean.toJSBoolean(arg3.ignoreFieldConflicts)) then
        local var2 = extractType(var1.type)
        local var3 = extractType(arg2.type)
        if var2.name.value ~= var3.name.value then
            local error = error
            local new = Error.new

            local str1 = tostring(arg2.name.value)
            local str2 = tostring(var2.name.value)
            local value = var3.name.value
            error(
                new(
                    ("Field \"%s\" already defined with a different type. Declared as \"%s\", but you tried to override with \"%s\""):format(
                        str1,
                        str2,
                        tostring(value)
                    )
                )
            )
        end
    end
    return not not Boolean.toJSBoolean(var1)
end

function module.mergeFields(tbl1, arg1, arg2, arg3)
    local tbl2 = {}
    if arg2 ~= nil then
        tbl2 = Array.concat(tbl2, arg2)
    end

    if arg1 ~= nil then
        for _, value in arg1 do
            if Boolean.toJSBoolean((fieldAlreadyExists(tbl2, value, arg3))) then
                local var1 = Array.find(tbl2, function(arg4): boolean
                    return arg4.name.value == value.name.value
                end)

                if not (arg3 and Boolean.toJSBoolean(arg3.ignoreFieldConflicts)) then
                    if arg3 and Boolean.toJSBoolean(arg3.throwOnConflict) then
                        preventConflicts(tbl1, var1, value, false)
                    else
                        preventConflicts(tbl1, var1, value, true)
                    end

                    local toJsBoolean = Boolean.toJSBoolean
                    local bool1 = isNonNullTypeNode(value.type)
                    if Boolean.toJSBoolean(bool1) then
                        bool1 = not Boolean.toJSBoolean(isNonNullTypeNode(var1.type))
                    end

                    if toJsBoolean(bool1) then
                        var1.type = value.type
                    end
                end
                var1.arguments = mergeArguments(
                    not Boolean.toJSBoolean(value.arguments) and {} or value.arguments,
                    not Boolean.toJSBoolean(var1.arguments) and {} or var1.arguments,
                    arg3
                )

                var1.directives = mergeDirectives(value.directives, var1.directives, arg3)

                var1.description = if Boolean.toJSBoolean(value.description) then value.description else var1.description
            else
                table.insert(tbl2, value)
            end
        end
    end

    if arg3 and Boolean.toJSBoolean(arg3.sort) then
        Array.sort(tbl2, compareNodes)
    end

    if not (arg3 and arg3.exclusions) then
        return tbl2
    end

    local exclusions = arg3.exclusions
    return Array.filter(tbl2, function(arg4): boolean
        local toJsBoolean = Boolean.toJSBoolean
        local includes = Array.includes
        local var1 = exclusions
        local str1 = tostring(tbl1.name.value)
        local value = arg4.name.value
        return not toJsBoolean(includes(var1, ("%s.%s"):format(str1, tostring(value))))
    end)
end

preventConflicts = function(tbl1, arg1, arg2, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    local var1 = printTypeNode(arg1.type)
    local var2 = printTypeNode(arg2.type)

    if var1 == var2 or Boolean.toJSBoolean(safeChangeForFieldType(arg1.type, arg2.type, bool1)) then
        return
    end

    local error = error
    local new = Error.new

    local str1 = tostring(tbl1.name.value)
    local value = arg1.name.value
    error(
        new(("Field '%s.%s' changed type from '%s' to '%s'"):format(str1, tostring(value), tostring(var1), tostring(var2)))
    )
end

safeChangeForFieldType = function(arg1, arg2, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    if not (Boolean.toJSBoolean(isWrappingTypeNode(arg1)) or Boolean.toJSBoolean(isWrappingTypeNode(arg2))) then
        return typeof(arg1) == "table" and #arg1 == 0 and typeof(arg2) == "table" and #arg2 == 0 or tostring(arg1) == tostring(arg2)
    elseif Boolean.toJSBoolean(isNonNullTypeNode(arg2)) then
        if Boolean.toJSBoolean(isNonNullTypeNode(arg1)) then
            arg1 = arg1.type
        end

        return safeChangeForFieldType(arg1, arg2.type)
    elseif Boolean.toJSBoolean(isNonNullTypeNode(arg1)) then
        return safeChangeForFieldType(arg2, arg1, bool1)
    else
        return if Boolean.toJSBoolean(isListTypeNode(arg1)) then isListTypeNode(arg2) and safeChangeForFieldType(arg1.type, arg2.type)
            or isNonNullTypeNode(arg2) and safeChangeForFieldType(arg1, arg2.type) else false
    end
end

return module
