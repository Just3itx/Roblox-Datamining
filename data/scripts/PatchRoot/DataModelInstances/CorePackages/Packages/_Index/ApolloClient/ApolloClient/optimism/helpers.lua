-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local _helpers_types = require(script.Parent.helpers_types)

local module = {
    hasOwnProperty = require(scriptParentParent.luaUtils.hasOwnProperty)
}

function module.toArray(arg1)
    if arg1._array then
        return table.clone(arg1._array)
    end

    local result = {}
    arg1:forEach(function(arg2)
        table.insert(result, arg2)
    end)
    return result
end

function module.maybeUnsubscribe(arg1)
    local unsubscribe = arg1.unsubscribe

    if type(unsubscribe) == "function" then
        arg1.unsubscribe = nil
        unsubscribe()
    end
end

return module
