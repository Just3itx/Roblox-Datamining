-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local FFlagMomentsCommentRowRedesign = require(Moments.Flags.FFlagMomentsCommentRowRedesign)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local Reaction = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.Reaction) else MomentsCommon.Components.Reaction
local ReactionAssets = MomentsCommon.Components.ReactionAssets
local ReactionSize = MomentsCommon.Enums.ReactionSize
local ReactionType = MomentsCommon.Enums.ReactionType

local tbl1 = {
    Color3 = Color3.new(1, 1, 1),
    Transparency = 0
}
local tbl2 = { frequency = 5, dampingRatio = 0.5 }
local tbl3 = { frequency = 6, dampingRatio = 1 }

return React.memo(function(tbl4) -- name: CommentReactionButton
    local var1 = useTokens()
    local testId = `moments-comment-reaction-button-{tbl4.commentId}`

    local var2, var3 = ReactOtter.useAnimatedBinding(if tbl4.isReactionSelected then 1 else 0)
    local var4 = React.useRef({ commentId = tbl4.commentId, isReactionSelected = tbl4.isReactionSelected })
    React.useLayoutEffect(function()
        local current = var4.current
        var4.current = {
            commentId = tbl4.commentId,
            isReactionSelected = tbl4.isReactionSelected
        }
        local num1 = if tbl4.isReactionSelected then 1 else 0

        if current.commentId ~= tbl4.commentId then
            var3((ReactOtter.instant(num1)))
        elseif current.isReactionSelected ~= tbl4.isReactionSelected then
            var3(ReactOtter.spring(num1, if tbl4.isReactionSelected then tbl2 else tbl3))
        end
    end, { tbl4.commentId, tbl4.isReactionSelected })

    local var5 = if FFlagMomentsCommentRowRedesign then var1.Color.Content.Emphasis else var1.Color.Content.Default

    local style = var2:map(function(num1: number)
        return getColorStyleWithTransparency(var5, math.clamp(num1, 0, 1))
    end)
    local scale = var2:map(function(num1: number): number
        return math.lerp(1, 0.6, math.clamp(num1, 0, 1))
    end)
    local imageStyle = var2:map(function(num1: number)
        return getColorStyleWithTransparency(tbl1, 1 - math.clamp(num1, 0, 1))
    end)

    local var9 = if FFlagMomentsCommentRowRedesign then var1.Size.Size_400 / ReactionAssets.getSizePixels(ReactionSize.XSmall) else 1
    if FFlagMomentsUseSharedReactions and FFlagMomentsCommentRowRedesign then
        var9 = var1.Size.Size_400 / var1.Size.Size_500
    end
    local var6 = var2:map(function(num1: number)
        return math.lerp(0.6, 1, num1) * var9
    end)

    local small = var1.Padding.Small
    local offset = tbl4.rightInset or small
    local var11 = if FFlagMomentsCommentRowRedesign then small - (var1.Size.Size_600 - var1.Size.Size_400) / 2 else small

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var1.Radius.Medium),
            offset = 0,
            borderWidth = var1.Stroke.Thicker
        }
    end, { var1 })

    local createElement = React.createElement
    local var13 = View
    local tbl5 = {
        tag = {
            ["size-0-600 auto-x"] = FFlagMomentsCommentRowRedesign,
            ["auto-xy"] = not FFlagMomentsCommentRowRedesign
        },
        LayoutOrder = tbl4.LayoutOrder,
        testId = `moments-comment-reaction-{tbl4.commentId}`
    }
    local tbl6 = { PaddedContent = 0, HitArea = 0 }
    local createElement2 = React.createElement
    local var14 = View
    local tbl7 = {
        tag = "auto-xy",
        AnchorPoint = if FFlagMomentsCommentRowRedesign then Vector2.new(0, 0.5) else nil,
        Position = if FFlagMomentsCommentRowRedesign then UDim2.new(0, 0, 0.5, -1) else nil,
        padding = {
            right = UDim.new(0, offset),
            bottom = if FFlagMomentsCommentRowRedesign then nil else UDim.new(0, small)
        }
    }
    local tbl8 = { Content = 0 }
    local createElement3 = React.createElement
    local var15 = View
    local tbl9 = {
        tag = "row align-y-center gap-xsmall auto-xy",
        testId = `moments-comment-reaction-content-{tbl4.commentId}`,
        GroupTransparency = if tbl4.isReactionDisabled then 0.5 else nil
    }
    local tbl10 = { IconSlot = 0, Count = 0 }
    local createElement4 = React.createElement
    local var16 = View
    local tbl11 = {
        tag = {
            ["size-400-400"] = FFlagMomentsCommentRowRedesign,
            ["size-500-500"] = not FFlagMomentsCommentRowRedesign
        },
        LayoutOrder = 1,
        testId = `moments-comment-reaction-icon-slot-{tbl4.commentId}`
    }
    local tbl12 = { Thumb = 0, Reacted = 0 }
    local createElement5 = React.createElement
    local var17 = View
    local tbl13 = { tag = "position-center-center anchor-center-center size-full", scale = scale }
    local tbl14 = {
        Icon = React.createElement(Icon, {
            name = BuilderIcons.Icon.ThumbUp,
            size = if FFlagMomentsCommentRowRedesign then IconSize.Small else IconSize.Medium,
            style = style,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            testId = `{testId}--icon`
        })
    }
    tbl12.Thumb = createElement5(var17, tbl13, tbl14)

    tbl12.Reacted = React.createElement(Reaction, {
        reactionType = ReactionType.ThumbsUp,
        size = ReactionSize.XSmall,
        imageStyle = imageStyle,
        scale = var6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        testId = `{testId}--image`
    })
    tbl10.IconSlot = createElement4(var16, tbl11, tbl12)
    local element

    if tbl4.isReactionCountHidden then
        element = nil
    else
        element = React.createElement(FoundationText, {
            tag = {
                ["auto-xy"] = true,
                ["text-label-small content-emphasis"] = FFlagMomentsCommentRowRedesign,
                ["text-title-small content-emphasis"] = not FFlagMomentsCommentRowRedesign and tbl4.isReactionSelected,
                ["text-body-small content-default"] = not (FFlagMomentsCommentRowRedesign or tbl4.isReactionSelected)
            },
            Text = tbl4.reactionCountLabel,
            testId = `moments-comment-reaction-count-{tbl4.commentId}`,
            LayoutOrder = 2
        })
    end

    tbl10.Count = element
    tbl8.Content = createElement3(var15, tbl9, tbl10)
    tbl6.PaddedContent = createElement2(var14, tbl7, tbl8)

    tbl6.HitArea = React.createElement(View, {
        tag = "radius-medium",
        Position = UDim2.fromOffset(-small, -var11),
        Size = if FFlagMomentsCommentRowRedesign then UDim2.new(1, small, 1, 2 * var11) else UDim2.new(1, small, 1, small),
        ZIndex = 2,
        cursor = cursor,
        isDisabled = tbl4.isReactionDisabled,
        onActivated = if tbl4.isReactionDisabled then nil else tbl4.onReactionActivated,
        selection = {
            Selectable = not tbl4.isReactionDisabled
        },
        testId = testId
    })
    return createElement(var13, tbl5, tbl6)
end)
