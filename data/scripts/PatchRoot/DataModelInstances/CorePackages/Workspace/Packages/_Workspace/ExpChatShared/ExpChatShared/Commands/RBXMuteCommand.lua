-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getPlayersFromString = require(script.Parent.getPlayersFromString)
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local FFlagExpChatUseChatMuteStore = require(ExpChatSharedParent.SharedFlags).FFlagExpChatUseChatMuteStore
local ChatMute = require(ExpChatSharedParent.ChatMute)

local tbl1 = {
    ["CoreScripts.TextChat.Mute.Error.TargetDoesNotExist"] = "Roblox.Mute.Error.PlayerNotFound",
    ["CoreScripts.TextChat.Mute.Error.MultipleMatches"] = "Roblox.Mute.Error.MultipleMatches",
    ["CoreScripts.TextChat.Mute.Error.CannotMuteSelf"] = "Roblox.Mute.Error.CannotMuteSelf",
    ["CoreScripts.TextChat.Mute.Success"] = "Roblox.Mute.Info.Success"
}

local _types = require(script.Parent.types)
return {
    name = script.Name,
    alias = { "/mute", "/m" },
    clientRun = function(arg1, arg2, arg3, arg4)
        if FFlagExpChatUseChatMuteStore then
            local var1 = ChatMute.resolveMuteTarget(string.split(arg3, " ")[2], tostring(arg2))
            if var1.playerInfo then
                ChatMute.mutePlayer(var1.playerInfo)
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
                metadata = "Roblox.Mute.Error.PlayerNotFound"
            }
        end

        local playersFromString = getPlayersFromString(arg1:getState().Players, rbxName)
        if #playersFromString == 0 then
            return {
                key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
                args = { RBX_NAME = rbxName },
                metadata = "Roblox.Mute.Error.PlayerNotFound"
            }
        end

        if #playersFromString > 1 then
            return {
                key = "CoreScripts.TextChat.Mute.Error.MultipleMatches",
                args = {},
                metadata = "Roblox.Mute.Error.MultipleMatches"
            }
        end

        local var1 = playersFromString[1]
        if var1.userId == tostring(arg2) then
            return {
                key = "CoreScripts.TextChat.Mute.Error.CannotMuteSelf",
                args = {},
                metadata = "Roblox.Mute.Error.CannotMuteSelf"
            }
        end

        if not (arg4 and arg4.messagesStore) then
            return {
                key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                args = {},
                metadata = "Roblox.Mute.Error.ContextNotAvailable"
            }
        end

        arg4.messagesStore.muteUser(var1.userId)

        return {
            key = "CoreScripts.TextChat.Mute.Success",
            args = {
                RBX_NAME = var1.nameToDisplay
            },
            metadata = "Roblox.Mute.Info.Success"
        }
    end
}
