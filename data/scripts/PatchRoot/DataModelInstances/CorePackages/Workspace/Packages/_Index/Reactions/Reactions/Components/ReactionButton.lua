-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)
local ReactOtter = require(ReactionsParent.ReactOtter)

local Reaction = require(Reactions.Components.Reaction)
local ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)

local ControlState = Foundation.Enums.ControlState
local View = Foundation.View
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local vector2 = Vector2.new(0.5, 0.5)

local tbl1 = { frequency = 4, dampingRatio = 0.65 }

local tbl2 = { frequency = 4, dampingRatio = 1 }

local function getCenter(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AbsolutePosition + arg1.AbsoluteSize / 2
end

return React.memo(function(tbl3) -- name: ReactionButton
    local var1 = useTokens()
    local reducedMotion = usePreferences().reducedMotion

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var1.Radius.Circle),
            offset = var1.Size.Size_150,
            borderWidth = var1.Stroke.Thicker
        }
    end, { var1 })

    local var3, var4 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        var4(hover == ControlState.Hover)
    end, {})

    local var6 = tbl3.isHovered == true or var3
    local hover, var8 = ReactOtter.useAnimatedBinding(0)
    React.useEffect(function()
        local num1 = if var6 then 1 else 0
        if reducedMotion then
            var8((ReactOtter.instant(num1)))
            return
        end
        var8((ReactOtter.spring(num1, tbl2)))
    end, { var6, reducedMotion })

    local entryDelay = tbl3.entryDelay
    local entry, var10 = ReactOtter.useAnimatedBinding(if entryDelay == nil then 1 else 0)
    React.useEffect(function()
        if entryDelay == nil or reducedMotion then
            var10((ReactOtter.instant(1)))
            return nil
        end
        local var11 = task.delay(entryDelay, function()
            var10((ReactOtter.spring(1, tbl1)))
        end)
        return function()
            task.cancel(var11)
        end
    end, { entryDelay, reducedMotion })

    local var11 = React.joinBindings({ entry = entry, hover = hover })
    local var12 = var11:map(function(tbl4): UDim2
        return UDim2.new(0.5, 0, 0.5, (1 - tbl4.entry) * 12 - tbl4.hover * 8)
    end)
    local scale = var11:map(function(tbl4)
        return tbl4.entry * (tbl4.hover * 0.1 + 1)
    end)

    local onActivated = tbl3.onActivated
    local var2 = React.useCallback(function(arg1)
        onActivated((getCenter(arg1)))
    end, { onActivated })

    local createElement = React.createElement
    local var15 = View
    local tbl4 = {
        tag = {
            ["size-1000-1000 radius-circle"] = true,
            ["bg-surface-300"] = tbl3.isActive == true
        },
        onActivated = var2,
        onStateChanged = onStateChanged,
        cursor = cursor,
        LayoutOrder = tbl3.layoutOrder,
        ref = tbl3.buttonRef,
        testId = tbl3.testId
    }
    local tbl5 = { Glyph = 0 }
    local createElement2 = React.createElement
    local var16 = View
    local tbl6 = {
        tag = "auto-xy",
        Position = var12,
        AnchorPoint = vector2,
        ZIndex = 2,
        scale = scale,
        testId = if tbl3.testId then `{tbl3.testId}--glyph` else nil
    }
    local tbl7 = {
        Reaction = React.createElement(Reaction, {
            reactionType = tbl3.reactionType,
            size = tbl3.reactionSize or ReactionSize.Small,
            testId = if tbl3.testId then `{tbl3.testId}--reaction` else nil
        })
    }
    tbl5.Glyph = createElement2(var16, tbl6, tbl7)
    return createElement(var15, tbl4, tbl5)
end)
