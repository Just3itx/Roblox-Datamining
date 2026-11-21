-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local isIosAuthServiceEnabled = require(AuthCommon.Utils.isIosAuthServiceEnabled)

local function shouldSkipLegacyPasswordSaveEvent(bool1: boolean)
    return bool1 and isIosAuthServiceEnabled()
end

return shouldSkipLegacyPasswordSaveEvent
