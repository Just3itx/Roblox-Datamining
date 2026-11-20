-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local module = {}
local Kind = require(scriptParentParentParent.GraphQL).Kind

local mergeDirectives = require(script.Parent.directives).mergeDirectives

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

function module.mergeScalar(arg1, arg2, arg3)
    if arg2 then
        return {
            name = arg1.name,
            description = if Boolean.toJSBoolean(arg1.description) then arg1.description else arg2.description,
            kind = if arg3 and Boolean.toJSBoolean(arg3.convertExtensions)
                or arg1.kind == "ScalarTypeDefinition"
                or arg2.kind == "ScalarTypeDefinition" then "ScalarTypeDefinition" else "ScalarTypeExtension",
            loc = arg1.loc,
            directives = mergeDirectives(arg1.directives, arg2.directives, arg3)
        }
    elseif arg3 and Boolean.toJSBoolean(arg3.convertExtensions) then
        return (Object.assign({}, arg1, { kind = Kind.SCALAR_TYPE_DEFINITION }))
    end

    return arg1
end

return module
