-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent
local IXPService = game:GetService("IXPService")

local tutils = require(GamePlayButtonParent.tutils)
local React = require(GamePlayButtonParent.React)
local Responsive = require(GamePlayButtonParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local useSelector = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization

local MenuDirection = require(GamePlayButtonParent.UIBlox).App.Menu.MenuDirection

local useTokens = require(GamePlayButtonParent.Foundation).Hooks.useTokens

local GamesProductInfoReducer = require(GamePlayButtonParent.GameProductInfoRodux).GamesProductInfoReducer

local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local useOnPlayButtonCallback = require(script.Parent.useOnPlayButtonCallback)
local useOnPlaySquadButtonCallback = require(script.Parent.useOnPlaySquadButtonCallback)
local usePlayButtonState = require(script.Parent.usePlayButtonState)
local useEarlyAccessCaption = require(script.Parent.EarlyAccess.useEarlyAccessCaption)
local LegacyPlayButton = require(script.Parent.LegacyPlayButton)
local PlayButtonGroupView = require(script.Parent.PlayButtonGroupView)
local PlayButtonStates = require(script.Parent.PlayButtonStates)

local AppUserLayers = require(GamePlayButtonParent.ExperimentLayers).AppUserLayers
local useUserExperiment = require(GamePlayButtonParent.RoactAppExperiment).useUserExperiment

local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagLuaAppUnifyPlayButtonAllSurfacesIxp = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppUnifyPlayButtonAllSurfacesIxp
local bool1 = game:DefineFastFlag("LuaAppFixPlayButtonDefaultLaunchSource", false)

local bool2 = game:DefineFastFlag("LuaAppHidePlayButtonOptionalTextForDualButtons", false)

local FFlagLuaAppUnifiedPlayButtonSquadMenuDirection = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppUnifiedPlayButtonSquadMenuDirection

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry
local FFlagLuaAppUpdatePlayButtonText = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppUpdatePlayButtonText
local FFlagEnableGameJoinEarlyAccess = require(GamePlayButtonParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local FFlagLuaAppLogExposurePlayButtonUX = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppLogExposurePlayButtonUX

local FFlagLuaAppPlayButtonLaunchOnReleaseAfterUnmountForce = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLaunchOnReleaseAfterUnmountForce
local FFlagLuaAppLaunchWhenLoadingEdp = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppLaunchWhenLoadingEdp
local FFlagLuaAppLaunchWhenLoadingForce = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppLaunchWhenLoadingForce

local FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP
local FIntLuaAppPlayButtonSecondaryButtonGap = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonSecondaryButtonGap
local FFlagLuaAppPlayButtonPrivatePT = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT

local FStringR20UniverseId = require(GamePlayButton.Flags.FStringR20UniverseId)

local usePlayOnReleaseAfterUnmount = require(script.Parent.usePlayOnReleaseAfterUnmount)

local function func1() end

return React.memo(function(tbl1) -- name: PlayButton
    local var1 = React.useRef(false)
    React.useEffect(function()
        var1.current = true
        return function()
            var1.current = false
        end
    end, {})

    local var2 = useRoactService(RoactNetworking)
    local gameProductInfo = useSelector(function(arg1)
        if tbl1.universeId then
            return arg1[GamesProductInfoReducer.key][tbl1.universeId]
        end

        return nil
    end, tutils.shallowEqual)

    local eventContext = if FFlagLuaAppPlayButtonLoadingDurationTelemetry then tbl1.eventContext or "PlayButton" else nil
    local var4 = useBreakpointXOrSmaller(Responsive.Keys.Small)

    local var5 = usePlayButtonState(
        var2,
        tbl1.universeId,
        tbl1.fetchDelayInSeconds,
        tbl1.isPlayableWhenLoading,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then true else nil,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then eventContext else nil,
        if FFlagEnableGameJoinEarlyAccess then tbl1.enableEarlyAccessState else nil
    )

    local playButtonState = var5.playButtonState
    local secondaryPlayButtonState = var5.secondaryPlayButtonState
    if secondaryPlayButtonState ~= nil then
        local unplayableOther = PlayButtonStates.UnplayableOther
        local bool3 = playButtonState == unplayableOther
        local unplayableOther2 = PlayButtonStates.UnplayableOther
        local bool4 = secondaryPlayButtonState == unplayableOther2

        if tbl1.preferSecondaryPlayButton == true or var4 and bool3 then
            playButtonState = secondaryPlayButtonState
            secondaryPlayButtonState = nil
        elseif var4 and bool4 then
            secondaryPlayButtonState = nil
        end
    end

    local var6, bool3

    if FFlagEnableGameJoinEarlyAccess then
        local earlyAccess = var5.earlyAccess
        var6 = useEarlyAccessCaption(earlyAccess)
        if earlyAccess then
            bool3 = earlyAccess.isPendingUnlock == true
        else
            bool3 = false
        end
    else
        var6 = nil
        bool3 = nil
    end

    local shouldLaunchWhenLoading = FFlagLuaAppLaunchWhenLoadingForce or FFlagLuaAppLaunchWhenLoadingEdp and tbl1.launchWhenLoading == true

    local var8 = useOnPlayButtonCallback
    local universeId = tbl1.universeId
    local referralSource = tbl1.referralSource
    if not FFlagLuaAppPlayButtonLoadingDurationTelemetry then
        eventContext = tbl1.eventContext or "PlayButton"
    end

    local var9 = var8(
        universeId,
        referralSource,
        eventContext,
        nil,
        tbl1.launchSource or (if bool1 then "UnknownLaunchSource" else "LuaGameCard"),
        tbl1.experienceJoinData,
        tbl1.placeId,
        if FFlagLuaAppLaunchWhenLoadingEdp or FFlagLuaAppLaunchWhenLoadingForce then tbl1.launchWhenLoading else nil
    )
    local squadButtonMenuDirection = if FFlagLuaAppUnifiedPlayButtonSquadMenuDirection and tbl1.squadButtonMenuDirection ~= nil then tbl1.squadButtonMenuDirection else MenuDirection.Up
    local var11 = useOnPlaySquadButtonCallback(squadButtonMenuDirection, playButtonState, tbl1.referralSource, tbl1.universeId)

    local shouldLaunchOnReleaseAfterUnmount = FFlagLuaAppPlayButtonLaunchOnReleaseAfterUnmountForce or tbl1.launchOnReleaseAfterUnmount == true

    local var13 = React.useCallback(function(str1: string?)
        if str1 == nil or not shouldLaunchOnReleaseAfterUnmount and not var1.current then
            return
        end

        if tbl1.onActivated then
            tbl1.onActivated()
        end

        if tbl1.onPurchaseRequiredCallback and (str1 == PlayButtonStates.PaidAccess or str1 == PlayButtonStates.FiatPaidAccess) then
            tbl1.onPurchaseRequiredCallback()
            return
        end
        var9(str1, tbl1.reportExperienceLaunched)
    end, {
        var9,
        tbl1.onPurchaseRequiredCallback,
        tbl1.reportExperienceLaunched,
        tbl1.onActivated,
        shouldLaunchOnReleaseAfterUnmount
    })

    local var14 = React.useCallback(function()
        var13(playButtonState)
    end, { var13, playButtonState })

    local var15 = React.useCallback(function()
        var13(secondaryPlayButtonState)
    end, { var13, secondaryPlayButtonState })

    local var16 = usePlayOnReleaseAfterUnmount(var14)
    local playButtonRef = if shouldLaunchOnReleaseAfterUnmount and var16 then var16.playButtonRef else nil
    local loadingCaptureRef = if shouldLaunchOnReleaseAfterUnmount and var16 then var16.loadingCaptureRef else nil

    if shouldLaunchOnReleaseAfterUnmount then
        var14 = var16.onActivated
    end

    local var17 = React.useCallback(function(arg1)
        if not var1.current then
            return
        end
        if tbl1.onActivated then
            tbl1.onActivated()
        end
        var11(arg1)
    end, { var11, tbl1.onActivated })

    React.useEffect(function()
        local onRegisterActivation = tbl1.onRegisterActivation
        if onRegisterActivation ~= nil then
            return onRegisterActivation(var14)
        end
    end, { tbl1.onRegisterActivation, var14 })

    local localized = useLocalization({
        join = "Feature.ExperienceDetails.PlayButtonText.ActionNeeded",
        play = if FFlagLuaAppUpdatePlayButtonText then "Feature.ExperienceDetails.PlayButtonText.Play" else nil,
        playDemo = "Feature.ExperienceDetails.PlayButtonText.PlayDemo",
        playtest = if FFlagLuaAppPlayButtonPrivatePT then "Feature.ExperienceDetails.PlayButtonText.Playtest" else nil,
        unlock = "Feature.ExperienceDetails.PlayButtonText.Unlock",
        joinWithParty = "Feature.Squads.Action.JoinWithParty",
        unavailable = "Feature.ExperienceDetails.PlayButtonText.Unavailable",
        waitingForParty = "Feature.Squads.Action.WaitingForParty",
        earlyAccess = if FFlagEnableGameJoinEarlyAccess then "Feature.VirtualEvents.Label.EarlyAccess" else nil
    })
    local var19, var20, var21

    if FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then
        var19, var20, var21 = useUserExperiment({ AppUserLayers.PlayButtonUXExposureLayer }, function(arg1)
            local var22 = arg1[AppUserLayers.PlayButtonUXExposureLayer] or {}
            return var22.HasJoinTextButton, var22.HasIconPlayButton, var22.HasPlayButtonLoadingSkeleton
        end, true)
    else
        var19 = nil
        var20 = nil
        var21 = nil
    end

    if FFlagLuaAppLogExposurePlayButtonUX then
        React.useEffect(function()
            IXPService:LogUserLayerExposure(AppUserLayers.PlayButtonUXExposureLayer)
        end, {})
    end

    local tokens = useTokens()

    if not FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP or not tbl1.shouldUseModuleLegacyPlayButtonView then
        local bool4 = if FFlagEnableGameJoinEarlyAccess then not (tbl1.enableEarlyAccessPlusTooltip ~= true)
            and var4
            and not (FStringR20UniverseId == "")
            and tostring(tbl1.universeId) == FStringR20UniverseId else nil
        local hideOptionalText = tbl1.hideOptionalText
        if bool2 and var4 and secondaryPlayButtonState ~= nil then
            hideOptionalText = true
        end

        local createElement = React.createElement
        local var23 = PlayButtonGroupView
        local tbl2 = {
            playButtonState = playButtonState,
            secondaryPlayButtonState = secondaryPlayButtonState
        }

        if not FFlagEnableGameJoinEarlyAccess then
            bool4 = nil
        end

        tbl2.showEarlyAccessTooltip = bool4
        if not FFlagEnableGameJoinEarlyAccess then
            var6 = nil
        end

        tbl2.earlyAccessCaption = var6
        if not FFlagEnableGameJoinEarlyAccess then
            bool3 = nil
        end

        tbl2.earlyAccessPending = bool3
        tbl2.gameProductInfo = gameProductInfo
        tbl2.localized = localized
        tbl2.tokens = tokens
        tbl2.hasJoinTextPlayableButtonIxp = var19
        tbl2.hasIconPlayButtonIxp = var20
        tbl2.hasPlayButtonLoadingSkeletonIxp = var21
        tbl2.onPlayButtonActivated = var14
        tbl2.onSecondaryPlayButtonActivated = var15
        tbl2.onPlaySquadButtonActivated = var17
        tbl2.playButtonCaptureRef = playButtonRef
        tbl2.loadingCaptureRef = loadingCaptureRef
        tbl2.shouldLaunchWhenLoading = shouldLaunchWhenLoading
        tbl2.shouldLaunchOnReleaseAfterUnmount = shouldLaunchOnReleaseAfterUnmount
        tbl2.squadButtonMenuDirection = squadButtonMenuDirection
        tbl2.playableText = tbl1.playableText
        tbl2.fiatText = tbl1.fiatText
        tbl2.hidePlayableIcon = tbl1.hidePlayableIcon
        tbl2.hideOptionalText = hideOptionalText
        tbl2.buttonSize = tbl1.buttonSize
        tbl2.width = tbl1.width
        tbl2.expandWidthForSecondaryPlayButton = tbl1.expandWidthForSecondaryPlayButton
        tbl2.fillBehavior = tbl1.fillBehavior
        tbl2.useUIBloxButton = tbl1.useUIBloxButton
        tbl2.hideIfUnplayable = tbl1.hideIfUnplayable
        tbl2.hideIfLoading = tbl1.hideIfLoading
        tbl2.LayoutOrder = tbl1.LayoutOrder
        tbl2.Position = tbl1.Position
        tbl2.tag = tbl1.tag
        tbl2.testId = tbl1.testId
        return createElement(var23, tbl2)
    end

    local price = gameProductInfo and gameProductInfo.price or 0
    local localizedFiatPrice = gameProductInfo and gameProductInfo.localizedFiatPrice or ""

    if secondaryPlayButtonState == nil then
        local createElement = React.createElement
        local var23 = LegacyPlayButton
        local tbl2 = {
            Size = UDim2.new(tbl1.width or UDim.new(1, 0), UDim.new(1, 0)),
            LayoutOrder = tbl1.LayoutOrder,
            playButtonState = playButtonState,
            price = price,
            localizedFiatPrice = localizedFiatPrice,
            onPlayButtonActivated = var14,
            onPlaySquadButtonActivated = 0,
            testId = 0
        }

        if not GetFFlagIsSquadEnabled() then
            var17 = nil
        end

        tbl2.onPlaySquadButtonActivated = var17
        tbl2.testId = tbl1.testId
        return createElement(var23, tbl2)
    end

    local uDim2 = UDim2.new(0.5, -FIntLuaAppPlayButtonSecondaryButtonGap / 2, 1, 0)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(tbl1.width or UDim.new(1, 0), UDim.new(1, 0)),
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, FIntLuaAppPlayButtonSecondaryButtonGap)
        }),
        PlayButton = React.createElement(LegacyPlayButton, {
            Size = uDim2,
            LayoutOrder = 1,
            playButtonState = playButtonState,
            price = price,
            localizedFiatPrice = localizedFiatPrice,
            onPlayButtonActivated = var14,
            onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then var17 else nil,
            testId = tbl1.testId
        }),
        SecondaryPlayButton = 0
    }
    local createElement2 = React.createElement
    local var23 = LegacyPlayButton
    local tbl4 = {
        Size = uDim2,
        LayoutOrder = 2,
        playButtonState = secondaryPlayButtonState,
        price = price,
        localizedFiatPrice = localizedFiatPrice,
        onPlayButtonActivated = var15 or func1,
        onPlaySquadButtonActivated = 0,
        testId = 0
    }

    if not GetFFlagIsSquadEnabled() then
        var17 = nil
    end

    tbl4.onPlaySquadButtonActivated = var17
    tbl4.testId = if tbl1.testId then `{tbl1.testId}--secondary` else nil
    tbl3.SecondaryPlayButton = createElement2(var23, tbl4)
    return createElement(str1, tbl2, tbl3)
end)
