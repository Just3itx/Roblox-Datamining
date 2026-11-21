-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CredentialsProtocol = require(script.CredentialsProtocol)
local Constants = require(script.Constants)
local _CredentialsProtocolTypes = require(script.CredentialsProtocolTypes)
local CredentialsProtocolErrorCodes = require(script.CredentialsProtocolErrorCodes)
local getCredentialsTimeoutSeconds = require(script.getCredentialsTimeoutSeconds)

local FFlagCacheCredentialsProtocolIsAvailable = require(script.Flags.FFlagCacheCredentialsProtocolIsAvailable)
local GetFFlagLuaAppEnableCredentialsProtocol = require(script.Flags.GetFFlagLuaAppEnableCredentialsProtocol)
local GetFIntLuaAppCredentialsProtocolTimeout = require(script.Flags.GetFIntLuaAppCredentialsProtocolTimeout)

local GetFIntLuaAppCredentialsProtocolAvailableTimeout = require(script.Flags.GetFIntLuaAppCredentialsProtocolAvailableTimeout)
local FFlagLuaAppNormalizeUnifiedPasskeyResponse = require(script.Flags.FFlagLuaAppNormalizeUnifiedPasskeyResponse)

return {
    Constants = Constants,
    CredentialsProtocol = CredentialsProtocol,
    CredentialsProtocolErrorCodes = CredentialsProtocolErrorCodes,
    getCredentialsTimeoutSeconds = getCredentialsTimeoutSeconds,
    ["jest.config"] = script["jest.config"],
    Flags = {
        FFlagCacheCredentialsProtocolIsAvailable = FFlagCacheCredentialsProtocolIsAvailable,
        GetFFlagLuaAppEnableCredentialsProtocol = GetFFlagLuaAppEnableCredentialsProtocol,
        GetFIntLuaAppCredentialsProtocolTimeout = GetFIntLuaAppCredentialsProtocolTimeout,
        GetFIntLuaAppCredentialsProtocolAvailableTimeout = GetFIntLuaAppCredentialsProtocolAvailableTimeout,
        FFlagLuaAppNormalizeUnifiedPasskeyResponse = FFlagLuaAppNormalizeUnifiedPasskeyResponse
    }
}
