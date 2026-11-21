-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local FocusNavigationUtils = require(GameJoinCardParent.FocusNavigationUtils)
local InputHandlers = require(GameJoinCardParent.InputHandlers)
local ReactFocusNavigation = require(GameJoinCardParent.ReactFocusNavigation)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusOnMount = FocusNavigationUtils.useFocusOnMount
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useMostRecentOrDefaultFocusBehavior = ReactFocusNavigation.useMostRecentOrDefaultFocusBehavior

local _Types = require(GameJoinCard.Components.Actions.Types)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

return {
    useGameJoinCardGamepadNavigation = function(callback: (...any) -> (...any), isFocusable: boolean)
        local eventHandlers = React.useMemo(function()
            local result = {}
            result[FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    callback()
                    arg1:cancel()
                end)
            }
            return result
        end, { callback })

        local var2 = useFocusRoot({
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            eventMap = eventMap,
            eventHandlers = eventHandlers,
            isAutoFocusRoot = true,
            shouldRestoreFocus = false,
            isFocusable = isFocusable
        })
        local var3, rootRef = useMostRecentOrDefaultFocusBehavior(var2)
        local var5 = useFocusOnMount(var3)

        local tbl2 = { rootRef = rootRef, primaryButtonFocusRef = 0 }
        if not isFocusable then
            var5 = var3
        end

        tbl2.primaryButtonFocusRef = var5
        return tbl2
    end,
    assignPrimaryFocusRef = function(tbl2, focusRef)
        if tbl2 == nil or focusRef == nil or tbl2[1] == nil then
            return tbl2
        end

        local var1 = table.clone(tbl2)
        local var2 = table.clone(tbl2[1])
        var2.focusRef = focusRef
        var1[1] = var2
        return var1
    end
}
