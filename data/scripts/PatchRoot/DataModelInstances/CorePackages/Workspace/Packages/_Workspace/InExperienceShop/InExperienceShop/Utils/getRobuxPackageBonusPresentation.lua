-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)
local _promoteBonusRobuxPackageToTopPicks = require(InExperienceShop.Api.promoteBonusRobuxPackageToTopPicks)
local BonusPromotionEligibility = require(InExperienceShop.Api.BonusPromotionEligibility)

local function getRobuxPackageBonusPresentation(arg1, bool1: boolean?, ineligible)
    local bonusItemDetails = arg1.bonusItemDetails
    if bonusItemDetails == nil then
        return { hasBonusItem = false, bonusItemThumbnail = nil }
    end

    if bool1 == true or ineligible == BonusPromotionEligibility.Ineligible then
        return { hasBonusItem = false, bonusItemThumbnail = nil }
    end

    local thumbnail = bonusItemDetails.thumbnail
    return if thumbnail == nil then { hasBonusItem = false, bonusItemThumbnail = nil } else {
        hasBonusItem = true,
        bonusItemThumbnail = thumbnail
    }
end

return getRobuxPackageBonusPresentation
