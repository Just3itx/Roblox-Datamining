-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local UnifiedEventLogEnums = require(InExperienceShopParent.AvatarExperienceAnalytics).UnifiedEventLogEnums
local MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction
local MarketplaceUnifiedItemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType

local UnifiedLoggingSurface = require(InExperienceShopParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local module = {}

local tbl1 = {
    [UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_HOME] = true,
    [UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_DETAILS] = true,
    [UnifiedLoggingSurface.IN_EXPERIENCE_SHOP_SEARCH] = true
}

local tbl2 = {
    [MarketplaceUnifiedItemType.GAME_PASS] = true,
    [MarketplaceUnifiedItemType.DEVELOPER_PRODUCT] = true,
    [MarketplaceUnifiedItemType.ROBUX] = true,
    [MarketplaceUnifiedItemType.ROBUX_WITH_BONUS] = true
}

function module.hasItemId(arg1): boolean
    local itemId = arg1.itemId
    return not (itemId == nil) and itemId ~= ""
end

function module.hasValidItemType(arg1): boolean
    local itemType = arg1.itemType
    return not (itemType == nil) and tbl2[itemType] == true
end

function module.hasValidAction(arg1): boolean
    local action = arg1.action
    return not (action == nil) and action ~= MarketplaceUnifiedAction.UNDEFINED_ACTION
end

function module.hasValidSurface(arg1): boolean
    local surface = arg1.surface
    return not (surface == nil) and tbl1[surface] == true
end

function module.hasValidSizeAndPosition(arg1): boolean
    local action = arg1.action

    if action ~= MarketplaceUnifiedAction.ITEM_IMPRESSION
        and action ~= MarketplaceUnifiedAction.ITEM_SELECTED
        and action ~= MarketplaceUnifiedAction.ITEM_DESELECTED
        and action ~= MarketplaceUnifiedAction.PURCHASE_SUCCESS
    then
        return true
    end

    local screenSizeWidth = arg1.screenSizeWidth or 0
    local screenSizeHeight = arg1.screenSizeHeight or 0
    local elementSizeWidth = arg1.elementSizeWidth or 0
    local elementSizeHeight = arg1.elementSizeHeight or 0
    local gridPositionRow = arg1.gridPositionRow or 0
    local gridPositionColumn = arg1.gridPositionColumn or 0

    return screenSizeWidth > 0
        and screenSizeHeight > 0
        and elementSizeWidth > 0
        and elementSizeHeight > 0
        and gridPositionRow > 0
        and gridPositionColumn > 0
end

function module.hasUniverseId(arg1): boolean
    local universeId = arg1.universeId

    if typeof(universeId) == "number" then
        return universeId > 0
    elseif typeof(universeId) == "string" then
        return universeId ~= ""
    end

    return false
end

function module.filter(arg1)
    local var1 = module.hasItemId(arg1)
    local var2 = module.hasValidItemType(arg1)
    local var3 = module.hasValidAction(arg1)
    local var4 = module.hasValidSurface(arg1)
    local var5 = module.hasValidSizeAndPosition(arg1)
    local var6 = module.hasUniverseId(arg1)

    local var7 = var1 and var2 and var3 and var4 and var5 and var6

    if not var7 then
        local str1 = ""
        if not var1 then
            str1 ..= "hasItemId "
        end
        if not var2 then
            str1 ..= "hasValidItemType "
        end
        if not var3 then
            str1 ..= "hasValidAction "
        end
        if not var4 then
            str1 ..= "hasValidSurface "
        end
        if not var5 then
            str1 ..= "hasValidSizeAndPosition "
        end
        if not var6 then
            str1 ..= "hasUniverseId "
        end

        warn("Failed to send in-experience shop unified event. Failing Check(s): " .. str1)
    end

    return var7
end

return module
