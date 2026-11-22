-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)

local FoundationText = Foundation.Text
local View = Foundation.View
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState
local Reaction = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.Reaction) else MomentsCommon.Components.Reaction
local ReactionSize = MomentsCommon.Enums.ReactionSize

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)
local ReactionsSheet = require(Moments.Components.ReactionsSheet)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)

local function formatCount(num1: number?): string -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil then
        return ""
    elseif num1 >= 1000000 then
        return string.format("%.1fM", num1 / 1000000)
    elseif num1 >= 1000 then
        return string.format("%.1fK", num1 / 1000)
    end
    return tostring(num1)
end

return React.memo(function(tbl1) -- name: Reactions
    local var1 = useTokens()
    local var2 = MomentContext.useMoment()

    local var3, var4 = React.useState(false)

    local var5 = useSignalBinding(var2.store.getReactionCount)

    local reactionCounts = useSignalState(var2.store.getIndividualReactionCounts)
    local animationRatio = var2.animationRatio

    local imageStyle = animationRatio:map(function(num1: number)
        return getColorStyleWithTransparency(var1.Color.Content.Emphasis, num1)
    end)

    local onActivated = React.useCallback(function()
        var4(true)
    end, {})

    local onClose = React.useCallback(function()
        var4(false)
    end, {})

    local tbl2 = ({})
    local num1 = #reactionCounts

    for layoutOrder = 1, math.min(3, num1) do
        local var10 = reactionCounts[layoutOrder]
        local str1 = "Reaction" .. layoutOrder
        tbl2[str1] = React.createElement(
            Reaction,
            {
                LayoutOrder = layoutOrder,
                reactionType = var10.reaction,
                size = ReactionSize.Small,
                imageStyle = imageStyle
            }
        )
    end
    return React.createElement(React.Fragment, nil, {
        ReactionsLine = React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row align-x-left align-y-center gap-small auto-xy",
            onActivated = onActivated,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            Visible = var5:map(function(num2: number?): boolean
                return num2 ~= nil
            end)
        }, {
            Facepile = React.createElement(View, { LayoutOrder = 1, tag = "row align-x-left align-y-center gap-xxsmall auto-xy" }, tbl2),
            Count = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "auto-xy text-body-medium text-align-x-left text-align-y-center content-default",
                Text = var5:map(function(num2: number?): string
                    local str1 = formatCount(num2)
                    return `{str1} reactions`
                end),
                textStyle = animationRatio:map(function(num2: number)
                    return getColorStyleWithTransparency(var1.Color.Content.Default, num2)
                end)
            })
        }),
        Modal = if var3 then React.createElement(ReactionsSheet, { reactionCounts = reactionCounts, onClose = onClose }) else nil
    })
end)
