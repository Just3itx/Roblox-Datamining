-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.Enums.EventNames)

return {
    [EventNames.EditProfileBackgroundOpened] = {
        name = game:DefineFastString("EditProfileBackgroundOpened", "EditProfileBackgroundOpened")
    },
    [EventNames.EditProfileBackgroundLoadingStage] = {
        name = game:DefineFastString("EditProfileBackgroundLoadingStage", "EditProfileBackgroundLoadingStage")
    },
    [EventNames.BackgroundSelected] = {
        name = game:DefineFastString("BackgroundSelected", "BackgroundSelected")
    },
    [EventNames.EditProfileBackgroundFailure] = {
        name = game:DefineFastString("EditProfileBackgroundFailure", "EditProfileBackgroundFailure")
    }
}
