-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _AppTelemetryLayer = require(AppChat.Telemetry.Layers.AppTelemetryLayer)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)

return {
    Events = {
        ModalRendered = ModalTelemetry.Events.modalRenderedWithSequence({
            modalSequence = ModalTelemetry.Enums.ModalSequence.ConversationOverlay,
            counterFormat = function(arg1, _)
                return {
                    modalVariant = arg1.modalVariant
                }
            end
        }),
        ModalAction = ModalTelemetry.Events.modalActionWithSequence({
            modalSequence = ModalTelemetry.Enums.ModalSequence.ConversationOverlay,
            counterFormat = function(arg1, _)
                return {
                    modalVariant = arg1.modalVariant,
                    action = arg1.action
                }
            end
        }),
        ModalActionResult = ModalTelemetry.Events.modalActionResultWithSequence({
            modalSequence = ModalTelemetry.Enums.ModalSequence.ConversationOverlay,
            counterFormat = function(arg1, _)
                return {
                    modalVariant = arg1.modalVariant,
                    action = arg1.action,
                    actionResult = arg1.actionResult
                }
            end
        })
    }
}
