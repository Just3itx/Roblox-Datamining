-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SignalsUtilsParent = script:FindFirstAncestor("SignalsUtils").Parent
local Signals = require(SignalsUtilsParent.Signals)
local getCurrentUserId = require(SignalsUtilsParent.LocalUserIdStore).LocalUserIdStore.getCurrentUserId

local function createSessionScopedSignal(arg1, arg2)
    local computed = Signals.createComputed(function(arg3)
        getCurrentUserId(arg3)
        local getter, setter = Signals.createSignal(arg1, arg2)
        return { getter = getter, setter = setter }
    end)
    local function getter(arg3)
        return computed(arg3).getter(arg3)
    end
    local function setter(arg3)
        computed().setter(arg3)
    end
    return getter, setter
end

return createSessionScopedSignal
