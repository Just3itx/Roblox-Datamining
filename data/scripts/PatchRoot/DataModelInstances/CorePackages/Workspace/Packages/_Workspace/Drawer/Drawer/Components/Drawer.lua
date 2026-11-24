-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Drawer = script:FindFirstAncestor("Drawer")
local UserInputService = game:GetService("UserInputService")
local DrawerParent = Drawer.Parent
local React = require(DrawerParent.React)
local ReactIs = require(DrawerParent.ReactIs)
local Foundation = require(DrawerParent.Foundation)
local ReactOtter = require(DrawerParent.ReactOtter)
local Signals = require(DrawerParent.Signals)
local GetDrawerVisibleStore = require(script.Parent.Parent.Stores.GetDrawerVisibleStore)
local useSetDrawerVisible = require(script.Parent.Parent.Hooks.useSetDrawerVisible)
local useSetDrawerShouldMount = require(script.Parent.Parent.Hooks.useSetDrawerShouldMount)
local useSetDrawerAnimating = require(script.Parent.Parent.Hooks.useSetDrawerAnimating)
local Scrim = require(script.Parent.Scrim)
local Constants = require(script.Parent.Parent.Constants)
local _Types = require(script.Parent.Parent.Types)
local DrawerPanelStatus = require(script.Parent.Parent.Enum).DrawerPanelStatus

local FocusNavigableSurfaceWrapper = nil
local FocusNavigableSurfaceIdentifierEnum = nil
local FocusNavigationEventNameEnum = nil
local InputHandlers = nil

local SharedFlags = require(DrawerParent.SharedFlags)
local FFlagEnableDrawerFocusNav = SharedFlags.FFlagEnableDrawerFocusNav
local FFlagEnableDrawerAnimatingHook = SharedFlags.FFlagEnableDrawerAnimatingHook
local FFlagSideSheetOpenPeoplePage = SharedFlags.FFlagSideSheetOpenPeoplePage
local FFlagFixOverlayTopInsetForDeviceSafeInsets = SharedFlags.FFlagFixOverlayTopInsetForDeviceSafeInsets
local FFlagFixDrawerNavigateBackWhileClosing = require(Drawer.Flags).FFlagFixDrawerNavigateBackWhileClosing

if FFlagEnableDrawerFocusNav then
    local focusNavigationUtils = require(DrawerParent.FocusNavigationUtils)
    FocusNavigableSurfaceWrapper = focusNavigationUtils.FocusNavigableSurfaceWrapper
    FocusNavigableSurfaceIdentifierEnum = focusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
    FocusNavigationEventNameEnum = focusNavigationUtils.FocusNavigationEventNameEnum
    InputHandlers = require(DrawerParent.InputHandlers)
end

return React.memo(function(arg1)
    local var1 = useSetDrawerVisible()
    local var2 = useSetDrawerShouldMount()
    local var3 = not FFlagEnableDrawerAnimatingHook and function(_: boolean) end or useSetDrawerAnimating()
    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var6, var7 = React.useBinding(DrawerPanelStatus.Scrollable)
    local var8 = React.useMemo(function()
        return var6:map(function(scrollable): boolean
            return scrollable == DrawerPanelStatus.Scrollable
        end)
    end, {})

    local zIndex = React.useMemo(function()
        return var6:map(function(movable): number
            return if movable == DrawerPanelStatus.Movable then 3 else 1
        end)
    end, {})

    local backgroundColor3 = if FFlagEnableDrawerFocusNav then React.useMemo(function()
        local backgroundStyle = arg1.backgroundStyle
        if backgroundStyle == nil then
            return nil
        elseif ReactIs.isBinding(backgroundStyle) then
            return backgroundStyle:map(function(arg2)
                return arg2.Color3
            end)
        end
        return backgroundStyle.Color3
    end, { arg1.backgroundStyle }) else nil

    local backgroundTransparency = if FFlagEnableDrawerFocusNav then React.useMemo(function()
        local backgroundStyle = arg1.backgroundStyle
        if backgroundStyle == nil then
            return nil
        elseif ReactIs.isBinding(backgroundStyle) then
            return backgroundStyle:map(function(arg2)
                return arg2.Transparency
            end)
        end
        return backgroundStyle.Transparency
    end, { arg1.backgroundStyle }) else nil

    local topOffset = arg1.topOffset or 0
    local bottomOffset = arg1.bottomOffset or 0
    local leftOffset = arg1.leftOffset or 0
    local deviceSafeInsets = if FFlagFixOverlayTopInsetForDeviceSafeInsets then arg1.deviceSafeInsets else nil
    local clipsDescendants = FFlagSideSheetOpenPeoplePage and arg1.allowOutsideInteraction == true
    local current = arg1.menuWidth + leftOffset
    local var13 = React.useRef(false)
    local var14 = React.useCallback(function(arg2)
        if FFlagEnableDrawerAnimatingHook then
            var3(false)
        end
        if var6:getValue() == DrawerPanelStatus.Closing then
            var7(DrawerPanelStatus.Scrollable)
        end
        if arg2 == -current then
            var2(false)
        end
    end, FFlagSideSheetOpenPeoplePage and { current, var3, var2 }
        or FFlagEnableDrawerAnimatingHook and { current, var3, var2 }
        or {})

    local menuPosX, var16 = ReactOtter.useAnimatedBinding(-current, var14)

    local var17 = React.useRef(current)
    var17.current = current

    local ref = React.useRef(nil)
    local var19, var20 = ReactOtter.useAnimatedBinding(1)

    local var21 = if FFlagSideSheetOpenPeoplePage then React.useCallback(function(arg2): boolean
        local current = ref.current
        if current == nil then
            return false
        end

        local position = arg2.Position
        local absolutePosition = current.AbsolutePosition
        local absoluteSize = current.AbsoluteSize

        return position.X >= absolutePosition.X
            and position.X <= absolutePosition.X + absoluteSize.X
            and position.Y >= absolutePosition.Y
            and position.Y <= absolutePosition.Y + absoluteSize.Y
    end, {}) else nil

    local var22 = React.useCallback(function(source)
        var1(false)
        var7(DrawerPanelStatus.Closing)
        if arg1.onDrawerClosedAnalytics then
            arg1.onDrawerClosedAnalytics({ source = source })
        end
    end, FFlagSideSheetOpenPeoplePage and { arg1.onDrawerClosedAnalytics, var1 } or { arg1.onDrawerClosedAnalytics })

    local var23 = React.useCallback(function(arg2)
        if var13.current and var6:getValue() ~= DrawerPanelStatus.Closing and (not clipsDescendants or var21(arg2)) then
            var4.current = arg2.Position
            var5.current = DateTime.now().UnixTimestampMillis
            var7(DrawerPanelStatus.Static)
        end
    end, FFlagSideSheetOpenPeoplePage and { clipsDescendants, var21 } or {})

    local var24 = React.useCallback(function(arg2)
        if not var13.current or var4.current == nil or var5.current == nil or var6:getValue() ~= DrawerPanelStatus.Movable then
            var4.current = nil
            var5.current = nil
            return
        end

        local var24 = var4.current.X - arg2.Position.X
        if var17.current * Constants.DRAWER_SWIPE_THRESHOLD_PERCENT <= var24 then
            var22("swipe")
        elseif var24 > 0 then
            local var25 = (DateTime.now().UnixTimestampMillis - var5.current) / 1000
            if var25 > 0.01 and var24 / var25 >= Constants.DRAWER_VELOCITY_THRESHOLD then
                var22("swipe")
            end
        end

        if var6:getValue() ~= DrawerPanelStatus.Closing then
            if FFlagEnableDrawerAnimatingHook then
                var3(true)
            end
            var16(ReactOtter.ease(0, Constants.DRAWER_ANIM_SETTINGS))
            var7(DrawerPanelStatus.Scrollable)
        end

        var4.current = nil
        var5.current = nil
    end, FFlagEnableDrawerAnimatingHook and { var22, var3 } or {})

    local var25 = React.useCallback(function(arg2)
        if not var13.current or var4.current == nil or var6:getValue() == DrawerPanelStatus.Closing then
            return
        end

        local var25 = arg2.Position.X - var4.current.X
        if var6:getValue() == DrawerPanelStatus.Static then
            local var26 = arg2.Position.Y - var4.current.Y
            if math.abs(var25) > math.abs(var26) then
                var7(DrawerPanelStatus.Movable)
            else
                var7(DrawerPanelStatus.Scrollable)
            end
        end

        if var6:getValue() == DrawerPanelStatus.Movable and var25 < 0 then
            var16((ReactOtter.instant(var25)))
        end

        if arg2.Position.X > var4.current.X then
            var4.current = arg2.Position
        end
    end, {})

    React.useEffect(function()
        local getDrawerVisible = GetDrawerVisibleStore(false).getDrawerVisible
        return Signals.createEffect(function(arg2)
            local drawerVisible = getDrawerVisible(arg2)
            var13.current = drawerVisible

            local var26 = if drawerVisible then 0 else -var17.current
            if FFlagEnableDrawerAnimatingHook then
                var3(true)
            end
            var16(ReactOtter.ease(var26, Constants.DRAWER_ANIM_SETTINGS))

            if not FFlagSideSheetOpenPeoplePage then
                local var27 = if drawerVisible then Constants.SCRIM_TRANSPARENCY else 1
                var20(ReactOtter.ease(var27, Constants.DRAWER_ANIM_SETTINGS))
            end
        end)
    end, FFlagEnableDrawerAnimatingHook and { var3 } or {})

    if FFlagSideSheetOpenPeoplePage then
        React.useEffect(function()
            local getDrawerVisible = GetDrawerVisibleStore(false).getDrawerVisible
            return Signals.createEffect(function(arg2)
                local var26 = if not getDrawerVisible(arg2) or clipsDescendants then 1 else Constants.SCRIM_TRANSPARENCY

                var20(ReactOtter.ease(var26, Constants.DRAWER_ANIM_SETTINGS))
            end)
        end, { clipsDescendants })
    end

    React.useEffect(function()
        if FFlagSideSheetOpenPeoplePage and not var13.current and menuPosX:getValue() ~= -current then
            var16((ReactOtter.instant(-current)))
        end
    end, { current })

    React.useEffect(function()
        local connection = UserInputService.TouchStarted:Connect(var23)
        local connection2 = UserInputService.TouchEnded:Connect(var24)
        local connection3 = UserInputService.TouchMoved:Connect(var25)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, FFlagSideSheetOpenPeoplePage and { var24, var25, var23 } or {})

    local onActivated = React.useCallback(function()
        if var6:getValue() == DrawerPanelStatus.Closing then
            return
        end

        if var6:getValue() ~= DrawerPanelStatus.Movable then
            var22("shield")
        end
    end, { var6, var22 })

    local var27 = if FFlagSideSheetOpenPeoplePage then React.useMemo(function()
        return React.joinBindings({ menuPosX = menuPosX, scrimTransparency = var19 }):map(function(arg2): boolean
            return arg2.menuPosX > -current or arg2.scrimTransparency < 1
        end)
    end, { current }) else var19:map(function(arg2): boolean
        return arg2 < 1
    end)

    local tbl1 = {
        DrawerContent = React.createElement("ScrollingFrame", {
            ref = ref,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Selectable = false,
            Size = UDim2.new(0, arg1.menuWidth, 1, -topOffset - bottomOffset),
            Position = UDim2.new(0, leftOffset, 0, topOffset),
            CanvasSize = UDim2.new(0, arg1.menuWidth, 0, 0),
            Active = var8,
            BorderSizePixel = 0,
            ScrollBarThickness = 0,
            ClipsDescendants = true,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = var8,
            ZIndex = 2
        }, arg1.children),
        DeviceSafeInsetsBackground = if deviceSafeInsets then React.createElement(Foundation.View, {
            Position = UDim2.fromOffset(-deviceSafeInsets.left, -deviceSafeInsets.top),
            Size = UDim2.new(1, deviceSafeInsets.left, 1, deviceSafeInsets.top + deviceSafeInsets.bottom),
            backgroundStyle = arg1.backgroundStyle,
            ZIndex = 0
        }) else nil,
        SinkInput = React.createElement("ImageButton", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = if deviceSafeInsets then UDim2.fromOffset(-deviceSafeInsets.left, -deviceSafeInsets.top) else nil,
            Size = if deviceSafeInsets then UDim2.new(1, deviceSafeInsets.left, 1, deviceSafeInsets.top + deviceSafeInsets.bottom) else UDim2.fromScale(1, 1),
            Selectable = false,
            AutoButtonColor = false,
            ZIndex = zIndex
        })
    }

    local customEventHandlers = React.useMemo(function()
        if not FFlagEnableDrawerFocusNav then
            return {}
        end
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg2)
                    if not FFlagFixDrawerNavigateBackWhileClosing or var6:getValue() ~= DrawerPanelStatus.Closing then
                        var22("focus-navigation-back")
                    end
                    arg2:cancel()
                end)
            }
        }
    end, { var22 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        testId = if FFlagSideSheetOpenPeoplePage then "drawer-root" else nil,
        Size = if clipsDescendants then UDim2.new(0, current, 1, 0) else UDim2.fromScale(1, 1),
        ClipsDescendants = clipsDescendants,
        backgroundStyle = { Transparency = 1 },
        Visible = var27
    }
    local tbl3 = { Scrim = 0, DrawerAnimatedFrame = 0 }
    local element

    if clipsDescendants then
        element = nil
    elseif deviceSafeInsets then
        element = React.createElement(Foundation.View, {
            Position = UDim2.fromOffset(-deviceSafeInsets.left, -deviceSafeInsets.top),
            Size = UDim2.new(1, deviceSafeInsets.left + deviceSafeInsets.right, 1, deviceSafeInsets.top + deviceSafeInsets.bottom),
            backgroundStyle = { Transparency = 1 },
            ZIndex = 1
        }, {
            Scrim = React.createElement(
                Scrim,
                {
                    onActivated = onActivated,
                    transparencyBinding = var19,
                    zIndex = 1,
                    isModal = arg1.scrimIsModal
                }
            )
        })
    else
        element = React.createElement(
            Scrim,
            {
                onActivated = onActivated,
                transparencyBinding = var19,
                zIndex = 1,
                isModal = arg1.scrimIsModal
            }
        )
    end

    tbl3.Scrim = element
    local element2

    if FFlagEnableDrawerFocusNav then
        local createElement2 = React.createElement
        local var29 = FocusNavigableSurfaceWrapper

        local tbl4 = {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.Drawer,
            frameProps = {
                Position = menuPosX:map(function(xOffset2: number): UDim2
                    return UDim2.fromOffset(xOffset2, 0)
                end),
                ZIndex = 2,
                Size = UDim2.new(0, current, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = backgroundColor3,
                BackgroundTransparency = backgroundTransparency,
                Selectable = false,
                SelectionBehaviorRight = if clipsDescendants then Enum.SelectionBehavior.Escape else nil
            },
            isIsolated = true,
            customEventHandlers = customEventHandlers
        }

        element2 = createElement2(var29, tbl4, tbl1)
    else
        element2 = React.createElement(Foundation.View, {
            Position = menuPosX:map(function(xOffset2: number): UDim2
                return UDim2.fromOffset(xOffset2, 0)
            end),
            ZIndex = 2,
            Size = UDim2.new(0, current, 1, 0),
            BorderSizePixel = 0,
            backgroundStyle = arg1.backgroundStyle,
            Selectable = false
        }, tbl1)
    end

    tbl3.DrawerAnimatedFrame = element2
    return createElement(view, tbl2, tbl3)
end)
