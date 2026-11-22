-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local _SlotId = require(NotificationsOrchestrator.Enums.SlotId)
local _Types = require(NotificationsOrchestrator.Types)

local GlobalSlotConfig = {
    lifecycle = {
        frequency = { maxImpressions = 10, window = "session", cooldownSeconds = 60 },
        visibility = { delayMs = 0, autoDismissAfterMs = 0 }
    }
}

local SlotConfigBySlotId = {}

return {
    GlobalSlotConfig = GlobalSlotConfig,
    SlotConfigBySlotId = SlotConfigBySlotId,
    getSlotConfig = function(arg1)
        return SlotConfigBySlotId[arg1] or GlobalSlotConfig
    end
}
