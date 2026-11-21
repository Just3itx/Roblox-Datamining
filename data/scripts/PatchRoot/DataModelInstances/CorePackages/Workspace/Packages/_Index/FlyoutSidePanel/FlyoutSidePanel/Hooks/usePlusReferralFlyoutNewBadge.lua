-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)

local function getImpressionCount(key: string): number -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(key)
    end)
    return if success and typeof(result) == "string" and result ~= "" then tonumber(result) or 0 else 0
end

local function markSeen(key: string) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        AppStorageService:SetItem(key, "1")
        AppStorageService:Flush()
    end)
end

local function usePlusReferralFlyoutNewBadge(callback: (...any) -> (...any), key: string)
    local shouldShowNewBadge = React.useState(function(): boolean
        return getImpressionCount(key) < 1
    end)

    return {
        shouldShowNewBadge = shouldShowNewBadge,
        onActivated = React.useCallback(function()
            if shouldShowNewBadge then
                markSeen(key)
            end
            callback()
        end, { shouldShowNewBadge, callback, key })
    }
end

return usePlusReferralFlyoutNewBadge
