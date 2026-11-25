-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local useSelector = require(RobloxAppHooksParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(RobloxAppHooksParent.SignalsReact).useSignalState
local FFlagUseSignalsForIsLocalUserSoothsayer = require(RobloxAppHooksParent.SharedFlags).FFlagUseSignalsForIsLocalUserSoothsayer
local GetIsLocalUserSoothsayerStore = if FFlagUseSignalsForIsLocalUserSoothsayer then require(RobloxAppHooksParent.IsLocalUserSoothsayerStore).GetIsLocalUserSoothsayerStore else nil

return function()
    if FFlagUseSignalsForIsLocalUserSoothsayer then
        return useSignalState(GetIsLocalUserSoothsayerStore(false).getIsLocalUserSoothsayer)
    end
    return useSelector(function(arg1)
        return arg1.IsLocalUserSoothsayer
    end)
end
