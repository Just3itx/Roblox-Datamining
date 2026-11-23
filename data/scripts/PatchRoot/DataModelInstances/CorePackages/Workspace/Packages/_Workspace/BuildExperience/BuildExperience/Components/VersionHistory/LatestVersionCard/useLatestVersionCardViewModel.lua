-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local Localization = require(BuildExperienceParent.Localization)
local Navigation = require(BuildExperienceParent.Navigation)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local launchPlaytestWithLoadingState = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.launchPlaytestWithLoadingState)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)
local VersionHistoryUtils = require(script.Parent.Parent.VersionHistoryUtils)
local _LatestVersionCardView = require(script.Parent.LatestVersionCardView)
local _useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local DataStatus = DataHydration.DataStatus
local useLocalization = Localization.Hooks.useLocalization
local useNavigation = Navigation.useNavigation

local function useLatestVersionCardViewModel(tbl1)
    local placeVersionHistoryStore = PlaceVersionHistory.getPlaceVersionHistoryStore()
    local var1 = React.useMemo(function()
        return placeVersionHistoryStore.getLiveVersion(tbl1.placeId)
    end, { tbl1.placeId, placeVersionHistoryStore })
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)

    React.useEffect(function()
        placeVersionHistoryStore.fetchLiveVersion(tbl1.placeId)
    end, { tbl1.placeId, placeVersionHistoryStore })

    local var4 = React.useCallback(function(arg1)
        return GetPlaytestLoadingStore(arg1).getIsPlaytestLoadingForPlaceId(tbl1.placeId)(arg1)
    end, { tbl1.placeId })
    local isPlaytestDisabled = SignalsReact.useSignalState(var4)

    local var6 = useLocalization(
        {
            playtest = LocalizationStrings.BUILD_MENU_PLAYTEST,
            publish = LocalizationStrings.BUILD_MENU_PUBLISH
        }
    )
    local var7 = useNavigation()

    local onPlaytestActivated = React.useCallback(function()
        sendBuildExperienceEvent(
            "PLAYTEST_CLICK",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId
            },
            { context = "LatestVersionCard" }
        )
        launchPlaytestWithLoadingState(tbl1.placeId, "LatestVersionCard", true)
    end, { tbl1.placeId, tbl1.universeId })

    local onPublishActivated = React.useCallback(function()
        if var7 == nil then
            return
        end
        sendBuildExperienceEvent(
            "PUBLISH_CLICK",
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId
            },
            { context = "LatestVersionCard" }
        )

        if tbl1.onClose then
            tbl1.onClose()
        end
        var7.navigate(
            "BuildPublish",
            {
                target = var7.getParam("target") or {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                }
            }
        )
    end, {
        tbl1.placeId,
        tbl1.universeId,
        tbl1.onClose,
        var7
    })
    local entry = tbl1.entry
    if entry == nil then
        return nil
    end

    local placeVersion = if var2 then var2.placeVersion else nil
    local versionNumber = if placeVersion then VersionHistoryUtils.getVersionNumber(placeVersion) else nil
    local isPublishDisabled = var3 == DataStatus.NotReady
    local var10 = not FFlagBuildCheckGamePermissions or tbl1.permissions.canEdit
    local var11 = not FFlagBuildCheckGamePermissions or tbl1.permissions.canPublish

    return {
        versionLabel = entry.versionLabel,
        title = entry.title,
        description = entry.description,
        playtestText = var6.playtest,
        publishText = var6.publish,
        isPlaytestDisabled = isPlaytestDisabled or not var10,
        isPublishDisabled = isPublishDisabled or versionNumber == entry.versionNumber or not var11,
        onPlaytestActivated = onPlaytestActivated,
        onPublishActivated = onPublishActivated,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return useLatestVersionCardViewModel
