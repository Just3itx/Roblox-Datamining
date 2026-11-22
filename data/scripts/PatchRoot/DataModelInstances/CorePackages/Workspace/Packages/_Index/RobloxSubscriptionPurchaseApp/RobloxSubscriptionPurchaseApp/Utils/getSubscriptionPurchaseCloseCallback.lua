-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local engineFeature = game:GetEngineFeature("ReadHasRobloxSubscriptionLua")

local engineFeature2 = game:GetEngineFeature("EnablePromptSignalRobloxSubscriptionPurchaseFinished")

local function getSubscriptionPurchaseCloseCallback(): (() -> ())?
    local var1

    if engineFeature then
        local success, result = pcall(function(): boolean
            return Players.LocalPlayer.HasRobloxSubscription
        end)

        var1 = success and result == true
    else
        var1 = false
    end

    return if var1 or not engineFeature2 then nil else function()
        MarketplaceService:signalPromptRobloxSubscriptionPurchaseFinished(" ", true)
    end
end
return getSubscriptionPurchaseCloseCallback
