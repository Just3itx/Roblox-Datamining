-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent

local React = require(CurrencyTransfersParent.React)
local InputHandlers = require(CurrencyTransfersParent.InputHandlers)
local FocusNavigationUtils = require(CurrencyTransfersParent.FocusNavigationUtils)
local ReactFocusNavigation = require(CurrencyTransfersParent.ReactFocusNavigation)

local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useFocusOnMount = FocusNavigationUtils.useFocusOnMount
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useMostRecentOrDefaultFocusBehavior = ReactFocusNavigation.useMostRecentOrDefaultFocusBehavior

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useTransferSheetFocus(callback: (...any) -> (...any))
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
        shouldRestoreFocus = false
    })

    local var3, var4 = useMostRecentOrDefaultFocusBehavior(var2)
    return var4, (useFocusOnMount(var3))
end

return useTransferSheetFocus
