-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local _Types = require(Gifting.Types)

local var1 = t.interface({ priceInRobux = t.number })

local var2 = t.interface({ robuxDiscountAmount = t.number, robuxDiscountPercentage = t.number })

local var3 = t.interface({ originalPrice = t.number, totalDiscountPercentage = t.number, totalDiscountAmount = t.number })

local var4 = t.interface({ userId = t.number })

local var5 = t.interface({ remaining = t.number, granted = t.number, startTimeMs = t.number, endTimeMs = t.number })

local var6 = t.interface({ purchaseGiftRequest = t.any, totalPriceInRobux = t.number, senderRobuxBalance = t.number })

local function formatItemDetail(arg1)
    local var7, var8 = var1(arg1)
    if not var7 then
        return nil, `item: {var8}`
    end

    local var9, var10 = GiftModelUtils.formatItem(arg1.item)
    if var9 == nil then
        return nil, var10
    end

    return {
        item = var9,
        name = arg1.name or "",
        thumbnailUrl = arg1.thumbnailUrl or "",
        priceInRobux = arg1.priceInRobux
    }
end

local function formatDiscountDetail(arg1)
    local var7, var8 = var2(arg1)
    if not var7 then
        return nil, `discount: {var8}`
    end

    return {
        robuxDiscountAmount = arg1.robuxDiscountAmount,
        robuxDiscountPercentage = arg1.robuxDiscountPercentage,
        discountCampaign = arg1.discountCampaign or "",
        localizedDiscountAttribution = arg1.localizedDiscountAttribution or ""
    }
end

local function formatDiscountInformation(discountInformation)
    local var7, var8 = var3(discountInformation)
    if not var7 then
        return nil, `discountInformation: {var8}`
    end

    local discounts, var10 = GiftModelUtils.formatList("discounts", discountInformation.discounts or {}, formatDiscountDetail)
    if discounts == nil then
        return nil, var10
    end

    return {
        originalPrice = discountInformation.originalPrice,
        totalDiscountPercentage = discountInformation.totalDiscountPercentage,
        totalDiscountAmount = discountInformation.totalDiscountAmount,
        discounts = discounts
    }
end

local function formatRecipientInfo(arg1) -- Luacid: unused: defined but never referenced
    local var7, var8 = var4(arg1)
    if not var7 then
        return nil, `recipient: {var8}`
    end

    return {
        userId = arg1.userId,
        displayName = arg1.displayName or "",
        thumbnailUrl = arg1.thumbnailUrl or ""
    }
end

local function formatFreeAllowance(arg1) -- Luacid: unused: defined but never referenced
    local var7, var8 = var5(arg1)
    if not var7 then
        return nil, `freeAllowance: {var8}`
    end

    return {
        remaining = arg1.remaining,
        granted = arg1.granted,
        startTimeMs = arg1.startTimeMs,
        endTimeMs = arg1.endTimeMs
    }
end

local module = {}

function module.format(arg1)
    local var7, var8 = var6(arg1)
    if not var7 then
        return nil, var8
    end

    local items, var10 = GiftModelUtils.formatList("items", arg1.items, formatItemDetail)
    if items == nil then
        return nil, var10
    end

    local recipient = arg1.recipient
    local var11, var12 = var4(recipient)
    local var13, tbl1

    if not var11 then
        var13 = `recipient: {var12}`
        tbl1 = nil
    else
        tbl1 = {
            userId = recipient.userId,
            displayName = recipient.displayName or "",
            thumbnailUrl = recipient.thumbnailUrl or ""
        }
        var13 = nil
    end

    if tbl1 == nil then
        return nil, var13
    end

    local userRelationshipDetail, var15 = GiftModelUtils.formatUserRelationshipDetail(arg1.userRelationshipDetail)
    if userRelationshipDetail == nil then
        return nil, var15
    end

    local var16

    if arg1.discountInformation == nil then
        var16 = nil
    else
        local var17
        var16, var17 = formatDiscountInformation(arg1.discountInformation)
        if var16 == nil then
            return nil, var17
        end
    end

    local tbl2

    if arg1.freeAllowance == nil then
        tbl2 = nil
    else
        local freeAllowance = arg1.freeAllowance
        local var17, var18 = var5(freeAllowance)
        local var19

        if not var17 then
            var19 = `freeAllowance: {var18}`
            tbl2 = nil
        else
            tbl2 = {
                remaining = freeAllowance.remaining,
                granted = freeAllowance.granted,
                startTimeMs = freeAllowance.startTimeMs,
                endTimeMs = freeAllowance.endTimeMs
            }
            var19 = nil
        end

        if tbl2 == nil then
            return nil, var19
        end
    end

    return {
        purchaseGiftRequest = arg1.purchaseGiftRequest,
        items = items,
        totalPriceInRobux = arg1.totalPriceInRobux,
        discountInformation = var16,
        senderRobuxBalance = arg1.senderRobuxBalance,
        recipient = tbl1,
        userRelationshipDetail = userRelationshipDetail,
        freeAllowance = tbl2
    }
end

return module
