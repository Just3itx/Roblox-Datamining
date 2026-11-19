-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserShouldMuteUnfilteredMessage")
end)

local var1 = success and result

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
end)
local var2 = success2 and result2

local success3, result3 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var3 = success3 and result3

local module = {}

local scriptParent = script.Parent
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))
local Util = require(scriptParent:WaitForChild("Util"))

local var4 = nil

pcall(function()
    var4 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var4 = var4 or {}

if not (var4.FormatMessageToSend and var4.LocalizeFormattedMessage) then
    function var4.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:SendSystemMessage(arg1, arg2)
    local var5 = self:InternalCreateMessageObject(arg1, nil, true, arg2)

    local success4, result4 = pcall(function()
        self.eMessagePosted:Fire(var5)
    end)

    if not success4 and result4 then
        print("Error posting message: " .. result4)
    end

    self:InternalAddMessageToHistoryLog(var5)

    for _, speaker in pairs(self.Speakers) do
        speaker:InternalSendSystemMessage(var5, self.Name)
    end

    return var5
end

function tbl1:SendSystemMessageToSpeaker(arg1, arg2, arg3)
    local speaker = self.Speakers[arg2]
    if speaker then
        speaker:InternalSendSystemMessage(self:InternalCreateMessageObject(arg1, nil, true, arg3), self.Name)
    elseif RunService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a system message", arg2, self.Name))
    end
end

function tbl1:SendMessageObjToFilters(message, arg1, arg2)
    local message2 = arg1.Message
    arg1.Message = message
    self:InternalDoMessageFilter(arg2.Name, arg1, self.Name)
    self.ChatService:InternalDoMessageFilter(arg2.Name, arg1, self.Name)
    local message3 = arg1.Message
    arg1.Message = message2
    return message3
end

function tbl1:CanCommunicateByUserId(userIdFrom, userIdTo)
    if RunService:IsStudio() then
        return true
    end

    if userIdFrom == 0 or userIdTo == 0 then
        return true
    end
    local success4, result4 = pcall(function(): boolean
        return Chat:CanUsersChatAsync(userIdFrom, userIdTo)
    end)
    return success4 and result4
end

function tbl1:CanCommunicate(arg1, arg2)
    local player = arg1:GetPlayer()
    local player2 = arg2:GetPlayer()
    if player and player2 then
        return self:CanCommunicateByUserId(player.UserId, player2.UserId)
    end
    return true
end

function tbl1:SendMessageToSpeaker(arg1, arg2, arg3, arg4)
    local speaker = self.Speakers[arg2]
    local speaker2 = self.ChatService:GetSpeaker(arg3)
    if not speaker or not speaker2 then
        if RunService:IsStudio() then
            warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a message", arg2, self.Name))
        end

        return
    end

    if speaker:IsSpeakerMuted(arg3) then
        return
    end

    if not self:CanCommunicate(speaker, speaker2) then
        return
    end

    local var5 = self:InternalCreateMessageObject(arg1, arg3, arg2 == arg3, arg4)
    arg1 = self:SendMessageObjToFilters(arg1, var5, arg3)
    speaker:InternalSendMessage(var5, self.Name)

    local textFilterContext = self.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat
    local var6, isFilterResult, filterResult = self.ChatService:InternalApplyRobloxFilterNewAPI(var5.FromSpeaker, arg1, textFilterContext)

    if var6 then
        var5.FilterResult = filterResult
        var5.IsFilterResult = isFilterResult
        var5.IsFiltered = true
        speaker:InternalSendFilteredMessageWithFilterResult(var5, self.Name)
    end
end

function tbl1:KickSpeaker(arg1, arg2)
    local speaker = self.ChatService:GetSpeaker(arg1)
    if not speaker then
        error("Speaker \"" .. arg1 .. "\" does not exist!")
    end

    local nameForDisplay = speaker:GetNameForDisplay()
    local var5, var6

    if arg2 then
        var5 = string.format("You were kicked from '%s' for the following reason(s): %s", self.Name, arg2)
        var6 = string.format("%s was kicked for the following reason(s): %s", nameForDisplay, arg2)
    else
        var5 = string.format("You were kicked from '%s'", self.Name)
        var6 = string.format("%s was kicked", nameForDisplay)
    end

    self:SendSystemMessageToSpeaker(var5, arg1)
    speaker:LeaveChannel(self.Name)
    self:SendSystemMessage(var6)
end

function tbl1:MuteSpeaker(arg1, arg2, arg3)
    local speaker = self.ChatService:GetSpeaker(arg1)
    if not speaker then
        error("Speaker \"" .. arg1 .. "\" does not exist!")
    end

    self.Mutes[arg1:lower()] = if arg3 == 0 or arg3 == nil then 0 else os.time() + arg3

    if arg2 then
        local nameForDisplay = speaker:GetNameForDisplay()

        self:SendSystemMessage(string.format("%s was muted for the following reason(s): %s", nameForDisplay, arg2))
    end

    local success4, result4 = pcall(function()
        self.eSpeakerMuted:Fire(arg1, arg2, arg3)
    end)

    if not success4 and result4 then
        print("Error mutting speaker: " .. result4)
    end

    local speaker2 = self.ChatService:GetSpeaker(arg1)
    if not speaker2 then
        return
    end

    local success5, result5 = pcall(function()
        speaker2.eMuted:Fire(self.Name, arg2, arg3)
    end)

    if not success5 and result5 then
        print("Error mutting speaker: " .. result5)
    end
end

function tbl1:UnmuteSpeaker(arg1)
    if not self.ChatService:GetSpeaker(arg1) then
        error("Speaker \"" .. arg1 .. "\" does not exist!")
    end

    self.Mutes[arg1:lower()] = nil

    local success4, result4 = pcall(function()
        self.eSpeakerUnmuted:Fire(arg1)
    end)

    if not success4 and result4 then
        print("Error unmuting speaker: " .. result4)
    end

    local speaker = self.ChatService:GetSpeaker(arg1)
    if not speaker then
        return
    end

    local success5, result5 = pcall(function()
        speaker.eUnmuted:Fire(self.Name)
    end)

    if not success5 and result5 then
        print("Error unmuting speaker: " .. result5)
    end
end

function tbl1:IsSpeakerMuted(arg1): boolean
    return self.Mutes[arg1:lower()] ~= nil
end

function tbl1:GetSpeakerList()
    local speakerList = {}
    for _, speaker in pairs(self.Speakers) do
        table.insert(speakerList, speaker.Name)
    end
    return speakerList
end

function tbl1:RegisterFilterMessageFunction(arg1, arg2, arg3)
    if self.FilterMessageFunctions:HasFunction(arg1) then
        error(string.format("FilterMessageFunction '%s' already exists", arg1))
    end
    self.FilterMessageFunctions:AddFunction(arg1, arg2, arg3)
end

function tbl1:FilterMessageFunctionExists(arg1)
    return self.FilterMessageFunctions:HasFunction(arg1)
end

function tbl1:UnregisterFilterMessageFunction(arg1)
    if not self.FilterMessageFunctions:HasFunction(arg1) then
        error(string.format("FilterMessageFunction '%s' does not exists", arg1))
    end
    self.FilterMessageFunctions:RemoveFunction(arg1)
end

function tbl1:RegisterProcessCommandsFunction(arg1, arg2, arg3)
    if self.ProcessCommandsFunctions:HasFunction(arg1) then
        error(string.format("ProcessCommandsFunction '%s' already exists", arg1))
    end
    self.ProcessCommandsFunctions:AddFunction(arg1, arg2, arg3)
end

function tbl1:ProcessCommandsFunctionExists(arg1)
    return self.ProcessCommandsFunctions:HasFunction(arg1)
end

function tbl1:UnregisterProcessCommandsFunction(arg1)
    if not self.ProcessCommandsFunctions:HasFunction(arg1) then
        error(string.format("ProcessCommandsFunction '%s' does not exist", arg1))
    end
    self.ProcessCommandsFunctions:RemoveFunction(arg1)
end

local function ShallowCopy(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local result4 = ({})
    for k, value in pairs(arg1) do
        result4[k] = value
    end
    return result4
end

function tbl1:GetHistoryLog()
    return ShallowCopy(self.ChatHistory)
end

function tbl1:GetHistoryLogForSpeaker(arg1)
    local player = arg1:GetPlayer()
    local var5 = if player then player.UserId else -1

    local historyLogForSpeaker = {}

    for i = 1, #self.ChatHistory do
        if not self:CanCommunicateByUserId(var5, self.ChatHistory[i].SpeakerUserId) then
            continue
        end

        local tbl2 = ShallowCopy(self.ChatHistory[i])

        if tbl2.MessageType == ChatConstants.MessageTypeDefault or tbl2.MessageType == ChatConstants.MessageTypeMeCommand then
            local filterResult = tbl2.FilterResult
            if tbl2.IsFilterResult then
                if player then
                    tbl2.Message = filterResult:GetChatForUserAsync(player.UserId)
                else
                    tbl2.Message = filterResult:GetNonChatStringForBroadcastAsync()
                end
            else
                tbl2.Message = filterResult
            end
        end

        table.insert(historyLogForSpeaker, tbl2)
    end

    return historyLogForSpeaker
end

function tbl1:InternalDestroy()
    for _, speaker in pairs(self.Speakers) do
        speaker:LeaveChannel(self.Name)
    end

    self.eDestroyed:Fire()

    self.eDestroyed:Destroy()
    self.eMessagePosted:Destroy()
    self.eSpeakerJoined:Destroy()
    self.eSpeakerLeft:Destroy()
    self.eSpeakerMuted:Destroy()
    self.eSpeakerUnmuted:Destroy()
end

function tbl1:InternalDoMessageFilter(arg1, arg2, arg3)
    for value, value2, _ in (self.FilterMessageFunctions:GetIterator()) do
        local success4, reason = pcall(function()
            value2(arg1, arg2, arg3)
        end)

        if not success4 then
            warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", value, reason))
        end
    end
end

function tbl1:InternalDoProcessCommands(arg1, arg2, arg3)
    for value, value2, _ in (self.ProcessCommandsFunctions:GetIterator()) do
        local success4, reason = pcall(function()
            local var5 = value2(arg1, arg2, arg3)
            if type(var5) ~= "boolean" then
                error("Process command functions must return a bool")
            end
            return var5
        end)

        if not success4 then
            warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", value, reason))
        elseif reason then
            return true
        end
    end

    return false
end

function getLanguageCodeFromLocale(localeId)
    return string.gmatch(localeId, "[^-]+")() or "en"
end

function tbl1:InternalPostMessage(arg1, message, arg3)
    if self:InternalDoProcessCommands(arg1.Name, message, self.Name) then
        return false
    end
    if self.Mutes[arg1.Name:lower()] ~= nil then
        local var5 = self.Mutes[arg1.Name:lower()]
        if not (var5 > 0 and var5 < os.time()) then
            self:SendSystemMessageToSpeaker(
                var4:FormatMessageToSend("GameChat_ChatChannel_MutedInChannel", "You are muted and cannot talk in this channel"),
                arg1.Name
            )
            return false
        end

        self:UnmuteSpeaker(arg1.Name)
    end

    local callbackArguments = self:InternalCreateMessageObject(message, arg1.Name, false, arg3)

    callbackArguments.Message = message
    local chatCallbackResult = nil
    pcall(function()
        chatCallbackResult = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnServerReceivingMessage, callbackArguments)
    end)
    callbackArguments.Message = nil

    if chatCallbackResult then
        if chatCallbackResult.ShouldDeliver == false then
            return false
        end
        callbackArguments = chatCallbackResult
    end

    message = self:SendMessageObjToFilters(message, callbackArguments, arg1)

    local tbl2 = {}
    for _, speaker in pairs(self.Speakers) do
        if speaker:IsSpeakerMuted(arg1.Name) or not self:CanCommunicate(arg1, speaker) then
            continue
        end

        table.insert(tbl2, speaker.Name)
        if speaker.Name == arg1.Name then
            local tbl3 = ShallowCopy(callbackArguments)
            if var1 then
                local var5 = callbackArguments.MessageLengthUtf8 or callbackArguments.MessageLength
                tbl3.Message = string.rep("_", var5)
            else
                tbl3.Message = message
            end
            tbl3.IsFiltered = true

            speaker:InternalSendMessage(tbl3, self.Name)
        else
            speaker:InternalSendMessage(callbackArguments, self.Name)
        end
    end

    local success4, result4 = pcall(function()
        self.eMessagePosted:Fire(callbackArguments)
    end)

    if not success4 and result4 then
        print("Error posting message: " .. result4)
    end

    local textFilterContext = self.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat
    local var5 = nil
    if var3 then
        local tbl3 = {}
        local tbl4 = {}
        for _, speaker in pairs(self.Speakers) do
            local player = speaker:GetPlayer()
            if player ~= nil and player.LocaleId ~= nil then
                tbl4[getLanguageCodeFromLocale(player.LocaleId)] = true
            end
        end
        for value, _ in tbl4 do
            table.insert(tbl3, value)
        end

        local var6, isFilterResult, filterResult = self.ChatService:InternalApplyRobloxFilterAndTranslate(callbackArguments.FromSpeaker, tbl3, message, textFilterContext)

        if var6 then
            if isFilterResult then
                local sourceText = filterResult.SourceText
                callbackArguments.FilterResult = sourceText
            else
                callbackArguments.FilterResult = filterResult
            end
            callbackArguments.IsFilterResult = isFilterResult
            if isFilterResult then
                var5 = filterResult
            end
        else
            if not var2 then
                return false
            end

            callbackArguments.IsFilterResult = false
            callbackArguments.FilterResult = ""
            callbackArguments.MessageLength = 0
        end
    else
        local var6, isFilterResult, filterResult = self.ChatService:InternalApplyRobloxFilterNewAPI(callbackArguments.FromSpeaker, message, textFilterContext)

        if var6 then
            callbackArguments.FilterResult = filterResult
            callbackArguments.IsFilterResult = isFilterResult
        else
            if not var2 then
                return false
            end

            callbackArguments.IsFilterResult = false
            callbackArguments.FilterResult = ""
            callbackArguments.MessageLength = 0
        end
    end

    callbackArguments.IsFiltered = true
    self:InternalAddMessageToHistoryLog(callbackArguments)

    for _, value in pairs(tbl2) do
        local speaker = self.Speakers[value]
        if not speaker then
            continue
        end

        local bool1 = var3

        if bool1 then
            if var5 then
                if arg1:GetPlayer() == nil or speaker:GetPlayer() == nil then
                    bool1 = false
                else
                    bool1 = arg1:GetPlayer().LocaleId ~= speaker:GetPlayer().LocaleId
                end
            else
                bool1 = var5
            end
        end

        if bool1 then
            speaker:InternalSendFilteredMessageWithTranslatedFilterResult(callbackArguments, self.Name, var5)
        else
            speaker:InternalSendFilteredMessageWithFilterResult(callbackArguments, self.Name)
        end
    end

    local tbl3 = {}
    for _, speaker in pairs(self.Speakers) do
        if speaker:IsSpeakerMuted(arg1.Name) or not self:CanCommunicate(arg1, speaker) then
            continue
        end

        local bool1 = false
        for _, value in pairs(tbl2) do
            if speaker.Name == value then
                bool1 = true
                break
            end
        end

        if not bool1 then
            table.insert(tbl3, speaker.Name)
        end
    end

    for _, value in pairs(tbl3) do
        local speaker = self.Speakers[value]
        if speaker then
            speaker:InternalSendFilteredMessageWithFilterResult(callbackArguments, self.Name)
        end
    end

    return callbackArguments
end

function tbl1:InternalAddSpeaker(arg1)
    if self.Speakers[arg1.Name] then
        warn("Speaker \"" .. arg1.name .. "\" is already in the channel!")
        return
    end

    self.Speakers[arg1.Name] = arg1
    local success4, result4 = pcall(function()
        self.eSpeakerJoined:Fire(arg1.Name)
    end)

    if not success4 and result4 then
        print("Error removing channel: " .. result4)
    end
end

function tbl1:InternalRemoveSpeaker(arg1)
    if not self.Speakers[arg1.Name] then
        warn("Speaker \"" .. arg1.name .. "\" is not in the channel!")
        return
    end

    self.Speakers[arg1.Name] = nil
    local success4, result4 = pcall(function()
        self.eSpeakerLeft:Fire(arg1.Name)
    end)

    if not success4 and result4 then
        print("Error removing speaker: " .. result4)
    end
end

function tbl1:InternalRemoveExcessMessagesFromLog()
    local remove = table.remove
    while #self.ChatHistory > self.MaxHistory do
        remove(self.ChatHistory, 1)
    end
end

function tbl1:InternalAddMessageToHistoryLog(arg1)
    table.insert(self.ChatHistory, arg1)

    self:InternalRemoveExcessMessagesFromLog()
end

function tbl1:GetMessageType(_, arg1)
    return if arg1 == nil then ChatConstants.MessageTypeSystem else ChatConstants.MessageTypeDefault
end

function tbl1:InternalCreateMessageObject(arg1, fromSpeaker, isFiltered, arg2)
    local messageType = self:GetMessageType(arg1, fromSpeaker)

    local num1 = -1
    local nameForDisplay = nil
    local speaker

    if fromSpeaker then
        speaker = self.ChatService:GetSpeaker(fromSpeaker)
        if speaker then
            local player = speaker:GetPlayer()
            if player then
                num1 = player.UserId

                if ChatSettings.PlayerDisplayNamesEnabled then
                    nameForDisplay = speaker:GetNameForDisplay()
                end
            else
                num1 = 0
            end
        end
    else
        speaker = nil
    end

    local tbl2 = {
        ID = self.ChatService:InternalGetUniqueMessageId(),
        FromSpeaker = fromSpeaker,
        SpeakerDisplayName = nameForDisplay,
        SpeakerUserId = num1,
        OriginalChannel = self.Name,
        MessageLength = string.len(arg1),
        MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(arg1)),
        MessageType = messageType,
        IsFiltered = isFiltered,
        Message = isFiltered and arg1 or nil,
        Time = os.time(),
        ExtraData = {}
    }

    if speaker then
        for k, value in pairs(speaker.ExtraData) do
            tbl2.ExtraData[k] = value
        end
    end

    if arg2 then
        for k, value in pairs(arg2) do
            tbl2.ExtraData[k] = value
        end
    end

    return tbl2
end

function tbl1:SetChannelNameColor(channelNameColor)
    self.ChannelNameColor = channelNameColor
    for _, speaker in pairs(self.Speakers) do
        speaker:UpdateChannelNameColor(self.Name, channelNameColor)
    end
end

function tbl1:GetWelcomeMessageForSpeaker(arg1)
    if self.GetWelcomeMessageFunction then
        local welcomeMessageFunction = self.GetWelcomeMessageFunction(arg1)
        if welcomeMessageFunction then
            return welcomeMessageFunction
        end
    end
    return self.WelcomeMessage
end

function tbl1:RegisterGetWelcomeMessageFunction(getWelcomeMessageFunction)
    if type(getWelcomeMessageFunction) ~= "function" then
        error("RegisterGetWelcomeMessageFunction must be called with a function.")
    end
    self.GetWelcomeMessageFunction = getWelcomeMessageFunction
end

function tbl1:UnRegisterGetWelcomeMessageFunction()
    self.GetWelcomeMessageFunction = nil
end

function module.new(chatService, selfName, welcomeMessage, channelNameColor)
    local self = setmetatable({}, tbl1)

    self.ChatService = chatService

    self.Name = selfName
    self.WelcomeMessage = welcomeMessage or ""
    self.GetWelcomeMessageFunction = nil
    self.ChannelNameColor = channelNameColor

    self.Joinable = true
    self.Leavable = true
    self.AutoJoin = false
    self.Private = false

    self.Speakers = {}
    self.Mutes = {}

    self.MaxHistory = 200
    self.HistoryIndex = 0
    self.ChatHistory = {}

    self.FilterMessageFunctions = Util:NewSortedFunctionContainer()
    self.ProcessCommandsFunctions = Util:NewSortedFunctionContainer()

    self.eDestroyed = Instance.new("BindableEvent")
    self.eMessagePosted = Instance.new("BindableEvent")
    self.eSpeakerJoined = Instance.new("BindableEvent")
    self.eSpeakerLeft = Instance.new("BindableEvent")
    self.eSpeakerMuted = Instance.new("BindableEvent")
    self.eSpeakerUnmuted = Instance.new("BindableEvent")

    self.MessagePosted = self.eMessagePosted.Event
    self.SpeakerJoined = self.eSpeakerJoined.Event
    self.SpeakerLeft = self.eSpeakerLeft.Event
    self.SpeakerMuted = self.eSpeakerMuted.Event
    self.SpeakerUnmuted = self.eSpeakerUnmuted.Event
    self.Destroyed = self.eDestroyed.Event

    return self
end

return module
