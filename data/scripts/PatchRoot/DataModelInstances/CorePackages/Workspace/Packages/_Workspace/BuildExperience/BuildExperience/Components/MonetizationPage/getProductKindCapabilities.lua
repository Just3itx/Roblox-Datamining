-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _MonetizationPageView = require(script.Parent.MonetizationPageView)

local tbl1 = {
    GamePass = {
        priceRequiredForSale = true,
        regionalPricing = true,
        editableName = true,
        editablePrice = true
    },
    Subscription = {
        priceRequiredForSale = false,
        regionalPricing = false,
        editableName = false,
        editablePrice = false
    }
}

local function getProductKindCapabilities(arg1)
    return if arg1 == nil then nil else tbl1[arg1]
end

return getProductKindCapabilities
