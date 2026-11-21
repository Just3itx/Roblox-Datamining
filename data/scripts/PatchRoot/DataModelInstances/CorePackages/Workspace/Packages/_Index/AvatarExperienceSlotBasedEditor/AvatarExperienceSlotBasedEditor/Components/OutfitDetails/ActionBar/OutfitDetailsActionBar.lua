-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")
local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)

local Constants = require(AvatarExperienceSlotBasedEditor.Constants)

local function OutfitDetailsActionBar(tbl1)
    return React.createElement(
        Foundation.View,
        {
            tag = "col bg-surface-0",
            Size = UDim2.new(1, 0, 0, Constants.ActionBarHeight),
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            Divider = React.createElement(Foundation.Divider, { LayoutOrder = 1 }),
            Buttons = React.createElement(
                Foundation.View,
                {
                    tag = "row align-x-right align-y-center fill gap-small size-full-0 padding-x-medium",
                    LayoutOrder = 2
                },
                {
                    RenameButton = React.createElement(Foundation.Button, {
                        text = tbl1.renameText,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        size = Foundation.Enums.ButtonSize.Medium,
                        onActivated = tbl1.onRenameOutfit,
                        LayoutOrder = 1
                    }),
                    DeleteButton = React.createElement(Foundation.Button, {
                        text = tbl1.deleteText,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        size = Foundation.Enums.ButtonSize.Medium,
                        onActivated = tbl1.onDeleteOutfit,
                        LayoutOrder = 2
                    })
                }
            )
        }
    )
end
return OutfitDetailsActionBar
