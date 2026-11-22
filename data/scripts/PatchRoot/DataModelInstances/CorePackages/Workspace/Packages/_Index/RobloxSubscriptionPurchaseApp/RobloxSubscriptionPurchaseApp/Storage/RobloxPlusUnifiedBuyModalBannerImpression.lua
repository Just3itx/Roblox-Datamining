-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local module = {}

function module.canUseAppStorage(): boolean
    return game:GetEngineFeature("RobloxPlusImpressionStorageKey")
end

function module.getImpressionCount(): number
    if not module.canUseAppStorage() then
        return math.huge
    end
    local success, result = pcall(function(): string
        return AppStorageService:GetItem("RobloxPlusUpsellBannerUnifiedBuyModalImpressionCount")
    end)
    return if success and typeof(result) == "string" and result ~= "" then tonumber(result) or 0 else 0
end

function module.incrementImpressionCount()
    if not module.canUseAppStorage() then
        return
    end
    pcall(function()
        local var1 = module.getImpressionCount() + 1
        AppStorageService:SetItem("RobloxPlusUpsellBannerUnifiedBuyModalImpressionCount", tostring(var1))
        AppStorageService:Flush()
    end)
end

return module
