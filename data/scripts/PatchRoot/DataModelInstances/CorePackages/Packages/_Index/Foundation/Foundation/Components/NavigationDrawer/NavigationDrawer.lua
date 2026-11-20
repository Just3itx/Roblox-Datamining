-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local ElevationLayer = require(Foundation.Enums.ElevationLayer)
local InternalDrawer = require(Foundation.Components.InternalDrawer)
local InternalDrawerBackdrop = require(Foundation.Enums.InternalDrawerBackdrop)
local InternalDrawerLayout = require(Foundation.Enums.InternalDrawerLayout)
local InternalDrawerShadow = require(Foundation.Enums.InternalDrawerShadow)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Types = require(Foundation.Components.InternalDrawer.Types)
local _OnCloseCallbackReason = require(Foundation.Enums.OnCloseCallbackReason)
local SwipeBehavior = require(Foundation.Enums.SwipeBehavior)
local useElevation = require(Foundation.Providers.Elevation.useElevation)
local useHardwareInsets = require(Foundation.Components.Sheet.useHardwareInsets)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {}
local tbl2 = {}

local tbl3 = { testId = "--foundation-navigation-drawer", width = 320 }

return React.memo(React.forwardRef(function(tbl4, ref) -- name: NavigationDrawer
    local var1 = withDefaults(tbl4, tbl3)
    local elevation = useElevation(ElevationLayer.Drawer, { stackAboveOwner = false })
    local var3 = useOverlay()
    local var4 = useHardwareInsets(var3)
    local width = useScaledValue(var1.width)
    local bool1 = var1.swipe == SwipeBehavior.Open or var1.swipe == SwipeBehavior.OpenAndDismiss
    local bool2 = var1.swipe == SwipeBehavior.Dismiss or var1.swipe == SwipeBehavior.OpenAndDismiss

    return React.createElement(InternalDrawer, {
        elevation = elevation,
        isOpen = var1.isOpen,
        onRequestClose = var1.onClose,
        onOpenComplete = var1.onOpenComplete,
        onCloseComplete = var1.onCloseComplete,
        side = InternalDrawerSide.Start,
        width = width,
        outerBleed = var4.left,
        backdrop = InternalDrawerBackdrop.Dismissible,
        layout = InternalDrawerLayout.FullBleed,
        shadow = InternalDrawerShadow.Overlay300,
        backgroundColor = "bg-surface-100",
        header = var1.header,
        footer = var1.footer,
        swipeToDismiss = if bool2 then tbl1 else nil,
        swipeToOpen = if bool1 then tbl2 else nil,
        onRequestOpen = var1.onOpen,
        testId = var1.testId,
        ref = ref
    }, var1.children)
end))
