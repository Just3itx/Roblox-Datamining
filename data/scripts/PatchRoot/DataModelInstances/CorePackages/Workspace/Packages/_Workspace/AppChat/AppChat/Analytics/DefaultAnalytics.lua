-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    fireAnalyticsEvent = function<T, U>(arg1: T, arg2: U): (T, U)
        return arg1, arg2
    end,
    updateInfoForAllEvents = function<T>(arg1: T): T
        return arg1
    end,
    getInfoForAllEvents = function()
        return { analyticsTag = "DefaultAnalytics" }
    end
}
