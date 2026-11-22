-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local IconButton = Foundation.IconButton

local useTextAlignmentButtonState = require(MomentsCreation.Components.TextOverlay.useTextAlignmentButtonState)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function TextAlignmentButton(tbl1)
    local var1 = useTextAlignmentButtonState(tbl1.controller)

    return React.createElement(IconButton, {
        LayoutOrder = tbl1.LayoutOrder,
        icon = var1.icon,
        onActivated = var1.onActivated,
        size = Foundation.Enums.InputSize.Medium
    })
end

return TextAlignmentButton
