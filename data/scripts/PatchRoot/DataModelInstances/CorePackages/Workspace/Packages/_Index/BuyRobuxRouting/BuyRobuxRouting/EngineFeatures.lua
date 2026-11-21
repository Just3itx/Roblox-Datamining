-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    isRobloxSubscriptionReadSupported = function(): boolean
        return game:GetEngineFeature("ReadHasRobloxSubscriptionLua")
    end,
    isFirstTimePurchaseConsentStorageSupported = function(): boolean
        return game:GetEngineFeature("FirstTimePurchaseConsentAcknowledgedStorageKey")
    end
}
