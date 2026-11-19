-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local VRService = game:GetService("VRService")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Actions = scriptParentParent.Actions
local Thunks = scriptParentParent.Thunks

local HideMenu = require(Actions.HideMenu)
local SetLayout = require(Actions.SetLayout)
local ShowError = require(Actions.ShowError)
local HideError = require(Actions.HideError)

local OpenMenu = require(Thunks.OpenMenu)

local EmotesWheel = require(scriptParent.EmotesWheel)
local ErrorMessage = require(scriptParent.ErrorMessage)

local Constants = require(scriptParentParent.Constants)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local LocalPlayer = Players.LocalPlayer
local var1 = nil

local var2 = Roact.PureComponent:extend("EmotesMenu")

function var2.init(arg1)
    arg1.savedSelectedCoreObject = nil
    arg1.savedSelectedObject = nil
end

function var2.displayVisitShopMessage(arg1)
    local locale = arg1.props.locale
    local var3 = RobloxTranslator:FormatByKeyForLocale(Constants.LocalizationKeys.VisitShopToGetEmotes, locale)
    arg1.props.showError(var3)
    delay(Constants.ErrorDisplayTimeSeconds, function()
        arg1.props.hideError()
    end)
end

function var2.bindActions(arg1)
    ContextActionService:BindAction(Constants.ToggleMenuAction, function(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject) -- name: toggleMenuFunc
        if GuiService.MenuIsOpen then
            return Enum.ContextActionResult.Pass
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
            return Enum.ContextActionResult.Pass
        end

        if userInputState == Enum.UserInputState.Begin then
            if arg1.props.displayOptions.menuVisible then
                arg1.props.hideMenu()
            else
                arg1.props.openMenu()
            end
        end

        return nil
    end, false, Constants.EmoteMenuOpenKey)
end

function var2.unbindActions(_)
    ContextActionService:UnbindAction(Constants.ToggleMenuAction)
end

function var2.saveSelectedObject(arg1)
    arg1.savedSelectedCoreObject = GuiService.SelectedCoreObject
    GuiService.SelectedCoreObject = nil
    arg1.savedSelectedObject = GuiService.SelectedObject
    GuiService.SelectedObject = nil
end

function var2.resetSelectedObject(arg1)
    if GuiService.SelectedCoreObject == nil
        and (arg1.savedSelectedCoreObject == nil or arg1.savedSelectedCoreObject:IsDescendantOf(CoreGui))
    then
        GuiService.SelectedCoreObject = arg1.savedSelectedCoreObject
    end

    if GuiService.SelectedObject ~= nil then
        return
    end

    if var1 == nil then
        var1 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end

    if var1 and (arg1.savedSelectedObject == nil or arg1.savedSelectedObject:IsDescendantOf(var1)) then
        GuiService.SelectedObject = arg1.savedSelectedObject
    end
end

function var2.viewPortSizeChanged(arg1)
    if arg1.props.layout == Constants.Layout.TenFoot then
        return
    end

    local currentCamera = Workspace.CurrentCamera
    if not currentCamera then
        return
    end

    local viewportSize = currentCamera.ViewportSize
    if viewportSize == Vector2.new(1, 1) then
        return
    end

    local large = Constants.Layout.Large

    local bool1 = viewportSize.X < Constants.SmallScreenMaxSize.X
    local bool2 = viewportSize.Y < Constants.SmallScreenMaxSize.Y

    if bool1 or bool2 then
        large = Constants.Layout.Small
    end

    arg1.props.setLayout(large)
end

function var2.currentCameraChanged(arg1)
    if arg1.viewportSizeChangedConn then
        arg1.viewportSizeChangedConn:Disconnect()
    end

    local currentCamera = Workspace.CurrentCamera
    if currentCamera then
        arg1.viewportSizeChangedConn = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            arg1:viewPortSizeChanged()
        end)
        arg1:viewPortSizeChanged()
    end
end

function var2.didMount(arg1)
    arg1.currentCameraChangedConn = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        arg1:currentCameraChanged()
    end)
    arg1:currentCameraChanged()

    arg1.menuOpenedConn = GuiService.MenuOpened:Connect(function()
        if arg1.props.displayOptions.menuVisible and not VRService.VREnabled then
            arg1.props.hideMenu()
        end
    end)

    arg1.inputOutsideMenuConn = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
        if gameProcessedEvent or not arg1.props.displayOptions.menuVisible then
            return
        end

        local userInputType = input.UserInputType
        if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
            arg1.props.hideMenu()
        end
    end)

    arg1:bindActions()
end

function var2.willUnmount(arg1)
    arg1.currentCameraChangedConn:Disconnect()
    arg1.viewportSizeChangedConn:Disconnect()
    arg1.menuOpenedConn:Disconnect()
    arg1.inputOutsideMenuConn:Disconnect()

    arg1.currentCameraChangedConn = nil
    arg1.viewportSizeChangedConn = nil
    arg1.menuOpenedConn = nil
    arg1.inputOutsideMenuConn = nil

    arg1:unbindActions()
end

function var2.didUpdate(arg1, arg2, _)
    if arg1.props.displayOptions.menuVisible == arg2.displayOptions.menuVisible then
        return
    end

    if arg1.props.displayOptions.menuVisible then
        arg1:saveSelectedObject()
        return
    end
    arg1:resetSelectedObject()
end

function var2.render(arg1)
    local layout = Constants.Layouts[arg1.props.layout]
    local guiInset = arg1.props.displayOptions.guiInset

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, -guiInset),
        Size = UDim2.new(1, 0, 1, guiInset),
        ZIndex = Constants.EmotesMenuZIndex,
        AutoLocalize = false
    }, {
        Main = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = Constants.ScreenAvailable,
            BackgroundTransparency = 1
        }, {
            AsspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1 }),
            SizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = layout.EmotesWheelMinSize, MaxSize = layout.EmotesWheelMaxSize }),
            EmotesWheel = Roact.createElement(EmotesWheel)
        }),
        ErrorMessage = Roact.createElement(ErrorMessage)
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        displayOptions = arg1.displayOptions,
        emotesInfo = arg1.emotesPage.emotesInfo,
        layout = arg1.layout,
        locale = arg1.locale
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        openMenu = function()
            return arg1(OpenMenu())
        end,
        hideMenu = function()
            return arg1(HideMenu())
        end,
        setLayout = function(arg2)
            return arg1(SetLayout(arg2))
        end,
        showError = function(arg2)
            return arg1(ShowError(arg2))
        end,
        hideError = function()
            return arg1(HideError())
        end
    }
end)(var2)
