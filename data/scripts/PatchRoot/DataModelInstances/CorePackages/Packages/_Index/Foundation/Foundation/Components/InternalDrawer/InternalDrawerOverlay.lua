-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local useAnimatedBinding = ReactOtter.useAnimatedBinding

local Backdrop = require(Foundation.Components.Backdrop)
local Constants = require(Foundation.Constants)
local OnCloseCallbackReason = require(Foundation.Enums.OnCloseCallbackReason)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local ScrollView = require(Foundation.Components.ScrollView)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local View = require(Foundation.Components.View)
local useInternalDrawerVariants = require(script.Parent.useInternalDrawerVariants)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useScreenSize = require(Foundation.Components.Sheet.useScreenSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local InternalDrawerBackdrop = require(Foundation.Enums.InternalDrawerBackdrop)
local InternalDrawerShadow = require(Foundation.Enums.InternalDrawerShadow)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Types = require(script.Parent.Types)

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalDrawerOverlay
    local var1 = useOverlay()
    local var2 = useTokens()
    local var3 = useInternalDrawerVariants(arg1.layout, arg1.side)
    local bool1 = arg1.shadow == InternalDrawerShadow.Overlay300
    local elevation = arg1.elevation
    local reducedMotion = usePreferences().reducedMotion
    local var4 = useScreenSize()

    local surface = var3.surface
    local num1 = math.min(arg1.width, math.max(var4.X - var2.Size.Size_1200 - surface.margin, 0))

    local outerBleed = arg1.outerBleed or 0
    local padding = if outerBleed > 0 then arg1.side == InternalDrawerSide.End and {
        right = UDim.new(0, outerBleed)
    } or {
        left = UDim.new(0, outerBleed)
    } else nil
    local var6 = React.useRef(arg1.isOpen)
    var6.current = arg1.isOpen

    local var7 = React.useRef(true)
    local var8 = React.useRef(true)
    local var9 = React.useRef(0)
    local var10 = React.useRef(1)
    local var11 = React.useRef(false)
    local var12 = React.useRef(arg1.onExited)
    var12.current = arg1.onExited
    local var13 = React.useRef(arg1.onOpenComplete)
    var13.current = arg1.onOpenComplete

    local function notifySettled()
        if not var6.current and var7.current and var8.current then
            var12.current()
            return
        end
        if not var11.current or not var7.current or not var8.current or var9.current ~= 1 or var10.current ~= 0 then
            return
        end
        var11.current = false
        local current = var13.current
        if current then
            current()
        end
    end

    local var14, var15 = useAnimatedBinding(0, function(current: number)
        var9.current = current
        var7.current = true
        notifySettled()
    end)
    local transparency, var17 = useAnimatedBinding(1, function(current: number)
        var10.current = current
        var8.current = true
        notifySettled()
    end)

    React.useEffect(function()
        var7.current = false
        var8.current = false
        var11.current = arg1.isOpen and var13.current ~= nil
        if reducedMotion then
            var15((Otter.instant(if arg1.isOpen then 1 else 0)))
            var17((Otter.instant(if arg1.isOpen then 0 else 1)))
            return
        end

        if arg1.isOpen then
            var15(Otter.ease(1, { easingStyle = var2.Ease.StandardOut, duration = var2.Time.Time_300 }))

            var17(Otter.ease(0, { duration = var2.Time.Time_100 }))
        else
            var15(Otter.ease(0, { easingStyle = var2.Ease.StandardIn, duration = var2.Time.Time_100 }))

            var17(Otter.ease(1, { duration = var2.Time.Time_100 }))
        end
    end, { arg1.isOpen, reducedMotion })

    local onActivated = React.useCallback(function()
        if arg1.backdrop == InternalDrawerBackdrop.Dismissible and var6.current then
            arg1.onRequestClose(OnCloseCallbackReason.BackdropClick)
        end
    end, { arg1.backdrop, arg1.onRequestClose })

    local uDim2 = UDim2.new(0, num1 + outerBleed, 1, -surface.margin * 2)
    local var19 = var14:map(function(num2: number): UDim2
        local var19 = (1 - num2) * outerBleed
        local xOffset

        if arg1.side == InternalDrawerSide.End then
            xOffset = -num2 * (num1 + surface.margin) + var19
        else
            local num3 = (1 - num2) * num1
            xOffset = surface.openOffsetSign * surface.margin * num2 + surface.hiddenOffsetSign * (num3 + outerBleed + var19)
        end
        return UDim2.new(surface.anchorScaleX, xOffset, 0, surface.margin)
    end)

    if var1 then
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local var20 = View
        local tbl1 = {
            ZIndex = elevation.zIndex,
            tag = "size-full",
            testId = `{arg1.testId}--container`
        }
        local tbl2 = { Surface = 0, Shadow = 0, Backdrop = 0 }
        local createElement2 = React.createElement
        local var21 = View
        local tbl3 = {
            Size = uDim2,
            Position = var19,
            ClipsDescendants = true,
            ZIndex = if bool1 then 3 else 2,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = Dash.noop,
            selection = Constants.MODAL.DISABLE_SELECTION,
            selectionGroup = Constants.MODAL.TRAP_FOCUS,
            tag = `{surface.tag} {arg1.backgroundColor}`,
            ref = ref,
            testId = arg1.testId
        }
        local tbl4 = { Content = 0, InnerEdge = 0 }
        local createElement3 = React.createElement
        local var22 = View
        local tbl5 = {
            tag = "col size-full",
            padding = padding,
            testId = `{arg1.testId}--column`
        }
        local createElement4 = React.createElement
        local var23 = ElevationOwnerScope
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
        tbl4.Content = createElement3(var22, tbl5, createElement4(var23, tbl6, tbl7))
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
        tbl2.Surface = createElement2(var21, tbl3, tbl4)

        tbl2.Shadow = if bool1 then React.createElement(
            View,
            {
                Size = uDim2,
                Position = var19,
                ZIndex = 2,
                tag = var3.shadow.tag,
                testId = `{arg1.testId}--shadow`
            }
        ) else nil

        tbl2.Backdrop = React.createElement(
            Backdrop,
            {
                ZIndex = 1,
                transparency = transparency,
                onActivated = onActivated,
                testId = `{arg1.testId}--backdrop`
            }
        )
        var1 = createPortal(createElement(var20, tbl1, tbl2), var1)
    end

    return var1
end))
