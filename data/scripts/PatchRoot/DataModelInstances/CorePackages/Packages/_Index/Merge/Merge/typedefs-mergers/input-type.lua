-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object
local module = {}

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local Kind = require(scriptParentParentParent.GraphQL).Kind

local mergeFields = require(script.Parent.fields).mergeFields
local mergeDirectives = require(script.Parent.directives).mergeDirectives

function module.mergeInputType(arg1, arg2, arg3)
    if Boolean.toJSBoolean(arg2) then
        local success, result = pcall(function()
            return {
                name = arg1.name,
                description = if Boolean.toJSBoolean(arg1.description) then arg1.description else arg2.description,
                kind = if Boolean.toJSBoolean(arg3 and arg3.convertExtensions)
                    or arg1.kind == "InputObjectTypeDefinition"
                    or arg2.kind == "InputObjectTypeDefinition" then "InputObjectTypeDefinition" else "InputObjectTypeExtension",
                loc = arg1.loc,
                fields = mergeFields(arg1, arg1.fields, arg2.fields, arg3),
                directives = mergeDirectives(arg1.directives, arg2.directives, arg3)
            }
        end)

        if not success then
            local error = error
            local new = Error.new

            local str1 = tostring(arg1.name.value)
            local message = result.message
            error(new(("Unable to merge GraphQL input type \"%s\": %s"):format(str1, tostring(message))))
        end

        return result
    elseif arg3 and Boolean.toJSBoolean(arg3.convertExtensions) then
        return (Object.assign({}, arg1, { kind = Kind.INPUT_OBJECT_TYPE_DEFINITION }))
    else
        return arg1
    end
end

return module
