-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent
local _Navigation = require(RobloxAppNavigationParent.Navigation)
local _Signals = require(RobloxAppNavigationParent.Signals)

local var1 = nil

local bool1 = false

local tbl1 = {
    dispatch = function(): boolean
        if not bool1 then
            bool1 = true
            print(
                "AppNavigationRegistry: not registered. This is expected in tests that aren't testing navigation. If you *are* testing navigation, please ensure AppNavigation.lua has been required."
            )
        end

        return false
    end,
    getIsNavigating = function(): boolean
        return false
    end
}

local function get() -- Luacid: Inlined by compiler; 1 call site recovered
    return var1 or tbl1
end

return {
    register = function(arg1)
        assert(var1 == nil, "Attempted to double-register AppNavigation")
        var1 = arg1
    end,
    get = get,
    isRegistered = function(): boolean
        return var1 ~= nil
    end,
    isNavigationLocked = function(arg1)
        local var2 = get()
        local getIsPending = var2.getIsPending
        local isNavigating = var2.getIsNavigating(arg1)
        return isNavigating or getIsPending ~= nil and getIsPending(arg1)
    end,
    _resetForTest = function()
        var1 = nil
    end
}
