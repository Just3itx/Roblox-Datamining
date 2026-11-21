-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local CentralOverlay = require(GameTileParent.CentralOverlay)
local Foundation = require(GameTileParent.Foundation)
local Localization = require(GameTileParent.Localization)
local Loggers = require(GameTileParent.Loggers)
local React = require(GameTileParent.React)
local RoactServiceTags = require(GameTileParent.RoactServiceTags)
local RoactUtils = require(GameTileParent.RoactUtils)
local RobloxAppEnums = require(GameTileParent.RobloxAppEnums)
local RobloxAppHooks = require(GameTileParent.RobloxAppHooks)
local SharedFlags = require(GameTileParent.SharedFlags)

local AbuseVector = require(GameTileParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(GameTileParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local activateGameNotInterested = require(GameTile.activateGameNotInterested)
local TileOverflowMenuItems = require(GameTile.GameTileConstants).TileOverflowMenuItems

local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local IconName = Foundation.Enums.IconName
local useLocalization = Localization.Hooks.useLocalization
local flaggedMutedError = Loggers.flaggedMutedError
local RoactNetworking = RoactServiceTags.RoactNetworking
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local useRoactService = RobloxAppHooks.useRoactService

local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience
local FFlagEnableNewReportFlowGameTile = SharedFlags.FFlagEnableNewReportFlowGameTile
local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport
local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppContinueSortInstantPlay = SharedFlags.FFlagLuaAppContinueSortInstantPlay

local function useGameTileActions(tbl1, callback: ((...any) -> (...any))?)
    local dispatch = useDispatch()
    local networking = useRoactService(RoactNetworking)
    local localizedStrings = useLocalization({
        notInterested = "Feature.GameDetails.Action.NotInterested",
        whyThisAd = "Feature.GameDetails.Action.WhyThisAd",
        reportAd = "Feature.GameDetails.Action.ReportAd",
        reportExperience = if FFlagLuaAppEnableReportExperience then "Feature.GameDetails.Action.Report" else nil,
        gameDetails = if FFlagLuaAppContinueSortInstantPlay then "Feature.GameDetails.Action.GameDetails" else nil,
        dialogTitle = "Feature.GameDetails.Label.ProvideFeedbackTitle",
        dialogText = "Feature.GameDetails.Message.HelpImproveExperience",
        checkboxListTitle = "Feature.GameDetails.Message.HidingExperienceQuestion",
        tooRepetitive = "Feature.GameDetails.Label.TooRepetitive",
        dontLikeGame = "Feature.GameDetails.Label.DontLikeGame",
        dontLikeImage = "Feature.GameDetails.Label.DontLikeImage",
        inappropriateContent = "Feature.GameDetails.Label.InappropriateContent",
        somethingElse = "Feature.GameDetails.Label.SomethingElse"
    })

    local collectionId = tbl1.collectionId or ""

    local onActivated = if FFlagLuaAppContinueSortInstantPlay then React.useCallback(function()
        if tbl1.onGameDetailsActivated then
            tbl1.onGameDetailsActivated()
        end

        if callback then
            callback(TileOverflowMenuItems.GameDetails)
        end
    end, { tbl1.onGameDetailsActivated, callback }) else nil

    local var1 = React.useCallback(function()
        if activateGameNotInterested({
            appPage = tbl1.appPage,
            collectionId = collectionId,
            dispatch = dispatch,
            isSponsored = tbl1.isSponsored,
            localizedStrings = localizedStrings,
            networking = networking,
            placeId = tbl1.placeId,
            setGameHidden = tbl1.setGameHidden,
            universeId = tbl1.universeId
        })
            and callback
        then
            callback(TileOverflowMenuItems.NotInterested)
        end
    end, {
        collectionId,
        dispatch,
        localizedStrings,
        networking,
        callback,
        tbl1.appPage,
        tbl1.isSponsored,
        tbl1.placeId,
        tbl1.setGameHidden,
        tbl1.universeId
    })

    local useCallback = React.useCallback
    local function func1()
        dispatch(
            SetCentralOverlay(CentralOverlayType.WhyThisAdModal, {
                universeId = tbl1.universeId,
                payerName = tbl1.payerName,
                sponsoredUserCohort = tbl1.sponsoredUserCohort,
                contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
            })
        )
        if callback then
            callback(TileOverflowMenuItems.WhyThisAd)
        end
    end

    local universeId = tbl1.universeId
    local payerName = tbl1.payerName
    local sponsoredUserCohort = tbl1.sponsoredUserCohort
    local contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
    local var2 = useCallback(func1, { dispatch, universeId, payerName, sponsoredUserCohort, contentType, callback })

    local var3 = React.useCallback(function()
        if not tbl1.adId then
            flaggedMutedError("ReportSponsoredAdError", "Report ad clicked without valid target ad id")
            return
        end

        dispatch(OpenDynamicAbuseReport({
            abuseVector = AbuseVector.AdV2,
            targetId = tbl1.adId,
            onClose = function()
                dispatch(CloseCentralOverlay())
            end
        }))

        if callback then
            callback(TileOverflowMenuItems.ReportAd)
        end
    end, { dispatch, tbl1.adId, callback })

    local var4 = if FFlagLuaAppEnableReportExperience then React.useCallback(function()
        if not tbl1.placeId then
            flaggedMutedError("ReportExperienceError", "Report experience clicked without valid target place id")

            return
        end

        local var8 = dispatch
        local var9 = OpenDynamicAbuseReport
        local tbl2 = {
            abuseVector = if FFlagEnableNewReportFlowGameTile then AbuseVector.GameTile else AbuseVector.Place,
            targetId = tbl1.placeId,
            custom = FFlagAddThumbnailSelectorReport and {
                universeId = tbl1.universeId
            } or nil,
            onClose = 0
        }

        function tbl2.onClose()
            dispatch(CloseCentralOverlay())
        end

        var8(var9(tbl2))

        if callback then
            callback(TileOverflowMenuItems.ReportExperience)
        end
    end, {
        dispatch,
        tbl1.placeId,
        tbl1.universeId,
        callback
    }) else nil

    local useMemo = React.useMemo
    local function func2()
        local result = {}

        if FFlagLuaAppContinueSortInstantPlay and tbl1.availableMenuItems[TileOverflowMenuItems.GameDetails] then
            table.insert(result, {
                icon = "icons/actions/info",
                id = TileOverflowMenuItems.GameDetails,
                text = localizedStrings.gameDetails,
                onActivated = onActivated
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.NotInterested] then
            table.insert(result, {
                icon = "icons/actions/block",
                id = TileOverflowMenuItems.NotInterested,
                text = localizedStrings.notInterested,
                onActivated = var1
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.WhyThisAd] then
            table.insert(result, {
                icon = "icons/actions/info",
                id = TileOverflowMenuItems.WhyThisAd,
                text = localizedStrings.whyThisAd,
                onActivated = var2
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.ReportAd] then
            table.insert(
                result,
                {
                    icon = IconName.Flag,
                    id = TileOverflowMenuItems.ReportAd,
                    text = localizedStrings.reportAd,
                    onActivated = var3
                }
            )
        end

        if FFlagLuaAppEnableReportExperience and tbl1.availableMenuItems[TileOverflowMenuItems.ReportExperience] then
            table.insert(result, {
                icon = IconName.Flag,
                id = TileOverflowMenuItems.ReportExperience,
                text = localizedStrings.reportExperience,
                onActivated = var4
            })
        end

        return result
    end

    local var9 = if FFlagLuaAppContinueSortInstantPlay then onActivated else nil
    local isSponsored = tbl1.isSponsored
    local availableMenuItems = tbl1.availableMenuItems
    local var10 = if FFlagLuaAppEnableReportExperience then var4 else nil
    return (useMemo(func2, { var9, var1, localizedStrings, var2, isSponsored, availableMenuItems, var3, var10 }))
end

return useGameTileActions
