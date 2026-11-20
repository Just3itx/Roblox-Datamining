-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local _createVoiceRestrictionController = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController)
local UniversalFeatureRestrictions = require(CorePackages.Workspace.Packages.UniversalFeatureRestrictions)

local function showUFRVoiceRestriction(tbl1)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    local userId = localPlayer.UserId

    local manager = tbl1.manager
    local analytics = manager.Analytics
    local banReason = tbl1.settings.banReason
    local var1 = if manager.service then manager.previousSessionId else ""

    local bool1 = false
    local bool2 = false
    local bool3 = false

    local function logBanDialogEvent(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        analytics:reportBanMessageEvent(str1)
        analytics:reportBanMessageEventV2(str1, banReason, userId, var1)
    end

    UniversalFeatureRestrictions.showFeatureRestriction(UniversalFeatureRestrictions.AbuseVector.Voice, {
        onShown = function()
            if not bool1 then
                bool1 = true
                logBanDialogEvent("Shown")
            end
        end,
        onAppeal = function()
            bool2 = true
            logBanDialogEvent("Denied")
        end,
        onDismiss = function()
            if bool3 then
                return
            end
            bool3 = true
            if not bool2 then
                logBanDialogEvent("Acknowledged")
            end
        end,
        onAcknowledgementSuccess = tbl1.onAcknowledgementSuccess
    })
end

return showUFRVoiceRestriction
