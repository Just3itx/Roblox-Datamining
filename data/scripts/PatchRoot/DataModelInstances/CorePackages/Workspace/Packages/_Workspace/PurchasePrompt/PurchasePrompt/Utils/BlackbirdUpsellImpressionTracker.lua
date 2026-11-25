-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("BlackbirdUpsellBannerMaxSessionImpressions", 50)

local MemStorageService = game:GetService("MemStorageService")

local module = {}

function module.getImpressionCount(): number
    local success, result = pcall(function(): string
        return MemStorageService:GetItem("BlackbirdUpsellBannerImpressionCount")
    end)
    return if success and result and result ~= "" then tonumber(result) or 0 else 0
end

function module.incrementImpressionCount()
    local impressionCount = module.getImpressionCount()
    pcall(function()
        MemStorageService:SetItem("BlackbirdUpsellBannerImpressionCount", tostring(impressionCount + 1))
    end)
end

function module.hasReachedMaxImpressions(): boolean
    local num2 = num1
    return not (num2 == 0) and num2 <= module.getImpressionCount()
end

return module
