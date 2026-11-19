-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator("RECEIVED_USER_INVITE_STATUS", function(arg1, inviteStatus)
    return {
        userId = tostring(arg1),
        inviteStatus = inviteStatus
    }
end)
