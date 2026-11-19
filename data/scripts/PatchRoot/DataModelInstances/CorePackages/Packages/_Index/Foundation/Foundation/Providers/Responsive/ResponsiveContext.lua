-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:28Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BreakpointConfig = require(Foundation.Utility.Responsive.BreakpointConfig)
local GridConfig = require(Foundation.Utility.Responsive.GridConfig)
return require(FoundationParent.React).createContext({ config = { breakpoint = BreakpointConfig, grid = GridConfig } })
