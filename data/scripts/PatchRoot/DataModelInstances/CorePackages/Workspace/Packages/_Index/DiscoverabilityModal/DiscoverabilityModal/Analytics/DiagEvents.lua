-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.Enums.EventNames)

return {
    [EventNames.DiscoverabilityModalLoad] = {
        name = game:DefineFastString("DiscoverabilityModalLoadCounter", "DiscoverabilityModalLoad")
    },
    [EventNames.DiscoverabilityModalContinue] = {
        name = game:DefineFastString("DiscoverabilityModalContinueCounter", "DiscoverabilityModalContinue")
    },
    [EventNames.DiscoverabilityModalClose] = {
        name = game:DefineFastString("DiscoverabilityModalCloseCounter", "DiscoverabilityModalClose")
    },
    [EventNames.DiscoverabilityModalRadioButtonClick] = {
        name = game:DefineFastString("DiscoverabilityModalRadioButtonClickCounter", "DiscoverabilityModalRadioButtonClick")
    }
}
