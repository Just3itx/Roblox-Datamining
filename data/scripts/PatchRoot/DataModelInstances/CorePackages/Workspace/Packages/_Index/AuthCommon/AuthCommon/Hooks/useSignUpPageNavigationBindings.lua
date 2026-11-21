-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local React = require(AuthCommonParent.React)
local ReactFocusNavigation = require(AuthCommonParent.ReactFocusNavigation)
local FocusNavigationUtils = require(AuthCommonParent.FocusNavigationUtils)
local InputHandlers = require(AuthCommonParent.InputHandlers)
local FFlagEnableConfirmSignifierOnSignUpPage = require(AuthCommonParent.SharedFlags).FFlagEnableConfirmSignifierOnSignUpPage

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local tbl1 = {
    [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.Confirm,
    [Enum.KeyCode.Return] = FocusNavigationEventNameEnum.Confirm,
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useSignUpPageNavigationBindings(callback: ((...any) -> (...any))?)
    local handler = React.useCallback(function(arg1)
        arg1:cancel()

        if arg1.eventData and arg1.eventData.KeyCode == Enum.KeyCode.None then
            return
        end
        if callback then
            callback()
        end
    end, callback and { callback } or {})

    if not FFlagEnableConfirmSignifierOnSignUpPage then
        return (ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, handler))
    end

    local var2 = ReactFocusNavigation.useEventMap(tbl1)
    local var3 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = { handler = handler },
            [FocusNavigationEventNameEnum.Confirm] = {
                handler = InputHandlers.onRelease(function() end)
            }
        }
    end, {})

    return ReactFocusNavigation.useEventHandlerMap(var3, var2)
end

return useSignUpPageNavigationBindings
