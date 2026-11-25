-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local _types = require(script.Parent.Parent.types)
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local FFlagHideLookDiscountPercentWithIneligibleItems = require(script.Parent.Parent.Flags.FFlagHideLookDiscountPercentWithIneligibleItems)
local FFlagPurchasePromptFetchCartPricingForLooks = SharedFlags.FFlagPurchasePromptFetchCartPricingForLooks
local FIntBlackbirdUpsellMinPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMinPriceForDiscountInclusive
local FIntBlackbirdUpsellMaxPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMaxPriceForDiscountInclusive

local function handleLooksProductInfoResult(arg1, tbl1): {IsForSale: boolean, Name: string, PriceDiscountDetails: {[any]: any}, PriceInRobux: any, UserBasePriceInRobux: any}?
    if not (arg1 and arg1.look and arg1.look.items) then
        return nil
    end

    local look = arg1.look
    local tbl2 = tbl1 or {}

    local tbl3 = {}
    for _, value in ipairs(tbl2.excludedAssetIds or {}) do
        tbl3[tostring(value)] = true
    end
    local tbl4 = {}
    for _, value in ipairs(tbl2.excludedBundleIds or {}) do
        tbl4[tostring(value)] = true
    end

    local tbl5 = {}
    for _, value in ipairs(tbl2.timedOptions or {}) do
        local itemType = value.itemType
        local itemId = value.itemId

        tbl5[itemType .. ":" .. tostring(itemId)] = value.days
    end

    local num1 = 0
    local num2 = 0
    local tbl6 = ({})

    local tbl7 = ({})
    local bool1 = false
    local bool2 = false
    local collectibleItemIds = {}
    local cartPricingRequestedItems = {}

    for _, item in ipairs(look.items) do
        local str1 = tostring(item.id)

        if item.itemType == "Asset" and tbl3[str1] or item.itemType == "Bundle" and tbl4[str1] then
            continue
        end

        local rentalDays = tbl5[item.itemType .. ":" .. str1]

        if FFlagPurchasePromptFetchCartPricingForLooks then
            local collectibleItemId = item.collectibleItemId or item.CollectibleItemId or item.collectible_item_id
            if type(collectibleItemId) == "string" and collectibleItemId ~= "" then
                table.insert(collectibleItemIds, collectibleItemId)
                local tbl10 = { collectibleItemId = collectibleItemId }
                if type(rentalDays) == "number" and rentalDays > 0 then
                    tbl10.rentalDays = rentalDays
                else
                    tbl10.isPermanent = true
                end
                table.insert(cartPricingRequestedItems, tbl10)
            end
        end
        local var2 = nil
        local discountInformation = nil

        if rentalDays and item.timedOptions then
            local bool3 = false
            for _, timedOption in ipairs(item.timedOptions) do
                if timedOption.days == rentalDays then
                    var2 = timedOption.price or 0
                    discountInformation = timedOption.discountInformation
                    bool3 = true
                    break
                end
            end

            if not bool3 then
                var2 = item.priceInRobux or 0
                discountInformation = item.discountInformation
            end
        else
            var2 = item.priceInRobux or 0
            discountInformation = item.discountInformation
        end

        num1 += var2
        local var3 = if discountInformation then discountInformation.originalPrice or var2 else var2
        local var4 = FIntBlackbirdUpsellMaxPriceForDiscountInclusive
        local bool3 = var3 <= FIntBlackbirdUpsellMinPriceForDiscountInclusive or not (var4 == 0) and var4 <= var3

        if discountInformation and not bool3 then
            bool1 = true
        else
            bool2 = true
        end

        if discountInformation then
            num2 += discountInformation.originalPrice or var2
            for _, value in ipairs(discountInformation.discounts or {}) do
                local discountCampaign = value.discountCampaign
                if not discountCampaign then
                    continue
                end

                tbl6[discountCampaign] = (tbl6[discountCampaign] or 0) + (value.robuxDiscountAmount or 0)
                if not FFlagPurchasePromptFetchCartPricingForLooks or tbl7[discountCampaign] ~= nil then
                    continue
                end

                local localizedDiscountAttribution = value.localizedDiscountAttribution
                if localizedDiscountAttribution ~= "" then
                    tbl7[discountCampaign] = localizedDiscountAttribution
                end
            end
        else
            num2 += var2
        end
    end

    local var1 = FFlagHideLookDiscountPercentWithIneligibleItems and bool1 and bool2

    local priceDiscountDetails = {}
    if num2 > 0 then
        for type, amountInRobux in pairs(tbl6) do
            if not (amountInRobux > 0) then
                continue
            end

            local tbl11 = {
                Type = type,
                AmountInRobux = amountInRobux,
                Percent = if var1 then 0 else math.round(amountInRobux / num2 * 100),
                LocalizedDiscountAttribution = if FFlagPurchasePromptFetchCartPricingForLooks then tbl7[type] else nil
            }
            table.insert(priceDiscountDetails, tbl11)
        end
    end

    local tbl11 = {
        PriceInRobux = num1,
        UserBasePriceInRobux = num2,
        PriceDiscountDetails = priceDiscountDetails,
        IsForSale = true,
        Name = "Looks"
    }

    if FFlagPurchasePromptFetchCartPricingForLooks then
        if #collectibleItemIds > 0 then
            tbl11.CollectibleItemIds = collectibleItemIds
            tbl11.CollectibleItemId = collectibleItemIds[1]
        end
        if #cartPricingRequestedItems > 0 then
            tbl11.CartPricingRequestedItems = cartPricingRequestedItems
        end
    end
    return tbl11
end

return handleLooksProductInfoResult
