-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
return {
    componentType = "dropdown",
    getIsVisible = function(_): boolean
        return true
    end,
    getMenuItems = function(_)
        return {}
    end,
    onUpdateSelectedOption = function(_, _) end,
    readonlyValue = require(AbuseReportMenu.Components.Constants).InappropriateContentAbuseReason,
    fieldLabel = "ReasonForAbuse",
    componentName = "AbuseReason"
}
