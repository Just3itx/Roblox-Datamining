-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ToastNotificationParent = script:FindFirstAncestor("ToastNotification").Parent

local React = require(ToastNotificationParent.React)
local AppShortcutBar = require(ToastNotificationParent.AppShortcutBar)
local useTokens = require(ToastNotificationParent.Foundation).Hooks.useTokens
local IconWithHoldAnimation = AppShortcutBar.IconWithHoldAnimation

return function(tbl1)
    local var1 = useTokens()
    local iconSize = tbl1.iconSize or var1.Size.Size_350

    return React.createElement("CanvasGroup", {
        Size = UDim2.fromOffset(iconSize, iconSize),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible,
        GroupTransparency = tbl1.iconTransparency
    }, {
        HoldIcon = React.createElement(IconWithHoldAnimation, {
            size = UDim2.fromScale(1, 1),
            icon = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect),
            iconSize = iconSize,
            progress = tbl1.progress
        })
    })
end
