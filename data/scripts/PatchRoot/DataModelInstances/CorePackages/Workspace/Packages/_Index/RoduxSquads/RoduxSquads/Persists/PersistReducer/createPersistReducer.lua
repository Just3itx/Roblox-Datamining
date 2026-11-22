-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local RoduxSquadsParent = RoduxSquads.Parent
local Rodux = require(RoduxSquadsParent.Rodux)
local createInternalPersistManager = require(RoduxSquads.Persists.PersistManager).createInternalPersistManager
local createPersistManager = require(RoduxSquads.Persists.PersistManager).createPersistManager
local createPause = require(RoduxSquads.Persists.Actions).createPause
local createPersistAndUpdateState = require(RoduxSquads.Persists.Actions).createPersistAndUpdateState

local tbl1 = { isPaused = false }

return function(arg1, arg2)
    local bool1 = false
    local pause = createPause(arg1)
    local persistAndUpdateState = createPersistAndUpdateState(arg1)

    local internalPersistManager = createInternalPersistManager(arg1)
    local persistManager = createPersistManager(arg1, internalPersistManager)

    local isPaused = tbl1.isPaused

    local var1 = nil

    if internalPersistManager then
        internalPersistManager.bindToStorage(function(arg3)
            var1 = arg3
        end)
        var1 = internalPersistManager.get()
    end

    local function func1(arg3, arg4)
        if internalPersistManager and not bool1 then
            arg3 = var1 or arg3
        end

        bool1 = true

        if persistAndUpdateState.name == arg4.type then
            return var1
        end

        local var2

        if isPaused then
            var2 = arg3
        else
            var2 = arg2(arg3, arg4)
            if internalPersistManager and var2 ~= arg3 then
                internalPersistManager.update(var2)
            end
        end

        return var2
    end

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[persistAndUpdateState.name] = function(_, _)
        isPaused = false
        return { isPaused = isPaused }
    end
    tbl3[pause.name] = function(_, _)
        isPaused = true
        return { isPaused = isPaused }
    end

    return func1, createReducer(tbl2, tbl3), persistManager
end
