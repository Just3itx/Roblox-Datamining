-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:55Z
-- Luau bytecode version: 9 | Luau type version: 3
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _Types = require(script.Parent.Types)

local context = React.createContext(nil)
context.displayName = "WidgetsContext"

return context
