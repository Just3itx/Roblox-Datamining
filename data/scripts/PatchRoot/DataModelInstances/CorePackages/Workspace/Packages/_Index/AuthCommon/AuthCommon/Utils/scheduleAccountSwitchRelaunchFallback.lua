-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Promise = require(AuthCommonParent.Promise)
local GetFIntAccountSwitchRelaunchFallbackSeconds = require(AuthCommonParent.SharedFlags).GetFIntAccountSwitchRelaunchFallbackSeconds

local function scheduleAccountSwitchRelaunchFallback(callback: (...any) -> (...any), tbl1)
    return ((tbl1 or {}).delay or Promise.delay)(GetFIntAccountSwitchRelaunchFallbackSeconds()):andThen(function()
        callback()
    end)
end

return scheduleAccountSwitchRelaunchFallback
