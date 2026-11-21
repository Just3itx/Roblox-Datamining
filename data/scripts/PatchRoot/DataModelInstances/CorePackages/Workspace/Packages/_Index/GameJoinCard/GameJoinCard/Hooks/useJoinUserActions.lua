-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local Signals = require(GameJoinCardParent.Signals)
local SignalsReact = require(GameJoinCardParent.SignalsReact)
local DataHydration = require(GameJoinCardParent.DataHydration)

local FFlagJoinabilityCTARefactor = require(GameJoinCardParent.SharedFlags).FFlagJoinabilityCTARefactor

local ProfileCTAStore = DataHydration.Profile.ProfileCTAStore
local DataStatus = DataHydration.DataStatus
local useSignalState = SignalsReact.useSignalState
local createComputed = Signals.createComputed

local computed = createComputed(function()
    return nil
end)
local computed2 = createComputed(function()
    return DataStatus.NotReady
end)

local function useJoinUserActions(userId: string, bool1: boolean?, arg1)
    local bool2 = bool1 == true
    local var1 = React.useRef(nil)

    local var2 = React.useMemo(function()
        if FFlagJoinabilityCTARefactor and userId ~= "" and bool2 then
            local getJoinUserActions = ProfileCTAStore.get().getJoinUserActions
            if getJoinUserActions then
                return getJoinUserActions(userId, true)
            end
        end
        return nil
    end, { userId, bool2, arg1 })

    if var2 then
        var1.current = { userId = userId, result = var2 }
    end

    local current = var1.current

    if var2 == nil and current and current.userId == userId then
        var2 = current.result
    end

    return useSignalState(if var2 then var2.data else computed), (useSignalState(if var2 then var2.status else computed2))
end

return useJoinUserActions
