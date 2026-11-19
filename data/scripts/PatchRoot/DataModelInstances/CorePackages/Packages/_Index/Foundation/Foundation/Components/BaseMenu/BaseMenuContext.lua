-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:53Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local InputSize = require(Foundation.Enums.InputSize)

return (React.createContext({
    onActivated = nil,
    onNestedLeafActivated = nil,
    size = InputSize.Medium,
    hasLeading = nil,
    setHasLeading = nil,
    hoverOpenPath = {},
    hoverOpenAtDepth = nil,
    hoverCloseAtDepth = nil,
    hoverReset = nil,
    depth = 1,
    maxHeight = nil
}))
