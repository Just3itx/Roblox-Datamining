-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local getOffersForKey = require(InExperienceOffers.Utils.getOffersForKey)

local _Types = require(InExperienceOffers.Types)

local function hasOfferForAnyKey(arg1, tbl1)
    for _, value in tbl1 do
        if getOffersForKey(arg1, value) ~= nil then
            return true
        end
    end
    return false
end

return hasOfferForAnyKey
