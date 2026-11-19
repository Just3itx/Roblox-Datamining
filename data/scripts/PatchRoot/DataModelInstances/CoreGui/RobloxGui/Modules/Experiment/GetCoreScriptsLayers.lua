-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local FStringSocialCaptureIXPLayer = require(CorePackages.Workspace.Packages.SharedFlags).FStringSocialCaptureIXPLayer

local FStringSocialCaptureTakenIXPLayer = require(CorePackages.Workspace.Packages.SharedFlags).FStringSocialCaptureTakenIXPLayer
local _GetFFlagEnableNewInviteMenuIXP = require(script.Parent.Parent.Flags.GetFFlagEnableNewInviteMenuIXP)

local GetFStringLargerRobuxUpsellIxpLayer = require(CorePackages.Workspace.Packages.SharedFlags).GetFStringLargerRobuxUpsellIxpLayer

local GetFStringLuaAppExperienceMenuLayer = require(CorePackages.Workspace.Packages.SharedFlags).GetFStringLuaAppExperienceMenuLayer

local GetFStringLuaAppConsoleExperienceMenuLayer = require(script.Parent.Parent.Flags.GetFStringLuaAppConsoleExperienceMenuLayer)

local GetFFlagReportAnythingAnnotationIXP = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagReportAnythingAnnotationIXP

local GetFStringReportAnythingAnnotationIXPLayerName = require(CorePackages.Workspace.Packages.SharedFlags).GetFStringReportAnythingAnnotationIXPLayerName
local GetFStringChatTranslationLayerName = require(script.Parent.Parent.Flags.GetFStringChatTranslationLayerName)
local GetFFlagChatTranslationSettingEnabled = require(script.Parent.Parent.Flags.GetFFlagChatTranslationSettingEnabled)
local GetFFlagVoiceUserAgencyEnableIXP = require(script.Parent.Parent.Flags.GetFFlagVoiceUserAgencyEnableIXP)
local GetFStringVoiceUserAgencyIXPLayerName = require(script.Parent.Parent.Flags.GetFStringVoiceUserAgencyIXPLayerName)

local getFStringDesktopToastNotificationLayer = require(CorePackages.Workspace.Packages.SharedFlags).getFStringDesktopToastNotificationLayer

local GetFFlagUXForCameraPerformanceIXPEnabled = require(script.Parent.Parent.Flags.GetFFlagUXForCameraPerformanceIXPEnabled)

local GetFStringUXForCameraPerformanceIXPLayerName = require(script.Parent.Parent.Flags.GetFStringUXForCameraPerformanceIXPLayerName)
local GetFStringVoiceExposureIXPLayerName = require(script.Parent.Parent.Flags.GetFStringVoiceExposureIXPLayerName)

local GetFStringAndroidPhoneVerificationLayer = require(CorePackages.Workspace.Packages.SharedFlags).GetFStringAndroidPhoneVerificationLayer

local GetFStringIOSPhoneVerificationLayer = require(CorePackages.Workspace.Packages.SharedFlags).GetFStringIOSPhoneVerificationLayer

local GetFFlagEnableAppChatInExperience = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableAppChatInExperience

local getFStringAppChatInExperienceIXPLayer = require(CorePackages.Workspace.Packages.SharedFlags).getFStringAppChatInExperienceIXPLayer
local FStringReportMenuIXPLayer = require(CorePackages.Workspace.Packages.SharedFlags).FStringReportMenuIXPLayer
local FStringReportingIXPLayer = require(CorePackages.Workspace.Packages.SharedFlags).FStringReportingIXPLayer

local FFlagEnableShopExposureLogging = require(CorePackages.Workspace.Packages.InExperienceShop.FFlagEnableShopExposureLogging)

local FStringExperienceShopLayer1 = require(CorePackages.Workspace.Packages.InExperienceShop.FStringExperienceShopLayer1)

local FStringExperienceShopLayer2 = require(CorePackages.Workspace.Packages.InExperienceShop.FStringExperienceShopLayer2)

return function()
    local tbl1 = {
        "AbuseReports",
        getFStringDesktopToastNotificationLayer(),
        FStringReportMenuIXPLayer,
        FStringReportingIXPLayer,
        FStringSocialCaptureIXPLayer,
        FStringSocialCaptureTakenIXPLayer
    }

    table.insert(tbl1, GetFStringLuaAppExperienceMenuLayer())
    table.insert(tbl1, GetFStringLuaAppConsoleExperienceMenuLayer())

    if GetFStringLargerRobuxUpsellIxpLayer() then
        table.insert(tbl1, GetFStringLargerRobuxUpsellIxpLayer())
    end

    if GetFFlagReportAnythingAnnotationIXP() then
        table.insert(tbl1, GetFStringReportAnythingAnnotationIXPLayerName())
    end

    if GetFFlagChatTranslationSettingEnabled() and #GetFStringChatTranslationLayerName() > 0 then
        table.insert(tbl1, GetFStringChatTranslationLayerName())
    end

    if GetFFlagVoiceUserAgencyEnableIXP() then
        table.insert(tbl1, GetFStringVoiceUserAgencyIXPLayerName())
    end

    if GetFFlagUXForCameraPerformanceIXPEnabled() then
        table.insert(tbl1, GetFStringUXForCameraPerformanceIXPLayerName())
    end

    table.insert(tbl1, GetFStringVoiceExposureIXPLayerName())

    if GetFStringAndroidPhoneVerificationLayer() then
        table.insert(tbl1, GetFStringAndroidPhoneVerificationLayer())
    end

    if GetFStringIOSPhoneVerificationLayer() then
        table.insert(tbl1, GetFStringIOSPhoneVerificationLayer())
    end

    if GetFFlagEnableAppChatInExperience() then
        table.insert(tbl1, getFStringAppChatInExperienceIXPLayer())
    end

    if FFlagEnableShopExposureLogging then
        table.insert(tbl1, FStringExperienceShopLayer1)
        table.insert(tbl1, FStringExperienceShopLayer2)
    end

    return tbl1
end
