-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local _VRService = game:GetService("VRService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Chrome = scriptParentParentParent.Chrome

local Service = require(Chrome.Service)
local Constants = require(scriptParentParent.Constants)
local InGameMenuConstants = require(scriptParentParentParent.InGameMenuConstants)
local Constants2 = require(Chrome.ChromeShared.Unibar.Constants)

local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils
local Display = require(CorePackages.Workspace.Packages.Display)
local Foundation = require(CorePackages.Packages.Foundation)
local Motion = require(CorePackages.Packages.Motion)
local React = require(CorePackages.Packages.React)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local UIBlox = require(CorePackages.Packages.UIBlox)

local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local FFlagShowUnibarOnVirtualCursor = SharedFlags.FFlagShowUnibarOnVirtualCursor
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local FFlagEnablePlaytestModeUnibar = SharedFlags.FFlagEnablePlaytestModeUnibar

local View = Foundation.View
local Icon = Foundation.Icon
local ControlState = Foundation.Enums.ControlState
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor

local useIsPlaytestMode = require(Chrome.ChromeShared.Hooks.useIsPlaytestMode)

local getSideSheetVisibility = require(CorePackages.Workspace.Packages.InExperienceSideSheet).getSideSheetVisibility

local menuIconHoveredSignal = require(scriptParentParent.Components.Presentation.menuIconHoveredSignal)
local BadgeOver12 = require(scriptParentParent.Components.Presentation.BadgeOver12)
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation

local TooltipCallout = UIBlox.App.Dialog.TooltipCallout
local VrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
local UIManager = VrSpatialUi.UIManager
local Panel3DInSpatialUI = VrSpatialUi.Panel3DInSpatialUI
local PanelType = VrSpatialUi.Constants.PanelType
local SPATIAL_TOOLTIP_SPACING = VrSpatialUi.Constants.SPATIAL_TOOLTIP_SPACING
local function func1(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if not isSpatial() then
        return false
    end

    local var1 = Service:showTopBar()
    local var2 = UIManager.getInstance():isBottomBarInteractionOnAnimationSupported()
    return not (var1 or var2)
end

local tokens = if FFlagEnablePlaytestModeUnibar then Foundation.Utility.getTokens(Foundation.Enums.ColorMode.Light) else nil
local hotkeyCodes = { Enum.KeyCode.Escape }

local function MenuIcon(tbl2)
    local var1 = useTokens()
    local var2 = if FFlagEnablePlaytestModeUnibar then useIsPlaytestMode() else nil
    local style = if FFlagEnablePlaytestModeUnibar and var2 then tokens.Color.Content.Emphasis elseif isSideSheetEnabled then var1.Color.ActionEmphasis.Foreground else nil
    local overMedia0 = if FFlagEnablePlaytestModeUnibar and var2 then tokens.Color.OverMedia.OverMedia_0 else var1.Color.OverMedia.OverMedia_0

    local var4 = SignalsReact.useSignalState(function(arg1)
        return Display.GetDisplayStore(arg1).getUIScale(arg1)
    end)
    local var5 = Constants.TopBarButtonPadding * var4

    local size = Constants.MENU_ICON_SIZE * var4
    local var7 = React.useMemo(function()
        return {
            menuOpen = Motion.createState({ size = size * Constants.MenuIconOpenScale }),
            menuClosed = Motion.createState({ size = size })
        }
    end, { var4 })
    local var8, var9 = Motion.useMotion(var7.menuClosed)

    local var10, var11 = React.useBinding(GuiService.PreferredTransparency)

    local var12 = React.useRef(false)
    local var13 = React.useRef(false)

    local var14 = nil

    if tbl2.unibarMenuRef and tbl2.unibarMenuRef.current then
        local var15 = Service:menuList():get()[1]
        local var16 = if var15 then Constants2.ICON_NAME_PREFIX .. var15.id else nil

        if tbl2.unibarMenuRef.current and var16 then
            var14 = tbl2.unibarMenuRef.current:FindFirstChild(var16, true)
        else
            var14 = nil
        end
    end
    local active, var16 = React.useState(false)
    local var17, var18 = React.useState(Vector2.zero)
    local var19, var20 = React.useState(Vector2.zero)

    local selectionImageObject = useCursor(Foundation.Enums.CursorType.SkinToneCircle)

    local var22 = React.useRef("Roblox Menu")
    local tbl3 = {
        textAlignment = Enum.TextXAlignment.Center,
        headerText = var22.current,
        hotkeyCodes = hotkeyCodes
    }

    local tbl4 = {
        active = active,
        guiTarget = CoreGui,
        preferredOrientation = TooltipOrientation.Bottom,
        DisplayOrder = 10
    }

    React.useEffect(function()
        pcall(function()
            var22.current = RobloxTranslator:FormatByKey("CoreScripts.TopBar.RobloxMenu")
        end)

        local connection = GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
            var11(GuiService.PreferredTransparency)
        end)
        local connection2 = SettingsShowSignal:connect(function(arg1)
            var9(if arg1 then var7.menuOpen else var7.menuClosed)
        end)

        local effect = if isSideSheetEnabled then Signals.createEffect(function(arg1)
            local sideSheetVisibility = getSideSheetVisibility(arg1)
            var9(if sideSheetVisibility then var7.menuOpen else var7.menuClosed)
        end) else nil

        local connection3 = if tbl2.menuIconRef then Service:onTriggerMenuIcon():connect(function()
            GuiService.SelectedCoreObject = tbl2.menuIconRef.current
            FocusUtils.MenuIconSelectedSignal:set(true)
        end) else nil

        return function()
            if isSideSheetEnabled and effect then
                effect()
            end
            connection:Disconnect()
            connection2:Disconnect()
            if connection3 then
                connection3:disconnect()
            end
        end
    end, {})

    local var23 = React.useRef(ControlState.Default)
    local var24 = React.useCallback(function(current)
        if current == ControlState.Hover then
            if func1() then
                return
            end
            var13.current = true
            menuIconHoveredSignal:fire(true)

            task.delay(0.65, function()
                if not var13.current or var12.current then
                    return
                end

                if func1() then
                    return
                end
                var16(true)
            end)
        elseif current == ControlState.Selected then
            FocusUtils.MenuIconSelectedSignal:set(true)
        elseif current == ControlState.Default then
            if var23.current == ControlState.Hover then
                var16(false)
                var13.current = false
                var12.current = false
            elseif var23.current == ControlState.Selected then
                if not (FFlagShowUnibarOnVirtualCursor and GamepadService.GamepadCursorEnabled)
                    and GuiService.SelectedCoreObject
                    and string.find(GuiService.SelectedCoreObject.Name, Constants2.ICON_NAME_PREFIX)
                then
                    Service:enableFocusNav()
                end
                FocusUtils.MenuIconSelectedSignal:set(false)
            end
        end

        var23.current = current
    end, {})

    local var25 = React.useCallback(function()
        var16(false)
        var12.current = true

        if func1() then
            return
        end
        require(scriptParentParentParent.Settings.SettingsHub):ToggleVisibility(
            InGameMenuConstants.AnalyticsMenuOpenTypes.TopbarButton
        )
    end, {})

    local function renderWithTooltipCompat(arg1, arg2, arg3)
        if not isSpatial() then
            return withTooltip(arg1, arg2, arg3)
        end

        local function func2(arg4)
            var18(arg4.AbsoluteSize)
            var20(arg4.AbsolutePosition)
        end
        local renderFunction = React.useCallback(function(vector2: Vector2)
            return React.createElement(TooltipCallout, {
                textAlignment = Enum.TextXAlignment.Center,
                headerText = arg1.headerText,
                orientation = TooltipOrientation.Top,
                distanceOffset = 0,
                triggerPointCenter = Vector2.new(var19.X + var17.X / 2, vector2.Y - SPATIAL_TOOLTIP_SPACING),
                contentOffsetVector = Vector2.zero,
                triggerPointRadius = Vector2.zero
            })
        end, { arg1, var19, var17 })
        return React.createElement(React.Fragment, nil, {
            VRSpatialTooltip = if arg2.active and var17 and Panel3DInSpatialUI then React.createElement(Panel3DInSpatialUI, { panelType = PanelType.ToolTipsContainer, renderFunction = renderFunction }) else nil,
            MenuIconTriggerPoint = arg3(func2)
        })
    end

    return renderWithTooltipCompat(tbl3, tbl4, (React.useCallback(function(arg1)
        return React.createElement(View, {
            tag = "radius-circle aspect-1-1",
            backgroundStyle = if isSideSheetEnabled then nil else var10:map(function(arg2)
                local var26 = overMedia0
                var26.Transparency *= arg2
                return var26
            end),
            Size = if tbl2.buttonSize then UDim2.fromOffset(tbl2.buttonSize, tbl2.buttonSize) else UDim2.fromScale(1, 1),
            NextSelectionRight = var14,
            selection = isSideSheetEnabled and FFlagSideSheetFocusNav and { Selectable = false }
                or { Selectable = true, SelectionImageObject = selectionImageObject },
            selectionGroup = {
                SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            },
            ref = tbl2.menuIconRef,
            onAbsoluteSizeChanged = arg1,
            onAbsolutePositionChanged = arg1,
            onActivated = if isSideSheetEnabled then nil else var25,
            onStateChanged = if isSideSheetEnabled then nil else var24
        }, {
            BadgeOver12 = if tbl2.showBadgeOver12 then React.createElement(BadgeOver12, { position = UDim2.new(0, 1, 1, -(var5 + 1)) }) else nil,
            Icon = React.createElement(Icon, {
                name = Foundation.Enums.IconName.Tilt,
                size = var8.size,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                style = style
            })
        })
    end, {
        var10,
        var14,
        selectionImageObject,
        var25,
        var24,
        tbl2.showBadgeOver12,
        style,
        overMedia0,
        tbl2.buttonSize
    })))
end

return MenuIcon
