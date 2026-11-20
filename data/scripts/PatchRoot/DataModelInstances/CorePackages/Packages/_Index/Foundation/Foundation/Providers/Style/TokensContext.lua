-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local _Tokens = require(scriptParent.Tokens)

return (require(FoundationParent.React).createContext({}))
