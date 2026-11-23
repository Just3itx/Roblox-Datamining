-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local _Style = require(BulkPurchaseAppParent.Style)
local ItemCardThumbnail = require(BulkPurchaseAppParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local _AvatarExperienceCommon = require(BulkPurchaseAppParent.AvatarExperienceCommon)
local ItemStatusToItemStatusKey = require(BulkPurchaseApp.Enums.ItemStatusToItemStatusKey)

local FFlagBulkPurchaseEnablePurchaseOptions = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseEnablePurchaseOptions)

local _BulkPurchaseRequestItem = require(script.Parent.BulkPurchaseRequestItem)
local _BulkPurchaseRequestOwnedItem = require(script.Parent.BulkPurchaseRequestOwnedItem)
local _BulkPurchaseRequestUnpurchasableItem = require(script.Parent.BulkPurchaseRequestUnpurchasableItem)

local function toCardPropsWithId(tbl1: {presentationSlot: number, priceLineContent: number, title: number}, id: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = table.clone(tbl1)
    var1.id = id
    return var1
end

local module = {}

function module.mapItemsToRowPresentation(tbl1, tbl2)
    local result = {}
    for _, value in tbl1 do
        local priceLineContent = {{
            type = "price",
            price = value.cost
        }}

        if value.originalPrice then
            table.insert(priceLineContent, { type = "price", price = value.originalPrice, strikethrough = true })
        end

        if FFlagBulkPurchaseEnablePurchaseOptions and tbl2 and value.timedOptionDays and value.timedOptionDays > 0 then
            local timedOptionDays = value.timedOptionDays

            local tbl4 = {
                num = tostring(timedOptionDays)
            }
            table.insert(priceLineContent, {
                type = "badge",
                text = tbl2:Format(
                    if timedOptionDays == 1 then "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDay" else "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDays",
                    tbl4
                )
            })
        end

        local tbl4 = {
            presentationSlot = React.createElement(ItemCardThumbnail, { url = value.image }),
            title = value.name,
            priceLineContent = priceLineContent
        }
        table.insert(result, (toCardPropsWithId(tbl4, value.id)))
    end
    return result
end

function module.mapOwnedItemsToRowPresentation(tbl1, colorStyle, tbl2)
    local result = {}
    for _, value in tbl1 do
        local tbl3 = { type = "text", text = 0, colorStyle = 0 }

        local itemOwned = tbl2.itemOwned
        local ownedCount = value.ownedCount
        tbl3.text = itemOwned:gsub("{.*}", tostring(ownedCount))
        tbl3.colorStyle = colorStyle

        local tbl4 = {
            presentationSlot = React.createElement(ItemCardThumbnail, { url = value.image }),
            title = value.name,
            priceLineContent = { tbl3 }
        }
        table.insert(result, (toCardPropsWithId(tbl4, value.id)))
    end
    return result
end

function module.mapUnpurchasableItemsToRowPresentation(tbl1, tbl2, colorStyle, arg1)
    local result = {}
    for _, value in tbl1 do
        local text = tbl2[ItemStatusToItemStatusKey[value.status]]
        local var1 = if value.status == Enum.MarketplaceItemPurchaseStatus.Success then colorStyle else arg1
        local tbl3 = {
            presentationSlot = React.createElement(ItemCardThumbnail, { url = value.image }),
            title = value.name,
            priceLineContent = {{ type = "text", text = text, colorStyle = var1 }}
        }
        table.insert(result, (toCardPropsWithId(tbl3, value.id)))
    end
    return result
end

return module
