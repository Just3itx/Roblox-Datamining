-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Types)
local SlotId = require(script.Enums.SlotId)
local SlotGroup = require(script.Enums.SlotGroup)
local SlotGroupBySlotId = require(script.Config.SlotGroupBySlotId)
local SlotGroupConfigByGroupId = require(script.Config.SlotGroupConfigByGroupId)
local SlotConfigBySlotId = require(script.Config.SlotConfigBySlotId)
local GetNotificationsStore = require(script.Stores.GetNotificationsStore)

local FFlagEnableNotificationsOrchestratorUnifiedLogging = require(script.Flags.FFlagEnableNotificationsOrchestratorUnifiedLogging)

local module = {
    SlotId = SlotId,
    SlotGroup = SlotGroup,
    SlotGroupBySlotId = SlotGroupBySlotId,
    GlobalSlotGroupConfig = SlotGroupConfigByGroupId.GlobalSlotGroupConfig,
    SlotGroupConfigByGroupId = SlotGroupConfigByGroupId.SlotGroupConfigByGroupId,
    getSlotGroupConfig = SlotGroupConfigByGroupId.getSlotGroupConfig,
    GlobalSlotConfig = SlotConfigBySlotId.GlobalSlotConfig,
    SlotConfigBySlotId = SlotConfigBySlotId.SlotConfigBySlotId,
    getSlotConfig = SlotConfigBySlotId.getSlotConfig,
    GetNotificationsStore = GetNotificationsStore
}

function module.submit(arg1)
    return GetNotificationsStore(false).submit(arg1)
end

function module.revoke(arg1)
    GetNotificationsStore(false).revoke(arg1)
end

function module.report(arg1, arg2, arg3)
    GetNotificationsStore(false).report(arg1, arg2, arg3)
end

function module.getActiveForSlot(arg1)
    return GetNotificationsStore(false).getActiveForSlot(arg1)
end

function module.setInExperienceShopOpen(bool1: boolean)
    GetNotificationsStore(false).setInExperienceShopOpen(bool1)
end

module.Flags = {
    FFlagEnableNotificationsOrchestratorUnifiedLogging = FFlagEnableNotificationsOrchestratorUnifiedLogging
}

module["jest.config"] = script["jest.config"]
return module
