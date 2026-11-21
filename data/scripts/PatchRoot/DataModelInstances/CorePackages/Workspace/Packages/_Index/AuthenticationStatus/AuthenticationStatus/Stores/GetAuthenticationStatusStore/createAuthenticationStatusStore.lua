-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthenticationStatusParent = script:FindFirstAncestor("AuthenticationStatus").Parent

local Signals = require(AuthenticationStatusParent.Signals)
local UNKNOWN = require(AuthenticationStatusParent.RobloxAppEnums).LoginStatus.UNKNOWN

local function createAuthenticationStatusStore()
    local getStatus, var2 = Signals.createSignal(UNKNOWN)

    return {
        getStatus = getStatus,
        setAuthenticationStatus = function(arg1)
            var2(arg1)
        end,
        reset = function()
            var2(UNKNOWN)
        end
    }
end
return createAuthenticationStatusStore
