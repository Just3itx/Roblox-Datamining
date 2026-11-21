-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local flaggedMutedError = require(DiscoveryAnalyticsParent.Loggers).flaggedMutedError

local var1 = t.strictInterface({
    universeId = t.string,
    upsellName = t.string,
    playabilityStatus = t.optional(t.string),
    pageName = t.optional(t.string)
})

return function(arg1, arg2)
    local var2, var3 = var1(arg2)
    if not var2 then
        flaggedMutedError("UnlockPlayIntentEventInterface", var3)
    end

    arg1:sendEventDeferred("PlayButton", "unlockPlayIntent", arg2)
end
