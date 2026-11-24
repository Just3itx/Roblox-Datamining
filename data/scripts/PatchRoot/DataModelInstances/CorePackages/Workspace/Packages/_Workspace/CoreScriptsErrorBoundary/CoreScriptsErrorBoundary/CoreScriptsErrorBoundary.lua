-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local LoggingProtocol = require(scriptParentParent.LoggingProtocol)

local ReactTreeCrashedConfig = require(scriptParent.ReactTreeCrashedConfig)
local reportCaughtError = require(scriptParent.reportCaughtError)

local var1 = React.Component:extend("CoreScriptsErrorBoundary")

function var1.getDerivedStateFromError(_)
    return { hasError = true }
end

function var1.init(arg1)
    arg1.state = { hasError = false }
end

function var1.componentDidCatch(tbl1, arg1, tbl2)
    local props = tbl1.props
    LoggingProtocol.default:logRobloxTelemetryCounter(ReactTreeCrashedConfig, 1, { surface = props.surface })

    reportCaughtError(arg1, { surface = props.surface, componentStack = tbl2 and tbl2.componentStack or nil })
end

function var1.render(arg1)
    return if arg1.state.hasError then nil else arg1.props.children
end

return var1
