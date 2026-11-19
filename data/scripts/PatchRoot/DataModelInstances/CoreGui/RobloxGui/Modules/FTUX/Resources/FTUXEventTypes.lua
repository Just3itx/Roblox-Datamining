-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
return {
    [require(scriptParentParent.Enums.PlatformEnum).QuestVR] = {
        FirstPersonToggleEvent = "FirstPersonToggleEvent",
        MoveToGoalEvent = "MoveToGoalEvent",
        HapticFeedbackEvent = "HapticFeedbackEvent",
        HapticFeedbackTwiceEvent = "HapticFeedbackTwiceEvent",
        SoundFeedbackEvent = "SoundFeedbackEvent",
        JumpEvent = "JumpEvent",
        PerspectiveTooltipEvent = "PerspectiveTooltipEvent",
        MovementTooltipEvent = "MovementTooltipEvent",
        LeaveGameIconHighlightEvent = "LeaveGameIconHighlightEvent"
    }
}
