-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthenticationStatus = script:FindFirstAncestor("AuthenticationStatus")
local AuthenticationStatusParent = AuthenticationStatus.Parent
local LoginStatus = require(AuthenticationStatusParent.RobloxAppEnums).LoginStatus
local SetAuthenticationStatus = require(AuthenticationStatus.Actions.SetAuthenticationStatus)
local Cryo = require(AuthenticationStatusParent.Cryo)

return function(arg1, arg2)
    arg1 = arg1 or {
        status = LoginStatus.UNKNOWN
    }

    if arg2.type == SetAuthenticationStatus.name then
        arg1 = Cryo.Dictionary.join(arg1, { status = arg2.status })
    end

    return arg1
end
