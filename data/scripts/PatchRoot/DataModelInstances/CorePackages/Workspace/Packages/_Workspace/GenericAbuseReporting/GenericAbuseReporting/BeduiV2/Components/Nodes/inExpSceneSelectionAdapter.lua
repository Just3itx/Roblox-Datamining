-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local MessageBusService = game:GetService("MessageBusService")
local SafetyService = game:GetService("SafetyService")

local messageId = MessageBusService:GetMessageId("CaptureMode", "sceneSelectionExitReason")

return {
    start = function()
        SafetyService.IsCaptureModeForReport = true
        ExperienceStateCaptureService:ToggleCaptureMode()
    end,
    subscribeOnceToExitReason = function(callback: (...any) -> (...any)): Instance
        return MessageBusService:Subscribe(messageId, callback, true, false)
    end
}
