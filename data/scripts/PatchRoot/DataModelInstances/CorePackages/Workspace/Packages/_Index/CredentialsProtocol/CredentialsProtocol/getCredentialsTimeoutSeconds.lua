-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)

local function getCredentialsTimeoutSeconds(num1: number?)
    return if typeof(num1) == "number" and not (num1 <= 0) then num1 / 1000 else Constants.Defaults.CREDENTIALSPROTOCOL_GETCREDENTIALS_DEFAULTTIMEOUT
end

return getCredentialsTimeoutSeconds
