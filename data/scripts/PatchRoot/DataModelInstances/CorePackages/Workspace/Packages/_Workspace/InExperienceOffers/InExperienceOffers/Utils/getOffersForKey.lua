-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local _Types = require(InExperienceOffers.Types)

local function getOffersForKey(arg1, str1: string, offerStatus)
    if arg1 == nil then
        return nil
    end
    local var1 = arg1[str1]
    if var1 == nil or offerStatus == nil then
        return var1
    end
    local tbl1 = {}
    for _, value in var1 do
        if value.offerStatus == offerStatus then
            table.insert(tbl1, value)
        end
    end
    return if #tbl1 > 0 then tbl1 else nil
end

return getOffersForKey
