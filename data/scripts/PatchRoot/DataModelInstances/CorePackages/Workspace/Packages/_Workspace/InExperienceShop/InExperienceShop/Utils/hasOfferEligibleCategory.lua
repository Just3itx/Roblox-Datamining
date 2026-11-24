-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)

local function hasOfferEligibleCategory(tbl1)
    for _, value in tbl1 do
        if value.id ~= Constants.HOME_CATEGORY_ID and value.name ~= Constants.ROBUX_CATEGORY_NAME then
            return true
        end
    end
    return false
end

return hasOfferEligibleCategory
