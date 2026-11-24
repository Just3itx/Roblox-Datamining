-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local _Foundation = require(GroupsParent.Foundation)
local FocusNavigationUtils = require(GroupsParent.FocusNavigationUtils)
local InputHandlers = require(GroupsParent.InputHandlers)
local _ReactFocusNavigation = require(GroupsParent.ReactFocusNavigation)
local UserLib = require(GroupsParent.UserLib)

local _ChatHeaderView = require(script.Parent.ChatHeaderView)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useChatHeaderViewModel(tbl2)
    local isMenuOpen, var2 = React.useState(false)

    local onCloseMenu = React.useCallback(function()
        var2(false)
    end, {})

    local onToggleMenu = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local menuItems = React.useMemo(function()
        local result = {}
        for value, value2 in tbl2.overflowActions or {} do
            local tbl3 = {
                id = tostring(value),
                text = value2.title,
                onActivated = 0
            }

            function tbl3.onActivated()
                onCloseMenu()
                value2.action()
            end

            table.insert(result, tbl3)
        end

        return result
    end, { tbl2.overflowActions, onCloseMenu })

    local bool1 = #menuItems > 0

    React.useEffect(function()
        if not bool1 then
            var2(false)
        end
    end, { bool1 })

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onCloseMenu()
                    arg1:cancel()
                end)
            }
        }
    end, { onCloseMenu })

    local menuRef = FocusNavigationUtils.useFocusRoot({
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = isMenuOpen and bool1,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    local isUserIcon = tbl2.iconType == "user"
    local icon = if isUserIcon then UserLib.Utils.getRbxthumbWithTypeSizeAndOptions(
        tostring(tbl2.iconTargetId),
        UserLib.Utils.Constants.RbxthumbTypes.AvatarHeadShot,
        150
    ) else `rbxassetid://{tbl2.iconTargetId}`
    return {
        title = tbl2.title,
        subtitle = tbl2.subtitle,
        icon = icon,
        isUserIcon = isUserIcon,
        ctaButton = tbl2.ctaButton,
        onClick = tbl2.onClick,
        menuItems = menuItems,
        isMenuOpen = isMenuOpen,
        onToggleMenu = onToggleMenu,
        onCloseMenu = onCloseMenu,
        menuRef = menuRef,
        LayoutOrder = tbl2.LayoutOrder,
        testId = tbl2.testId or "--groups-chat-header"
    }
end

return useChatHeaderViewModel
