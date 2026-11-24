-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getPlayersFromString = require(script.Parent.getPlayersFromString)
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local FFlagExpChatUseChatMuteStore = require(ExpChatSharedParent.SharedFlags).FFlagExpChatUseChatMuteStore
local ChatMute = require(ExpChatSharedParent.ChatMute)

local tbl1 = {
    ["CoreScripts.TextChat.Mute.Error.TargetDoesNotExist"] = "Roblox.Unmute.Error.PlayerNotFound",
    ["CoreScripts.TextChat.Mute.Error.MultipleMatches"] = "Roblox.Unmute.Error.MultipleMatches",
    ["CoreScripts.TextChat.Mute.Error.CannotMuteSelf"] = "Roblox.Unmute.Error.CannotMuteSelf",
    ["CoreScripts.TextChat.Unmute.Success"] = "Roblox.Unmute.Info.Success"
}

local _types = require(script.Parent.types)
return {
    name = script.Name,
    alias = { "/unmute", "/um" },
    clientRun = function(arg1, arg2, arg3, arg4)
        if FFlagExpChatUseChatMuteStore then
            local var1 = ChatMute.resolveUnmuteTarget(string.split(arg3, " ")[2], tostring(arg2))
            if var1.playerInfo then
                ChatMute.unmutePlayer(var1.playerInfo)
            end
            return {
                key = var1.key,
                args = var1.args,
                metadata = tbl1[var1.key]
            }
        end
        local rbxName = string.split(arg3, " ")[2]
        if not rbxName then
            return {
                key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
                args = { RBX_NAME = "" },
                metadata = "Roblox.Unmute.Error.PlayerNotFound"
            }
        end

        local playersFromString = getPlayersFromString(arg1:getState().Players, rbxName)
        if #playersFromString == 0 then
            return {
                key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
                args = { RBX_NAME = rbxName },
                metadata = "Roblox.Unmute.Error.PlayerNotFound"
            }
        end

        if #playersFromString > 1 then
            return {
                key = "InGame.Chat.Response.DisplayNameMultipleMatches",
                args = {},
                metadata = "Roblox.Unmute.Error.MultipleMatches"
            }
        end

        local var1 = playersFromString[1]
        if var1.userId == tostring(arg2) then
            return {
                key = "CoreScripts.TextChat.Mute.Error.CannotMuteSelf",
                args = {},
                metadata = "Roblox.Unmute.Error.CannotMuteSelf"
            }
        end

        if not (arg4 and arg4.messagesStore) then
            return {
                key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                args = {},
                metadata = "Roblox.Unmute.Error.ContextNotAvailable"
            }
        end

        arg4.messagesStore.unmuteUser(var1.userId)

        return {
            key = "CoreScripts.TextChat.Unmute.Success",
            args = {
                RBX_NAME = var1.nameToDisplay
            },
            metadata = "Roblox.Unmute.Info.Success"
        }
    end
}
