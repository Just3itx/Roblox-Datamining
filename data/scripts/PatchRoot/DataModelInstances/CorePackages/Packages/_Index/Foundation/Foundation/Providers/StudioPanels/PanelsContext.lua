-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _Types = require(script.Parent.Types)

local context = React.createContext(nil)
context.displayName = "PanelsContext"

return context
