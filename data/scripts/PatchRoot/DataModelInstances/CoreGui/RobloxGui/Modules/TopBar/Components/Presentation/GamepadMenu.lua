-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Cryo = require(CorePackages.Packages.Cryo)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local AppUserLayers = require(CorePackages.Workspace.Packages.ExperimentLayers).AppUserLayers
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local withStyle = UIBlox.Core.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local MenuHeader = require(script.MenuHeader)
local ChatIcon = require(script.ChatIcon)
local MenuCell = require(script.MenuCell)
local QuickMenuControllerBar = require(script.QuickMenuControllerBar)
local MenuNavigationToggleDialog = require(script.MenuNavigationToggleDialog)

local Modules = CoreGui:WaitForChild("RobloxGui").Modules
local TopBar = Modules.TopBar
local TenFootInterface = require(Modules.TenFootInterface)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(Modules.BackpackScript)
local EmotesMenuMaster = require(Modules.EmotesMenu.EmotesMenuMaster)
local ChatSelector = require(Modules.ChatSelector)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local PlayerListManager = require(Modules.PlayerList.PlayerListManager)

local isNewInGameMenuEnabled = require(Modules.isNewInGameMenuEnabled)
local InGameMenuConstants = require(Modules.InGameMenuConstants)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize

local Telemetry = require(TopBar:WaitForChild("Telemetry"))
local LogGamepadOpenExperienceControlsMenu = Telemetry.LogGamepadOpenExperienceControlsMenu
local default = Telemetry.GamepadMenuTelemetry.default
local GameSettings = UserSettings().GameSettings
local Actions = script.Parent.Parent.Parent.Actions
local SetGamepadMenuOpen = require(Actions.SetGamepadMenuOpen)
local EnumGamepadMenuOptions = require(script.EnumGamepadMenuOptions)

local iconsLogoBlock = Images["icons/logo/block"]
local iconsMenuAR = Images["icons/menu/AR"]

local iconsActionsRespawn = Images["icons/actions/respawn"]
local iconsNavigationClose = Images["icons/navigation/close"]

local component_assetsCircle_17 = Images["component_assets/circle_17"]
local rect = Rect.new(8, 8, 9, 9)

local var1 = Roact.PureComponent:extend("GamepadMenu")
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagAddMenuNavigationToggleDialog = SharedFlags.FFlagAddMenuNavigationToggleDialog
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagExperienceMenuGamepadExposureEnabled = SharedFlags.FFlagExperienceMenuGamepadExposureEnabled
local FFlagMountCoreGuiBackpack = require(Modules.Flags.FFlagMountCoreGuiBackpack)
local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook

local getFFlagExpChatAlwaysRunTCS = SharedFlags.getFFlagExpChatAlwaysRunTCS

local ToastNotification = nil
local ToastNotificationWrapper = nil
local Toast = nil
task.spawn(function()
    ToastNotification = CoreGui:WaitForChild("ToastNotification", 3)
    ToastNotificationWrapper = if ToastNotification == nil then nil else ToastNotification:WaitForChild("ToastNotificationWrapper", 3)
    Toast = if ToastNotificationWrapper == nil then nil else ToastNotificationWrapper:FindFirstChild("Toast", true)
end)

local strictInterface = t.strictInterface
local tbl1 = {
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    chatVersion = t.optional(t.EnumItem),
    chatEnabled = t.boolean,
    leaderboardEnabled = t.boolean,
    emotesEnabled = t.boolean,
    backpackEnabled = if FFlagMountCoreGuiBackpack then nil else t.boolean,
    respawnEnabled = t.boolean,
    leaderboardOpen = t.boolean,
    backpackOpen = t.boolean,
    emotesOpen = t.boolean,
    menuOpen = t.boolean,
    topBarEnabled = if FFlagMountCoreGuiBackpack then t.boolean else nil,
    setGamepadMenuOpen = t.callback,
    isGamepadMenuOpen = t.boolean
}
var1.validateProps = strictInterface(tbl1)

function var1.init(arg1)
    if FFlagMountCoreGuiBackpack then
        arg1:setState(
            {
                selectedIndex = 1,
                menuActions = {},
                mountBackpack = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack)
            }
        )
        StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType == Enum.CoreGuiType.Backpack or coreGuiType == Enum.CoreGuiType.All then
                arg1:setState({ mountBackpack = enabled })
            end
        end)
    else
        arg1:setState({ selectedIndex = 1, menuActions = {} })
    end

    if FFlagExperienceMenuGamepadExposureEnabled then
        arg1.loggedExperienceMenuGamepadExposure = false
    end

    arg1.boundMenuOpenActions = false

    arg1.lastMenuButtonPress = 0

    function arg1.toggleChatVisibilityAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end

        arg1.toggleChatVisible()
        default.onOptionSelected(
            {
                menuOptionName = EnumGamepadMenuOptions.Chat,
                usedShortcut = true,
                isToggleOpen = ChatSelector:GetVisibility()
            }
        )
    end

    function arg1.toggleMenuVisibleAction(_, userInputState, _)
        if arg1.props.menuOpen then
            return Enum.ContextActionResult.Pass
        end

        local toastVisible = not (Toast == nil) and Toast.Visible

        if userInputState == Enum.UserInputState.Begin then
            arg1.lastMenuButtonPress = tick()
            return Enum.ContextActionResult.Pass
        end

        if userInputState ~= Enum.UserInputState.End or toastVisible and not (tick() - arg1.lastMenuButtonPress < 1) then
            return Enum.ContextActionResult.Pass
        end

        local bool1 = not arg1.props.isGamepadMenuOpen

        if FFlagPlayerListUseFocusNavHook and bool1 and PlayerListManager:GetIsModal() and PlayerListManager:GetVisibility() then
            PlayerListManager:SetVisibility(false)
        end

        arg1.props.setGamepadMenuOpen(bool1)
        LogGamepadOpenExperienceControlsMenu(bool1)
        arg1:logExperienceMenuGamepadExposure()

        return Enum.ContextActionResult.Sink
    end

    function arg1.closeMenuAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        arg1.props.setGamepadMenuOpen(false)

        return Enum.ContextActionResult.Sink
    end

    function arg1.leaveGameMenuAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        var1.leaveGame()

        arg1.props.setGamepadMenuOpen(false)
        default.onOptionSelected({ menuOptionName = EnumGamepadMenuOptions.Leave, usedShortcut = true, isToggleOpen = true })

        return Enum.ContextActionResult.Sink
    end

    function arg1.respawnMenuAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        var1.respawnCharacter()

        arg1.props.setGamepadMenuOpen(false)
        default.onOptionSelected({ menuOptionName = EnumGamepadMenuOptions.Respawn, usedShortcut = true, isToggleOpen = true })

        return Enum.ContextActionResult.Sink
    end

    arg1.lastThumbStickMove = 0

    function arg1.moveSelectionAction(_, userInputState, arg2)
        if userInputState == Enum.UserInputState.Begin then
            if arg2.KeyCode == Enum.KeyCode.DPadUp then
                if arg1.state.selectedIndex > 1 then
                    arg1:setState({ selectedIndex = arg1.state.selectedIndex - 1 })
                end

                return Enum.ContextActionResult.Sink
            end

            if arg2.KeyCode == Enum.KeyCode.DPadDown then
                if arg1.state.selectedIndex < #arg1.state.menuActions then
                    arg1:setState({ selectedIndex = arg1.state.selectedIndex + 1 })
                end

                return Enum.ContextActionResult.Sink
            end
        elseif arg2.KeyCode == Enum.KeyCode.Thumbstick1 then
            if tick() - arg1.lastThumbStickMove < 0.15 then
                return Enum.ContextActionResult.Pass
            end
            if arg2.Position.Y > 0.8 then
                if arg1.state.selectedIndex > 1 then
                    arg1:setState({ selectedIndex = arg1.state.selectedIndex - 1 })

                    arg1.lastThumbStickMove = tick()
                end
                return Enum.ContextActionResult.Pass
            end

            if arg2.Position.Y < -0.8 then
                if arg1.state.selectedIndex < #arg1.state.menuActions then
                    arg1:setState({ selectedIndex = arg1.state.selectedIndex + 1 })

                    arg1.lastThumbStickMove = tick()
                end
                return Enum.ContextActionResult.Sink
            end
        end
        return Enum.ContextActionResult.Pass
    end

    function arg1.goToTopAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        arg1:setState({ selectedIndex = 1 })
    end

    function arg1.goToBottomAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        arg1:setState({ selectedIndex = #arg1.state.menuActions })
    end

    function arg1.activateSelectionAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        local menuAction = arg1.state.menuActions[arg1.state.selectedIndex]
        arg1.props.setGamepadMenuOpen(false)

        GuiService:SetMenuIsOpen(false, "GamepadMenu")

        menuAction.onActivated()
        local function isMenuOptionToggleOpenOnSelect(leaderboard) -- Luacid: Inlined by compiler; 1 call site recovered
            if leaderboard == EnumGamepadMenuOptions.Leaderboard then
                return PlayerListManager:GetSetVisible()
            end

            return true
        end

        default.onOptionSelected({
            menuOptionName = menuAction.name,
            usedShortcut = false,
            isToggleOpen = isMenuOptionToggleOpenOnSelect(menuAction.name)
        })

        return Enum.ContextActionResult.Sink
    end

    function arg1.overlayDismiss()
        arg1.props.setGamepadMenuOpen(false)
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var1.openRootMenu()
    if isNewInGameMenuEnabled() then
        require(Modules.InGameMenuInit).openInGameMenu(InGameMenuConstants.MainPagePageKey)
        return
    end
    require(Modules.Settings.SettingsHub):SetVisibility(
        true,
        nil,
        nil,
        true,
        InGameMenuConstants.AnalyticsMenuOpenTypes.PlayersTriggered
    )
end

function var1.openUnibarMenu()
    require(Modules.Chrome.Service):enableFocusNav()
end

function var1.closeUnibarMenu()
    require(Modules.Chrome.Service):disableFocusNav()
end

function var1.toggleChatVisible()
    ChatSelector:ToggleVisibility()
    GameSettings.ChatVisible = ChatSelector:GetVisibility()
end

function var1.focusChatBar()
    ChatSelector:SetVisible(true)
    GameSettings.ChatVisible = true
    ChatSelector:FocusChatBar()
end

function var1.toggleLeaderboard()
    if isNewInGameMenuEnabled() then
        require(Modules.InGameMenuInit).openPlayersPage()
        return
    end
    PlayerListManager:SetVisibility(not PlayerListManager:GetSetVisible())
end

function var1.toggleEmotesMenu()
    if EmotesMenuMaster:isOpen() then
        EmotesMenuMaster:close()
        return
    end
    EmotesMenuMaster:open()
end

function var1.toggleBackpack()
    if FFlagEnableNewBackpack then
        Features.toggleVisibility(Features.FeatureName.Backpack)
        return
    end
    BackpackScript:OpenClose()
end

function var1.leaveGame()
    if isNewInGameMenuEnabled() then
        require(Modules.InGameMenuInit).openGameLeavePage()
        return
    end
    local settingsHub = require(Modules.Settings.SettingsHub)
    settingsHub:SetVisibility(
        true,
        false,
        settingsHub.Instance.LeaveGamePage,
        true,
        InGameMenuConstants.AnalyticsMenuOpenTypes.GamepadLeaveGame
    )
end

function var1.respawnCharacter()
    if isNewInGameMenuEnabled() then
        require(Modules.InGameMenuInit).openCharacterResetPage()
        return
    end
    local settingsHub = require(Modules.Settings.SettingsHub)
    settingsHub:SetVisibility(
        true,
        false,
        settingsHub.Instance.ResetCharacterPage,
        true,
        InGameMenuConstants.AnalyticsMenuOpenTypes.GamepadResetCharacter
    )
end

function var1.shouldShowChatMenuOption(arg1, arg2)
    if not TenFootInterface:IsEnabled() then
        return arg2
    end

    arg1 = arg1 or TextChatService.ChatVersion

    if getFFlagExpChatAlwaysRunTCS() then
        return arg2
    end

    return arg2 and arg1 == Enum.ChatVersion.TextChatService
end

function var1.getMenuActionsFromProps(arg1, arg2)
    local menuActionsFromProps = {}

    table.insert(menuActionsFromProps, {
        name = EnumGamepadMenuOptions.Menu,
        icon = iconsLogoBlock,
        iconComponent = nil,
        localizationKey = "CoreScripts.TopBar.Menu",
        onActivated = var1.openRootMenu
    })

    if var1.shouldShowChatMenuOption(arg1.chatVersion, arg1.chatEnabled) then
        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Chat,
            icon = nil,
            iconComponent = ChatIcon,
            localizationKey = "CoreScripts.TopBar.Chat",
            onActivated = var1.focusChatBar
        })
    end

    if ChromeEnabled() then
        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Unibar,
            icon = iconsMenuAR,
            iconComponent = nil,
            localizationKey = "CoreScripts.TopBar.Title.ExperienceControls",
            onActivated = var1.openUnibarMenu
        })
    end

    if arg1.leaderboardEnabled or TenFootInterface:IsEnabled() then
        local icon = if arg1.leaderboardOpen then "rbxasset://textures/ui/TopBar/leaderboardOn.png" else "rbxasset://textures/ui/TopBar/leaderboardOff.png"

        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Leaderboard,
            icon = icon,
            iconComponent = nil,
            localizationKey = "CoreScripts.TopBar.Leaderboard",
            onActivated = var1.toggleLeaderboard
        })
    end

    if arg1.emotesEnabled then
        local icon = if arg1.emotesOpen then "rbxasset://textures/ui/TopBar/emotesOn.png" else "rbxasset://textures/ui/TopBar/emotesOff.png"

        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Emotes,
            icon = icon,
            iconComponent = nil,
            localizationKey = "CoreScripts.TopBar.Emotes",
            onActivated = var1.toggleEmotesMenu
        })
    end

    if if FFlagMountCoreGuiBackpack then arg1.topBarEnabled and arg2.mountBackpack else arg1.backpackEnabled then
        local icon = if arg1.backpackOpen then "rbxasset://textures/ui/TopBar/inventoryOn.png" else "rbxasset://textures/ui/TopBar/inventoryOff.png"

        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Inventory,
            icon = icon,
            iconComponent = nil,
            localizationKey = "CoreScripts.TopBar.Inventory",
            onActivated = var1.toggleBackpack
        })
    end

    if arg1.respawnEnabled then
        table.insert(menuActionsFromProps, {
            name = EnumGamepadMenuOptions.Respawn,
            icon = iconsActionsRespawn,
            iconComponent = nil,
            localizationKey = "CoreScripts.TopBar.Respawn",
            onActivated = var1.respawnCharacter
        })
    end

    table.insert(menuActionsFromProps, {
        name = EnumGamepadMenuOptions.Leave,
        icon = iconsNavigationClose,
        iconComponent = nil,
        localizationKey = "CoreScripts.TopBar.Leave",
        onActivated = var1.leaveGame
    })

    return menuActionsFromProps
end

function var1.getDerivedStateFromProps(arg1, arg2)
    local menuActions = if FFlagMountCoreGuiBackpack then var1.getMenuActionsFromProps(arg1, arg2) else var1.getMenuActionsFromProps(arg1)
    local selectedIndex = arg2.selectedIndex or 1
    local var2 = #menuActions < selectedIndex and #menuActions or selectedIndex

    return Cryo.Dictionary.join(arg2, { selectedIndex = var2, menuActions = menuActions })
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local tbl2 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            MenuHeader = Roact.createElement(MenuHeader, { layoutOrder = 1, height = 120 })
        }

        for i, menuAction in ipairs(arg1.state.menuActions) do
            local name = menuAction.name
            tbl2[name] = Roact.createElement(MenuCell, {
                layoutOrder = i + 1,
                icon = menuAction.icon,
                iconComponent = menuAction.iconComponent,
                localizationKey = menuAction.localizationKey,
                height = 56,
                hasDivider = i ~= #arg1.state.menuActions,
                isSelected = i == arg1.state.selectedIndex
            })
        end

        local yOffset = #arg1.state.menuActions * 56 + 120

        local num1 = 1
        local screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize

        if screenSize.Y * 0.75 < yOffset then
            num1 = screenSize.Y * 0.75 / yOffset
        end

        if screenSize.X * 0.75 < 336 then
            local var2 = screenSize.X * 0.75 / 336
            if var2 < num1 then
                num1 = var2
            end
        end

        if num1 < 1 then
            tbl2.UIScale = Roact.createElement("UIScale", { Scale = num1 })
        end

        local isGamepadMenuOpen = arg1.props.isGamepadMenuOpen
        local controllerBar = if isGamepadMenuOpen then Roact.createElement(
            QuickMenuControllerBar,
            {
                chatMenuEnabled = arg1.shouldShowChatMenuOption(arg1.props.chatVersion, arg1.props.chatEnabled)
            }
        ) else nil
        local tbl3 = {
            Menu = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = component_assetsCircle_17,
                SliceCenter = rect,
                ScaleType = Enum.ScaleType.Slice,
                ImageTransparency = theme.BackgroundUIContrast.Transparency,
                ImageColor3 = theme.BackgroundUIContrast.Color,
                Size = UDim2.fromOffset(336, yOffset),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }, tbl2),
            ControllerBar = controllerBar,
            MenuNavigationToggleDialog = if ChromeEnabled() or FFlagEnableConsoleExpControls or not FFlagAddMenuNavigationToggleDialog then nil else Roact.createElement(MenuNavigationToggleDialog, { Position = UDim2.fromScale(0.5, 0.1) })
        }

        return Roact.createElement("TextButton", {
            Visible = isGamepadMenuOpen,
            Text = "",
            BackgroundTransparency = theme.Overlay.Transparency,
            BackgroundColor3 = theme.Overlay.Color,
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            ZIndex = 10,
            [Roact.Event.Activated] = arg1.overlayDismiss
        }, tbl3)
    end)
end

function var1.didMount(arg1)
    if not VRService.VREnabled then
        ContextActionService:BindCoreAction(
            "TopBarGamepadToggleGamepadMenu",
            arg1.toggleMenuVisibleAction,
            false,
            Enum.KeyCode.ButtonStart
        )
    end
end

function var1.bindMenuOpenActions(arg1)
    arg1.boundMenuOpenActions = true

    ContextActionService:BindCoreAction("TopBarGamepadFreezeController", function() end, false, Enum.UserInputType.Gamepad1)

    ContextActionService:BindCoreAction("TopBarGamepadCloseMenu", arg1.closeMenuAction, false, Enum.KeyCode.ButtonB)
    ContextActionService:BindCoreAction("TopBarGamepadLeaveGame", arg1.leaveGameMenuAction, false, Enum.KeyCode.ButtonX)
    ContextActionService:BindCoreAction("TopBarGamepadRespawnAction", arg1.respawnMenuAction, false, Enum.KeyCode.ButtonY)
    ContextActionService:BindCoreAction(
        "TopBarGamepadActivateSelection",
        arg1.activateSelectionAction,
        false,
        Enum.KeyCode.ButtonA
    )
    ContextActionService:BindCoreAction(
        "TopBarGamepadMoveSelection",
        arg1.moveSelectionAction,
        false,
        Enum.KeyCode.Thumbstick1,
        Enum.KeyCode.DPadUp,
        Enum.KeyCode.DPadDown
    )

    ContextActionService:BindCoreAction("TopBarGamepadMoveSelectionTop", arg1.goToTopAction, false, Enum.KeyCode.ButtonL2)
    ContextActionService:BindCoreAction(
        "TopBarGamepadMoveSelectionBottom",
        arg1.goToBottomAction,
        false,
        Enum.KeyCode.ButtonR2
    )
    ContextActionService:BindCoreAction(
        "TopBarGamepadToggleChatVisibility",
        arg1.toggleChatVisibilityAction,
        false,
        Enum.KeyCode.ButtonR1
    )

    ContextActionService:BindCoreAction(
        "TopBarGamepadToggleGamepadMenu",
        arg1.toggleMenuVisibleAction,
        false,
        Enum.KeyCode.ButtonStart
    )
end

function var1.unbindMenuOpenActions(arg1)
    arg1.boundMenuOpenActions = false

    ContextActionService:UnbindCoreAction("TopBarGamepadFreezeController")
    ContextActionService:UnbindCoreAction("TopBarGamepadCloseMenu")
    ContextActionService:UnbindCoreAction("TopBarGamepadActivateSelection")
    ContextActionService:UnbindCoreAction("TopBarGamepadLeaveGame")
    ContextActionService:UnbindCoreAction("TopBarGamepadRespawnAction")
    ContextActionService:UnbindCoreAction("TopBarGamepadMoveSelection")
    ContextActionService:UnbindCoreAction("TopBarGamepadMoveSelectionTop")
    ContextActionService:UnbindCoreAction("TopBarGamepadMoveSelectionBottom")
    ContextActionService:UnbindCoreAction("TopBarGamepadToggleChatVisibility")
end

function var1.unbindAllActions(arg1)
    if arg1.boundMenuOpenActions then
        arg1:unbindMenuOpenActions()
    end

    ContextActionService:UnbindCoreAction("TopBarGamepadToggleGamepadMenu")
end

function var1.didUpdate(arg1, arg2, _)
    local bool1 = arg2.isGamepadMenuOpen ~= arg1.props.isGamepadMenuOpen
    local isGamepadMenuOpen = arg1.props.isGamepadMenuOpen

    if not bool1 then
        return
    end

    if not isGamepadMenuOpen then
        arg1:unbindMenuOpenActions()

        GuiService:SetMenuIsOpen(false, "GamepadMenu")
        return
    end

    arg1:bindMenuOpenActions()

    if arg1.state.selectedIndex ~= 1 then
        arg1:setState({ selectedIndex = 1 })
    end

    arg1.savedSelectedCoreObject = GuiService.SelectedCoreObject
    GuiService.SelectedCoreObject = nil
    arg1.savedSelectedObject = GuiService.SelectedObject
    GuiService.SelectedObject = nil

    GuiService:SetMenuIsOpen(true, "GamepadMenu")

    if ChromeEnabled() then
        var1.closeUnibarMenu()
    end
end

function var1.willUnmount(arg1)
    arg1:unbindAllActions()

    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

function var1.logExperienceMenuGamepadExposure(arg1)
    if FFlagExperienceMenuGamepadExposureEnabled and not arg1.loggedExperienceMenuGamepadExposure then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.ExperienceMenuGamepadExposureLayer)
        arg1.loggedExperienceMenuGamepadExposure = true
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    local topbarEnabled = arg1.displayOptions.topbarEnabled

    local tbl2 = {
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        chatEnabled = arg1.coreGuiEnabled[Enum.CoreGuiType.Chat] and topbarEnabled and not VRService.VREnabled,
        leaderboardEnabled = arg1.coreGuiEnabled[Enum.CoreGuiType.PlayerList] and topbarEnabled,
        emotesEnabled = arg1.moreMenu.emotesEnabled and arg1.coreGuiEnabled[Enum.CoreGuiType.EmotesMenu] and topbarEnabled,
        backpackEnabled = if FFlagMountCoreGuiBackpack then nil else arg1.coreGuiEnabled[Enum.CoreGuiType.Backpack] and topbarEnabled,
        respawnEnabled = arg1.respawn.enabled,
        topBarEnabled = 0,
        leaderboardOpen = 0,
        backpackOpen = 0,
        emotesOpen = 0,
        menuOpen = 0,
        isGamepadMenuOpen = 0
    }
    if not FFlagMountCoreGuiBackpack then
        topbarEnabled = nil
    end

    tbl2.topBarEnabled = topbarEnabled
    tbl2.leaderboardOpen = arg1.moreMenu.leaderboardOpen
    tbl2.backpackOpen = arg1.moreMenu.backpackOpen
    tbl2.emotesOpen = arg1.moreMenu.emotesOpen

    tbl2.menuOpen = arg1.displayOptions.menuOpen

    tbl2.isGamepadMenuOpen = arg1.displayOptions.isGamepadMenuOpen
    return tbl2
end, function(arg1) -- name: mapDispatchToProps
    return {
        setGamepadMenuOpen = function(arg2)
            return arg1(SetGamepadMenuOpen(arg2))
        end
    }
end)(var1)
