-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local ButtonEnum = require(scriptParentParent.Enums.ButtonEnum)
return {
    [require(scriptParentParent.Enums.PlatformEnum).QuestVR] = {
        {
            title = "CoreScripts.VRFTUX.Heading.Perspective",
            text = { "CoreScripts.VRFTUX.Description.Perspective.Body1", "CoreScripts.VRFTUX.Description.Perspective.Body2" },
            image = "rbxassetid://13251804809",
            button = ButtonEnum.SkipButton
        },
        {
            title = "CoreScripts.VRFTUX.Heading.Movement",
            text = { "CoreScripts.VRFTUX.Description.Movement.Body1", "CoreScripts.VRFTUX.Description.Movement.Body2", "CoreScripts.VRFTUX.Description.Movement.Body3" },
            image = "rbxassetid://13251750527",
            button = ButtonEnum.SkipButton
        },
        {
            title = "CoreScripts.VRFTUX.Heading.SafetyBubble.Title",
            text = { "CoreScripts.VRFTUX.Description.SafetyBubble.Body1", "CoreScripts.VRFTUX.Description.SafetyBubble.Body2" },
            image = "rbxassetid://13251806846",
            button = ButtonEnum.NextButton
        },
        {
            title = "CoreScripts.VRFTUX.Heading.OtherSettings.Title",
            text = { "CoreScripts.VRFTUX.Description.OtherSettings.Body1", "CoreScripts.VRFTUX.Description.OtherSettings.Body2" },
            image = "",
            button = ButtonEnum.NextButton
        }
    }
}
