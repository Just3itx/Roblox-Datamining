-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local NotificationsOrchestratorParent = NotificationsOrchestrator.Parent

local AvatarExperienceAnalytics = require(NotificationsOrchestratorParent.AvatarExperienceAnalytics)
local MarketplaceUnifiedAction = AvatarExperienceAnalytics.UnifiedEventLogEnums.MarketplaceUnifiedAction
local sendPassthroughUnifiedEventLog = AvatarExperienceAnalytics.sendPassthroughUnifiedEventLog
local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog

local UnifiedLoggingSurface = require(NotificationsOrchestratorParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local _Types = require(NotificationsOrchestrator.Types)

local tbl1 = {
    suppressed = true,
    submitDropped = true,
    capReached = true,
    promoteDropped = true,
    revoked = true
}

local function metadataString(str1: string?) -- Luacid: Inlined by compiler; 5 call sites recovered
    if str1 == nil then
        return nil
    end
    return tostring(str1)
end

local function actionFor(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl2.eventType == "mounted" then
        return nil
    elseif tbl2.eventType == "viewed" then
        return MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION
    end

    if tbl2.eventType == "activated" or tbl2.eventType == "dismissed" then
        return MarketplaceUnifiedAction.UI_ELEMENT_CLICK
    end

    if tbl2.eventType == "queued" then
        return 12
    end

    if tbl1[tbl2.eventType] then
        return 13
    end

    return nil
end

local function metadataFor(tbl2): string
    local input = {
        eventType = tostring(tbl2.eventType),
        reason = metadataString(tbl2.reason),
        actionId = metadataString(tbl2.actionId),
        handle = metadataString(tbl2.handle),
        lifecycleKey = metadataString(tbl2.lifecycleKey),
        source = metadataString(tbl2.source)
    }
    return HttpService:JSONEncode(input)
end

return {
    send = function(tbl2)
        local action = actionFor(tbl2)

        if action == nil then
            return
        end

        local tbl3 = {
            action = action,
            surface = UnifiedLoggingSurface.IN_EXPERIENCE_NOTIFICATIONS,
            elementName = tbl2.slot,
            elementMetadata = metadataFor(tbl2),
            universeId = game.GameId,
            itemId = tbl2.itemId,
            itemType = tbl2.itemType
        }

        if AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads then
            sendPassthroughUnifiedEventLog(tbl3)
            return
        end
        sendUnifiedEventLog(tbl3)
    end
}
