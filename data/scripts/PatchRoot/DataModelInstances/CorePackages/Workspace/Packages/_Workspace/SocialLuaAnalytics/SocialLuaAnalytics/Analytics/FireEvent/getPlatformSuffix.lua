-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent
local IsVRAppBuild = require(SocialLuaAnalyticsParent.AppCommonLib).IsVRAppBuild
local getUserInputService = require(script.Parent.getUserInputService)
local PlatformBuckets = require(script.Parent.Parent.Enums.PlatformBuckets)
local PlatformSpecificity = require(script.Parent.Parent.Enums.PlatformSpecificity)

local tbl1 = {
    [Enum.Platform.Windows] = PlatformBuckets.Windows,
    [Enum.Platform.OSX] = PlatformBuckets.Mac,
    [Enum.Platform.IOS] = PlatformBuckets.IOS,
    [Enum.Platform.Android] = PlatformBuckets.Android,
    [Enum.Platform.UWP] = PlatformBuckets.Windows,
    [Enum.Platform.XBox360] = PlatformBuckets.XBox,
    [Enum.Platform.XBoxOne] = PlatformBuckets.XBox,
    [Enum.Platform.PS3] = PlatformBuckets.Playstation,
    [Enum.Platform.PS4] = PlatformBuckets.Playstation,
    [Enum.Platform.PS5] = PlatformBuckets.Playstation,
    [Enum.Platform.None] = PlatformBuckets.None
}

return function(arg1)
    local userInputService = getUserInputService()
    local var1 = nil
    pcall(function()
        var1 = userInputService:GetPlatform() or Enum.Platform.None
    end)

    if arg1 == PlatformSpecificity.All then
        if IsVRAppBuild() then
            return PlatformBuckets.Quest
        end

        return tostring(var1):match(".*%.(.*)") or PlatformBuckets.None
    end

    if arg1 == PlatformSpecificity.BucketsOnly then
        if IsVRAppBuild() then
            return PlatformBuckets.Quest
        end

        return tbl1[var1] or PlatformBuckets.None
    end

    return ""
end
