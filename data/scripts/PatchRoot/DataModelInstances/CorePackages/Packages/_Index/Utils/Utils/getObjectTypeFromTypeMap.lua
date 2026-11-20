-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Boolean = require(scriptParentParent.LuauPolyfill).Boolean

local module = {}
local isObjectType = require(scriptParentParent.GraphQL).isObjectType

local _types = require(script.Parent.types)

function module.getObjectTypeFromTypeMap(arg1, arg2)
    if arg2 then
        local var1 = arg1:get(arg2.name)

        if Boolean.toJSBoolean(isObjectType(var1)) then
            return var1
        end
    end

    return nil
end

return module
