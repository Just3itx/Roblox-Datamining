-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection
local KeyLabel = UIBlox.App.Menu.KeyLabel
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local scriptParentParent = script.Parent.Parent

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local SetRespawning = require(scriptParentParent.Actions.SetRespawning)
local CloseMenu = require(scriptParentParent.Thunks.CloseMenu)
local Assets = require(scriptParentParent.Resources.Assets)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)
local VoiceIndicator = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicator)

local Constants = require(scriptParentParent.Resources.Constants)
local Direction = require(scriptParentParent.Enums.Direction)

local PageNavigation = require(script.Parent.PageNavigation)
local GameIconHeader = require(script.Parent.GameIconHeader)
local ZonePortal = require(script.Parent.ZonePortal)

local Flags = scriptParentParent.Flags
local bool1 = game:DefineFastFlag("TakeAScreenshotOfThis", false)
local bool2 = game:DefineFastFlag("ShowContextMenuWhenButtonsArePresent", false)
local bool3 = game:DefineFastFlag("UseVRSpecificLeaveButton", false)
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)
local Images = UIBlox.App.ImageSet.Images
local FocusHandler = require(script.Parent.Connection.FocusHandler)
local IGMMainPageControllerBar = require(script.Parent.IGMMainPageControllerBar)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local tbl1 = {
    [Constants.InputType.MouseAndKeyboard] = Enum.KeyCode.R,
    [Constants.InputType.Gamepad] = Enum.KeyCode.ButtonY
}

local tbl2 = {
    [Constants.InputType.MouseAndKeyboard] = Enum.KeyCode.L,
    [Constants.InputType.Gamepad] = Enum.KeyCode.ButtonX
}

local var1 = Roact.PureComponent:extend("MainPage")

local function areCapturesAllowed(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not VRService.VREnabled
        and (not bool1 or not require(CorePackages.Workspace.Packages.CachedPolicyService):IsSubjectToChinaPolicies())
end

function var1.renderButtonModels(arg1, _, arg2)
    local inputType = arg1.props.inputType
    local bool4 = areCapturesAllowed()
    local result = {}

    if bool4 and bool1 then
        table.insert(result, {
            icon = Images["icons/controls/screenshot"],
            text = arg2.screenCapture,
            onActivated = function()
                arg1:setState({ modalOpen = false })

                arg1.props.closeMenu()

                RunService.RenderStepped:Wait()
                RunService.RenderStepped:Wait()

                CoreGui:TakeScreenshot()
            end
        })
    end

    if arg1.props.respawnButtonVisible then
        table.insert(result, {
            icon = Assets.Images.RespawnIcon,
            text = arg2.respawnCharacter,
            onActivated = function()
                arg1:setState({ modalOpen = false })

                arg1.props.startRespawning()
            end,
            keyCodeLabel = tbl1[inputType]
        })
    end

    return result
end

var1.validateProps = t.strictInterface({
    open = t.boolean,
    isMainPageMoreMenuOpen = t.optional(t.boolean),
    respawnButtonVisible = t.boolean,
    startLeavingGame = t.callback,
    startRespawning = t.callback,
    setMainPageMoreMenuOpen = t.optional(t.callback),
    closeMenu = t.callback,
    screenSize = t.Vector2,
    canCaptureFocus = t.optional(t.boolean),
    inputType = t.optional(t.string),
    setFirstItemRef = t.optional(t.callback),
    voiceEnabled = t.optional(t.boolean),
    currentZone = GetFFlagIGMGamepadSelectionHistory() and t.optional(t.number) or nil
})

function var1.init(arg1)
    arg1.moreMenuFrameRef = nil
    arg1.moreMenuFirstItemFrameRef = nil
    arg1.moreMenuButtonRef = Roact.createRef()
    arg1.mainPageFirstButtonRef = Roact.createRef()

    function arg1.setMoreMenuRef(moreMenuFrameRef)
        arg1.moreMenuFrameRef = moreMenuFrameRef
    end

    function arg1.setMoreMenuFirstItemRef(moreMenuFirstItemFrameRef)
        arg1.moreMenuFirstItemFrameRef = moreMenuFirstItemFrameRef
    end

    arg1.state = { modalOpen = false }
end

function var1.getDerivedStateFromProps(arg1): {modalOpen: boolean}?
    return if arg1.canCaptureFocus then nil else { modalOpen = false }
end

function var1.renderMainPageFocusHandler(arg1)
    local var2 = arg1.canGamepadCaptureFocus(arg1.props)
    local bool4

    if GetFFlagIGMGamepadSelectionHistory() then
        local modalOpen = arg1.state.modalOpen

        var2 = arg1.canGamepadCaptureFocus(arg1.props) and not modalOpen

        bool4 = not arg1.props.open or arg1.props.currentZone == 0
    else
        bool4 = nil
    end

    return Roact.createElement(FocusHandler, {
        isFocused = var2,
        shouldForgetPreviousSelection = bool4,
        didFocus = GetFFlagIGMGamepadSelectionHistory() and function(selectedCoreObject)
            ContextActionService:BindCoreAction("LeftStickTogglesMoreMenuAction", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.End then
                    return Enum.ContextActionResult.Pass
                end

                arg1:setState({ modalOpen = true })

                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonL3)

            GuiService.SelectedCoreObject = selectedCoreObject or arg1.mainPageFirstButtonRef:getValue()
        end or function()
            ContextActionService:BindCoreAction("LeftStickTogglesMoreMenuAction", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.End then
                    return Enum.ContextActionResult.Pass
                end

                arg1:setState({ modalOpen = not arg1.state.modalOpen })

                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonL3)
        end,
        didBlur = function()
            ContextActionService:UnbindCoreAction("LeftStickTogglesMoreMenuAction")
        end
    })
end

function var1.renderMoreMenuFocusHandler(arg1)
    local var2 = arg1.canGamepadCaptureFocus(arg1.props)

    local modalOpen = arg1.state.modalOpen

    return Roact.createElement(FocusHandler, {
        isFocused = var2 and modalOpen,
        didFocus = function()
            local function func1(_, userInputState)
                if userInputState ~= Enum.UserInputState.End then
                    return Enum.ContextActionResult.Pass
                end

                arg1:setState({ modalOpen = false })

                return Enum.ContextActionResult.Sink
            end

            if GetFFlagIGMGamepadSelectionHistory() then
                ContextActionService:BindCoreAction("CloseMoreMenuAction", func1, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonL3)
            else
                ContextActionService:BindCoreAction("CloseMoreMenuAction", func1, false, Enum.KeyCode.ButtonB)
            end

            if arg1.moreMenuFrameRef ~= nil then
                GuiService:RemoveSelectionGroup("MainPageMoreMenu")
            end
            GuiService:AddSelectionParent("MainPageMoreMenu", arg1.moreMenuFrameRef)

            GuiService.SelectedCoreObject = arg1.moreMenuFirstItemFrameRef
        end,
        didBlur = function()
            ContextActionService:UnbindCoreAction("CloseMoreMenuAction")
        end
    })
end

function var1.render(arg1)
    local canCaptureFocus = arg1.canGamepadCaptureFocus(arg1.props)

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundDefault = {
                    Color = arg2.Color.Surface.Surface_0.Color3,
                    Transparency = arg2.Color.Surface.Surface_0.Transparency
                }
            }
        }
    end, function(arg2)
        return withLocalization({
            leaveGame = "CoreScripts.InGameMenu.LeaveGame",
            respawnCharacter = "CoreScripts.InGameMenu.RespawnCharacter",
            screenCapture = "CoreScripts.InGameMenu.Controls.Screenshot"
        })(
            function(arg3)
                local element = Roact.createElement(Button, {
                    buttonType = ButtonType.Secondary,
                    size = UDim2.fromOffset(44, 44),
                    onActivated = function()
                        arg1:setState({ modalOpen = true })
                    end,
                    icon = Assets.Images.MoreActions,
                    [Roact.Ref] = arg1.moreMenuButtonRef
                })

                local buttonProps = arg1:renderButtonModels(arg2, arg3)
                local respawnButtonVisible = arg1.props.respawnButtonVisible

                if bool2 then
                    respawnButtonVisible = #buttonProps > 0
                end

                local inputType = arg1.props.inputType
                local keyCode = if VRService.VREnabled and bool3 then Enum.KeyCode.ButtonX else tbl2[inputType]
                local xOffset = if respawnButtonVisible then -56 else 0

                local modalOpen = arg1.state.modalOpen

                local controllerBar = Roact.createElement(IGMMainPageControllerBar, { canCaptureFocus = canCaptureFocus, isMainPageMoreMenuOpen = modalOpen })
                local var5

                if arg1.props.voiceEnabled then
                    local createElement = Roact.createElement
                    local var6 = VoiceIndicator
                    local tbl3 = {
                        size = UDim2.fromOffset(44, 44),
                        userId = tostring(Players.LocalPlayer.UserId),
                        iconStyle = "MicLight",
                        onClicked = 0
                    }
                    function tbl3.onClicked()
                        default:ToggleMic("VRInGameMenuMainPage")
                    end

                    var5 = createElement(var6, tbl3)

                    xOffset -= 56
                else
                    var5 = nil
                end

                return Roact.createElement("TextButton", {
                    Size = UDim2.new(0, 400, 1, 0),
                    BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
                    BackgroundTransparency = arg2.Theme.BackgroundDefault.Transparency,
                    BorderSizePixel = 0,
                    Visible = arg1.props.open,
                    Text = "",
                    AutoButtonColor = false,
                    Selectable = false
                }, {
                    MoreMenuFocusHandler = arg1:renderMoreMenuFocusHandler(),
                    MainPageFocusHandler = if VRService.VREnabled then nil else arg1:renderMainPageFocusHandler() or nil,
                    ControllerBar = controllerBar,
                    ZonePortal = Roact.createElement(ZonePortal, { targetZone = 0, direction = Direction.Left }),
                    GameIconHeader = Roact.createElement(GameIconHeader),
                    PageNavigation = Roact.createElement(
                        PageNavigation,
                        {
                            Position = UDim2.new(0, Constants.Zone.ContentOffset, 0, 148),
                            mainPageFirstButtonRef = arg1.mainPageFirstButtonRef
                        }
                    ),
                    ContextualMenu = Roact.createElement(ContextualMenu, {
                        buttonProps = buttonProps,
                        setFrameRef = arg1.setMoreMenuRef,
                        setFirstItemRef = arg1.setMoreMenuFirstItemRef,
                        open = modalOpen,
                        menuDirection = MenuDirection.Up,
                        openPositionY = UDim.new(1, -84),
                        closeBackgroundVisible = true,
                        screenSize = arg1.props.screenSize,
                        onDismiss = function()
                            arg1:setState({ modalOpen = false })
                        end
                    }),
                    BottomButtons = Roact.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, 84),
                        Position = UDim2.new(0, 0, 1, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        BackgroundTransparency = 1
                    }, {
                        Layout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            Padding = UDim.new(0, 12),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Top
                        }),
                        Padding = Roact.createElement("UIPadding", {
                            PaddingTop = UDim.new(0, 24),
                            PaddingBottom = UDim.new(0, 24),
                            PaddingLeft = UDim.new(0, 24),
                            PaddingRight = UDim.new(0, 24)
                        }),
                        LeaveGame = Roact.createElement("Frame", {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, xOffset, 0, 44),
                            Position = UDim2.fromScale(1, 0),
                            AnchorPoint = Vector2.new(1, 0),
                            LayoutOrder = 1
                        }, {
                            Button = Roact.createElement(Button, {
                                buttonType = ButtonType.PrimarySystem,
                                size = UDim2.new(1, 0, 0, 44),
                                onActivated = arg1.props.startLeavingGame,
                                text = arg3.leaveGame
                            }),
                            KeyLabel = keyCode
                                and Roact.createElement(KeyLabel, {
                                    keyCode = keyCode,
                                    iconThemeKey = "UIDefault",
                                    textThemeKey = "SystemPrimaryContent",
                                    AnchorPoint = Vector2.new(1, 0.5),
                                    Position = UDim2.new(1, -16, 0.5, 0),
                                    LayoutOrder = 2,
                                    ZIndex = 2
                                })
                                or nil
                        }),
                        VoiceChatMuteButton = var5,
                        MoreButton = respawnButtonVisible and element
                    })
                })
            end
        )
    end)
end

function var1.willUnmount(_)
    GuiService:RemoveSelectionGroup("MainPageMoreMenu")
end

function var1.canGamepadCaptureFocus(arg1)
    return arg1.canCaptureFocus and arg1.inputType == Constants.InputType.Gamepad
end

function var1.didUpdate(arg1, arg2, arg3)
    local modalOpen = arg1.state.modalOpen

    local modalOpen2 = arg3.modalOpen

    if not GetFFlagIGMGamepadSelectionHistory() and arg1.canGamepadCaptureFocus(arg1.props) and not modalOpen then
        if modalOpen2 then
            GuiService.SelectedCoreObject = arg1.moreMenuButtonRef:getValue()
        elseif not arg1.canGamepadCaptureFocus(arg2) then
            GuiService.SelectedCoreObject = arg1.mainPageFirstButtonRef:getValue()
        end
    end

    if VRService.VREnabled then
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local currentZone = if GetFFlagIGMGamepadSelectionHistory() then arg1.currentZone else nil
    local canCaptureFocus = arg1.menuPage == Constants.MainPagePageKey and arg1.isMenuOpen and not arg1.respawn.dialogOpen and arg1.currentZone == 1
    return {
        open = arg1.isMenuOpen,
        respawnButtonVisible = arg1.respawn.enabled,
        screenSize = arg1.screenSize,
        voiceEnabled = arg1.voiceState.voiceEnabled,
        canCaptureFocus = canCaptureFocus,
        currentZone = currentZone,
        inputType = arg1.displayOptions.inputType,
        isMainPageInForeground = nil
    }
end, function(callback)
    return {
        startLeavingGame = function()
            callback(SetCurrentPage(Constants.LeaveGamePromptPageKey))
        end,
        startRespawning = function()
            callback(SetRespawning(true))
        end,
        closeMenu = function()
            callback(CloseMenu)
        end
    }
end)(var1)
