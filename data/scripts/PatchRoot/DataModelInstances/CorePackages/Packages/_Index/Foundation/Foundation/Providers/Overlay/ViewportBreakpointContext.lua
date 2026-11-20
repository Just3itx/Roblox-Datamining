-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)

return React.createContext(nil)
