-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local usePreferences = Foundation.Hooks.usePreferences

local Reaction = MomentsCommon.Components.Reaction
local ReactionSize = MomentsCommon.Enums.ReactionSize

local tbl1 = { frequency = 4, dampingRatio = 0.65 }
local tbl2 = { frequency = 4, dampingRatio = 1 }

return React.memo(function(tbl3) -- name: PickerItem
    local reducedMotion = usePreferences().reducedMotion
    local ref = React.useRef(nil)

    local onActivated = React.useCallback(function()
        local current = ref.current
        local var2 = if current == nil then nil else current.AbsolutePosition + current.AbsoluteSize / 2
        tbl3.onSelect(tbl3.reaction, var2)
    end, { tbl3.onSelect, tbl3.reaction })

    local entry, var4 = ReactOtter.useAnimatedBinding(0)
    local hover, var6 = ReactOtter.useAnimatedBinding(0)

    React.useEffect(function()
        if reducedMotion then
            var4(ReactOtter.instant(1))
            return
        end

        local var7 = task.delay((tbl3.index - 1) * 0.04, function()
            var4((ReactOtter.spring(1, tbl1)))
        end)
        return function()
            task.cancel(var7)
        end
    end, { tbl3.index, reducedMotion })

    local var7, var8 = React.useState(false)
    React.useEffect(function()
        local num1 = if var7 then 1 else 0
        if reducedMotion then
            var6(ReactOtter.instant(num1))
            return
        end
        var6((ReactOtter.spring(num1, tbl2)))
    end, { var7, reducedMotion })

    local onStateChanged = React.useCallback(function(arg1)
        var8(
            arg1 == ControlState.Hover
                or arg1 == ControlState.Pressed
                or arg1 == ControlState.Selected
                or arg1 == ControlState.SelectedPressed
        )
    end, {})

    local scale = React.joinBindings({ entry = entry, hover = hover }):map(function(tbl4)
        return tbl4.entry * (tbl4.hover * 0.1 + 1)
    end)
    local var11 = React.joinBindings({ entry = entry, hover = hover }):map(function(tbl4): UDim2
        local yOffset = (1 - tbl4.entry) * 12 - tbl4.hover * 8
        return UDim2.new(0.5, 0, 0.5, yOffset)
    end)

    return React.createElement(View, {
        tag = "size-800-800",
        onActivated = onActivated,
        onStateChanged = onStateChanged,
        LayoutOrder = tbl3.index,
        selection = { Selectable = true },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        ref = ref
    }, {
        Glyph = React.createElement(Reaction, {
            reactionType = tbl3.reaction,
            size = ReactionSize.Medium,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = var11,
            scale = scale
        })
    })
end)
