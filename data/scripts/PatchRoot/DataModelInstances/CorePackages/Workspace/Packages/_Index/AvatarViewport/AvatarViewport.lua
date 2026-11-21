-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _Types = require(script.Types)

return {
    ["jest.config"] = script["jest.config"],
    CameraMath = require(script.CameraMath),
    Constants = require(script.Constants),
    ModelSources = {
        fromUserId = require(script.ModelSources.createUserIdModelSource),
        fromUserIdWithRigType = require(script.ModelSources.createUserIdRigTypeModelSource)
    },
    useRotatableOrbitViewport = require(script.Hooks.useRotatableOrbitViewport),
    useAvatarViewportScene = require(script.Hooks.useAvatarViewportScene),
    useViewportModelLoader = require(script.Hooks.useViewportModelLoader),
    useViewportOrbitInteractions = require(script.Hooks.useViewportOrbitInteractions),
    useViewportGamepadOrbit = require(script.Hooks.useViewportGamepadOrbit),
    useOrbitHeadCamera = require(script.Hooks.useOrbitHeadCamera),
    AvatarViewportScene = require(script.Components.AvatarViewportScene),
    ViewportInteractionOverlay = require(script.Components.ViewportInteractionOverlay)
}
