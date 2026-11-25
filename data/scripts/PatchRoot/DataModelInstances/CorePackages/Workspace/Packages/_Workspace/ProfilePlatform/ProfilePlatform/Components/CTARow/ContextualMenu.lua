-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local _Types = require(ProfilePlatform.Components.CTARow.Types)

local CoreGui = game:GetService("CoreGui")

local React = require(ProfilePlatformParent.React)
local Dash = require(ProfilePlatformParent.Dash)
local Foundation = require(ProfilePlatformParent.Foundation)
local useIsSpatial = require(ProfilePlatformParent.Responsive).useIsSpatial
local Menu = Foundation.Menu
local OverlayProvider = Foundation.OverlayProvider
local PopoverAlign = Foundation.Enums.PopoverAlign
local InputSize = Foundation.Enums.InputSize

local function getVROverlaySurfaceGui() -- Luacid: Inlined by compiler; 1 call site recovered
    local luaAppScreenGui = CoreGui:FindFirstChild("LuaAppScreenGui")
    if luaAppScreenGui then
        return (luaAppScreenGui:FindFirstChild("MainAppScreen_SurfaceGui"))
    end
    return nil
end

local function convertToMenuItems(menuItems, callback: (...any) -> (...any))
    return Dash.map(menuItems, function(arg1)
        return {
            items = Dash.map(arg1.items, function(arg2)
                local displayValue = arg2.displayValue
                return {
                    id = arg2.id,
                    onActivated = function()
                        callback()
                        arg2.onActivated()
                    end,
                    isDisabled = arg2.isDisabled,
                    text = displayValue.text or "",
                    icon = displayValue.icon
                }
            end)
        }
    end)
end

local function ContextualMenu(tbl1)
    local var1 = useIsSpatial()
    local gui = React.useMemo(function()
        if var1 then
            return getVROverlaySurfaceGui()
        end

        return nil
    end, { var1 })

    local items = React.useMemo(function()
        return convertToMenuItems(tbl1.menuItems, tbl1.closeMenu)
    end, { tbl1.menuItems, tbl1.closeMenu })

    return (React.createElement(OverlayProvider, { gui = gui }, {
        Menu = React.createElement(Menu, {
            isOpen = tbl1.isOpen,
            align = tbl1.align or PopoverAlign.End,
            anchorRef = tbl1.anchorRef,
            items = items,
            onPressedOutside = tbl1.closeMenu,
            ref = tbl1.menuRef,
            size = InputSize.Medium
        })
    }))
end

return ContextualMenu
