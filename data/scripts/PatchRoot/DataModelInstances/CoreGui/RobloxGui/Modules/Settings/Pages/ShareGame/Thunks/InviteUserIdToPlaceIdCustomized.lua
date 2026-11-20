-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui"):WaitForChild("RobloxGui").Modules.Settings.Pages.ShareGame
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents

local Promise = require(CorePackages.Packages.Promise)

local ReceivedUserInviteStatus = require(ShareGame.Actions.ReceivedUserInviteStatus)
local InviteStatus = require(ShareGame.Constants).InviteStatus

local PostSendExperienceInvite = require(CorePackages.Workspace.Packages.GameInvite).PostSendExperienceInvite

return function(arg1, str1: string, str2: string, arg2, str3: string, str4: string?, str5: string?)
    return function(arg3)
        if str2 == "0" then
            warn("Game Invite failed to send. Cannot send invite to unpublished Place.")
            arg3:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Failed))
            return Promise.reject()
        end

        local state = arg3:getState()

        return Promise.new(function(callback, callback2)
            if state.Invites[str1] == InviteStatus.Pending then
                callback2()
                return
            end
            callback()
        end):andThen(function()
            arg3:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Pending))
            return PostSendExperienceInvite(arg1, str1, str2, str3, str4, str5)
        end):andThen(function<T>(arg4: T): T
            arg3:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Success))
            return arg4
        end, function()
            arg2:sendEvent(str3, GameInviteEvents.ErrorShown)
            arg3:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Failed))
        end)
    end
end
