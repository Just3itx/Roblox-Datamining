-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local Promise = require(scriptParentParentParent.Promise)
local _PromiseOrValue = require(scriptParentParent.jsutils.PromiseOrValue)

return {
    coerceToPromise = function(arg1)
        if Promise.is(arg1) then
            return arg1
        end
        return (Promise.resolve(arg1))
    end
}
