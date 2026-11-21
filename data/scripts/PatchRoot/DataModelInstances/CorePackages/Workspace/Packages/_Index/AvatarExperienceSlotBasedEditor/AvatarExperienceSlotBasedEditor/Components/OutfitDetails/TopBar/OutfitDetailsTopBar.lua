-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function OutfitDetailsTopBar(tbl1)
    return React.createElement(
        Foundation.View,
        {
            tag = "col size-full-0 auto-y bg-surface-0",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            StatusBarSpacer = React.createElement(
                Foundation.View,
                {
                    Size = UDim2.new(1, 0, 0, tbl1.statusBarHeight),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                }
            ),
            ButtonRow = React.createElement(
                Foundation.View,
                { tag = "row align-y-center size-full-0 auto-y padding-medium", LayoutOrder = 2 },
                {
                    CloseButton = React.createElement(Foundation.IconButton, {
                        testId = "OutfitDetailsExitButton",
                        LayoutOrder = 1,
                        size = InputSize.Small,
                        icon = Foundation.Enums.IconName.X,
                        isCircular = true,
                        variant = ButtonVariant.Standard,
                        onActivated = tbl1.onClose
                    })
                }
            )
        }
    )
end

return OutfitDetailsTopBar
