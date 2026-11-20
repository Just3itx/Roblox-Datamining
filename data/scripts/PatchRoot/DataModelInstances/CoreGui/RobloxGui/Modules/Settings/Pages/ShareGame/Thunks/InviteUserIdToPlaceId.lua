-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui"):WaitForChild("RobloxGui").Modules.Settings.Pages.ShareGame

local ApiSendGameInvite = require(ShareGame.Thunks.ApiSendGameInvite)
local ApiFetchPlaceInfos = require(CorePackages.Workspace.Packages.PlaceInfoRodux).Thunks.ApiFetchPlaceInfos
local Promise = require(CorePackages.Packages.Promise)

local ReceivedUserInviteStatus = require(ShareGame.Actions.ReceivedUserInviteStatus)
local InviteStatus = require(ShareGame.Constants).InviteStatus

return function(arg1, str1: string, str2: string)
    return function(arg2)
        if str2 == "0" then
            warn("Game Invite failed to send. Cannot send invite to unpublished Place.")
            arg2:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Failed))
            return Promise.reject()
        end

        local state = arg2:getState()

        return Promise.new(function(callback, callback2)
            if state.Invites[tostring(str1)] == InviteStatus.Pending then
                callback2()
                return
            end
            callback()
        end):andThen(function()
            local placeInfo = state.PlaceInfos[str2]

            return Promise.new(function(callback, callback2)
                arg2:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Pending))

                if placeInfo then
                    callback(placeInfo)
                    return
                end
                arg2:dispatch(ApiFetchPlaceInfos(arg1, { str2 })):andThen(function(arg3)
                    if arg3[1] ~= nil then
                        callback(arg3[1])
                        return
                    end
                    callback2()
                end, function()
                    callback2()
                end)
            end):andThen(function(arg3)
                return arg2:dispatch(ApiSendGameInvite(arg1, str1, arg3))
            end):andThen(function(arg3)
                arg2:dispatch(ReceivedUserInviteStatus(str1, arg3.resultType))
                return arg3
            end, function()
                arg2:dispatch(ReceivedUserInviteStatus(str1, InviteStatus.Failed))
            end)
        end)
    end
end
