-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local InputHandlers = require(GenericAbuseReportingParent.InputHandlers)
local React = require(GenericAbuseReportingParent.React)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useDefaultFocusBehavior = require(GenericAbuseReportingParent.ReactFocusNavigation).useDefaultFocusBehavior
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot

local composeRefs = require(script.Parent.composeRefs)
local useScrollNavigationBindings = require(script.Parent.useScrollNavigationBindings)

local function useFocusNavigationRefs(surfaceIdentifier, arg1)
    local var1 = useDefaultFocusBehavior()
    local var2 = useScrollNavigationBindings({ includeDiscreteScroll = false })

    local var3 = useAppFocusRoot({
        surfaceIdentifier = surfaceIdentifier,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(arg1)
            }
        },
        isAutoFocusRoot = true
    })

    return (React.useMemo(function()
        return composeRefs(var3, var1, var2)
    end, { var3, var1, var2 }))
end

return useFocusNavigationRefs
