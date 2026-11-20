-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local _GraphQL = require(scriptParentParent.GraphQL)

local mergeDeep = require(scriptParentParent.Utils).mergeDeep

module.extractExtensionsFromSchema = require(scriptParentParent.Utils).extractExtensionsFromSchema

function module.mergeExtensions(arg1)
    return mergeDeep(arg1)
end

local function applyExtensionObject(arg1, arg2)
    if not arg1 then
        return
    end

    arg1.extensions = mergeDeep(
        { not Boolean.toJSBoolean(arg1.extensions) and {} or arg1.extensions or {}, Boolean.toJSBoolean(arg2) and arg2 or {} }
    )
end

function module.applyExtensions<T>(arg1: T, arg2): T
    applyExtensionObject(arg1, arg2.schemaExtensions)
    for _, value in Object.entries(Boolean.toJSBoolean(arg2.types) and arg2.types or {}) do
        local var1 = value[1]
        local var2 = value[2]

        local type = arg1:getType(var1)
        if not Boolean.toJSBoolean(type) then
            continue
        end

        applyExtensionObject(type, var2.extensions)
        if var2.type == "object" or var2.type == "interface" then
            for _, value2 in Object.entries(var2.fields) do
                local var3 = value2[1]
                local var4 = value2[2]

                local var5 = type:getFields():get(var3)

                if not Boolean.toJSBoolean(var5) then
                    continue
                end

                applyExtensionObject(var5, var4.extensions)
                for _, value3 in Object.entries(var4.arguments) do
                    local var6, var7 = table.unpack(value3, 1, 2)
                    applyExtensionObject(Array.find(var5.args, function(arg3): boolean
                        return arg3.name == var6
                    end), var7)
                end
            end
        elseif var2.type == "input" then
            for _, value2 in Object.entries(var2.fields) do
                local var3, var4 = table.unpack(value2, 1, 2)

                local var5 = type:getFields():get(var3)

                applyExtensionObject(var5, var4.extensions)
            end
        elseif var2.type == "enum" then
            for _, value2 in Object.entries(var2.values) do
                local var3, var4 = table.unpack(value2, 1, 2)
                local value3 = type:getValue(var3)

                applyExtensionObject(value3, var4)
            end
        end
    end

    return arg1
end

return module
