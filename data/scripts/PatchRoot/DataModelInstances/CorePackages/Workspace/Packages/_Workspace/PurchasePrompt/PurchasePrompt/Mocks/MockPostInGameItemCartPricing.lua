-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Promise = require(scriptParentParent.Promise)
local _types = require(scriptParentParent.types)

local _IAPExperience = require(scriptParentParentParent.IAPExperience)
local _PurchasePromptLite = require(scriptParentParentParent.PurchasePromptLite)

local function isOfferDeselected(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1 == nil then
        return false
    end
    for _, value in tbl1 do
        if value == "be86b44b-462a-41a2-a059-01411756f07d" then
            return true
        end
    end
    return false
end

local function buildMockResponse(tbl1)
    local selected = not isOfferDeselected(tbl1)

    local tbl2 = {
        productIdentifier = { namespace = "GamePass", targetIdentifier = "12345" },
        priceInRobux = if selected then 80 else 100,
        regularPriceInRobux = 100
    }

    if selected then
        tbl2.discountInformation = {
            originalPrice = 100,
            totalDiscountPercentage = 20,
            totalDiscountAmount = 20,
            discounts = {{
                robuxDiscountAmount = 20,
                robuxDiscountPercentage = 20,
                discountCampaign = "sample-campaign",
                localizedDiscountAttribution = "XX% offer",
                discountType = "MARKETPLACE_OFFER",
                discountId = "be86b44b-462a-41a2-a059-01411756f07d"
            }}
        }
    end

    return {
        items = { tbl2 },
        savingsSummary = if selected then "Saving R$ XX" else nil,
        availableOffers = {{
            offerId = "be86b44b-462a-41a2-a059-01411756f07d",
            localizedDescription = "XX% off one item up to R$ XX",
            expirationTimeUtc = DateTime.fromUnixTimestamp(DateTime.now().UnixTimestamp + 259200):ToIsoDate(),
            selected = selected
        }}
    }
end

local function MockPostInGameItemCartPricing(_, _: number, _: string, tbl1, tbl2, _, _)
    if tbl1 == nil or #tbl1 == 0 then
        return Promise.resolve(nil)
    end

    return Promise.resolve((buildMockResponse(tbl2)))
end

return MockPostInGameItemCartPricing
