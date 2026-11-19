-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:54Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local InputSize = require(Foundation.Enums.InputSize)

return React.createContext({
    hasDivider = false,
    isContained = false,
    isInset = false,
    hasMargin = false,
    lastLayoutOrder = 0,
    size = InputSize.Medium,
    testId = ""
})
