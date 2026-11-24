-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local UnifiedLoggingSurface = require(InExperienceShopParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local Constants = require(script.Parent.Constants)

local function getShopUnifiedLoggingSurface(str1: string?)
    if str1 == Constants.ShopPageType.Home then
        return UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_HOME
    end

    if str1 == Constants.ShopPageType.Search then
        return UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_SEARCH
    end

    return UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_DETAILS
end

return getShopUnifiedLoggingSurface
