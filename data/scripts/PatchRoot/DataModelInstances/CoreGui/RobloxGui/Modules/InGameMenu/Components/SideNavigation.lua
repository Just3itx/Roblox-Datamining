-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Interactable = UIBlox.Core.Control.Interactable
local ControlState = UIBlox.Core.Control.Enum.ControlState

local scriptParentParent = script.Parent.Parent

local FocusHandler = require(scriptParentParent.Components.Connection.FocusHandler)
local ZonePortal = require(scriptParentParent.Components.ZonePortal)

local CloseMenu = require(scriptParentParent.Thunks.CloseMenu)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

local Constants = require(scriptParentParent.Resources.Constants)
local Direction = require(scriptParentParent.Enums.Direction)

local CloseMenuButton = require(script.CloseMenuButton)
local HomeButton = require(script.HomeButton)
local SystemMenuButton = require(script.SystemMenuButton)

local InGameMenuPolicy = require(scriptParentParent.InGameMenuPolicy)

local GetFFlagIGMGamepadSelectionHistory = require(scriptParentParent.Flags.GetFFlagIGMGamepadSelectionHistory)

local var1 = Roact.PureComponent:extend("SideNavigation")

var1.validateProps = t.strictInterface({
    open = t.boolean,
    closeMenu = t.callback,
    goToHomePage = t.callback,
    goToSystemMenu = t.callback,
    currentPage = t.string,
    canCaptureFocus = t.optional(t.boolean),
    currentZone = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.number) or nil else nil,
    enableInGameHomeIcon = t.optional(t.boolean)
})

function var1.init(arg1)
    function arg1.controlStateUpdated(hover, hover2)
        if hover == ControlState.Hover and hover2 ~= ControlState.Hover and arg1.props.currentPage == Constants.InitalPageKey then
            arg1.props.closeMenu()
        end
    end

    arg1.firstItemRef = Roact.createRef()

    function arg1.onContainerRendered(selectionParent: Instance)
        if selectionParent then
            GuiService:RemoveSelectionGroup("SideNavigation_IGMSelectionGroup")
            GuiService:AddSelectionParent("SideNavigation_IGMSelectionGroup", selectionParent)
        end
    end
end

function var1.oldRender(arg1)
    local shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then arg1.props.currentZone ~= 0 or not arg1.props.open else nil

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundUIContrast = {
                    Color = arg2.Color.OverMedia.OverMedia_0.Color3,
                    Transparency = arg2.Color.OverMedia.OverMedia_0.Transparency
                }
            }
        }
    end, function(arg2)
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl1 = {
            AutoButtonColor = false,
            Text = "",
            BackgroundColor3 = arg2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = arg2.Theme.BackgroundUIContrast.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 64, 1, 0),
            Visible = arg1.props.open,
            Selectable = false,
            [Roact.Ref] = arg1.onContainerRendered
        }

        local tbl2 = {
            Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 1) }),
            CloseMenuButton = Roact.createElement(CloseMenuButton, {
                onActivated = arg1.props.closeMenu,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 4),
                [Roact.Ref] = arg1.firstItemRef
            }),
            FocusHandler = Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canCaptureFocus,
                shouldForgetPreviousSelection = shouldForgetPreviousSelection,
                didFocus = GetFFlagIGMGamepadSelectionHistory() and function(selectedCoreObject)
                    GuiService.SelectedCoreObject = selectedCoreObject or arg1.firstItemRef:getValue()
                end or function()
                    GuiService.SelectedCoreObject = arg1.firstItemRef:getValue()
                end
            }),
            ZonePortal = if arg1.props.currentPage == Constants.InitalPageKey then nil else Roact.createElement(ZonePortal, { targetZone = 1, direction = Direction.Right }) or nil
        }

        return createElement(str1, tbl1, tbl2)
    end)
end

function var1.newRender(arg1)
    local currentPage = arg1.props.currentPage

    local tbl1 = {
        Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 4) }),
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 4)
        }),
        SystemMenuButton = Roact.createElement(SystemMenuButton, {
            on = currentPage == Constants.MainPagePageKey,
            onClose = arg1.props.closeMenu,
            onActivated = arg1.props.goToSystemMenu,
            layoutOrder = 1,
            anchorPoint = Vector2.new(0.5, 0),
            position = UDim2.new(0.5, 0, 0, 4),
            canCaptureFocus = arg1.props.canCaptureFocus
        }),
        HomeButton = Roact.createElement(HomeButton, {
            on = currentPage == Constants.LeaveToAppPromptPageKey,
            onActivated = arg1.props.goToHomePage,
            layoutOrder = 2,
            anchorPoint = Vector2.new(0.5, 0),
            position = UDim2.new(0.5, 0, 0, 8)
        })
    }

    local tbl2 = {
        Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 1) }),
        Content = Roact.createElement("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Selectable = false }, tbl1),
        ZonePortal = if arg1.props.currentPage == Constants.InitalPageKey then nil else Roact.createElement(ZonePortal, { targetZone = 1, direction = Direction.Right }) or nil
    }

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundUIContrast = {
                    Color = arg2.Color.OverMedia.OverMedia_0.Color3,
                    Transparency = arg2.Color.OverMedia.OverMedia_0.Transparency
                }
            }
        }
    end, function(arg2)
        return Roact.createElement(Interactable, {
            onStateChanged = arg1.controlStateUpdated,
            AutoButtonColor = false,
            BackgroundColor3 = arg2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = arg2.Theme.BackgroundUIContrast.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 64, 1, 0),
            Visible = arg1.props.open,
            Selectable = false,
            [Roact.Ref] = arg1.onContainerRendered
        }, tbl2)
    end)
end

function var1.render(arg1)
    if arg1.props.enableInGameHomeIcon then
        return arg1:newRender()
    end
    return arg1:oldRender()
end

local var2 = InGameMenuPolicy.connect(function(arg1, _)
    return {
        enableInGameHomeIcon = arg1.enableInGameHomeIcon()
    }
end)(var1)

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local bool1 = arg1.isMenuOpen and not arg1.respawn.dialogOpen

    if bool1 then
        if arg1.displayOptions.inputType == Constants.InputType.Gamepad then
            bool1 = arg1.currentZone == 0
        else
            bool1 = false
        end
    end

    local currentZone = if GetFFlagIGMGamepadSelectionHistory() then arg1.currentZone else nil
    return {
        canCaptureFocus = bool1,
        currentPage = arg1.menuPage,
        open = arg1.isMenuOpen,
        currentZone = currentZone
    }
end, function(callback)
    return {
        closeMenu = function()
            callback(CloseMenu)
        end,
        goToSystemMenu = function()
            callback(SetCurrentPage(Constants.MainPagePageKey))
        end,
        goToHomePage = function()
            callback(SetCurrentPage(Constants.LeaveToAppPromptPageKey))
        end
    }
end)(var2)
