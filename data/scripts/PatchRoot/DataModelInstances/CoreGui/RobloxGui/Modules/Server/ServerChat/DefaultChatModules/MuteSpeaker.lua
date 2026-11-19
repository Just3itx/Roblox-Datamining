-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
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
local function Run(arg1)
    local function GetSpeakerNameFromMessage(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if string.sub(str1, 1, 1) == "\"" then
            local var2 = string.find(str1, "\"", 2)
            if var2 then
                return string.sub(str1, 2, var2 - 1)
            end
        else
            str1 = string.match(str1, "^[^%s]+") or str1
        end

        return str1
    end

    local function DoMuteCommand(arg2, str1: string, arg3)
        local speakerNameFromMessage = GetSpeakerNameFromMessage(str1)
        local speaker = arg1:GetSpeaker(arg2)

        if not speaker then
            return
        end

        local nameForDisplay, var2

        if ChatSettings.PlayerDisplayNamesEnabled then
            nameForDisplay, var2 = DisplayNameHelpers.getUserNameFromChattedName(speakerNameFromMessage, arg2, speaker:GetNameForDisplay())
        else
            nameForDisplay, var2 = DisplayNameHelpers.getUserNameFromChattedName(speakerNameFromMessage, arg2, nil)
        end

        local speaker2 = arg1:GetSpeaker(nameForDisplay)

        if var2 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."),
                arg3,
                tbl1
            )
            return
        end
        if var2 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_MuteSpeaker_SpeakerDoesNotExist",
                    string.format("Speaker '%s' does not exist.", tostring(speakerNameFromMessage)),
                    "RBX_NAME",
                    tostring(nameForDisplay)
                ),
                arg3,
                tbl1
            )
            return
        end
        if var2 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
            local usersWithDisplayNameString = DisplayNameHelpers.getUsersWithDisplayNameString(speakerNameFromMessage, arg2)
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

        speaker:AddMutedSpeaker(speaker2.Name)

        if ChatSettings.PlayerDisplayNamesEnabled then
            nameForDisplay = speaker2:GetNameForDisplay()
        end

        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatMain_SpeakerHasBeenMuted",
                string.format("Speaker '%s' has been muted.", nameForDisplay),
                "RBX_NAME",
                nameForDisplay
            ),
            arg3
        )
    end

    local function DoUnmuteCommand(arg2, str1: string, arg3)
        local speakerNameFromMessage = GetSpeakerNameFromMessage(str1)
        local speaker = arg1:GetSpeaker(arg2)

        if not speaker then
            return
        end

        local nameForDisplay, var2

        if ChatSettings.PlayerDisplayNamesEnabled then
            nameForDisplay, var2 = DisplayNameHelpers.getUserNameFromChattedName(speakerNameFromMessage, arg2, speaker:GetNameForDisplay())
        else
            nameForDisplay, var2 = DisplayNameHelpers.getUserNameFromChattedName(speakerNameFromMessage, arg2, nil)
        end

        local speaker2 = arg1:GetSpeaker(nameForDisplay)

        if var2 == DisplayNameHelpers.CommandErrorCodes.ChattingToSelf then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend("GameChat_DoMuteCommand_CannotMuteSelf", "You cannot mute yourself."),
                arg3,
                tbl1
            )
            return
        end
        if var2 == DisplayNameHelpers.CommandErrorCodes.NoMatches then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_MuteSpeaker_SpeakerDoesNotExist",
                    string.format("Speaker '%s' does not exist.", tostring(nameForDisplay)),
                    "RBX_NAME",
                    tostring(nameForDisplay)
                ),
                arg3,
                tbl1
            )
            return
        end
        if var2 == DisplayNameHelpers.CommandErrorCodes.MultipleMatches then
            local usersWithDisplayNameString = DisplayNameHelpers.getUsersWithDisplayNameString(speakerNameFromMessage, arg2)
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

        speaker:RemoveMutedSpeaker(speaker2.Name)

        if ChatSettings.PlayerDisplayNamesEnabled then
            nameForDisplay = speaker2:GetNameForDisplay()
        end

        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatMain_SpeakerHasBeenUnMuted",
                string.format("Speaker '%s' has been unmuted.", nameForDisplay),
                "RBX_NAME",
                nameForDisplay
            ),
            arg3
        )
    end

    arg1:RegisterProcessCommandsFunction("mute_commands", function(arg2, arg3, arg4) -- name: MuteCommandsFunction
        local bool1 = false

        if string.sub(arg3, 1, 6):lower() == "/mute " then
            DoMuteCommand(arg2, string.sub(arg3, 7), arg4)
            return true
        end

        if string.sub(arg3, 1, 8):lower() == "/unmute " then
            DoUnmuteCommand(arg2, string.sub(arg3, 9), arg4)
            bool1 = true
        end

        return bool1
    end, ChatConstants.StandardPriority)
end

return Run
