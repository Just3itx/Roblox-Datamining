-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:51Z
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
local tbl1 = {
    ChatColor = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
}
local function Run(arg1)
    local Players = game:GetService("Players")

    local var2 = arg1:AddChannel("Team")
    var2.WelcomeMessage = var1:FormatMessageToSend(
        "GameChat_TeamChat_WelcomeMessage",
        "This is a private channel between you and your team members."
    )
    var2.Joinable = false
    var2.Leavable = false
    var2.AutoJoin = false
    var2.Private = true

    var2:RegisterProcessCommandsFunction("replication_function", function(arg2, arg3, arg4): boolean -- name: TeamChatReplicationFunction
        local speaker = arg1:GetSpeaker(arg2)
        local channel = arg1:GetChannel(arg4)
        if speaker and channel then
            local player = speaker:GetPlayer()
            if player then
                for _, value in pairs(channel:GetSpeakerList()) do
                    local speaker2 = arg1:GetSpeaker(value)
                    if not speaker2 then
                        continue
                    end

                    local player2 = speaker2:GetPlayer()
                    if not player2 or player.Team ~= player2.Team then
                        continue
                    end

                    local tbl2 = {
                        NameColor = player.TeamColor.Color,
                        ChatColor = player.TeamColor.Color,
                        ChannelColor = player.TeamColor.Color
                    }
                    speaker2:SendMessage(arg3, arg4, arg2, tbl2)
                end
            end
        end

        return true
    end, ChatConstants.LowPriority)

    local function DoTeamCommand(arg2, str1: string, arg3)
        str1 = if str1 == nil then "" else str1

        local speaker = arg1:GetSpeaker(arg2)
        if not speaker then
            return
        end

        local player = speaker:GetPlayer()

        if not player then
            return
        end

        if player.Team == nil then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_TeamChat_CannotTeamChatIfNotInTeam",
                    "You cannot team chat if you are not on a team!"
                ),
                arg3,
                tbl1
            )
            return
        end

        local channel = arg1:GetChannel("Team")
        if not channel then
            return
        end

        if not speaker:IsInChannel(channel.Name) then
            speaker:JoinChannel(channel.Name)
        end
        if str1 and string.len(str1) > 0 then
            speaker:SayMessage(str1, channel.Name)
        end
        speaker:SetMainChannel(channel.Name)
    end

    arg1:RegisterProcessCommandsFunction("team_commands", function(arg2, arg3, arg4) -- name: TeamCommandsFunction
        local bool1 = false

        if arg3 == nil then
            error("Message is nil")
        end

        if arg4 == "Team" then
            return false
        elseif string.sub(arg3, 1, 6):lower() == "/team " or arg3:lower() == "/team" then
            DoTeamCommand(arg2, string.sub(arg3, 7), arg4)
            return true
        elseif string.sub(arg3, 1, 3):lower() == "/t " or arg3:lower() == "/t" then
            DoTeamCommand(arg2, string.sub(arg3, 4), arg4)
            return true
        else
            if string.sub(arg3, 1, 2):lower() == "% " or arg3:lower() == "%" then
                DoTeamCommand(arg2, string.sub(arg3, 3), arg4)
                bool1 = true
            end

            return bool1
        end
    end, ChatConstants.StandardPriority)

    local function GetDefaultChannelNameColor()
        if ChatSettings.DefaultChannelNameColor then
            return ChatSettings.DefaultChannelNameColor
        end
        return Color3.fromRGB(35, 76, 142)
    end

    local function PutSpeakerInCorrectTeamChatState(speaker, player)
        if player.Neutral or player.Team == nil then
            speaker:UpdateChannelNameColor(var2.Name, GetDefaultChannelNameColor())

            if speaker:IsInChannel(var2.Name) then
                speaker:LeaveChannel(var2.Name)
            end
        elseif not player.Neutral and player.Team then
            speaker:UpdateChannelNameColor(var2.Name, player.Team.TeamColor.Color)

            if not speaker:IsInChannel(var2.Name) then
                speaker:JoinChannel(var2.Name)
            end
        end
    end

    arg1.SpeakerAdded:connect(function(arg2)
        local speaker = arg1:GetSpeaker(arg2)
        if not speaker then
            return
        end

        local player = speaker:GetPlayer()
        if player then
            PutSpeakerInCorrectTeamChatState(speaker, player)
        end
    end)

    local tbl2 = ({})
    Players.PlayerAdded:connect(function(player: Player)
        tbl2[player] = player.Changed:connect(function(property: string)
            local speaker = arg1:GetSpeaker(player.Name)
            if not speaker then
                return
            end

            if property == "Neutral" then
                PutSpeakerInCorrectTeamChatState(speaker, player)
                return
            end

            if property ~= "Team" then
                return
            end

            PutSpeakerInCorrectTeamChatState(speaker, player)
            if speaker:IsInChannel(var2.Name) then
                speaker:SendSystemMessage(
                    var1:FormatMessageToSend(
                        "GameChat_TeamChat_NowInTeam",
                        string.format("You are now on the '%s' team.", player.Team.Name),
                        "RBX_NAME",
                        player.Team.Name
                    ),
                    var2.Name
                )
            end
        end)
    end)

    Players.PlayerRemoving:connect(function(player: Player)
        local var3 = tbl2[player]
        if var3 then
            var3:Disconnect()
        end
        tbl2[player] = nil
    end)
end

return Run
