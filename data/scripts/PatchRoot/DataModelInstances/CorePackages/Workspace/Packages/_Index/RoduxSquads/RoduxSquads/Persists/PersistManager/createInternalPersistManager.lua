-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local _PersistStorage = require(RoduxSquads.Persists.PersistStorage.PersistStorage)

return function(arg1): {bindToStorage: (any) -> any, get: () -> any, update: (any) -> any}?
    local storage = arg1.storage
    return if storage then {
        update = function(arg2)
            return storage:setItem(arg2)
        end,
        get = function()
            return storage:getItem()
        end,
        bindToStorage = function(arg2)
            return storage:bindAndFire(arg2)
        end
    } else nil
end
