-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)

local _SystemInfoProtocolTypes = require(script.Parent.SystemInfoProtocolTypes)

local module = {
    GET_SYSTEM_INFO_DESCRIPTOR = {
        fid = MessageBus.getMessageId("SystemInfo", "getSystemInfo"),
        validateParams = t.table
    }
}

module.InfoNames = {
    MANUFACTURER = "manufacturer",
    DEVICE_NAME = "deviceName",
    MAX_MEMORY = "maxMemory",
    MAX_RESOLUTION = "maxResolution",
    BASE_OS = "baseOs",
    SYSTEM_VERSION = "systemVersion",
    APP_VERSION = "appVersion",
    CPU_MAKE = "cpuMake",
    IS_64BIT = "is64bit",
    CPU_LOGICAL_COUNT = "cpuLogicalCount",
    CPU_CORE_COUNT = "cpuCoreCount",
    CPU_PHYS_COUNT = "cpuPhysCount",
    CPU_SPEED = "cpuSpeed",
    GPU = "GPU",
    AVAIL_RAM = "availRAM",
    NETWORK_TYPE = "networkType",
    BATTERY_LEVEL = "batteryLevel",
    THERMAL_STATUS = "thermalStatus"
}

module.ALL_INFO_NAMES = {
    module.InfoNames.MANUFACTURER,
    module.InfoNames.DEVICE_NAME,
    module.InfoNames.MAX_MEMORY,
    module.InfoNames.MAX_RESOLUTION,
    module.InfoNames.BASE_OS,
    module.InfoNames.SYSTEM_VERSION,
    module.InfoNames.APP_VERSION,
    module.InfoNames.CPU_MAKE,
    module.InfoNames.IS_64BIT,
    module.InfoNames.CPU_LOGICAL_COUNT,
    module.InfoNames.CPU_CORE_COUNT,
    module.InfoNames.CPU_PHYS_COUNT,
    module.InfoNames.CPU_SPEED,
    module.InfoNames.GPU,
    module.InfoNames.AVAIL_RAM,
    module.InfoNames.NETWORK_TYPE
}

if game:GetEngineFeature("NewSystemInfoFeaturesEnabled") then
    table.insert(module.ALL_INFO_NAMES, module.InfoNames.BATTERY_LEVEL)
    table.insert(module.ALL_INFO_NAMES, module.InfoNames.THERMAL_STATUS)
end

module.__index = module

function module.new(messageBus)
    return (setmetatable({ messageBus = messageBus or MessageBus }, module))
end

function module:getSystemInfo(arg1)
    return self.messageBus.call(self.GET_SYSTEM_INFO_DESCRIPTOR, arg1)
end

module.default = module.new()

return module
