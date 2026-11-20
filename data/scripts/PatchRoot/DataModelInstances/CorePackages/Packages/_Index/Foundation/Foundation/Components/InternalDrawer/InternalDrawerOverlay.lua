-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local useAnimatedBinding = ReactOtter.useAnimatedBinding

local Backdrop = require(Foundation.Components.Backdrop)
local Constants = require(Foundation.Constants)
local OnCloseCallbackReason = require(Foundation.Enums.OnCloseCallbackReason)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local InternalDrawerDismissSwipe = require(script.Parent.InternalDrawerDismissSwipe)
local ScrollView = require(Foundation.Components.ScrollView)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local View = require(Foundation.Components.View)
local drawerMotion = require(script.Parent.drawerMotion)
local useInternalDrawerVariants = require(script.Parent.useInternalDrawerVariants)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useSurfaceWidth = require(script.Parent.useSurfaceWidth)
local useTokens = require(Foundation.Providers.Style.useTokens)

local InternalDrawerBackdrop = require(Foundation.Enums.InternalDrawerBackdrop)
local InternalDrawerOpenPhase = require(Foundation.Enums.InternalDrawerOpenPhase)
local InternalDrawerShadow = require(Foundation.Enums.InternalDrawerShadow)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Types = require(script.Parent.Types)

local function assignForwardedRef(arg1, current) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "function" then
        arg1(current)
    elseif arg1 ~= nil then
        arg1.current = current
    end
end

return React.memo(React.forwardRef(function(arg1, arg2) -- name: InternalDrawerOverlay
    local var1 = useOverlay()
    local var2 = useTokens()
    local var3 = useInternalDrawerVariants(arg1.layout, arg1.side)
    local bool1 = arg1.shadow == InternalDrawerShadow.Overlay300
    local elevation = arg1.elevation
    local reducedMotion = usePreferences().reducedMotion

    local surface = var3.surface
    local outerBleed = arg1.outerBleed or 0
    local var4, travel = useSurfaceWidth(arg1.width, surface.margin, outerBleed)
    local padding = if outerBleed > 0 then arg1.side == InternalDrawerSide.End and {
        right = UDim.new(0, outerBleed)
    } or {
        left = UDim.new(0, outerBleed)
    } else nil
    local var7 = React.useRef(arg1.isOpen)
    var7.current = arg1.isOpen
    local panelRef = React.useRef(nil)
    local backdropRef = React.useRef(nil)
    local scrollingFrameRef = React.useRef(nil)

    local var11 = React.useCallback(function(current)
        panelRef.current = current
        assignForwardedRef(arg2, current)
    end, { arg2 })

    local var12 = React.useRef(true)
    local var13 = React.useRef(true)
    local var14 = React.useRef(0)
    local var15 = React.useRef(1)
    local var16 = React.useRef(false)
    local var17 = React.useRef(arg1.onExited)
    var17.current = arg1.onExited
    local var18 = React.useRef(arg1.onOpenComplete)
    var18.current = arg1.onOpenComplete
    local var19 = React.useRef(false)
    local bool2 = arg1.openPhase == InternalDrawerOpenPhase.Pressed and not arg1.isOpen
    local current = (arg1.openPhase == InternalDrawerOpenPhase.Dragging or arg1.openPhase == InternalDrawerOpenPhase.Requested)
        and not arg1.isOpen
    var19.current = current or bool2

    local function notifySettled()
        if not var7.current and not var19.current and var12.current and var13.current then
            var17.current()
            return
        end
        if not var16.current or not var12.current or not var13.current or var14.current ~= 1 or var15.current ~= 0 then
            return
        end
        var16.current = false
        local current = var18.current
        if current then
            current()
        end
    end

    local var20, setPanelGoal = useAnimatedBinding(0, function(current2: number)
        var14.current = current2
        var12.current = true
        notifySettled()
    end)
    local var22, setBackdropGoal = useAnimatedBinding(1, function(current2: number)
        var15.current = current2
        var13.current = true
        notifySettled()
    end)

    local drag = arg1.drag
    local setDrag = arg1.setDrag
    local motion = React.useMemo(function()
        return {
            panelProgress = var20,
            backdropTransparency = var22,
            setPanelGoal = setPanelGoal,
            setBackdropGoal = setBackdropGoal,
            drag = drag,
            setDrag = setDrag
        }
    end, {
        var20,
        var22,
        setPanelGoal,
        setBackdropGoal,
        drag,
        setDrag
    })
    local var25 = React.useMemo(function()
        return React.joinBindings({ animated = var20, dragged = drag }):map(function(tbl1)
            return if tbl1.dragged == nil then tbl1.animated else tbl1.dragged
        end)
    end, { var20, drag })
    local transparency = React.useMemo(function()
        return React.joinBindings({ animated = var22, dragged = drag }):map(function(tbl1)
            return if tbl1.dragged == nil then tbl1.animated else 1 - tbl1.dragged
        end)
    end, { var22, drag })

    React.useEffect(function()
        if current then
            drawerMotion.hold(motion)
            return
        end

        if not bool2 then
            var12.current = false
            var13.current = false
            var16.current = arg1.isOpen and var18.current ~= nil
            drawerMotion.animate(motion, arg1.isOpen, var2, reducedMotion)
        end
    end, {
        arg1.isOpen,
        current,
        bool2,
        reducedMotion
    })
    local onActivated = React.useCallback(function()
        if arg1.backdrop == InternalDrawerBackdrop.Dismissible and var7.current then
            arg1.onRequestClose(OnCloseCallbackReason.BackdropClick)
        end
    end, { arg1.backdrop, arg1.onRequestClose })

    local uDim2 = UDim2.new(0, var4 + outerBleed, 1, -surface.margin * 2)
    local side = arg1.side
    local var28 = React.useMemo(function()
        return var25:map(function(num1: number): UDim2
            local var28 = (1 - num1) * outerBleed
            local xOffset

            if side == InternalDrawerSide.End then
                xOffset = -num1 * (var4 + surface.margin) + var28
            else
                local var29 = (1 - num1) * var4
                xOffset = surface.openOffsetSign * surface.margin * num1 + surface.hiddenOffsetSign * (var29 + outerBleed + var28)
            end
            return UDim2.new(surface.anchorScaleX, xOffset, 0, surface.margin)
        end)
    end, {
        var25,
        side,
        var4,
        outerBleed,
        surface
    })
    if var1 then
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local var29 = View
        local tbl1 = {
            Visible = arg1.openPhase ~= InternalDrawerOpenPhase.Pressed,
            ZIndex = elevation.zIndex,
            tag = "size-full",
            testId = `{arg1.testId}--container`
        }
        local tbl2 = { Surface = 0, Shadow = 0, Backdrop = 0, Swipe = 0 }
        local createElement2 = React.createElement
        local var30 = View
        local tbl3 = {
            Size = uDim2,
            Position = var28,
            ClipsDescendants = true,
            ZIndex = if bool1 then 3 else 2,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = Dash.noop,
            selection = Constants.MODAL.DISABLE_SELECTION,
            selectionGroup = Constants.MODAL.TRAP_FOCUS,
            tag = `{surface.tag} {arg1.backgroundColor}`,
            ref = 0,
            testId = 0
        }

        if arg1.swipeToDismiss == nil then
            var11 = arg2
        end

        tbl3.ref = var11
        tbl3.testId = arg1.testId
        local tbl4 = { Content = 0, InnerEdge = 0 }
        local createElement3 = React.createElement
        local var31 = View
        local tbl5 = {
            tag = "col size-full",
            padding = padding,
            testId = `{arg1.testId}--column`
        }
        local createElement4 = React.createElement
        local var32 = ElevationOwnerScope
        local tbl6 = { owner = elevation }
        local tbl7 = {
            Header = if arg1.header == nil then nil else React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "col size-full-0 auto-y",
                    testId = `{arg1.testId}--header`
                },
                arg1.header
            ),
            Body = 0,
            Footer = 0
        }
        local element

        if arg1.scrolls == false then
            element = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "fill size-full-0",
                    testId = `{arg1.testId}--body`
                },
                arg1.children
            )
        else
            element = React.createElement(ScrollView, {
                LayoutOrder = 2,
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.fromScale(1, 0),
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    scrollBarVisibility = arg1.scrollBarVisibility
                },
                tag = "fill size-full-0",
                scrollingFrameRef = if arg1.swipeToDismiss == nil then nil else scrollingFrameRef,
                testId = `{arg1.testId}--body`
            }, {
                Children = React.createElement(
                    View,
                    {
                        tag = "col size-full-0 auto-y",
                        testId = `{arg1.testId}--body-content`
                    },
                    arg1.children
                )
            })
        end

        tbl7.Body = element

        tbl7.Footer = if arg1.footer == nil then nil else React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = "col size-full-0 auto-y",
                testId = `{arg1.testId}--footer`
            },
            arg1.footer
        )
        tbl4.Content = createElement3(var31, tbl5, createElement4(var32, tbl6, tbl7))
        local element2

        if var3.innerEdge.isVisible then
            element2 = React.createElement(View, {
                Size = UDim2.new(0, var3.innerEdge.thickness, 1, 0),
                backgroundStyle = var3.innerEdge.backgroundStyle,
                ZIndex = 2,
                tag = var3.innerEdge.tag,
                testId = `{arg1.testId}--inner-edge`
            })
        else
            element2 = nil
        end

        tbl4.InnerEdge = element2
        tbl2.Surface = createElement2(var30, tbl3, tbl4)

        tbl2.Shadow = if bool1 then React.createElement(
            View,
            {
                Size = uDim2,
                Position = var28,
                ZIndex = 2,
                tag = var3.shadow.tag,
                testId = `{arg1.testId}--shadow`
            }
        ) else nil

        tbl2.Backdrop = React.createElement(Backdrop, {
            ZIndex = 1,
            transparency = transparency,
            onActivated = onActivated,
            ref = if arg1.swipeToDismiss == nil then nil else backdropRef,
            testId = `{arg1.testId}--backdrop`
        })

        tbl2.Swipe = if arg1.swipeToDismiss == nil then nil else React.createElement(InternalDrawerDismissSwipe, {
            config = arg1.swipeToDismiss,
            panelRef = panelRef,
            backdropRef = backdropRef,
            scrollingFrameRef = scrollingFrameRef,
            travel = travel,
            side = arg1.side,
            isOpen = arg1.isOpen,
            motion = motion,
            onRequestClose = arg1.onRequestClose,
            testId = arg1.testId
        })
        var1 = createPortal(createElement(var29, tbl1, tbl2), var1)
    end

    return var1
end))
