-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")
local UserInputService = game:GetService("UserInputService")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)

local IconOnlyMenu = require(AvatarExperienceControlBar.Components.IconOnlyMenu)
local IconTextMenu = require(AvatarExperienceControlBar.Components.IconTextMenu)
local ExternalEventConnection = require(AvatarExperienceControlBarParent.RoactUtils).ExternalEventConnection

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)

return React.memo(function(arg1) -- name: BaseControlBar
    local var1, var2 = React.useBinding(UDim2.new(0, 0, 0, 0))
    return React.createElement(
        Foundation.View,
        {
            tag = "no-clip",
            Size = var1,
            ref = arg1.containerRef,
            LayoutOrder = arg1.LayoutOrder
        },
        {
            MainMenu = React.createElement(IconOnlyMenu, {
                items = arg1.menus,
                activeItemId = arg1.activeMenuItemId,
                onItemActivated = arg1.onMenuItemActivated,
                ref = arg1.iconMenuRef,
                onAbsoluteSizeChanged = function(arg2)
                    var2(UDim2.fromOffset(arg2.AbsoluteSize.X, arg2.AbsoluteSize.Y))
                end
            }),
            Submenu = if arg1.submenuItems then React.createElement(IconTextMenu, {
                key = arg1.activeMenuItemId,
                items = arg1.submenuItems,
                onItemActivated = arg1.onSubmenuItemActivated,
                Position = arg1.submenuPosition
            }) else nil,
            OnInputEnded = React.createElement(ExternalEventConnection, { event = UserInputService.InputEnded, callback = arg1.onInputEnded })
        }
    )
end)
