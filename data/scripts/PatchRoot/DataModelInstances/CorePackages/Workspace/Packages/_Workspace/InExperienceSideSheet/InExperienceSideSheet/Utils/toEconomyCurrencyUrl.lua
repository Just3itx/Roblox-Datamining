-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toEconomyCurrencyUrl(str1: string)
    local var1 = string.gsub(str1:lower(), "/m.", "/www.")
    local var2 = string.gsub(var1, "http:", "https:")
    return string.gsub(var2, "https://www.", "https://economy.") .. "v1/user/currency"
end

return toEconomyCurrencyUrl
