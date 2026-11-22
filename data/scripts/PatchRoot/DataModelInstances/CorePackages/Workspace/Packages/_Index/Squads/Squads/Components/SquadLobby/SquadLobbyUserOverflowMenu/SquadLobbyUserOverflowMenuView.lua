-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local React = require(SquadsParent.React)
local Foundation = require(SquadsParent.Foundation)
local BuilderIcons = require(SquadsParent.BuilderIcons)

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local function SquadLobbyUserOverflowMenuView(tbl1)
    local var1 = Foundation.Hooks.useTokens()

    if #tbl1.items == 0 then
        return nil
    end

    return React.createElement(Foundation.Menu, {
        isOpen = tbl1.isOpen,
        items = tbl1.items,
        size = InputSize.Medium,
        side = PopoverSide.Bottom,
        align = PopoverAlign.End,
        onPressedOutside = tbl1.onClose,
        ref = tbl1.menuRef,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -var1.Padding.Small, 0, var1.Padding.Small),
        ZIndex = 5,
        testId = `{tbl1.testId}--menu`
    }, {
        Trigger = React.createElement(Foundation.IconButton, {
            icon = BuilderIcons.Icon.ThreeDotsHorizontal,
            isCircular = true,
            size = InputSize.Small,
            variant = ButtonVariant.Utility,
            onActivated = tbl1.onTriggerActivated,
            testId = `{tbl1.testId}--trigger`
        })
    })
end

return SquadLobbyUserOverflowMenuView
