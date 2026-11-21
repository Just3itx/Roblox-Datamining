-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TelemetryService = game:GetService("TelemetryService")

local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local LoggingProtocol = require(GameJoinCardParent.LoggingProtocol)
local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagGameJoinCardAnalyticsCardId = SharedFlags.FFlagGameJoinCardAnalyticsCardId
local FFlagSocialCarouselBuildPresence = SharedFlags.FFlagSocialCarouselBuildPresence

local AgeCheckUpsellOutcome = require(script.Parent.AnalyticsConstants).AgeCheckUpsellOutcome

local throttlingPercentage = game:DefineFastInt("GameJoinCardAnalyticsThrottleHundredthsPercent", 10000)

local config = {
    eventName = "buttonClick",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 4, 14 },
    description = "Game join card button taps (GameJoinCardButtonEvents → buttonClick, ctx gameJoinCard)",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/game_join_card/game_join_card_button_events.proto"
}

local config2 = {
    eventName = "luaPageLoad",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 4, 14 },
    description = "Game join card surface shown (GameJoinCardPageLoadedEvent → luaPageLoad, ctx gameJoinCard)",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/game_join_card/game_join_card_page_loaded.proto"
}

local config3 = {
    eventName = "joinCardAgeCheckUpsellImpression",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 5, 19 },
    description = "Game join card age-check upsell shown to user (ctx gameJoinCard)",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/game_join_card/game_join_card_age_check_upsell_impression.proto"
}

local config4 = {
    eventName = "joinCardAgeCheckVerificationOutcome",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 5, 19 },
    description = "Outcome (success/cancelled/error) of the age-check verification flow opened from the game join card (ctx gameJoinCard)",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/game_join_card/game_join_card_age_check_verification_outcome.proto"
}

local tbl1 = {
    eventName = "joinCardCtaLoadTime",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 5, 19 },
    description = "Game join card carousel tap → CTA settled duration in ms, plus the ctaType rendered and whether playability was served from cache (ctx gameJoinCard)",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/game_join_card/game_join_card_cta_load_time.proto"
}

local function optionalInt64FromString(universeId: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    if universeId == nil or universeId == "" then
        return nil
    end
    return tonumber(universeId)
end

local function buildGameJoinCardCommonFields(tbl2)
    local gameJoinCardCommonFields = {}

    local localPlayer = Players.LocalPlayer
    if localPlayer then
        gameJoinCardCommonFields.uid = localPlayer.UserId
    end

    if tbl2.friendId and tbl2.friendId ~= "" then
        local cardUserId = tonumber(tbl2.friendId)
        if cardUserId then
            gameJoinCardCommonFields.cardUserId = cardUserId
        end
    end

    local universeId = optionalInt64FromString(tbl2.universeId)
    if universeId then
        gameJoinCardCommonFields.universeId = universeId
    end

    if tbl2.absolutePosition ~= nil then
        gameJoinCardCommonFields.carouselAbsolutePosition = math.floor(tbl2.absolutePosition)
    end

    if FFlagGameJoinCardAnalyticsCardId and tbl2.joinGameCardId and tbl2.joinGameCardId ~= "" then
        gameJoinCardCommonFields.joinGameCardId = tbl2.joinGameCardId
    end

    if FFlagSocialCarouselBuildPresence and tbl2.cardType ~= nil then
        gameJoinCardCommonFields.cardType = tbl2.cardType
    end

    return gameJoinCardCommonFields
end

return {
    logGameJoinCardButtonEvent = function(buttonAction: number, tbl2)
        local customFields = buildGameJoinCardCommonFields(tbl2 or {})
        customFields.buttonAction = buttonAction

        TelemetryService:LogEvent(
            config,
            {
                eventContext = "gameJoinCard",
                customFields = customFields,
                standardizedFields = { "addSessionInfo" }
            }
        )
    end,
    logGameJoinCardPageLoaded = function(tbl2)
        local customFields = buildGameJoinCardCommonFields(tbl2 or {})

        TelemetryService:LogEvent(
            config2,
            {
                eventContext = "gameJoinCard",
                customFields = customFields,
                standardizedFields = { "addSessionInfo" }
            }
        )
    end,
    logJoinCardAgeCheckUpsellImpression = function(tbl2)
        local customFields = {}

        local universeId = optionalInt64FromString(tbl2.universeId)
        if universeId then
            customFields.universeId = universeId
        end

        TelemetryService:LogEvent(
            config3,
            {
                eventContext = "gameJoinCard",
                customFields = customFields,
                standardizedFields = { "addSessionInfo" }
            }
        )
    end,
    logJoinCardAgeCheckVerificationOutcome = function(tbl2)
        local customFields = {
            outcome = AgeCheckUpsellOutcome[tbl2.outcome]
        }

        local universeId = optionalInt64FromString(tbl2.universeId)
        if universeId then
            customFields.universeId = universeId
        end

        TelemetryService:LogEvent(
            config4,
            {
                eventContext = "gameJoinCard",
                customFields = customFields,
                standardizedFields = { "addSessionInfo" }
            }
        )
    end,
    logJoinCardCtaLoadTime = function(tbl2)
        TelemetryService:LogEvent(tbl1, {
            eventContext = "gameJoinCard",
            customFields = {
                durationMs = math.max(0, math.floor(tbl2.durationMs)),
                ctaType = tbl2.ctaType,
                wasCached = tbl2.wasCached
            },
            standardizedFields = { "addSessionInfo" }
        })
    end
}
