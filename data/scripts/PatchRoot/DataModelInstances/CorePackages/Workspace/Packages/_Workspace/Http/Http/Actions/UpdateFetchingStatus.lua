-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpParent = script:FindFirstAncestor("Http").Parent

return require(HttpParent.Rodux).makeActionCreator(script.Name, function(key, status)
    return { key = key, status = status }
end)
