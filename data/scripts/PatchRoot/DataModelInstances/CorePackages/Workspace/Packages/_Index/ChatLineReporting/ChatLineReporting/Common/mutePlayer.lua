-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local ChatMute = require(ChatLineReportingParent.ChatMute)

local ExpChatShared = require(ChatLineReportingParent.ExpChatShared)
local RBXMuteCommand = require(ChatLineReportingParent.ExpChatShared).Commands.RBXMuteCommand

local Constants = require(ChatLineReporting.Common.Constants)

local FFlagExpChatUseChatMuteStore = require(ChatLineReportingParent.SharedFlags).FFlagExpChatUseChatMuteStore

local bool1 = game:DefineFastFlag("ExpChatMuteByUserIdBeforeUsernameCheck", false)

function mutePlayer(arg1, arg2, arg3)
    if FFlagExpChatUseChatMuteStore then
        if arg1.username == "" and not (bool1 and tonumber(arg1.userId)) then
            return {
                key = Constants.ErrorDoesNotExistKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = "Roblox.Mute.Error.PlayerNotFound"
            }
        end
        if tonumber(arg1.userId) == arg2.UserId then
            return {
                key = Constants.ErrorSelfMuteKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = "Roblox.Mute.Error.CannotMuteSelf"
            }
        end
        if tonumber(arg1.userId) then
            ChatMute.mutePlayer({ userId = arg1.userId })
            return {
                key = Constants.SuccessfulMuteKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = if arg3 then "Roblox.GlobalMute.Info.Success" else "Roblox.Mute.Info.Success"
            }
        end
        local var1 = ChatMute.resolveMuteTarget(arg1.displayName, tostring(arg2.UserId))
        if var1.playerInfo then
            ChatMute.mutePlayer(var1.playerInfo)
        end
        return {
            key = var1.key,
            args = var1.args,
            metadata = if var1.playerInfo then "Roblox.Mute.Info.Success" else "Roblox.Mute.Error.Unknown"
        }
    end

    local context = ExpChatShared.context
    local var1 = nil
    if arg3 then
        if tonumber(arg1.userId) then
            if not context.globalMutedUsersStore then
                return {
                    key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                    args = {
                        RBX_NAME = arg1.displayName
                    },
                    metadata = "Roblox.GlobalMute.Error.ContextNotAvailable"
                }
            end

            context.globalMutedUsersStore.muteGlobalUserId(arg1.userId)
            return {
                key = Constants.SuccessfulMuteKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = "Roblox.GlobalMute.Info.Success"
            }
        end
    else
        if arg1.username == "" then
            return {
                key = Constants.ErrorDoesNotExistKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = "Roblox.Mute.Error.PlayerNotFound"
            }
        end
        if tonumber(arg1.userId) == arg2.UserId then
            return {
                key = Constants.ErrorSelfMuteKey,
                args = {
                    RBX_NAME = arg1.displayName
                },
                metadata = "Roblox.Mute.Error.CannotMuteSelf"
            }
        end
        if not tonumber(arg1.userId) then
            return RBXMuteCommand.clientRun(context.store, arg2.UserId, "/mute " .. arg1.displayName, context)
        end

        if context.store then
            if not (context and context.messagesStore) then
                return {
                    key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                    args = {
                        RBX_NAME = arg1.displayName
                    },
                    metadata = "Roblox.Mute.Error.ContextNotAvailable"
                }
            end

            context.messagesStore.muteUser(arg1.userId)
            return var1
        end
    end

    return var1
end

return mutePlayer
