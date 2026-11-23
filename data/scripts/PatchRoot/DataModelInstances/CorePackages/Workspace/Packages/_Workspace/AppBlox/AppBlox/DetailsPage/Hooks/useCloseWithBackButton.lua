-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local InputHandlers = require(AppBloxParent.InputHandlers)
local ReactFocusNavigation = require(AppBloxParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = require(AppBloxParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local React = require(AppBloxParent.React)

local tbl1 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useCloseWithBackButton(arg1, callback: ((...any) -> (...any))?)
    local var1 = React.useMemo(function()
        return InputHandlers.onRelease(function(arg2)
            if callback then
                callback()
                arg2:cancel()
            end
        end)
    end, { callback })

    local var2 = ReactFocusNavigation.useEventMap(tbl1, arg1)
    return (ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, var1, nil, var2))
end

return useCloseWithBackButton
