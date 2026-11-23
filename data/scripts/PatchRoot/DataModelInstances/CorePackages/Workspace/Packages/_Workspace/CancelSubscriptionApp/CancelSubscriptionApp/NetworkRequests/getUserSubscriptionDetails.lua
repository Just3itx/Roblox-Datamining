-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local Promise = require(CancelSubscriptionAppParent.Promise)
local MarketplaceService = game:GetService("MarketplaceService")

local function getUserSubscriptionDetails(_, subscriptionId: string)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return MarketplaceService:GetUserSubscriptionDetailsInternalAsync(subscriptionId)
        end)
        if success then
            callback(result)
            return
        end
        callback2(result)
    end)
end

return getUserSubscriptionDetails
