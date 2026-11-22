-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.Enums.EventNames)

return {
    [EventNames.CustomizeNameModalOpened] = {
        name = game:DefineFastString("CustomizeNameModalOpened", "CustomizeNameModalOpened")
    },
    [EventNames.CustomizeNameClearedInput] = {
        name = game:DefineFastString("CustomizeNameClearedInput", "CustomizeNameClearedInput")
    },
    [EventNames.CustomizeNameMaximumCharLimitTyped] = {
        name = game:DefineFastString("CustomizeNameMaximumCharLimitTyped", "CustomizeNameMaximumCharLimitTyped")
    },
    [EventNames.CustomizeNameModalClosed] = {
        name = game:DefineFastString("CustomizeNameModalClosed", "CustomizeNameModalClosed")
    },
    [EventNames.CustomizeNameSaved] = {
        name = game:DefineFastString("CustomizeNameSaved", "CustomizeNameSaved")
    },
    [EventNames.CustomizeNameSaveAttemptInvalidInput] = {
        name = game:DefineFastString("CustomizeNameSaveAttemptInvalidInput", "CustomizeNameSaveAttemptInvalidInput")
    }
}
