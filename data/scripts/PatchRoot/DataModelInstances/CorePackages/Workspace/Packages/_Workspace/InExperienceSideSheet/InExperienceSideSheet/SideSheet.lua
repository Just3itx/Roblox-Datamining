-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Chrome = require(InExperienceSideSheetParent.Chrome)
local CoreScriptsCommon = require(InExperienceSideSheetParent.CoreScriptsCommon)
local Display = require(InExperienceSideSheetParent.Display)
local Drawer = require(InExperienceSideSheetParent.Drawer)
local FocusNavigationUtils = require(InExperienceSideSheetParent.FocusNavigationUtils)
local Foundation = require(InExperienceSideSheetParent.Foundation)
local isPioneerLaunch = require(InExperienceSideSheetParent.PioneerUtils).isPioneerLaunch
local React = require(InExperienceSideSheetParent.React)
local ReactRoblox = require(InExperienceSideSheetParent.ReactRoblox)
local Responsive = require(InExperienceSideSheetParent.Responsive)
local Signals = require(InExperienceSideSheetParent.Signals)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)
local SwitchServer = require(InExperienceSideSheetParent.SwitchServer)

local Divider = Foundation.Divider
local DrawerContainer = Drawer.DrawerContainer
local ExperienceDetailsRow = require(InExperienceSideSheet.Components.ExperienceDetailsRow)
local Footer = require(InExperienceSideSheet.Components.Footer)
local UserProfileRow = require(InExperienceSideSheet.Components.UserProfileRow)
local ScrollView = Foundation.ScrollView
local SideSheetWidgetList = require(InExperienceSideSheet.Components.SideSheetWidgetList)
local VerticalList = require(InExperienceSideSheet.Components.VerticalList)
local View = Foundation.View
local FocusRoot = FocusNavigationUtils.FocusRoot
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local SidesheetAnalytics = require(InExperienceSideSheet.Analytics.SidesheetAnalytics)

local useDrawerShouldMount = Drawer.Hooks.useDrawerShouldMount
local useScaledValue = Foundation.Hooks.useScaledValue
local useStyleSheet = Foundation.Hooks.useStyleSheet
local useBackgroundStyle = require(InExperienceSideSheet.Hooks.useBackgroundStyle)
local useSideSheetFocusNavScrollViewAnimation = require(InExperienceSideSheet.Hooks.useSideSheetFocusNavScrollViewAnimation)

local GetIntegrationsStore = require(InExperienceSideSheet.Stores.GetIntegrationsStore)
local GetSideSheetConfigStore = require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)
local GetSwitchServerStore = SwitchServer.GetSwitchServerStore

local wrapWithProviders = require(InExperienceSideSheet.Utils.wrapWithProviders)
local closePeoplePageOpenedWithSideSheet = require(InExperienceSideSheet.Utils.closePeoplePageOpenedWithSideSheet)
local getDidSideSheetOpenWithPeoplePage = require(InExperienceSideSheet.Utils.getDidSideSheetOpenWithPeoplePage)
local getIsPeoplePageOpen = require(InExperienceSideSheet.Utils.getIsPeoplePageOpen)
local getSideSheetVisibility = require(InExperienceSideSheet.Utils.getSideSheetVisibility)
local nextWrappedInteger = require(InExperienceSideSheetParent.AppCommonLib).nextWrappedInteger
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local Flags = require(InExperienceSideSheet.Flags)
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagMountUnmountSideSheet = Flags.FFlagMountUnmountSideSheet
local FFlagSideSheetOpenPeoplePage = Flags.FFlagSideSheetOpenPeoplePage
local FFlagSideSheetOpenPeoplePageRestoreChat = Flags.FFlagSideSheetOpenPeoplePageRestoreChat
local FFlagSideSheetUnifiedMenuOrder = SharedFlags.FFlagSideSheetUnifiedMenuOrder
local FFlagEnableSideSheetWidgets = SharedFlags.FFlagEnableSideSheetWidgets
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local FFlagEnableWhatsNew = SharedFlags.FFlagEnableWhatsNew
local FFlagUseAnimateScrollViewToSelectionHelper = SharedFlags.FFlagUseAnimateScrollViewToSelectionHelper
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local var1 = FFlagEnableSideSheetWidgets or isPioneerLaunch()
local WhatsNewAnchor = if FFlagEnableWhatsNew then require(InExperienceSideSheetParent.WhatsNew).WhatsNewAnchor else nil
local SwitchServerTelemetry = SwitchServer.SwitchServerTelemetry

local tbl1 = {
    Enum.KeyCode.Left,
    Enum.KeyCode.Right,
    Enum.KeyCode.Up,
    Enum.KeyCode.Down,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D
}

local tbl2 = {
    ExperienceDetails = 0,
    HeaderDivider = 1,
    TopWidgets = 2,
    PrimaryList = if var1 then 3 else 2,
    ListDivider = if var1 then 4 else 3,
    SecondaryList = if var1 then 5 else 4,
    BottomWidgets = if var1 then 6 else 5
}

local module = ({})

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local MouseIconOverrideService = CoreScriptsCommon.MouseIconOverrideService

local usePreferredInput = Responsive.usePreferredInput

local function getDeviceSafePadding(arg1)
    return Display.GetDisplayStore(arg1).getDeviceSafePadding(arg1)
end

local function getAboveFoldIntegrations(arg1)
    return GetIntegrationsStore(arg1).getAboveFoldIntegrations(arg1)
end

local function getBelowFoldIntegrations(arg1)
    return GetIntegrationsStore(arg1).getBelowFoldIntegrations(arg1)
end

local function getScrollableContentTopWidgetIntegrations(arg1)
    return GetIntegrationsStore(arg1).getScrollableContentTopWidgetIntegrations(arg1)
end

local function getScrollableContentBottomWidgetIntegrations(arg1)
    return GetIntegrationsStore(arg1).getScrollableContentBottomWidgetIntegrations(arg1)
end

local useFocusGuiObject = if FFlagSideSheetFocusNav then require(InExperienceSideSheetParent.ReactFocusNavigation).useFocusGuiObject else nil

local root = nil
local function SideSheetContent(tbl3)
    local menuWidth = useScaledValue(320)
    local styleSheet = useStyleSheet()
    local backgroundStyle = useBackgroundStyle()
    local var5 = SignalsReact.useSignalState(getDeviceSafePadding)
    local var6 = not FFlagMountUnmountSideSheet or useDrawerShouldMount()
    local var7 = if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(getSideSheetVisibility) else false
    local var8 = if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(getIsPeoplePageOpen) else false
    local allowRightFocusEscape = (if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(getDidSideSheetOpenWithPeoplePage) else false)
        and var7
        and var8

    local var10 = SignalsReact.useSignalState(getScrollableContentTopWidgetIntegrations)
    local var11 = var1 and #var10 > 0

    local onDrawerClosedAnalytics = React.useCallback(function(arg1)
        SidesheetAnalytics.logSidesheetClosed(arg1.source)
    end, {})

    local var13 = nil
    local var14 = nil
    local var15 = nil
    local var16

    if FFlagSideSheetFocusNav then
        var13 = React.useRef(nil)
        var14 = useFocusGuiObject()
        var15 = useLastInputMode()
        var16 = React.useCallback(function(arg1)
            if var15 == "Focus" and var13 and var13.current == false then
                var13.current = true
                var14(arg1)
            end
        end, { var14, var15 })
    else
        var16 = nil
    end

    local var17 = React.useRef(false)
    local var18 = if FFlagSideSheetOpenPeoplePageRestoreChat then React.useRef(nil) else nil
    local var19 = if FFlagSideSheetOpenPeoplePageRestoreChat then React.useRef(false) else nil
    local var20 = if FFlagSideSheetOpenPeoplePageRestoreChat then React.useRef(0) else nil
    local var21 = React.useRef(false)
    local var22 = usePreferredInput()

    local var23 = React.useRef(false)

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local sideSheetVisibility = getSideSheetVisibility(arg1)

            if FFlagSideSheetOpenPeoplePageRestoreChat
                and tbl3.ChatSelector
                and sideSheetVisibility
                and not (var18.current or var19.current)
            then
                local current = tbl3.ChatSelector:GetVisibility()
                if GuiService.MenuIsOpen and not current then
                    var17.current = UserSettings().GameSettings.ChatVisible
                else
                    var17.current = current
                end
            end

            GuiService:SetMenuIsOpen(sideSheetVisibility, "InExperienceSideSheet")

            if not FFlagSideSheetOpenPeoplePageRestoreChat or not tbl3.ChatSelector then
                return
            end

            if sideSheetVisibility then
                var20.current = nextWrappedInteger(var20.current)
                var19.current = false
                if var18.current then
                    var18.current:Disconnect()
                    var18.current = nil
                end
                tbl3.ChatSelector:SetVisible(false)
                return
            end
            if not var17.current or var18.current or var19.current then
                return
            end
            local function restoreChat() -- Luacid: Inlined by compiler; 2 call sites recovered
                if var18.current then
                    var18.current:Disconnect()
                end
                var18.current = nil
                var19.current = false
                tbl3.ChatSelector:SetVisible(true)
                var17.current = false
            end

            if not GuiService.MenuIsOpen then
                restoreChat()
                return
            end

            var18.current = GuiService.MenuClosed:Once(function()
                local current = var20.current
                var19.current = true
                if var18.current then
                    var18.current:Disconnect()
                    var18.current = nil
                end
                task.defer(function()
                    if var20.current ~= current or getSideSheetVisibility() then
                        var19.current = false
                        return
                    end

                    restoreChat()
                end)
            end)
        end)

        return function()
            effect()
            if FFlagSideSheetOpenPeoplePageRestoreChat then
                var20.current = nextWrappedInteger(var20.current)
                var19.current = false
            end
            if FFlagSideSheetOpenPeoplePageRestoreChat and var18.current then
                var18.current:Disconnect()
                var18.current = nil
            end

            if GuiService.MenuIsOpen then
                GuiService:SetMenuIsOpen(false, "InExperienceSideSheet")
            end
        end
    end, { if FFlagSideSheetOpenPeoplePageRestoreChat then tbl3.ChatSelector else nil })

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local sideSheetVisibility = getSideSheetVisibility(arg1)

            if not FFlagSideSheetOpenPeoplePageRestoreChat and tbl3.ChatSelector then
                if sideSheetVisibility then
                    var17.current = tbl3.ChatSelector:GetVisibility()
                    tbl3.ChatSelector:SetVisible(false)
                elseif var17.current then
                    tbl3.ChatSelector:SetVisible(true)
                    var17.current = false
                end
            end

            if var22 == Responsive.Input.Pointer then
                if sideSheetVisibility and not var21.current then
                    MouseIconOverrideService.push("InExperienceSideSheet", Enum.OverrideMouseIconBehavior.ForceShow)
                    var21.current = true
                elseif not sideSheetVisibility and var21.current then
                    MouseIconOverrideService.pop("InExperienceSideSheet")
                    var21.current = false
                end
            end

            if FFlagSideSheetFocusNav then
                if sideSheetVisibility then
                    var13.current = false
                else
                    var13.current = nil
                end
            end

            if sideSheetVisibility
                and (FFlagShowSwitchServerButton or isPioneerLaunch())
                and GetSwitchServerStore(arg1).shouldEnableSwitchServer(arg1)
                and not var23.current
            then
                var23.current = true
                SwitchServerTelemetry.sendSwitchServerButtonActions({ event_type = "impression" })
            end
        end)

        local connection = if tbl3.ChatSelector then tbl3.ChatSelector.VisibilityStateChanged:connect(function(arg1)
            if getSideSheetVisibility() and arg1 then
                var17.current = false
            end
        end) else nil

        return function()
            effect()
            if connection ~= nil then
                connection:disconnect()
            end
        end
    end, { tbl3.ChatSelector, var22 })

    if FFlagSideSheetFocusNav then
        React.useEffect(function()
            ContextActionService:BindCoreAction("SideSheetBlockInputAction", function(_, userInputState, _)
                if userInputState == Enum.UserInputState.Begin then
                    if var13.current == nil then
                        return Enum.ContextActionResult.Pass
                    end

                    return Enum.ContextActionResult.Sink
                end

                return Enum.ContextActionResult.Pass
            end, false, unpack(tbl1))

            ContextActionService:BindCoreAction("SideSheetSinkR2Action", function(_, _, _): Enum.ContextActionResult
                return if getSideSheetVisibility() then Enum.ContextActionResult.Sink else Enum.ContextActionResult.Pass
            end, false, Enum.KeyCode.ButtonR2)

            ContextActionService:BindCoreAction("SideSheetCloseAction", function(_, userInputState, _)
                if FFlagSideSheetOpenPeoplePage and userInputState ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end
                if not getSideSheetVisibility() then
                    return Enum.ContextActionResult.Pass
                end

                toggleSideSheet(false)
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

            return function()
                ContextActionService:UnbindCoreAction("SideSheetBlockInputAction")
                ContextActionService:UnbindCoreAction("SideSheetSinkR2Action")
                ContextActionService:UnbindCoreAction("SideSheetCloseAction")
            end
        end, {})
    end

    local var24 = if FFlagSideSheetFocusNav and FFlagUseAnimateScrollViewToSelectionHelper then useSideSheetFocusNavScrollViewAnimation() else nil
    local left = var5.left

    if FFlagSideSheetOpenPeoplePage then
        React.useEffect(function()
            GetSideSheetConfigStore(false).setSideSheetDrawerWidth(menuWidth)
        end, { menuWidth })

        React.useEffect(function(): (() -> ())?
            return if var7 then function()
                closePeoplePageOpenedWithSideSheet()
            end else nil
        end, { var7 })
    end

    if not var6 then
        return nil
    end

    local headerRow = if isPioneerLaunch() then React.createElement(UserProfileRow, { layoutOrder = tbl2.ExperienceDetails }) else React.createElement(ExperienceDetailsRow, { layoutOrder = tbl2.ExperienceDetails })
    local var25 = FFlagSideSheetUnifiedMenuOrder

    local tbl4 = {
        HeaderRow = headerRow,
        HeaderDivider = if var11 then nil else React.createElement(
            View,
            {
                tag = "size-full-0 auto-y",
                LayoutOrder = tbl2.HeaderDivider
            },
            {
                Divider = React.createElement(Divider)
            }
        ),
        TopWidgets = if var1 then React.createElement(SideSheetWidgetList, {
            integrationsGetter = getScrollableContentTopWidgetIntegrations,
            layoutOrder = tbl2.TopWidgets,
            placement = Chrome.Enums.SideSheetPlacement.ScrollableContentTop,
            firstIntegrationToFocusCallback = if FFlagSideSheetFocusNav and var11 then var16 else nil
        }) else nil,
        AboveFoldList = React.createElement(VerticalList, {
            layoutOrder = tbl2.PrimaryList,
            integrationsGetter = getAboveFoldIntegrations,
            firstIntegrationToFocusCallback = if FFlagSideSheetFocusNav and not (var11 or var25) then var16 else nil,
            allowRightFocusEscape = allowRightFocusEscape
        }),
        FoldDivider = if var25 then nil else React.createElement(
            View,
            {
                tag = "size-full-0 auto-y padding-y-xxlarge",
                LayoutOrder = tbl2.ListDivider
            },
            {
                Divider = React.createElement(Divider)
            }
        ),
        BelowFoldList = 0,
        BottomWidgets = 0
    }

    local createElement = React.createElement
    local var26 = VerticalList
    local tbl5 = {
        layoutOrder = tbl2.SecondaryList,
        integrationsGetter = getBelowFoldIntegrations,
        firstIntegrationToFocusCallback = 0,
        allowRightFocusEscape = 0
    }

    if not var25 or not FFlagSideSheetFocusNav or var11 then
        var16 = nil
    end

    tbl5.firstIntegrationToFocusCallback = var16

    tbl5.allowRightFocusEscape = allowRightFocusEscape
    tbl4.BelowFoldList = createElement(var26, tbl5)

    tbl4.BottomWidgets = if var1 then React.createElement(SideSheetWidgetList, {
        integrationsGetter = getScrollableContentBottomWidgetIntegrations,
        layoutOrder = tbl2.BottomWidgets,
        placement = Chrome.Enums.SideSheetPlacement.ScrollableContentBottom
    }) else nil

    local createElement2 = React.createElement
    local var27 = View
    local tbl6 = { tag = "col size-full" }

    local tbl7 = { ScrollableContent = 0, Footer = 0 }
    local createElement3 = React.createElement
    local var28 = ScrollView
    local tbl8 = {
        tag = "fill size-full-0 padding-x-xlarge",
        scroll = {
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0, 0)
        },
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        LayoutOrder = 1,
        selection = FFlagSideSheetFocusNav and { Selectable = false } or nil,
        scrollingFrameRef = 0
    }

    if not (FFlagSideSheetFocusNav and FFlagUseAnimateScrollViewToSelectionHelper) then
        var24 = nil
    end

    tbl8.scrollingFrameRef = var24
    tbl7.ScrollableContent = createElement3(var28, tbl8, tbl4)

    tbl7.Footer = React.createElement(Footer, { layoutOrder = 2 })
    local element2_2 = createElement2(var27, tbl6, tbl7)

    if FFlagEnableWhatsNew then
        element2_2 = React.createElement(WhatsNewAnchor, { anchorId = "sideSheet", tag = "size-full" }, { SideSheetPanel = element2_2 })
    end

    local createElement4 = React.createElement
    local var29 = DrawerContainer
    local tbl9 = {
        displayOrder = 12,
        menuWidth = menuWidth,
        leftOffset = left,
        topOffset = var5.top,
        bottomOffset = var5.bottom,
        backgroundStyle = backgroundStyle,
        onDrawerClosedAnalytics = onDrawerClosedAnalytics,
        allowOutsideInteraction = if FFlagSideSheetOpenPeoplePage then allowRightFocusEscape else nil,
        scrimIsModal = not (FFlagSideSheetOpenPeoplePage and allowRightFocusEscape)
    }
    local tableValue1 = React.createElement("StyleLink", { StyleSheet = styleSheet })

    if FFlagSideSheetFocusNav then
        element2_2 = React.createElement(FocusRoot, {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            isIsolated = true,
            frameProps = allowRightFocusEscape and {
                SelectionBehaviorRight = Enum.SelectionBehavior.Escape
            } or nil
        }, { Content = element2_2 })
    end

    return createElement4(var29, tbl9, { FoundationStyleLink = tableValue1, element2_2 })
end

function module.createSideSheet(arg1, tbl3, arg2)
    if not root then
        local inExperienceSideSheet = Instance.new("Folder")
        inExperienceSideSheet.Name = "InExperienceSideSheet"
        inExperienceSideSheet.Parent = CoreGui

        local var2 = wrapWithProviders({ SideSheetContent = React.createElement(SideSheetContent, tbl3) }, arg1, arg2)

        root = ReactRoblox.createRoot(inExperienceSideSheet)
        root:render(var2)
    end

    return root
end

return module
