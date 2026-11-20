-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local valueFromASTUntyped = require(scriptParentParent.GraphQL).valueFromASTUntyped

local _types = require(script.Parent.types)

function module.getFieldsWithDirectives(arg1, tbl1)
    local fieldsWithDirectives = {}
    local tbl2 = { "ObjectTypeDefinition", "ObjectTypeExtension" }

    if Boolean.toJSBoolean((tbl1 == nil and {} or tbl1).includeInputTypes) then
        tbl2 = Array.concat({}, tbl2, { "InputObjectTypeDefinition", "InputObjectTypeExtension" })
    end

    for _, value in (Array.filter(arg1.definitions, function(arg2)
        return Array.includes(tbl2, arg2.kind)
    end)) do
        local value2 = value.name.value

        if value.fields == nil then
            continue
        end

        for _, field in value.fields do
            if not (Boolean.toJSBoolean(field.directives) and #field.directives > 0) then
                continue
            end
            local value3 = field.name.value
            local str1 = ("%s.%s"):format(tostring(value2), tostring(value3))
            local var1 = Array.map(field.directives, function(arg2)
                return {
                    name = arg2.name.value,
                    args = Array.reduce(Boolean.toJSBoolean(arg2.arguments) and arg2.arguments or {}, function(tbl3, arg3)
                        return Object.assign({}, tbl3, { [arg3.name.value] = valueFromASTUntyped(arg3.value, nil) })
                    end, {})
                }
            end)

            fieldsWithDirectives[tostring(str1)] = var1
        end
    end

    return fieldsWithDirectives
end

return module
