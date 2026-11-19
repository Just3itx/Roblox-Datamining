-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local RobloxGui = game:GetService("CoreGui").RobloxGui

local Constants = require(AbuseReportMenu.Components.Constants)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local function func1(player): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return default:getRecentUsersInteractionData()[tostring(player.UserId)] ~= nil
end

function handlePreselectedPlayer(player, bool1: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any))
    if bool1 and func1(player) then
        callback({ type = Constants.PlayerMenuActions.UpdateMethodOfAbuse, methodOfAbuse = Constants.AbuseMethods.VoiceChat })

        callback2({ type = Constants.AnalyticsActions.SetTypeOfAbuseSelection, selection = Constants.AbuseMethods.VoiceChat })

        callback2(
            {
                type = Constants.AnalyticsActions.SetPreselectedAbuseSelection,
                selection = Constants.AbuseMethods.VoiceChat
            }
        )
    elseif TnSIXPWrapper.getReportAnythingAvatarEnabled() then
        callback({ type = Constants.PlayerMenuActions.UpdateMethodOfAbuse, methodOfAbuse = Constants.AbuseMethods.TextChat })

        callback2({ type = Constants.AnalyticsActions.SetTypeOfAbuseSelection, selection = Constants.AbuseMethods.TextChat })

        callback2(
            {
                type = Constants.AnalyticsActions.SetPreselectedAbuseSelection,
                selection = Constants.AbuseMethods.TextChat
            }
        )
    else
        callback2({ type = Constants.AnalyticsActions.SetPreselectedAbuseSelection, selection = "None" })
    end

    callback({ type = Constants.PlayerMenuActions.SetPreselectedPlayer, player = player })
end

return handlePreselectedPlayer
