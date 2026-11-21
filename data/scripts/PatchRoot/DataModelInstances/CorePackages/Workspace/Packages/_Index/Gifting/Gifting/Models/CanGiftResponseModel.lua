-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local GiftEligibility = require(Gifting.Enums.GiftEligibility)
local RequiredAction = require(Gifting.Enums.RequiredAction)
local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local _Types = require(Gifting.Types)

local var1 = t.interface({ isGiftable = t.boolean })

local function formatItemGiftability(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, `item giftability: {var3}`
    end

    local var4, var5 = GiftModelUtils.formatItem(arg1.item)
    if var4 == nil then
        return nil, var5
    end

    return {
        item = var4,
        isGiftable = arg1.isGiftable
    }
end

local module = {}

function module.format(arg1)
    local eligibility = GiftEligibility.fromValue(arg1.eligibility)
    if eligibility == nil then
        return nil, GiftModelUtils.invalidField("eligibility", arg1.eligibility)
    end

    local requiredActions = RequiredAction.fromValues(arg1.requiredActions or {})
    if requiredActions == nil then
        return nil, GiftModelUtils.invalidField("requiredActions", arg1.requiredActions)
    end

    local items, var3 = GiftModelUtils.formatList("items", arg1.items or {}, formatItemGiftability)
    if items == nil then
        return nil, var3
    end

    return { eligibility = eligibility, requiredActions = requiredActions, items = items }
end

return module
