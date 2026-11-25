-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local str1 = game:DefineFastString("PriceChangedSubscriptionMembershipCheckProductTypes", "")

local function shouldCheckSubscriptionMembershipForProductType(str2: string?)
    if str2 == nil or str1 == "" then
        return false
    end

    for value in string.gmatch(str1, "[^,]+") do
        local var1 = value:gsub("^%s+", ""):gsub("%s+$", "")
        if var1 ~= "" and var1 == str2 then
            return true
        end
    end

    return false
end

return shouldCheckSubscriptionMembershipForProductType
