-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local t = require(DataHydrationParent.t)

local _store = require(script.Parent.Types.store)

local var1 = t.interface({
    userEligible = t.boolean,
    universeEligible = t.boolean,
    freeCreditsRemaining = t.integer,
    cardType = t.union(t.literal("promote_free"), t.literal("promote_paid"), t.literal("none")),
    ineligibleReasons = t.array(t.string),
    offer = t.optional(t.interface({ displayAmountRobux = t.integer, durationDays = t.integer }))
})

local function decodeAdCampaignEligibilityResult(nil1: nil)
    local var2, var3 = var1(nil1)
    if not var2 then
        return nil, "Invalid ad campaign eligibility response: " .. tostring(var3)
    end

    if nil1.freeCreditsRemaining < 0 then
        return nil, "Invalid ad campaign eligibility response: freeCreditsRemaining must be non-negative"
    end

    if nil1.offer ~= nil then
        if nil1.offer.displayAmountRobux < 0 then
            return nil, "Invalid ad campaign eligibility response: offer.displayAmountRobux must be non-negative"
        end
        if nil1.offer.durationDays <= 0 then
            return nil, "Invalid ad campaign eligibility response: offer.durationDays must be positive"
        end
    end

    return nil1, nil
end

return decodeAdCampaignEligibilityResult
