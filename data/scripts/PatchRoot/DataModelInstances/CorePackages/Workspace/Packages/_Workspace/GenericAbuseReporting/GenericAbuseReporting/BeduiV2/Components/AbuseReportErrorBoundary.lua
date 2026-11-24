-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local forwardErrorToScriptContext = require(GenericAbuseReporting.BeduiV2.Analytics.forwardErrorToScriptContext)

local var1 = React.Component:extend("AbuseReportErrorBoundary")

function var1.getDerivedStateFromError(_)
    return { hasError = true }
end

function var1.init(arg1)
    arg1.state = { hasError = false }
end

function var1.componentDidCatch(tbl1, arg1, tbl2)
    local onError = tbl1.props.onError
    if onError then
        onError(arg1, tbl2)
    end

    forwardErrorToScriptContext(arg1, tbl2 and tbl2.componentStack or nil)
end

function var1.render(arg1)
    local props = arg1.props
    return if arg1.state.hasError then props.fallback else props.children
end

return var1
