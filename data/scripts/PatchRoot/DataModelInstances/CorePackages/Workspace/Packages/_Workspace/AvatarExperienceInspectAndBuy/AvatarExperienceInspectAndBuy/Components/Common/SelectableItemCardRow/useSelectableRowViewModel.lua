-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local useTokens = require(AvatarExperienceInspectAndBuyParent.Foundation).Hooks.useTokens
local ItemCardThumbnail = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail

local _Types = require(AvatarExperienceInspectAndBuy.Types)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local getItemThumbnailUrl = require(AvatarExperienceInspectAndBuy.Utils.getItemThumbnailUrl)
local getCatalogCardItemType = require(AvatarExperienceInspectAndBuy.Utils.getCatalogCardItemType)
local getPriceLineContent = require(AvatarExperienceInspectAndBuy.Utils.getPriceLineContent)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local _SelectableItemCardRowView = require(script.Parent.SelectableItemCardRowView)

local function useSelectableRowViewModel(tbl1)
    local var1 = useTokens()
    local itemData = tbl1.itemData
    local var2 = if tbl1.isSelectionEnabled then tbl1.itemCardWidth - (var1.Size.Size_400 + var1.Gap.Medium) else tbl1.itemCardWidth

    local isOwned = React.useMemo(function(): boolean
        return getPriceStatus(itemData) == PriceStatus.Owned
    end, { itemData })

    local url = React.useMemo(function()
        if itemData.id == nil or itemData.itemType == nil then
            return nil
        end
        return getItemThumbnailUrl({ id = itemData.id, itemType = itemData.itemType })
    end, { itemData })

    local onItemCardActivated = tbl1.onItemCardActivated
    local onActivated = React.useCallback(function()
        onItemCardActivated(itemData)
    end, { itemData, onItemCardActivated })

    local isSelected = tbl1.isSelected
    local onSelectionChanged = tbl1.onSelectionChanged

    local onSelectionToggled = React.useCallback(function()
        onSelectionChanged(itemData, not isSelected)
    end, { itemData, isSelected, onSelectionChanged })

    return {
        cardProps = {
            title = itemData.name,
            presentationSlot = if url then React.createElement(ItemCardThumbnail, { url = url }) else nil,
            itemSubType = tbl1.itemSubTypeLabel,
            itemType = getCatalogCardItemType(itemData.itemRestrictions),
            creator = itemData.creator and {
                name = itemData.creator.creatorName or "",
                verified = itemData.creator.creatorHasVerifiedBadge
            }
                or nil,
            priceLineContent = getPriceLineContent(itemData, var1, tbl1.priceStatusLabels, tbl1.priceOptions),
            isOwned = isOwned,
            onActivated = onActivated,
            headerSize = UDim2.fromOffset(var2, var2),
            footerAutomaticSize = Enum.AutomaticSize.XY,
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = 2
        },
        isSelectionEnabled = tbl1.isSelectionEnabled,
        isSelected = isSelected,
        onSelectionToggled = onSelectionToggled,
        isSelectionDisabled = tbl1.isSelectionDisabled,
        checkboxSize = tbl1.checkboxSize,
        LayoutOrder = tbl1.LayoutOrder
    }
end

return useSelectableRowViewModel
