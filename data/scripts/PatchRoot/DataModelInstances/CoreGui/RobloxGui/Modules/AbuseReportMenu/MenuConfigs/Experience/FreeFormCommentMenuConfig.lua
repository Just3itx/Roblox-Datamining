-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

return {
    componentType = "freeComments",
    getIsVisible = function(_): boolean
        return true
    end,
    onUpdate = function(comment: string, _, callback, arg1)
        arg1.analyticsDispatch({ type = Constants.AnalyticsActions.SetCommentAdded, commentAdded = #comment > 0 })

        callback({ type = Constants.PlayerMenuActions.UpdateComment, comment = comment })
    end,
    componentName = "FreeComments"
}
