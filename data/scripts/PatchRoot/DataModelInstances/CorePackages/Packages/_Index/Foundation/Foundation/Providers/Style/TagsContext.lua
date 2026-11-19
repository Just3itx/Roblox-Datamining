-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Logger = require(Foundation.Utility.Logger)
return (require(FoundationParent.React).createContext(function(): string
    Logger:warning("No Style Provider found")
    return ""
end))
