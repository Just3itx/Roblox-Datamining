-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local RoactGamepad = require(AvatarExperienceControlBarParent.RoactGamepad)
local AvatarExperienceCommon = require(AvatarExperienceControlBarParent.AvatarExperienceCommon)

local useTokens = Foundation.Hooks.useTokens
local debounce = AvatarExperienceCommon.Utils.debounce

local FFlagAXFixVRControlBarFlicker = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXFixVRControlBarFlicker

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)

local tbl1 = {
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true,
    [Enum.KeyCode.Left] = true,
    [Enum.KeyCode.Right] = true,
    [Enum.KeyCode.DPadDown] = true,
    [Enum.KeyCode.DPadUp] = true,
    [Enum.KeyCode.DPadLeft] = true,
    [Enum.KeyCode.DPadRight] = true,
    [Enum.KeyCode.Thumbstick1] = true
}

local function useBaseControlBarProps(arg1)
    local var1 = useTokens()

    local var2 = React.useRef(false)
    local containerRef = React.useRef(nil)
    local iconMenuRef = React.useRef(nil)
    local menuItemsRefCache = RoactGamepad.useRefCache()

    local var6 = React.useCallback(function()
        local tbl2 = {}
        local tbl3 = {}
        if arg1.config then
            for _, value in arg1.config do
                if value.children then
                    tbl3[value.id] = value.children
                end
                value.ref = menuItemsRefCache[value.id]
                table.insert(tbl2, value)
            end
        end
        return tbl2, tbl3
    end, { arg1.config })

    local var7, var8 = var6()
    local menus, var10 = React.useState(var7)
    local submenus, var12 = React.useState(var8)
    local activeMenuItemId, var14 = React.useState("")

    React.useEffect(function()
        local var15, var16 = var6()
        var10(var15)
        var12(var16)
    end, { var6 })

    React.useEffect(function()
        if arg1.onActiveMenuItemChanged then
            arg1.onActiveMenuItemChanged(activeMenuItemId, submenus[activeMenuItemId] ~= nil)
        end
    end, { activeMenuItemId, submenus })

    local submenuItems = React.useMemo(function()
        return submenus[activeMenuItemId]
    end, { activeMenuItemId, submenus })

    local submenuPosition = React.useMemo(function()
        local var16 = menuItemsRefCache[activeMenuItemId]
        if not (var16 and var16.current and containerRef.current and iconMenuRef.current) then
            return nil
        end

        local absolutePosition = var16.current.AbsolutePosition
        local absolutePosition2 = containerRef.current.AbsolutePosition
        local absoluteSize = iconMenuRef.current.AbsoluteSize

        local var17 = absolutePosition - absolutePosition2 + Vector2.new(absoluteSize.X + var1.Size.Size_50, 0)
        return UDim2.new(0, var17.X, 0, var17.Y)
    end, { activeMenuItemId })

    local var17 = React.useCallback(debounce(function()
        var2.current = false
    end, 0.1), {})

    return {
        activeMenuItemId = activeMenuItemId,
        menus = menus,
        submenus = submenus,
        submenuItems = submenuItems,
        submenuPosition = submenuPosition,
        onMenuItemActivated = React.useCallback(function(str1: string)
            var14(if str1 == activeMenuItemId then "" else str1)
            var2.current = true
            var17()
        end, { activeMenuItemId }),
        onSubmenuItemActivated = React.useCallback(function(_: string)
            var14("")
            var2.current = true
            var17()
        end, {}),
        onInputEnded = React.useCallback(function(arg2)
            if activeMenuItemId ~= "" and not (var2.current or tbl1[arg2.KeyCode]) then
                var14("")
            end
            if not FFlagAXFixVRControlBarFlicker then
                var2.current = false
            end
        end, { activeMenuItemId }),
        containerRef = containerRef,
        iconMenuRef = iconMenuRef,
        menuItemsRefCache = menuItemsRefCache,
        LayoutOrder = arg1.LayoutOrder
    }
end

return useBaseControlBarProps
