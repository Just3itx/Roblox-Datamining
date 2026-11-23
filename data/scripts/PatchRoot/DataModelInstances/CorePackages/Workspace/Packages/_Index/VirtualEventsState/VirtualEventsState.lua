-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local installReducer = require(script.installReducer)
local _types = require(script.types)
return {
    RoduxKey = "VirtualEvents",
    installReducer = installReducer,
    enums = require(script.enums),
    network = require(script.network),
    ExperienceDetailsModel = require(script.Models.ExperienceDetailsModel),
    ExperienceMediaModel = require(script.Models.ExperienceMediaModel),
    ["jest.config"] = script["jest.config"]
}
