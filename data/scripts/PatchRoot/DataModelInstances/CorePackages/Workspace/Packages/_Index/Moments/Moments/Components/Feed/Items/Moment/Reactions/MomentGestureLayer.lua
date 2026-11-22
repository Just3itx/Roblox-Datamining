-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local View = Foundation.View
local useSignalState = SignalsReact.useSignalState

local MomentContext = require(script.Parent.Parent.MomentContext)
local useMomentGestures = require(script.Parent.useMomentGestures)
local useReactionCommit = require(script.Parent.useReactionCommit)

return React.memo(function(tbl1) -- name: MomentGestureLayer
    local var1 = MomentContext.useMoment()
    local controller = var1.controller
    local store = var1.store
    local var2 = useReactionCommit()

    local var3 = useSignalState(store.getIsModerated)
    local var4 = useSignalState(store.getIsScrubbing)

    local onSingleTapConfirmed = React.useCallback(function()
        if controller ~= nil then
            controller.toggle()
        end
    end, { controller })

    local onDoubleTap = React.useCallback(function(vector2: Vector2)
        var2("doubleTap", vector2, nil)
    end, { var2 })

    local var7 = useMomentGestures(not (var3 or var4), { onSingleTapConfirmed = onSingleTapConfirmed, onDoubleTap = onDoubleTap })

    return React.createElement(
        View,
        {
            ref = var7.ref,
            tag = "size-full",
            Active = true,
            BackgroundTransparency = 1,
            ZIndex = tbl1.ZIndex
        }
    )
end)
