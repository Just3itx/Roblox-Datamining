-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local React = require(CorePackages.Packages.React)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagEnableWhatsNew = SharedFlags.FFlagEnableWhatsNew
local WhatsNewAnchor = if FFlagEnableWhatsNew then require(CorePackages.Workspace.Packages.WhatsNew).WhatsNewAnchor else nil
local Flags = require(script.Parent.Parent.Parent.Parent.Flags)
local FFlagUnibarMenuOpenHamburger = Flags.FFlagUnibarMenuOpenHamburger
local FFlagUnibarMenuOpenSubmenu = Flags.FFlagUnibarMenuOpenSubmenu

local Flags2 = require(ChromeShared.Flags)
local FFlagChromeNineDotActivityIndicator = Flags2.FFlagChromeNineDotActivityIndicator
local FFlagTokenizeUnibarConstantsWithStyleProvider = Flags2.FFlagTokenizeUnibarConstantsWithStyleProvider

local UIBlox = require(CorePackages.Packages.UIBlox)

local Foundation = require(CorePackages.Packages.Foundation)
local useCursor = Foundation.Hooks.useCursor
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant

local Interactable = UIBlox.Core.Control.Interactable
local ControlState = UIBlox.Core.Control.Enum.ControlState
local useStyle = UIBlox.Core.Style.useStyle
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip

local Constants = require(ChromeShared.Unibar.Constants)

local Service = require(ChromeShared.Service)
local ChromeAnalytics = require(ChromeShared.Analytics.ChromeAnalytics)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local useObservableValue = require(ChromeShared.Hooks.useObservableValue)
local useMappedObservableValueBinding = require(ChromeShared.Hooks.useMappedObservableValueBinding)
local useTimeHysteresis = require(ChromeShared.Hooks.useTimeHysteresis)
local shouldRejectMultiTouch = require(ChromeShared.Utility.shouldRejectMultiTouch)

local ChatNotificationBadge = require(script.Parent.ChatNotificationBadge)
local NineDotActivityIndicator = require(script.Parent.NineDotActivityIndicator)
local NineDotNotificationBadge = require(script.Parent.NineDotNotificationBadge)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local isSpatial = nil
local Panel3DInSpatialUI = nil
local PanelType = nil
local TooltipOrientation = nil
local TooltipCallout = nil
local SPATIAL_TOOLTIP_SPACING = nil

local var1 = nil
if isInExperienceUIVREnabled then
    isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    Panel3DInSpatialUI = vrSpatialUi.Panel3DInSpatialUI
    PanelType = vrSpatialUi.Constants.PanelType
    TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
    TooltipCallout = UIBlox.App.Dialog.TooltipCallout
    SPATIAL_TOOLTIP_SPACING = vrSpatialUi.Constants.SPATIAL_TOOLTIP_SPACING
    local uiManager = vrSpatialUi.UIManager
    local mappedSignal = require(ChromeShared.Service.ChromeUtils).MappedSignal
    local bottomBarVisibility = uiManager.getInstance():getBottomBarVisibility()
    if bottomBarVisibility and isSpatial() then
        var1 = mappedSignal.new(bottomBarVisibility, function()
            return bottomBarVisibility:get()
        end)
    end
end

local MenuIconContext = if FFlagEnableConsoleExpControls then require(ChromeShared.Parent.Parent.TopBar.Components.MenuIconContext) else nil
local tbl1 = ({})

function areTooltipsDisplaying()
    local now = tick()
    for _, value in tbl1 do
        if value.displaying or now - value.time < 0.15 then
            return true
        end
    end
    return false
end

function logTooltipState(id, displaying: boolean)
    if not tbl1[id] or tbl1[id].displaying ~= displaying then
        tbl1[id] = {
            displaying = displaying,
            time = tick()
        }
    end
end

function NotificationBadge(tbl2)
    if not tbl2.integration then
        return nil
    end

    local notification = if tbl2.integration.integration then tbl2.integration.integration.notification or nil else nil
    local var2, var3 = React.useBinding(notification and notification:get().value or 0)
    local var4 = var3
    local var5, var6 = React.useState(false)
    local var7 = var6

    React.useEffect(function()
        if not notification then
            return
        end

        local connection = notification:connect(function()
            local value = notification:get().value or 0
            var7(value > 0)
            var4(value)
        end)
        return function()
            connection:disconnect()
        end
    end, { tbl2.integration.integration.id })

    local iconBadgeOffsetX, iconBadgeOffsetY

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var8 = UnibarStyle.use()
        iconBadgeOffsetX = var8.ICON_BADGE_OFFSET_X
        iconBadgeOffsetY = var8.ICON_BADGE_OFFSET_Y
    else
        iconBadgeOffsetX = Constants.ICON_BADGE_OFFSET_X
        iconBadgeOffsetY = Constants.ICON_BADGE_OFFSET_Y
    end

    local minBadgeCount = tbl2.minBadgeCount or 0

    local hasNotificationBadge = var5 or minBadgeCount > 0

    local value = var2:map(function(arg1): number
        return math.min(math.max(arg1, minBadgeCount), 99)
    end)

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Visible = not tbl2.toggleTransition or tbl2.toggleTransition:map(function(_): boolean
            return true
        end) or true,
        ZIndex = 2
    }, {
        Badge = if hasNotificationBadge then React.createElement(StatusIndicator, {
            value = value,
            variant = StatusIndicatorVariant.Emphasis,
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.new(0, iconBadgeOffsetX, 0, iconBadgeOffsetY)
        }) else nil,
        ActivityIndicator = if FFlagChromeNineDotActivityIndicator and tbl2.integration.id == "nine_dot" then React.createElement(
            NineDotActivityIndicator,
            {
                hasNotificationBadge = hasNotificationBadge,
                position = UDim2.new(0, iconBadgeOffsetX, 0, iconBadgeOffsetY),
                visible = tbl2.showNineDotActivityIndicator == true
            }
        ) else nil
    })
end

function NotificationIndicator(tbl2)
    local var2 = useObservableValue(Service:notificationIndicator())
    tbl2.setIconVisible(not var2)

    return (React.createElement(
        "Frame",
        {
            Name = "NotificationIndicatorFrame",
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        },
        {
            IntegrationIcon = var2 and var2.component(tbl2) or nil,
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            })
        }
    ))
end

function HighlightCircle(arg1)
    local iconHighlightSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_HIGHLIGHT_SIZE else Constants.ICON_HIGHLIGHT_SIZE
    return React.createElement("Frame", {
        Name = arg1.name or "Highlighter",
        Size = iconHighlightSize,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = arg1.color.Color,
        BackgroundTransparency = arg1.color.Transparency,
        BorderSizePixel = 0,
        Visible = arg1.visible
    }, {
        corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
    })
end

function TooltipButton(tbl2)
    local iconHighlightSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_HIGHLIGHT_SIZE else Constants.ICON_HIGHLIGHT_SIZE
    local var2 = React.useRef(nil)
    local secondaryAction = tbl2.integration.integration.secondaryAction
    local draggable = tbl2.integration.integration.draggable or false
    local var3 = React.useRef(nil)

    React.useEffect(function()
        return function()
            if var3.current then
                var3.current:Disconnect()
                var3.current = nil
            end
        end
    end, {})

    local var4, var5

    if secondaryAction then
        local var6
        var4, var6 = useTimeHysteresis(0.05, 0.15, 0.35)
        var5 = var6
    else
        local var6
        var4, var6 = useTimeHysteresis(0.6, 0.65, 0.7)
        var5 = var6
    end

    local var6, var7 = useTimeHysteresis(0, 0, 0.65)
    local var8, var9 = React.useState(false)

    local var10, var11 = useTimeHysteresis(0, 1)
    local var12 = if isInExperienceUIVREnabled then isSpatial() else nil
    local var13 = if isInExperienceUIVREnabled then useObservableValue(Service:getTopBarVisibiity()) else nil
    local var14 = if isInExperienceUIVREnabled and var1 then useObservableValue(var1) else nil
    local bool1 = false
    if isInExperienceUIVREnabled and var12 and not (var13 or var14) then
        bool1 = true
        draggable = draggable and not bool1
    end

    local onStateChanged = React.useCallback(function(arg1, arg2)
        if isInExperienceUIVREnabled and bool1 then
            return
        end

        if arg2 == ControlState.Selected and (arg1 == ControlState.Default or arg1 == ControlState.Hover)
            or arg2 == ControlState.Selected and arg1 == ControlState.Default
        then
            Service:setSelected(tbl2.integration.id)
        end

        local bool2 = arg2 ~= ControlState.Default
        tbl2.setHovered(bool2)
        local bool3 = arg2 == ControlState.Hover
        var5(bool3, bool3 and var6 or areTooltipsDisplaying())
        if bool3 then
            Service:onIntegrationHovered():fire(tbl2.integration.id)
        end
        if not bool2 then
            var11(false)
        end
    end, isInExperienceUIVREnabled and {
        tbl2.setHovered,
        var5,
        var11,
        var6,
        var12,
        bool1
    }
        or {
            tbl2.setHovered,
            var5,
            var11,
            var6
        })

    local var16 = React.useCallback(function(_, arg1)
        if not draggable then
            return
        end

        if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        local position = arg1.Position
        var11(true, true)
        ChromeAnalytics.default:onIconTouchBegan(tbl2.integration.id)

        if var3.current then
            return
        end

        var3.current = UserInputService.InputChanged:Connect(function(input: InputObject, _: boolean)
            if shouldRejectMultiTouch(arg1, input) or Service:isWindowOpen(tbl2.integration.id) or not var3.current then
                return
            end

            local inputPosition = input.Position

            if math.abs((position - inputPosition).Magnitude) > Constants.DRAG_MAGNITUDE_THRESHOLD then
                ChromeAnalytics.default:onIconDrag(tbl2.integration.id)
                Service:storeChromeInteracted()
                Service:toggleWindow(tbl2.integration.id)
                Service:gesture(tbl2.integration.id, var3, arg1)
            end
        end)
    end, { draggable })
    local var17 = React.useCallback(function(_, arg1)
        if not draggable then
            return
        end

        if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        var11(false)
        if var3.current then
            var3.current:Disconnect()
            var3.current = nil
            Service:gesture(tbl2.integration.id, nil)
        end
    end, { draggable })

    local bool2 = (var4 or var6 or var8) and not var10
    if isInExperienceUIVREnabled and bool2 and bool1 then
        bool2 = false
    end

    logTooltipState(tbl2.integration.id, bool2)
    local var18 = if FFlagEnableConsoleExpControls then React.useContext(MenuIconContext) else nil
    local useCallback = React.useCallback

    local function func1(arg1)
        local id = if FFlagEnableConsoleExpControls then Service:menuList():get()[1].id else nil
        local createElement = React.createElement
        local var19 = Interactable

        local tbl3 = {
            Name = (if FFlagEnableConsoleExpControls then Constants.ICON_NAME_PREFIX else "IconHitArea_") .. tbl2.integration.id,
            Size = iconHighlightSize,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            onStateChanged = onStateChanged,
            ref = var2,
            SelectionOrder = if FFlagUnibarMenuOpenHamburger or FFlagUnibarMenuOpenSubmenu then tbl2.integration.order else 100 - tbl2.integration.order,
            Position = tbl2.isCurrentlyOpenSubMenu:map(function(bool3: boolean?): UDim2
                return UDim2.new(0.5, 0, 0.5, if FFlagEnableConsoleExpControls or not bool3 then 0 else 1)
            end),
            SelectionImageObject = useCursor(Foundation.Enums.CursorType.SkinToneCircle),
            SelectionGroup = true,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = tbl2.isCurrentlyOpenSubMenu:map(function(bool3: boolean?): Enum.SelectionBehavior
                return if bool2 and secondaryAction or bool3 then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop
            end),
            NextSelectionLeft = if FFlagEnableConsoleExpControls and tbl2.integration.id == id then var18.menuIconRef else nil,
            [React.Change.AbsolutePosition] = arg1,
            [React.Change.AbsoluteSize] = arg1,
            [React.Event.InputBegan] = var16,
            [React.Event.InputEnded] = var17
        }

        tbl3[React.Event.Activated] = function()
            if isInExperienceUIVREnabled and var12 then
                if bool1 then
                    return
                end
                Service:onTriggerVRToggleButton():fire(true)
            end

            var11(true, true)
            tbl2.integration.activated()
            if var3.current then
                var3.current:Disconnect()
                var3.current = nil
                Service:gesture(tbl2.integration.id, nil)
            end
        end

        return createElement(var19, tbl3, { corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    end

    local var19 = var5

    local isCurrentlyOpenSubMenu = tbl2.isCurrentlyOpenSubMenu
    local var20 = bool2
    local bool3 = if isInExperienceUIVREnabled then bool1 else nil
    local menuIconRef = if FFlagEnableConsoleExpControls then var18.menuIconRef else nil
    local var21 = useCallback(
        func1,
        {
            onStateChanged,
            var19,
            var11,
            var16,
            var17,
            isCurrentlyOpenSubMenu,
            var20,
            secondaryAction,
            bool3,
            menuIconRef
        }
    )

    local var22 = React.useRef(nil)
    local var23 = React.useCallback(function(current)
        local connection = nil
        local connection2 = nil
        local connection3 = nil
        local function func2()
            if connection then
                connection:disconnect()
                connection = nil
            end
            if connection2 then
                connection2:disconnect()
                connection2 = nil
            end
            if connection3 then
                connection3:disconnect()
                connection3 = nil
            end
        end

        if current == var22.current then
            return
        end

        pcall(func2)
        if current then
            connection = current.MouseEnter:Connect(function()
                var7(true, true)
            end)
            connection2 = current.MouseLeave:Connect(function()
                var7(false)
            end)
            connection3 = current.Destroying:Connect(function()
                var7(false)
            end)
        end
        var22.current = current
    end, { var7 })

    local buttonProps = secondaryAction
        and {
            text = secondaryAction.label,
            onStateChanged = function(_, selected)
                if selected == ControlState.Selected then
                    var9(true)
                    return
                end
                var9(false)
            end,
            onActivated = function()
                secondaryAction.activated(tbl2.integration)
            end,
            NextSelectionUp = var2,
            NextSelectionLeft = var2,
            NextSelectionRight = var2,
            NextSelectionDown = var2
        }
        or nil

    if not (isInExperienceUIVREnabled and var12) then
        return withTooltip({
            headerText = tbl2.integration.integration.label,
            hotkeyCodes = tbl2.integration.integration.hotkeyCodes,
            textAlignment = Enum.TextXAlignment.Left,
            buttonProps = buttonProps,
            ref = if secondaryAction then var23 else nil
        }, { active = bool2, guiTarget = CoreGui, DisplayOrder = 10 }, var21)
    end

    local var25, var26 = React.useBinding(Vector2.zero)
    local var27, var28 = React.useBinding(Vector2.zero)

    local var29 = React.useCallback(function(arg1)
        var26(arg1.AbsolutePosition)
        var28(arg1.AbsoluteSize)
    end, { var26, var28 })

    return React.createElement(React.Fragment, nil, {
        VRSpatialTooltip = if bool2 and Panel3DInSpatialUI then React.createElement(Panel3DInSpatialUI, {
            panelType = PanelType.ToolTipsContainer,
            renderFunction = function(vector2: Vector2)
                local vector2_2 = Vector2.new(var25:getValue().X + var27:getValue().X / 2, vector2.Y - SPATIAL_TOOLTIP_SPACING)

                return React.createElement(TooltipCallout, {
                    textAlignment = Enum.TextXAlignment.Center,
                    headerText = tbl2.integration.integration.label,
                    orientation = TooltipOrientation.Top,
                    distanceOffset = 0,
                    triggerPointCenter = vector2_2,
                    contentOffsetVector = Vector2.zero,
                    triggerPointRadius = Vector2.zero,
                    buttonProps = buttonProps,
                    ref = if secondaryAction then var23 else nil
                })
            end
        }) else nil,
        var21(var29)
    })
end

function IconHost(iconHostProps)
    if not (iconHostProps.integration and iconHostProps.integration.component) then
        warn("IconHost has no component to render")
    end

    local visible, setHovered = React.useBinding(false)
    local var4, setIconVisible = React.useBinding(true)

    local backgroundOnHover = useStyle().Theme.BackgroundOnHover
    local iconCellWidth = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_CELL_WIDTH else Constants.ICON_CELL_WIDTH

    local var6 = useMappedObservableValueBinding(Service:currentSubMenu(), function(id): boolean
        return id == iconHostProps.integration.id
    end)

    local tbl2 = {
        React.createElement("Frame", {
            Name = "IntegrationIconFrame",
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Visible = var4
        }, {
            IntegrationIcon = if iconHostProps.integration and iconHostProps.integration.component then iconHostProps.integration.component(iconHostProps) or nil else nil,
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            })
        }),
        if iconHostProps.integration.integration.flashNotificationSource then React.createElement(NotificationIndicator, { integration = iconHostProps.integration, setIconVisible = setIconVisible }) else nil,
        React.createElement(HighlightCircle, { name = "SelectedHighlighter", color = backgroundOnHover, visible = var6 }),
        React.createElement(HighlightCircle, { name = "Highlighter", color = backgroundOnHover, visible = visible }),
        if iconHostProps.integration.id == "chat" then React.createElement(ChatNotificationBadge, { iconHostProps = iconHostProps, NotificationBadge = NotificationBadge }) elseif FFlagChromeNineDotActivityIndicator and iconHostProps.integration.id == "nine_dot" then React.createElement(NineDotNotificationBadge, { iconHostProps = iconHostProps, NotificationBadge = NotificationBadge }) else React.createElement(NotificationBadge, iconHostProps),
        if iconHostProps.disableButtonBehaviors then nil else React.createElement(
            TooltipButton,
            {
                integration = iconHostProps.integration,
                setHovered = setHovered,
                isCurrentlyOpenSubMenu = var6
            }
        )
    }

    local tbl3 = {
        Size = UDim2.new(0, iconCellWidth, 0, iconCellWidth),
        LayoutOrder = iconHostProps.integration.order,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = iconHostProps.position,
        Visible = iconHostProps.visible,
        ZIndex = if FFlagEnableConsoleExpControls then nil else iconHostProps.integration.order
    }

    if not FFlagEnableWhatsNew then
        return React.createElement("Frame", tbl3, tbl2)
    end

    return React.createElement("Frame", tbl3, {
        WhatsNewAnchor = React.createElement(WhatsNewAnchor, { anchorId = iconHostProps.integration.id, tag = "size-full" }, tbl2)
    })
end
return IconHost
