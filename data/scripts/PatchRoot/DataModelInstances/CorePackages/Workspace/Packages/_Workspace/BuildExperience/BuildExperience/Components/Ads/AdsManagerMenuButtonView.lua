-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local IconButton = Foundation.IconButton
local Menu = Foundation.Menu

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local function AdsManagerMenuButtonView(tbl1)
    return React.createElement(Menu, {
        LayoutOrder = tbl1.layoutOrder,
        align = PopoverAlign.End,
        isOpen = tbl1.isMenuOpen,
        items = tbl1.menuItems,
        onActivated = tbl1.onItemActivated,
        onPressedOutside = tbl1.onCloseMenu,
        side = PopoverSide.Bottom,
        size = tbl1.menuSize,
        testId = `{tbl1.testId}.Menu`,
        width = UDim.new(0, tbl1.menuWidth)
    }, {
        Button = React.createElement(IconButton, {
            icon = IconName.ThreeDotsHorizontal,
            isCircular = true,
            onActivated = tbl1.onToggleMenu,
            size = tbl1.buttonSize,
            testId = `{tbl1.testId}.Button`,
            variant = ButtonVariant.Utility
        })
    })
end

return AdsManagerMenuButtonView
