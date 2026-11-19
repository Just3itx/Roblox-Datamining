-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CoreGui = game:GetService("CoreGui")
local _Types = require(AbuseReportMenu.Components.Types)
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)
local getAvailableMethodsOfAbuse = require(AbuseReportMenu.Utility.getAvailableMethodsOfAbuse)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)
local RobloxGui = CoreGui.RobloxGui
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Cryo = require(CorePackages.Packages.Cryo)

return {
    componentType = "modalSelector",
    getIsVisible = function(arg1)
        return arg1.isVoiceEnabled or TnSIXPWrapper.getReportAnythingAvatarEnabled()
    end,
    getMenuItems = function(arg1)
        local var1 = arg1.isVoiceEnabled and not Cryo.isEmpty(default:getRecentUsersInteractionData())

        return getAvailableMethodsOfAbuse(var1, TnSIXPWrapper.getReportAnythingAvatarEnabled())
    end,
    getSelectedValue = function(arg1)
        return arg1.methodOfAbuse
    end,
    onUpdateSelectedOption = function(arg1, arg2, callback, arg3)
        callback({ type = Constants.PlayerMenuActions.UpdateMethodOfAbuse, methodOfAbuse = arg1.identifier })

        if arg1.identifier == arg2.methodOfAbuse then
            return
        end

        arg3.reportAnythingDispatch({ type = Constants.ReportAnythingActions.ClearAnnotationFlowProperties })

        arg3.analyticsDispatch({ type = Constants.AnalyticsActions.IncrementTypeofabuseChanged })
        arg3.analyticsDispatch({ type = Constants.AnalyticsActions.SetTypeOfAbuseSelection, selection = arg1.identifier })
    end,
    fieldLabel = "MethodOfAbuse",
    componentName = "MethodOfAbuse"
}
