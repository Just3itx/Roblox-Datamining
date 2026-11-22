-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)
local ReactOtter = require(ReactionsParent.ReactOtter)

local Reaction = require(Reactions.Components.Reaction)
local ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)
local abbreviateReactionCount = require(Reactions.Utils.abbreviateReactionCount)

local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local FoundationText = Foundation.Text
local View = Foundation.View
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local function easeOut(alpha: number): number
    return TweenService:GetValue(alpha, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end

local function getPopScale(num1: number): number
    if num1 < 0.6 then
        return math.lerp(0.88, 1.08, easeOut(num1 / 0.6))
    end
    return math.lerp(1.08, 1, easeOut((num1 - 0.6) / 0.4))
end

local function getPopOpacity(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if not (num1 < 0.6) then
        return 1
    end

    return math.lerp(0.55, 1, easeOut(num1 / 0.6))
end

local function CountText(tbl1)
    local default = useTokens().Color.Content.Default
    local var1, var2 = ReactOtter.useAnimatedBinding(if tbl1.isAnimated then 0 else 1)

    React.useLayoutEffect(function()
        if tbl1.isAnimated then
            var2((ReactOtter.ease(1, { duration = 0.24 })))
        end
    end, { tbl1.isAnimated })

    return React.createElement(FoundationText, {
        Text = tbl1.text,
        scale = if tbl1.isAnimated then var1:map(getPopScale) else nil,
        textStyle = if tbl1.isAnimated then var1:map(function(num1: number)
            return {
                Color3 = default.Color3,
                Transparency = 1 - (1 - (default.Transparency or 0)) * getPopOpacity(num1)
            }
        end) else nil,
        tag = "auto-xy text-label-small content-default",
        LayoutOrder = 2,
        testId = tbl1.testId
    })
end

local function PoppingCount(tbl1)
    local reducedMotion = usePreferences().reducedMotion
    local var1, var2 = React.useState(0)
    local var3 = React.useRef(tbl1.count)

    React.useLayoutEffect(function()
        if var3.current ~= tbl1.count then
            var3.current = tbl1.count
            var2(function(num1: number): number
                return num1 + 1
            end)
        end
    end, { tbl1.count })

    return React.createElement(CountText, {
        key = tostring(var1),
        text = tbl1.localizeCount(tbl1.count),
        isAnimated = var1 > 0 and not reducedMotion,
        testId = tbl1.testId
    })
end

return React.memo(function(tbl1) -- name: ReactionPill
    local testId = tbl1.testId or "reaction-pill"
    local count = tbl1.count
    if count == 0 then
        return nil
    end

    local bool1 = tbl1.isSelected == true

    return React.createElement(View, {
        tag = {
            ["row align-y-center gap-xsmall auto-xy padding-small stroke-standard radius-circle"] = true,
            ["stroke-action-standard bg-shift-300"] = bool1,
            ["stroke-default bg-surface-100"] = not bool1
        },
        stateLayer = bool1 and {
            affordance = StateLayerAffordance.None
        } or nil,
        onActivated = tbl1.onActivated,
        LayoutOrder = tbl1.layoutOrder,
        testId = testId
    }, {
        Reaction = React.createElement(Reaction, {
            reactionType = tbl1.reactionType,
            size = ReactionSize.XSmall,
            LayoutOrder = 1,
            testId = `{testId}--reaction`
        }),
        Count = if count == nil then nil else React.createElement(
            PoppingCount,
            {
                count = count,
                localizeCount = tbl1.localizeCount or abbreviateReactionCount,
                testId = `{testId}--count`
            }
        )
    })
end)
