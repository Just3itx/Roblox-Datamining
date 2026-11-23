-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local _types = require(AppChat.types)
local AppChatParent = AppChat.Parent
local _SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local _AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Telemetry = require(AppChat.Telemetry.Telemetry)
local DefaultTelemetryEvents = require(AppChat.Telemetry.DefaultTelemetryEvents)
local namedCounterConfigurationAndFormat = DefaultTelemetryEvents.namedCounterConfigurationAndFormat
local eventIngestWithFormatFunction = DefaultTelemetryEvents.eventIngestWithFormatFunction
local Cryo = require(AppChatParent.Cryo)

local tbl1 = {}

local function eventIngestWithModalFormatFunction(eventStreamFormat, modalSequence: string)
    return eventIngestWithFormatFunction(function(tbl2, arg1)
        local var1 = eventStreamFormat(tbl2, arg1)
        return Cryo.Dictionary.join({ modalSequence = modalSequence }, var1)
    end)
end
tbl1.Events = {
    modalRenderedWithSequence = function(arg1)
        local backendsList = {}
        local counterFormat = arg1.counterFormat
        local eventStreamFormat = arg1.eventStreamFormat
        if counterFormat then
            table.insert(
                backendsList,
                namedCounterConfigurationAndFormat(`AppChat.Modal.{arg1.modalSequence}.Rendered`, counterFormat)
            )
        end
        if eventStreamFormat then
            table.insert(backendsList, eventIngestWithModalFormatFunction(eventStreamFormat, arg1.modalSequence))
        end
        return (Telemetry.new(
            {
                name = "appChatModalRendered",
                description = "",
                lastUpdated = { 2025, 9, 8 },
                backendsList = backendsList
            }
        ))
    end,
    modalActionWithSequence = function(arg1)
        local backendsList = {}
        local counterFormat = arg1.counterFormat
        local eventStreamFormat = arg1.eventStreamFormat
        if counterFormat then
            table.insert(
                backendsList,
                namedCounterConfigurationAndFormat(`AppChat.Modal.{arg1.modalSequence}.Action`, counterFormat)
            )
        end
        if eventStreamFormat then
            table.insert(backendsList, eventIngestWithModalFormatFunction(eventStreamFormat, arg1.modalSequence))
        end
        return (Telemetry.new(
            {
                name = "appChatModalAction",
                description = "",
                lastUpdated = { 2025, 9, 8 },
                backendsList = backendsList
            }
        ))
    end,
    modalActionResultWithSequence = function(arg1)
        local backendsList = {}
        local counterFormat = arg1.counterFormat
        local eventStreamFormat = arg1.eventStreamFormat
        if counterFormat then
            table.insert(
                backendsList,
                namedCounterConfigurationAndFormat(`AppChat.Modal.{arg1.modalSequence}.ActionResult`, counterFormat)
            )
        end
        if eventStreamFormat then
            table.insert(backendsList, eventIngestWithModalFormatFunction(eventStreamFormat, arg1.modalSequence))
        end
        return (Telemetry.new(
            {
                name = "appChatModalActionResult",
                description = "",
                lastUpdated = { 2025, 9, 8 },
                backendsList = backendsList
            }
        ))
    end
}
tbl1.Enums = {
    ModalActions = {
        PrimaryCta = "primaryCta",
        SecondaryCta = "secondaryCta",
        Dismiss = "dismiss",
        InlineCta = "inlineCta"
    },
    ModalActionResults = { Success = "success", Failure = "failure" },
    ModalSequence = {
        ChatLandingModal = "ChatLandingModal",
        ConversationOverlay = "ConversationOverlay",
        ConversationTopModal = "ConversationTopModal",
        ConversationListOverlay = "ConversationListOverlay"
    }
}

return tbl1
