-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local IXPService = game:GetService("IXPService")
local Cryo = require(GameTileParent.Cryo)
local RoactServices = require(GameTileParent.RoactServices).RoactServices
local RoactServiceTags = require(GameTileParent.RoactServiceTags)
local AppSessionService = RoactServiceTags.AppSessionService
local RoactNetworking = RoactServiceTags.RoactNetworking
local Roact = require(GameTileParent.Roact)
local React = require(GameTileParent.React)
local RoactRodux = require(GameTileParent.RoactRodux)
local t = require(GameTileParent.t)
local ButtonSize = require(GameTileParent.Foundation).Enums.ButtonSize
local UIBlox = require(GameTileParent.UIBlox)
local ExperienceActionRow = UIBlox.App.Tile.ExperienceActionRow
local Images = UIBlox.App.ImageSet.Images
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local MenuDirection = UIBlox.App.Menu.MenuDirection
local RobloxAppSessionization = require(GameTileParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType
local withLocalization = require(GameTileParent.Localization).withLocalization
local GamePlayButton = require(GameTileParent.GamePlayButton)
local PlayButton = GamePlayButton.PlayButton
local PlayButtonStates = GamePlayButton.PlayButtonStates
local usePlayButtonState = GamePlayButton.usePlayButtonState
local useOnPlaySquadButtonCallback = GamePlayButton.useOnPlaySquadButtonCallback
local useOnPlayButtonCallback = GamePlayButton.useOnPlayButtonCallback
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local GamesProductInfoReducer = require(GameTileParent.GameProductInfoRodux).GamesProductInfoReducer
local CentralOverlayType = require(GameTileParent.RobloxAppEnums).CentralOverlayType
local CloseCentralOverlay = require(GameTileParent.CentralOverlay).Thunks.CloseCentralOverlay
local AppUserLayers = require(GameTileParent.ExperimentLayers).AppUserLayers
local useUserExperiment = require(GameTileParent.RoactAppExperiment).useUserExperiment
local useAppPolicy = require(GameTileParent.UniversalAppPolicy).useAppPolicy
local GetFFlagIsSquadEnabled = require(GameTileParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagDebugEnablePopForcePicker = require(GameTileParent.SharedFlags).FFlagDebugEnablePopForcePicker

local FFlagLuaAppEnablePlayableStateWhenLoading = require(GameTileParent.SharedFlags).FFlagLuaAppEnablePlayableStateWhenLoading

local FFlagLuaAppSupportDisablePlayableWhenLoading = require(GameTileParent.SharedFlags).FFlagLuaAppSupportDisablePlayableWhenLoading

local FFlagLuaAppDisablePlayableWhenLoadingForce = require(GameTileParent.SharedFlags).FFlagLuaAppDisablePlayableWhenLoadingForce
local FFlagLuaAppPlayButtonLoadingPrimary = require(GameTileParent.SharedFlags).FFlagLuaAppPlayButtonLoadingPrimary
local FFlagLuaAppUnifyPlayButtonTile = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTile
local FFlagLuaAppUnifyPlayButtonTileIxp = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTileIxp
local FFlagLuaAppUnifyPlayButtonAllSurfacesIxp = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonAllSurfacesIxp
local GetFFlagUIBloxUseFoundationButton = require(GameTileParent.SharedFlags).UIBlox.GetFFlagUIBloxUseFoundationButton

local FFlagLuaAppPlayButtonOptOutFoundationButton = require(GameTileParent.SharedFlags).FFlagLuaAppPlayButtonOptOutFoundationButton

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(GameTileParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry
local FFlagLuaAppTextOnlyPlayButton = require(GameTileParent.SharedFlags).FFlagLuaAppTextOnlyPlayButton
local FFlagLuaAppIconTextPlayButton = require(GameTileParent.SharedFlags).FFlagLuaAppIconTextPlayButton
local FFlagLuaAppUpdatePlayButtonText = require(GameTileParent.SharedFlags).FFlagLuaAppUpdatePlayButtonText
local FFlagLuaAppLogExposurePlayButtonUX = require(GameTileParent.SharedFlags).FFlagLuaAppLogExposurePlayButtonUX
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GameTileParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppPlayButtonPrivatePT = require(GameTileParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT

local bool1 = game:DefineFastFlag("LuaAppFixAppExperienceActionRowLoadingState", false)

local GameTileExperimentation = require(GameTile.GameTileExperimentation)

local var1 = if FFlagLuaAppUnifyPlayButtonTile then 40 else nil

local var2 = Roact.PureComponent:extend("AppExperienceActionRow")

local strictInterface = t.strictInterface
local tbl1 = {
    universeId = t.string,
    launchExperienceEventContext = t.optional(t.string),
    referralSource = t.optional(t.string),
    launchSource = t.string,
    reportExperienceLaunched = t.optional(t.callback),
    entry = t.table,
    openGameDetails = t.callback,
    horizontalPadding = t.optional(t.number),
    verticalPadding = t.optional(t.number),
    height = t.optional(t.number),
    fetchDelayInSeconds = t.optional(t.number),
    index = t.optional(t.number),
    showButtonText = t.optional(t.boolean),
    width = if FFlagLuaAppUnifyPlayButtonTile then t.optional(t.UDim) else nil,
    placeIdOverride = t.optional(t.string),
    launchDataOverride = t.optional(t.string),
    price = t.optional(t.number),
    centralOverlayType = t.optional(t.string),
    closeCentralOverlay = t.optional(t.callback),
    playButtonState = t.string,
    playabilityStatus = t.optional(t.table),
    onPlayButtonActivated = t.callback,
    onPlaySquadButtonActivated = t.optional(t.callback),
    sessionService = t.optional(t.union(t.Instance, t.table)),
    isUnifiedGameTileEnabled = t.optional(t.boolean),
    hasUnifiedPlayButtonIxp = if FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then t.optional(t.boolean) else nil,
    unifyToUIBloxIxp = if FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then t.optional(t.boolean) else nil
}
var2.validateProps = strictInterface(tbl1)

local function modifyPlayButtonState(loading) -- Luacid: Inlined by compiler; 1 call site recovered
    return if loading == PlayButtonStates.Loading then PlayButtonStates.Playable else loading
end

function var2.init(arg1)
    function arg1.onPlayPressed()
        if arg1:requiresPurchase() or arg1:requiresFiatPurchase() then
            arg1.props.openGameDetails()
        elseif arg1:isButtonEnabled() then
            SetGamePlaySession(arg1.props.sessionService, SessionType.StructuralIdentifier.GamePlayFromHoverTile, true)
            local reportExperienceLaunched = if arg1.props.reportExperienceLaunched then arg1.reportExperienceLaunched else nil
            arg1.props.onPlayButtonActivated(arg1.props.playButtonState, reportExperienceLaunched)
        end
    end

    function arg1.reportExperienceLaunched(str1: string?)
        if FFlagLuaAppUnifyPlayButtonTile then
            SetGamePlaySession(arg1.props.sessionService, SessionType.StructuralIdentifier.GamePlayFromHoverTile, true)
        end

        local reportExperienceLaunched = arg1.props.reportExperienceLaunched
        local entry = arg1.props.entry
        local referralSource = arg1.props.referralSource
        local launchSource = arg1.props.launchSource
        local launchExperienceEventContext = arg1.props.launchExperienceEventContext
        local index = arg1.props.index
        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            str1 = nil
        end

        reportExperienceLaunched(entry, referralSource, launchSource, launchExperienceEventContext, index, str1)
    end
end

function var2.willUnmount(arg1)
    if GetFFlagIsSquadEnabled() and arg1.props.centralOverlayType == CentralOverlayType.GameDetailsSquad then
        arg1.props.closeCentralOverlay()
    end
end

function var2.render(arg1)
    if FFlagLuaAppUnifyPlayButtonTile then
        local isUnifiedGameTileEnabled = arg1.props.isUnifiedGameTileEnabled

        local var3 = FFlagLuaAppUnifyPlayButtonAllSurfacesIxp and arg1.props.hasUnifiedPlayButtonIxp
            or FFlagLuaAppUnifyPlayButtonTileIxp and GameTileExperimentation.getIsPlayButtonMigrationEnabled()

        if isUnifiedGameTileEnabled and (not (FFlagLuaAppUnifyPlayButtonTileIxp or FFlagLuaAppUnifyPlayButtonAllSurfacesIxp) or var3) then
            local horizontalPadding = arg1.props.horizontalPadding or 0
            local verticalPadding = arg1.props.verticalPadding or 0

            return withLocalization({ buyText = "Feature.ExperienceDetails.PlayButtonText.Buy" })(function(arg2)
                return Roact.createElement(PlayButton, {
                    universeId = arg1.props.universeId,
                    placeId = arg1.props.placeIdOverride,
                    referralSource = arg1.props.referralSource,
                    eventContext = arg1.props.launchExperienceEventContext,
                    launchSource = arg1.props.launchSource,
                    experienceJoinData = arg1.props.launchDataOverride and {
                        launchData = arg1.props.launchDataOverride
                    } or nil,
                    reportExperienceLaunched = arg1.reportExperienceLaunched,
                    fiatText = arg2.buyText,
                    hideOptionalText = not arg1.props.showButtonText,
                    buttonSize = ButtonSize.Medium,
                    isPlayableWhenLoading = true,
                    useUIBloxButton = arg1.props.unifyToUIBloxIxp,
                    onPurchaseRequiredCallback = arg1.props.openGameDetails,
                    preferSecondaryPlayButton = true,
                    fillBehavior = if arg1.props.width then nil else "Fill",
                    width = arg1.props.width,
                    Position = UDim2.new(0, horizontalPadding, 1, -verticalPadding - var1)
                })
            end)
        end
    end

    local appExperienceActionRow = withLocalization({
        unlockText = "Feature.ExperienceDetails.PlayButtonText.Unlock",
        unavailableText = "Feature.ExperienceDetails.PlayButtonText.Unavailable",
        buyText = "Feature.ExperienceDetails.PlayButtonText.Buy",
        playDemoText = "Feature.ExperienceDetails.PlayButtonText.PlayDemo",
        playtestText = if FFlagLuaAppPlayButtonPrivatePT then "Feature.ExperienceDetails.PlayButtonText.Playtest" else nil,
        playText = (FFlagLuaAppTextOnlyPlayButton or FFlagLuaAppIconTextPlayButton)
            and (if FFlagLuaAppUpdatePlayButtonText then "Feature.ExperienceDetails.PlayButtonText.Play" else "Feature.ExperienceDetails.PlayButtonText.ActionNeeded")
            or nil
    })(
        function(arg2)
            return Roact.createElement(ExperienceActionRow, {
                isActionable = arg1:isButtonEnabled(),
                buttonLoading = if FFlagLuaAppSupportDisablePlayableWhenLoading then arg1.props.playButtonState == PlayButtonStates.Loading else nil,
                text = arg1:getButtonText(arg2),
                icon = arg1:getButtonIcon(),
                buttonType = arg1:getButtonType(),
                onPlayPressed = arg1.onPlayPressed,
                onOverflowPressed = if GetFFlagIsSquadEnabled() and arg1:isOverflowButtonVisible() then arg1.props.onPlaySquadButtonActivated else nil,
                horizontalPadding = arg1.props.horizontalPadding,
                verticalPadding = arg1.props.verticalPadding,
                height = arg1.props.height,
                DO_NOT_USE_useUIBloxButton = if GetFFlagUIBloxUseFoundationButton() or FFlagLuaAppPlayButtonOptOutFoundationButton then true else nil
            })
        end
    )

    if not FFlagDebugEnablePopForcePicker then
        return appExperienceActionRow
    end
    local popForcePicker = require(GameTileParent.GamePlayButton.PopForcePicker)

    return Roact.createElement(
        "Frame",
        {
            Name = "PopForcePickerWrapper",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            }),
            PlaySlot = Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    Size = UDim2.fromScale(0, 1),
                    BackgroundTransparency = 1
                },
                {
                    Flex = Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                    AppExperienceActionRow = appExperienceActionRow
                }
            ),
            PopForcePickerAnchor = Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                },
                {
                    Picker = Roact.createElement(popForcePicker, { compact = true })
                }
            )
        }
    )
end

function var2.isOverflowButtonVisible(arg1)
    return GetFFlagIsSquadEnabled()
        and (arg1.props.playButtonState == PlayButtonStates.PlayableWithParty
            or arg1.props.playButtonState == PlayButtonStates.WaitingForParty)
end

function var2.isButtonEnabled(arg1)
    if FFlagLuaAppEnablePlayableStateWhenLoading
        and arg1.props.playabilityStatus == nil
        and GetFFlagIsSquadEnabled()
        and arg1.props.playButtonState == PlayButtonStates.WaitingForParty
    then
        return false
    end

    return (arg1.props.playabilityStatus == nil
        or arg1.props.playButtonState == PlayButtonStates.Playable
        or not FFlagLuaAppSupportDisablePlayableWhenLoading and arg1.props.playButtonState == PlayButtonStates.Loading
        or GetFFlagIsSquadEnabled() and arg1.props.playButtonState == PlayButtonStates.PlayableWithParty)
        and true
        or arg1:isActionNeeded()
        or arg1:requiresPurchase()
        or arg1:requiresFiatPurchase()
        or arg1.props.playButtonState == PlayButtonStates.DemoMode
        or FFlagLuaAppPlayButtonPrivatePT and arg1.props.playButtonState == PlayButtonStates.Playtest
end

function var2.requiresFiatPurchase(arg1): boolean
    return arg1.props.playButtonState == PlayButtonStates.FiatPaidAccess
end

function var2.requiresPurchase(arg1): boolean
    return arg1.props.playButtonState == PlayButtonStates.PaidAccess
end

function var2.isActionNeeded(arg1): boolean
    return arg1.props.playButtonState == PlayButtonStates.ActionNeeded
end

function var2.getButtonText(arg1, arg2)
    if arg1.props.showButtonText and not arg1:isButtonEnabled() then
        return if GetFFlagIsSquadEnabled() and arg1.props.playButtonState == PlayButtonStates.WaitingForParty then nil else arg2.unavailableText
    end

    if arg1:isActionNeeded() then
        return arg2.unlockText
    end

    if arg1:requiresPurchase() then
        return tostring(arg1.props.price or "--")
    end

    if arg1:requiresFiatPurchase() then
        return arg2.buyText
    end

    if arg1.props.playButtonState == PlayButtonStates.DemoMode then
        return arg2.playDemoText
    end

    if FFlagLuaAppPlayButtonPrivatePT and arg1.props.playButtonState == PlayButtonStates.Playtest then
        return arg2.playtestText
    end

    if (FFlagLuaAppTextOnlyPlayButton or FFlagLuaAppIconTextPlayButton)
        and arg1.props.playButtonState == PlayButtonStates.Playable
    then
        return arg2.playText
    end

    return nil
end

function var2.getButtonType(arg1)
    if FFlagLuaAppSupportDisablePlayableWhenLoading
        and (bool1 or not FFlagLuaAppPlayButtonLoadingPrimary)
        and arg1.props.playButtonState == PlayButtonStates.Loading
    then
        if bool1 then
            if FFlagLuaAppPlayButtonLoadingPrimary then
                return ButtonType.PrimaryContextual
            end

            return ButtonType.Secondary
        end

        return ButtonType.Secondary
    end

    if arg1.props.playButtonState == PlayButtonStates.DemoMode
        or FFlagLuaAppPlayButtonPrivatePT and arg1.props.playButtonState == PlayButtonStates.Playtest
    then
        return ButtonType.PrimarySystem
    end

    if arg1:isButtonEnabled() then
        return ButtonType.PrimaryContextual
    end

    return ButtonType.Secondary
end

function var2.getButtonIcon(arg1)
    if FFlagLuaAppSupportDisablePlayableWhenLoading and arg1.props.playButtonState == PlayButtonStates.Loading then
        return nil
    end

    if arg1:requiresPurchase() then
        return Images["icons/common/robux"]
    end

    if arg1:requiresFiatPurchase()
        or arg1.props.playButtonState == PlayButtonStates.DemoMode
        or FFlagLuaAppPlayButtonPrivatePT and arg1.props.playButtonState == PlayButtonStates.Playtest
        or arg1:isActionNeeded()
    then
        return nil
    end

    if FFlagLuaAppTextOnlyPlayButton and arg1.props.playButtonState == PlayButtonStates.Playable then
        return nil
    end

    if arg1:isButtonEnabled() then
        return Images["icons/common/play"]
    end

    if GetFFlagIsSquadEnabled() and arg1.props.playButtonState == PlayButtonStates.WaitingForParty then
        return Images["icons/common/play"]
    end

    return Images["icons/status/unavailable"]
end

local var3 = RoactRodux.connect(function(arg1, arg2)
    local universeId = arg2.universeId
    local var3 = if arg1[GamesProductInfoReducer.key] then arg1[GamesProductInfoReducer.key][universeId] else nil
    return {
        price = if var3 == nil then nil else var3.price,
        centralOverlayType = if GetFFlagIsSquadEnabled() then arg1.CentralOverlay.OverlayType else nil
    }
end, function(arg1)
    return {
        closeCentralOverlay = function()
            return arg1(CloseCentralOverlay())
        end
    }
end)(function(arg1)
    local var3 = useRoactService(RoactNetworking)

    local var4 = usePlayButtonState(
        var3,
        arg1.universeId,
        arg1.fetchDelayInSeconds,
        if FFlagLuaAppEnablePlayableStateWhenLoading then true else nil,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then true else nil,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then arg1.launchExperienceEventContext else nil
    )

    local var5 = arg1.launchDataOverride and {
        launchData = arg1.launchDataOverride
    } or nil

    local onPlayButtonActivated = useOnPlayButtonCallback(
        arg1.universeId,
        arg1.referralSource,
        arg1.launchExperienceEventContext or "PlayButton",
        nil,
        arg1.launchSource or "UnknownLaunchSource",
        var5,
        arg1.placeIdOverride
    )
    local onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then useOnPlaySquadButtonCallback(MenuDirection.Up, var4.playButtonState, arg1.referralSource, arg1.universeId) else nil
    local var8, var9

    if FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then
        var8, var9 = useUserExperiment({ AppUserLayers.PlayButtonUXExposureLayer }, function(arg2)
            local var10 = arg2[AppUserLayers.PlayButtonUXExposureLayer] or {}
            return var10.HasUnifiedPlayButton, var10.UnifyToUIBlox
        end, true)
    else
        var8 = nil
        var9 = nil
    end

    if FFlagLuaAppLogExposurePlayButtonUX then
        React.useEffect(function()
            IXPService:LogUserLayerExposure(AppUserLayers.PlayButtonUXExposureLayer)
        end, {})
    end

    local var10

    if FFlagLuaAppSupportDisablePlayableWhenLoading then
        local var11 = useAppPolicy(function(arg2)
            return arg2.getDisablePlayableWhenLoading()
        end)

        var10 = FFlagLuaAppDisablePlayableWhenLoadingForce or var11
    else
        var10 = nil
    end

    local var11 = if FFlagLuaAppEnablePlayableStateWhenLoading or FFlagLuaAppSupportDisablePlayableWhenLoading and var10 then var4.playButtonState else modifyPlayButtonState(var4.playButtonState)

    if var4.secondaryPlayButtonState ~= nil then
        var11 = var4.secondaryPlayButtonState
    end

    local join = Cryo.Dictionary.join
    local tbl2 = {
        playabilityStatus = var4.playabilityStatus,
        onPlayButtonActivated = onPlayButtonActivated,
        onPlaySquadButtonActivated = onPlaySquadButtonActivated,
        playButtonState = var11,
        hasUnifiedPlayButtonIxp = 0,
        unifyToUIBloxIxp = 0
    }

    if not FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then
        var8 = nil
    end

    tbl2.hasUnifiedPlayButtonIxp = var8
    if not FFlagLuaAppUnifyPlayButtonAllSurfacesIxp then
        var9 = nil
    end

    tbl2.unifyToUIBloxIxp = var9
    local var12 = join(arg1, tbl2)

    return Roact.createElement(var2, var12)
end)
return (RoactServices.connect({ sessionService = AppSessionService })(var3))
