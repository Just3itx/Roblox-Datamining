-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)

local function sortCurrentlyWearingItems(arg1, arg2): boolean
    local tbl1 = {
        isOffSale = arg1.isOffSale or false,
        price = arg1.price or arg1.lowestResalePrice or 0,
        favoriteCount = arg1.favoriteCount or 0
    }
    local tbl2 = {
        isOffSale = arg2.isOffSale or false,
        price = arg2.price or arg2.lowestResalePrice or 0,
        favoriteCount = arg2.favoriteCount or 0
    }

    if tbl1.isOffSale ~= tbl2.isOffSale then
        return not tbl1.isOffSale
    end

    if tbl1.price ~= tbl2.price then
        return not (tbl1.price == 0) and (tbl2.price == 0 or tbl1.price > tbl2.price)
    end

    return (tonumber(arg1.id) or 0) < (tonumber(arg2.id) or 0)
end

return sortCurrentlyWearingItems
