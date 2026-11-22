-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)
local RealtimeDelivery = require(MomentsParent.RealtimeDelivery)
local SignalsReact = require(MomentsParent.SignalsReact)

local GetMomentsUsageStore = require(Moments.Stores.GetMomentsUsageStore)
local _MomentsTimeLimitView = require(script.Parent.MomentsTimeLimitView)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    title = "Feature.Moments.Label.TimeLimitReachedTitle",
    description = "Feature.Moments.Description.TimeLimitReachedBody"
}

local tbl2 = {
    title = "Feature.Moments.Label.MomentsOffTitle",
    description = "Feature.Moments.Description.MomentsOffBody"
}

local function isLimitChange(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local settingsChanged = if type(arg1) == "table" then arg1.SettingsChanged else nil
    return type(settingsChanged) == "table" and table.find(settingsChanged, "MomentsUsageLimit") ~= nil
end

local function useMomentsTimeLimitViewModel()
    local momentsUsageStore = GetMomentsUsageStore(false)
    local var1 = SignalsReact.useSignalState(momentsUsageStore.getLimitSeconds)
    local var2 = useLocalization(if var1 == 0 then tbl2 else tbl1)

    RealtimeDelivery.useRealtimeNamespace("UserSettingsChanged", function(arg1)
        if isLimitChange(arg1) then
            momentsUsageStore.checkForMoreTime()
        end
    end, { momentsUsageStore })

    RealtimeDelivery.useRealtimeConnectionStateChanged("UserSettingsChanged", function(_, arg1)
        if arg1 then
            momentsUsageStore.checkForMoreTime()
        end
    end, { momentsUsageStore })

    return {
        title = var2.title,
        description = var2.description
    }
end

return useMomentsTimeLimitViewModel
