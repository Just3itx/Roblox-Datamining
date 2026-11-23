-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)

local Foundation = require(AppChatParent.Foundation)
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local RoundedVariant = require(AppChat.Enums.RoundedVariant)
local getGameCardThumbnailCornerRadii = require(script.Parent.getGameCardThumbnailCornerRadii)

local FFlagAppChatNativeFoundationCornerRadii = require(AppChat.Flags.FFlagAppChatNativeFoundationCornerRadii)

local tbl1 = { LayoutOrder = 0, aspectRatio = 1, Visible = true }

local keypoints = {
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.1, 1),
    NumberSequenceKeypoint.new(0.4, 0),
    NumberSequenceKeypoint.new(1, 0)
}

return React.memo(function(tbl2) -- name: GameCardThumbnail
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local size500 = useTokens().Size.Size_500

    if FFlagAppChatNativeFoundationCornerRadii then
        return React.createElement(Image, {
            Size = UDim2.new(1, 0, 1, 0),
            Image = var1.gameThumbnail,
            ZIndex = 0,
            LayoutOrder = var1.LayoutOrder,
            aspectRatio = {
                AspectRatio = var1.aspectRatio,
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Width
            },
            cornerRadius = getGameCardThumbnailCornerRadii(var1.roundedVariant, size500),
            onActivated = var1.onActivated,
            Visible = var1.Visible
        })
    end

    local var2 = React.useMemo(function()
        local num1 = math.deg(math.atan(var1.aspectRatio))

        return {
            [RoundedVariant.Top] = 90,
            [RoundedVariant.TopLeft] = num1 + 0,
            [RoundedVariant.TopRight] = 180 - num1
        }
    end, { var1.aspectRatio })

    local transparencyGradient = React.useMemo(function()
        return React.createElement("UIGradient", {
            Rotation = if var1.roundedVariant then var2[var1.roundedVariant] else 0,
            Transparency = NumberSequence.new(keypoints)
        })
    end, { var1.roundedVariant, var2 })

    return React.createElement(Image, {
        Size = UDim2.new(1, 0, 1, 0),
        Image = var1.gameThumbnail,
        ZIndex = 0,
        LayoutOrder = var1.LayoutOrder,
        aspectRatio = {
            AspectRatio = var1.aspectRatio,
            AspectType = Enum.AspectType.ScaleWithParentSize,
            DominantAxis = Enum.DominantAxis.Width
        },
        cornerRadius = UDim.new(0, size500),
        onActivated = var1.onActivated,
        Visible = var1.Visible
    }, {
        OverlayImage = React.createElement(
            Image,
            {
                tag = "size-full",
                Image = var1.gameThumbnail,
                Visible = var1.Visible
            },
            { TransparencyGradient = transparencyGradient }
        )
    })
end)
