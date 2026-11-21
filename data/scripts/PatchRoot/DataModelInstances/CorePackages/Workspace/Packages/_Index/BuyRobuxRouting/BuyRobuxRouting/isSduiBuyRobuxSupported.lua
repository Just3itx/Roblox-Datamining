-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuyRobuxRouting = script:FindFirstAncestor("BuyRobuxRouting")
local BuyRobuxRoutingParent = BuyRobuxRouting.Parent

local SharedFlags = require(BuyRobuxRoutingParent.SharedFlags)

local EngineFeatures = require(BuyRobuxRouting.EngineFeatures)

local function isSduiBuyRobuxSupported()
    return SharedFlags.FFlagSduiBuyRobuxHydration
        and SharedFlags.FFlagInitializeSduiForApp
        and EngineFeatures.isRobloxSubscriptionReadSupported()
        and EngineFeatures.isFirstTimePurchaseConsentStorageSupported()
end

return isSduiBuyRobuxSupported
