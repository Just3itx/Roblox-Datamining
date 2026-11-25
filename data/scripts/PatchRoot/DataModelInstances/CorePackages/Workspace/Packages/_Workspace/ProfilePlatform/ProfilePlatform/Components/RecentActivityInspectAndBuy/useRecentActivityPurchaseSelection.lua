-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Dash = require(ProfilePlatformParent.Dash)

local _Types = require(ProfilePlatform.Common.Types)
local InspectAvatarUtils = require(ProfilePlatform.Components.InspectAvatar.InspectAvatarUtils)
local _sendProfilePurchaseEvents = require(ProfilePlatform.Analytics.sendProfilePurchaseEvents)

local FFlagProfileUnifiedPurchaseLogging = require(ProfilePlatform.Flags.FFlagProfileUnifiedPurchaseLogging)

local isItemPurchasable = InspectAvatarUtils.isItemPurchasable
local getPriceStatus = InspectAvatarUtils.getPriceStatus
local PriceStatusEnum = InspectAvatarUtils.PriceStatusEnum

local function useRecentActivityPurchaseSelection(tbl1)
    local selectedItems, var2 = React.useState({})
    local var3 = React.useRef({})

    React.useEffect(function()
        if #tbl1 == 0 then
            return
        end
        local tbl2 = ({})
        local bool1 = false
        for _, value in tbl1 do
            local id = value.id
            if isItemPurchasable(value) and not var3.current[id] then
                var3.current[id] = true
                tbl2[id] = true
                bool1 = true
            end
        end

        if not bool1 then
            return
        end
        var2(function(arg1)
            return Dash.join(arg1, tbl2)
        end)
    end, { tbl1 })

    return {
        selectedItems = selectedItems,
        onToggleItem = React.useCallback(function(str1: string)
            var2(function(arg1)
                return Dash.join(arg1, { [str1] = not arg1[str1] })
            end)
        end, {}),
        purchaseData = React.useMemo(function()
            local lineItems = {}
            local purchasedItems = FFlagProfileUnifiedPurchaseLogging and {} or nil
            local num1 = 0
            local num2 = 0
            for _, value in tbl1 do
                if not value.id then
                    continue
                end

                local id = value.id
                if not (selectedItems[id] and isItemPurchasable(value)) then
                    continue
                end

                local effectivePrice = InspectAvatarUtils.getEffectivePrice(value)

                table.insert(lineItems, {
                    collectibleProductId = if getPriceStatus(value) == PriceStatusEnum.PurchaseFromResale and value.collectibleItemDetails then value.collectibleItemDetails.collectibleLowestAvailableResaleProductId or value.collectibleProductId else value.collectibleProductId,
                    agreedPriceRobux = effectivePrice
                })
                if FFlagProfileUnifiedPurchaseLogging and purchasedItems then
                    table.insert(
                        purchasedItems,
                        {
                            itemId = id,
                            itemType = value.itemType,
                            itemSubType = tonumber(value.itemSubType),
                            priceInRobux = effectivePrice
                        }
                    )
                end

                num1 += effectivePrice
                num2 += 1
            end

            return {
                lineItems = lineItems,
                totalPrice = num1,
                count = num2,
                purchasedItems = purchasedItems
            }
        end, { tbl1, selectedItems })
    }
end

return useRecentActivityPurchaseSelection
