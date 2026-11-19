-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local VerifiedBadges = require(CorePackages.Workspace.Packages.VerifiedBadges)
local UserLib = require(CorePackages.Workspace.Packages.UserLib)
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

local InExperienceCapabilities = require(CorePackages.Workspace.Packages.InExperienceCapabilities).InExperienceCapabilities

return {
    componentType = "modalSelector",
    getIsVisible = function(_): boolean
        return true
    end,
    getMenuItems = function(arg1)
        return (Cryo.List.map(arg1.playerObjects, function(arg2)
            local var1 = if UserLib.Utils.isPlayerVerified(arg2) then VerifiedBadges.emoji.verified else ""

            return {
                label = arg2.DisplayName .. var1,
                subLabel = if InExperienceCapabilities.canDisplayPeoplesUsernames then "[@" .. arg2.Name .. "]" else nil,
                identifier = arg2.Name
            }
        end))
    end,
    getSelectedValue = function(arg1)
        local allegedAbuser = arg1.allegedAbuser
        if not allegedAbuser then
            return nil
        end

        local displayName = allegedAbuser.DisplayName
        local allegedAbuserName = allegedAbuser.Name

        return displayName .. (if InExperienceCapabilities.canDisplayPeoplesUsernames then "[@" .. allegedAbuserName .. "]" else "")
    end,
    onUpdateSelectedOption = function(arg1, arg2, callback, arg3)
        if not arg1.identifier then
            return
        end

        local identifier = arg1.identifier
        for _, abuser in arg2.playerObjects do
            if identifier ~= abuser.Name then
                continue
            end

            local userId = abuser.UserId
            arg3.analyticsDispatch({ type = Constants.AnalyticsActions.IncrementPersonChanged })
            callback({ type = Constants.PlayerMenuActions.UpdateAbuser, abuseId = userId, abuser = abuser })
        end
    end,
    fieldLabel = "WhichPerson",
    componentName = "PlayerSelector"
}
