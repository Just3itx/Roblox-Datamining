-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)

local useUndoRedoBarViewModel = require(script.Parent.useUndoRedoBarViewModel)
local IconOnlyMenu = require(AvatarExperienceControlBar.Components.IconOnlyMenu)
local BaseControlBarContainer = require(AvatarExperienceControlBar.BaseControlBarContainer)

local FFlagAXResetAvatarButton = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXResetAvatarButton

return React.memo(function(tbl1) -- name: UndoRedoBarContainer
    local var1 = useUndoRedoBarViewModel()
    if FFlagAXResetAvatarButton then
        return (React.createElement(BaseControlBarContainer, {
            config = var1.items,
            onActiveMenuItemChanged = function() end,
            LayoutOrder = tbl1.LayoutOrder
        }))
    end

    return (React.createElement(IconOnlyMenu, {
        items = var1.items,
        direction = if tbl1.direction then tbl1.direction else "horizontal",
        LayoutOrder = tbl1.LayoutOrder
    }))
end)
