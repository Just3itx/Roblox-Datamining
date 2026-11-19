-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

return require(FoundationParent.React).createContext({
    requestOverlay = function() end,
    instance = nil,
    screen = nil
})
