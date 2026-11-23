-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local _ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local Telemetry = require(AppChat.Telemetry.Telemetry)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)
local DefaultTelemetryEvents = require(AppChat.Telemetry.DefaultTelemetryEvents)

local tbl1 = {}

local function eventIngestWithFormatFunction(format: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
    return {
        type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.EventIngest,
        standardizedFields = DefaultTelemetryEvents.STANDARDIZED_FIELDS,
        format = format,
        overrideName = nil,
        throttlingThousandths = nil
    }
end

tbl1.Constants = {
    EventStreamCtx = SocialLuaAnalytics.Analytics.Enums.Contexts.Party,
    FaeModalShownField = "fae",
    ConfirmFaeBtn = "confirmFae",
    CancelFaeBtn = "cancelFae"
}

tbl1.Events = {
    FaeModalShown = Telemetry.new({
        name = "authModalShown",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            DefaultTelemetryEvents.namedCounterConfigurationNoEmittedInfo("AppChat.ChatLandingModal.FaeModal.Shown"),
            {
                type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.EventIngest,
                standardizedFields = DefaultTelemetryEvents.STANDARDIZED_FIELDS,
                format = function(_, _)
                    return {
                        field = tbl1.Constants.FaeModalShownField,
                        os_time = os.time(),
                        os_clock = os.clock()
                    }
                end,
                overrideName = nil,
                throttlingThousandths = nil
            }
        },
        eventStreamCtx = tbl1.Constants.EventStreamCtx
    }),
    TelemetryFaeButtonClick = Telemetry.new({
        name = "authButtonClick",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            DefaultTelemetryEvents.namedCounterConfigurationAndFormat("AppChat.ChatLandingModal.FaeButton.Click", function(tbl2)
                return {
                    btn = tbl2.btn
                }
            end),
            {
                type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.EventIngest,
                standardizedFields = DefaultTelemetryEvents.STANDARDIZED_FIELDS,
                format = function(tbl2, _)
                    return {
                        state = tbl2.state,
                        btn = tbl2.btn,
                        os_time = os.time(),
                        os_clock = os.clock()
                    }
                end,
                overrideName = nil,
                throttlingThousandths = nil
            }
        },
        eventStreamCtx = tbl1.Constants.EventStreamCtx
    }),
    ModalRendered = ModalTelemetry.Events.modalRenderedWithSequence({
        modalSequence = ModalTelemetry.Enums.ModalSequence.ChatLandingModal,
        counterFormat = function(arg1, _)
            return {
                modalVariant = arg1.modalVariant
            }
        end
    }),
    ModalAction = ModalTelemetry.Events.modalActionWithSequence({
        modalSequence = ModalTelemetry.Enums.ModalSequence.ChatLandingModal,
        counterFormat = function(arg1, _)
            return {
                modalVariant = arg1.modalVariant,
                action = arg1.action
            }
        end
    }),
    ModalActionResult = ModalTelemetry.Events.modalActionResultWithSequence({
        modalSequence = ModalTelemetry.Enums.ModalSequence.ChatLandingModal,
        counterFormat = function(arg1, _)
            return {
                modalVariant = arg1.modalVariant,
                action = arg1.action,
                actionResult = arg1.actionResult
            }
        end
    })
}

return tbl1
