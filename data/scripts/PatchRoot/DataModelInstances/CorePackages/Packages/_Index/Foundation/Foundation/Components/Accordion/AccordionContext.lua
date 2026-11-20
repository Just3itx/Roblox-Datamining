-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local InputPlacement = require(Foundation.Enums.InputPlacement)
local InputSize = require(Foundation.Enums.InputSize)
return require(FoundationParent.React).createContext({
    onAccordionItemActivated = nil,
    itemSize = InputSize.Medium,
    isContained = false,
    chevronPosition = InputPlacement.End,
    testId = ""
})
