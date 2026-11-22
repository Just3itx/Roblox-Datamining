-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseEligibleOffers(eligibleOffers)
    assert(type(eligibleOffers) == "table", "Expected EligibleOffers to be a table")
    local result = {}
    for _, eligibleOffer in ipairs(eligibleOffers) do
        assert(type(eligibleOffer) == "table", "Expected each EligibleOffer to be a table")

        table.insert(result, {
            Duration = tonumber(eligibleOffer.Duration) or 0,
            OfferType = tostring(eligibleOffer.OfferType or ""),
            PeriodType = tostring(eligibleOffer.PeriodType or "")
        })
    end
    return result
end

local function parseRobloxSubscriptionDiscounts(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local result = {}
    for _, value in ipairs(arg1) do
        if type(value) ~= "table" then
            continue
        end

        table.insert(result, {
            DiscountPercent = tonumber(value.DiscountPercent) or 0,
            PeriodIndex = tonumber(value.PeriodIndex) or 0,
            TierId = tostring(value.TierId or "")
        })
    end

    return result
end

local function parseFeatureConfig(featureConfig)
    assert(type(featureConfig) == "table", "Expected FeatureConfig to be a table")

    return {
        IsRobuxTransferEnabled = featureConfig.IsRobuxTransferEnabled == true,
        IsTradingEnabled = featureConfig.IsTradingEnabled == true,
        IsUgcPublishingEnabled = featureConfig.IsUgcPublishingEnabled == true,
        VirtualTransactionDiscounts = parseRobloxSubscriptionDiscounts(featureConfig.VirtualTransactionDiscounts),
        PrivateServerDiscounts = parseRobloxSubscriptionDiscounts(featureConfig.PrivateServerDiscounts)
    }
end

local function parseRobloxSubscriptionProductDetails(robloxSubscriptionProductDetails) -- Luacid: Inlined by compiler; 1 call site recovered
    assert(type(robloxSubscriptionProductDetails) == "table", "Expected RobloxSubscriptionProductDetails to be a table")
    return {
        FeatureConfig = parseFeatureConfig(robloxSubscriptionProductDetails.FeatureConfig)
    }
end

local function parseProductTypeDetails(arg1) -- Luacid: unused: defined but never referenced
    assert(type(arg1) == "table", "Expected ProductTypeDetails to be a table")
    return {
        RobloxSubscriptionProductDetails = parseRobloxSubscriptionProductDetails(arg1.RobloxSubscriptionProductDetails)
    }
end

local function parseLocalizedPrice(localizedPrice)
    assert(type(localizedPrice) == "table", "Expected LocalizedPrice to be a table")
    return {
        CurrencyCode = tostring(localizedPrice.CurrencyCode or ""),
        Nanos = tonumber(localizedPrice.Nanos) or 0,
        Units = tonumber(localizedPrice.Units) or 0
    }
end

local function parseProductKey(productKey)
    if type(productKey) ~= "table" then
        return { Id = "", Type = "" }
    end
    return {
        Id = tostring(productKey.Id or ""),
        Type = tostring(productKey.Type or "")
    }
end

local function parseEligibleOffersFromRest(eligibleOffers)
    if type(eligibleOffers) ~= "table" then
        return {}
    end
    local result = {}
    for _, eligibleOffer in ipairs(eligibleOffers) do
        if type(eligibleOffer) ~= "table" then
            continue
        end
        local freeTrialOffer = if type(eligibleOffer.freeTrialOffer) == "table" then eligibleOffer.freeTrialOffer else nil
        table.insert(result, {
            Duration = tonumber(freeTrialOffer and freeTrialOffer.duration) or 0,
            OfferType = tostring(eligibleOffer.offerType or ""),
            PeriodType = tostring(freeTrialOffer and freeTrialOffer.periodType or "")
        })
    end

    return result
end

local function parseDiscountsFromRest(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local result = {}
    for _, value in ipairs(arg1) do
        if type(value) ~= "table" then
            continue
        end

        table.insert(result, {
            DiscountPercent = tonumber(value.discountPercent) or 0,
            PeriodIndex = tonumber(value.periodIndex) or 0,
            TierId = tostring(value.tierId or "")
        })
    end

    return result
end

local function parseFeatureConfigFromRest(arg1)
    local var1 = type(arg1) ~= "table" and {} or arg1
    return {
        IsRobuxTransferEnabled = var1.isRobuxTransferEnabled == true,
        IsTradingEnabled = var1.isTradingEnabled == true,
        IsUgcPublishingEnabled = var1.isUgcPublishingEnabled == true,
        VirtualTransactionDiscounts = parseDiscountsFromRest(var1.virtualTransactionDiscounts),
        PrivateServerDiscounts = parseDiscountsFromRest(var1.privateServerDiscounts)
    }
end

local function parseLocalizedPriceFromRest(localizedPrice)
    local var1 = type(localizedPrice) ~= "table" and {} or localizedPrice
    return {
        CurrencyCode = tostring(var1.currencyCode or ""),
        Nanos = tonumber(var1.nanos) or 0,
        Units = tonumber(var1.units) or 0
    }
end

local function parseProductKeyFromRest(productKey)
    if type(productKey) ~= "table" then
        return { Id = "", Type = "" }
    end
    return {
        Id = tostring(productKey.id or ""),
        Type = tostring(productKey.type or "")
    }
end

local module = {}

function module.new<T>(tbl1): T
    return tbl1
end

function module.format(arg1)
    assert(type(arg1) == "table", "Expected products response to be a table")
    local result = {}
    for _, value in ipairs(arg1) do
        if type(value) == "table" then
            assert(type(value.PeriodType) == "string" and value.PeriodType ~= "", "Missing or invalid PeriodType")
            local tbl1 = {
                EligibleOffers = parseEligibleOffers(value.EligibleOffers),
                LocalizedPrice = parseLocalizedPrice(value.LocalizedPrice),
                LocalizedPriceDisplayString = if type(value.LocalizedPriceDisplayString) == "string" then value.LocalizedPriceDisplayString or nil else nil,
                PeriodType = tostring(value.PeriodType),
                ProductKey = parseProductKey(value.ProductKey),
                ProductTypeDetails = 0
            }
            local productTypeDetails = value.ProductTypeDetails
            assert(type(productTypeDetails) == "table", "Expected ProductTypeDetails to be a table")
            local tbl2 = { RobloxSubscriptionProductDetails = 0 }
            local robloxSubscriptionProductDetails = productTypeDetails.RobloxSubscriptionProductDetails
            assert(type(robloxSubscriptionProductDetails) == "table", "Expected RobloxSubscriptionProductDetails to be a table")
            tbl2.RobloxSubscriptionProductDetails = {
                FeatureConfig = parseFeatureConfig(robloxSubscriptionProductDetails.FeatureConfig)
            }

            tbl1.ProductTypeDetails = tbl2

            table.insert(result, module.new(tbl1))
        else
            error("Expected each product to be a table")
        end
    end
    return result
end

function module.formatFromRest(arg1)
    assert(type(arg1) == "table", "Expected products response to be a table")
    local products = arg1.products
    if type(products) ~= "table" then
        return {}
    end
    local result = {}
    for _, product in ipairs(products) do
        if type(product) ~= "table" or type(product.periodType) ~= "string" or product.periodType == "" then
            continue
        end

        local featureConfig = product.productTypeDetails
            and product.productTypeDetails.robloxSubscriptionProductDetails
            and product.productTypeDetails.robloxSubscriptionProductDetails.featureConfig
        local tbl1 = {
            EligibleOffers = parseEligibleOffersFromRest(product.eligibleOffers),
            LocalizedPrice = parseLocalizedPriceFromRest(product.localizedPrice),
            LocalizedPriceDisplayString = if type(product.localizedPriceDisplayString) == "string" then product.localizedPriceDisplayString or nil else nil,
            PeriodType = tostring(product.periodType),
            ProductKey = parseProductKeyFromRest(product.productKey),
            ProductTypeDetails = {
                RobloxSubscriptionProductDetails = {
                    FeatureConfig = parseFeatureConfigFromRest(featureConfig)
                }
            }
        }
        table.insert(result, module.new(tbl1))
    end

    return result
end

function module.mock(tbl1)
    local tbl2 = {
        EligibleOffers = {{ Duration = 1, OfferType = "FreeTrial", PeriodType = "Month" }},
        LocalizedPrice = { CurrencyCode = "USD", Nanos = 990000000, Units = 12 },
        LocalizedPriceDisplayString = "$12.99",
        PeriodType = "Month",
        ProductKey = { Id = "8429606799668938154", Type = "Blackbird" },
        ProductTypeDetails = {
            RobloxSubscriptionProductDetails = {
                FeatureConfig = {
                    IsRobuxTransferEnabled = true,
                    IsTradingEnabled = true,
                    IsUgcPublishingEnabled = true,
                    VirtualTransactionDiscounts = {
                        { DiscountPercent = 1, PeriodIndex = 0, TierId = "percent_1" },
                        { DiscountPercent = 50, PeriodIndex = 2, TierId = "percent_50" }
                    },
                    PrivateServerDiscounts = {{
                        DiscountPercent = 100,
                        PeriodIndex = 0,
                        TierId = "free"
                    }}
                }
            }
        }
    }

    if type(tbl1) == "table" then
        for k, value in pairs(tbl1) do
            tbl2[k] = value
        end
    end
    return module.new(tbl2)
end

return module
