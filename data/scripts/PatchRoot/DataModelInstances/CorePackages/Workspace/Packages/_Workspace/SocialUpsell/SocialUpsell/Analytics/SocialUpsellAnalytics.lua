-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local _Types = require(SocialUpsell.Types)
local SocialUpsellParent = SocialUpsell.Parent
local Cryo = require(SocialUpsellParent.Cryo)
local UpsellEntrySurfaceType = require(SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType)
local UpsellComponent = require(SocialUpsell.Analytics.Enum.UpsellComponent)
local UpsellStage = require(SocialUpsell.Analytics.Enum.UpsellStage)
local _EventTypes = require(SocialUpsellParent.SocialLuaAnalytics).Analytics.Enums.EventTypes
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local tbl1 = {
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FIntSocialUpsellEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2025, 9, 26 },
    description = "Upsell Banner Analytics Event"
}

function evaluateUpsellStage(arg1, modal, modal2)
    if modal == UpsellComponent.Modal then
        if modal2 == UpsellComponent.Modal
            and (arg1 == UpsellEntrySurfaceType.Homepage
                or arg1 == UpsellEntrySurfaceType.InExperienceChatInputBar
                or arg1 == UpsellEntrySurfaceType.InExperienceVoiceChatIcon)
        then
            return UpsellStage.Fae
        end

        return UpsellStage.FaeDetails
    end

    return UpsellStage.Fae
end

local function generateUpsellIdentifier(upsellPurpose: string?, upsellEntrySurface: string?, upsellComponent: string?): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if upsellPurpose and upsellEntrySurface and upsellComponent then upsellPurpose .. upsellEntrySurface .. upsellComponent else nil
end

function logUpsellEvent(eventName, tbl2)
    local config = Cryo.Dictionary.join(tbl1, { eventName = eventName })
    local playSessionId = RbxAnalyticsService:GetPlaySessionId()

    local customFields = {
        upsellEntrySurface = tbl2.upsellEntrySurface,
        upsellStage = tbl2.upsellStage,
        upsellImpressionId = tbl2.upsellImpressionId,
        upsellComponent = tbl2.upsellComponent,
        btn = tbl2.btn or nil,
        conversationId = tbl2.conversationId or nil,
        playSessionId = 0,
        clientTimeStamp = 0,
        upsellEntryComponent = 0
    }

    if playSessionId == "" then
        playSessionId = nil
    end

    customFields.playSessionId = playSessionId
    customFields.clientTimeStamp = os.time()
    customFields.upsellEntryComponent = tbl2.upsellEntryComponent

    customFields.upsellIdentifier = generateUpsellIdentifier(tbl2.upsellPurpose, tbl2.upsellEntrySurface, tbl2.upsellComponent)

    customFields.upsellPurpose = tbl2.upsellPurpose

    local standardizedFields = { "addSessionInfo" }
    table.insert(standardizedFields, "addPlaceId")
    table.insert(standardizedFields, "addUniverseId")

    TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = standardizedFields })
end

return {
    evaluateUpsellStage = evaluateUpsellStage,
    logUpsellEvent = logUpsellEvent
}
