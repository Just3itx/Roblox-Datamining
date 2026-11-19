-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local Utility = require(RobloxGui.Modules.Settings.Utility)
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local React = require(CorePackages.Packages.React)
local useEventConnection = require(CorePackages.Packages.ReactUtils).useEventConnection
local Constants = UIBlox.App.Style.Constants
local ApolloClient = require(CoreGui.RobloxGui.Modules.ApolloClient)
local ApolloProvider = require(CorePackages.Packages.ApolloClient).ApolloProvider
local scriptParent = script.Parent
local Signals = require(CorePackages.Packages.Signals)
local InExperienceTopBar = require(CorePackages.Workspace.Packages.InExperienceTopBar)

local Reducer = require(scriptParent.Reducers.Reducer)
local GlobalConfig = require(scriptParent.GlobalConfig)
local PlayerListSwitcher = require(scriptParent.PlayerListSwitcher)
local MakePlayerInfoRequests = require(scriptParent.Thunks.MakePlayerInfoRequests)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local PlatformLeaderboardsClient = require(CorePackages.Workspace.Packages.PlatformLeaderboardsClient)
local PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore)
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local Constants2 = PlayerList.Common.Constants
local PlayerRelationshipStore = PlayerList.PlayerRelationshipStore
local PlayerListPanel = PlayerList.Presentation.PlayerListPanel
local PlayerContextualMenuView = PlayerList.Presentation.PlayerContextualMenuView
local LeaderboardScrim = PlayerList.Presentation.LeaderboardScrim

local SetPlayerListEnabled = require(scriptParent.Actions.SetPlayerListEnabled)
local SetPlayerListVisibility = require(scriptParent.Actions.SetPlayerListVisibility)
local SetTempHideKey = require(scriptParent.Actions.SetTempHideKey)
local SetTenFootInterface = require(scriptParent.Actions.SetTenFootInterface)
local SetSmallTouchDevice = require(scriptParent.Actions.SetSmallTouchDevice)
local SetIsUsingGamepad = require(scriptParent.Actions.SetIsUsingGamepad)
local SetMinimized = require(scriptParent.Actions.SetMinimized)
local SetSubjectToChinaPolicies = require(scriptParent.Actions.SetSubjectToChinaPolicies)
local SetSettings = require(scriptParent.Actions.SetSettings)

if not Players.LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end

local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FStringPlayerListOverrideType = require(scriptParent.Flags.FStringPlayerListOverrideType)

local FFlagReplacePlayerIconRoduxWithSignal = require(CorePackages.Workspace.Packages.SharedFlags).FFlagReplacePlayerIconRoduxWithSignal

local FFlagBadgeVisibilitySettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBadgeVisibilitySettingEnabled

local FFlagLuaSupportMicroGamepadPreferredInput = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagEnableMobilePlayerListOnGamepad = PlayerList.Flags.FFlagEnableMobilePlayerListOnGamepad
local isReskinConsoleMobileRoute = PlayerList.Common.isReskinConsoleMobileRoute
local FFlagPlayerListUseMobileOnSmallDisplay = PlayerList.Flags.FFlagPlayerListUseMobileOnSmallDisplay
local FFlagPlayerListIgnoreDevGamepadBindings = PlayerList.Flags.FFlagPlayerListIgnoreDevGamepadBindings

local FFlagPlatformLeaderboardPersistStoreOnRemount = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlatformLeaderboardPersistStoreOnRemount

local FFlagPlayerListReskin = PlayerList.Flags.FFlagPlayerListReskin
local FFlagPlayerListContrastingTeamText = PlayerList.Flags.FFlagPlayerListContrastingTeamText
local FFlagPlayerListPersistVisibility = require(scriptParent.Flags.FFlagPlayerListPersistVisibility)

local PlayerListContainer = PlayerList.Container.PlayerListContainer
local LeaderboardStoreInstanceManager = PlayerList.LeaderboardStoreInstanceManager
local PlayerListVisibilityStore = PlayerList.PlayerListVisibilityStore
local PlayerContextualMenuStore = PlayerList.PlayerContextualMenuStore
local PlayerIconInfoStore2 = PlayerIconInfoStore.PlayerIconInfoStore

local FFlagTopBarSignalizeSetCores = InExperienceTopBar.Flags.FFlagTopBarSignalizeSetCores

local function isUnderTestEZ(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return _G.__TESTEZ_RUNNING_TEST__ == true
end

local function isTouchOrGamepadInput(preferredInput) -- Luacid: Inlined by compiler; 12 call sites recovered
    return preferredInput == Enum.PreferredInput.Touch
        or preferredInput == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and preferredInput == Enum.PreferredInput.MicroGamepad
end

local function isCurrentReskinConsoleMobileRoute(preferredInput) -- Luacid: Inlined by compiler; 13 call sites recovered
    return isReskinConsoleMobileRoute({ displaySize = GuiService.ViewportDisplaySize, preferredInput = preferredInput })
end

local function resolveIsTenFoot(preferredInput) -- Luacid: Inlined by compiler; 4 call sites recovered
    if isCurrentReskinConsoleMobileRoute(preferredInput) or FFlagEnableMobilePlayerListOnConsole then
        return false
    end

    return (TenFootInterface:IsEnabled())
end

local function isLargeConsoleLayout(preferredInput) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if isCurrentReskinConsoleMobileRoute(preferredInput) then true elseif GuiService.ViewportDisplaySize == Enum.DisplaySize.Large and isTouchOrGamepadInput(preferredInput) then FFlagEnableMobilePlayerListOnConsole else false
end

local function isSmallTouchScreen(preferredInput) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = FFlagPlayerListUseMobileOnSmallDisplay and GuiService.ViewportDisplaySize == Enum.DisplaySize.Small
    return Utility:IsSmallTouchScreen()
        or isLargeConsoleLayout(preferredInput)
        or var1 and isTouchOrGamepadInput(preferredInput)
        or FStringPlayerListOverrideType == "mobile"
end

local function setupSettings(store)
    local function updateSettings() -- Luacid: Inlined by compiler; 3 call sites recovered
        store:dispatch(
            SetSettings(
                {
                    reducedMotion = UserGameSettings.ReducedMotion,
                    preferredTransparency = UserGameSettings.PreferredTransparency
                }
            )
        )
    end

    updateSettings()

    UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
        updateSettings()
    end)

    UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(function()
        updateSettings()
    end)
end

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)

    if FFlagPlayerListReskin then
        return self:_setupReskin()
    end

    if GlobalConfig.propValidation then
        Roact.setGlobalConfig({ propValidation = true })
    end

    if GlobalConfig.elementTracing then
        Roact.setGlobalConfig({ elementTracing = true })
    end

    self.layerCollectorRef = Roact.createRef()

    self.store = Rodux.Store.new(Reducer, nil, { Rodux.thunkMiddleware })

    setupSettings(self.store)

    if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
        self.store:dispatch(SetPlayerListEnabled(false))
    end

    coroutine.wrap(function()
        self.store:dispatch(SetSmallTouchDevice((isSmallTouchScreen(UserInputService.PreferredInput))))
    end)()

    self.store:dispatch(SetTenFootInterface((resolveIsTenFoot(UserInputService.PreferredInput))))

    coroutine.wrap(function()
        self.store:dispatch(SetSubjectToChinaPolicies(CachedPolicyService:IsSubjectToChinaPolicies()))
    end)()

    self:_trackEnabled()

    local appStyleForUiModeStyleProvider = {
        themeName = ColorMode.Dark,
        fontName = Constants.FontName.Gotham
    }

    self.root = Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        Switcher = Roact.createElement(PlayerListSwitcher, {
            appStyleForUiModeStyleProvider = appStyleForUiModeStyleProvider,
            setLayerCollectorEnabled = function(enabled)
                if not self.layerCollectorRef.current then
                    return
                end
                self.layerCollectorRef.current.Enabled = enabled
            end
        })
    })

    self.root = Roact.createElement(ApolloProvider, { client = ApolloClient }, { StoreProvider = self.root })

    function self._setIsUsingGamepad()
        local userInputType = UserInputService:GetLastInputType()
        local var1 = userInputType and userInputType.Name:find("Gamepad")
        self.store:dispatch(SetIsUsingGamepad(var1 ~= nil))
    end

    function self._mountLeaderboardStore()
        LeaderboardStoreInstanceManager.createLeaderboardStoreInstance()
    end

    function self._unmountLeaderboardStore()
        LeaderboardStoreInstanceManager.cleanUpInstance()
    end

    self._unmountPlayerIconInfoStore = FFlagReplacePlayerIconRoduxWithSignal and function()
        PlayerIconInfoStore2.cleanUp()
    end or nil

    self._mountLeaderboardStore()
    self._setIsUsingGamepad()
    self.root = Roact.createElement(PlayerListContainer, {
        leaderboardStore = LeaderboardStoreInstanceManager.getLeaderboardStoreInstance,
        TopBarConstants = require(RobloxGui.Modules.TopBar.Constants),
        isTenFoot = resolveIsTenFoot(UserInputService.PreferredInput)
    }, {
        PlayerListRoot = self.root
    })

    local createElement = Roact.createElement
    local tbl2 = {
        AutoLocalize = false,
        IgnoreGuiInset = true,
        DisplayOrder = 1,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        [Roact.Ref] = self.layerCollectorRef
    }
    self.root = createElement("ScreenGui", tbl2, { PlayerListRoot = self.root })

    self.element = Roact.mount(self.root, CoreGui, "PlayerList")

    self.topBarEnabled = true
    self.mounted = true
    self.coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)
    self:_updateMounted()

    self.SetVisibleChangedEvent = Instance.new("BindableEvent")
    if FFlagAddNewPlayerListFocusNav then
        self.VisibilityChangedEvent = Instance.new("BindableEvent")
    end

    if FFlagTopBarSignalizeSetCores then
        self.disposeEffect = Signals.createEffect(function(arg1)
            local getTopBarStore = InExperienceTopBar.Stores.GetTopBarStore
            if getTopBarStore then
                self:SetTopBarEnabled(getTopBarStore(arg1).getTopBarCoreGuiEnabled(arg1))
            end
        end)
    end

    self.store.changed:connect(function(arg1, arg2)
        if arg1.displayOptions.setVisible ~= arg2.displayOptions.setVisible then
            self.SetVisibleChangedEvent:Fire(arg1.displayOptions.setVisible)
        end
        if FFlagAddNewPlayerListFocusNav and arg1.displayOptions.isVisible ~= arg2.displayOptions.isVisible then
            self.VisibilityChangedEvent:Fire(arg1.displayOptions.isVisible)
        end
    end)

    return self
end

function module:_updateMounted()
    if resolveIsTenFoot(UserInputService.PreferredInput) then
        return
    end

    local topBarEnabled = self.coreGuiEnabled and self.topBarEnabled
    if topBarEnabled and not self.mounted then
        self._mountLeaderboardStore()
        self._setIsUsingGamepad()
        self.element = Roact.mount(self.root, CoreGui, "PlayerList")
        self.mounted = true
        return
    end

    if topBarEnabled or not self.mounted then
        return
    end

    Roact.unmount(self.element)
    self._unmountLeaderboardStore()
    if self._unmountPlayerIconInfoStore then
        self._unmountPlayerIconInfoStore()
    end
    self.mounted = false
    if self.inspector then
        self.inspector:destroy()
        self.inspector = nil
    end
end

function module:_trackEnabled()
    StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if coreGuiType ~= Enum.CoreGuiType.All and coreGuiType ~= Enum.CoreGuiType.PlayerList then
            return
        end

        self.coreGuiEnabled = enabled
        self:_updateMounted()
        self.store:dispatch(SetPlayerListEnabled(enabled))
        if FFlagPlayerListIgnoreDevGamepadBindings and not enabled then
            GuiService:SetMenuIsOpen(false, Constants2.PLAYER_LIST_MENU)
        end
    end)
end

if FFlagAddNewPlayerListMobileFocusNav then
    function module:GetIsModal()
        if FFlagPlayerListReskin then
            return (isSmallTouchScreen(UserInputService.PreferredInput))
        end
        return self.store:getState().displayOptions.isSmallTouchDevice
    end
end

local PreferredTransparencyChanged = UserGameSettings:GetPropertyChangedSignal("PreferredTransparency")
local function ReskinElement(arg1)
    assert(
        FFlagPlayerListContrastingTeamText,
        "ReskinElement is only supported when FFlagPlayerListContrastingTeamText is on"
    )

    local preferredTransparency, var2 = React.useState(UserGameSettings.PreferredTransparency)
    useEventConnection(PreferredTransparencyChanged, function()
        var2(UserGameSettings.PreferredTransparency)
    end, { PreferredTransparencyChanged })

    local tbl1 = {
        Scrim = React.createElement(LeaderboardScrim, { isSmallTouchDevice = arg1.isSmallTouchDevice }),
        Container = React.createElement(Foundation.View, arg1.resolveContainerProps(), {
            ReskinContainer = React.createElement(PlayerListContainer, {
                leaderboardStore = LeaderboardStoreInstanceManager.getLeaderboardStoreInstance,
                TopBarConstants = arg1.TopBarConstants,
                isTenFoot = arg1.isTenFoot
            }, {
                PlayerListPanel = React.createElement(PlayerListPanel, { isSmallTouchDevice = arg1.isSmallTouchDevice, title = arg1.leaderboardTitle })
            })
        }),
        ContextMenu = React.createElement(PlayerContextualMenuView, { isSmallTouchDevice = arg1.isSmallTouchDevice })
    }

    return React.createElement(FoundationProvider, {
        colorMode = ColorMode.Dark,
        device = arg1.foundationDevice,
        preferences = { preferredTransparency = preferredTransparency }
    }, tbl1)
end

local function createReskinElement(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(ReskinElement, arg1)
end

function module:_setupReskin()
    local react = require(CorePackages.Packages.React)
    local reactRoblox = require(CorePackages.Packages.ReactRoblox)
    local constants = require(RobloxGui.Modules.TopBar.Constants)
    local foundation = require(CorePackages.Packages.Foundation)
    local foundationProvider = foundation.FoundationProvider
    local colorMode = foundation.Enums.ColorMode
    local device = foundation.Enums.Device
    local robloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
    local contextMenuController = require(scriptParent.ContextMenuController)

    local function translate(str1: string, str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local success, result = pcall(function()
            return robloxTranslator:FormatByKey(str1)
        end)
        return if success and result and result ~= "" then result else str2
    end

    local var1 = translate("InGame.PlayerList.Leaderboard", "Leaderboard")

    local preferredInput = UserInputService.PreferredInput
    local isTenFoot = resolveIsTenFoot(preferredInput)
    local var3 = FFlagPlayerListUseMobileOnSmallDisplay and GuiService.ViewportDisplaySize == Enum.DisplaySize.Small
    local isSmallTouchScreen2 = Utility:IsSmallTouchScreen()

    if not isSmallTouchScreen2 then
        if isCurrentReskinConsoleMobileRoute(preferredInput) then
            isSmallTouchScreen2 = true
        elseif GuiService.ViewportDisplaySize ~= Enum.DisplaySize.Large or not isTouchOrGamepadInput(preferredInput) then
            isSmallTouchScreen2 = false
        else
            isSmallTouchScreen2 = FFlagEnableMobilePlayerListOnConsole
        end

        if not isSmallTouchScreen2 then
            local bool1 = false

            if var3 then
                isSmallTouchScreen2 = true

                if preferredInput ~= Enum.PreferredInput.Touch then
                    isSmallTouchScreen2 = true
                    if preferredInput ~= Enum.PreferredInput.Gamepad then
                        isSmallTouchScreen2 = FFlagLuaSupportMicroGamepadPreferredInput
                        isSmallTouchScreen2 = isSmallTouchScreen2 and preferredInput == Enum.PreferredInput.MicroGamepad
                    end
                end

                bool1 = isSmallTouchScreen2
            end

            if not bool1 then
                isSmallTouchScreen2 = FStringPlayerListOverrideType == "mobile"
            end
        end
    end

    local var4 = if isTenFoot or isLargeConsoleLayout(preferredInput) then device.Console else device.Unknown

    local function restoreVisibilityOnDismiss()
        if PlayerContextualMenuStore.takeSuppressNextDismissRestore() then
            return
        end
        PlayerListVisibilityStore.setVisible(true)
    end

    if isSmallTouchScreen2 then
        PlayerContextualMenuStore.setOnDismiss(restoreVisibilityOnDismiss)
    end

    PlayerContextualMenuStore.setContextMenuOpener(function(arg1, anchorPosition, arg2, arg3)
        task.spawn(function()
            local menuData = contextMenuController.buildMenuData(arg1, PlayerContextualMenuStore.closeContextMenu, isSmallTouchScreen2, arg3)

            if arg1.Parent == nil then
                return
            end

            menuData.anchorPosition = anchorPosition
            PlayerContextualMenuStore.setMenuDataIfCurrent(menuData, arg2)
        end)
    end)

    local playerListInitialVisibleState = require(scriptParent.PlayerListInitialVisibleState)
    PlayerListVisibilityStore.reset()
    if FFlagPlatformLeaderboardPersistStoreOnRemount then
        PlatformLeaderboardsClient.reset()
    end
    local function setStorePersistVisibility() -- Luacid: Inlined by compiler; 3 call sites recovered
        PlayerListVisibilityStore.setShouldPersistVisibility(
            FFlagPlayerListPersistVisibility and not (isSmallTouchScreen2 or isTenFoot)
        )
    end

    setStorePersistVisibility()
    PlayerListVisibilityStore.setVisible(playerListInitialVisibleState())

    self.SetVisibleChangedEvent = Instance.new("BindableEvent")
    self.VisibilityChangedEvent = Instance.new("BindableEvent")

    local function setupVisibilityEffect()
        local bool1 = false
        self._reskinSetVisibleEffect = Signals.createEffect(function(arg1)
            local visible = PlayerListVisibilityStore.getVisible(arg1)
            if bool1 then
                self.SetVisibleChangedEvent:Fire(visible)
                return
            end
            bool1 = true
        end)

        local bool2 = false
        self._reskinVisibilityEffect = Signals.createEffect(function(arg1)
            local effectiveVisible = PlayerListVisibilityStore.getEffectiveVisible(arg1)
            if bool2 then
                self.VisibilityChangedEvent:Fire(effectiveVisible)
                return
            end
            bool2 = true
        end)
    end

    local topBarHeight = constants.TopBarHeight

    local function computeMobileTopInset(): number -- Luacid: Inlined by compiler; 1 call site recovered
        local mobileEdgeGap = Constants2.MOBILE_EDGE_GAP
        return math.max(mobileEdgeGap, constants.ApplyDisplayScale(mobileEdgeGap))
    end
    local function computeMobilePosition()
        return UDim2.new(0.5, 0, 0, topBarHeight + computeMobileTopInset())
    end
    local var5, var6 = react.createBinding(computeMobilePosition())
    local function resolveContainerProps()
        if isSmallTouchScreen2 then
            return {
                AnchorPoint = Vector2.new(0.5, 0),
                Position = var5,
                Size = UDim2.fromOffset(0, 0),
                tag = "auto-xy"
            }
        end

        local num1 = math.max(4, constants.ApplyDisplayScale(4))
        return {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -num1, 0, num1 + topBarHeight),
            Size = UDim2.fromOffset(0, 0),
            tag = "auto-xy"
        }
    end

    local function buildReskinElement()
        return react.createElement(foundationProvider, {
            colorMode = colorMode.Dark,
            device = var4,
            preferences = {
                preferredTransparency = UserGameSettings.PreferredTransparency
            }
        }, {
            Scrim = react.createElement(LeaderboardScrim, { isSmallTouchDevice = isSmallTouchScreen2 }),
            Container = react.createElement(foundation.View, resolveContainerProps(), {
                ReskinContainer = react.createElement(
                    PlayerListContainer,
                    {
                        leaderboardStore = LeaderboardStoreInstanceManager.getLeaderboardStoreInstance,
                        TopBarConstants = constants,
                        isTenFoot = isTenFoot
                    },
                    {
                        PlayerListPanel = react.createElement(PlayerListPanel, { isSmallTouchDevice = isSmallTouchScreen2, title = var1 })
                    }
                )
            }),
            ContextMenu = react.createElement(PlayerContextualMenuView, { isSmallTouchDevice = isSmallTouchScreen2 })
        })
    end

    local function setupPlayerInfoRequests()
        local tbl1 = {
            getState = function()
                return {
                    players = Players:GetPlayers()
                }
            end,
            dispatch = function(_, arg1)
                if type(arg1) ~= "table" then
                    return
                end

                if arg1.type == "SetPlayerIsBlocked" and arg1.userId then
                    PlayerRelationshipStore.patchPlayerRelationship(arg1.userId, { isBlocked = arg1.isBlocked })
                elseif arg1.type == "SetPlayerFriendStatus" and arg1.userId then
                    PlayerRelationshipStore.patchPlayerRelationship(arg1.userId, { friendStatus = arg1.friendStatus })
                end
            end
        }

        local function request(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            MakePlayerInfoRequests(arg1)(tbl1)
        end
        for _, player in ipairs(Players:GetPlayers()) do
            request(player)
        end

        self._reskinPlayerAddedConn = Players.PlayerAdded:Connect(request)
        self._reskinPlayerRemovingConn = Players.PlayerRemoving:Connect(function(player: Player)
            PlayerIconInfoStore2.removePlayer(player.UserId)
            PlayerRelationshipStore.removePlayer(player.UserId)
        end)
        local function refreshOpenMenuForPlayer(player: Player, friendStatus: Enum.FriendStatus) -- Luacid: Inlined by compiler; 1 call site recovered
            local menuData = PlayerContextualMenuStore.getMenuData(false)
            if menuData ~= nil and menuData.player == player then
                PlayerContextualMenuStore.openContextMenu(player, menuData.anchorPosition, friendStatus)
            end
        end

        self._reskinBlockedStatusConn = BlockingUtility:GetBlockedStatusChangedEvent():Connect(function(arg1, isBlocked)
            local var7 = tonumber(arg1)
            if var7 then
                PlayerRelationshipStore.patchPlayerRelationship(var7, { isBlocked = isBlocked })
            end
        end)
        self._reskinFriendStatusConn = Players.LocalPlayer.FriendStatusChanged:Connect(function(player: Player, friendStatus: Enum.FriendStatus)
            PlayerRelationshipStore.patchPlayerRelationship(player.UserId, { friendStatus = friendStatus })
            refreshOpenMenuForPlayer(player, friendStatus)
        end)

        if not FFlagBadgeVisibilitySettingEnabled then
            return
        end

        task.spawn(function()
            local sendPlayerProfileSettings = RobloxReplicatedStorage:WaitForChild("SendPlayerProfileSettings", math.huge)
            self._reskinProfileSettingsConn = sendPlayerProfileSettings.OnClientEvent:Connect(function(arg1)
                local playerByUserId = Players:GetPlayerByUserId(tonumber(arg1))
                if playerByUserId then
                    request(playerByUserId)
                end
            end)
        end)
    end

    local function teardownPlayerInfoRequests()
        if self._reskinPlayerAddedConn then
            self._reskinPlayerAddedConn:Disconnect()
            self._reskinPlayerAddedConn = nil
        end
        if self._reskinPlayerRemovingConn then
            self._reskinPlayerRemovingConn:Disconnect()
            self._reskinPlayerRemovingConn = nil
        end
        if self._reskinBlockedStatusConn then
            self._reskinBlockedStatusConn:Disconnect()
            self._reskinBlockedStatusConn = nil
        end
        if self._reskinFriendStatusConn then
            self._reskinFriendStatusConn:Disconnect()
            self._reskinFriendStatusConn = nil
        end
        if self._reskinProfileSettingsConn then
            self._reskinProfileSettingsConn:Disconnect()
            self._reskinProfileSettingsConn = nil
        end
        PlayerRelationshipStore.cleanUp()
    end

    local function mountReskin()
        setStorePersistVisibility()
        local playerListReskin = Instance.new("ScreenGui")
        playerListReskin.Name = "PlayerListReskin"
        playerListReskin.AutoLocalize = false
        playerListReskin.IgnoreGuiInset = true
        playerListReskin.DisplayOrder = if isUnderTestEZ() then -1 else 1
        playerListReskin.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        playerListReskin.Parent = CoreGui
        local _reskinRoot = reactRoblox.createRoot(playerListReskin)
        local reskinElement = if FFlagPlayerListContrastingTeamText then createReskinElement({
            isSmallTouchDevice = isSmallTouchScreen2,
            isTenFoot = isTenFoot,
            foundationDevice = var4,
            leaderboardTitle = var1,
            TopBarConstants = constants,
            resolveContainerProps = resolveContainerProps
        }) else buildReskinElement()
        _reskinRoot:render(reskinElement)

        self._reskinRoot = _reskinRoot
        self._reskinScreenGui = playerListReskin
        if isSmallTouchScreen2 then
            local function connectViewport(camera: Camera)
                if self._reskinViewportConn then
                    self._reskinViewportConn:Disconnect()
                    self._reskinViewportConn = nil
                end
                if camera then
                    self._reskinViewportConn = camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                        var6(computeMobilePosition())
                    end)
                    var6(computeMobilePosition())
                end
            end
            self._reskinCameraConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
                connectViewport(workspace.CurrentCamera)
            end)
            connectViewport(workspace.CurrentCamera)
        end
        setupPlayerInfoRequests()
    end

    local function unmountReskin()
        PlayerListVisibilityStore.setShouldPersistVisibility(false)
        teardownPlayerInfoRequests()
        if self._reskinCameraConn then
            self._reskinCameraConn:Disconnect()
            self._reskinCameraConn = nil
        end
        if self._reskinViewportConn then
            self._reskinViewportConn:Disconnect()
            self._reskinViewportConn = nil
        end
        if self._reskinRoot then
            self._reskinRoot:unmount()
            self._reskinRoot = nil
        end
        if self._reskinScreenGui then
            self._reskinScreenGui:Destroy()
            self._reskinScreenGui = nil
        end
        if self._reskinVisibilityEffect then
            self._reskinVisibilityEffect()
            self._reskinVisibilityEffect = nil
        end
        if self._reskinSetVisibleEffect then
            self._reskinSetVisibleEffect()
            self._reskinSetVisibleEffect = nil
        end
    end

    self.topBarEnabled = true
    self.coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)

    self._reskin = {
        mountReskin = mountReskin,
        unmountReskin = unmountReskin,
        setupVisibilityEffect = setupVisibilityEffect
    }

    if self.coreGuiEnabled then
        LeaderboardStoreInstanceManager.createLeaderboardStoreInstance()
        setupVisibilityEffect()
        mountReskin()
        self.mounted = true
    else
        self.mounted = false
    end

    if FFlagEnableMobilePlayerListOnGamepad then
        local function onPreferredInputChanged(arg1)
            local var7 = isSmallTouchScreen(arg1)

            if var7 == isSmallTouchScreen2 then
                return
            end
            if PlayerContextualMenuStore.getMenuData(false) ~= nil then
                PlayerContextualMenuStore.closeContextMenu()
            end
            isSmallTouchScreen2 = var7
            var4 = if isLargeConsoleLayout(arg1) then device.Console else device.Unknown
            PlayerContextualMenuStore.setOnDismiss(if isSmallTouchScreen2 then restoreVisibilityOnDismiss else nil)
            if self.mounted then
                unmountReskin()
                setupVisibilityEffect()
                mountReskin()
            end

            setStorePersistVisibility()
            local var8 = playerListInitialVisibleState(arg1)
            PlayerListVisibilityStore.setVisible(var8)
            PlayerListVisibilityStore.setTempHideSnapshot(var8)
        end

        self._onPreferredInputChanged = onPreferredInputChanged
        self._reskinPreferredInputConn = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            onPreferredInputChanged(UserInputService.PreferredInput)
        end)
    end

    self._reskinCoreGuiConn = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if coreGuiType == Enum.CoreGuiType.All or coreGuiType == Enum.CoreGuiType.PlayerList then
            self.coreGuiEnabled = enabled
            self:SetTopBarEnabled(self.topBarEnabled)
        end
    end)

    ContextActionService:BindCoreAction("RbxPlayerListToggle", function(_, userInputState, _)
        if not self.mounted then
            return Enum.ContextActionResult.Pass
        end
        if isSmallTouchScreen2 then
            return Enum.ContextActionResult.Pass
        end
        if GuiService.MenuIsOpen then
            return Enum.ContextActionResult.Pass
        end
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end
        self:SetVisibility(not self:GetVisibility())
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Tab)

    if FFlagTopBarSignalizeSetCores then
        self._reskinTopBarEffect = Signals.createEffect(function(arg1)
            local getTopBarStore = InExperienceTopBar.Stores.GetTopBarStore
            if getTopBarStore then
                self:SetTopBarEnabled(getTopBarStore(arg1).getTopBarCoreGuiEnabled(arg1))
            end
        end)
    end

    return self
end

function module:GetVisibility()
    if FFlagPlayerListReskin then
        return PlayerListVisibilityStore.getEffectiveVisible(false)
    end
    return self.store:getState().displayOptions.isVisible
end

if FFlagAddNewPlayerListFocusNav then
    function module:GetVisibilityChangedEvent()
        return self.VisibilityChangedEvent
    end
end

function module:GetSetVisible()
    if FFlagPlayerListReskin then
        return PlayerListVisibilityStore.getVisible(false)
    end
    return self.store:getState().displayOptions.setVisible
end

function module:GetSetVisibleChangedEvent()
    return self.SetVisibleChangedEvent
end

function module:SetVisibility(arg1)
    if not FFlagPlayerListReskin then
        self.store:dispatch(SetPlayerListVisibility(arg1))
        return
    end

    if not arg1 then
        PlayerContextualMenuStore.closeContextMenu()
    end
    PlayerListVisibilityStore.setVisible(arg1)
end

function module:HideTemp(arg1, arg2)
    if FFlagPlayerListReskin then
        if arg2 and PlayerContextualMenuStore.getMenuData(false) ~= nil then
            PlayerContextualMenuStore.closeContextMenu()
        end

        PlayerListVisibilityStore.setTempHide(arg1, arg2)
        return
    end
    if arg2 == false then
        arg2 = nil
    end

    self.store:dispatch(SetTempHideKey(arg1, arg2))
end

function module:SetTopBarEnabled(topBarEnabled)
    if not FFlagPlayerListReskin then
        self.topBarEnabled = topBarEnabled
        self:_updateMounted()
        return
    end

    self.topBarEnabled = topBarEnabled
    local var1 = self.coreGuiEnabled and topBarEnabled
    if var1 and not self.mounted then
        LeaderboardStoreInstanceManager.createLeaderboardStoreInstance()
        self._reskin.setupVisibilityEffect()
        self._reskin.mountReskin()
        self.mounted = true
    elseif not var1 and self.mounted then
        self._reskin.unmountReskin()
        LeaderboardStoreInstanceManager.cleanUpInstance()
        self.mounted = false
    end
end

function module:SetMinimized(arg1)
    if FFlagPlayerListReskin then
        return
    end
    self.store:dispatch(SetMinimized(arg1))
end

return module
