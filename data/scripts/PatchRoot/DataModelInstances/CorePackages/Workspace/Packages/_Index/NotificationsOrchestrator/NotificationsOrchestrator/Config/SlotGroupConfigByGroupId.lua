-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local _SlotGroup = require(NotificationsOrchestrator.Enums.SlotGroup)
local _Types = require(NotificationsOrchestrator.Types)

local GlobalSlotGroupConfig = {
    frequency = { maxImpressions = 10, window = "session", cooldownSeconds = 60 },
    capacity = 1
}

local SlotGroupConfigByGroupId = {}

return {
    GlobalSlotGroupConfig = GlobalSlotGroupConfig,
    SlotGroupConfigByGroupId = SlotGroupConfigByGroupId,
    getSlotGroupConfig = function(arg1)
        return SlotGroupConfigByGroupId[arg1] or GlobalSlotGroupConfig
    end
}
