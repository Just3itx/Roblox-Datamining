-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagEnableMenuTrailingBadge = SharedFlags.FFlagEnableMenuTrailingBadge
local bool1 = game:DefineFastFlag("AvatarSwitcherHamburgerExposure", false)
local str1 = game:DefineFastString("AvatarSwitcherIXPLayer", "UIEcosystem.User.Migration")

local FFlagUnibarMenuOpenSubmenu = require(script.Parent.Parent.Parent.Flags).FFlagUnibarMenuOpenSubmenu

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local GamepadUtils = if FFlagEnableConsoleExpControls then require(CorePackages.Workspace.Packages.InputUi).Gamepad.GamepadUtils else nil
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle
local Interactable = UIBlox.Core.Control.Interactable
local ControlState = UIBlox.Core.Control.Enum.ControlState
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView
local ScrollBarType = UIBlox.App.Container.Enum.ScrollBarType
local ReactOtter = require(CorePackages.Packages.ReactOtter)
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper

local Foundation = require(CorePackages.Packages.Foundation)
local useCursor = Foundation.Hooks.useCursor

local Service = require(ChromeShared.Service)
local Chrome = require(CorePackages.Workspace.Packages.Chrome)
local ViewportUtil = require(ChromeShared.Service.ViewportUtil)
local Constants = require(ChromeShared.Unibar.Constants)
local MenuIconContext = if FFlagEnableConsoleExpControls then require(ChromeShared.Parent.Parent.TopBar.Components.MenuIconContext) else nil
local SubMenuContext = require(ChromeShared.Unibar.SubMenuContext)
local MenuTrailingBadge = if FFlagEnableMenuTrailingBadge then require(ChromeShared.Unibar.MenuTrailingBadge) else nil
local UnibarStyle = Chrome.UnibarStyle

local UserInputService = game:GetService("UserInputService")

local useChromeMenuItems = require(ChromeShared.Hooks.useChromeMenuItems)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)
local useTopbarInsetHeight = require(ChromeShared.Hooks.useTopbarInsetHeight)
local useMappedObservableValue = require(ChromeShared.Hooks.useMappedObservableValue)

local bool2 = game:DefineFastFlag("FixChromeIntegrationLayoutBug", false)

local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP

local UIManager = if isInExperienceUIVREnabled then require(CorePackages.Workspace.Packages.VrSpatialUi).UIManager else nil

local IconHost = require(ChromeShared.Unibar.ComponentHosts.IconHost)
local RoundedSlot = Foundation.Enums.CursorType.RoundedSlot

local vector2 = Vector2.new(0, 0)

local tbl1 = {}
local var1 = nil

function MenuRow(integration)
    local theme = useStyle().Theme
    local tbl2 = {
        Color = Color3.new(0, 0, 0),
        Transparency = 1
    }
    local iconSize, subMenuRowHeight, submenuPaddingLeft, submenuPaddingRight, submenuRowLabelFont, submenuRowPadding, submenuRowCornerRadius

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var2 = UnibarStyle.use()
        iconSize = var2.ICON_SIZE
        subMenuRowHeight = var2.SUB_MENU_ROW_HEIGHT
        submenuPaddingLeft = var2.SUBMENU_PADDING_LEFT
        submenuPaddingRight = var2.SUBMENU_PADDING_RIGHT
        submenuRowLabelFont = var2.SUBMENU_ROW_LABEL_FONT
        submenuRowPadding = var2.SUBMENU_ROW_PADDING
        submenuRowCornerRadius = var2.SUBMENU_ROW_CORNER_RADIUS
    else
        iconSize = Constants.ICON_SIZE
        subMenuRowHeight = Constants.SUB_MENU_ROW_HEIGHT
        submenuPaddingLeft = Constants.SUBMENU_PADDING_LEFT
        submenuPaddingRight = Constants.SUBMENU_PADDING_RIGHT
        submenuRowLabelFont = Constants.SUBMENU_ROW_LABEL_FONT
        submenuRowPadding = Constants.SUBMENU_ROW_PADDING
        submenuRowCornerRadius = Constants.SUBMENU_ROW_CORNER_RADIUS
    end

    local var2 = React.useContext(SubMenuContext)
    local var3 = if FFlagEnableConsoleExpControls then React.useContext(MenuIconContext) else nil
    local var4, var5 = React.useBinding(tbl2)

    local onStateChanged = React.useCallback(function(_, arg1)
        if arg1 == ControlState.Pressed then
            var5(theme.BackgroundOnPress)
        elseif arg1 == ControlState.Hover then
            var5(theme.BackgroundOnHover)
        else
            var5(tbl2)
        end
    end)

    local menuTrailingBadgeConfig = if FFlagEnableMenuTrailingBadge then integration.integration.menuTrailingBadgeConfig else nil

    local var7 = React.useCallback(function()
        if not FFlagEnableConsoleExpControls then
            integration.activated()

            return
        end

        Service:disableFocusNav()
        GuiService.SelectedCoreObject = nil
        Service:setShortcutBar(nil)
        Service:selectedItem():set(nil)
        integration.activated()
    end, { integration.id })

    local element = React.createElement(StyledTextLabel, {
        size = if FFlagEnableMenuTrailingBadge then UDim2.fromScale(1, 1) else UDim2.new(1, -iconSize - submenuPaddingLeft - submenuPaddingRight, 1, 0),
        lineHeight = 1,
        fontStyle = submenuRowLabelFont,
        colorStyle = var2 and {
            Color = theme.TextEmphasis.Color,
            Transparency = var2:map(function(arg1): number
                return 1 - arg1
            end)
        } or theme.TextEmphasis,
        text = integration.integration.label,
        textTruncate = Enum.TextTruncate.AtEnd,
        textXAlignment = Enum.TextXAlignment.Left,
        fluidSizing = true,
        richText = true
    })

    if FFlagEnableMenuTrailingBadge then
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(0, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                StyledTextLabel = element
            }
        )
    end
    local element2 = React.createElement(React.Fragment, nil, {
        UIPadding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, submenuPaddingLeft),
                PaddingRight = UDim.new(0, submenuPaddingRight)
            }
        ),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, submenuRowPadding)
        }),
        IconHost = React.createElement(IconHost, { integration = integration, disableButtonBehaviors = true }),
        Label = element,
        TrailingBadge = if FFlagEnableMenuTrailingBadge and menuTrailingBadgeConfig then React.createElement(MenuTrailingBadge, { integrationId = integration.integration.id, config = menuTrailingBadgeConfig }) else nil
    })

    local var8 = if not isInExperienceUIVREnabled or InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then 1 else UIManager.getInstance():getAdditionalCameraScaleIfNeeded()

    local createElement = React.createElement
    local var9 = Interactable

    local tbl3 = {
        Size = UDim2.new(1, 0, 0, subMenuRowHeight * var8),
        BorderSizePixel = 0,
        BackgroundTransparency = var4:map(function(arg1)
            return arg1.Transparency
        end),
        BackgroundColor3 = var4:map(function(arg1)
            return arg1.Color
        end),
        SelectionImageObject = useCursor(RoundedSlot),
        [React.Event.Activated] = var7,
        LayoutOrder = integration.order,
        onStateChanged = onStateChanged,
        NextSelectionLeft = if FFlagEnableConsoleExpControls then var3.menuIconRef else nil
    }

    local tbl4 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, submenuRowCornerRadius) }),
        RowLabel = 0
    }
    if bool2 then
        element2 = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                LayoutOrder = integration.order
            },
            { element2 }
        )
    end

    tbl4.RowLabel = element2
    return createElement(var9, tbl3, tbl4)
end

function isLeft(horizontalAlignment): boolean
    return horizontalAlignment == Enum.HorizontalAlignment.Left
end

function SubMenu(tbl2)
    local var2 = useStyle()

    local theme = var2.Theme
    local ref = React.useRef(nil)
    local var4 = useObservableValue(ViewportUtil.screenSize)
    local var5 = useTopbarInsetHeight()
    local unibarLeftMargin, iconCellWidth, unibarEndPadding, subMenuRowHeight, submenuCornerRadius, submenuBottomPadding

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var6 = UnibarStyle.use()
        unibarLeftMargin = var6.UNIBAR_LEFT_MARGIN
        iconCellWidth = var6.ICON_CELL_WIDTH
        unibarEndPadding = var6.UNIBAR_END_PADDING
        subMenuRowHeight = var6.SUB_MENU_ROW_HEIGHT
        submenuCornerRadius = var6.SUBMENU_CORNER_RADIUS
        submenuBottomPadding = var6.SUBMENU_BOTTOM_PADDING
    else
        unibarLeftMargin = Constants.UNIBAR_LEFT_MARGIN
        iconCellWidth = Constants.ICON_CELL_WIDTH
        unibarEndPadding = Constants.UNIBAR_END_PADDING
        subMenuRowHeight = Constants.SUB_MENU_ROW_HEIGHT
        submenuCornerRadius = Constants.SUBMENU_CORNER_RADIUS
        submenuBottomPadding = Constants.SUBMENU_BOTTOM_PADDING
    end
    local var6 = subMenuRowHeight * 0.5
    React.useEffect(function()
        local function moveLeft() -- Luacid: Inlined by compiler; 2 call sites recovered
            if ref.current and ref.current:IsAncestorOf(GuiService.SelectedCoreObject) then
                Service:setSelectedByOffset(-1)
            end
        end

        local function moveRight() -- Luacid: Inlined by compiler; 2 call sites recovered
            if ref.current and ref.current:IsAncestorOf(GuiService.SelectedCoreObject) then
                Service:setSelectedByOffset(1)
            end
        end

        local connection = if FFlagEnableConsoleExpControls then UserInputService.InputChanged:Connect(function(_inputObject: InputObject)
            for _, value in (UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1)) do
                if value.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                    continue
                end

                local x = GamepadUtils.normalizeStickByDeadzone(Vector2.new(value.Position.X, value.Position.Y)).X
                if x < -0.5 then
                    moveLeft()
                elseif x > 0.5 then
                    moveRight()
                end
            end
        end) else nil

        local connection2 = UserInputService.InputBegan:Connect(function(input: InputObject)
            local keyCode = input.KeyCode
            if keyCode == Enum.KeyCode.Left or keyCode == Enum.KeyCode.DPadLeft then
                moveLeft()
            elseif keyCode == Enum.KeyCode.Right or keyCode == Enum.KeyCode.DPadRight then
                moveRight()
            end
        end)

        return function()
            if FFlagEnableConsoleExpControls then
                connection:Disconnect()
            end
            connection2:Disconnect()
        end
    end, {})

    if bool1 then
        React.useEffect(function()
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str1)
        end, {})
    end

    local var7 = var5 + iconCellWidth
    local var8 = if tbl2 and tbl2.items then subMenuRowHeight * #tbl2.items else 0
    local var9 = var8 * (if not isInExperienceUIVREnabled or InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then 1 else UIManager.getInstance():getAdditionalCameraScaleIfNeeded())
    local vector2_2 = if tbl2.panelSize then tbl2.panelSize.Y else var9
    local var10 = isInExperienceUIVREnabled and isSpatial()
    local y = if var10 then math.min(var9, vector2_2) else math.min(var4.Y - var7, var8)

    if not var10 and var4.Y - var7 < var8 then
        local num1 = math.floor((var4.Y - var7) / subMenuRowHeight)
        if subMenuRowHeight * num1 + var6 <= var4.Y - var7 then
            y = subMenuRowHeight * num1 + var6
        else
            y = subMenuRowHeight * num1 - var6
        end
    end

    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        UISizeConstraint = React.createElement("UISizeConstraint", {
            MinSize = if not UserGameSettings.ReducedMotion and tbl2.menuTransition then tbl2.menuTransition:map(function(arg1): Vector2
                return Vector2.new(0, y * arg1)
            end) else Vector2.new(0, y)
        }),
        BottomPadding = React.createElement(
            "Frame",
            {
                Size = UDim2.new(0, 0, 0, submenuBottomPadding),
                BackgroundTransparency = 1,
                LayoutOrder = 10000
            }
        )
    }

    for _, item in tbl2.items do
        tbl3[item.id] = React.createElement(MenuRow, item)
    end

    local var11 = useMappedObservableValue(Service:orderAlignment(), isLeft)

    local var12 = var2.Theme.BackgroundUIContrast.Transparency * var2.Settings.PreferredTransparency
    local vector2_3 = if var10 then Vector2.new(0, 1) elseif var11 then Vector2.zero else Vector2.new(1, 0)
    local createElement = React.createElement
    local str2 = "Frame"

    local tbl4 = {
        Size = if var10 then UDim2.new(1, 0, 0, if var10 then math.min(var9, vector2_2) else var9) else UDim2.new(0, iconCellWidth * 4 + unibarLeftMargin + unibarEndPadding * 2, 0, 0),
        AnchorPoint = vector2_3,
        Position = if var10 then UDim2.new(0, 0, 1, 0) else UDim2.new(0, -var5 - 2 + unibarLeftMargin, 0, 0),
        BackgroundColor3 = theme.BackgroundUIContrast.Color,
        BackgroundTransparency = if tbl2.menuTransition then tbl2.menuTransition:map(function(arg1): number
            return var12 + (1 - var12) * (1 - arg1)
        end) else var12,
        AutomaticSize = if var10 then nil else Enum.AutomaticSize.Y,
        ref = ref,
        SelectionGroup = if FFlagEnableConsoleExpControls then true else nil,
        SelectionBehaviorDown = if FFlagEnableConsoleExpControls then Enum.SelectionBehavior.Stop else nil
    }

    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, submenuCornerRadius) }),
        ScrollingFrame = 0
    }
    local createElement2 = React.createElement
    local var14 = VerticalScrollView
    local tbl6 = {
        size = UDim2.new(1, 0, 1, 0),
        canvasSizeY = 0,
        selectable = false,
        scrollBarType = 0
    }
    local new = UDim.new
    local num1 = 0

    if var10 then
        var8 = var9
    end

    tbl6.canvasSizeY = new(num1, var8)

    tbl6.scrollBarType = ScrollBarType.Compact
    tbl5.ScrollingFrame = createElement2(var14, tbl6, tbl3)
    return createElement(str2, tbl4, tbl5)
end

return function(tbl2)
    local tbl3 = ({})

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = useObservableValue(Service:currentSubMenu())

    local _, var6 = React.useState(0)

    local var7 = useChromeMenuItems()
    local tbl4 = {}

    local var8, var9 = ReactOtter.useAnimatedBinding(0, function(arg1)
        var6(arg1)
    end)

    React.useEffect(function()
        tbl1 = tbl4
        var1 = var5

        if var5 then
            var6(0)
            var9(ReactOtter.spring(1, Constants.MENU_ANIMATION_SPRING))

            var4.current = UserInputService.TouchStarted:Connect(function(touch: InputObject)
                vector2 = Vector2.new(touch.Position.X, touch.Position.Y)
            end)

            var3.current = UserInputService.TouchTap:Connect(function(touchPositions: {Vector2})
                if touchPositions[1] - vector2 ~= Vector2.zero then
                    return
                end

                local var10 = Service:currentSubMenu():get()
                if var10 then
                    Service:toggleSubMenu(var10)
                end
            end)

            var2.current = UserInputService.InputEnded:Connect(function(input: InputObject, _: boolean)
                if isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter() then
                    return
                end

                local bool3 = input.UserInputType == Enum.UserInputType.MouseButton1

                local var10 = Service:currentSubMenu():get()
                if var10 and bool3 then
                    Service:toggleSubMenu(var10)
                end
            end)
        else
            var6(1)
            var9(ReactOtter.spring(0, Constants.MENU_ANIMATION_SPRING))
        end

        return function()
            if var2.current then
                var2.current:Disconnect()
                var2.current = nil
            end
            if var3.current then
                var3.current:Disconnect()
                var3.current = nil
            end
            if var4.current then
                var4.current:Disconnect()
                var4.current = nil
            end
        end
    end, { var5 })

    if var5 and var7 then
        for _, value in var7 do
            if var5 == value.id then
                tbl4 = value.children
                break
            end
        end
    end

    if #tbl4 > 0 then
        tbl3[var5] = React.createElement(SubMenu, { items = tbl4, menuTransition = var8, panelSize = tbl2.panelSize })
    elseif #tbl1 > 0 then
        tbl3[var1] = React.createElement(SubMenu, { items = tbl1, menuTransition = var8, panelSize = tbl2.panelSize })
    end

    return React.createElement("Frame", {
        Name = "SubMenuHost",
        Size = if isInExperienceUIVREnabled and isSpatial() then UDim2.new(1, 0, 1, 0) else UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ref = if FFlagUnibarMenuOpenSubmenu then tbl2.subMenuHostRef else nil
    }, React.createElement(SubMenuContext.Provider, { value = var8 }, tbl3))
end
