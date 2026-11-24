-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local SessionServiceWrapper = require(scriptParent.SessionizationUtil).SessionServiceWrapper

local SessionType = require(script.SessionType)
local ExperienceMenuSessionManagerInstance = require(script.ExperienceMenuSessionManager).new(SessionServiceWrapper)

return {
    ["jest.config"] = script["jest.config"],
    SessionType = SessionType,
    ExperienceMenuSessionManagerInstance = ExperienceMenuSessionManagerInstance
}
