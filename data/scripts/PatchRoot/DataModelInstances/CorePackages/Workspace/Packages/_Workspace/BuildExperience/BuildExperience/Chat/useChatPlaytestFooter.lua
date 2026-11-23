-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)

local function getIsPlaytestLoadingForPlaceId(arg1, playtestPlaceId: number?)
    local playtestLoadingStore = GetPlaytestLoadingStore(arg1)
    if playtestPlaceId == nil then
        return false
    end
    return playtestLoadingStore.getIsPlaytestLoadingForPlaceId(playtestPlaceId)(arg1)
end

local function useChatPlaytestFooter(tbl1, str1: string)
    local launchPlaytest = tbl1.launchPlaytest
    local var1 = React.useCallback(function(arg1)
        return getIsPlaytestLoadingForPlaceId(arg1, tbl1.playtestPlaceId)
    end, { tbl1.playtestPlaceId })
    local isPlaytestLoading = SignalsReact.useSignalState(var1)

    local var3 = React.useCallback(function()
        if not launchPlaytest or isPlaytestLoading then
            return
        end

        launchPlaytest(str1)
    end, { isPlaytestLoading, launchPlaytest, str1 })

    local tbl2 = { onPlaytest = 0, isPlaytestLoading = 0 }
    if tbl1.playtestPlaceId == nil or not launchPlaytest then
        var3 = nil
    end

    tbl2.onPlaytest = var3
    tbl2.isPlaytestLoading = isPlaytestLoading
    return tbl2
end

return useChatPlaytestFooter
