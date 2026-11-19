-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:42Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)

local context = React.createContext(Flags.FoundationPopoverPluginOverlayMeasurement and { id = nil, ready = true } or nil)
context.displayName = "PluginPopoverParentContext"

return context
