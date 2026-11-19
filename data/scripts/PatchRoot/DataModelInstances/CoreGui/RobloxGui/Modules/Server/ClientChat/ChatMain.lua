-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Visible = nil,
    IsCoreGuiEnabled = nil,
    TopbarEnabled = nil,
    VisibilityStateChanged = nil
}

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
end)
if not success then
    result = false
end

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var1 = success2 and result2

local success3, result3 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAddBetterConsoleCheckForLegacyChat")
end)
local var2 = success3 and result3

local _RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chat = game:GetService("Chat")
local StarterGui = game:GetService("StarterGui")
local _ContextActionService = game:GetService("ContextActionService")

local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local DefaultChatSystemChatEvents2 = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local MessageCreatorModules = ClientChatModules:WaitForChild("MessageCreatorModules")
local Util = require(MessageCreatorModules:WaitForChild("Util"))

local var3 = nil

pcall(function()
    var3 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

if var3 == nil then
    var3 = {}

    function var3.Get<T>(_, _, arg1: T): T
        return arg1
    end
end

local var4 = nil
if var1 then
    var4 = script:FindFirstChild("ChatTranslationEnabled")
    if var4 == nil then
        local connection = nil
        connection = script.ChildAdded:Connect(function(child: Instance)
            if child.Name == "ChatTranslationEnabled" then
                var4 = child

                connection:Disconnect()
            end
        end)
    end
end

local num1 = 10
local tbl1 = {
    OnNewMessage = "RemoteEvent",
    OnMessageDoneFiltering = "RemoteEvent",
    OnNewSystemMessage = "RemoteEvent",
    OnChannelJoined = "RemoteEvent",
    OnChannelLeft = "RemoteEvent",
    OnMuted = "RemoteEvent",
    OnUnmuted = "RemoteEvent",
    OnMainChannelSet = "RemoteEvent",
    SayMessageRequest = "RemoteEvent",
    GetInitDataRequest = "RemoteFunction"
}

local tbl2 = {}

local bindableEvent = Instance.new("BindableEvent")

function TryRemoveChildWithVerifyingIsCorrectType(arg1)
    if tbl1[arg1.Name] and arg1:IsA(tbl1[arg1.Name]) then
        tbl1[arg1.Name] = nil
        tbl2[arg1.Name] = arg1
        num1 -= 1
    end
end

for _, child in pairs(DefaultChatSystemChatEvents2:GetChildren()) do
    TryRemoveChildWithVerifyingIsCorrectType(child)
end

if num1 > 0 then
    local connection = DefaultChatSystemChatEvents2.ChildAdded:connect(function(child: Instance)
        TryRemoveChildWithVerifyingIsCorrectType(child)
        if num1 < 1 then
            bindableEvent:Fire()
        end
    end)

    bindableEvent.Event:wait()
    connection:disconnect()

    bindableEvent:Destroy()
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local bool1 = true

local DisplayOrder = if ChatSettings.ScreenGuiDisplayOrder == nil then 6 else ChatSettings.ScreenGuiDisplayOrder

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Chat2 = Instance.new("ScreenGui")
Chat2.Name = "Chat"
Chat2.ResetOnSpawn = false
Chat2.DisplayOrder = DisplayOrder
Chat2.Parent = PlayerGui

if var2 and game:GetService("GuiService"):IsTenFootInterface() then
    Chat2.Enabled = false
end

local bool2 = false

local script = script

local ChatWindow = require(script:WaitForChild("ChatWindow"))
local ChatBar = require(script:WaitForChild("ChatBar"))
local ChannelsBar = require(script:WaitForChild("ChannelsBar"))
local _MessageLabelCreator = require(script:WaitForChild("MessageLabelCreator"))
local MessageLogDisplay = require(script:WaitForChild("MessageLogDisplay"))
local _ChatChannel = require(script:WaitForChild("ChatChannel"))
local CommandProcessor = require(script:WaitForChild("CommandProcessor"))

local chatWindow = ChatWindow.new()
local channelsBar = ChannelsBar.new()
local messageLogDisplay = MessageLogDisplay.new()
local commandProcessor = CommandProcessor.new()
local chatBar = ChatBar.new(commandProcessor, chatWindow)

chatWindow:CreateGuiObjects(Chat2)

chatWindow:RegisterChatBar(chatBar)
chatWindow:RegisterChannelsBar(channelsBar)
chatWindow:RegisterMessageLogDisplay(messageLogDisplay)

Util:RegisterChatWindow(chatWindow)

local MessageSender = require(script:WaitForChild("MessageSender"))
MessageSender:RegisterSayMessageFunction(tbl2.SayMessageRequest)

if UserInputService.TouchEnabled then
    chatBar:SetTextLabelText(var3:Get("GameChat_ChatMain_ChatBarTextTouch", "Tap here to chat"))
else
    chatBar:SetTextLabelText(var3:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
end

spawn(function()
    local curveUtil = require(script:WaitForChild("CurveUtil"))
    local var6 = 1 / (ChatSettings.ChatAnimationFPS or 20)
    local var7 = tick()
    while true do
        local now = tick()
        local var8 = curveUtil:DeltaTimeToTimescale(now - var7)

        if var8 ~= 0 then
            chatWindow:Update(var8)
        end

        wait(var6)
        var7 = now
    end
end)

function CheckIfPointIsInSquare(arg1, absolutePosition, arg2): boolean
    return absolutePosition.X <= arg1.X and arg1.X <= arg2.X and absolutePosition.Y <= arg1.Y and arg1.Y <= arg2.Y
end

local bool3 = false
local bool4 = false
local num2 = 0
local num3 = 0

local bindableEvent2 = Instance.new("BindableEvent")
local bindableEvent3 = Instance.new("BindableEvent")
local bindableEvent4 = Instance.new("BindableEvent")

function DoBackgroundFadeIn(arg1)
    num3 = tick()
    bool3 = false
    bindableEvent2:Fire()
    chatWindow:FadeInBackground(arg1 or ChatSettings.ChatDefaultFadeDuration)

    if chatWindow:GetCurrentChannel() then
        local scroller = messageLogDisplay.Scroller
        scroller.ScrollingEnabled = true
        scroller.ScrollBarThickness = MessageLogDisplay.ScrollBarThickness
    end
end

function DoBackgroundFadeOut(arg1)
    num3 = tick()
    bool3 = true
    bindableEvent2:Fire()
    chatWindow:FadeOutBackground(arg1 or ChatSettings.ChatDefaultFadeDuration)

    if chatWindow:GetCurrentChannel() then
        local scroller = messageLogDisplay.Scroller
        scroller.ScrollingEnabled = false
        scroller.ScrollBarThickness = 0
    end
end

function DoTextFadeIn(arg1)
    num2 = tick()
    bool4 = false
    bindableEvent2:Fire()
    chatWindow:FadeInText((arg1 or ChatSettings.ChatDefaultFadeDuration) * 0)
end

function DoTextFadeOut(arg1)
    num2 = tick()
    bool4 = true
    bindableEvent2:Fire()
    chatWindow:FadeOutText(arg1 or ChatSettings.ChatDefaultFadeDuration)
end

function DoFadeInFromNewInformation()
    DoTextFadeIn()
    if ChatSettings.ChatShouldFadeInFromNewInformation then
        DoBackgroundFadeIn()
    end
end

function InstantFadeIn()
    DoBackgroundFadeIn(0)
    DoTextFadeIn(0)
end

function InstantFadeOut()
    DoBackgroundFadeOut(0)
    DoTextFadeOut(0)
end

local var6 = nil
function UpdateFadingForMouseState(arg1)
    var6 = arg1

    bindableEvent3:Fire()

    if chatBar:IsFocused() then
        return
    end
    if arg1 then
        DoBackgroundFadeIn()
        DoTextFadeIn()
    else
        DoBackgroundFadeIn()
    end
end

spawn(function()
    while true do
        RunService.RenderStepped:wait()

        while var6 or chatBar:IsFocused() do
            if var6 then
                bindableEvent3.Event:wait()
            end
            if chatBar:IsFocused() then
                bindableEvent4.Event:wait()
            end
        end

        if not bool3 then
            if tick() - num3 > ChatSettings.ChatWindowBackgroundFadeOutTime then
                DoBackgroundFadeOut()
            end
        elseif bool4 then
            bindableEvent2.Event:wait()
        elseif tick() - num2 > ChatSettings.ChatWindowTextFadeOutTime then
            DoTextFadeOut()
        end
    end
end)

function getClassicChatEnabled()
    return if ChatSettings.ClassicChatEnabled == nil then Players.ClassicChat else ChatSettings.ClassicChatEnabled
end

function getBubbleChatEnabled()
    return if ChatSettings.BubbleChatEnabled == nil then Players.BubbleChat else ChatSettings.BubbleChatEnabled
end

function bubbleChatOnly()
    return not getClassicChatEnabled() and getBubbleChatEnabled()
end

function UpdateMousePosition(arg1)
    if not module.Visible
        or not module.IsCoreGuiEnabled
        or not module.TopbarEnabled and not ChatSettings.ChatOnWithTopBarOff
        or bubbleChatOnly()
    then
        return
    end

    local absolutePosition = chatWindow.GuiObject.AbsolutePosition
    local absoluteSize = chatWindow.GuiObject.AbsoluteSize

    local var7 = CheckIfPointIsInSquare(arg1, absolutePosition, absolutePosition + absoluteSize)

    if var7 ~= var6 then
        UpdateFadingForMouseState(var7)
    end
end

UserInputService.InputChanged:connect(function(input: InputObject, _: boolean)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local vector2 = Vector2.new(input.Position.X, input.Position.Y)
        UpdateMousePosition(vector2)
    end
end)

UserInputService.TouchTap:connect(function(touchPositions: {Vector2}, _: boolean)
    UpdateMousePosition(touchPositions[1])
end)

UserInputService.TouchMoved:connect(function(touch: InputObject, _: boolean)
    local vector2 = Vector2.new(touch.Position.X, touch.Position.Y)
    UpdateMousePosition(vector2)
end)

UserInputService.Changed:connect(function(property: string)
    if property ~= "MouseBehavior" or UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        return
    end

    local absolutePosition = chatWindow.GuiObject.AbsolutePosition
    local absoluteSize = chatWindow.GuiObject.AbsoluteSize
    local absoluteSize2 = Chat2.AbsoluteSize

    if CheckIfPointIsInSquare(absoluteSize2 / 2, absolutePosition, absolutePosition + absoluteSize) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end)

UpdateFadingForMouseState(true)
UpdateFadingForMouseState(false)

local tbl3 = {
    Signal = function()
        local module2 = {}

        local bindableEvent5 = Instance.new("BindableEvent")

        local var7 = nil
        local var8 = nil

        function module2.fire(_, ...)
            var7 = { ... }
            local select = select
            var8 = select("#", ...)
            bindableEvent5:Fire()
        end

        function module2.connect(_, callback): RBXScriptConnection
            if not callback then
                error("connect(nil)", 2)
            end

            return bindableEvent5.Event:connect(function()
                callback(unpack(var7, 1, var8))
            end)
        end

        function module2.wait(_)
            bindableEvent5.Event:wait()
            assert(var7, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
            return unpack(var7, 1, var8)
        end

        return module2
    end
}

function SetVisibility(moduleVisible)
    chatWindow:SetVisible(moduleVisible)
    module.VisibilityStateChanged:fire(moduleVisible)
    module.Visible = moduleVisible

    if not module.IsCoreGuiEnabled then
        return
    end

    if moduleVisible then
        InstantFadeIn()
        return
    end
    InstantFadeOut()
end

local DoChatBarFocus = nil

module.TopbarEnabled = true
module.MessageCount = 0
module.Visible = true
module.IsCoreGuiEnabled = true

function module.ToggleVisibility(_)
    SetVisibility(not chatWindow:GetVisible())
end

function module.SetVisible(_, arg1)
    if chatWindow:GetVisible() ~= arg1 then
        SetVisibility(arg1)
    end
end

function module.FocusChatBar(_)
    chatBar:CaptureFocus()
end

function module.EnterWhisperState(_, arg1)
    chatBar:EnterWhisperState(arg1)
end

function module.GetVisibility(_)
    return chatWindow:GetVisible()
end

function module.GetMessageCount(arg1)
    return arg1.MessageCount
end

function module.TopbarEnabledChanged(arg1, topbarEnabled)
    arg1.TopbarEnabled = topbarEnabled
    arg1.CoreGuiEnabled:fire(game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat))
end

function module.IsFocused(_, _)
    return chatBar:IsFocused()
end

module.ChatBarFocusChanged = tbl3.Signal()
module.VisibilityStateChanged = tbl3.Signal()
module.MessagesChanged = tbl3.Signal()

module.MessagePosted = tbl3.Signal()
module.CoreGuiEnabled = tbl3.Signal()

module.ChatMakeSystemMessageEvent = tbl3.Signal()
module.ChatWindowPositionEvent = tbl3.Signal()
module.ChatWindowSizeEvent = tbl3.Signal()
module.ChatBarDisabledEvent = tbl3.Signal()

function module.fChatWindowPosition(_)
    return chatWindow.GuiObject.Position
end

function module.fChatWindowSize(_)
    return chatWindow.GuiObject.Size
end

function module.fChatBarDisabled(_): boolean
    return not chatBar:GetEnabled()
end

function module.SpecialKeyPressed(_, specialKey, _)
    if specialKey == Enum.SpecialKey.ChatHotkey and bool1 then
        DoChatBarFocus()
    end
end

module.CoreGuiEnabled:connect(function(isCoreGuiEnabled)
    module.IsCoreGuiEnabled = isCoreGuiEnabled

    isCoreGuiEnabled = isCoreGuiEnabled and (module.TopbarEnabled or ChatSettings.ChatOnWithTopBarOff)

    chatWindow:SetCoreGuiEnabled(isCoreGuiEnabled)

    if not isCoreGuiEnabled then
        chatBar:ReleaseFocus()
        InstantFadeOut()
        return
    end
    InstantFadeIn()
end)

function trimTrailingSpaces(arg1)
    local num4 = #arg1

    while num4 > 0 and arg1:find("^%s", num4) do
        num4 -= 1
    end

    return arg1:sub(1, num4)
end

module.ChatMakeSystemMessageEvent:connect(function(extraData)
    if not extraData.Text or type(extraData.Text) ~= "string" then
        return
    end

    while not bool2 do
        wait()
    end
    local generalChannelName = ChatSettings.GeneralChannelName
    local channel = chatWindow:GetChannel(generalChannelName)

    if not channel then
        return
    end

    local tbl4 = {
        ID = -1,
        FromSpeaker = nil,
        SpeakerUserId = 0,
        OriginalChannel = generalChannelName,
        IsFiltered = true,
        MessageLength = string.len(extraData.Text),
        MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(extraData.Text)),
        Message = trimTrailingSpaces(extraData.Text),
        MessageType = ChatConstants.MessageTypeSetCore,
        Time = os.time(),
        ExtraData = extraData
    }
    channel:AddMessageToChannel(tbl4)
    channelsBar:UpdateMessagePostedInChannel(generalChannelName)

    module.MessageCount += 1
    module.MessagesChanged:fire(module.MessageCount)
end)

module.ChatBarDisabledEvent:connect(function(arg1)
    if not bool1 then
        return
    end

    chatBar:SetEnabled(not arg1)
    if arg1 then
        chatBar:ReleaseFocus()
    end
end)

module.ChatWindowSizeEvent:connect(function(size)
    chatWindow.GuiObject.Size = size
end)

module.ChatWindowPositionEvent:connect(function(position)
    chatWindow.GuiObject.Position = position
end)

DoChatBarFocus = function()
    if chatWindow:GetCoreGuiEnabled() and chatBar:GetEnabled() and not chatBar:IsFocused() and chatBar:GetVisible() then
        module:SetVisible(true)
        InstantFadeIn()
        chatBar:CaptureFocus()
        module.ChatBarFocusChanged:fire(true)
    end
end

bindableEvent4.Event:connect(function(bool5: boolean)
    module.ChatBarFocusChanged:fire(bool5)
end)

function DoSwitchCurrentChannel(arg1)
    if chatWindow:GetChannel(arg1) then
        chatWindow:SwitchCurrentChannel(arg1)
    end
end

function SendMessageToSelfInTargetChannel(arg1, originalChannel, extraData)
    local channel = chatWindow:GetChannel(originalChannel)
    if not channel then
        return
    end

    channel:AddMessageToChannel({
        ID = -1,
        FromSpeaker = nil,
        SpeakerUserId = 0,
        OriginalChannel = originalChannel,
        IsFiltered = true,
        MessageLength = string.len(arg1),
        MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(arg1)),
        Message = trimTrailingSpaces(arg1),
        MessageType = ChatConstants.MessageTypeSystem,
        Time = os.time(),
        ExtraData = extraData
    })
end

function chatBarFocused()
    if not var6 then
        DoBackgroundFadeIn()
        if bool4 then
            DoTextFadeIn()
        end
    end

    bindableEvent4:Fire(true)
end

function chatBarFocusLost(arg1, _)
    DoBackgroundFadeIn()
    bindableEvent4:Fire(false)

    if not arg1 then
        return
    end

    local textBoxText = chatBar:GetTextBox().Text

    if chatBar:IsInCustomState() then
        textBoxText = chatBar:GetCustomMessage() or textBoxText

        local var7 = chatBar:CustomStateProcessCompletedMessage(textBoxText)
        chatBar:ResetCustomState()
        if var7 then
            return
        end
    end

    chatBar:GetTextBox().Text = ""

    if textBoxText == "" then
        return
    end
    module.MessagePosted:fire(textBoxText)

    if commandProcessor:ProcessCompletedChatMessage(textBoxText, chatWindow) then
        return
    end

    if ChatSettings.DisallowedWhiteSpace then
        for i = 1, #ChatSettings.DisallowedWhiteSpace do
            if ChatSettings.DisallowedWhiteSpace[i] == "\t" then
                textBoxText = string.gsub(textBoxText, ChatSettings.DisallowedWhiteSpace[i], " ")
            else
                textBoxText = string.gsub(textBoxText, ChatSettings.DisallowedWhiteSpace[i], "")
            end
        end
    end
    local var7 = string.gsub(textBoxText, "\n", "")
    local var8 = string.gsub(var7, "[ ]+", " ")

    local targetMessageChannel = chatWindow:GetTargetMessageChannel()
    if targetMessageChannel then
        MessageSender:SendMessage(var8, targetMessageChannel)
        return
    end
    MessageSender:SendMessage(var8, nil)
end

local tbl4 = {}
function setupChatBarConnections()
    for i = 1, #tbl4 do
        tbl4[i]:Disconnect()
    end
    tbl4 = {}

    table.insert(tbl4, (chatBar:GetTextBox().FocusLost:connect(chatBarFocusLost)))

    table.insert(tbl4, (chatBar:GetTextBox().Focused:connect(chatBarFocused)))
end

setupChatBarConnections()
chatBar.GuiObjectsChanged:connect(setupChatBarConnections)

function getEchoMessagesInGeneral()
    return ChatSettings.EchoMessagesInGeneralChannel == nil or ChatSettings.EchoMessagesInGeneralChannel
end

tbl2.OnMessageDoneFiltering.OnClientEvent:connect(function(arg1)
    if not ChatSettings.ShowUserOwnFilteredMessage and arg1.FromSpeaker == LocalPlayer.Name then
        return
    end

    local originalChannel = arg1.OriginalChannel
    local channel = chatWindow:GetChannel(originalChannel)
    if channel then
        channel:UpdateMessageFiltered(arg1)
    end

    if not getEchoMessagesInGeneral()
        or not ChatSettings.GeneralChannelName
        or originalChannel == ChatSettings.GeneralChannelName
    then
        return
    end

    local channel2 = chatWindow:GetChannel(ChatSettings.GeneralChannelName)
    if channel2 then
        channel2:UpdateMessageFiltered(arg1)
    end
end)

tbl2.OnNewMessage.OnClientEvent:connect(function(arg1, generalChannelName)
    local channel = chatWindow:GetChannel(generalChannelName)
    if not channel then
        return
    end

    channel:AddMessageToChannel(arg1)

    if arg1.FromSpeaker ~= LocalPlayer.Name then
        channelsBar:UpdateMessagePostedInChannel(generalChannelName)
    end

    if getEchoMessagesInGeneral() and ChatSettings.GeneralChannelName and generalChannelName ~= ChatSettings.GeneralChannelName then
        local channel2 = chatWindow:GetChannel(ChatSettings.GeneralChannelName)
        if channel2 then
            channel2:AddMessageToChannel(arg1)
        end
    end

    module.MessageCount += 1
    module.MessagesChanged:fire(module.MessageCount)

    DoFadeInFromNewInformation()
end)

tbl2.OnNewSystemMessage.OnClientEvent:connect(function(arg1, arg2)
    arg2 = arg2 or "System"

    local channel = chatWindow:GetChannel(arg2)
    if not channel then
        warn(string.format("Just received system message for channel I'm not in [%s]", arg2))
        return
    end

    channel:AddMessageToChannel(arg1)

    channelsBar:UpdateMessagePostedInChannel(arg2)

    module.MessageCount += 1
    module.MessagesChanged:fire(module.MessageCount)

    DoFadeInFromNewInformation()

    if not getEchoMessagesInGeneral() or not ChatSettings.GeneralChannelName or arg2 == ChatSettings.GeneralChannelName then
        return
    end

    local channel2 = chatWindow:GetChannel(ChatSettings.GeneralChannelName)
    if channel2 then
        channel2:AddMessageToChannel(arg1)
    end
end)

function HandleChannelJoined(originalChannel, arg1, arg2, arg3, arg4, arg5)
    if chatWindow:GetChannel(originalChannel) then
        chatWindow:RemoveChannel(originalChannel)
    end

    if originalChannel == ChatSettings.GeneralChannelName then
        bool2 = true
    end

    if arg3 then
        chatBar:SetChannelNameColor(originalChannel, arg3)
    end

    local var7 = chatWindow:AddChannel(originalChannel)

    if not var7 then
        return
    end

    if originalChannel == ChatSettings.GeneralChannelName then
        DoSwitchCurrentChannel(originalChannel)
    end

    if arg2 then
        local var8 = if #arg2 > ChatSettings.MessageHistoryLengthPerChannel then #arg2 - ChatSettings.MessageHistoryLengthPerChannel else 1

        for i = var8, #arg2 do
            var7:AddMessageToChannel(arg2[i])
        end

        if getEchoMessagesInGeneral()
            and arg4
            and ChatSettings.GeneralChannelName
            and originalChannel ~= ChatSettings.GeneralChannelName
        then
            local channel = chatWindow:GetChannel(ChatSettings.GeneralChannelName)
            if channel then
                channel:AddMessagesToChannelByTimeStamp(arg2, var8)
            end
        end
    end

    if arg1 ~= "" then
        local tbl5 = {
            ID = -1,
            FromSpeaker = nil,
            SpeakerUserId = 0,
            OriginalChannel = originalChannel,
            IsFiltered = true,
            MessageLength = string.len(arg1),
            MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(arg1)),
            Message = trimTrailingSpaces(arg1),
            MessageType = ChatConstants.MessageTypeWelcome,
            Time = os.time(),
            ExtraData = nil
        }

        var7:AddMessageToChannel(tbl5)

        if getEchoMessagesInGeneral()
            and arg5
            and not ChatSettings.ShowChannelsBar
            and originalChannel ~= ChatSettings.GeneralChannelName
        then
            local channel = chatWindow:GetChannel(ChatSettings.GeneralChannelName)
            if channel then
                channel:AddMessageToChannel(tbl5)
            end
        end
    end

    local var8 = var3:Get(
        "GameChat_ChatMain_ChatTranslationOnboarding",
        "Text chat will be translated into your language. Tap the symbol in front of the message to see the original. You can turn off translations in the Settings menu."
    )
    if var1 and var8 ~= "" and originalChannel == ChatSettings.GeneralChannelName and var4 ~= nil and var4.Value then
        var7:AddMessageToChannel({
            ID = -2,
            FromSpeaker = nil,
            SpeakerUserId = 0,
            OriginalChannel = originalChannel,
            IsFiltered = true,
            MessageLength = string.len(var8),
            MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(var8)),
            Message = trimTrailingSpaces(var8),
            MessageType = ChatConstants.MessageTypeWelcome,
            Time = os.time(),
            ExtraData = nil
        })
    end
    DoFadeInFromNewInformation()
end

tbl2.OnChannelJoined.OnClientEvent:connect(function(arg1, arg2, arg3, arg4)
    HandleChannelJoined(arg1, arg2, arg3, arg4, false, true)
end)

tbl2.OnChannelLeft.OnClientEvent:connect(function(arg1)
    chatWindow:RemoveChannel(arg1)

    DoFadeInFromNewInformation()
end)

tbl2.OnMuted.OnClientEvent:connect(function(_) end)

tbl2.OnUnmuted.OnClientEvent:connect(function(_) end)

tbl2.OnMainChannelSet.OnClientEvent:connect(function(arg1)
    DoSwitchCurrentChannel(arg1)
end)

coroutine.wrap(function()
    local channelNameColorUpdated = DefaultChatSystemChatEvents:WaitForChild("ChannelNameColorUpdated", 5)
    if channelNameColorUpdated then
        channelNameColorUpdated.OnClientEvent:connect(function(arg1, arg2)
            chatBar:SetChannelNameColor(arg1, arg2)
        end)
    end
end)()

local core = nil
local core2 = nil
local core3 = nil
local core4 = nil

pcall(function()
    core = StarterGui:GetCore("PlayerBlockedEvent")
    core2 = StarterGui:GetCore("PlayerMutedEvent")
    core3 = StarterGui:GetCore("PlayerUnblockedEvent")
    core4 = StarterGui:GetCore("PlayerUnmutedEvent")
end)

function SendSystemMessageToSelf(arg1)
    local currentChannel = chatWindow:GetCurrentChannel()

    if not currentChannel then
        return
    end

    currentChannel:AddMessageToChannel({
        ID = -1,
        FromSpeaker = nil,
        SpeakerUserId = 0,
        OriginalChannel = currentChannel.Name,
        IsFiltered = true,
        MessageLength = string.len(arg1),
        MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(arg1)),
        Message = trimTrailingSpaces(arg1),
        MessageType = ChatConstants.MessageTypeSystem,
        Time = os.time(),
        ExtraData = nil
    })
end

function MutePlayer(arg1)
    local mutePlayerRequest = DefaultChatSystemChatEvents:FindFirstChild("MutePlayerRequest")
    if mutePlayerRequest then
        return mutePlayerRequest:InvokeServer(arg1.Name)
    end
    return false
end

if core then
    core.Event:connect(function(arg1)
        if MutePlayer(arg1) then
            local rbxName = if ChatSettings.PlayerDisplayNamesEnabled then arg1.DisplayName else arg1.Name
            SendSystemMessageToSelf(
                var3:Get(
                    "GameChat_ChatMain_SpeakerHasBeenBlocked",
                    string.format("Speaker '%s' has been blocked.", rbxName),
                    { RBX_NAME = rbxName }
                )
            )
        end
    end)
end

if result then
    local function ShowFriendJoinNotification() -- Luacid: Inlined by compiler; 1 call site recovered
        return not (ChatSettings.ShowFriendJoinNotification == nil) and ChatSettings.ShowFriendJoinNotification
    end

    if ShowFriendJoinNotification() then
        Players.PlayerAdded:Connect(function(player: Player)
            local success4, result4 = pcall(function(): boolean
                return player:IsFriendsWith(LocalPlayer.UserId)
            end)

            if not success4 or not result4 then
                return
            end

            local playerName = player.Name
            if ChatSettings.PlayerDisplayNamesEnabled then
                playerName = player.DisplayName
            end

            local var7 = var3:FormatMessageToSend(
                "GameChat_FriendChatNotifier_JoinMessage",
                string.format("Your friend %s has joined the game.", playerName),
                "RBX_NAME",
                playerName
            )

            SendSystemMessageToSelf(var7)
        end)
    end
end

if core2 then
    core2.Event:connect(function(arg1)
        if MutePlayer(arg1) then
            local rbxName = if ChatSettings.PlayerDisplayNamesEnabled then arg1.DisplayName else arg1.Name
            SendSystemMessageToSelf(
                var3:Get(
                    "GameChat_ChatMain_SpeakerHasBeenMuted",
                    string.format("Speaker '%s' has been muted.", rbxName),
                    { RBX_NAME = rbxName }
                )
            )
        end
    end)
end

function UnmutePlayer(arg1)
    local unMutePlayerRequest = DefaultChatSystemChatEvents:FindFirstChild("UnMutePlayerRequest")
    if unMutePlayerRequest then
        return unMutePlayerRequest:InvokeServer(arg1.Name)
    end
    return false
end

if core3 then
    core3.Event:connect(function(arg1)
        if UnmutePlayer(arg1) then
            local rbxName = if ChatSettings.PlayerDisplayNamesEnabled then arg1.DisplayName else arg1.Name
            SendSystemMessageToSelf(
                var3:Get(
                    "GameChat_ChatMain_SpeakerHasBeenUnBlocked",
                    string.format("Speaker '%s' has been unblocked.", rbxName),
                    { RBX_NAME = rbxName }
                )
            )
        end
    end)
end

if core4 then
    core4.Event:connect(function(arg1)
        if UnmutePlayer(arg1) then
            local rbxName = if ChatSettings.PlayerDisplayNamesEnabled then arg1.DisplayName else arg1.Name
            SendSystemMessageToSelf(
                var3:Get(
                    "GameChat_ChatMain_SpeakerHasBeenUnMuted",
                    string.format("Speaker '%s' has been unmuted.", rbxName),
                    { RBX_NAME = rbxName }
                )
            )
        end
    end)
end

spawn(function()
    if not (LocalPlayer.UserId > 0) then
        return
    end

    pcall(function()
        local core5 = StarterGui:GetCore("GetBlockedUserIds")
        if not (#core5 > 0) then
            return
        end

        local setBlockedUserIdsRequest = DefaultChatSystemChatEvents:FindFirstChild("SetBlockedUserIdsRequest")
        if setBlockedUserIdsRequest then
            setBlockedUserIdsRequest:FireServer(core5)
        end
    end)
end)

spawn(function()
    local success4, result4 = pcall(function(): boolean
        return Chat:CanUserChatAsync(LocalPlayer.UserId)
    end)
    if success4 then
        bool1 = RunService:IsStudio() or result4
    end
end)

local serverResult = tbl2.GetInitDataRequest:InvokeServer()

for _, Channel in pairs(serverResult.Channels) do
    if Channel[1] == ChatSettings.GeneralChannelName then
        HandleChannelJoined(Channel[1], Channel[2], Channel[3], Channel[4], true, false)
    end
end

for _, Channel in pairs(serverResult.Channels) do
    if Channel[1] ~= ChatSettings.GeneralChannelName then
        HandleChannelJoined(Channel[1], Channel[2], Channel[3], Channel[4], true, false)
    end
end

return module
