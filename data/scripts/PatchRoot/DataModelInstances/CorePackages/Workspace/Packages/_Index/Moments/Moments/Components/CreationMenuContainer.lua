-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local CreationMenuView = require(Moments.Components.CreationMenuView)
local useCreationMenuViewModel = require(Moments.Components.useCreationMenuViewModel)

local _ButtonVariant = Foundation.Enums.ButtonVariant

local function CreationMenuContainer(tbl1)
    local var1 = useCreationMenuViewModel({
        onCreateFromCaptures = tbl1.onCreateFromCaptures,
        onCreateFromAvatar = tbl1.onCreateFromAvatar,
        onTriggerActivated = tbl1.onTriggerActivated
    })

    return React.createElement(CreationMenuView, {
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId,
        buttonTestId = tbl1.buttonTestId,
        buttonVariant = tbl1.buttonVariant,
        isOpen = var1.isOpen,
        items = var1.items,
        menuRef = var1.menuRef,
        onToggle = var1.onToggle,
        onPressedOutside = var1.onPressedOutside
    })
end

return CreationMenuContainer
