-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.EventNames)

return {
    [EventNames.CapturesActivatedInGameMenu] = {
        name = game:DefineFastString("CapturesActivatedInGameMenu", "CapturesActivatedInGameMenu")
    },
    [EventNames.CapturesCarouselOpened] = {
        name = game:DefineFastString("CapturesCarouselOpened", "CapturesCarouselOpened")
    },
    [EventNames.CapturesDeactivatedInGameMenu] = {
        name = game:DefineFastString("CapturesDeactivatedInGameMenu", "CapturesDeactivatedInGameMenu")
    },
    [EventNames.CapturesEntrypointActivated] = {
        name = game:DefineFastString("CapturesEntrypointActivated", "CapturesEntrypointActivated")
    },
    [EventNames.CapturesPageOpenedInGameMenu] = {
        name = game:DefineFastString("CapturesPageOpenedInGameMenu", "CapturesPageOpenedInGameMenu")
    },
    [EventNames.CapturesShareFromNonStandardServer] = {
        name = game:DefineFastString("CapturesShareToastButtonActivated", "CapturesShareToastButtonActivated")
    },
    [EventNames.CapturesShareToastButtonActivated] = {
        name = game:DefineFastString("CapturesShareToastButtonActivated", "CapturesShareToastButtonActivated")
    },
    [EventNames.ShareCaptureGenerateLinkFailed] = {
        name = game:DefineFastString("ShareCaptureGenerateLinkFailed", "ShareCaptureGenerateLinkFailed")
    },
    [EventNames.ShareCapturePromptAccepted] = {
        name = game:DefineFastString("ShareCapturePromptAccepted", "ShareCapturePromptAccepted")
    },
    [EventNames.ShareCapturePromptRejected] = {
        name = game:DefineFastString("ShareCapturePromptRejected", "ShareCapturePromptRejected")
    }
}
