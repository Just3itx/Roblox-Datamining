-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))

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

local function Run(arg1)
    local function ShowJoinAndLeaveCommands() -- Luacid: Inlined by compiler; 1 call site recovered
        return not (ChatSettings.ShowJoinAndLeaveHelpText == nil) and ChatSettings.ShowJoinAndLeaveHelpText
    end

    arg1:RegisterProcessCommandsFunction("chat_commands_inquiry", function(arg2, arg3, arg4): boolean -- name: ProcessCommandsFunction
        if arg3:lower() ~= "/?" and arg3:lower() ~= "/help" then
            return false
        end

        local speaker = arg1:GetSpeaker(arg2)
        speaker:SendSystemMessage(
            var1:FormatMessageToSend("GameChat_ChatCommandsTeller_Desc", "These are the basic chat commands."),
            arg4
        )

        if ChatSettings.AllowMeCommand then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend("GameChat_ChatCommandsTeller_MeCommand", "/me <text> : roleplaying command for doing actions."),
                arg4
            )
        end

        speaker:SendSystemMessage(
            var1:FormatMessageToSend("GameChat_ChatCommandsTeller_SwitchChannelCommand", "/c <channel> : switch channel menu tabs."),
            arg4
        )

        if ShowJoinAndLeaveCommands() then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_ChatCommandsTeller_JoinChannelCommand",
                    "/join <channel> or /j <channel> : join channel."
                ),
                arg4
            )
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_ChatCommandsTeller_LeaveChannelCommand",
                    "/leave <channel> or /l <channel> : leave channel. (leaves current if none specified)"
                ),
                arg4
            )
        end

        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatCommandsTeller_WhisperCommand",
                "/whisper <speaker> or /w <speaker> : open private message channel with speaker."
            ),
            arg4
        )
        speaker:SendSystemMessage(
            var1:FormatMessageToSend("GameChat_ChatCommandsTeller_MuteCommand", "/mute <speaker> : mute a speaker."),
            arg4
        )
        speaker:SendSystemMessage(
            var1:FormatMessageToSend("GameChat_ChatCommandsTeller_UnMuteCommand", "/unmute <speaker> : unmute a speaker."),
            arg4
        )
        local player = speaker:GetPlayer()
        if player and player.Team then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_ChatCommandsTeller_TeamCommand",
                    "/team <message> or /t <message> : send a team chat to players on your team."
                ),
                arg4
            )
        end
        return true
    end, ChatConstants.StandardPriority)

    if not ChatSettings.GeneralChannelName then
        return
    end

    local channel = arg1:GetChannel(ChatSettings.GeneralChannelName)
    if channel then
        channel.WelcomeMessage = var1:FormatMessageToSend(
            "GameChat_ChatCommandsTeller_AllChannelWelcomeMessage",
            "Chat '/?' or '/help' for a list of chat commands."
        )
    end
end

return Run
