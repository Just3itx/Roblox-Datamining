-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local buildLegacyVoiceRestrictionDetail = require(script.Parent.buildLegacyVoiceRestrictionDetail)

local _createVoiceRestrictionController = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController)
local getRestrictionType = require(script.Parent.getRestrictionType)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local UniversalFeatureRestrictions = require(CorePackages.Workspace.Packages.UniversalFeatureRestrictions)
local VoiceChat = require(CorePackages.Workspace.Packages.VoiceChat)

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local function format(str1: string, tbl1)
    return localization:Format(str1, tbl1)
end

local function showLegacyVoiceRestriction(tbl1)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    local userId = localPlayer.UserId

    local manager = tbl1.manager
    local settings = tbl1.settings
    local trigger = tbl1.trigger
    local isCurrent = tbl1.isCurrent

    local var1 = if manager.service then manager.previousSessionId else ""
    local analytics = manager.Analytics

    local restrictionType = getRestrictionType(settings)
    local banReason = if settings then settings.banReason else nil
    local nudgeAnalyticsData = nil
    local var2 = nil
    if not settings then
        nudgeAnalyticsData, var2 = manager:GetNudgeAnalyticsData()
    end

    local legacyVoiceRestrictionDetail = buildLegacyVoiceRestrictionDetail(
        {
            settings = settings,
            userId = userId,
            now = DateTime.now().UnixTimestamp,
            format = format
        }
    )
    local bool1 = false
    local bool2 = false
    local bool3 = false

    local function logBanDialogEvent(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        analytics:reportBanMessageEvent(str1)
        analytics:reportBanMessageEventV2(str1, banReason, userId, var1)
    end

    local function onShown()
        if bool3 then
            return
        end

        bool3 = true
        if restrictionType ~= "Nudge" then
            logBanDialogEvent("Shown")
        end
    end

    local function onAppeal()
        bool2 = true
        if restrictionType == "Nudge" then
            analytics:reportDeniedNudge(nudgeAnalyticsData, var2)
            return
        end

        logBanDialogEvent("Denied")
    end

    local function onDismiss()
        if bool1 then
            return
        end

        bool1 = true

        if trigger ~= "micTap" and (restrictionType == "TemporaryBan" or restrictionType == "NudgeBan") and isCurrent() then
            VoiceChat.PostInformedOfBan(function(arg1, arg2, arg3)
                return manager:PostRequest(arg1, arg2, arg3)
            end, true)
        end

        if restrictionType == "Nudge" then
            analytics:reportClosedNudge(nudgeAnalyticsData, var2)
            if not bool2 then
                analytics:reportAcknowledgedNudge(nudgeAnalyticsData, var2)
            end
        elseif not bool2 then
            logBanDialogEvent(if restrictionType == "NudgeBan" then "Understood" else "Acknowledged")
        end
    end

    local showFeatureRestrictionDirect = UniversalFeatureRestrictions.showFeatureRestrictionDirect
    local voice = UniversalFeatureRestrictions.AbuseVector.Voice
    local tbl2 = { onShown = onShown, onDismiss = onDismiss, onAppeal = 0 }
    if restrictionType ~= "Nudge" and restrictionType ~= "NudgeBan" then
        onAppeal = nil
    end

    tbl2.onAppeal = onAppeal
    showFeatureRestrictionDirect(voice, legacyVoiceRestrictionDetail, tbl2)
end

return showLegacyVoiceRestriction
