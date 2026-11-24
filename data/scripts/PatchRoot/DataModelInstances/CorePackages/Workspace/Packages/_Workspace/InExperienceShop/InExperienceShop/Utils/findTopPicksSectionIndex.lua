-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local FFlagIdentifyTopPicksByCategoryType = require(InExperienceShop.Flags.FFlagIdentifyTopPicksByCategoryType)

local function findTopPicksSectionIndex(tbl1)
    for value, value2 in tbl1 do
        if FFlagIdentifyTopPicksByCategoryType then
            if value2.categoryType == Constants.TOP_PICKS_CATEGORY_TYPE then
                return value
            end

            if value2.categoryType == nil and string.lower(value2.name) == "top picks" then
                return value
            end
        elseif string.lower(value2.name) == "top picks" then
            return value
        end
    end
    return nil
end

return findTopPicksSectionIndex
