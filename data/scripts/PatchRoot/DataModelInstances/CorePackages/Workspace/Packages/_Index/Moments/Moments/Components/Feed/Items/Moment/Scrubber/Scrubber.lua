-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local ScrubberBar = require(script.Parent.ScrubberBar)
local MomentContext = require(script.Parent.Parent.MomentContext)
local useMomentProgress = require(script.Parent.Parent.Hooks.useMomentProgress)
local PreviewPopover = require(script.Parent.PreviewPopover)

local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useSignalBinding = SignalsReact.useSignalBinding

return React.memo(function(tbl1) -- name: Scrubber
    local var1 = MomentContext.useMoment()

    local isHovering, var3 = React.useState(false)
    local isPressed, var5 = React.useState(false)
    local var6, var7 = React.useState(false)

    local ref = React.useRef(nil)
    local var9 = React.useCallback(function(vector2: Vector2): number
        local current = ref.current
        if current == nil then
            return 0
        end

        local num1 = math.clamp((vector2.X - current.AbsolutePosition.X) / current.AbsoluteSize.X, 0, 1)
        var1.store.setScrubPosition(num1)

        return num1
    end, { var1.store.setScrubPosition })

    local var10 = useMomentProgress()
    local var11 = useSignalBinding(var10)
    local var12 = useSignalBinding(var1.store.getScrubPosition)

    local progress = React.joinBindings({ var12, var11 }):map(function(tbl2)
        local var13 = tbl2[1]
        local var14 = tbl2[2]

        if var13 == nil then
            var13 = var14.ratio
        end

        return {
            time = var13 * var14.duration,
            duration = var14.duration,
            ratio = var13
        }
    end)

    local progressRatio = progress:map(function(arg1)
        return arg1.ratio
    end)

    local createElement = React.createElement
    local var15 = View

    local tbl2 = {
        tag = "size-full-300",
        LayoutOrder = tbl1.LayoutOrder,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        onStateChanged = function(arg1)
            local bool1 = arg1 == ControlState.Hover or arg1 == ControlState.Selected
            local bool2 = arg1 == ControlState.Pressed or arg1 == ControlState.SelectedPressed

            var3(bool1)
            var5(bool2)
        end
    }

    local tbl3 = { DragContainer = 0, ScrubberBar = 0, PreviewPopover = 0 }
    local createElement2 = React.createElement
    local var16 = View

    local tbl4 = { DragDetector = 0 }
    local createElement3 = React.createElement
    local tbl5 = {
        CursorIcon = "",
        DragAxis = Vector2.new(1, 0),
        DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
        ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
    }

    tbl5[React.Event.DragStart] = function(_, vector2: Vector2)
        var7(true)
        if var1.controller then
            var1.controller.pause(0)
        end

        var9(vector2)
    end
    tbl5[React.Event.DragContinue] = function(_, vector2: Vector2)
        var9(vector2)
    end
    tbl5[React.Event.DragEnd] = function(_, vector2: Vector2)
        local var17 = var9(vector2)
        var1.store.setScrubPosition(nil)
        var7(false)

        if var1.controller then
            var1.controller.play()
            local duration = var1.controller.getState(false).duration
            var1.controller.seek(var17 * duration)
        end
    end

    tbl4.DragDetector = createElement3("UIDragDetector", tbl5)
    tbl3.DragContainer = createElement2(var16, { tag = "size-full", ZIndex = 2, ref = ref }, tbl4)

    tbl3.ScrubberBar = React.createElement(
        ScrubberBar,
        {
            isHovering = isHovering,
            isPressed = isPressed or var6,
            progressRatio = progressRatio
        }
    )
    tbl3.PreviewPopover = React.createElement(PreviewPopover, { progress = progress, progressRatio = progressRatio })
    return createElement(var15, tbl2, tbl3)
end)
