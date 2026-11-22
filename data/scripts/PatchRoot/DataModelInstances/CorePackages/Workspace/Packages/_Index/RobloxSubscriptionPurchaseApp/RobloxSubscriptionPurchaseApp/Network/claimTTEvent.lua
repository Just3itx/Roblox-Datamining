-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)

local function claimTTEvent()
    return Promise.resolve()
end

return claimTTEvent
