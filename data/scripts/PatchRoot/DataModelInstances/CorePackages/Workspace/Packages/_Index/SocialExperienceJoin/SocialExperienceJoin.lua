-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script["jest.config"],
    installReducer = require(script.Rodux.installReducer),
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    PurchaseExperienceModal = require(script.Components.PurchaseExperienceModal),
    UnableToJoinExperienceModal = require(script.Components.UnableToJoinExperienceModal),
    useJoinUserInExperience = require(script.Hooks.useJoinUserInExperience)
}
