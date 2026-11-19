-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:57Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _InputPlacement = require(Foundation.Enums.InputPlacement)
local _InputSize = require(Foundation.Enums.InputSize)

return (React.createContext({ size = nil, placement = nil }))
