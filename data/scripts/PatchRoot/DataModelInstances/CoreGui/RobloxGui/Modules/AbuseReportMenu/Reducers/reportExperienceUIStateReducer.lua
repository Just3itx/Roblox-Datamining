-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local Constants = require(AbuseReportMenu.Components.Constants)
local _Types = require(AbuseReportMenu.Components.Types)
local PlayerMenuActions = Constants.PlayerMenuActions

local function reportExperienceUIStateReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    if arg2.type == PlayerMenuActions.UpdateComment then
        var1.comment = arg2.comment
    end
    return var1
end

return reportExperienceUIStateReducer
