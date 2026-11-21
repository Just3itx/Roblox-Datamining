-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)

game:DefineFastInt("PlusReferralFlyoutBannerMaxImpressions", 10)

local function getImpressionCount(key: string): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(key)
    end)
    return if success and typeof(result) == "string" and result ~= "" then tonumber(result) or 0 else 0
end

local function incrementImpressionCount(key: string) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        local num1 = getImpressionCount(key) + 1
        AppStorageService:SetItem(key, tostring(num1))
        AppStorageService:Flush()
    end)
end

local function usePlusReferralFlyoutBannerBlindness(bool1: boolean, key: string, num1: number?)
    local var1 = React.useState(function(): number
        return getImpressionCount(key)
    end)
    local num2 = num1 or game:GetFastInt("PlusReferralFlyoutBannerMaxImpressions")
    local bool2 = num2 == 0 or var1 < num2
    local bool3 = bool1 and bool2

    React.useEffect(function()
        if bool3 then
            incrementImpressionCount(key)
        end
    end, { bool3, key })

    return bool3
end

return usePlusReferralFlyoutBannerBlindness
