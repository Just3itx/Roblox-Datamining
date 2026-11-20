-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}

local Kind = require(scriptParentParentParent.GraphQL).Kind

local mergeDirectives = require(script.Parent.directives).mergeDirectives

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local DEFAULT_OPERATION_TYPE_NAME_MAP = {
    query = "Query",
    mutation = "Mutation",
    subscription = "Subscription"
}
module.DEFAULT_OPERATION_TYPE_NAME_MAP = DEFAULT_OPERATION_TYPE_NAME_MAP
local function mergeOperationTypes(operationTypes, operationTypes2)
    local var1 = operationTypes == nil and {} or operationTypes
    local var2 = operationTypes2 == nil and {} or operationTypes2

    local result = {}

    for _, value in DEFAULT_OPERATION_TYPE_NAME_MAP do
        local var3 = Array.find(var1, function(arg1): boolean
            return arg1.operation == value
        end)
        local var4 = Boolean.toJSBoolean(var3) and var3 or Array.find(var2, function(arg1): boolean
            return arg1.operation == value
        end)

        if var4 then
            table.insert(result, var4)
        end
    end
    return result
end

function module.mergeSchemaDefs(arg1, arg2, arg3)
    if Boolean.toJSBoolean(arg2) then
        return {
            kind = if arg1.kind == Kind.SCHEMA_DEFINITION or arg2.kind == Kind.SCHEMA_DEFINITION then Kind.SCHEMA_DEFINITION else Kind.SCHEMA_EXTENSION,
            description = Boolean.toJSBoolean(arg1.description) and arg1.description or arg2.description,
            directives = mergeDirectives(arg1.directives, arg2.directives, arg3),
            operationTypes = mergeOperationTypes(arg1.operationTypes, arg2.operationTypes)
        }
    elseif arg3 and Boolean.toJSBoolean(arg3.convertExtensions) then
        return (Object.assign({}, arg1, { kind = Kind.SCHEMA_DEFINITION }))
    end

    return arg1
end

return module
