-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local getNamedType = GraphQL.getNamedType

local isObjectType = GraphQL.isObjectType

local _Interfaces = require(script.Parent.Interfaces)

local String = LuauPolyfill.String

function module.forEachField(arg1, callback)
    local typeMap = arg1:getTypeMap()

    for _, value in typeMap do
        local var1 = value[1]

        local var2 = typeMap:get(var1)

        if String.startsWith(getNamedType(var2).name, "__") or not isObjectType(var2) then
            continue
        end

        local fields = var2:getFields()

        for _, field in fields do
            local var3 = field[1]

            callback(fields:get(var3), var1, var3)
        end
    end
end

return module
