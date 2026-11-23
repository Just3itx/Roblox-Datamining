-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local isSpatial = require(AvatarExperienceAnalyticsParent.AppCommonLib).isSpatial

local function getAvatarEventCounterNameWithPlatform(str1: string)
    local platform = UserInputService:GetPlatform()

    if isSpatial() then
        return "VR" .. str1
    end

    if platform == Enum.Platform.Android then
        return "Android" .. str1
    end

    if platform == Enum.Platform.IOS then
        return "IOS" .. str1
    end

    if platform == Enum.Platform.Windows then
        return "Windows" .. str1
    end

    if platform == Enum.Platform.OSX then
        return "OSX" .. str1
    end

    if platform == Enum.Platform.PS4 or platform == Enum.Platform.PS5 then
        return "PlayStation" .. str1
    end

    if platform == Enum.Platform.XBoxOne or platform == Enum.Platform.XBox360 then
        str1 = "Xbox-" .. str1
    end
    return str1
end

return getAvatarEventCounterNameWithPlatform
