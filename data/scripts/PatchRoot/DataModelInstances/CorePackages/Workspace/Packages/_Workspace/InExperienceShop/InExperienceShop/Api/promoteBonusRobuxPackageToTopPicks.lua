-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local SharedFlags = require(InExperienceShopParent.SharedFlags)
local _Types = require(InExperienceShop.Types)
local findTopPicksSectionIndex = require(InExperienceShop.Utils.findTopPicksSectionIndex)
local FFlagPromoteRobuxInTopPicks = require(InExperienceShop.Flags.FFlagPromoteRobuxInTopPicks)
local FFlagHideBonusInShopWhenNotClaimable = require(InExperienceShop.Flags.FFlagHideBonusInShopWhenNotClaimable)
local FFlagEnableRobuxInExperienceShop = SharedFlags.FFlagEnableRobuxInExperienceShop
local FFlagEnableBonusJwtInShop = SharedFlags.FFlagEnableBonusJwtInShop
local BonusPromotionEligibility = require(InExperienceShop.Api.BonusPromotionEligibility)

local function findFirstBonusRobuxPackageWithPaymentSession(tbl1)
    for _, value in tbl1 do
        local robuxPackages = value.robuxPackages
        if robuxPackages == nil then
            continue
        end

        for _, value2 in robuxPackages do
            if value2.bonusItem ~= nil then
                return value2, value.paymentSessionId, value.bonusJwt
            end
        end
    end
    return nil, nil, nil
end

local function withoutFeaturedPromotion(tbl1)
    local topPicksSectionIndex = findTopPicksSectionIndex(tbl1)
    if topPicksSectionIndex == nil then
        return tbl1
    end

    local var1 = tbl1[topPicksSectionIndex]
    if var1.featuredRobuxPackage == nil then
        return tbl1
    end

    local var2 = table.clone(tbl1)
    var2[topPicksSectionIndex] = {
        id = var1.id,
        name = var1.name,
        items = var1.items,
        categoryType = var1.categoryType,
        stableCategoryId = var1.stableCategoryId,
        categoryGroup = var1.categoryGroup,
        robuxPackages = var1.robuxPackages,
        featuredRobuxPackage = nil
    }

    return var2
end

local function getBonusGamePassId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bonusItem = arg1.bonusItem
    if bonusItem == nil or bonusItem.type ~= "GamePass" then
        return nil
    end
    return tostring(bonusItem.id)
end

local function canPromoteBonusPackage(firstBonusRobuxPackageWithPaymentSession, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local bonusGamePassId = getBonusGamePassId(firstBonusRobuxPackageWithPaymentSession)
    return not (bonusGamePassId == nil)
        and not (firstBonusRobuxPackageWithPaymentSession.bonusItemDetails == nil)
        and tbl1[bonusGamePassId] == BonusPromotionEligibility.Eligible
end

return {
    findFirstBonusRobuxPackage = function(tbl1)
        local var1, _, _ = findFirstBonusRobuxPackageWithPaymentSession(tbl1)
        return var1
    end,
    getBonusGamePassId = getBonusGamePassId,
    withoutFeaturedPromotion = withoutFeaturedPromotion,
    promoteBonusRobuxPackageToTopPicks = function(tbl1, tbl2)
        if not (FFlagEnableRobuxInExperienceShop and FFlagPromoteRobuxInTopPicks) then
            return (withoutFeaturedPromotion(tbl1))
        end

        local var1, paymentSessionId, bonusJwt = findFirstBonusRobuxPackageWithPaymentSession(tbl1)
        if var1 == nil then
            return (withoutFeaturedPromotion(tbl1))
        end

        local var4

        if paymentSessionId == nil or paymentSessionId == "" then
            var4 = FFlagEnableBonusJwtInShop

            if var4 then
                if bonusJwt == nil then
                    var4 = false
                else
                    var4 = bonusJwt ~= ""
                end
            end
        else
            var4 = true
        end

        if FFlagHideBonusInShopWhenNotClaimable and not var4 then
            return (withoutFeaturedPromotion(tbl1))
        end

        local topPicksSectionIndex = findTopPicksSectionIndex(tbl1)
        if topPicksSectionIndex == nil then
            return (withoutFeaturedPromotion(tbl1))
        end

        if not canPromoteBonusPackage(var1, tbl2) then
            return (withoutFeaturedPromotion(tbl1))
        end

        local var5 = tbl1[topPicksSectionIndex]
        local featuredRobuxPackage = var5.featuredRobuxPackage
        if featuredRobuxPackage ~= nil and featuredRobuxPackage.id == var1.id then
            local bool1 = var5.paymentSessionId == paymentSessionId
            local bool2 = not FFlagEnableBonusJwtInShop or var5.bonusJwt == bonusJwt
            if bool1 and bool2 then
                return tbl1
            end
        end

        local var6 = table.clone(tbl1)
        local tbl3 = {
            id = var5.id,
            name = var5.name,
            items = var5.items,
            categoryType = var5.categoryType,
            stableCategoryId = var5.stableCategoryId,
            categoryGroup = var5.categoryGroup,
            paymentSessionId = var5.paymentSessionId,
            bonusJwt = var5.bonusJwt,
            robuxPackages = var5.robuxPackages,
            featuredRobuxPackage = var1
        }
        if paymentSessionId ~= nil then
            tbl3.paymentSessionId = paymentSessionId
        end
        if FFlagEnableBonusJwtInShop and bonusJwt ~= nil then
            tbl3.bonusJwt = bonusJwt
        end
        var6[topPicksSectionIndex] = tbl3
        return var6
    end
}
