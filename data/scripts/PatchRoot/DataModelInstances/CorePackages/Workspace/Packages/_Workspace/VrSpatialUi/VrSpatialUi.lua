-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Constants)
local isInExperienceUIVREnabled = require(script.Parent.SharedExperimentDefinition).isInExperienceUIVREnabled

return {
    UIManager = require(script.UIManager),
    Constants = Constants,
    registerRoactPanel = require(script.registerRoactPanel),
    Panel3DInSpatialUI = if isInExperienceUIVREnabled then require(script.Panel3DInSpatialUI) else nil,
    VrEnvironmentScene = require(script.VrEnvironmentScene),
    ["jest.config"] = script["jest.config"]
}
