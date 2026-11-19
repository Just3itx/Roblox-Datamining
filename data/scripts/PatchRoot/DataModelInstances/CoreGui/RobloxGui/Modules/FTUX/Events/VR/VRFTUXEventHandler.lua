-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local FirstPersonToggleEvent = require(scriptParentParentParent.Events.VR.FirstPersonToggleEvent)
local HapticFeedbackEvent = require(scriptParentParentParent.Events.VR.HapticFeedbackEvent)
local HapticFeedbackTwiceEvent = require(scriptParentParentParent.Events.VR.HapticFeedbackTwiceEvent)
local SoundFeedbackEvent = require(scriptParentParentParent.Events.VR.SoundFeedbackEvent)
local JumpEvent = require(scriptParentParentParent.Events.VR.JumpEvent)
local MoveToGoalEvent = require(scriptParentParentParent.Events.VR.MoveToGoalEvent)
local PerspectiveTooltipEvent = require(scriptParentParentParent.Events.VR.PerspectiveTooltipEvent)
local MovementTooltipEvent = require(scriptParentParentParent.Events.VR.MovementTooltipEvent)
local LeaveGameIconHighlightEvent = require(scriptParentParentParent.Events.VR.LeaveGameIconHighlightEvent)

local PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)
local FTUXEventTypes = require(scriptParentParentParent.Resources.FTUXEventTypes)
local _EventType = require(script.Parent.Parent.EventType)

local var1 = FTUXEventTypes[PlatformEnum.QuestVR]

local module = { Name = "VRFTUXEventHandler" }

function module.StartEvent(arg1, func1: (...any) -> (...any))
    if arg1 == var1.FirstPersonToggleEvent then
        task.spawn(FirstPersonToggleEvent.StartEvent, func1)
    elseif arg1 == var1.MoveToGoalEvent then
        task.spawn(MoveToGoalEvent.StartEvent, func1)
    elseif arg1 == var1.JumpEvent then
        task.spawn(JumpEvent.StartEvent, func1)
    elseif arg1 == var1.PerspectiveTooltipEvent then
        task.spawn(PerspectiveTooltipEvent.StartEvent)
    elseif arg1 == var1.MovementTooltipEvent then
        task.spawn(MovementTooltipEvent.StartEvent)
    elseif arg1 == var1.HapticFeedbackEvent then
        task.spawn(HapticFeedbackEvent.StartEvent)
    elseif arg1 == var1.SoundFeedbackEvent then
        task.spawn(SoundFeedbackEvent.StartEvent)
    elseif arg1 == var1.HapticFeedbackTwiceEvent then
        task.spawn(HapticFeedbackTwiceEvent.StartEvent)
    elseif arg1 == var1.LeaveGameIconHighlightEvent then
        task.spawn(LeaveGameIconHighlightEvent.StartEvent)
    else
        warn("Unmapped VRFTUX event type: " .. tostring(arg1))
    end
end

function module.StopEvent(arg1)
    if arg1 == var1.FirstPersonToggleEvent then
        task.spawn(FirstPersonToggleEvent.StopEvent)
    elseif arg1 == var1.MoveToGoalEvent then
        task.spawn(MoveToGoalEvent.StopEvent)
    elseif arg1 == var1.JumpEvent then
        task.spawn(JumpEvent.StopEvent)
    elseif arg1 == var1.PerspectiveTooltipEvent then
        task.spawn(PerspectiveTooltipEvent.StopEvent)
    elseif arg1 == var1.MovementTooltipEvent then
        task.spawn(MovementTooltipEvent.StopEvent)
    elseif arg1 == var1.LeaveGameIconHighlightEvent then
        task.spawn(LeaveGameIconHighlightEvent.StopEvent)
    elseif arg1 ~= var1.HapticFeedbackTwiceEvent and arg1 ~= var1.HapticFeedbackEvent and arg1 ~= var1.SoundFeedbackEvent then
        warn("Unmapped VRFTUX event type: " .. tostring(arg1))
    end
end

return module
