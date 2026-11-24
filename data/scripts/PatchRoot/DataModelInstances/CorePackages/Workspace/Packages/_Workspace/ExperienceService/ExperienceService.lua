-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameProtocol = require(script.GameProtocol)
local ExperienceServiceWrapper = require(script.ExperienceServiceWrapper)
local _GameProtocolTypes = require(script.GameProtocolTypes)

local GetFFlagMoveLuaExpLaunchBegin = require(script.Flags.GetFFlagMoveLuaExpLaunchBegin)

return {
    GameProtocol = GameProtocol,
    GameParams = require(script.GameParams),
    ExperienceService = ExperienceServiceWrapper,
    Flags = { GetFFlagMoveLuaExpLaunchBegin = GetFFlagMoveLuaExpLaunchBegin }
}
