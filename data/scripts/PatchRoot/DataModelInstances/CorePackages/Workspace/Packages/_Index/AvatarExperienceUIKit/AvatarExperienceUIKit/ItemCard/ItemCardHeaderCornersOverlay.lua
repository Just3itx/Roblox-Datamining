-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local useTokens = require(AvatarExperienceUIKitParent.Foundation).Hooks.useTokens

local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXItemCardComponentsMemo = AvatarExperienceFlags.FFlagAXItemCardComponentsMemo
local FFlagAXMarketplaceItemCardIndicatorStack = AvatarExperienceFlags.FFlagAXMarketplaceItemCardIndicatorStack
local FFlagAXMarketplaceLicensingItemCards = AvatarExperienceFlags.FFlagAXMarketplaceLicensingItemCards

local function CornerSlot(tbl1)
    local constrainedWidth = if FFlagAXMarketplaceLicensingItemCards then tbl1.constrainedWidth else nil
    return React.createElement("Frame", {
        AutomaticSize = if constrainedWidth then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY,
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Size = if constrainedWidth then UDim2.new(constrainedWidth.Scale, constrainedWidth.Offset, 0, 0) else nil,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = constrainedWidth ~= nil,
        ZIndex = tbl1.ZIndex
    }, tbl1.children)
end

local function ItemCardHeaderCornersOverlay(tbl1)
    local small = useTokens().Gap.Small
    local var1 = if FFlagAXMarketplaceItemCardIndicatorStack then small + (tbl1.bottomInset or 0) else small
    local createElement = React.createElement
    local fragment = React.Fragment
    local var2 = nil
    local tbl2 = {
        ItemCardHeaderTopLeftSlot = if tbl1.topLeftSlot then React.createElement(CornerSlot, {
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.fromOffset(small, small),
            constrainedWidth = if tbl1.constrainTopLeftSlot then UDim.new(1, -2 * small) else nil,
            ZIndex = tbl1.ZIndex or 2
        }, tbl1.topLeftSlot) else nil,
        ItemCardHeaderTopRightSlot = if tbl1.topRightSlot then React.createElement(
            CornerSlot,
            {
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -small, 0, small),
                ZIndex = tbl1.ZIndex or 2
            },
            tbl1.topRightSlot
        ) else nil,
        ItemCardHeaderBottomLeftSlot = if tbl1.bottomLeftSlot then React.createElement(
            CornerSlot,
            {
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, small, 1, -var1),
                ZIndex = tbl1.ZIndex or 2
            },
            tbl1.bottomLeftSlot
        ) else nil,
        ItemCardHeaderBottomRightSlot = if tbl1.bottomRightSlot then React.createElement(
            CornerSlot,
            {
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.new(1, -small, 1, -var1),
                ZIndex = tbl1.ZIndex or 2
            },
            tbl1.bottomRightSlot
        ) else nil
    }
    return createElement(fragment, var2, tbl2)
end

if FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardHeaderCornersOverlay))
end

return ItemCardHeaderCornersOverlay
