-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)
local _createPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.createPlaytestLoadingStore)
local PlaytestStatusIndicator = require(script.Parent.PlaytestStatusIndicator)

local function getStatusForPlaceId(arg1, placeId: number, playtestLoadingStore)
    return (playtestLoadingStore or GetPlaytestLoadingStore(arg1)).getStatusForPlaceId(placeId)(arg1)
end

local function PlaytestStatusIndicatorForPlace(tbl1)
    local var1 = React.useCallback(function(arg1)
        return getStatusForPlaceId(arg1, tbl1.placeId, tbl1.playtestLoadingStore)
    end, { tbl1.placeId, tbl1.playtestLoadingStore })
    local status = SignalsReact.useSignalState(var1)

    return React.createElement(PlaytestStatusIndicator, { LayoutOrder = tbl1.LayoutOrder, status = status })
end

return PlaytestStatusIndicatorForPlace
