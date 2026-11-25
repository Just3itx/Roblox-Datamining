-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local getPlayerPrice = require(PurchasePrompt.Utils.getPlayerPrice)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(PurchasePromptParent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
local selectCartPricingOverride = require(script.Parent.selectCartPricingOverride)

local function selectProductPrice(arg1)
    local collectibleItemInstanceId = arg1.promptRequest.collectibleItemInstanceId
    local expectedPrice = arg1.promptRequest.expectedPrice

    local bool1 = arg1.accountInfo.membershipType == 4

    local playerPrice = getPlayerPrice(arg1.productInfo, bool1)

    if (not collectibleItemInstanceId or collectibleItemInstanceId == "")
        and (not FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
            or not arg1.productPayload
            or arg1.productPayload.timedOptionDays == nil)
    then
        expectedPrice = playerPrice
    end

    local var1 = selectCartPricingOverride(arg1)
    if var1 ~= nil then
        expectedPrice = var1.priceInRobux
    end
    return expectedPrice
end
return selectProductPrice
