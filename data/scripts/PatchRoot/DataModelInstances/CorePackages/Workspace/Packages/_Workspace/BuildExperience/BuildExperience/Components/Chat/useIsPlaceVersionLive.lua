-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local function useIsPlaceVersionLive(num1: number?, num2: number?): boolean
    local placeVersionHistoryStore = PlaceVersionHistory.getPlaceVersionHistoryStore()
    if num2 == nil then
        num1 = nil
    end

    local var1 = React.useMemo(function()
        if num1 == nil then
            return (Signals.createSignal(nil))
        end
        return placeVersionHistoryStore.getLiveVersion(num1).data
    end, { num1, placeVersionHistoryStore })
    local var2 = SignalsReact.useSignalState(var1)

    React.useEffect(function()
        if num1 ~= nil then
            placeVersionHistoryStore.fetchLiveVersion(num1)
        end
    end, { num1, placeVersionHistoryStore })

    local placeVersion = if var2 == nil then nil else var2.placeVersion
    return not (num2 == nil or placeVersion == nil) and tonumber(placeVersion.version) == num2
end

return useIsPlaceVersionLive
