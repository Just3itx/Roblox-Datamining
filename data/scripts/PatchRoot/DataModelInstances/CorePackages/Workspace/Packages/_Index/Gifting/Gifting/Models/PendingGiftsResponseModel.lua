-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local _Types = require(Gifting.Types)

local var1 = t.interface({ giftId = GiftModelUtils.nonEmptyString })

local function formatPendingGiftItem(arg1)
    local var2, var3 = t.table(arg1)
    if not var2 then
        return nil, `item: {var3}`
    end

    local var4, var5 = GiftModelUtils.formatItem(arg1.item)
    if var4 == nil then
        return nil, var5
    end

    return {
        item = var4,
        thumbnailUrl = arg1.thumbnailUrl or ""
    }
end

local function formatPendingGift(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, `gift: {var3}`
    end

    local sender, var5 = GiftModelUtils.formatGiftSenderInfo(arg1.sender)
    if sender == nil then
        return nil, var5
    end

    local items, var7 = GiftModelUtils.formatList("items", arg1.items, formatPendingGiftItem)
    if items == nil then
        return nil, var7
    end

    return {
        giftId = arg1.giftId,
        sender = sender,
        items = items
    }
end

local module = {}

function module.format(arg1)
    local gifts, var3 = GiftModelUtils.formatList("gifts", arg1.gifts or {}, formatPendingGift)
    if gifts == nil then
        return nil, var3
    end

    return {
        gifts = gifts,
        nextCursor = arg1.nextCursor
    }
end

return module
