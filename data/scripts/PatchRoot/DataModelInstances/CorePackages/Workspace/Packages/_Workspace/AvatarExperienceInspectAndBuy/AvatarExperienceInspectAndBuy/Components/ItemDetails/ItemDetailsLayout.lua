-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local ItemDetailsView = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.ItemDetailsView)
local BuyActionBarLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.BuyActionBarLayout)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)
local useTokens = Foundation.Hooks.useTokens
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local Cryo = require(AvatarExperienceInspectAndBuyParent.Cryo)

local function ItemDetailsLayout(tbl1)
    local var1 = useTokens()

    local size2700 = var1.Size.Size_2700

    local var2 = React.useMemo(function()
        return Cryo.Dictionary.join(tbl1.itemDetailsViewProps, { buyActionBarOffset = size2700 })
    end, { tbl1.itemDetailsViewProps, size2700 })

    local bool1 = tbl1.view == ViewType.Compact
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "size-full" }

    local tbl3 = {
        ItemDetailsView = React.createElement(ItemDetailsView, var2),
        BuyActionBarLayout = 0
    }
    local element

    if bool1 then
        element = React.createElement(BuyActionBarLayout, {
            buyActionBarProps = tbl1.buyActionBarProps,
            enableTopBorder = true,
            ZIndex = 2,
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            padding = UDim.new(0, var1.Padding.Medium),
            Size = UDim2.new(1, 0, 0, size2700)
        })
    else
        element = nil
    end

    tbl3.BuyActionBarLayout = element
    return createElement(view, tbl2, tbl3)
end

return ItemDetailsLayout
