-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthenticationStatusParent = script:FindFirstAncestor("AuthenticationStatus").Parent
return require(AuthenticationStatusParent.Rodux).makeActionCreator(script.Name, function(status)
    return { status = status }
end)
