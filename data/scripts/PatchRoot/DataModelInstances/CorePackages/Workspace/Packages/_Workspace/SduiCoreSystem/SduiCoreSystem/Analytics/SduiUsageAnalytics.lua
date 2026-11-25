-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local config = {
    eventName = "sdui_type_usage",
    description = "Per-page-load delta of SDUI component types and action types observed for a given (page, version). `components` and `actions` are comma-joined strings convertible to `repeated string` server-side.",
    lastUpdated = { 26, 4, 24 },
    backends = { "Points", "EventIngest" },
    throttlingPercentage = 10000
}

local config2 = {
    eventName = "sdui_param_usage",
    description = "Per-page-load delta of SDUI component-prop and action-param names observed for a given (page, version). `props` and `actionParams` are comma-joined strings convertible to `repeated string` server-side; each entry is shaped `componentType.propName` or `actionType.paramName`.",
    lastUpdated = { 26, 4, 24 },
    backends = { "Points", "EventIngest" },
    throttlingPercentage = 10000
}

local function joinSet(tbl1): string
    local tbl2 = {}
    for value, _ in tbl1 do
        table.insert(tbl2, value)
    end
    table.sort(tbl2)
    return table.concat(tbl2, ",")
end

return {
    sendTypeUsageEvent = function(tbl1)
        TelemetryService:LogEvent(config, {
            customFields = {
                page = tbl1.page,
                version = tbl1.version,
                components = joinSet(tbl1.componentTypes),
                actions = joinSet(tbl1.actionTypes)
            },
            standardizedFields = { "addOSInfo" }
        })
    end,
    sendParamUsageEvent = function(tbl1)
        TelemetryService:LogEvent(config2, {
            customFields = {
                page = tbl1.page,
                version = tbl1.version,
                props = joinSet(tbl1.props),
                actionParams = joinSet(tbl1.actionParams)
            },
            standardizedFields = { "addOSInfo" }
        })
    end
}
