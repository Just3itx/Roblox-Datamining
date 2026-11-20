-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Constants = require(Foundation.Constants)
local _DialogSize = require(Foundation.Enums.DialogSize)
local _React = require(FoundationParent.React)

return {
    nonSelectable = Constants.MODAL.DISABLE_SELECTION,
    isolatedSelectionGroup = Constants.MODAL.TRAP_FOCUS
}
