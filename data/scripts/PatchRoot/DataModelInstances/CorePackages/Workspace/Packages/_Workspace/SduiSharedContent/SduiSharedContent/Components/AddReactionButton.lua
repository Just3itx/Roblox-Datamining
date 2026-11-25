-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)
local Reactions = require(SduiSharedContentParent.Reactions)

local IconButton = Foundation.IconButton
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local PopoverAlign = Foundation.Enums.PopoverAlign

local function AddReactionButton(tbl1)
    local isOpen, var2 = React.useState(false)
    local var3 = React.useRef(nil)

    local onDismiss = React.useCallback(function()
        var2(false)
    end, {})

    local onActivated = React.useCallback(function()
        var2(function(bool1: boolean): boolean
            return not bool1
        end)
    end, {})

    return React.createElement(React.Fragment, nil, {
        Button = React.createElement(IconButton, {
            icon = IconName.SquareFaceEmoji,
            isCircular = true,
            variant = ButtonVariant.Utility,
            onActivated = onActivated,
            LayoutOrder = tbl1.layoutOrder,
            ref = var3,
            testId = "reaction-add"
        }),
        Picker = React.createElement(Reactions.ReactionPickerPopover, {
            isOpen = isOpen,
            anchorRef = var3,
            align = PopoverAlign.Start,
            reactions = tbl1.reactions,
            selectedReactions = tbl1.selectedReactions,
            onReactionSelected = function(arg1) -- name: selectReaction
                onDismiss()
                tbl1.onReactionSelected(arg1)
            end,
            onDismiss = onDismiss
        })
    })
end

return AddReactionButton
