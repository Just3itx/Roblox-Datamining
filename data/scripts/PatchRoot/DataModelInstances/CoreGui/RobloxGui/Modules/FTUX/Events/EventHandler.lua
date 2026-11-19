-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)
local VRFTUXEventHandler = require(scriptParentParent.Events.VR.VRFTUXEventHandler)
local Events = require(scriptParentParent.Events.Events)

local tbl1 = {
    [PlatformEnum.QuestVR] = VRFTUXEventHandler
}

local module = {}

function module.StartEvents(arg1, num1: number, func1: (...any) -> (...any))
    local var1 = tbl1[arg1]

    local var2 = Events[arg1][num1]
    if not var2 then
        return
    end

    for _, value in pairs(var2) do
        var1.StartEvent(value, func1)
    end
end

function module.StopEvents(arg1, num1: number)
    local var1 = tbl1[arg1]

    local var2 = Events[arg1][num1]
    if not var2 then
        return
    end

    for _, value in pairs(var2) do
        var1.StopEvent(value)
    end
end

return module
