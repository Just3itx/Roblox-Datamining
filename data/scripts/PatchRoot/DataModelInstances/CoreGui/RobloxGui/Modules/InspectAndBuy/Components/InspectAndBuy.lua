-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Symbol = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol
local renderWithCoreScriptsStyleProvider = require(CoreGui.RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)
local SelectionCursorProvider = require(CorePackages.Packages.UIBlox).App.SelectionImage.SelectionCursorProvider
local IxpUtils = require(CorePackages.Workspace.Packages.IxpUtils)
local str1 = game:DefineFastString("AXInspectAndBuyLayerName", "Experience.Menu")
local bool1 = game:DefineFastFlag("AXEnableInspectAndBuyExposureLogging", false)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider

local Chrome = RobloxGui.Modules.Chrome
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local Service = if ChromeEnabled() then require(Chrome.Service) else nil
local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local scriptParentParent = script.Parent.Parent
local SetDetailsInformation = require(scriptParentParent.Actions.SetDetailsInformation)
local SetTryingOnInfo = require(scriptParentParent.Actions.SetTryingOnInfo)
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local Analytics = require(scriptParentParent.Services.Analytics)
local InspectAndBuyReducer = require(scriptParentParent.Reducers.InspectAndBuyReducer)
local Container = require(scriptParentParent.Components.Container)
local InspectAndBuyBaseContainer = require(scriptParentParent.Components.InspectAndBuyBaseContainer)
local Constants = require(scriptParentParent.Constants)
local CompactView = require(scriptParentParent.CompactView)
local WideView = require(scriptParentParent.WideView)
local WideLandscapeView = require(scriptParentParent.WideLandscapeView)
local SetGamepadEnabled = require(scriptParentParent.Actions.SetGamepadEnabled)
local SetView = require(scriptParentParent.Actions.SetView)
local SetPlayerId = require(scriptParentParent.Actions.SetPlayerId)
local SetPlayerName = require(scriptParentParent.Actions.SetPlayerName)
local SetLocale = require(scriptParentParent.Actions.SetLocale)
local SetItemBeingPurchased = require(scriptParentParent.Actions.SetItemBeingPurchased)
local SetIsSubjectToChinaPolicies = require(scriptParentParent.Actions.SetIsSubjectToChinaPolicies)
local UpdateStoreId = require(scriptParentParent.Actions.UpdateStoreId)
local var1 = if require(scriptParentParent.Flags.FFlagAXEnableFetchAvatarPreview) then require(scriptParentParent.Thunks.GetAssetsFromHumanoidDescriptionV2) else require(scriptParentParent.Thunks.GetAssetsFromHumanoidDescription)
local UpdateOwnedStatus = require(scriptParentParent.Thunks.UpdateOwnedStatus)
local ReportPurchaseSuccessUnifiedEvent = require(scriptParentParent.Thunks.ReportPurchaseSuccessUnifiedEvent)
local FFlagAXIaBSinglePurchaseUnifiedEvents = require(scriptParentParent.Flags.FFlagAXIaBSinglePurchaseUnifiedEvents)
local GetCharacterModelFromUserId = require(scriptParentParent.Thunks.GetCharacterModelFromUserId)
local GetPlayerName = require(scriptParentParent.Thunks.GetPlayerName)
local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local CloseOverlay = require(scriptParentParent.Actions.CloseOverlay)
local AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local getViewType = AvatarExperienceInspectAndBuy.Utils.getViewType
local InspectAndBuyVersion = AvatarExperienceInspectAndBuy.Enums.InspectAndBuyVersion
local AvatarExperienceFlags = require(CorePackages.Workspace.Packages.AvatarExperienceFlags)

local FFlagEnableInspectAndBuyV2RootFlag = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableInspectAndBuyV2RootFlag

local FFlagAXEnableInspectAndBuyVersionAnalytics = require(scriptParentParent.Flags.FFlagAXEnableInspectAndBuyVersionAnalytics)
local FFlagAXEnableInspectAndBuyFocusNavigation = AvatarExperienceFlags.FFlagAXEnableInspectAndBuyFocusNavigation
local FFlagAXInspectAndBuyAvatarBackground = AvatarExperienceFlags.FFlagAXInspectAndBuyAvatarBackground

local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local FFlagAXEnableNewInspectAndBuyContainer = require(scriptParentParent.Flags.FFlagAXEnableNewInspectAndBuyContainer)

local OverrideCursorInspectMenu = Symbol.named("OverrideCursorInspectMenu")

local var2 = Roact.PureComponent:extend("InspectAndBuy")

function var2.pushMouseIconOverride(_)
    if UserInputService:GetLastInputType().Name:find("Gamepad") then
        MouseIconOverrideService.push(OverrideCursorInspectMenu, Enum.OverrideMouseIconBehavior.ForceHide)
        return
    end
    MouseIconOverrideService.push(OverrideCursorInspectMenu, Enum.OverrideMouseIconBehavior.ForceShow)
end

function var2.popMouseIconOverride(_)
    MouseIconOverrideService.pop(OverrideCursorInspectMenu)
end

function var2.configureInputType(arg1, arg2)
    if (arg2 or UserInputService:GetLastInputType()).Name:find("Gamepad") then
        arg1.state.store:dispatch(SetGamepadEnabled(true))
        return
    end
    arg1.state.store:dispatch(SetGamepadEnabled(false))
end

function var2.updateView(arg1)
    local viewportSize = workspace.CurrentCamera.ViewportSize

    if FFlagAXEnableNewInspectAndBuyContainer then
        arg1.state.store:dispatch(SetView(getViewType(viewportSize)))
        return
    end
    local wide = Constants.View.Wide

    if viewportSize.X < 600 then
        wide = Constants.View.Compact
    elseif viewportSize.X > viewportSize.Y and viewportSize.X < 800 then
        wide = Constants.View.WideLandscape
    end

    arg1.state.store:dispatch(SetView(wide))
end

function var2.init(arg1)
    local playerId = arg1.props.playerId
    local playerName = arg1.props.playerName
    local ctx = arg1.props.ctx
    arg1.connections = {}
    arg1.network = arg1.props.network or Network.new()
    local analytics = if FFlagAXEnableInspectAndBuyVersionAnalytics then Analytics.new(
        playerId,
        ctx,
        if FFlagEnableInspectAndBuyV2RootFlag then InspectAndBuyVersion.Version2 else InspectAndBuyVersion.Version1
    ) else Analytics.new(playerId, ctx)
    arg1.analytics = analytics

    arg1.humanoidDescription = arg1.props.humanoidDescription

    arg1.analytics.reportOpenInspectMenu()

    arg1.state = {
        store = Rodux.Store.new(
            InspectAndBuyReducer,
            {},
            { Thunk.middleware({ [Network] = arg1.network, [Analytics] = arg1.analytics }) }
        ),
        views = {
            [Constants.View.Compact] = CompactView,
            [Constants.View.Wide] = WideView,
            [Constants.View.WideLandscape] = WideLandscapeView
        }
    }

    arg1.state.store:dispatch(UpdateStoreId())

    arg1.state.store:dispatch(SetPlayerName(playerName))
    arg1.state.store:dispatch(SetLocale(LocalizationService.RobloxLocaleId))

    if playerId then
        arg1.state.store:dispatch(SetPlayerId(playerId))
    end

    if arg1.humanoidDescription then
        arg1.state.store:dispatch(var1(arg1.humanoidDescription, false))
    end

    function arg1.onPromptPurchaseFinished(_, arg2, arg3)
        local itemBeingPurchased = arg1.state.store:getState().itemBeingPurchased

        arg1.analytics.sendCounter(Constants.Counters.PurchaseFinished)
        if arg3 and tostring(arg2) == itemBeingPurchased.itemId then
            if FFlagAXIaBSinglePurchaseUnifiedEvents then
                arg1.state.store:dispatch(
                    ReportPurchaseSuccessUnifiedEvent(
                        itemBeingPurchased.itemId,
                        itemBeingPurchased.itemType,
                        itemBeingPurchased.resalePrice
                    )
                )
            else
                arg1.analytics.reportPurchaseSuccess(itemBeingPurchased.itemType, itemBeingPurchased.itemId)
            end
            arg1.state.store:dispatch(UpdateOwnedStatus(itemBeingPurchased.itemId, itemBeingPurchased.itemType))

            if itemBeingPurchased.itemType == Constants.ItemType.Asset then
                arg1.analytics.sendCounter(Constants.Counters.PurchaseSucceededAsset)
            elseif itemBeingPurchased.itemType == Constants.ItemType.Bundle then
                arg1.analytics.sendCounter(Constants.Counters.PurchaseSucceededBundle)
            else
                arg1.analytics.sendCounter(Constants.Counters.PurchaseSucceededOther)
            end
        end
        arg1.state.store:dispatch(SetItemBeingPurchased(nil, nil))
    end
end

function var2.didMount(arg1)
    local playerId = arg1.props.playerId
    arg1.isMounted = true
    arg1:updateView()
    arg1:bindButtonB()
    arg1:configureInputType()
    arg1:pushMouseIconOverride()

    if bool1 then
        IxpUtils.logLayerExposure(str1)
    end

    if FFlagEnableConsoleExpControls and ChromeEnabled() then
        Service:setHideShortcutBar("InspectAndBuy", true)
    end

    local connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        arg1:configureInputType(lastInputType)
    end)

    local connection2 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        arg1:updateView()
    end)

    local connection3 = LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
        arg1.state.store:dispatch(SetLocale(LocalizationService.RobloxLocaleId))
    end)

    local connection4 = GuiService.MenuOpened:Connect(function()
        arg1:popMouseIconOverride()
        GuiService.SelectedCoreObject = nil
    end)

    local connection5 = GuiService.MenuClosed:Connect(function()
        arg1:pushMouseIconOverride()
    end)

    coroutine.wrap(function()
        local isSubjectToChinaPolicies = CachedPolicyService:IsSubjectToChinaPolicies()
        arg1.state.store:dispatch(SetIsSubjectToChinaPolicies(isSubjectToChinaPolicies))
    end)()

    local connection6 = MarketplaceService.PromptPurchaseFinished:Connect(arg1.onPromptPurchaseFinished)

    local connection7 = MarketplaceService.PromptBundlePurchaseFinished:Connect(arg1.onPromptPurchaseFinished)

    local connection8 = arg1.state.store.changed:connect(function(arg2, arg3)
        arg1:update(arg2, arg3)
    end)

    table.insert(arg1.connections, connection2)
    table.insert(arg1.connections, connection3)
    table.insert(arg1.connections, connection4)
    table.insert(arg1.connections, connection5)
    table.insert(arg1.connections, connection)
    table.insert(arg1.connections, connection6)
    table.insert(arg1.connections, connection7)
    table.insert(arg1.connections, connection8)

    local userId = Players.LocalPlayer.UserId
    arg1.state.store:dispatch(GetCharacterModelFromUserId(userId, true, function(localPlayerModel)
        if not arg1 or not arg1.isMounted then
            return
        end

        arg1.localPlayerModel = localPlayerModel
        local humanoidDescription = localPlayerModel.Humanoid.HumanoidDescription

        if humanoidDescription then
            arg1.state.store:dispatch(var1(humanoidDescription, true))
        end

        arg1:setState({ obtainedLocalPlayerModel = true })
    end))

    if not playerId then
        return
    end

    arg1.state.store:dispatch(GetCharacterModelFromUserId(playerId, false, function(playerModel)
        if not arg1 or not arg1.isMounted then
            return
        end

        arg1.playerModel = playerModel
        local humanoidDescription = arg1.playerModel.Humanoid.HumanoidDescription

        if humanoidDescription then
            arg1.state.store:dispatch(var1(humanoidDescription, false, FFlagAXInspectAndBuyAvatarBackground and function()
                return arg1.isMounted
            end or nil))
        end

        arg1:setState({ obtainedPlayerModel = true })
    end))

    arg1.state.store:dispatch(GetPlayerName(playerId))
end

function var2.update(arg1, arg2, arg3)
    if not arg2.visible and arg3.visible then
        ContextActionService:UnbindCoreAction("BackButtonInspectMenu")
    elseif arg2.visible and not arg3.visible then
        arg1:bindButtonB()
    end
end

function var2.willUnmount(arg1)
    arg1.isMounted = false
    for _, connection in pairs(arg1.connections) do
        connection:disconnect()
    end

    ContextActionService:UnbindCoreAction("BackButtonInspectMenu")
    arg1:popMouseIconOverride()

    if FFlagEnableConsoleExpControls and ChromeEnabled() then
        Service:setHideShortcutBar("InspectAndBuy", false)
    end
end

function var2.render(arg1)
    local localPlayerModel = arg1.localPlayerModel

    if not FFlagAXEnableNewInspectAndBuyContainer then
        return Roact.createElement(InspectAndBuyContext.Provider, {
            value = arg1.state.views
        }, {
            StoreProvider = Roact.createElement(RoactRodux.StoreProvider, {
                store = arg1.state.store
            }, {
                ThemeProvider = renderWithCoreScriptsStyleProvider({
                    CursorProvider = Roact.createElement(
                        SelectionCursorProvider,
                        {},
                        {
                            Container = Roact.createElement(Container, { localPlayerModel = localPlayerModel })
                        }
                    )
                })
            })
        })
    end

    local createElement = Roact.createElement
    local str2 = "Folder"
    local tbl1 = { Name = "InspectAndBuyApp" }
    local tbl2 = { CoreScriptsRootProvider = 0 }
    local createElement2 = Roact.createElement
    local var3 = CoreScriptsRootProvider
    local tbl3 = {}
    local tbl4

    if FFlagAXEnableInspectAndBuyFocusNavigation then
        tbl4 = { StoreProvider = 0 }
        local createElement3 = Roact.createElement
        local storeProvider = RoactRodux.StoreProvider
        local tbl5 = {
            store = arg1.state.store
        }
        local tbl6 = {
            Container = Roact.createElement(InspectAndBuyBaseContainer, {
                localPlayerModel = localPlayerModel,
                analytics = arg1.analytics,
                playerId = if FFlagAXInspectAndBuyAvatarBackground then arg1.props.playerId else nil
            })
        }
        tbl4.StoreProvider = createElement3(storeProvider, tbl5, tbl6)
    else
        tbl4 = { FocusNavigationWrapper = 0 }
        local createElement3 = Roact.createElement
        local var4 = FocusRoot
        local tbl5 = {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay
        }
        local tbl6 = { StoreProvider = 0 }
        local createElement4 = Roact.createElement
        local storeProvider = RoactRodux.StoreProvider
        local tbl7 = {
            store = arg1.state.store
        }
        local tbl8 = {
            Container = Roact.createElement(InspectAndBuyBaseContainer, {
                localPlayerModel = localPlayerModel,
                analytics = arg1.analytics,
                playerId = if FFlagAXInspectAndBuyAvatarBackground then arg1.props.playerId else nil
            })
        }
        tbl6.StoreProvider = createElement4(storeProvider, tbl7, tbl8)
        tbl4.FocusNavigationWrapper = createElement3(var4, tbl5, tbl6)
    end

    tbl2.CoreScriptsRootProvider = createElement2(var3, tbl3, tbl4)
    return createElement(str2, tbl1, tbl2)
end

function var2.bindButtonB(arg1)
    ContextActionService:BindCoreAction("BackButtonInspectMenu", function(_, userInputState, arg2)
        if userInputState == Enum.UserInputState.End and arg2.KeyCode == Enum.KeyCode.ButtonB then
            local state = arg1.state.store:getState()
            local viewingDetails = state.detailsInformation.viewingDetails

            if state.overlay and state.overlay.overlay ~= nil then
                arg1.state.store:dispatch(CloseOverlay())
            elseif viewingDetails then
                arg1.state.store:dispatch(SetDetailsInformation(false, nil))
                arg1.state.store:dispatch(SetTryingOnInfo(false, nil))
            else
                GuiService:CloseInspectMenu()
            end
        elseif userInputState == Enum.UserInputState.Begin and arg2.KeyCode == Enum.KeyCode.Escape
            or arg2.KeyCode == Enum.KeyCode.ButtonStart
        then
            GuiService:CloseInspectMenu()
            return Enum.ContextActionResult.Pass
        end

        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape, Enum.KeyCode.ButtonStart)
end

return var2
