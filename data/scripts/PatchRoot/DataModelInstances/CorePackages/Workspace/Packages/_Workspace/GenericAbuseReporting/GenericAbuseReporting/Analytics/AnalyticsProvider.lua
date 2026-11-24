-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local submitAnalytics = require(script.Parent.submitAnalytics)
local AnalyticsSubmitContext = require(script.Parent.AnalyticsSubmitContext)
local AnalyticsStateContext = require(script.Parent.AnalyticsStateContext)
local AnalyticsDispatchContext = require(script.Parent.AnalyticsDispatchContext)
local AnalyticsReducer = require(script.Parent.AnalyticsReducer)

local function AnalyticsProvider(tbl1)
    local value, var1 = React.useReducer(AnalyticsReducer.reducer, AnalyticsReducer.initialState)

    local var2 = React.useCallback(function(arg1)
        local var3 = if tbl1.onBeforeSubmitAnalytics then tbl1.onBeforeSubmitAnalytics(value) else value

        if not var3 then
            return
        end

        if tbl1.onSubmitAnalytics then
            tbl1.onSubmitAnalytics(var3, arg1)
            return
        end
        submitAnalytics(var3, arg1)
    end, { value, tbl1.onBeforeSubmitAnalytics, tbl1.onSubmitAnalytics })

    return React.createElement(AnalyticsSubmitContext.Provider, { value = var2 }, {
        stateProvider = React.createElement(
            AnalyticsStateContext.Provider,
            { value = value },
            {
                dispatchProvider = React.createElement(AnalyticsDispatchContext.Provider, { value = var1 }, tbl1.children)
            }
        )
    })
end
return AnalyticsProvider
