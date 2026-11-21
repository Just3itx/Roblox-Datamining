-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")

local ApiPostPreparePurchase = require(GamePlayButton.ApiPostPreparePurchase)
local GamePlayButtonShareLinkAnalytics = require(GamePlayButton.GamePlayButtonShareLinkAnalytics)
local OpenCentralOverlayForPurchaseGame = require(GamePlayButton.OpenCentralOverlayForPurchaseGame)
local OpenCentralOverlayForUnifiedPurchasePrompt = require(GamePlayButton.OpenCentralOverlayForUnifiedPurchasePrompt)
local PlayButtonReferralSource = require(GamePlayButton.PlayButtonReferralSource)
local PlayButtonStates = require(GamePlayButton.PlayButtonStates)
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)

local usePlayButtonLaunchAfterSeventeenPlusUpsell = require(GamePlayButton.PlayButtonLaunchChecks.usePlayButtonLaunchAfterSeventeenPlusUpsell)
local usePlayButtonLaunchGame = require(GamePlayButton.PlayButtonLaunchChecks.usePlayButtonLaunchGame)

local usePlayButtonLaunchWithUxTreatment = require(GamePlayButton.PlayButtonLaunchChecks.usePlayButtonLaunchWithUxTreatment)

local useAgeVerificationOverlayCallback = require(GamePlayButton.PlayButtonLaunchChecks.useAgeVerificationOverlayCallback)

local usePrivatePlaytestLaunchWithUpsell = require(GamePlayButton.PlayButtonLaunchChecks.usePrivatePlaytestLaunchWithUpsell)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local RoactUtils = require(GamePlayButtonParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useRouteName = require(GamePlayButtonParent.Navigation).useRouteName
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(GamePlayButtonParent.RoactServiceTags)
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local RoactNetworking = RoactServiceTags.RoactNetworking
local AppUpdateService = RoactServiceTags.AppUpdateService
local joinGamePlayButton = require(GamePlayButtonParent.DiscoveryAnalytics).Points.joinGamePlayButton
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent
local invalidPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.invalidPlayIntent
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local DiscoveryEventErrorLogger = require(GamePlayButtonParent.DiscoveryUtils).DiscoveryEventErrorLogger
local HandleUpdate = require(GamePlayButtonParent.RobloxAppUpdate).HandleUpdate
local launchPlaytestWithLoadingState = require(GamePlayButtonParent.BuildExperiencePlaytestLaunch.launchPlaytestWithLoadingState)
local useGameProductInfoSelector = require(GamePlayButtonParent.GameProductInfoRodux).useGameProductInfoSelector
local GameHydrationReact = require(GamePlayButtonParent.GameHydrationReact)
local CloseCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Thunks.CloseCentralOverlay
local FetchGamePlayabilityAndProductInfo = require(GamePlayButtonParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local PurchasePromptLite = require(GamePlayButtonParent.PurchasePromptLite)
local ProductPurchaseSurface = PurchasePromptLite.Enums.ProductPurchaseSurface
local getIsUserEligibleForUnifiedPurchaseFlow = PurchasePromptLite.getIsUserEligibleForUnifiedPurchaseFlow
local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled
local GetFFlagLuaAppEnableVirtualEventPlaceId = require(GamePlayButtonParent.SharedFlags).GetFFlagLuaAppEnableVirtualEventPlaceId
local FFlagShipUnifiedPurchaseFlowToPaidAccess = require(GamePlayButtonParent.SharedFlags).FFlagShipUnifiedPurchaseFlowToPaidAccess
local CreateExperienceInvite = require(GamePlayButtonParent.Squads.Thunks).CreateExperienceInvite

local SquadExternalContractContext = require(GamePlayButtonParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadExperienceInviteType = require(GamePlayButtonParent.SquadsCore.Enums).SquadExperienceInviteType
local SquadExperienceInviteSource = require(GamePlayButtonParent.SquadsCore.Enums).SquadExperienceInviteSource
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)

local engineFeature = game:GetEngineFeature("CanPerformBinaryUpdateEnabled")
local FFlagEnableSquadRegroupExperimentation = require(GamePlayButtonParent.SharedFlags).FFlagEnableSquadRegroupExperimentation
local FFlagLuaAppPlayableUxTreatment = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayableUxTreatment
local FFlagEnablePrivatePartyStartJoin = require(GamePlayButtonParent.SharedFlags).FFlagEnablePrivatePartyStartJoin

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry
local FFlagLuaAppLaunchWhenLoadingEdp = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppLaunchWhenLoadingEdp
local FFlagEnableGameJoinEarlyAccess = require(GamePlayButtonParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local FFlagLuaAppLaunchWhenLoadingForce = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppLaunchWhenLoadingForce
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppPlayButtonPrivatePT = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT
local FFlagLuaAppPrivatePlaytestEarlyTesting = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPrivatePlaytestEarlyTesting

local FFlagLuaAppPrivatePlaytestWithoutBuildMode = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPrivatePlaytestWithoutBuildMode

local FFlagLuaAppPlayButtonPrivatePTEnableSingleButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePTEnableSingleButton

local FFlagLuaAppPlayButtonPrivatePTEnableDualButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePTEnableDualButton
local FFlagLuaAppCloudClientPlayButtonOffer = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppCloudClientPlayButtonOffer
local usePlayButtonLaunchWithCloudClientOffer = if FFlagLuaAppCloudClientPlayButtonOffer then require(GamePlayButton.PlayButtonLaunchChecks.usePlayButtonLaunchWithCloudClientOffer) else nil

return function(universeId, referralSource, ctx, _, arg3, tbl1, arg4, bool1: boolean?)
    local var1 = useRoactService(RoactAnalytics)
    local var2 = useRoactService(AppUpdateService)
    local var3 = useRoactService(AppEventIngestService)

    local var4 = useDispatch()
    local var5 = useSelector(function(arg5)
        return arg5.GameDetails[universeId]
    end)
    local var6 = GameHydrationReact.useGameInfo(universeId)
    local var7 = useGameProductInfoSelector(universeId)
    local var8 = useSelector(function(arg5)
        return arg5.PlayabilityStatus[universeId]
    end)
    local experienceIconUrl = GameHydrationReact.useGameIcon(universeId)

    local pageName = useRouteName()
    local var11 = if GetFFlagIsSquadEnabled() then React.useContext(SquadExternalContractContext) else nil
    local rootPlaceId = var5 and var5.rootPlaceId

    if not rootPlaceId then
        if var6 then
            rootPlaceId = var6.rootPlaceId or nil
        else
            rootPlaceId = nil
        end
    end

    local var12 = if GetFFlagLuaAppEnableVirtualEventPlaceId() and arg4 ~= "0" then arg4 or rootPlaceId else rootPlaceId
    local name = var5 and var5.name

    if not name then
        if var6 then
            name = var6.name or nil
        else
            name = nil
        end
    end

    local var13

    if FFlagLuaAppPlayButtonPrivatePT then
        local id = var5 and var5.creator and var5.creator.id or var6 and var6.creator and var6.creator.id or nil

        if id == nil then
            var13 = nil
        else
            var13 = tostring(id)
        end
    else
        var13 = nil
    end
    local var14 = usePlayButtonLaunchGame(universeId, var12, rootPlaceId, referralSource, ctx, arg3, tbl1)
    local var15 = if FFlagLuaAppCloudClientPlayButtonOffer then usePlayButtonLaunchWithCloudClientOffer(universeId, var12, rootPlaceId, var8, pageName, var14) else nil
    local var16 = if FFlagLuaAppPlayableUxTreatment then usePlayButtonLaunchWithUxTreatment(
        var8,
        universeId,
        if FFlagLuaAppCloudClientPlayButtonOffer then var15 else var14,
        pageName
    ) else nil
    local var17 = usePlayButtonLaunchAfterSeventeenPlusUpsell

    if not FFlagLuaAppPlayableUxTreatment then
        if FFlagLuaAppCloudClientPlayButtonOffer then
            var16 = var15
        else
            var16 = var14
        end
    end

    local var18 = var17(var8, universeId, var16, pageName)

    local var19 = useAgeVerificationOverlayCallback

    if FFlagLuaAppCloudClientPlayButtonOffer then
        var14 = var15
    end

    local var20 = var19(universeId, var14, var18)

    local var21 = React.useCallback(function(arg5, str1: string?)
        local func1 = game:GetEngineFeature("VoiceChatSupported") and function()
            var20(arg5, if FFlagLuaAppDemoModePlayButtonTelemetry then str1 else nil)
        end or function()
            var18(arg5, if FFlagLuaAppDemoModePlayButtonTelemetry then str1 else nil)
        end

        HandleUpdate(var4, var2, engineFeature, var1, ctx, func1)
    end, {
        var1,
        var2,
        engineFeature,
        ctx,
        var20,
        var18,
        var4
    })

    local var22 = useRoactService(RoactNetworking)

    local var23 = FFlagLuaAppLaunchWhenLoadingForce or FFlagLuaAppLaunchWhenLoadingEdp and bool1 == true

    local var24 = nil
    if FFlagLuaAppPlayButtonPrivatePT then
        local var25 = React.useCallback(function(callback: ((...any) -> (...any))?, str1: string?)
            local var25 = if var12 == nil then nil else tonumber(var12)

            if var25 == nil then
                DiscoveryEventErrorLogger.reportError(
                    "PlaytestLaunchMissingPlaceId",
                    `Cannot launch private Playtest without a valid placeId for universeId {universeId}`
                )
                return
            end

            local var26 = if FFlagLuaAppPrivatePlaytestEarlyTesting or FFlagLuaAppPrivatePlaytestWithoutBuildMode then launchPlaytestWithLoadingState(var25, arg3, nil, nil, true) else launchPlaytestWithLoadingState(var25, arg3, true)

            if not var26 or callback == nil then
                return
            end

            if not FFlagLuaAppDemoModePlayButtonTelemetry then
                str1 = nil
            end

            callback(str1)
        end, { var12, arg3, universeId })

        if FFlagLuaAppPlayButtonPrivatePTEnableSingleButton then
            var25 = var21
        end

        var24 = usePrivatePlaytestLaunchWithUpsell(var8, tostring(universeId), var25, ctx, pageName, var13)
    end

    local useCallback = React.useCallback
    local function func1(playButtonState, arg5, tbl2)
        joinGamePlayButton(var1.InfluxDb, "playButtonClicked", {
            isUniversalApp = true,
            referralSource = referralSource,
            placeId = rootPlaceId,
            buttonState = playButtonState and playButtonState or "Invalid",
            ctx = ctx
        })
        if referralSource == PlayButtonReferralSource.ExperienceDetailsLink then
            GamePlayButtonShareLinkAnalytics(var1, {
                placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then var12 else rootPlaceId,
                playButtonState = playButtonState,
                universeId = universeId
            })
        end

        if playButtonState == PlayButtonStates.Playable or playButtonState == PlayButtonStates.ActionNeeded then
            if FFlagLuaAppPlayButtonPrivatePTEnableSingleButton then
                local privatePlaytestInfo = if var8 then var8.privatePlaytestInfo or nil else nil

                if playButtonState == PlayButtonStates.ActionNeeded and privatePlaytestInfo ~= nil then
                    var24(arg5, "PlaytestPlayButtonClick")

                    return
                end
            end

            var21(arg5)
            return
        end

        if playButtonState == PlayButtonStates.PaidAccess then
            local price = if var7 then var7.price or nil else nil
            local productId = if var7 then var7.productId or nil else nil
            local sellerId = if var7 then var7.sellerId or nil else nil
            local universeId = if var7 then var7.universeId or nil else nil

            local function onFlowComplete()
                var4(CloseCentralOverlay())
            end
            local function onPurchaseSuccess()
                var4(FetchGamePlayabilityAndProductInfo.Fetch(var22, universeId))
            end
            local function initiateLegacyPurchaseFlow() -- Luacid: Inlined by compiler; 2 call sites recovered
                var4(OpenCentralOverlayForPurchaseGame(universeId, name, price, productId, sellerId, { pageName }))
            end

            if FFlagShipUnifiedPurchaseFlowToPaidAccess then
                var4(
                    OpenCentralOverlayForUnifiedPurchasePrompt({
                        productPayload = {
                            universeId = universeId,
                            kind = "Experience",
                            experienceName = name,
                            experienceIconUrl = experienceIconUrl
                        },
                        purchaseCallbacks = {
                            onFlowComplete = onFlowComplete,
                            onPurchaseSuccess = onPurchaseSuccess
                        },
                        purchaseAnalyticsMetadata = {
                            surface = ProductPurchaseSurface.PaidAccess
                        }
                    })
                )
                return
            end

            getIsUserEligibleForUnifiedPurchaseFlow(var22):andThen(function(arg6)
                if not arg6 then
                    initiateLegacyPurchaseFlow()
                    return
                end

                var4(
                    OpenCentralOverlayForUnifiedPurchasePrompt({
                        productPayload = {
                            universeId = universeId,
                            kind = "Experience",
                            experienceName = name,
                            experienceIconUrl = experienceIconUrl
                        },
                        purchaseCallbacks = {
                            onFlowComplete = onFlowComplete,
                            onPurchaseSuccess = onPurchaseSuccess
                        },
                        purchaseAnalyticsMetadata = {
                            surface = ProductPurchaseSurface.PaidAccess
                        }
                    })
                )
            end):catch(function(_)
                initiateLegacyPurchaseFlow()
            end)

            return
        end

        if playButtonState == PlayButtonStates.DemoMode then
            if FFlagLuaAppDemoModePlayButtonTelemetry then
                var21(arg5, "DemoPlayButtonClick")
                return
            end
            var21(arg5)
            return
        end
        if FFlagLuaAppPlayButtonPrivatePTEnableDualButton and playButtonState == PlayButtonStates.Playtest then
            var24(arg5, "PlaytestPlayButtonClick")
            return
        end
        if playButtonState == PlayButtonStates.FiatPaidAccess then
            if rootPlaceId and var7 and var7.fiatBasePriceId then
                var4(ApiPostPreparePurchase.Fetch(var22, rootPlaceId, universeId, var7.fiatBasePriceId))

                unlockPlayIntent(var3, {
                    universeId = universeId,
                    upsellName = "FiatPurchase",
                    playabilityStatus = if var8 then var8.playabilityStatus or nil else nil,
                    pageName = pageName
                })
            end

            return
        end

        if playButtonState == PlayButtonStates.Loading then
            invalidPlayIntent(ctx, {
                universeId = universeId,
                playButtonState = playButtonState,
                playabilityStatus = if var8 then var8.playabilityStatus or nil else nil,
                pageName = if FFlagLuaAppPlayButtonLoadingDurationTelemetry then pageName else nil
            })

            if var23 then
                var21(arg5)
            end
            return
        end

        if GetFFlagIsSquadEnabled() and playButtonState == PlayButtonStates.PlayableWithParty then
            if rootPlaceId then
                var4(
                    CreateExperienceInvite(
                        rootPlaceId,
                        var11,
                        if FFlagEnableSquadRegroupExperimentation then SquadExperienceInviteSource.Default else nil,
                        if FFlagEnablePrivatePartyStartJoin and tbl2 and tbl2.isPrivateParty then SquadExperienceInviteType.PlayWithPartyInPrivatePartyServer else nil
                    )
                )
            end

            return
        end

        if playButtonState == PlayButtonStates.WaitingForParty then
            invalidPlayIntent(ctx, {
                universeId = universeId,
                playButtonState = playButtonState,
                playabilityStatus = if var8 then var8.playabilityStatus or nil else nil,
                pageName = if FFlagLuaAppPlayButtonLoadingDurationTelemetry then pageName else nil
            })
            return
        end
        if playButtonState ~= PlayButtonStates.UnplayableOther
            and (not FFlagEnableGameJoinEarlyAccess or playButtonState ~= PlayButtonStates.EarlyAccessLocked)
        then
            error(`invalid play button state {playButtonState}!`)
            return
        end

        invalidPlayIntent(ctx, {
            universeId = universeId,
            playButtonState = playButtonState,
            playabilityStatus = if var8 then var8.playabilityStatus or nil else nil,
            pageName = if FFlagLuaAppPlayButtonLoadingDurationTelemetry then pageName else nil
        })
    end

    local bool2 = engineFeature
    local var25 = if GetFFlagLuaAppEnableVirtualEventPlaceId() or FFlagLuaAppPlayButtonPrivatePT then var12 else nil
    local var26 = if FFlagLuaAppPlayButtonPrivatePT then arg3 else nil
    local var27 = if FFlagLuaAppPlayButtonPrivatePT then var24 else nil
    local var28 = if GetFFlagIsSquadEnabled() then var11 else nil
    local tableValue1 = var1
    local tableValue2 = var2
    local tableValue3 = bool2
    local tableValue4 = universeId
    local tableValue5 = var25
    local tableValue6 = rootPlaceId
    local tableValue7 = name
    local tableValue8 = referralSource
    local tableValue9 = ctx
    local tableValue10 = var21
    local tableValue11 = var7
    local tableValue12 = pageName
    local tableValue13 = var26
    local tableValue14 = var27
    local tableValue15 = var28
    local tableValue16 = var8
    local var29 = if FFlagLuaAppLaunchWhenLoadingForce or FFlagLuaAppLaunchWhenLoadingEdp then var23 else nil
    return (useCallback(func1, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        var4,
        var3,
        experienceIconUrl,
        var22,
        var29
    }))
end
