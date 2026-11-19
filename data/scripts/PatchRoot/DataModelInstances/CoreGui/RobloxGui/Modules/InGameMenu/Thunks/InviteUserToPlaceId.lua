-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent

local Network = scriptParentParent.Network

local AppChatNetworking = require(CorePackages.Workspace.Packages.AppChatNetworking)
local httpRequest = require(Network.httpRequest)
local GetPlaceInfos = require(Network.Requests.GetPlaceInfos)
local constructGameLinkUrl = require(scriptParentParent.Utility.constructGameLinkUrl)

local var1 = httpRequest(HttpRbxApiService)

local InviteStatus = require(scriptParentParent.Resources.Constants).InviteStatus

local ReceivedUserInviteStatus = require(scriptParentParent.Actions.ReceivedUserInviteStatus)

return function(arg1, arg2)
    return function(arg3)
        if arg3:getState().invites[tostring(arg1)] == InviteStatus.Pending then
            return
        end

        arg3:dispatch(ReceivedUserInviteStatus(arg1, InviteStatus.Pending))

        if RunService:IsStudio() then
            spawn(function()
                arg3:dispatch(ReceivedUserInviteStatus(arg1, InviteStatus.Failed))
            end)
            return
        end

        return GetPlaceInfos(var1, { arg2 }):andThen(function(arg4)
            local var2 = arg4.responseBody[1]
            assert(var2, "Error fetching placeInfos")

            var2.placeId = tostring(var2.placeId)
            var2.universeId = tostring(var2.universeId)

            return var2
        end):andThen(function(arg4)
            local str1 = string.format("Come join me in %s", arg4.name)
            assert(arg4.universeRootPlaceId, "Failed to get universe root place id")
            local var2 = str1 .. "\n" .. constructGameLinkUrl(arg4.universeRootPlaceId)
            return AppChatNetworking.http.CreateConversation(nil, "one_to_one", { arg1 }):andThen(function(arg5)
                local conversation = arg5.responseBody.conversations[1]
                assert(conversation, "Failed to create conversation")
                return AppChatNetworking.http.SendChatTextMessage(nil, conversation.id, var2):andThen(function(arg6)
                    local var3 = arg6.responseBody.messages[1]
                    assert(var3, "Failed to send message")
                    return {
                        resultType = if var3.status == "success" then "Success" else "Failed",
                        conversationId = conversation.id,
                        placeId = arg4.universeRootPlaceId
                    }
                end)
            end):catch(function(arg5)
                warn("Failed to send invite: " .. tostring(arg5))
            end)
        end):andThen(function(arg4)
            local var2
            var2, arg4 = arg4:await()
            assert(var2, "Failed to unroll promise after friend invitation: " .. tostring(arg4))

            local resultType = arg4.resultType
            local var3 = InviteStatus[resultType] or InviteStatus.Failed

            arg3:dispatch(ReceivedUserInviteStatus(arg1, var3))
            return arg4
        end, function(_)
            arg3:dispatch(ReceivedUserInviteStatus(arg1, InviteStatus.Failed))
        end)
    end
end
