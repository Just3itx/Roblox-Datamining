-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local usePrevious = require(FoundationParent.ReactUtils).usePrevious

local Constants = require(Foundation.Constants)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _ElevationLayer = require(Foundation.Enums.ElevationLayer)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local useElevation = require(Foundation.Providers.Elevation.useElevation)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useOverlayTransition = require(Foundation.Utility.useOverlayTransition)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useStableContainer = require(Foundation.Utility.useStableContainer)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _ScreenRegion = require(Foundation.Providers.ScreenRegion.ScreenRegion)
local ScreenRegionKind = require(Foundation.Providers.ScreenRegion.ScreenRegionKind)
local useRegionEntry = require(Foundation.Providers.ScreenRegion.useRegionEntry)

local tbl1 = { testId = "--foundation-floating-element" }

local function FloatingContent(arg1)
    local var1 = Dash.assign({ LayoutOrder = 1 }, arg1)
    local var2 = useTokens()
    local var3 = useOverlay()
    local owner = useElevation(var1.layer, { stackAboveOwner = false })
    local var5 = useScaledValue(Constants.FLOATING_MAX_WIDTH)

    local var6, ref = useStableContainer()
    local var8, var9 = React.useBinding(0)
    local large = var2.Padding.Large

    local size800 = var2.Size.Size_800
    local var10 = size800 - large

    local createElement = React.createElement
    local var11 = View
    local tbl2 = {
        ZIndex = owner.zIndex,
        tag = "size-full",
        testId = `{var1.testId}--container`
    }

    local tbl3 = {
        Transition = React.createElement(View, {
            ZIndex = owner.zIndex,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = var1.progress:map(function(num1: number): UDim2
                return UDim2.new(0.5, 0, 1, var10 + (1 - num1) * var2.Size.Size_800)
            end),
            Size = var8:map(function(num1: number): UDim2
                return UDim2.new(1, var10 * 2, 0, num1 + size800 * 2)
            end),
            sizeConstraint = {
                MaxSize = Vector2.new(var5 + size800 * 2, math.huge)
            },
            GroupTransparency = if var1.isAnimating then var1.progress:map(function(num1: number): number
                return 1 - num1
            end) else nil,
            ref = ref,
            testId = `{var1.testId}--transition`
        })
    }

    local element = createElement(var11, tbl2, tbl3)

    local element2 = React.createElement(View, {
        padding = UDim.new(0, size800),
        tag = "col align-x-center size-full"
    }, {
        Content = React.createElement(
            View,
            Dash.assign(withCommonProps(var1, { tag = "col align-x-center size-full-0 auto-y", ref = var1.forwardRef }), {
                onAbsoluteSizeChanged = function(arg2)
                    var9(arg2.AbsoluteSize.Y)
                    if var1.onAbsoluteSizeChanged then
                        var1.onAbsoluteSizeChanged(arg2)
                    end
                end
            }),
            React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
        )
    })

    local createElement2 = React.createElement
    local fragment = React.Fragment
    local var12 = nil
    local tbl4 = { Overlay = 0, StableContent = 0 }
    if var3 ~= nil then
        element = ReactRoblox.createPortal(element, var3)
    end

    tbl4.Overlay = element
    tbl4.StableContent = ReactRoblox.createPortal(element2, var6)
    return createElement2(fragment, var12, tbl4)
end

return React.memo(React.forwardRef(function(arg1, forwardRef) -- name: InternalFloatingElement
    local var1 = withDefaults(arg1, tbl1)
    local isMounted, var3 = React.useState(false)
    local queue = var1.queue
    local var4 = useRegionEntry(
        if queue then queue.region else nil,
        {
            kind = if queue then queue.kind else ScreenRegionKind.FloatingBanner,
            isOpen = var1.isOpen,
            isMounted = isMounted
        }
    )
    local onCloseComplete = var1.onCloseComplete

    local var5 = useOverlayTransition({
        isOpen = var1.isOpen and var4.isVisible,
        onExited = function()
            if not var1.isOpen and onCloseComplete then
                onCloseComplete()
            end
        end
    })

    local var6 = usePrevious(var1.isOpen)
    React.useEffect(function()
        if var6 and not var1.isOpen and not var5.isMounted and onCloseComplete then
            onCloseComplete()
        end
    end, {
        var6,
        var1.isOpen,
        var5.isMounted,
        onCloseComplete
    })

    React.useLayoutEffect(function()
        var3(var5.isMounted)
    end, { var5.isMounted })

    if not var5.isMounted then
        return nil
    end

    return React.createElement(
        FloatingContent,
        Dash.assign({}, var1, { progress = var5.progress, isAnimating = var5.isAnimating, forwardRef = forwardRef })
    )
end))
