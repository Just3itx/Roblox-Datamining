-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local useTokens = require(AvatarExperienceUIKitParent.Foundation).Hooks.useTokens

local ItemCardPriceLine = require(script.Parent.ItemCardPriceLine)
local ItemCardCreatorName = require(script.Parent.ItemCardCreatorName)
local ItemCardTitle = require(script.Parent.ItemCardTitle)

local FFlagAXAddTextXAlignmentProp = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXAddTextXAlignmentProp

local function ItemCardFooter(tbl1)
    local var1 = useTokens()
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        ClipsDescendants = true
    }
    local tbl3 = {
        ItemCardFooterLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, var1.Gap.XSmall)
        }),
        ItemCardFooterInfo = 0,
        ItemCardFooterPrice = 0
    }
    local var2

    if tbl1.title or tbl1.creatorName then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1
        }

        local tbl5 = {
            ItemCardFooterInfoLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, var1.Gap.XXSmall)
            }),
            ItemCardFooterInfoTitle = if tbl1.title then React.createElement(ItemCardTitle, {
                title = tbl1.title,
                titleTextSize = tbl1.titleTextSize,
                LayoutOrder = 1,
                TextXAlignment = if FFlagAXAddTextXAlignmentProp then tbl1.TextXAlignment else nil
            }) else nil,
            ItemCardFooterInfoCreatorName = if tbl1.creatorName then React.createElement(ItemCardCreatorName, {
                name = tbl1.creatorName,
                hasVerifiedBadge = tbl1.creatorHasVerifiedBadge,
                LayoutOrder = 2,
                TextXAlignment = if FFlagAXAddTextXAlignmentProp then tbl1.TextXAlignment else nil
            }) else nil
        }
        var2 = createElement2(str2, tbl4, tbl5)
    else
        var2 = nil
    end

    tbl3.ItemCardFooterInfo = var2

    tbl3.ItemCardFooterPrice = if tbl1.priceLineContent then React.createElement(ItemCardPriceLine, { content = tbl1.priceLineContent, LayoutOrder = 2 }) else nil
    return createElement(str1, tbl2, tbl3)
end

if require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardFooter))
end

return ItemCardFooter
