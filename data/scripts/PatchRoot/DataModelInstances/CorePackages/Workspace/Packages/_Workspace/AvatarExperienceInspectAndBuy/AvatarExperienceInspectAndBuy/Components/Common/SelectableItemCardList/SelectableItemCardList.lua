-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local _AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)

local _Types = require(AvatarExperienceInspectAndBuy.Types)
local _PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local _getPriceLineContent = require(AvatarExperienceInspectAndBuy.Utils.getPriceLineContent)
local SelectableCardRowContainer = require(AvatarExperienceInspectAndBuy.Components.Common.SelectableItemCardRow.SelectableCardRowContainer)

local tbl1 = { isShopContext = true }

local function SelectableItemCardList(tbl2)
    local rows = tbl2.rows
    local priceStatusLabels = tbl2.priceStatusLabels
    local itemSubTypeLabels = tbl2.itemSubTypeLabels
    local itemCardWidth = tbl2.itemCardWidth
    local onSelectionChanged = tbl2.onSelectionChanged
    local priceOptions = tbl2.priceOptions or tbl1

    local var2 = React.useMemo(function()
        local result = ({})
        for layoutOrder, row in rows do
            local isEquipped = row.isEquipped
            local itemSubTypeLabel = if itemSubTypeLabels == nil or row.itemData.itemType == nil then nil else itemSubTypeLabels[row.itemData.itemType]
            local tbl3 = {
                itemData = row.itemData,
                priceStatusLabels = priceStatusLabels,
                itemSubTypeLabel = if itemSubTypeLabel == nil or row.itemData.itemSubType == nil then nil else itemSubTypeLabel[tostring(row.itemData.itemSubType)],
                LayoutOrder = layoutOrder,
                itemCardWidth = itemCardWidth,
                isSelectionEnabled = true,
                isSelected = isEquipped,
                onSelectionChanged = onSelectionChanged,
                onItemCardActivated = 0,
                priceOptions = 0
            }

            function tbl3.onItemCardActivated(arg1)
                onSelectionChanged(arg1, not isEquipped)
            end
            tbl3.priceOptions = priceOptions
            local var3

            if row.itemData and row.itemData.id ~= nil and row.itemData.itemType ~= nil then
                var3 = "Row_" .. tostring(row.itemData.id) .. "-" .. tostring(row.itemData.itemType)
            else
                var3 = "Row_" .. tostring(layoutOrder)
            end

            result[var3] = React.createElement(SelectableCardRowContainer, tbl3)
        end
        return result
    end, {
        rows,
        priceStatusLabels,
        itemSubTypeLabels,
        itemCardWidth,
        onSelectionChanged,
        priceOptions
    })

    return React.createElement(
        Foundation.View,
        {
            tag = "col gap-medium size-full-0 auto-y",
            testId = "SelectableItemCardList",
            LayoutOrder = tbl2.LayoutOrder
        },
        var2
    )
end

return SelectableItemCardList
