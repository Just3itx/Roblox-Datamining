-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Requests = require(CorePackages.Workspace.Packages.Http).Requests

local DEPRECATED_ChatSendMessage = Requests.DEPRECATED_ChatSendMessage

local DEPRECATED_ChatStartOneToOneConversation = Requests.DEPRECATED_ChatStartOneToOneConversation

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local DEPRECATED_ChatSendGameLinkMessage = Requests.DEPRECATED_ChatSendGameLinkMessage

return function(arg1, arg2, arg3)
    local userId = Players.LocalPlayer.UserId

    local var1 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Message.InviteToGameTitle", { PLACENAME = arg3.name })

    return function(_)
        return DEPRECATED_ChatStartOneToOneConversation(arg1, arg2, userId):andThen(function(arg4)
            local conversation = arg4.responseBody.conversation

            return DEPRECATED_ChatSendMessage(arg1, conversation.id, var1, nil, true, arg2):andThen(function()
                local function handleResult(arg5)
                    return {
                        resultType = arg5.responseBody.resultType,
                        conversationId = conversation.id,
                        placeId = arg3.universeRootPlaceId
                    }
                end

                return DEPRECATED_ChatSendGameLinkMessage(arg1, conversation.id, arg3.universeId, nil, true, arg2, arg3.universeRootPlaceId):andThen(
                    handleResult
                )
            end)
        end)
    end
end
