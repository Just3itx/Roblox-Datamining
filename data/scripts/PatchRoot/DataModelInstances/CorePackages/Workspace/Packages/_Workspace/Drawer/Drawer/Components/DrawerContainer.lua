-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Drawer = script:FindFirstAncestor("Drawer")
local CoreGui = game:GetService("CoreGui")
local DrawerParent = Drawer.Parent
local React = require(DrawerParent.React)
local ReactRoblox = require(DrawerParent.ReactRoblox)
local Drawer2 = require(script.Parent.Drawer)
local _Types = require(script.Parent.Parent.Types)

local FFlagFixOverlayTopInsetForDeviceSafeInsets = require(DrawerParent.SharedFlags).FFlagFixOverlayTopInsetForDeviceSafeInsets

return React.memo(function(arg1)
    local createPortal = ReactRoblox.createPortal
    local tbl1 = {
        Drawer = React.createElement("ScreenGui", {
            ClipToDeviceSafeArea = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = arg1.displayOrder,
            IgnoreGuiInset = true,
            ScreenInsets = if FFlagFixOverlayTopInsetForDeviceSafeInsets and arg1.deviceSafeInsets then Enum.ScreenInsets.DeviceSafeInsets else Enum.ScreenInsets.None
        }, {
            DrawerContent = React.createElement(Drawer2, arg1)
        })
    }
    return createPortal(tbl1, CoreGui)
end)
