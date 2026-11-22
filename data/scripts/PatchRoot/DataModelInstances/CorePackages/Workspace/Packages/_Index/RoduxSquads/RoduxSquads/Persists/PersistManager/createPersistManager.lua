-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")

local _createInternalPersistManager = require(RoduxSquads.Persists.PersistManager.createInternalPersistManager)

local createPause = require(RoduxSquads.Persists.Actions).createPause
local createPersistAndUpdateState = require(RoduxSquads.Persists.Actions).createPersistAndUpdateState

return function(arg1, arg2): {pause: (any) -> (), persistAndUpdateState: (any) -> (), reset: () -> ()}?
    return if arg2 then {
        reset = function()
            arg2.update(nil)
        end,
        persistAndUpdateState = function(callback)
            local persistAndUpdateState2 = createPersistAndUpdateState(arg1)
            if persistAndUpdateState2 then
                callback(persistAndUpdateState2())
            end
        end,
        pause = function(callback)
            local pause2 = createPause(arg1)
            if pause2 then
                callback(pause2())
            end
        end
    } else nil
end
