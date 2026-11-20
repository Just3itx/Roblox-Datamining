-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:01Z
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

local Kind = GraphQL.Kind

local valueFromASTUntyped = GraphQL.valueFromASTUntyped

local function isTypeWithFields(arg1): boolean
    return arg1.kind == Kind.OBJECT_TYPE_DEFINITION or arg1.kind == Kind.OBJECT_TYPE_EXTENSION
end

function module.getArgumentsWithDirectives(arg1)
    local argumentsWithDirectives = {}

    for _, value in (Array.filter(arg1.definitions, isTypeWithFields)) do
        if value.fields == nil then
            continue
        end

        for _, field in value.fields do
            local arguments = if typeof(field.arguments) == "table" then field.arguments else nil

            local var1 = if arguments == nil then nil else Array.filter(arguments, function(arg2)
                return Boolean.toJSBoolean(typeof(arg2.directives) == "table" and #arg2.directives or nil)
            end)

            if not Boolean.toJSBoolean(typeof(var1) == "table" and #var1 or nil) then
                continue
            end

            local str1 = tostring(value.name.value)
            local str2 = tostring(field.name.value)
            argumentsWithDirectives[tostring(("%s.%s"):format(str1, str2))] = {}

            local str3 = tostring(value.name.value)
            local str4 = tostring(field.name.value)
            local var2 = argumentsWithDirectives[tostring(("%s.%s"):format(str3, str4))]

            for _, value2 in var1 do
                local var3 = Array.map(value2.directives, function(arg2)
                    return {
                        name = arg2.name.value,
                        args = Array.reduce(Boolean.toJSBoolean(arg2.arguments) and arg2.arguments or {}, function(arg3, arg4)
                            return Object.assign({}, arg3, { [arg4.name.value] = valueFromASTUntyped(arg4.value, {}) })
                        end, {})
                    }
                end)

                local value3 = value2.name.value
                var2[tostring(value3)] = var3
            end
        end
    end
    return argumentsWithDirectives
end

return module
