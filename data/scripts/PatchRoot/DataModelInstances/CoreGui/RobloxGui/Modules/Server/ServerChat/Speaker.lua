-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local RunService = game:GetService("RunService")
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local _scriptParent = script.Parent

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
end)
local var1 = success and result

local _, _result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)

local function ShallowCopy(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result2 = ({})
    for k, value in pairs(arg1) do
        result2[k] = value
    end
    return result2
end

local tbl1 = {}

local tbl2 = {
    eDestroyed = true,
    eSaidMessage = true,
    eReceivedMessage = true,
    eReceivedUnfilteredMessage = true,
    eMessageDoneFiltering = true,
    eReceivedSystemMessage = true,
    eChannelJoined = true,
    eChannelLeft = true,
    eMuted = true,
    eUnmuted = true,
    eExtraDataUpdated = true,
    eMainChannelSet = true,
    eChannelNameColorUpdated = true
}

local tbl3 = {
    Destroyed = "eDestroyed",
    SaidMessage = "eSaidMessage",
    ReceivedMessage = "eReceivedMessage",
    ReceivedUnfilteredMessage = "eReceivedUnfilteredMessage",
    RecievedUnfilteredMessage = "eReceivedUnfilteredMessage",
    MessageDoneFiltering = "eMessageDoneFiltering",
    ReceivedSystemMessage = "eReceivedSystemMessage",
    ChannelJoined = "eChannelJoined",
    ChannelLeft = "eChannelLeft",
    Muted = "eMuted",
    Unmuted = "eUnmuted",
    ExtraDataUpdated = "eExtraDataUpdated",
    MainChannelSet = "eMainChannelSet",
    ChannelNameColorUpdated = "eChannelNameColorUpdated"
}

function tbl1.__index(arg1, arg2)
    local var2 = rawget(tbl1, arg2)
    if var2 then
        return var2
    end
    if tbl2[arg2] and not rawget(arg1, arg2) then
        rawset(arg1, arg2, Instance.new("BindableEvent"))
    end
    local var3 = tbl3[arg2]
    if var3 and not rawget(arg1, arg2) then
        local var4 = rawget(arg1, var3)
        if not var4 then
            var4 = Instance.new("BindableEvent")
            rawset(arg1, var3, var4)
        end
        rawset(arg1, arg2, var4.Event)
    end
    return rawget(arg1, arg2)
end

function tbl1.LazyFire<T>(arg1, arg2: T, ...)
    local var2 = rawget(arg1, arg2)
    if var2 then
        var2:Fire(...)
    end
end

function tbl1.SayMessage(arg1, arg2, arg3, arg4)
    if arg1.ChatService:InternalDoProcessCommands(arg1.Name, arg2, arg3) or not arg3 then
        return
    end

    local channel = arg1.Channels[arg3:lower()]
    if not channel then
        return
    end

    local var2 = channel:InternalPostMessage(arg1, arg2, arg4)
    if var2 then
        pcall(function()
            arg1:LazyFire("eSaidMessage", var2, arg3)
        end)
    end

    return var2
end

function tbl1.JoinChannel(arg1, arg2)
    if arg1.Channels[arg2:lower()] then
        warn("Speaker is already in channel \"" .. arg2 .. "\"")
        return
    end

    local channel = arg1.ChatService:GetChannel(arg2)
    if not channel then
        error("Channel \"" .. arg2 .. "\" does not exist!")
    end

    arg1.Channels[arg2:lower()] = channel
    channel:InternalAddSpeaker(arg1)
    local success2, result2 = pcall(function()
        arg1.eChannelJoined:Fire(channel.Name, channel:GetWelcomeMessageForSpeaker(arg1))
    end)
    if not success2 and result2 then
        print("Error joining channel: " .. result2)
    end
end

function tbl1.LeaveChannel(arg1, arg2)
    if not arg1.Channels[arg2:lower()] then
        warn("Speaker is not in channel \"" .. arg2 .. "\"")
        return
    end

    local channel = arg1.Channels[arg2:lower()]

    arg1.Channels[arg2:lower()] = nil
    channel:InternalRemoveSpeaker(arg1)
    local success2, result2 = pcall(function()
        arg1:LazyFire("eChannelLeft", channel.Name)
        if arg1.PlayerObj then
            arg1.EventFolder.OnChannelLeft:FireClient(arg1.PlayerObj, channel.Name)
        end
    end)
    if not success2 and result2 then
        print("Error leaving channel: " .. result2)
    end
end

function tbl1.IsInChannel(arg1, arg2): boolean
    return arg1.Channels[arg2:lower()] ~= nil
end

function tbl1.GetChannelList(arg1)
    local channelList = {}
    for _, channel in pairs(arg1.Channels) do
        table.insert(channelList, channel.Name)
    end
    return channelList
end

function tbl1.SendMessage(arg1, arg2, arg3, arg4, arg5)
    local channel = arg1.Channels[arg3:lower()]
    if channel then
        channel:SendMessageToSpeaker(arg2, arg1.Name, arg4, arg5)
    elseif RunService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a message in it.", arg1.Name, arg3))
    end
end

function tbl1.SendSystemMessage(arg1, arg2, arg3, arg4)
    local channel = arg1.Channels[arg3:lower()]
    if channel then
        channel:SendSystemMessageToSpeaker(arg2, arg1.Name, arg4)
    elseif RunService:IsStudio() then
        warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a system message in it.", arg1.Name, arg3))
    end
end

function tbl1.GetPlayer(arg1)
    return arg1.PlayerObj
end

function tbl1.GetNameForDisplay(arg1)
    if not ChatSettings.PlayerDisplayNamesEnabled then
        return arg1.Name
    end

    local player = arg1:GetPlayer()

    return if player then player.DisplayName else arg1.Name
end

function tbl1.SetExtraData(arg1, arg2, arg3)
    arg1.ExtraData[arg2] = arg3
    arg1:LazyFire("eExtraDataUpdated", arg2, arg3)
end

function tbl1.GetExtraData(arg1, arg2)
    return arg1.ExtraData[arg2]
end

function tbl1.SetMainChannel(arg1, arg2)
    local success2, result2 = pcall(function()
        arg1:LazyFire("eMainChannelSet", arg2)
        if arg1.PlayerObj then
            arg1.EventFolder.OnMainChannelSet:FireClient(arg1.PlayerObj, arg2)
        end
    end)
    if not success2 and result2 then
        print("Error setting main channel: " .. result2)
    end
end

function tbl1.AddMutedSpeaker(arg1, arg2)
    arg1.MutedSpeakers[arg2:lower()] = true
end

function tbl1.RemoveMutedSpeaker(arg1, arg2)
    arg1.MutedSpeakers[arg2:lower()] = false
end

function tbl1.IsSpeakerMuted(arg1, arg2)
    return arg1.MutedSpeakers[arg2:lower()]
end

function tbl1.InternalDestroy(arg1)
    for _, channel in pairs(arg1.Channels) do
        channel:InternalRemoveSpeaker(arg1)
    end

    arg1.eDestroyed:Fire()

    arg1.EventFolder = nil
    arg1.eDestroyed:Destroy()
    arg1.eSaidMessage:Destroy()
    arg1.eReceivedMessage:Destroy()
    arg1.eReceivedUnfilteredMessage:Destroy()
    arg1.eMessageDoneFiltering:Destroy()
    arg1.eReceivedSystemMessage:Destroy()
    arg1.eChannelJoined:Destroy()
    arg1.eChannelLeft:Destroy()
    arg1.eMuted:Destroy()
    arg1.eUnmuted:Destroy()
    arg1.eExtraDataUpdated:Destroy()
    arg1.eMainChannelSet:Destroy()
    arg1.eChannelNameColorUpdated:Destroy()
end

function tbl1.InternalAssignPlayerObject(arg1, playerObj)
    arg1.PlayerObj = playerObj
end

function tbl1.InternalAssignEventFolder(arg1, eventFolder)
    arg1.EventFolder = eventFolder
end

function tbl1.InternalSendMessage(arg1, arg2, arg3)
    local success2, result2 = pcall(function()
        arg1:LazyFire("eReceivedUnfilteredMessage", arg2, arg3)
        if arg1.PlayerObj then
            arg1.EventFolder.OnNewMessage:FireClient(arg1.PlayerObj, arg2, arg3)
        end
    end)
    if not success2 and result2 then
        print("Error sending internal message: " .. result2)
    end
end

function tbl1.InternalSendFilteredMessage(arg1, arg2, arg3)
    local success2, result2 = pcall(function()
        arg1:LazyFire("eReceivedMessage", arg2, arg3)
        arg1:LazyFire("eMessageDoneFiltering", arg2, arg3)
        if arg1.PlayerObj then
            arg1.EventFolder.OnMessageDoneFiltering:FireClient(arg1.PlayerObj, arg2, arg3)
        end
    end)
    if not success2 and result2 then
        print("Error sending internal filtered message: " .. result2)
    end
end

function tbl1.InternalSendFilteredMessageWithTranslatedFilterResult(arg1, arg2, arg3, arg4)
    local tbl4 = ShallowCopy(arg2)
    local filterResult = tbl4.FilterResult
    local player = arg1:GetPlayer()
    local translationForLocale = if player == nil then nil else arg4:GetTranslationForLocale(player.LocaleId)
    local str1 = ""
    local var2 = nil
    pcall(function()
        if not tbl4.IsFilterResult then
            str1 = filterResult
            return
        end

        if player then
            str1 = filterResult:GetChatForUserAsync(player.UserId)
            if translationForLocale then
                var2 = translationForLocale:GetChatForUserAsync(player.UserId)
            end
        else
            str1 = filterResult:GetNonChatStringForBroadcastAsync()
            if translationForLocale then
                var2 = translationForLocale:GetNonChatStringForBroadcastAsync()
            end
        end
    end)

    if not var1 and not (#str1 > 0) then
        return
    end

    tbl4.Message = str1
    if var2 then
        tbl4.TranslatedMessage = var2
    end

    tbl4.FilterResult = nil
    arg1:InternalSendFilteredMessage(tbl4, arg3)
end

function tbl1.InternalSendFilteredMessageWithFilterResult(arg1, arg2, arg3)
    local tbl4 = ShallowCopy(arg2)
    local filterResult = tbl4.FilterResult
    local player = arg1:GetPlayer()

    local str1 = ""
    pcall(function()
        if not tbl4.IsFilterResult then
            str1 = filterResult

            return
        end

        if player then
            str1 = filterResult:GetChatForUserAsync(player.UserId)
            return
        end
        str1 = filterResult:GetNonChatStringForBroadcastAsync()
    end)

    if var1 or #str1 > 0 then
        tbl4.Message = str1
        tbl4.FilterResult = nil
        arg1:InternalSendFilteredMessage(tbl4, arg3)
    end
end

function tbl1.InternalSendSystemMessage(arg1, arg2, arg3)
    local success2, result2 = pcall(function()
        arg1:LazyFire("eReceivedSystemMessage", arg2, arg3)
        if arg1.PlayerObj then
            arg1.EventFolder.OnNewSystemMessage:FireClient(arg1.PlayerObj, arg2, arg3)
        end
    end)
    if not success2 and result2 then
        print("Error sending internal system message: " .. result2)
    end
end

function tbl1.UpdateChannelNameColor(arg1, arg2, arg3)
    arg1:LazyFire("eChannelNameColorUpdated", arg2, arg3)
    if arg1.PlayerObj then
        arg1.EventFolder.ChannelNameColorUpdated:FireClient(arg1.PlayerObj, arg2, arg3)
    end
end

function module.new(chatService, arg1)
    local var2 = setmetatable({}, tbl1)

    var2.ChatService = chatService

    var2.PlayerObj = nil

    var2.Name = arg1
    var2.ExtraData = {}

    var2.Channels = {}
    var2.MutedSpeakers = {}
    var2.EventFolder = nil

    return var2
end

return module
