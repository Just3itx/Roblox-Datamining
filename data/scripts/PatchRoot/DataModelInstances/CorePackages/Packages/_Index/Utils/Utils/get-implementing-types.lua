-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local module = {}
local isObjectType = require(scriptParentParent.GraphQL).isObjectType

function module.getImplementingTypes(name: string, arg1)
    local typeMap = arg1:getTypeMap()
    local implementingTypes = {}

    for _, value in typeMap do
        local var1 = typeMap:get((table.unpack(value)))

        if not Boolean.toJSBoolean(isObjectType(var1)) then
            continue
        end

        local interfaces = var1:getInterfaces()

        if Boolean.toJSBoolean(Array.find(interfaces, function(arg2): boolean
            return arg2.name == name
        end)) then
            table.insert(implementingTypes, var1.name)
        end
    end

    return implementingTypes
end

return module
