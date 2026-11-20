-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local InternalDrawerOpenPhase = require(Foundation.Enums.InternalDrawerOpenPhase)
local ScrollBarVisibility = require(Foundation.Enums.ScrollBarVisibility)
local withDefaults = require(Foundation.Utility.withDefaults)

local InternalDrawerEdgeSwipe = require(script.Parent.InternalDrawerEdgeSwipe)
local InternalDrawerOverlay = require(script.Parent.InternalDrawerOverlay)
local _Types = require(script.Parent.Types)
local drawerMotion = require(script.Parent.drawerMotion)
local useInternalDrawerVariants = require(script.Parent.useInternalDrawerVariants)
local useSurfaceWidth = require(script.Parent.useSurfaceWidth)

local tbl1 = {
    outerBleed = 0,
    scrolls = true,
    scrollBarVisibility = ScrollBarVisibility.None,
    testId = "--foundation-internal-drawer"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalDrawer
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useInternalDrawerVariants(var1.layout, var1.side)
    local _, travel = useSurfaceWidth(var1.width, var2.surface.margin, var1.outerBleed)
    local var4, var5 = React.useState(var1.isOpen)
    local var6, var7 = React.useState(InternalDrawerOpenPhase.Idle)
    local var8 = React.useRef(var6)
    var8.current = var6
    local var9 = React.useRef(var1.isOpen)
    local drag, setDrag = drawerMotion.useDrag()
    if var1.isOpen and not var4 then
        var5(true)
    end
    if var1.isOpen then
        var9.current = true
        if var6 ~= InternalDrawerOpenPhase.Idle then
            var7(InternalDrawerOpenPhase.Idle)
        end
    end

    React.useEffect(function()
        if var6 == InternalDrawerOpenPhase.Requested and not var1.isOpen then
            var7(InternalDrawerOpenPhase.Settling)
        end
    end, { var6, var1.isOpen })

    local onCloseComplete = var1.onCloseComplete
    local onExited = React.useCallback(function()
        local current = var9.current
        var9.current = false
        var5(false)
        var7(InternalDrawerOpenPhase.Idle)
        if current and onCloseComplete then
            onCloseComplete()
        end
    end, { onCloseComplete })

    local onRequestOpen = var1.onRequestOpen
    local setPhase = React.useCallback(function(arg2)
        if arg2 == InternalDrawerOpenPhase.Idle and var8.current ~= InternalDrawerOpenPhase.Pressed then
            return
        end
        var7(arg2)
        if arg2 == InternalDrawerOpenPhase.Requested and onRequestOpen ~= nil then
            onRequestOpen()
        end
    end, { onRequestOpen })

    local var14 = var4 or var6 ~= InternalDrawerOpenPhase.Idle
    if not var14 and var1.swipeToOpen == nil then
        return nil
    end

    local var15 = Dash.join(var1, { ref = ref, onExited = onExited, drag = drag, setDrag = setDrag, openPhase = var6 })

    return React.createElement(React.Fragment, nil, {
        Edge = if var1.swipeToOpen == nil then nil else React.createElement(InternalDrawerEdgeSwipe, {
            config = var1.swipeToOpen,
            side = var1.side,
            outerBleed = var1.outerBleed,
            travel = travel,
            isOpen = var1.isOpen,
            zIndex = var1.elevation.zIndex,
            setPhase = setPhase,
            setDrag = setDrag,
            testId = var1.testId
        }),
        Overlay = if var14 then React.createElement(InternalDrawerOverlay, var15) else nil
    })
end))
