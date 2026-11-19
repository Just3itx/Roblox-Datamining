-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatModules = Chat:WaitForChild("ChatModules")
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local DisplayNameHelpers = require(ChatModules.Utility.DisplayNameHelpers)

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var1 = var1 == nil and {} or var1
if not (var1.FormatMessageToSend and var1.LocalizeFormattedMessage) then
    function var1.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end
local tbl1 = {
    ChatColor = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
}
local bool1 = false
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserUseNewDirectChatAPI")
end)
if success then
    bool1 = result
end

local function GetWhisperChannelPrefix() -- Luacid: Inlined by compiler; 5 call sites recovered
    return if ChatConstants.WhisperChannelPrefix then ChatConstants.WhisperChannelPrefix else "To "
end

local function GetWhisperChannelId(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return GetWhisperChannelPrefix() .. arg1
end

local function Run(arg1)
    local function CanCommunicate(speaker, speaker2)
        if RunService:IsStudio() then
            return true
        end
        local player = speaker:GetPlayer()
        local player2 = speaker2:GetPlayer()
        if not (player and player2) then
            return false
        end

        if bool1 then
            local success2, result2 = pcall(function()
                return TextChatService:CanUsersDirectChatAsync(player.UserId, { player2.UserId })
            end)
            return success2 and #result2 > 0
        end
        local success2, result2 = pcall(function(): boolean
            return Chat:CanUsersChatAsync(player.UserId, player2.UserId)
        end)
        return success2 and result2
    end

    local function DoWhisperCommand(arg2, str1: string, arg3)
        local speaker = arg1:GetSpeaker(arg2)

        local var2 = nil

        if string.sub(str1, 1, 1) == "\"" then
            local var3 = string.find(str1, "\"", 2)
            if var3 then
                local str2 = string.sub(str1, 2, var3 - 1)
                var2 = string.sub(str1, var3 + 2)
                str1 = str2
            end
        else
            local var3 = string.match(str1, "^[^%s]+")
            if var3 then
                var2 = string.sub(str1, string.len(var3) + 2)
                str1 = var3
            end
        end

        local var3, var4

        if ChatSettings.PlayerDisplayNamesEnabled and ChatSettings.WhisperByDisplayNameEnabled then
            var3, var4 = DisplayNameHelpers.getUserNameFromChattedName(str1, arg2, speaker:GetNameForDisplay())
        else
            var3, var4 = DisplayNameHelpers.getUserNameFromChattedName(str1, arg2, nil)
        end

        local speaker2 = arg1:GetSpeaker(var3)

        if var4 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend("GameChat_PrivateMessaging_CannotWhisperToSelf", "You cannot whisper to yourself."),
                arg3,
                tbl1
            )
            return
        end
        if var4 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_MuteSpeaker_SpeakerDoesNotExist",
                    string.format("Speaker '%s' does not exist.", tostring(str1)),
                    "RBX_NAME",
                    tostring(var3)
                ),
                arg3,
                tbl1
            )
            return
        end
        if var4 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
            local usersWithDisplayNameString = DisplayNameHelpers.getUsersWithDisplayNameString(str1, arg2)
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "InGame.Chat.Response.DisplayNameMultipleMatches",
                    "Warning: The following users have this display name: "
                ),
                arg3,
                tbl1
            )

            speaker:SendSystemMessage(usersWithDisplayNameString, arg3, tbl1)
            return
        end
        if not speaker2 then
            return
        end

        local channel = arg1:GetChannel((GetWhisperChannelId(var3)))

        if not channel then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_MuteSpeaker_SpeakerDoesNotExist",
                    string.format("Speaker '%s' does not exist.", tostring(str1)),
                    "RBX_NAME",
                    tostring(var3)
                ),
                arg3,
                tbl1
            )
            return
        end

        if not CanCommunicate(speaker, speaker2) then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend("GameChat_PrivateMessaging_CannotChat", "You are not able to chat with this player."),
                arg3,
                tbl1
            )
            return
        end

        if not speaker:IsInChannel(channel.Name) then
            speaker:JoinChannel(channel.Name)
        end

        if var2 and string.len(var2) > 0 then
            speaker:SayMessage(var2, channel.Name)
        end

        speaker:SetMainChannel(channel.Name)
    end

    local function PrivateMessageReplicationFunction(arg2, arg3, arg4): boolean
        local speaker = arg1:GetSpeaker(arg2)
        local extraData = speaker.ExtraData
        speaker:SendMessage(arg3, arg4, arg2, extraData)

        local speaker2 = arg1:GetSpeaker(string.sub(arg4, 4))
        local whisperChannelId = GetWhisperChannelId(arg2)

        if speaker2 then
            if not speaker2:IsInChannel(whisperChannelId) then
                speaker2:JoinChannel(whisperChannelId)
            end
            speaker2:SendMessage(arg3, whisperChannelId, arg2, extraData)
        end

        return true
    end

    local function PrivateMessageAddTypeFunction(_, arg2, _)
        if ChatConstants.MessageTypeWhisper then
            arg2.MessageType = ChatConstants.MessageTypeWhisper
        end
    end

    arg1:RegisterProcessCommandsFunction("whisper_commands", function(arg2, arg3, arg4) -- name: WhisperCommandsFunction
        local bool2 = false

        if string.sub(arg3, 1, 3):lower() == "/w " then
            DoWhisperCommand(arg2, string.sub(arg3, 4), arg4)
            return true
        end
        if string.sub(arg3, 1, 9):lower() == "/whisper " then
            DoWhisperCommand(arg2, string.sub(arg3, 10), arg4)
            bool2 = true
        end

        return bool2
    end, ChatConstants.StandardPriority)

    local function GetWhisperChanneNameColor() -- Luacid: Inlined by compiler; 1 call site recovered
        if ChatSettings.WhisperChannelNameColor then
            return ChatSettings.WhisperChannelNameColor
        end
        return Color3.fromRGB(102, 14, 102)
    end

    arg1.SpeakerAdded:connect(function(arg2)
        local speaker = arg1:GetSpeaker(arg2)
        local var2 = if ChatSettings.PlayerDisplayNamesEnabled and speaker:GetPlayer() then speaker:GetNameForDisplay() .. "(@" .. arg2 .. ")" else arg2
        local whisperChannelId = GetWhisperChannelId(arg2)

        if arg1:GetChannel(whisperChannelId) then
            arg1:RemoveChannel(whisperChannelId)
        end

        local var3 = arg1:AddChannel(whisperChannelId)
        var3.Joinable = false
        var3.Leavable = true
        var3.AutoJoin = false
        var3.Private = true

        var3.WelcomeMessage = var1:FormatMessageToSend(
            "GameChat_PrivateMessaging_NowChattingWith",
            "You are now privately chatting with " .. var2 .. ".",
            "RBX_NAME",
            tostring(var2)
        )
        var3.ChannelNameColor = GetWhisperChanneNameColor()

        var3:RegisterProcessCommandsFunction(
            "replication_function",
            PrivateMessageReplicationFunction,
            ChatConstants.LowPriority
        )
        var3:RegisterFilterMessageFunction("message_type_function", PrivateMessageAddTypeFunction)
    end)

    arg1.SpeakerRemoved:connect(function(arg2)
        local whisperChannelId = GetWhisperChannelId(arg2)

        if arg1:GetChannel(whisperChannelId) then
            arg1:RemoveChannel(whisperChannelId)
        end
    end)
end

return Run
