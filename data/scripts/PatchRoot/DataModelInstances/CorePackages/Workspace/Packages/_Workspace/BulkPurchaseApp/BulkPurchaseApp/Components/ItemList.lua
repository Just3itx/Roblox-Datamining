-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local useTokens = require(BulkPurchaseAppParent.Foundation).Hooks.useTokens
local CatalogRowItemCard = require(BulkPurchaseAppParent.AvatarExperienceCommon).Components.CatalogItemCard.CatalogRowItemCard

local function ItemList(tbl1)
    local var1 = useTokens()
    local tbl2 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, var1.Gap.Medium)
        })
    }
    local size1200 = var1.Size.Size_1200
    for layoutOrder, item in tbl1.items do
        local tbl3 = {
            LayoutOrder = layoutOrder,
            title = item.title,
            presentationSlot = item.presentationSlot,
            priceLineContent = item.priceLineContent,
            headerSize = UDim2.fromOffset(size1200, size1200),
            footerSize = UDim2.new(1, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.XY
        }
        tbl2[item.id] = React.createElement(CatalogRowItemCard, tbl3)
    end
    return React.createElement("Frame", {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, tbl2)
end

return ItemList
