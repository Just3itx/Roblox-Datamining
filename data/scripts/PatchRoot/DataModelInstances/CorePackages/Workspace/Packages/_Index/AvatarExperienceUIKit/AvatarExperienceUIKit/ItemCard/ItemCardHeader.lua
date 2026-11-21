-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)

local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens
local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXAddTransparencyToItemCardHeader = AvatarExperienceFlags.FFlagAXAddTransparencyToItemCardHeader

local function ItemCardHeader(tbl1)
    local var1 = useDesignTokens()
    local uDim = UDim.new(0, var1.Radius.Medium)

    local shimmer = var1.Color.Common.Shimmer

    return React.createElement("Frame", {
        Size = if tbl1.Size then tbl1.Size else UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = shimmer.Color3,
        BackgroundTransparency = if FFlagAXAddTransparencyToItemCardHeader then tbl1.BackgroundTransparency or shimmer.Transparency else shimmer.Transparency,
        LayoutOrder = tbl1.LayoutOrder,
        ZIndex = tbl1.ZIndex
    }, {
        CornerRadius = React.createElement("UICorner", { CornerRadius = uDim }),
        AspectRatio = if tbl1.Size then nil else React.createElement("UIAspectRatioConstraint", {
            AspectRatio = tbl1.aspectRatio or 1,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width
        }),
        ItemCardHeaderChildren = React.createElement(React.Fragment, nil, tbl1.children),
        ItemCardHeaderOverlaySlot = tbl1.overlaySlot
    })
end

if AvatarExperienceFlags.FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardHeader))
end

return ItemCardHeader
