-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local scriptParentParentParentParent = scriptParentParentParent.Parent
local Url = require(scriptParentParentParentParent.Http).Url
local IXPServiceWrapper = require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local logger = require(scriptParentParentParent.Utility.logger)
local GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)
local FStringIXPLayerMobileUpsell = require(scriptParentParentParent.Flags.FStringIXPLayerMobileUpsell)

local FFlagEnableRobuxUpsellPlusButtonExperiment = require(scriptParentParentParent.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment)

local url = Url.APIS_URL .. "payments-gateway/v1/products/get-upsell-suggestions"

local bool1 = game:DefineFastFlag("EnableUpsellVirtualItemBadge", false)

return function(upsellPlatform, userRobuxBalance: number, attemptRobuxAmount: number, maxPackages: number, itemProductId: number?, itemName: string?, universeId: number?, analyticId: string?, bool2: boolean?): (boolean, {experimentVariant: number, products: {[any]: any}, virtualItemBadgeType: any}?)
    local badgingV2Variant = nil
    if bool1 then
        logger.debug({ message = "Virtual item flag is on" })

        local layerData = IXPServiceWrapper:GetLayerData(FStringIXPLayerMobileUpsell)
        logger.debug({ message = "Layer data", layerData = layerData })

        if layerData and layerData.badgingV2Variant then
            badgingV2Variant = layerData.badgingV2Variant
            IXPServiceWrapper:LogUserLayerExposure(FStringIXPLayerMobileUpsell)
        end
    end

    local input = {
        upsell_platform = upsellPlatform,
        user_robux_balance = userRobuxBalance,
        attempt_robux_amount = attemptRobuxAmount,
        max_packages = maxPackages,
        virtual_item_badge_variant = badgingV2Variant
    }
    if FFlagEnableRobuxUpsellPlusButtonExperiment then
        input.is_eligible_for_experiment = bool2 == true
    end
    if itemProductId ~= nil then
        input.item_product_id = itemProductId
    end
    if itemName ~= nil then
        input.item_name = itemName
    end
    if universeId ~= nil then
        input.universe_id = universeId
    end
    if analyticId ~= nil then
        input.analytic_id = analyticId
    end

    logger.debug({ message = "Making GetUpsellSuggestions API Call", url = url, data = input })

    local success, result = pcall(function(): string
        return HttpRbxApiService:PostAsyncFullUrl(url, HttpService:JSONEncode(input))
    end)

    logger.debug({ message = "GetUpsellSuggestions API Response", response = result, success = success })

    if not success then
        return false, nil
    end

    local var1 = HttpService:JSONDecode(result)
    local tbl1 = {
        products = {},
        virtualItemBadgeType = var1.virtual_item_badge_type,
        experimentVariant = if FFlagEnableRobuxUpsellPlusButtonExperiment then GetUpsellSuggestionsTypes.normalizeExperimentVariant(var1.experiment_variant) else nil
    }

    for i, product in ipairs(var1.products) do
        local products = tbl1.products
        local tbl2 = {
            productId = product.roblox_product_id,
            providerId = product.provider_product_id,
            productName = product.roblox_product_name,
            robuxAmount = product.robux_amount,
            robuxAmountBeforeBonus = product.robux_amount_before_bonus,
            price = product.price,
            badgeType = product.badge_type
        }
        products[i] = tbl2
    end

    return true, tbl1
end
