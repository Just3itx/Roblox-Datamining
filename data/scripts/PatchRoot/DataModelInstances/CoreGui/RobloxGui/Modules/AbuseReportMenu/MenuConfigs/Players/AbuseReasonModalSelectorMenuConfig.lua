-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)
local _Types = require(AbuseReportMenu.Components.Types)
local Cryo = require(CorePackages.Packages.Cryo)

return {
    componentType = "modalSelector",
    getIsVisible = function(_): boolean
        return true
    end,
    getMenuItems = function(arg1, arg2)
        local var1 = if arg1.methodOfAbuse == Constants.AbuseMethods.VoiceChat then Constants.PlayerVoiceAbuseTypes else Constants.PlayerAbuseTypes
        local var2 = Cryo.Dictionary.values(var1)
        return Cryo.List.map(var2, function(identifier)
            return {
                label = arg2[identifier],
                identifier = identifier
            }
        end)
    end,
    getSelectedValue = function(arg1)
        return arg1.abuseReason
    end,
    onUpdateSelectedOption = function(arg1, _, callback, arg2)
        arg2.analyticsDispatch({ type = Constants.AnalyticsActions.IncrementReasonChanged })
        arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetReasonSelection, selection = arg1.identifier })

        callback({ type = Constants.PlayerMenuActions.UpdateAbuseReason, abuseReason = arg1.identifier })
    end,
    fieldLabel = "ReasonForAbuse",
    componentName = "AbuseReason"
}
