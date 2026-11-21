-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserInputService = game:GetService("UserInputService")
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local IsVRAppBuild = require(GameCollectionsParent.AppCommonLib).IsVRAppBuild
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage

local str1 = "Other"
pcall(function()
    local platform = UserInputService:GetPlatform()
    if platform == Enum.Platform.Android then
        str1 = "Android"
    elseif platform == Enum.Platform.IOS then
        str1 = "iOS"
    elseif platform == Enum.Platform.Windows then
        str1 = "Win"
    elseif platform == Enum.Platform.UWP then
        str1 = "UWP"
    elseif platform == Enum.Platform.OSX then
        str1 = "Mac"
    elseif platform == Enum.Platform.XBox360 or platform == Enum.Platform.XBoxOne then
        str1 = "XBox"
    elseif platform == Enum.Platform.PS4 or game:GetEngineFeature("PlatformEnumPS5") and platform == Enum.Platform.PS5 then
        str1 = "PS"
    end
end)

return function(arg1, str2: string, num1: number, num2: number?)
    if not arg1 or not arg1.Diag or not str2 then
        return
    end

    local str3 = "Other"
    if str2 == AppPage.Home or str2 == AppPage.Games then
        if num2 == 1 then
            str3 = "GamesList"
        elseif str2 == AppPage.Home then
            str3 = "Home"
        else
            assert(str2 == AppPage.Games, `{str2} should always be Games here`)
            str3 = "Games"
        end
    elseif str2 == "recommended" then
        str3 = "GameDetail"
    elseif str2 == AppPage.SearchPage then
        str3 = "SearchPage"
    end

    local str4 = str1

    local str5 = (if IsVRAppBuild() then "VR" else str4) .. "-GameImps-" .. str3
    arg1.Diag:reportCounterSimple(str5, num1)
end
