-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local _Types = require(InExperienceShop.Types)

local function mapShopItemTypeToUnifiedItemType(arg1)
    local marketplaceUnifiedItemType = require(InExperienceShopParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedItemType

    if arg1 == "GamePass" then
        return marketplaceUnifiedItemType.GAME_PASS
    elseif arg1 == "Product" then
        return marketplaceUnifiedItemType.DEVELOPER_PRODUCT
    elseif arg1 == "Robux" then
        return marketplaceUnifiedItemType.ROBUX
    end

    return nil
end

return mapShopItemTypeToUnifiedItemType
