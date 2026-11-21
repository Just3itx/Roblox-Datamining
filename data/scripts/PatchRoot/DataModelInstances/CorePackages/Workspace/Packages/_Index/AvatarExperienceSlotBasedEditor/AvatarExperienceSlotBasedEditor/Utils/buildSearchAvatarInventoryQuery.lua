-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")

local InventorySearchConstants = require(AvatarExperienceSlotBasedEditor.InventorySearchConstants)
local _Types = require(AvatarExperienceSlotBasedEditor.Types)
local InventorySearchSortOption = require(AvatarExperienceSlotBasedEditor.Enums.InventorySearchSortOption)

local function isSortOption(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in InventorySearchSortOption do
        if value == str1 then
            return true
        end
    end
    return false
end

local function isPositiveInteger(pageLimit): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(pageLimit) == "number" and pageLimit >= 1 and pageLimit % 1 == 0
end

local function buildSearchAvatarInventoryQuery(arg1)
    if type(arg1.query) ~= "string" then
        return nil
    end
    local query = string.match(arg1.query, "^%s*(.-)%s*$")
    if query == "" then
        return nil
    end

    if not utf8.len(query) then
        return nil
    end

    local sortOption = arg1.sortOption or InventorySearchSortOption.Relevance

    if not isSortOption(sortOption) then
        return nil
    end

    local tbl1 = { query = query, sortOption = sortOption }

    local itemCategories = arg1.itemCategories
    if itemCategories ~= nil then
        if #itemCategories == 0 then
            return nil
        end
        for value, value2 in itemCategories do
            local var3 = InventorySearchConstants.SearchableSubtypesByItemType[value2.itemType]
            if not (var3 and var3[value2.itemSubType]) then
                return nil
            end
            local var4 = value - 1
            tbl1[`itemCategories[{var4}].itemType`] = value2.itemType
            tbl1[`itemCategories[{var4}].itemSubType`] = value2.itemSubType
        end
    end

    if arg1.pageLimit ~= nil then
        if not isPositiveInteger(arg1.pageLimit) or arg1.pageLimit > InventorySearchConstants.MaxPageLimit then
            return nil
        end
        tbl1.pageLimit = arg1.pageLimit
    end

    if arg1.pageToken ~= nil and arg1.pageToken ~= "" then
        tbl1.pageToken = arg1.pageToken
    end

    local searchAvatarInventoryQuery = ({})
    for value, value2 in tbl1 do
        searchAvatarInventoryQuery[value] = HttpService:UrlEncode(tostring(value2))
    end
    return searchAvatarInventoryQuery
end

return buildSearchAvatarInventoryQuery
