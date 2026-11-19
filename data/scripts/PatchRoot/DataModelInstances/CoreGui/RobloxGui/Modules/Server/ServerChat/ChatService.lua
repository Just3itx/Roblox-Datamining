-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { 0.05, 0.1, 0.2 }

local tbl2 = {}

local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local _ClientChatModules = Chat:WaitForChild("ClientChatModules")

local scriptParent = script.Parent
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local tbl3 = {
    ChatColor = require(ClientChatModules:WaitForChild("ChatSettings")).ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
}

local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))

local ChatChannel = require(scriptParent:WaitForChild("ChatChannel"))
local Speaker = require(scriptParent:WaitForChild("Speaker"))
local Util = require(scriptParent:WaitForChild("Util"))

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var1 = var1 or {}

if not (var1.FormatMessageToSend and var1.LocalizeFormattedMessage) then
    function var1.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end

local function allSpaces(stringToFilter: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return string.len((string.gsub(stringToFilter, " ", ""))) == 0
end

local tbl4 = {}
tbl4.__index = tbl4

function tbl4:AddChannel(arg1, autoJoin)
    if self.ChatChannels[arg1:lower()] then
        error(string.format("Channel %q alrady exists.", arg1))
    end

    local function DefaultChannelCommands(arg2, arg3): boolean
        if arg3:lower() ~= "/leave" then
            return false
        end

        local channel = self:GetChannel(arg1)
        local speaker = self:GetSpeaker(arg2)
        if channel and speaker then
            if channel.Leavable then
                speaker:LeaveChannel(arg1)
                speaker:SendSystemMessage(
                    var1:FormatMessageToSend(
                        "GameChat_ChatService_YouHaveLeftChannel",
                        string.format("You have left channel '%s'", arg1),
                        "RBX_NAME",
                        arg1
                    ),
                    "System"
                )
            else
                speaker:SendSystemMessage(
                    var1:FormatMessageToSend("GameChat_ChatService_CannotLeaveChannel", "You cannot leave this channel."),
                    arg1
                )
            end
        end
        return true
    end

    local chatChannel = ChatChannel.new(self, arg1)
    self.ChatChannels[arg1:lower()] = chatChannel

    chatChannel:RegisterProcessCommandsFunction("default_commands", DefaultChannelCommands, ChatConstants.HighPriority)

    local success, result = pcall(function()
        self.eChannelAdded:Fire(arg1)
    end)

    if not success and result then
        print("Error addding channel: " .. result)
    end

    if autoJoin ~= nil then
        chatChannel.AutoJoin = autoJoin
        if autoJoin then
            for _, speaker in pairs(self.Speakers) do
                speaker:JoinChannel(arg1)
            end
        end
    end

    return chatChannel
end

function tbl4:RemoveChannel(arg1)
    if not self.ChatChannels[arg1:lower()] then
        warn(string.format("Channel %q does not exist.", arg1))
        return
    end

    local name = self.ChatChannels[arg1:lower()].Name

    self.ChatChannels[arg1:lower()]:InternalDestroy()
    self.ChatChannels[arg1:lower()] = nil

    local success, result = pcall(function()
        self.eChannelRemoved:Fire(name)
    end)

    if not success and result then
        print("Error removing channel: " .. result)
    end
end

function tbl4:GetChannel(arg1)
    return self.ChatChannels[arg1:lower()]
end

function tbl4:AddSpeaker(arg1)
    if self.Speakers[arg1:lower()] then
        error("Speaker \"" .. arg1 .. "\" already exists!")
    end

    local speaker = Speaker.new(self, arg1)
    self.Speakers[arg1:lower()] = speaker

    local success, result = pcall(function()
        self.eSpeakerAdded:Fire(arg1)
    end)

    if not success and result then
        print("Error adding speaker: " .. result)
    end

    return speaker
end

function tbl4:InternalUnmuteSpeaker(arg1)
    for _, chatChannel in pairs(self.ChatChannels) do
        if chatChannel:IsSpeakerMuted(arg1) then
            chatChannel:UnmuteSpeaker(arg1)
        end
    end
end

function tbl4:RemoveSpeaker(arg1)
    if not self.Speakers[arg1:lower()] then
        warn("Speaker \"" .. arg1 .. "\" does not exist!")
        return
    end

    local name = self.Speakers[arg1:lower()].Name

    self:InternalUnmuteSpeaker(name)

    self.Speakers[arg1:lower()]:InternalDestroy()
    self.Speakers[arg1:lower()] = nil

    local success, result = pcall(function()
        self.eSpeakerRemoved:Fire(name)
    end)

    if not success and result then
        print("Error removing speaker: " .. result)
    end
end

function tbl4:GetSpeaker(arg1)
    return self.Speakers[arg1:lower()]
end

function tbl4:GetSpeakerByUserOrDisplayName(arg1)
    local speaker = self.Speakers[arg1:lower()]

    if speaker then
        return speaker
    end

    for _, speaker2 in pairs(self.Speakers) do
        local player = speaker2:GetPlayer()

        if player and player.DisplayName:lower() == arg1:lower() then
            return speaker2
        end
    end
end

function tbl4:GetChannelList()
    local channelList = {}
    for _, chatChannel in pairs(self.ChatChannels) do
        if not chatChannel.Private then
            table.insert(channelList, chatChannel.Name)
        end
    end
    return channelList
end

function tbl4:GetAutoJoinChannelList()
    local autoJoinChannelList = {}
    for _, chatChannel in pairs(self.ChatChannels) do
        if chatChannel.AutoJoin then
            table.insert(autoJoinChannelList, chatChannel)
        end
    end
    return autoJoinChannelList
end

function tbl4:GetSpeakerList()
    local speakerList = {}
    for _, speaker in pairs(self.Speakers) do
        table.insert(speakerList, speaker.Name)
    end
    return speakerList
end

function tbl4:SendGlobalSystemMessage(arg1)
    for _, speaker in pairs(self.Speakers) do
        speaker:SendSystemMessage(arg1, nil)
    end
end

function tbl4:RegisterFilterMessageFunction(arg1, arg2, arg3)
    if self.FilterMessageFunctions:HasFunction(arg1) then
        error(string.format("FilterMessageFunction '%s' already exists", arg1))
    end
    self.FilterMessageFunctions:AddFunction(arg1, arg2, arg3)
end

function tbl4:FilterMessageFunctionExists(arg1)
    return self.FilterMessageFunctions:HasFunction(arg1)
end

function tbl4:UnregisterFilterMessageFunction(arg1)
    if not self.FilterMessageFunctions:HasFunction(arg1) then
        error(string.format("FilterMessageFunction '%s' does not exists", arg1))
    end
    self.FilterMessageFunctions:RemoveFunction(arg1)
end

function tbl4:RegisterProcessCommandsFunction(arg1, arg2, arg3)
    if self.ProcessCommandsFunctions:HasFunction(arg1) then
        error(string.format("ProcessCommandsFunction '%s' already exists", arg1))
    end
    self.ProcessCommandsFunctions:AddFunction(arg1, arg2, arg3)
end

function tbl4:ProcessCommandsFunctionExists(arg1)
    return self.ProcessCommandsFunctions:HasFunction(arg1)
end

function tbl4:UnregisterProcessCommandsFunction(arg1)
    if not self.ProcessCommandsFunctions:HasFunction(arg1) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", arg1))
    end
    self.ProcessCommandsFunctions:RemoveFunction(arg1)
end

local num1 = 0
local num2 = 0
local num3 = 0
function tbl4:InternalNotifyFilterIssue()
    if tick() - num2 > 60 then
        num3 = 0
    end
    num3 += 1
    num2 = tick()
    if not (num3 >= 3) or not (tick() - num1 > 60) then
        return
    end

    num1 = tick()
    local channel = self:GetChannel("System")
    if channel then
        channel:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatService_ChatFilterIssues",
                "The chat filter is currently experiencing issues and messages may be slow to appear."
            ),
            tbl3
        )
    end
end

local tbl5 = ({})

function tbl4.InternalApplyRobloxFilter(arg1, arg2, stringToFilter: string, arg3)
    if not RunService:IsServer() or RunService:IsStudio() then
        if not tbl5[stringToFilter] then
            tbl5[stringToFilter] = true
            wait()
        end
        return stringToFilter
    end

    local speaker = arg1:GetSpeaker(arg2)
    local speaker2 = arg3 and arg1:GetSpeaker(arg3)

    if speaker == nil then
        return nil
    end

    local player = speaker:GetPlayer()
    local player2 = speaker2 and speaker2:GetPlayer()

    if player == nil then
        return stringToFilter
    end

    if allSpaces(stringToFilter) then
        return stringToFilter
    end

    local startTime = tick()
    local num4 = 0
    local result

    while true do
        local success

        success, result = pcall(function()
            if player2 then
                return Chat:FilterStringAsync(stringToFilter, player, player2)
            end
            return Chat:FilterStringForBroadcast(stringToFilter, player)
        end)

        if success then
            break
        end

        warn("Error filtering message:", result)

        num4 += 1
        if num4 > 3 or tick() - startTime > 60 then
            arg1:InternalNotifyFilterIssue()
            return nil
        end
        local var2 = tbl1[math.min(#tbl1, num4)]

        local var3 = var2 + (math.random() * 2 - 1) * var2
        wait(var3)
    end

    return result
end

function tbl4.InternalApplyRobloxFilterAndTranslate(arg1, arg2, targetLocales, stringToFilter: string, textFilterContext: Enum.TextFilterContext?)
    if not RunService:IsServer() or RunService:IsStudio() then
        wait()
        return true, false, stringToFilter
    end

    local speaker = arg1:GetSpeaker(arg2)
    if speaker == nil then
        return false, nil, nil
    end

    local player = speaker:GetPlayer()
    if player == nil then
        return true, false, stringToFilter
    end

    if allSpaces(stringToFilter) then
        return true, false, stringToFilter
    end

    local success, result = pcall(function(): TextFilterTranslatedResult
        return (game:GetService("TextService"):FilterAndTranslateStringAsync(
            stringToFilter,
            player.UserId,
            targetLocales,
            textFilterContext
        ))
    end)

    if success then
        return true, true, result
    end
    warn("Error filtering and translating message", stringToFilter, result)
    arg1:InternalNotifyFilterIssue()
    return false, nil, nil
end

function tbl4.InternalApplyRobloxFilterNewAPI(arg1, arg2, stringToFilter: string, textFilterContext: Enum.TextFilterContext?)
    if not RunService:IsServer() or RunService:IsStudio() then
        wait()
        return true, false, stringToFilter
    end

    local speaker = arg1:GetSpeaker(arg2)
    if speaker == nil then
        return false, nil, nil
    end

    local player = speaker:GetPlayer()
    if player == nil then
        return true, false, stringToFilter
    end

    if allSpaces(stringToFilter) then
        return true, false, stringToFilter
    end

    local success, result = pcall(function(): TextFilterResult
        return (game:GetService("TextService"):FilterStringAsync(stringToFilter, player.UserId, textFilterContext))
    end)
    if success then
        return true, true, result
    end
    warn("Error filtering message:", stringToFilter, result)
    arg1:InternalNotifyFilterIssue()
    return false, nil, nil
end

function tbl4:InternalDoMessageFilter(arg1, arg2, arg3)
    for value, value2, _ in (self.FilterMessageFunctions:GetIterator()) do
        local success, reason = pcall(function()
            value2(arg1, arg2, arg3)
        end)

        if not success then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", value, reason))
        end
    end
end

function tbl4:InternalDoProcessCommands(arg1, arg2, arg3)
    for value, value2, _ in (self.ProcessCommandsFunctions:GetIterator()) do
        local success, reason = pcall(function()
            local var2 = value2(arg1, arg2, arg3)
            if type(var2) ~= "boolean" then
                error("Process command functions must return a bool")
            end
            return var2
        end)

        if not success then
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", value, reason))
        elseif reason then
            return true
        end
    end

    return false
end

function tbl4:InternalGetUniqueMessageId(): number
    local messageIdCounter = self.MessageIdCounter
    self.MessageIdCounter = messageIdCounter + 1
    return messageIdCounter
end

function tbl4:InternalAddSpeakerWithPlayerObject(arg1, arg2, arg3)
    if self.Speakers[arg1:lower()] then
        error("Speaker \"" .. arg1 .. "\" already exists!")
    end

    local speaker = Speaker.new(self, arg1)
    speaker:InternalAssignPlayerObject(arg2)
    self.Speakers[arg1:lower()] = speaker

    if arg3 then
        local success, result = pcall(function()
            self.eSpeakerAdded:Fire(arg1)
        end)

        if not success and result then
            print("Error adding speaker: " .. result)
        end
    end

    return speaker
end

function tbl4.InternalFireSpeakerAdded(arg1, arg2)
    local success, result = pcall(function()
        arg1.eSpeakerAdded:Fire(arg2)
    end)

    if not success and result then
        print("Error firing speaker added: " .. result)
    end
end

function tbl2.new()
    local self = setmetatable({}, tbl4)

    self.MessageIdCounter = 0

    self.ChatChannels = {}
    self.Speakers = {}

    self.FilterMessageFunctions = Util:NewSortedFunctionContainer()
    self.ProcessCommandsFunctions = Util:NewSortedFunctionContainer()

    self.eChannelAdded = Instance.new("BindableEvent")
    self.eChannelRemoved = Instance.new("BindableEvent")
    self.eSpeakerAdded = Instance.new("BindableEvent")
    self.eSpeakerRemoved = Instance.new("BindableEvent")

    self.ChannelAdded = self.eChannelAdded.Event
    self.ChannelRemoved = self.eChannelRemoved.Event
    self.SpeakerAdded = self.eSpeakerAdded.Event
    self.SpeakerRemoved = self.eSpeakerRemoved.Event

    self.ChatServiceMajorVersion = 0
    self.ChatServiceMinorVersion = 5

    return self
end

return tbl2.new()
