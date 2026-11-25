-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local Signals = require(ProfilePlatformParent.Signals)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)

local GameGetGameInfoStore = require(ProfilePlatformParent.DataHydration.GameGetGameInfoStore)

local useSignalState = SignalsReact.useSignalState
local computed = Signals.createComputed(function()
    return nil
end)

local function useExperienceName(num1: number?)
    local var1 = if num1 == nil or num1 == 0 then nil else tostring(num1)
    local var2 = if var1 ~= nil then GameGetGameInfoStore(false).getAndFetchGameInfo(var1).data else computed
    local var3 = useSignalState(var2)
    return if var3 == nil then nil else var3.name
end

return useExperienceName
