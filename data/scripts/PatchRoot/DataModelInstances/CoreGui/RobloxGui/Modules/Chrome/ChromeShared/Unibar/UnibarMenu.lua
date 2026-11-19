-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local React = require(CorePackages.Packages.React)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local GetFFlagDebugEnableUnibarDummyIntegrations = SharedFlags.GetFFlagDebugEnableUnibarDummyIntegrations
local GetFIntIconSelectionTimeout = SharedFlags.GetFIntIconSelectionTimeout
local GetFFlagChromeCentralizedConfiguration = SharedFlags.GetFFlagChromeCentralizedConfiguration
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagAddUILessMode = SharedFlags.FFlagAddUILessMode
local FIntAddUILessModeVariant = SharedFlags.FIntAddUILessModeVariant
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab

local FFlagUnibarMenuOpenSubmenu = require(script.Parent.Parent.Parent.Flags).FFlagUnibarMenuOpenSubmenu

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider
local FFlagEnablePlaytestModeUnibar = SharedFlags.FFlagEnablePlaytestModeUnibar
local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle
local PlaytestModeThemeProvider = require(ChromeShared.Unibar.PlaytestModeThemeProvider)
local Service = require(ChromeShared.Service)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

if not GetFFlagChromeCentralizedConfiguration() then
    local _integrations = require(ChromeShared.Parent.Integrations)
end

local SubMenu = require(ChromeShared.Unibar.SubMenu)
local WindowManager = require(ChromeShared.Unibar.WindowManager)
local ShortcutBar = require(ChromeShared.Shortcuts.ShortcutBar)
local Constants = require(ChromeShared.Unibar.Constants)
local buildMenuOrder = require(ChromeShared.Unibar.buildMenuOrder)

local useChromeMenuItems = require(ChromeShared.Hooks.useChromeMenuItems)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)
local useMappedObservableValue = require(ChromeShared.Hooks.useMappedObservableValue)

local IconHost = require(ChromeShared.Unibar.ComponentHosts.IconHost)

local ReactOtter = require(CorePackages.Packages.ReactOtter)
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local FFlagReduceTopBarInsetsWhileHidden = SharedFlags.FFlagReduceTopBarInsetsWhileHidden

local Stores = require(CorePackages.Workspace.Packages.CoreGuiCommon).Stores
local createEffect = require(CorePackages.Packages.Signals).createEffect

local Constants2 = require(ChromeShared.Parent.Integrations.Party.Constants)
local isConnectUnibarEnabled = require(ChromeShared.Parent.Integrations.Connect.isConnectUnibarEnabled)
local GamepadConnector = if FFlagEnableConsoleExpControls then require(ChromeShared.Parent.Parent.TopBar.Components.GamepadConnector) else nil
local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local Panel3DInSpatialUI = nil
local PanelType = nil
local var1 = nil
if isInExperienceUIVREnabled then
    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    Panel3DInSpatialUI = vrSpatialUi.Panel3DInSpatialUI
    PanelType = vrSpatialUi.Constants.PanelType
    var1 = require(CorePackages.Workspace.Packages.Observable).ObservableValue.new(true)
end

if not GetFFlagChromeCentralizedConfiguration() then
    function configureUnibar()
        local menuOrder = buildMenuOrder()

        local tbl1 = { "nine_dot", "chat", "toggle_mic_mute" }
        table.insert(tbl1, 3, "join_voice")

        if GetFFlagDebugEnableUnibarDummyIntegrations() then
            table.insert(tbl1, "dummy_window")
            table.insert(tbl1, "dummy_window_2")
        end

        if isConnectUnibarEnabled() then
            table.insert(tbl1, "party_entrypoint")
        end

        local var2 = table.find(tbl1, "toggle_mic_mute")
        if var2 then
            table.insert(tbl1, var2, Constants2.TOGGLE_MIC_INTEGRATION_ID)
        end

        if FFlagAppNavMyStatsTab then
            table.insert(tbl1, "assistant_build")
        end

        if isInExperienceUIVREnabled and isSpatial() then
            Service:configureMenu({ { "vr_toggle_button", "vr_safety_bubble" }, tbl1 })
        else
            Service:configureMenu({ tbl1 })
        end

        Service:configureSubMenu("nine_dot", menuOrder)
    end

    configureUnibar()

    if FFlagEnableConsoleExpControls then
        require(script.Parent.Parent.Shortcuts.ConfigureShortcuts)()
    end
end

function IconDivider(tbl1)
    local var2 = useStyle()
    local iconDividerPosition = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_DIVIDER_POSITION else Constants.ICON_DIVIDER_POSITION
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = tbl1.position,
        Size = UDim2.new(0, Constants.DIVIDER_CELL_WIDTH, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl3 = {
        DividerBar = React.createElement("Frame", {
            Position = iconDividerPosition,
            AnchorPoint = Vector2.new(0, 0.5),
            Size = Constants.ICON_DIVIDER_SIZE,
            BorderSizePixel = 0,
            BackgroundColor3 = var2.Theme.Divider.Color,
            BackgroundTransparency = if tbl1.toggleTransition then tbl1.toggleTransition:map(function(arg1)
                return var2.Theme.Divider.Transparency + (1 - arg1) * (1 - var2.Theme.Divider.Transparency)
            end) else var2.Theme.Divider.Transparency,
            Visible = tbl1.visible or true
        })
    }

    return createElement(str1, tbl2, tbl3)
end

local function getSelectedChild(menuFrameRef, str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return menuFrameRef.current:FindFirstChild(Constants.ICON_NAME_PREFIX .. tostring(str1), true)
end

function AnimationStateHelper(arg1)
    local var2 = useObservableValue(Service:currentSubMenu())

    local var3 = useObservableValue(Service:selectedItem())
    local var4 = useObservableValue(Service:inFocusNav())

    React.useEffect(function()
        if not var4 then
            ContextActionService:UnbindCoreAction("RBXEscapeUnibar")

            if GuiService.SelectedCoreObject and arg1.menuFrameRef.current:IsAncestorOf(GuiService.SelectedCoreObject) then
                GuiService.SelectedCoreObject = nil
            end

            return
        end

        if not FFlagEnableConsoleExpControls then
            ContextActionService:BindCoreAction("RBXEscapeUnibar", function(_, userInputState, _)
                if FFlagEnableConsoleExpControls then
                    if userInputState == Enum.UserInputState.End then
                        Service:disableFocusNav()
                        GuiService.SelectedCoreObject = nil
                    end
                else
                    Service:disableFocusNav()
                end
            end, false, Enum.KeyCode.ButtonB)
        end

        if not FFlagEnableConsoleExpControls then
            if arg1.menuFrameRef.current then
                GuiService:Select(arg1.menuFrameRef.current)
            end

            return
        end

        if not arg1.menuFrameRef.current then
            return
        end

        local selectedCoreObject = getSelectedChild(arg1.menuFrameRef, var3)
        if selectedCoreObject then
            GuiService.SelectedCoreObject = selectedCoreObject
        elseif FFlagUnibarMenuOpenSubmenu then
            if FFlagEnableConsoleExpControls then
                Service:selectedItem():set("nine_dot")
            end
            Service:toggleSubMenu("nine_dot")
        else
            GuiService:Select(arg1.menuFrameRef.current)
        end
    end, { var4 })

    React.useEffect(function()
        if var2 ~= "nine_dot" then
            arg1.setToggleSubmenuTransition((ReactOtter.spring(0, Constants.MENU_ANIMATION_SPRING)))

            return
        end

        if FFlagUnibarMenuOpenSubmenu and var4 then
            GuiService:Select(arg1.subMenuHostRef.current)
        end
        arg1.setToggleSubmenuTransition((ReactOtter.spring(1, Constants.MENU_ANIMATION_SPRING)))
    end, { var2 })

    local useEffect = React.useEffect

    local function func1()
        if FFlagEnableConsoleExpControls and var2 == var3 then
            return
        end

        local thread = coroutine.create(function()
            local num1 = 0

            while num1 < GetFIntIconSelectionTimeout() do
                num1 += 1
                task.wait()
                if not (arg1.menuFrameRef.current and var3) then
                    continue
                end

                local selectedCoreObject = if FFlagEnableConsoleExpControls then getSelectedChild(arg1.menuFrameRef, var3) else arg1.menuFrameRef.current:FindFirstChild("IconHitArea_" .. var3, true)

                if selectedCoreObject then
                    GuiService.SelectedCoreObject = selectedCoreObject
                    return
                end
            end
        end)

        coroutine.resume(thread)
    end

    local var5 = if FFlagEnableConsoleExpControls then var2 else nil
    useEffect(func1, { var3, var5 })

    return nil
end

function linearInterpolation(num1: number, num2: number, num3: number): number
    return num1 * (1 - num3) + num2 * num3
end

function IconPositionBinding<T>(arg1: T, num1: number, num2: number, num3: number, arg2: T, arg3: T, bool1: boolean, bool2: boolean?, arg4)
    local unibarEndPadding = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().UNIBAR_END_PADDING else Constants.UNIBAR_END_PADDING

    return (React.joinBindings({ arg1, arg2, arg3 }):map(function(tbl1): UDim2
        local var2 = if arg4.current then linearInterpolation(num2, num1, tbl1[2]) else linearInterpolation(num1, num2, tbl1[2])
        local num4 = num3
        if bool2 and not bool1 then
            num4 = num3 - tbl1[3]
        end
        local var3 = var2 - num4

        return UDim2.new(0, unibarEndPadding + num4 + var3 * tbl1[1], 0, 0)
    end))
end

local function onUnibarSelectionChanged(arg1, _: boolean, _, arg2)
    if not arg1:IsAncestorOf(arg2) then
        Service:disableFocusNav()
    end
end

function isLeft(horizontalAlignment): boolean
    return horizontalAlignment == Enum.HorizontalAlignment.Left
end

function Unibar(tbl1)
    local iconCellWidth, unibarEndPadding

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var2 = UnibarStyle.use()
        iconCellWidth = var2.ICON_CELL_WIDTH
        unibarEndPadding = var2.UNIBAR_END_PADDING
    else
        iconCellWidth = Constants.ICON_CELL_WIDTH
        unibarEndPadding = Constants.UNIBAR_END_PADDING
    end
    local tbl2 = {}
    local var2 = React.useRef({})
    local var3 = React.useRef(Vector2.zero)

    local var4 = React.useRef(Vector2.zero)

    local var5 = if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and Stores.GetUILessStore then React.useRef(Stores.GetUILessStore(false)) else nil

    local bool1 = false
    local current = var2.current or {}

    local var6 = useChromeMenuItems()

    local var7, setToggleIconTransition = ReactOtter.useAnimatedBinding(1)
    local toggleTransition, setToggleWidthTransition = ReactOtter.useAnimatedBinding(1)
    local var11, var12 = ReactOtter.useAnimatedBinding(0)
    local var13 = React.useRef(0)
    local var14, var15 = ReactOtter.useAnimatedBinding(1)
    local var16 = React.useRef(false)
    local var17 = React.useRef(0)

    local bool2 = Service:currentSubMenu():get() == "nine_dot"

    local var8, setToggleSubmenuTransition = ReactOtter.useAnimatedBinding(if bool2 then 1 else 0)

    local tbl3 = {}
    local num1 = 0
    local num2 = 0
    local num3 = 0
    local num4 = 0

    local var20 = React.useCallback(function(arg1)
        local zero = Vector2.zero
        local zero2 = Vector2.zero
        if arg1 then
            zero = arg1.AbsolutePosition
            zero2 = arg1.AbsoluteSize
            if zero ~= var3.current then
                var3.current = zero
                Service:setMenuAbsolutePosition(zero)
            end
            if FFlagReduceTopBarInsetsWhileHidden and zero2 ~= var4.current then
                var4.current = zero2
            end

            if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and var5.current.getUILessModeEnabled(false) then
                if zero ~= var3.current then
                    var3.current = zero
                    Service:setMenuAbsolutePosition(zero)
                end
                if zero2 ~= var4.current then
                    var4.current = zero2
                end
            end
        end

        if FFlagReduceTopBarInsetsWhileHidden and GamepadConnector then
            if arg1 and tbl1.onAreaChanged and GamepadConnector:getShowTopBar():get() then
                tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, zero, zero2)
            end
        elseif FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and var5.current.getUILessModeEnabled(false) then
            if arg1 and tbl1.onAreaChanged and var5.current.getUIVisible(false) then
                tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, zero, zero2)
            end
        elseif arg1 and tbl1.onAreaChanged then
            tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, zero, arg1.AbsoluteSize)
        end
    end, {})

    local var21 = React.joinBindings({ toggleTransition, var11 }):map(function(tbl4): UDim2
        return UDim2.new(0, linearInterpolation(num4, tbl4[2], tbl4[1]), 0, iconCellWidth)
    end)

    local var22 = useMappedObservableValue(Service:orderAlignment(), isLeft)

    for _, value in var6 do
        if value.integration.availability:get() == Service.AvailabilitySignal.Pinned then
            num1 += 1
        end
    end

    local var23 = if var22 then 1 else math.max(num1 - 1, 0)

    for value, integration in var6 do
        if integration.isDivider then
            local var24 = num2 + iconCellWidth * var23

            local var25 = current[integration.id] or num2
            tbl2[integration.id] = num2
            bool1 = bool1 or var25 ~= num2
            local position = IconPositionBinding(var7, var25, num2, var24, var14, var11, false, var22, var16)

            local visible = if var22 then React.joinBindings({ position, var21 }):map(function(arg1): boolean
                return arg1[1].X.Offset >= iconCellWidth * 0.5
            end) else React.joinBindings({ position, var21 }):map(function(arg1): boolean
                local var27 = arg1[1]
                local var28 = arg1[2]
                return var27.X.Offset <= var28.X.Offset - iconCellWidth
            end)

            tbl3[integration.id or "icon" .. value] = React.createElement(IconDivider, { position = position, visible = visible, toggleTransition = toggleTransition })

            num2 += Constants.DIVIDER_CELL_WIDTH
        elseif integration.integration then
            local var24 = num2 + iconCellWidth * var23
            local bool3

            if integration.integration.availability:get() == Service.AvailabilitySignal.Pinned then
                var24 = num3
                bool3 = true
            else
                bool3 = false
            end

            local var25 = if current[integration.id] == nil then num2 else current[integration.id]
            tbl2[integration.id] = num2
            bool1 = bool1 or var25 ~= num2
            local position = IconPositionBinding(var7, var25, num2, var24, var14, var11, bool3, var22, var16)

            local var27 = if var22 then React.joinBindings({ position, var21 }):map(function(arg1): boolean
                return arg1[1].X.Offset >= iconCellWidth * 0.5
            end) else React.joinBindings({ position, var21 }):map(function(arg1): boolean
                local var27 = arg1[1]
                local var28 = arg1[2]
                return var27.X.Offset <= var28.X.Offset - iconCellWidth * 1.5
            end)

            tbl3[integration.id or "icon" .. value] = React.createElement(
                IconHost,
                {
                    position = position,
                    visible = bool3 or var27,
                    toggleTransition = var8,
                    integration = integration
                }
            )
            num2 += iconCellWidth
            if bool3 then
                num3 += iconCellWidth
            end
        end
    end

    num4 = num2
    if tbl1.onMinWidthChanged then
        tbl1.onMinWidthChanged(num4)
    end
    local x = unibarEndPadding * 2 + num2

    React.useEffect(function()
        local current2 = var13.current

        if var11:getValue() == 0 then
            var12((ReactOtter.instant(x)))
            var13.current = x
        elseif current2 ~= x then
            var12(ReactOtter.spring(x, Constants.MENU_ANIMATION_SPRING))
            var13.current = x
        end
        Service:setMenuAbsoluteSize(Vector2.new(x, iconCellWidth))
    end, { x })

    if bool1 then
        var17.current = (var17.current or 0) + 1
    end
    var2.current = tbl2

    React.useEffect(function()
        if not var16.current then
            var15(ReactOtter.spring(0, Constants.MENU_ANIMATION_SPRING))
            var16.current = true
            return
        end
        var15(ReactOtter.spring(1, Constants.MENU_ANIMATION_SPRING))
        var16.current = false
    end, { var17.current, var16 })

    React.useEffect(function()
        if not FFlagReduceTopBarInsetsWhileHidden or not GamepadConnector then
            return
        end

        local showTopBar = GamepadConnector:getShowTopBar()
        showTopBar:connect(function()
            if showTopBar:get() then
                tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, var3.current, var4.current)
                return
            end

            tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, Vector2.zero, Vector2.zero)
        end)

        tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, Vector2.zero, Vector2.zero)
    end, {})

    React.useEffect(function()
        local effect = nil
        if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and var5.current.getUILessModeEnabled(false) then
            effect = createEffect(function(arg1)
                if var5.current.getUIVisible(arg1) then
                    tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, var3.current, var4.current)
                    return
                end

                tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, Vector2.zero, Vector2.zero)
            end)

            tbl1.onAreaChanged(Constants.UNIBAR_KEEP_OUT_AREA_ID, Vector2.zero, Vector2.zero)
        end

        return function()
            if effect then
                effect()
            end
        end
    end, {})

    local var24 = useStyle()

    return React.createElement("Frame", {
        Size = var21,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        SelectionGroup = true,
        ref = tbl1.menuFrameRef,
        [React.Change.AbsoluteSize] = var20,
        [React.Change.AbsolutePosition] = var20
    }, { React.createElement(AnimationStateHelper, {
            setToggleIconTransition = setToggleIconTransition,
            setToggleWidthTransition = setToggleWidthTransition,
            setToggleSubmenuTransition = setToggleSubmenuTransition,
            menuFrameRef = tbl1.menuFrameRef,
            subMenuHostRef = if FFlagUnibarMenuOpenSubmenu then tbl1.subMenuHostRef else nil
        }), React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = var24.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = var24.Theme.BackgroundUIContrast.Transparency * var24.Settings.PreferredTransparency
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }), React.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, BackgroundTransparency = 1 }, tbl3) })
end

local function UnibarPills(tbl1)
    local var2 = useStyle()
    local unibarEndPadding, menuSubmenuPadding

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var3 = UnibarStyle.use()
        unibarEndPadding = var3.UNIBAR_END_PADDING
        menuSubmenuPadding = var3.MENU_SUBMENU_PADDING
    else
        unibarEndPadding = Constants.UNIBAR_END_PADDING
        menuSubmenuPadding = Constants.MENU_SUBMENU_PADDING
    end

    local var3 = useChromeMenuItems()

    local bool1 = Service:currentSubMenu():get() == "nine_dot"

    local toggleTransition, setToggleSubmenuTransition = ReactOtter.useAnimatedBinding(if bool1 then 1 else 0)

    assert(var3 ~= nil, "Menu items should not be nil")
    local tbl2 = {}
    local tbl3 = {}
    for value, integration in var3 do
        if integration.integration and integration.isDivider == false then
            tbl3["icon_host" .. value] = React.createElement(IconHost, { toggleTransition = toggleTransition, integration = integration })
        end

        if not integration.isDivider and value ~= #var3 then
            continue
        end
        local createElement = React.createElement
        local tbl4 = {
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BorderSizePixel = 0,
            BackgroundColor3 = var2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = var2.Theme.BackgroundUIContrast.Transparency * var2.Settings.PreferredTransparency
        }
        local tbl5 = {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            Padding = React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, unibarEndPadding),
                    PaddingRight = UDim.new(0, unibarEndPadding)
                }
            ),
            PillsHorizontalList = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
        }
        local element = createElement("Frame", tbl4, tbl5, tbl3)

        tbl2["pill_" .. value] = element
        tbl3 = {}
    end

    return React.createElement("Frame", {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        SelectionGroup = true,
        ref = tbl1.menuFrameRef,
        AutomaticSize = Enum.AutomaticSize.XY
    }, { React.createElement(AnimationStateHelper, {
            setToggleSubmenuTransition = setToggleSubmenuTransition,
            menuFrameRef = tbl1.menuFrameRef,
            subMenuHostRef = tbl1.subMenuHostRef
        }), React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, menuSubmenuPadding)
        }) }, tbl2)
end

local function SubMenuWrapper(arg1)
    if isInExperienceUIVREnabled and isSpatial() and Panel3DInSpatialUI then
        local var2 = useObservableValue(Service:currentSubMenu())
        var1:set(var2 ~= nil)
    end
    local renderFunction = React.useCallback(function(vector2: Vector2)
        return (React.createElement(SubMenu, { subMenuHostRef = arg1.subMenuHostRef, panelSize = vector2 }))
    end, { arg1.subMenuHostRef })

    if isInExperienceUIVREnabled and isSpatial() and Panel3DInSpatialUI then
        return (React.createElement(
            Panel3DInSpatialUI,
            {
                panelType = PanelType.ChromeSubMenu,
                renderFunction = renderFunction,
                visibilityObservable = var1
            }
        ))
    end

    return (React.createElement(SubMenu, { subMenuHostRef = arg1.subMenuHostRef }))
end

return React.memo(function(tbl1)
    local menuSubmenuPadding = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().MENU_SUBMENU_PADDING else Constants.MENU_SUBMENU_PADDING
    local var2 = React.useRef(nil)
    if FFlagEnableConsoleExpControls and tbl1.menuRef then
        var2 = tbl1.menuRef
    end
    local ref = React.useRef(nil)
    local subMenuHostRef = if FFlagUnibarMenuOpenSubmenu then React.useRef(nil) else nil

    local function updateSize() -- Luacid: Inlined by compiler; 1 call site recovered
        if ref.current and var2.current then
            ref.current.Size = var2.current.Size
        end
    end

    local var5 = useMappedObservableValue(Service:orderAlignment(), isLeft)

    local var6 = nil
    local var7 = nil
    local showTopBar = nil

    if FFlagEnableConsoleExpControls and GamepadConnector then
        local var8
        var6, var8 = React.useBinding(GamepadConnector:getShowTopBar():get())
        var7 = var8
        showTopBar = GamepadConnector:getShowTopBar()
    end

    local var8 = nil
    if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and Stores.GetUILessStore then
        var8 = React.useRef(Stores.GetUILessStore(false))

        if var8.current.getUILessModeEnabled(false) then
            local var9
            var6, var9 = React.useBinding(true)
            var7 = var9
        end
    end

    React.useEffect(function()
        local connection = if var2 and var2.current then var2.current:GetPropertyChangedSignal("Size"):Connect(updateSize) else nil
        updateSize()

        if FFlagEnableConsoleExpControls then
            showTopBar:connect(function()
                var7(showTopBar:get())
            end)
        end

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end)

    React.useEffect(function()
        local effect = if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and var8.current.getUILessModeEnabled(false) then createEffect(function(arg1)
            var7(var8.current.getUIVisible(arg1))
        end) else nil

        return function()
            if effect then
                effect()
            end
        end
    end, {})

    local element = if isInExperienceUIVREnabled and isSpatial() then React.createElement(UnibarPills, { menuFrameRef = var2, subMenuHostRef = subMenuHostRef }) else React.createElement(
        Unibar,
        {
            menuFrameRef = var2,
            subMenuHostRef = if FFlagUnibarMenuOpenSubmenu then subMenuHostRef else nil,
            onAreaChanged = tbl1.onAreaChanged,
            onMinWidthChanged = tbl1.onMinWidthChanged
        }
    )

    if FFlagEnablePlaytestModeUnibar then
        element = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                PlaytestModeThemeProvider = React.createElement(PlaytestModeThemeProvider, nil, { Unibar = element })
            }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Name = "UnibarMenu",
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        SelectionGroup = true,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionBehaviorLeft = if FFlagEnableConsoleExpControls then nil else Enum.SelectionBehavior.Stop,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
        ref = ref,
        [React.Event.SelectionChanged] = if FFlagEnableConsoleExpControls then onUnibarSelectionChanged else nil
    }

    if not FFlagEnableConsoleExpControls
        and (not FFlagAddUILessMode or FIntAddUILessModeVariant == 0 or not var8.current.getUILessModeEnabled(false))
    then
        var6 = nil
    end

    tbl2.Visible = var6
    return { createElement(str1, tbl2, {
            React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = if var5 then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, menuSubmenuPadding)
            }),
            element,
            if isInExperienceUIVREnabled then React.createElement(SubMenuWrapper, { subMenuHostRef = subMenuHostRef }) else React.createElement(SubMenu, { subMenuHostRef = subMenuHostRef }),
            if FFlagEnableConsoleExpControls then React.createElement(ShortcutBar) else nil,
            (React.createElement(WindowManager))
        }) }
end, function(_, _): boolean
    return true
end)
