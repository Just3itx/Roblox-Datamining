-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable
local ReceivedUserInviteStatus = require(ShareGame.Actions.ReceivedUserInviteStatus)
local StoppedToastTimer = require(ShareGame.Actions.StoppedToastTimer)

local InviteStatus = require(ShareGame.Constants).InviteStatus

return function(arg1, arg2)
    arg1 = arg1 or {
        failedInvites = {}
    }

    if arg2.type == ReceivedUserInviteStatus.name then
        local inviteStatus = arg2.inviteStatus

        if inviteStatus == InviteStatus.Moderated or inviteStatus == InviteStatus.Failed then
            local tbl1 = {
                timeStamp = tick(),
                userId = arg2.userId,
                status = inviteStatus
            }

            return (Immutable.JoinDictionaries(
                arg1,
                {
                    failedInvites = Immutable.JoinDictionaries(arg1.failedInvites, Immutable.Append(arg1.failedInvites, tbl1))
                }
            ))
        end
    elseif arg2.type == StoppedToastTimer.name then
        arg1 = Immutable.JoinDictionaries(arg1, { failedInvites = {} })
    end

    return arg1
end
