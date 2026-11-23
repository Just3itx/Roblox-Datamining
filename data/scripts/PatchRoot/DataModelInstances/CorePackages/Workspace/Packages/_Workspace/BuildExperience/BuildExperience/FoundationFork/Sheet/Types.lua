-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local Constants = require(Foundation.Constants)
local _DialogSize = require(Foundation.Enums.DialogSize)
local _React = require(FoundationParent.React)

return {
    nonSelectable = Constants.MODAL.DISABLE_SELECTION,
    isolatedSelectionGroup = Constants.MODAL.TRAP_FOCUS
}
