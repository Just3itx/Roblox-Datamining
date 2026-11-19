-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local _Types = require(AbuseReportMenu.Components.Types)
local TnSAvatarIdentification = require(CorePackages.Workspace.Packages.TnSAvatarIdentification)
local TnSAdIdentification = require(CorePackages.Workspace.Packages.TnSAdIdentification)

local ScreenshotManager = require(CorePackages.Workspace.Packages.TnSScreenshot).ScreenshotManager

local AvatarIdentification = TnSAvatarIdentification.AvatarIdentification
local AdIdentification = TnSAdIdentification.AdIdentification

return function<T>(func1: (...any) -> (...any), func2: (...any) -> (...any), callback: (...any) -> (...any))
    return React.useCallback(function()
        ScreenshotManager:TakeScreenshotWithCallback(func2, func1)
        local identifiedAvatars, avatarIdStats = AvatarIdentification.getVisibleAvatars()
        local identifiedAds, adIdStats = AdIdentification.getVisibleAds()

        callback({
            identifiedAvatars = identifiedAvatars,
            identifiedAds = identifiedAds,
            avatarIDStats = avatarIdStats,
            adIDStats = adIdStats
        })
    end, { func2, func1, callback })
end
