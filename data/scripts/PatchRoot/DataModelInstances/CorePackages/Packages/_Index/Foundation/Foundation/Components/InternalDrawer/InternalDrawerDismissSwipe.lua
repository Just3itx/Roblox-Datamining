-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local _InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Types = require(script.Parent.Types)
local OnCloseCallbackReason = require(Foundation.Enums.OnCloseCallbackReason)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local View = require(Foundation.Components.View)
local dismissSwipeHandlers = require(script.Parent.dismissSwipeHandlers)
local drawerMotion = require(script.Parent.drawerMotion)
local swipeMath = require(script.Parent.swipeMath)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useSwipeSession = require(script.Parent.useSwipeSession)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function InternalDrawerDismissSwipe(tbl1)
    local var1 = useTokens()
    local reducedMotion = usePreferences().reducedMotion
    local var2, var3 = React.useState(false)
    local var4 = React.useRef(nil)
    local distanceFraction, velocityThreshold = swipeMath.resolveThresholds(tbl1.config)

    local onClaim = React.useCallback(function()
        drawerMotion.hold(tbl1.motion)
    end, { tbl1.motion })

    local onRelease = React.useCallback(function(bool1: boolean)
        if bool1 then
            tbl1.onRequestClose(OnCloseCallbackReason.Swipe)
            var3(true)
            return
        end
        drawerMotion.animate(tbl1.motion, true, var1, reducedMotion)
    end, {
        tbl1.motion,
        tbl1.onRequestClose,
        var1,
        reducedMotion
    })
    local onCancel = React.useCallback(function()
        drawerMotion.animate(tbl1.motion, tbl1.isOpen, var1, reducedMotion)
    end, {
        tbl1.motion,
        tbl1.isOpen,
        var1,
        reducedMotion
    })
    local tbl2 = {
        side = tbl1.side,
        travel = tbl1.travel,
        isOpen = tbl1.isOpen,
        distanceFraction = distanceFraction,
        velocityThreshold = velocityThreshold,
        onClaim = onClaim,
        setDrag = tbl1.motion.setDrag,
        onRelease = onRelease,
        onCancel = onCancel
    }
    useSwipeSession(tbl2, function(latest)
        return {
            gesture = nil,
            latest = latest,
            panelRef = tbl1.panelRef,
            backdropRef = tbl1.backdropRef,
            scrollingFrameRef = tbl1.scrollingFrameRef,
            captureRef = var4,
            unlock = nil
        }
    end, dismissSwipeHandlers, tbl1.isOpen)

    React.useEffect(function()
        if not var2 then
            return
        end
        if tbl1.isOpen then
            drawerMotion.animate(tbl1.motion, true, var1, reducedMotion)
        end
        var3(false)
    end, {
        var2,
        tbl1.isOpen,
        tbl1.motion,
        var1,
        reducedMotion
    })
    return React.createElement(View, {
        Visible = false,
        ZIndex = 5,
        onActivated = Dash.noop,
        selection = Constants.MODAL.DISABLE_SELECTION,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        ref = var4,
        tag = "size-full",
        testId = `{tbl1.testId}--swipe-capture`
    })
end

return InternalDrawerDismissSwipe
