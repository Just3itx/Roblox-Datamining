-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local InputHandlers = require(GenericAbuseReportingParent.InputHandlers)
local React = require(GenericAbuseReportingParent.React)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useDefaultFocusBehavior = require(GenericAbuseReportingParent.ReactFocusNavigation).useDefaultFocusBehavior
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local composeRefs = require(script.Parent.composeRefs)
local useScrollNavigationBindings = require(script.Parent.useScrollNavigationBindings)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useInExpFocusNavigationRefs(surfaceIdentifier, arg1, isAutoFocusRoot: boolean?, isFocusable: boolean?)
    local var1 = useDefaultFocusBehavior()
    local var2 = useScrollNavigationBindings()

    local eventHandlers = {
        [FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(arg1)
        }
    }

    local var3 = useFocusRoot
    local tbl3 = {
        surfaceIdentifier = surfaceIdentifier,
        eventHandlers = eventHandlers,
        eventMap = eventMap,
        isFocusable = 0,
        isAutoFocusRoot = 0
    }

    if isFocusable == nil then
        isFocusable = true
    end

    tbl3.isFocusable = isFocusable
    if isAutoFocusRoot == nil then
        isAutoFocusRoot = true
    end

    tbl3.isAutoFocusRoot = isAutoFocusRoot
    local var4 = var3(tbl3)

    return (React.useMemo(function()
        return composeRefs(var4, var1, var2)
    end, { var4, var1, var2 }))
end

return useInExpFocusNavigationRefs
