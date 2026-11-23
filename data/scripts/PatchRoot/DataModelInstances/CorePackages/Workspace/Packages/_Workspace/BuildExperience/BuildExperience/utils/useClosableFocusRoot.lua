-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local InputHandlers = require(BuildExperienceParent.InputHandlers)
local React = require(BuildExperienceParent.React)
local _ReactFocusNavigation = require(BuildExperienceParent.ReactFocusNavigation)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useClosableFocusRoot(tbl2)
    local onClose = tbl2.onClose
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })
    return useFocusRoot({
        surfaceIdentifier = tbl2.surfaceIdentifier,
        isFocusable = tbl2.isOpen,
        isAutoFocusRoot = true,
        shouldRestoreFocus = tbl2.shouldRestoreFocus,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
end

return useClosableFocusRoot
