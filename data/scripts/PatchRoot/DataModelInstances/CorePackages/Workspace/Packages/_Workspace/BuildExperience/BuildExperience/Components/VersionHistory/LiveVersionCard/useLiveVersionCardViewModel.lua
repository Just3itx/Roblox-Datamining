-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local GameGetGameInfoStore = require(BuildExperienceParent.DataHydration.GameGetGameInfoStore)
local GameGetVotesStore = require(BuildExperienceParent.DataHydration.GameGetVotesStore)
local Localization = require(BuildExperienceParent.Localization)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Time = require(BuildExperienceParent.Time)

local FFlagBuildEventsUpdate1 = require(BuildExperience.Flags.FFlagBuildEventsUpdate1)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local launchExperience = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.launchExperience)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local VersionHistoryUtils = require(script.Parent.Parent.VersionHistoryUtils)
local _LiveVersionCardView = require(script.Parent.LiveVersionCardView)

local DateHelper = Time.DateHelper
local useAbbreviatedNumberLocalization = Localization.Hooks.useAbbreviatedNumberLocalization
local useLocalization = Localization.Hooks.useLocalization

local function useLiveVersionCardViewModel(tbl1): {description: number, isPlayDisabled: number, isTotalUpVotesLoading: number, isTotalVisitsLoading: number, layoutOrder: number, onPlayActivated: number, playText: number, testId: number, title: number, totalUpVotes: number, totalVisits: number, versionLabel: any}?
    local placeVersionHistoryStore = PlaceVersionHistory.getPlaceVersionHistoryStore()
    local var1 = React.useMemo(function()
        return placeVersionHistoryStore.getLiveVersion(tbl1.placeId)
    end, { tbl1.placeId, placeVersionHistoryStore })
    local var2 = SignalsReact.useSignalState(var1.data)

    React.useEffect(function()
        placeVersionHistoryStore.fetchLiveVersion(tbl1.placeId)
    end, { tbl1.placeId, placeVersionHistoryStore })

    local var3 = if tbl1.universeId == nil or tbl1.universeId == 0 then nil else tostring(tbl1.universeId)

    local var4 = SignalsReact.useSignalState(function(arg1) -- name: getGameInfo
        local var4 = GameGetGameInfoStore(arg1)
        if var3 == nil then
            return nil
        end

        return (var4.getAndFetchGameInfo(var3).data(arg1))
    end)

    local isTotalVisitsLoading = SignalsReact.useSignalState(function(arg1): boolean -- name: getIsGameInfoLoading
        local var5 = GameGetGameInfoStore(arg1)

        return not (var3 == nil) and var5.getAndFetchGameInfo(var3).status(arg1) == "NotReady"
    end)
    local var6 = SignalsReact.useSignalState(function(arg1) -- name: getVotes
        local var6 = GameGetVotesStore(arg1)
        if var3 == nil then
            return nil
        end

        return (var6.getAndFetchVote(var3).data(arg1))
    end)

    local isTotalUpVotesLoading = SignalsReact.useSignalState(function(arg1): boolean -- name: getAreVotesLoading
        local var7 = GameGetVotesStore(arg1)
        return not (var3 == nil) and var7.getAndFetchVote(var3).status(arg1) == "NotReady"
    end)

    local placeVersion = if var2 then var2.placeVersion else nil
    local var8 = if placeVersion then VersionHistoryUtils.getVersionNumber(placeVersion) else 0
    local var9, var10, var11

    if placeVersion then
        var9, var10, var11 = VersionHistoryUtils.getCreatedDateParts(placeVersion.createdTime)
    else
        var9 = 1
        var10 = 0
        var11 = ""
    end

    local var12 = useLocalization(DateHelper.MonthsLocalizationKeys)
    local var13 = useLocalization
    local tbl2 = {
        createdDate = {
            LocalizationStrings.LIVE_VERSION_CARD_CREATED_DATE,
            MONTH = var12[var9],
            DAY = var10,
            YEAR = var11
        },
        fallbackDescription = LocalizationStrings.LIVE_VERSION_CARD_FALLBACK_DESCRIPTION,
        play = LocalizationStrings.LIVE_VERSION_CARD_PLAY,
        versionNumber = {
            if var8 < 10 then LocalizationStrings.LIVE_VERSION_CARD_VERSION_PADDED else LocalizationStrings.LIVE_VERSION_CARD_VERSION_COMPACT,
            VERSION_NUMBER = var8
        },
        versionTitle = {
            LocalizationStrings.LIVE_VERSION_CARD_VERSION_TITLE,
            VERSION = var8
        }
    }
    local var14 = var13(tbl2)

    local var15 = useLocalization({
        versionLabel = {
            LocalizationStrings.VERSION_HISTORY_VERSION_LABEL,
            VERSION = var14.versionNumber,
            CREATED_DATE = var14.createdDate
        }
    })

    local totalUpVotes = useAbbreviatedNumberLocalization(if var6 then var6.upVotes else nil)
    local totalVisits = useAbbreviatedNumberLocalization(if var4 then var4.totalVisits else nil)

    local onPlayActivated = React.useCallback(function()
        sendBuildExperienceEvent(
            if FFlagBuildEventsUpdate1 then "PLAYTEST_CLICK" else "PLAY_CLICK",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId
            },
            FFlagBuildEventsUpdate1 and { context = "LiveVersionCard" } or nil
        )
        launchExperience(tbl1.placeId, "LiveVersionCard")
        if tbl1.onPlayActivated then
            tbl1.onPlayActivated()
        end
    end, { tbl1.placeId, tbl1.universeId, tbl1.onPlayActivated })

    if placeVersion == nil then
        return nil
    end

    return {
        versionLabel = var15.versionLabel,
        title = if placeVersion.title ~= nil and placeVersion.title ~= "" then placeVersion.title else var14.versionTitle,
        description = if placeVersion.description ~= nil and placeVersion.description ~= "" then placeVersion.description else var14.fallbackDescription,
        totalUpVotes = totalUpVotes,
        totalVisits = totalVisits,
        isTotalUpVotesLoading = isTotalUpVotesLoading,
        isTotalVisitsLoading = isTotalVisitsLoading,
        playText = var14.play,
        isPlayDisabled = tbl1.isPlayDisabled,
        onPlayActivated = onPlayActivated,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return useLiveVersionCardViewModel
