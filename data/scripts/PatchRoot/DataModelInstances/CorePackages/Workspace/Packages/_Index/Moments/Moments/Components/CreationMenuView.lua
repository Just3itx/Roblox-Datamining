-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local PlusLarge = BuilderIcons.Icon.PlusLarge

local IconButton = Foundation.IconButton
local Menu = Foundation.Menu

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function CreationMenuView(tbl1)
    return React.createElement(Menu, {
        align = Foundation.Enums.PopoverAlign.End,
        isOpen = tbl1.isOpen,
        items = tbl1.items,
        LayoutOrder = tbl1.layoutOrder,
        onPressedOutside = tbl1.onPressedOutside,
        ref = tbl1.menuRef,
        side = Foundation.Enums.PopoverSide.Bottom,
        testId = tbl1.testId
    }, {
        Trigger = React.createElement(IconButton, {
            LayoutOrder = tbl1.layoutOrder,
            icon = PlusLarge,
            onActivated = tbl1.onToggle,
            variant = tbl1.buttonVariant or ButtonVariant.Utility,
            size = InputSize.Medium,
            isCircular = true,
            Selectable = true,
            testId = tbl1.buttonTestId or "--moments-creation-menu-button"
        })
    })
end

return CreationMenuView
