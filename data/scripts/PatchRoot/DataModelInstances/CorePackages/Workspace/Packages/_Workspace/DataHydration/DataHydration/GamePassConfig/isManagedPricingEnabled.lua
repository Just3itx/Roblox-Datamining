-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _GamePassConfigTypes = require(script.Parent.GamePassConfigTypes)

local function isManagedPricingEnabled(arg1)
    if arg1.isManagedPricingEnabled ~= nil then
        return arg1.isManagedPricingEnabled
    end

    local enabledFeatures = if arg1.priceInformation == nil then nil else arg1.priceInformation.enabledFeatures

    if enabledFeatures == nil then
        return nil
    end

    return table.find(enabledFeatures, "RegionalPricing") ~= nil
end

return isManagedPricingEnabled
