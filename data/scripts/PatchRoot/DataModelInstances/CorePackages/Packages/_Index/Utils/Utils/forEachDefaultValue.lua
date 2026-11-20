-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local getNamedType = GraphQL.getNamedType

local isObjectType = GraphQL.isObjectType
local isInputObjectType = GraphQL.isInputObjectType

local _Interfaces = require(script.Parent.Interfaces)

local String = LuauPolyfill.String

function module.forEachDefaultValue(arg1, arg2)
    local typeMap = arg1:getTypeMap()

    for _, value in typeMap do
        local var1 = typeMap:get(value[1])

        if String.startsWith(getNamedType(var1).name, "__") then
            continue
        end
        if Boolean.toJSBoolean(isObjectType(var1)) then
            local fields = var1:getFields()

            for _, field in fields do
                for _, arg in fields:get(field[1]).args do
                    arg.defaultValue = arg2(arg.type, arg.defaultValue)
                end
            end
        elseif Boolean.toJSBoolean(isInputObjectType(var1)) then
            local fields = var1:getFields()

            for _, field in fields do
                local var2 = fields:get(field[1])

                var2.defaultValue = arg2(var2.type, var2.defaultValue)
            end
        end
    end
end

return module
