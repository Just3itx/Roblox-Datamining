-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local CoreGui = game:GetService("CoreGui")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local useIsSpatial = require(ProfilePlatformParent.Responsive).useIsSpatial
local FFlagProfileFixMenuNavigation = require(ProfilePlatformParent.SharedFlags).FFlagProfileFixMenuNavigation

local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local InputSize = Foundation.Enums.InputSize
local Menu = Foundation.Menu
local OverlayProvider = Foundation.OverlayProvider

local function getVROverlaySurfaceGui() -- Luacid: Inlined by compiler; 1 call site recovered
    if not FFlagProfileFixMenuNavigation then
        return nil
    end

    local luaAppScreenGui = CoreGui:FindFirstChild("LuaAppScreenGui")
    if luaAppScreenGui then
        return (luaAppScreenGui:FindFirstChild("MainAppScreen_SurfaceGui"))
    end
    return nil
end

local function ProfileContextualMenu(tbl1)
    local gui = if FFlagProfileFixMenuNavigation and useIsSpatial() then getVROverlaySurfaceGui() else nil
    local side = if tbl1.screenSize.Y / 2 < tbl1.rootElementPosition.Y then PopoverSide.Top else PopoverSide.Bottom

    if side == PopoverSide.Top then
        local var2 = tbl1.screenSize.X / tbl1.screenSize.Y
        local var3 = -(tbl1.screenSize.Y - tbl1.rootElementPosition.Y) + -20
        local bool1 = var2 >= 1.3 and var2 < 1.7

        if tbl1.screenSize.Y > 700 and not bool1 then
            local _ = var3 + tbl1.screenSize.Y * 0.05
        end
    else
        local _ = tbl1.rootElementPosition.Y + 60
    end

    if not FFlagProfileFixMenuNavigation then
        return (React.createElement(Menu, {
            align = PopoverAlign.End,
            anchorRef = tbl1.rootElementRef,
            isOpen = tbl1.isOpen == nil or tbl1.isOpen,
            items = tbl1.buttonProps,
            onPressedOutside = tbl1.onDismiss,
            side = side,
            size = InputSize.Medium,
            ref = if FFlagProfileFixMenuNavigation then tbl1.menuRef else nil
        }))
    end

    local createElement = React.createElement
    local var2 = OverlayProvider
    local tbl2 = { gui = gui }
    local tbl3 = {
        Menu = React.createElement(Menu, {
            align = PopoverAlign.End,
            anchorRef = tbl1.rootElementRef,
            isOpen = tbl1.isOpen == nil or tbl1.isOpen,
            items = tbl1.buttonProps,
            onPressedOutside = tbl1.onDismiss,
            side = side,
            size = InputSize.Medium,
            ref = if FFlagProfileFixMenuNavigation then tbl1.menuRef else nil
        })
    }
    return (createElement(var2, tbl2, tbl3))
end

return ProfileContextualMenu
