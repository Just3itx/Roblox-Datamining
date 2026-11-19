-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local script = script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")

local ChatService = require(script:WaitForChild("ChatService"))

local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local var1 = nil
pcall(function()
    var1 = require(Chat.ClientChatModules.ChatLocalization)
end)

var1 = var1 or {}

local MaxChannelNameCheckLength = ChatSettings.MaxChannelNameCheckLength or 50
local MaximumMessageLength = ChatSettings.MaximumMessageLength

if not (var1.FormatMessageToSend and var1.LocalizeFormattedMessage) then
    function var1.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end

local tbl1 = ({})

local DefaultChatSystemChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
if not DefaultChatSystemChatEvents then
    DefaultChatSystemChatEvents = Instance.new("Folder")
    DefaultChatSystemChatEvents.Name = "DefaultChatSystemChatEvents"
    DefaultChatSystemChatEvents.Archivable = false
    DefaultChatSystemChatEvents.Parent = ReplicatedStorage
end

local function validateMessageLength(str1: string): boolean
    if str1:len() > MaximumMessageLength * 6 then
        return false
    end

    if utf8.len(str1) == nil then
        return false
    end

    local var2 = utf8.len(utf8.nfcnormalize(str1))
    return not (MaximumMessageLength < var2)
end

local function validateChannelNameLength(str1: string): boolean
    if str1:len() > MaxChannelNameCheckLength * 6 then
        return false
    end

    if utf8.len(str1) == nil then
        return false
    end

    local var2 = utf8.len(utf8.nfcnormalize(str1))
    return not (MaxChannelNameCheckLength < var2)
end

local function emptyFunction() end

local function GetObjectWithNameAndType(arg1: Instance, name: string, className: string)
    for _, child in pairs(arg1:GetChildren()) do
        if child:IsA(className) and child.Name == name then
            return child
        end
    end

    return nil
end

local function CreateIfDoesntExist(arg1: Instance, name: string, className: string) -- Luacid: Inlined by compiler; 15 call sites recovered
    local objectWithNameAndType = GetObjectWithNameAndType(arg1, name, className)
    if not objectWithNameAndType then
        objectWithNameAndType = Instance.new(className)
        objectWithNameAndType.Name = name
        objectWithNameAndType.Parent = arg1
    end
    tbl1[name] = objectWithNameAndType

    return objectWithNameAndType
end

local function CreateEventIfItDoesntExist(arg1: Instance, name: string) -- Luacid: Inlined by compiler; 11 call sites recovered
    local ifDoesntExist = CreateIfDoesntExist(arg1, name, "RemoteEvent")
    ifDoesntExist.OnServerEvent:Connect(emptyFunction)
    return ifDoesntExist
end

CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnNewMessage")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnMessageDoneFiltering")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnNewSystemMessage")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnChannelJoined")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnChannelLeft")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnMuted")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnUnmuted")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "OnMainChannelSet")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "ChannelNameColorUpdated")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "SayMessageRequest")
CreateEventIfItDoesntExist(DefaultChatSystemChatEvents, "SetBlockedUserIdsRequest")
CreateIfDoesntExist(DefaultChatSystemChatEvents, "GetInitDataRequest", "RemoteFunction")
CreateIfDoesntExist(DefaultChatSystemChatEvents, "MutePlayerRequest", "RemoteFunction")
CreateIfDoesntExist(DefaultChatSystemChatEvents, "UnMutePlayerRequest", "RemoteFunction")
local tbl2 = tbl1

local function CreatePlayerSpeakerObject(arg1)
    if ChatService:GetSpeaker(arg1.Name) then
        ChatService:RemoveSpeaker(arg1.Name)
    end

    local var2 = ChatService:InternalAddSpeakerWithPlayerObject(arg1.Name, arg1, false)

    for _, value in pairs(ChatService:GetAutoJoinChannelList()) do
        local valueName = value.Name
        var2:JoinChannel(valueName)
    end

    var2:InternalAssignEventFolder(tbl2)

    var2.ChannelJoined:connect(function(arg2, arg3)
        local channel = ChatService:GetChannel(arg2)
        local historyLogForSpeaker, channelNameColor

        if channel then
            historyLogForSpeaker = channel:GetHistoryLogForSpeaker(var2)
            channelNameColor = channel.ChannelNameColor
        else
            historyLogForSpeaker = nil
            channelNameColor = nil
        end
        tbl2.OnChannelJoined:FireClient(arg1, arg2, arg3, historyLogForSpeaker, channelNameColor)
    end)

    var2.Muted:connect(function(arg2, arg3, arg4)
        tbl2.OnMuted:FireClient(arg1, arg2, arg3, arg4)
    end)

    var2.Unmuted:connect(function(arg2)
        tbl2.OnUnmuted:FireClient(arg1, arg2)
    end)

    ChatService:InternalFireSpeakerAdded(var2.Name)
end

tbl2.SayMessageRequest.OnServerEvent:connect(function(player: Player, arg1, arg2)
    if type(arg1) ~= "string"
        or not validateMessageLength(arg1)
        or type(arg2) ~= "string"
        or not validateChannelNameLength(arg2)
    then
        return
    end

    local speaker = ChatService:GetSpeaker(player.Name)
    if speaker then
        return speaker:SayMessage(arg1, arg2)
    end

    return nil
end)

function tbl2.MutePlayerRequest.OnServerInvoke(arg1, arg2)
    if type(arg2) ~= "string" then
        return
    end

    local speaker = ChatService:GetSpeaker(arg1.Name)
    if speaker then
        local speaker2 = ChatService:GetSpeaker(arg2)
        if speaker2 then
            speaker:AddMutedSpeaker(speaker2.Name)
            return true
        end
    end
    return false
end

function tbl2.UnMutePlayerRequest.OnServerInvoke(arg1, arg2)
    if type(arg2) ~= "string" then
        return
    end

    local speaker = ChatService:GetSpeaker(arg1.Name)
    if speaker then
        local speaker2 = ChatService:GetSpeaker(arg2)
        if speaker2 then
            speaker:RemoveMutedSpeaker(speaker2.Name)
            return true
        end
    end
    return false
end

local tbl3 = ({})

Players.PlayerAdded:connect(function(player: Player)
    for k, value in pairs(tbl3) do
        local speaker = ChatService:GetSpeaker(k.Name)
        if not speaker then
            continue
        end

        for i = 1, #value do
            if value[i] == player.UserId then
                speaker:AddMutedSpeaker(player.Name)
            end
        end
    end
end)

Players.PlayerRemoving:connect(function(player: Player)
    tbl3[player] = nil
end)

tbl2.SetBlockedUserIdsRequest.OnServerEvent:Connect(function(player: Player, arg1)
    if type(arg1) ~= "table" then
        return
    end

    local tbl4 = {}
    local speaker = ChatService:GetSpeaker(player.Name)
    if not speaker then
        return
    end

    local num1 = #arg1

    for i = 1, math.min(num1, 50) do
        if type(arg1[i]) ~= "number" then
            continue
        end
        table.insert(tbl4, arg1[i])

        local player2 = Players:GetPlayerByUserId(arg1[i])
        if player2 then
            speaker:AddMutedSpeaker(player2.Name)
        end
    end

    tbl3[player] = tbl4
end)

function tbl2.GetInitDataRequest.OnServerInvoke(arg1)
    local speaker = ChatService:GetSpeaker(arg1.Name)
    if not (speaker and speaker:GetPlayer()) then
        CreatePlayerSpeakerObject(arg1)
        speaker = ChatService:GetSpeaker(arg1.Name)
    end

    local tbl4 = {
        Channels = {},
        SpeakerExtraData = {}
    }
    for _, value in pairs(speaker:GetChannelList()) do
        local channel = ChatService:GetChannel(value)
        if not channel then
            continue
        end
        local tbl5 = {
            value,
            channel:GetWelcomeMessageForSpeaker(speaker),
            channel:GetHistoryLogForSpeaker(speaker),
            channel.ChannelNameColor
        }

        table.insert(tbl4.Channels, tbl5)
    end

    for _, value in pairs(ChatService:GetSpeakerList()) do
        local speaker2 = ChatService:GetSpeaker(value)
        tbl4.SpeakerExtraData[value] = speaker2.ExtraData
    end

    return tbl4
end

local function DoJoinCommand(arg1, str1: string, arg2)
    local speaker = ChatService:GetSpeaker(arg1)
    local channel = ChatService:GetChannel(str1)

    if not speaker then
        return
    end

    if not channel then
        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatServiceRunner_ChannelDoesNotExist",
                "Channel '" .. str1 .. "' does not exist.",
                "RBX_NAME",
                str1
            ),
            arg2
        )
        return
    end

    if not channel.Joinable then
        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatServiceRunner_YouCannotJoinChannel",
                "You cannot join channel '" .. str1 .. "'.",
                "RBX_NAME",
                str1
            ),
            arg2
        )
        return
    end

    if not speaker:IsInChannel(channel.Name) then
        speaker:JoinChannel(channel.Name)
        return
    end
    speaker:SetMainChannel(channel.Name)
    speaker:SendSystemMessage(
        var1:FormatMessageToSend(
            "GameChat_SwitchChannel_NowInChannel",
            string.format("You are now chatting in channel: '%s'", channel.Name),
            "RBX_NAME",
            channel.Name
        ),
        channel.Name
    )
end

local function DoLeaveCommand(arg1, str1: string, arg2)
    local speaker = ChatService:GetSpeaker(arg1)
    local channel = ChatService:GetChannel(str1)

    if not speaker then
        return
    end

    if not speaker:IsInChannel(str1) then
        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatServiceRunner_YouAreNotInChannel",
                "You are not in channel '" .. str1 .. "'.",
                "RBX_NAME",
                str1
            ),
            arg2
        )
        return
    end

    if channel.Leavable then
        speaker:LeaveChannel(channel.Name)
        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatService_YouHaveLeftChannel",
                string.format("You have left channel '%s'", str1),
                "RBX_NAME",
                channel.Name
            ),
            "System"
        )
        return
    end
    speaker:SendSystemMessage(
        var1:FormatMessageToSend(
            "GameChat_ChatServiceRunner_YouCannotLeaveChannel",
            "You cannot leave channel '" .. str1 .. "'.",
            "RBX_NAME",
            str1
        ),
        arg2
    )
end

ChatService:RegisterProcessCommandsFunction("default_commands", function(arg1, arg2, arg3): boolean
    if string.sub(arg2, 1, 6):lower() == "/join " then
        DoJoinCommand(arg1, string.sub(arg2, 7), arg3)
        return true
    end

    if string.sub(arg2, 1, 3):lower() == "/j " then
        DoJoinCommand(arg1, string.sub(arg2, 4), arg3)
        return true
    end

    if string.sub(arg2, 1, 7):lower() == "/leave " then
        DoLeaveCommand(arg1, string.sub(arg2, 8), arg3)
        return true
    end

    if string.sub(arg2, 1, 3):lower() ~= "/l " then
        return false
    end

    DoLeaveCommand(arg1, string.sub(arg2, 4), arg3)
    return true
end)

if ChatSettings.GeneralChannelName and ChatSettings.GeneralChannelName ~= "" then
    local var2 = ChatService:AddChannel(ChatSettings.GeneralChannelName)

    var2.Leavable = false
    var2.AutoJoin = true

    var2:RegisterGetWelcomeMessageFunction(function(arg1)
        if RunService:IsStudio() then
            return nil
        end
        local player = arg1:GetPlayer()
        if not player then
            return
        end

        local success, result = pcall(function(): boolean
            return Chat:CanUserChatAsync(player.UserId)
        end)
        if success and not result then
            return ""
        end
    end)
end

local var2 = ChatService:AddChannel("System")
var2.Leavable = false
var2.AutoJoin = true
var2.WelcomeMessage = var1:FormatMessageToSend(
    "GameChat_ChatServiceRunner_SystemChannelWelcomeMessage",
    "This channel is for system and game notifications."
)

var2.SpeakerJoined:connect(function(arg1)
    var2:MuteSpeaker(arg1)
end)

local function TryRunModule(arg1: Instance)
    if not arg1:IsA("ModuleScript") then
        return
    end

    local var3 = require(arg1)
    if type(var3) == "function" then
        var3(ChatService)
    end
end

local ChatModules = Chat:WaitForChild("ChatModules")
ChatModules.ChildAdded:connect(function(child: Instance)
    local success, result = pcall(TryRunModule, child)
    if not success and result then
        print("Error running module " .. child.Name .. ": " .. result)
    end
end)

for _, child in pairs(ChatModules:GetChildren()) do
    local success, result = pcall(TryRunModule, child)
    if not success and result then
        print("Error running module " .. child.Name .. ": " .. result)
    end
end

Players.PlayerRemoving:connect(function(player: Player)
    if ChatService:GetSpeaker(player.Name) then
        ChatService:RemoveSpeaker(player.Name)
    end
end)
