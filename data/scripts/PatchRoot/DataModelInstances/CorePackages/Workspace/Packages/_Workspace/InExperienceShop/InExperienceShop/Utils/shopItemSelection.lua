-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function findItemById(tbl1, id: string?, itemType)
    if id == nil or itemType == nil then
        return nil
    end
    for _, value in tbl1 do
        for _, item in value.items do
            if item.id == id and item.itemType == itemType then
                return item
            end
        end
    end
    return nil
end

local function findBonusItemById(tbl1, id: string?, itemType)
    if id == nil or itemType == nil then
        return nil
    end
    for _, value in tbl1 do
        local featuredRobuxPackage = value.featuredRobuxPackage
        if featuredRobuxPackage ~= nil then
            local bonusItemDetails = featuredRobuxPackage.bonusItemDetails
            if bonusItemDetails ~= nil and bonusItemDetails.id == id and bonusItemDetails.itemType == itemType then
                return bonusItemDetails
            end
        end
        local robuxPackages = value.robuxPackages
        if robuxPackages == nil then
            continue
        end

        for _, value2 in robuxPackages do
            local bonusItemDetails = value2.bonusItemDetails
            if bonusItemDetails ~= nil and bonusItemDetails.id == id and bonusItemDetails.itemType == itemType then
                return bonusItemDetails
            end
        end
    end

    return nil
end

return {
    findItemById = findItemById,
    findBonusItemById = findBonusItemById,
    resolveItemForSelection = function(tbl1, id: string?, itemType, bool1: boolean)
        local itemById = findItemById(tbl1, id, itemType)
        if itemById ~= nil then
            return itemById
        elseif bool1 then
            return (findBonusItemById(tbl1, id, itemType))
        end
        return nil
    end,
    isRobuxBonusOnlySelection = function(tbl1, id: string?, itemType, bool1: boolean): boolean
        return if bool1 and id ~= nil and itemType ~= nil then findItemById(tbl1, id, itemType) == nil and findBonusItemById(tbl1, id, itemType) ~= nil else false
    end
}
