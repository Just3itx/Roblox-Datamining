-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _AXPagesTypes = require(script.Parent.AXPagesTypes)
local AXPagesImpl = require(script.Parent.AXPagesImpl)

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local getCatalogV2SearchItemDetails = require(script.Parent.Parent.getCatalogV2SearchItemDetails).getCatalogV2SearchItemDetails

local _CatalogV2SearchItemDetails = require(AvatarExperienceCatalog.Models.CatalogV2SearchItemDetails)

local function fetchNextPage(func1: (...any) -> (...any), arg1, cursor: string)
    if cursor and cursor ~= "" then
        arg1.cursor = cursor
    end

    local var1, _ = getCatalogV2SearchItemDetails(func1, arg1)
    local var2 = var1:expect()

    return {
        data = not var2 and {} or var2.data or {},
        nextPageCursor = var2 and var2.nextPageCursor or nil
    }
end

local module = {}

function module.new(func1: (...any) -> (...any), arg1, tbl1, str1: string?)
    return AXPagesImpl.new(tbl1, str1, function(cursor: string) -- name: fetchNextPageWithContext
        return (fetchNextPage(func1, arg1, cursor))
    end)
end
return module
