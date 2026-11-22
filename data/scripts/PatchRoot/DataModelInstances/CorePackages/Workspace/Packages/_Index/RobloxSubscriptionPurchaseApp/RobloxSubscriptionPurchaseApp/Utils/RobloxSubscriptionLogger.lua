-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent
local Logger = require(RobloxSubscriptionPurchaseAppParent.Loggers).Logger
local HttpService = game:GetService("HttpService")

return {
    debug = function(input)
        Logger:debug(HttpService:JSONEncode(input))
    end,
    info = function(input)
        Logger:info(HttpService:JSONEncode(input))
    end,
    warn = function(input)
        Logger:warn(HttpService:JSONEncode(input))
    end,
    error = function(input)
        Logger:error(HttpService:JSONEncode(input))
    end
}
