-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    title = "Feature.InExperienceShop.GenericTransactionErrorTitle",
    body = "Feature.InExperienceShop.GenericTransactionErrorBody"
}

local tbl2 = {
    ActiveFreeTrialExists = {
        title = "Feature.InExperienceShop.Description.ActiveFreeTrialExistsTitle",
        body = "Feature.InExperienceShop.Description.ActiveFreeTrialExistsBody"
    },
    GamePassAlreadyOwned = {
        title = "Feature.InExperienceShop.Description.GamePassAlreadyOwnedTitle",
        body = "Feature.InExperienceShop.Description.GamePassAlreadyOwnedBody"
    },
    FreeTrialAlreadyRedeemed = {
        title = "Feature.InExperienceShop.Description.FreeTrialAlreadyRedeemedTitle",
        body = "Feature.InExperienceShop.Description.FreeTrialAlreadyRedeemedBody"
    },
    GamePassTrialNotEnabled = {
        title = "Feature.InExperienceShop.Description.GamePassTrialNotEnabledTitle",
        body = "Feature.InExperienceShop.Description.GamePassTrialNotEnabledBody"
    },
    GamePassNotPurchasable = {
        title = "Feature.InExperienceShop.Description.GamePassNotPurchasableTitle",
        body = "Feature.InExperienceShop.Description.GamePassNotPurchasableBody"
    },
    GamePassNotInUniverse = {
        title = "Feature.InExperienceShop.Description.GamePassNotInUniverseTitle",
        body = "Feature.InExperienceShop.Description.GamePassNotInUniverseBody"
    }
}

local function getTrialRedemptionErrorKeys(str1: string?)
    return if str1 == nil then tbl1 else tbl2[str1] or tbl1
end

return getTrialRedemptionErrorKeys
