-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent

local BuilderIcons = require(AppBloxParent.BuilderIcons)
local Cryo = require(AppBloxParent.Cryo)
local FocusNavigationUtils = require(AppBloxParent.FocusNavigationUtils)
local Foundation = require(AppBloxParent.Foundation)
local React = require(AppBloxParent.React)
local SharedFlags = require(AppBloxParent.SharedFlags)

local ThreeDotsHorizontal = BuilderIcons.Icon.ThreeDotsHorizontal
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusNavigableSurfaceRegistryConnection = FocusNavigationUtils.useFocusNavigableSurfaceRegistryConnection
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Menu = Foundation.Menu
local View = Foundation.View

local getOverflowMenuSignalStore = require(AppBlox.OverflowMenu.getOverflowMenuSignalStore)
local useOverflowMenuOpen = require(AppBlox.OverflowMenu.useOverflowMenuOpen)
local FFlagLuaAppSduiGameTileFeedback = SharedFlags.FFlagLuaAppSduiGameTileFeedback

return React.memo(function(tbl1) -- name: OverflowMenu
    local menuKey = tbl1.menuKey
    local var1 = React.useRef(nil)
    local overflowMenuSignalStore = getOverflowMenuSignalStore()
    local var2 = useOverflowMenuOpen(menuKey)

    local onActivated = React.useCallback(function()
        local var3 = var2
        overflowMenuSignalStore.toggleMenu(menuKey)
        if tbl1.onMenuOpenChanged then
            tbl1.onMenuOpenChanged(var3)
        end
    end, {
        menuKey,
        overflowMenuSignalStore,
        var2,
        tbl1.onMenuOpenChanged
    })

    local onPressedOutside = React.useCallback(function()
        overflowMenuSignalStore.closeMenu(menuKey)
        if tbl1.onMenuOpenChanged then
            tbl1.onMenuOpenChanged(true)
        end
    end, { menuKey, overflowMenuSignalStore, tbl1.onMenuOpenChanged })

    local items = React.useMemo(function()
        return Cryo.List.map(tbl1.menuItems, function(arg1)
            return {
                icon = arg1.icon,
                id = arg1.id,
                text = arg1.text,
                onActivated = function()
                    task.spawn(function()
                        arg1.onActivated()
                    end)
                    overflowMenuSignalStore.closeMenu(menuKey)
                    if tbl1.onMenuOpenChanged then
                        tbl1.onMenuOpenChanged(true)
                    end
                end
            }
        end)
    end, {
        tbl1.menuItems,
        menuKey,
        overflowMenuSignalStore,
        tbl1.onMenuOpenChanged
    })

    local var6 = React.useRef(menuKey)
    React.useEffect(function()
        if var6.current ~= menuKey and overflowMenuSignalStore then
            var6.current = menuKey
            overflowMenuSignalStore.closeMenu(menuKey)
        end
    end, { menuKey, overflowMenuSignalStore })

    local var7, var8 = React.useState(nil)
    local ref = React.useCallback(function(arg1)
        var8(arg1)
        if tbl1.setFocusRef then
            tbl1.setFocusRef(arg1)
        end
    end, { tbl1.setFocusRef })

    useFocusNavigableSurfaceRegistryConnection(var7, FocusNavigableSurfaceIdentifierEnum.ContextualMenu, true)

    if not (tbl1.shouldShowAnchor or var2) then
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var10 = nil
    local tbl2 = { MenuAnchor = 0, OverflowMenu = 0 }
    local element

    if tbl1.hasOverflowButton and (tbl1.shouldShowAnchor or var2) then
        element = React.createElement(View, {
            AnchorPoint = tbl1.anchorPoint,
            Position = tbl1.anchorPosition,
            ZIndex = if FFlagLuaAppSduiGameTileFeedback then tbl1.zIndex else nil,
            tag = if tbl1.buttonTag == nil then "auto-xy radius-circle" else tbl1.buttonTag,
            backgroundStyle = tbl1.buttonIconBackgroundStyle,
            ref = var1
        }, {
            IconButton = React.createElement(IconButton, {
                icon = tbl1.buttonIcon or ThreeDotsHorizontal,
                isCircular = tbl1.buttonIsCircular == nil or tbl1.buttonIsCircular,
                onActivated = onActivated,
                size = tbl1.buttonIconSize or IconSize.Medium,
                variant = tbl1.buttonVariant or ButtonVariant.Utility
            })
        })
    else
        element = React.createElement("Frame", {
            AnchorPoint = tbl1.anchorPoint,
            BackgroundTransparency = 1,
            Position = tbl1.anchorPosition,
            Size = UDim2.fromScale(0, 0),
            ZIndex = if FFlagLuaAppSduiGameTileFeedback then tbl1.zIndex else nil,
            ref = var1
        })
    end

    tbl2.MenuAnchor = element

    tbl2.OverflowMenu = if var2 then React.createElement(Menu, {
        align = tbl1.popoverAlign or PopoverAlign.End,
        isOpen = true,
        items = items,
        onPressedOutside = onPressedOutside,
        side = tbl1.popoverSide or PopoverSide.Bottom,
        size = tbl1.menuItemSize or InputSize.Medium,
        width = tbl1.menuWidth,
        anchorRef = var1,
        ref = ref
    }) else nil
    return (createElement(fragment, var10, tbl2))
end)
