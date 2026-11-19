-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)
local var1 = require(scriptParentParent.Resources.FTUXEventTypes)[PlatformEnum.QuestVR]

return {
    [PlatformEnum.QuestVR] = {
        { var1.PerspectiveTooltipEvent, var1.FirstPersonToggleEvent, var1.HapticFeedbackEvent },
        {
            var1.MovementTooltipEvent,
            var1.MoveToGoalEvent,
            var1.SoundFeedbackEvent,
            var1.HapticFeedbackTwiceEvent
        },
        { var1.HapticFeedbackEvent, var1.SoundFeedbackEvent },
        { var1.SoundFeedbackEvent, var1.LeaveGameIconHighlightEvent }
    }
}
