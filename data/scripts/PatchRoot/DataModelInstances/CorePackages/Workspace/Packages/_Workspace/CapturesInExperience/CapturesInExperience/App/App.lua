-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local FFlagCapturesInExpUseMomentsCreation = require(scriptParentParent.Flags.FFlagCapturesInExpUseMomentsCreation)

local AppStorageService = game:GetService("AppStorageService")
local CaptureService = game:GetService("CaptureService")
local LocalizationService = game:GetService("LocalizationService")
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local AppCommonLib = require(scriptParentParentParent.AppCommonLib)
local CapturesCommon = require(scriptParentParentParent.CapturesCommon)
local Dash = require(scriptParentParentParent.Dash)
local MomentsCreationFlow = if FFlagCapturesInExpUseMomentsCreation then nil else require(scriptParentParentParent.MomentsCreationFlow)
local React = require(scriptParentParentParent.React)
local Roact = require(scriptParentParentParent.Roact)
local Rodux = require(scriptParentParentParent.Rodux)

local Signal = AppCommonLib.Signal

local AnalyticsService = require(scriptParentParent.Analytics.AnalyticsService)
local CaptureManagerScreen = require(scriptParentParent.Components.CaptureManager.CaptureManagerScreen)
local CaptureOverlay = require(scriptParentParent.Components.CoreUI.CaptureOverlay)
local MomentsCreationFlowScreen = require(scriptParentParent.Components.MomentsCreationFlow.MomentsCreationFlowScreen)
local CapturesActivated = require(scriptParentParent.Actions.CapturesActivated)
local CapturesCoreGuiDisabled = require(scriptParentParent.Actions.CapturesCoreGuiDisabled)
local CapturesCoreGuiEnabled = require(scriptParentParent.Actions.CapturesCoreGuiEnabled)
local CapturesCoreUI = require(scriptParentParent.Components.CoreUI.CapturesCoreUI)
local CapturesDeactivated = require(scriptParentParent.Actions.CapturesDeactivated)
local CaptureServicePrompts = require(scriptParentParent.Components.CaptureService.CaptureServicePrompts)
local CapturesPage = require(scriptParentParent.Components.CoreUI.CapturesPage)
local CapturesPolicy = require(scriptParentParent.App.CapturesPolicy)
local CarouselScreen = require(scriptParentParent.Components.CapturesCarousel.CarouselScreen)
local Constants = require(scriptParentParent.Constants)
local EventNames = require(scriptParentParent.Analytics.EventNames)
local getLocalUserId = require(scriptParentParent.Utils.getLocalUserId)
local GetLatestCaptureStore = require(scriptParentParent.Stores.GetLatestCaptureStore)
local getUserIdsFromString = require(scriptParentParent.Utils.getUserIdsFromString)
local installReducer = require(scriptParentParent.installReducer)
local makeCaptureSavedHandler = require(scriptParentParent.Utils.makeCaptureSavedHandler)
local makeVideoCaptureInProgressHandler = require(scriptParentParent.Utils.makeVideoCaptureInProgressHandler)
local makeWrapWithProviders = require(scriptParentParent.Utils.makeWrapWithProviders)
local MenuClosed = require(scriptParentParent.Actions.MenuClosed)
local MenuOpened = require(scriptParentParent.Actions.MenuOpened)
local MomentsCreationFlowClosed = require(scriptParentParent.Actions.MomentsCreationFlowClosed)
local Networking = require(scriptParentParent.App.Networking)
local onToggleActivation = require(scriptParentParent.Utils.onToggleActivation)
local onViewportSizeChanged = CapturesCommon.Utils.onViewportSizeChanged
local CheckMomentsEligibility = require(scriptParentParent.Thunks.CheckMomentsEligibility)
local RetrieveCaptures = require(scriptParentParent.Thunks.RetrieveCaptures)
local ScreenSize = require(scriptParentParent.installReducer.ScreenSize)
local ScreenSizeChanged = require(scriptParentParent.Actions.ScreenSizeChanged)
local ServerType = require(scriptParentParent.installReducer.ServerType)
local ServerTypeDetected = require(scriptParentParent.Actions.ServerTypeDetected)
local setupFireEvent = require(scriptParentParent.Analytics.setupFireEvent)
local TakeCapture = require(scriptParentParent.Thunks.TakeCapture)
local _Types = require(scriptParentParent.Types)

local FFlagCapturesVideoCaptureTriggerHandlerEnabled = require(scriptParentParent.Flags.FFlagCapturesVideoCaptureTriggerHandlerEnabled)
local FFlagCapturesControlsGalleryButton = require(scriptParentParent.Flags.FFlagCapturesControlsGalleryButton)
local FFlagCreateMomentsToast = require(scriptParentParent.Flags.FFlagCreateMomentsToast)
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)

local FFlagCapturesInExpReportMomentsCreationUI = require(scriptParentParent.Flags.FFlagCapturesInExpReportMomentsCreationUI)
local FIntCapturesCoreGuiEventsPerMyriad = require(scriptParentParent.Flags.FIntCapturesCoreGuiEventsPerMyriad)
local engineFeature = game:GetEngineFeature("SSUIMetaLua")

local module = {}

function module.createApp(arg1)
    local module2 = {
        _momentsCreationFlowDestroyingConnection = nil,
        _momentsCreationFlowHandle = nil
    }

    local var1 = Dash.join({
        AnalyticsService = AnalyticsService,
        AppStorageService = AppStorageService,
        CaptureService = CaptureService,
        LocalizationService = LocalizationService,
        NotificationService = NotificationService,
        Players = Players,
        RbxAnalyticsService = RbxAnalyticsService,
        RobloxReplicatedStorage = RobloxReplicatedStorage,
        StarterGui = StarterGui
    }, arg1)

    local fireAnalyticsEvent = setupFireEvent({
        analytics = var1.AnalyticsService,
        infoForAllEvents = {
            isUnder13 = if var1.Players.LocalPlayer then var1.Players.LocalPlayer:GetUnder13() else nil,
            pid = tostring(game.PlaceId),
            source = Constants.AnalyticsSource,
            uid = getLocalUserId(var1.Players),
            universeId = tostring(game.GameId)
        }
    })

    local tbl1 = {
        [Constants.RoduxKey] = installReducer(),
        NetworkStatus = Networking.RoduxNetworking.installReducer(),
        ScreenSize = ScreenSize,
        ServerType = ServerType,
        ShareLinks = Networking.ShareLinksRodux.installReducer()
    }
    if MomentsCreationFlow then
        tbl1[MomentsCreationFlow.Constants.RoduxKey] = MomentsCreationFlow.installReducer()
    end
    local var3 = Rodux.combineReducers(tbl1)

    module2._store = Rodux.Store.new(var3, {}, { Rodux.thunkMiddleware })

    module2._store:dispatch(RetrieveCaptures())
    if FFlagCreateMomentsToast or FFlagMomentsCaptureEndIxpEnabled then
        module2._store:dispatch(CheckMomentsEligibility(game.GameId))
    end

    local captureSavedHandler = makeCaptureSavedHandler(module2._store, var1, fireAnalyticsEvent)
    var1.CaptureService.CaptureSavedInternal:Connect(captureSavedHandler)

    if FFlagCapturesVideoCaptureTriggerHandlerEnabled then
        local videoCaptureInProgressHandler = makeVideoCaptureInProgressHandler(module2._store, var1, fireAnalyticsEvent)

        var1.CaptureService.VideoCaptureInProgress:Connect(videoCaptureInProgressHandler)
    end

    var1.AppStorageService:WhenLoaded(function()
        local success, result = pcall(function()
            return var1.AppStorageService:GetItem(Constants.CapturesActiveLocalStorageKey)
        end)

        if not success or result == "" then
            return
        end

        if getUserIdsFromString(result)[getLocalUserId(var1.Players) or ""] then
            module2._store:dispatch(CapturesActivated())
            return
        end
        module2._store:dispatch(CapturesDeactivated())
    end)

    task.spawn(function()
        local success, result = pcall(function()
            return var1.RobloxReplicatedStorage:WaitForChild("GetServerType", math.huge):InvokeServer()
        end)
        if success then
            module2._store:dispatch(ServerTypeDetected(result))
        end
    end)

    function module2.closeMenu()
        module2._store:dispatch(MenuClosed())
    end

    function module2.openMenu()
        module2._store:dispatch(MenuOpened())

        if FFlagCapturesControlsGalleryButton then
            GetLatestCaptureStore(false).clearLatestCapture()
        end
    end

    function module2.takeCapture(arg2)
        module2._store:dispatch(TakeCapture(arg2))
    end

    local function maybeSendCoreGuiEvent(allTypeChanged: boolean, enabled: boolean)
        if FIntCapturesCoreGuiEventsPerMyriad == 0 then
            return
        end

        if Random.new():NextInteger(1, 10000) >= FIntCapturesCoreGuiEventsPerMyriad then
            return
        end

        if enabled then
            fireAnalyticsEvent(EventNames.CapturesCoreGuiEnabled, { allTypeChanged = allTypeChanged })
        else
            fireAnalyticsEvent(EventNames.CapturesCoreGuiDisabled, { allTypeChanged = allTypeChanged })
        end
    end

    var1.StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if coreGuiType ~= Enum.CoreGuiType.All and coreGuiType ~= Enum.CoreGuiType.Captures then
            return
        end

        local allTypeChanged = coreGuiType == Enum.CoreGuiType.All
        maybeSendCoreGuiEvent(allTypeChanged, enabled)

        if enabled then
            module2._store:dispatch(CapturesCoreGuiEnabled())
            return
        end
        module2._store:dispatch(CapturesCoreGuiDisabled())
    end)

    if var1.StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Captures) then
        module2._store:dispatch(CapturesCoreGuiEnabled())
    else
        module2._store:dispatch(CapturesCoreGuiDisabled())
    end

    module2.onIsActiveChanged = Signal.new()
    function module2.getIsActive()
        return module2._store:getState()[Constants.RoduxKey].IsActive or false
    end

    module2._store.changed:connect(function(arg2, arg3)
        local isActive = arg3[Constants.RoduxKey].IsActive
        local isActive2 = arg2[Constants.RoduxKey].IsActive

        if isActive2 == isActive then
            return
        end

        pcall(function()
            local item = var1.AppStorageService:GetItem(Constants.CapturesActiveLocalStorageKey)
            local userIdsFromString = getUserIdsFromString(item)
            local localUserId = getLocalUserId(var1.Players) or ""
            if isActive2 then
                userIdsFromString[localUserId] = true
            else
                userIdsFromString[localUserId] = nil
            end

            local str1 = table.concat(Dash.keys(userIdsFromString), ",")
            var1.AppStorageService:SetItem(Constants.CapturesActiveLocalStorageKey, str1)
            var1.AppStorageService:Flush()
        end)

        module2.onIsActiveChanged:fire(isActive2)
    end)

    if engineFeature then
        pcall(function()
            local SafetyService = var1.SafetyService or game:GetService("SafetyService")
            module2._store.changed:connect(function(arg2, arg3)
                local var4 = arg2[Constants.RoduxKey]
                local var5 = arg3[Constants.RoduxKey]

                local var6 = var5.IsMenuOpen or var5.Carousel and var5.Carousel.IsOpen
                local var7 = var4.IsMenuOpen or var4.Carousel and var4.Carousel.IsOpen
                if FFlagCapturesInExpReportMomentsCreationUI then
                    var6 = var6 or var5.MomentsCreationFlow.IsOpen
                    var7 = var7 or var4.MomentsCreationFlow.IsOpen
                end

                if var7 and not var6 then
                    pcall(function()
                        SafetyService:ReportCapturesUIOpen()
                    end)
                elseif not var7 and var6 then
                    pcall(function()
                        SafetyService:ReportCapturesUIClose()
                    end)
                end
            end)
        end)
    end

    onViewportSizeChanged(function(vector2: Vector2)
        module2._store:dispatch(ScreenSizeChanged(vector2))
    end)

    function module2.onToggleActivationFromChrome(...)
        local function func1(...)
            module2._store:dispatch(...)
        end

        onToggleActivation(
            module2.getIsActive(),
            nil,
            fireAnalyticsEvent,
            func1,
            EventNames.CapturesActivatedChrome,
            EventNames.CapturesDeactivatedChrome
        )
    end

    local wrapWithProviders = makeWrapWithProviders(module2._store, var1)

    local var4 = CapturesPolicy.PolicyImplementation.read()
    local var5 = if var4 then CapturesPolicy.Mapper(var4).eligibleForCapturesFeature() else false
    local var6 = if var4 then CapturesPolicy.Mapper(var4).enableCapturesBulkManagement() else false
    local tbl2 = { fireAnalyticsEvent = fireAnalyticsEvent }

    local function unmountMomentsCreationFlow()
        local _momentsCreationFlowDestroyingConnection = module2._momentsCreationFlowDestroyingConnection
        module2._momentsCreationFlowDestroyingConnection = nil
        if _momentsCreationFlowDestroyingConnection then
            _momentsCreationFlowDestroyingConnection:Disconnect()
        end

        local _momentsCreationFlowHandle = module2._momentsCreationFlowHandle
        module2._momentsCreationFlowHandle = nil
        if _momentsCreationFlowHandle then
            Roact.unmount(_momentsCreationFlowHandle)
        end

        if FFlagCapturesInExpUseMomentsCreation and module2._store:getState()[Constants.RoduxKey].MomentsCreationFlow.IsOpen then
            local momentsCreation = require(scriptParentParentParent.MomentsCreation)
            momentsCreation.resetCreationFlow(momentsCreation.Enums.CreationFlowState.Preview)
            module2._store:dispatch(MomentsCreationFlowClosed())
        end
    end

    function module2.mountCaptureManager(arg2)
        if var6 and var5 then
            module2._captureManagerHandle = wrapWithProviders(arg2, tbl2, { CaptureManager = React.createElement(CaptureManagerScreen) })
        end
    end

    function module2.mountCaptureOverlay(arg2)
        if not var5 then
            return
        end

        local tbl3 = {
            CaptureOverlay = React.createElement(CaptureOverlay)
        }

        module2._captureOverlayHandle = wrapWithProviders(arg2, tbl2, tbl3)
    end

    function module2.mountCarousel(arg2)
        if not var5 then
            return
        end

        local tbl3 = {
            CarouselScreen = React.createElement(CarouselScreen)
        }

        module2._carouselHandle = wrapWithProviders(arg2, tbl2, tbl3)
    end

    function module2.mountCoreUI(arg2, chromeEnabled: boolean?, openGallery: ((...any) -> (...any))?)
        if not var5 then
            return
        end

        local tbl3 = {
            chromeEnabled = chromeEnabled,
            fireAnalyticsEvent = fireAnalyticsEvent,
            openGallery = 0
        }

        if not FFlagCapturesControlsGalleryButton then
            openGallery = nil
        end

        tbl3.openGallery = openGallery

        module2._coreUiHandle = wrapWithProviders(arg2, tbl3, {
            CaptureServicePrompts = React.createElement(CaptureServicePrompts),
            CapturesCoreUI = React.createElement(CapturesCoreUI)
        }, "CapturesCoreUI")
    end

    function module2.mountMenuPage(arg2, closeSettingsMenu: (...any) -> (...any), chromeEnabled: boolean?)
        if not var5 then
            return
        end

        module2._menuPageHandle = wrapWithProviders(
            arg2,
            { chromeEnabled = chromeEnabled, fireAnalyticsEvent = fireAnalyticsEvent },
            {
                CapturesPage = React.createElement(CapturesPage, { closeSettingsMenu = closeSettingsMenu })
            }
        )
    end
    function module2.mountMomentsCreationFlow(arg2)
        if not FFlagCreateMomentsToast or not var5 then
            return
        end

        if FFlagCapturesInExpUseMomentsCreation and module2._momentsCreationFlowHandle then
            unmountMomentsCreationFlow()
        end

        module2._momentsCreationFlowHandle = wrapWithProviders(
            arg2,
            tbl2,
            {
                MomentsCreationFlowScreen = React.createElement(MomentsCreationFlowScreen)
            },
            nil,
            {
                withFoundationProvider = not FFlagCapturesInExpUseMomentsCreation
            }
        )
        if FFlagCapturesInExpUseMomentsCreation then
            module2._momentsCreationFlowDestroyingConnection = arg2.Destroying:Connect(unmountMomentsCreationFlow)
        end
    end

    return module2
end

return module
