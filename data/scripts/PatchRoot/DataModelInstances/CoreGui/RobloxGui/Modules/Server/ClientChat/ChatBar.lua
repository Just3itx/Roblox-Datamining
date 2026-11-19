-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
    Players.PlayerAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local Chat = game:GetService("Chat")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local scriptParent = script.Parent
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(scriptParent:WaitForChild("CurveUtil"))

local CommandModules = ClientChatModules:WaitForChild("CommandModules")
local Whisper = require(CommandModules:WaitForChild("Whisper"))

local _MessageSender = require(scriptParent:WaitForChild("MessageSender"))

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

if var1 == nil then
    var1 = {}

    function var1.Get<T>(_, _, arg1: T): T
        return arg1
    end
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:CreateGuiObjects(chatBarParentFrame)
    self.ChatBarParentFrame = chatBarParentFrame

    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = ChatSettings.ChatBarBackGroundColor
    frame.Parent = chatBarParentFrame

    local boxFrame = Instance.new("Frame")
    boxFrame.Selectable = false
    boxFrame.Name = "BoxFrame"
    boxFrame.BackgroundTransparency = 0.6
    boxFrame.BorderSizePixel = 0
    boxFrame.BackgroundColor3 = ChatSettings.ChatBarBoxColor
    boxFrame.Size = UDim2.new(1, -14, 1, -14)
    boxFrame.Position = UDim2.new(0, 7, 0, 7)
    boxFrame.Parent = frame

    local frame2 = Instance.new("Frame")
    frame2.BackgroundTransparency = 1
    frame2.Size = UDim2.new(1, -10, 1, -10)
    frame2.Position = UDim2.new(0, 5, 0, 5)
    frame2.Parent = boxFrame

    local chatBar = Instance.new("TextBox")
    chatBar.Selectable = ChatSettings.GamepadNavigationEnabled
    chatBar.Name = "ChatBar"
    chatBar.BackgroundTransparency = 1
    chatBar.Size = UDim2.new(1, 0, 1, 0)
    chatBar.Position = UDim2.new(0, 0, 0, 0)
    chatBar.TextSize = ChatSettings.ChatBarTextSize
    chatBar.Font = ChatSettings.ChatBarFont
    chatBar.TextColor3 = ChatSettings.ChatBarTextColor
    chatBar.TextTransparency = 0.4
    chatBar.TextStrokeTransparency = 1
    chatBar.ClearTextOnFocus = false
    chatBar.TextXAlignment = Enum.TextXAlignment.Left
    chatBar.TextYAlignment = Enum.TextYAlignment.Top
    chatBar.TextWrapped = true
    chatBar.Text = ""
    chatBar.Parent = frame2

    local messageMode = Instance.new("TextButton")
    messageMode.Selectable = false
    messageMode.Name = "MessageMode"
    messageMode.BackgroundTransparency = 1
    messageMode.Position = UDim2.new(0, 0, 0, 0)
    messageMode.TextSize = ChatSettings.ChatBarTextSize
    messageMode.Font = ChatSettings.ChatBarFont
    messageMode.TextXAlignment = Enum.TextXAlignment.Left
    messageMode.TextWrapped = true
    messageMode.Text = ""
    messageMode.Size = UDim2.new(0, 0, 0, 0)
    messageMode.TextYAlignment = Enum.TextYAlignment.Center
    messageMode.TextColor3 = self:GetDefaultChannelNameColor()
    messageMode.Visible = true
    messageMode.Parent = frame2

    local textLabel = Instance.new("TextLabel")
    textLabel.Selectable = false
    textLabel.TextWrapped = true
    textLabel.BackgroundTransparency = 1
    textLabel.Size = chatBar.Size
    textLabel.Position = chatBar.Position
    textLabel.TextSize = chatBar.TextSize
    textLabel.Font = chatBar.Font
    textLabel.TextColor3 = chatBar.TextColor3
    textLabel.TextTransparency = chatBar.TextTransparency
    textLabel.TextStrokeTransparency = chatBar.TextStrokeTransparency
    textLabel.TextXAlignment = chatBar.TextXAlignment
    textLabel.TextYAlignment = chatBar.TextYAlignment
    textLabel.Text = "..."
    textLabel.Parent = frame2

    self.GuiObject = frame
    self.TextBox = chatBar
    self.TextLabel = textLabel

    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.TextBoxFrame = boxFrame
    self.GuiObjects.TextBox = chatBar
    self.GuiObjects.TextLabel = textLabel
    self.GuiObjects.MessageModeTextButton = messageMode

    self:AnimGuiObjects()
    self:SetUpTextBoxEvents(chatBar, textLabel, messageMode)
    if self.UserHasChatOff then
        self:DoLockChatBar()
    end
    self.eGuiObjectsChanged:Fire()
end

function tbl1:DoLockChatBar()
    if self.TextLabel then
        if LocalPlayer.UserId > 0 then
            self.TextLabel.Text = var1:Get("GameChat_ChatMessageValidator_SettingsError", "To chat in game, turn on chat in your Privacy Settings.")
        else
            self.TextLabel.Text = var1:Get("GameChat_SwallowGuestChat_Message", "Sign up to chat in game.")
        end

        self:CalculateSize()
    end
    if self.TextBox then
        self.TextBox.Active = false
        self.TextBox.Focused:connect(function()
            self.TextBox:ReleaseFocus()
        end)
    end
end

function tbl1:SetUpTextBoxEvents(arg1, arg2, arg3)
    for k, textBoxConnection in pairs(self.TextBoxConnections) do
        textBoxConnection:disconnect()
        self.TextBoxConnections[k] = nil
    end

    self.TextBoxConnections.UserInputBegan = UserInputService.InputBegan:connect(function(input: InputObject, _: boolean)
        if input.KeyCode == Enum.KeyCode.Backspace and self:IsFocused() and arg1.Text == "" then
            self:SetChannelTarget(ChatSettings.GeneralChannelName)
        end
    end)

    self.TextBoxConnections.TextBoxChanged = arg1.Changed:connect(function(arg4)
        if arg4 == "AbsoluteSize" then
            self:CalculateSize()
            return
        end

        if arg4 ~= "Text" then
            return
        end

        self:CalculateSize()

        if utf8.len(utf8.nfcnormalize(arg1.Text)) > ChatSettings.MaximumMessageLength then
            arg1.Text = self.PreviousText
        else
            self.PreviousText = arg1.Text
        end

        if self.InCustomState then
            self.CustomState:TextUpdated()
            return
        end

        local customState = self.CommandProcessor:ProcessInProgressChatMessage(arg1.Text, self.ChatWindow, self)
        if customState then
            self.InCustomState = true
            self.CustomState = customState
        end
    end)

    local function UpdateOnFocusStatusChanged(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 or arg1.Text ~= "" then
            arg2.Visible = false
            return
        end
        arg2.Visible = true
    end

    self.TextBoxConnections.MessageModeClick = arg3.MouseButton1Click:connect(function()
        if arg3.Text ~= "" then
            self:SetChannelTarget(ChatSettings.GeneralChannelName)
        end
    end)

    self.TextBoxConnections.TextBoxFocused = arg1.Focused:connect(function()
        if not self.UserHasChatOff then
            self:CalculateSize()
            UpdateOnFocusStatusChanged(true)
        end
    end)

    self.TextBoxConnections.TextBoxFocusLost = arg1.FocusLost:connect(function(_: boolean, inputThatCausedFocusLoss: InputObject)
        self:CalculateSize()
        if inputThatCausedFocusLoss and inputThatCausedFocusLoss.KeyCode == Enum.KeyCode.Escape then
            arg1.Text = ""
        end

        UpdateOnFocusStatusChanged(false)
    end)
end

function tbl1:GetTextBox()
    return self.TextBox
end

function tbl1:GetMessageModeTextButton()
    return self.GuiObjects.MessageModeTextButton
end

function tbl1.GetMessageModeTextLabel(arg1)
    return arg1:GetMessageModeTextButton()
end

function tbl1:IsFocused()
    if self.UserHasChatOff then
        return false
    end

    return self:GetTextBox():IsFocused()
end

function tbl1:GetVisible()
    return self.GuiObject.Visible
end

function tbl1:CaptureFocus()
    if not self.UserHasChatOff then
        self:GetTextBox():CaptureFocus()
    end
end

function tbl1.ReleaseFocus(arg1, arg2)
    arg1:GetTextBox():ReleaseFocus(arg2)
end

function tbl1.ResetText(arg1)
    arg1:GetTextBox().Text = ""
end

function tbl1:SetText(text)
    self:GetTextBox().Text = text
end

function tbl1:GetEnabled()
    return self.GuiObject.Visible
end

function tbl1:SetEnabled(visible)
    if self.UserHasChatOff then
        self.GuiObject.Visible = true
        return
    end
    self.GuiObject.Visible = visible
end

function tbl1:SetTextLabelText(text)
    if not self.UserHasChatOff then
        self.TextLabel.Text = text
    end
end

function tbl1:SetTextBoxText(text)
    self.TextBox.Text = text
end

function tbl1:GetTextBoxText()
    return self.TextBox.Text
end

function tbl1:ResetSize()
    self.TargetYSize = 0
    self:TweenToTargetYSize()
end

local function measureSize(arg1): Vector2 -- Luacid: Inlined by compiler; 2 call sites recovered
    return TextService:GetTextSize(arg1.Text, arg1.TextSize, arg1.Font, Vector2.new(arg1.AbsoluteSize.X, 10000))
end

function tbl1:CalculateSize()
    if self.CalculatingSizeLock then
        return
    end
    self.CalculatingSizeLock = true
    local textSize, y

    if self:IsFocused() or self.TextBox.Text ~= "" then
        textSize = self.TextBox.TextSize
        y = measureSize(self.TextBox).Y
    else
        textSize = self.TextLabel.TextSize
        y = measureSize(self.TextLabel).Y
    end

    local targetYSize = y - textSize
    if self.TargetYSize ~= targetYSize then
        self.TargetYSize = targetYSize
        self:TweenToTargetYSize()
    end

    self.CalculatingSizeLock = false
end

function tbl1:TweenToTargetYSize()
    local uDim2 = UDim2.new(1, 0, 1, self.TargetYSize)
    local guiObjectSize = self.GuiObject.Size

    local absoluteSizeY = self.GuiObject.AbsoluteSize.Y
    self.GuiObject.Size = uDim2
    local absoluteSizeY2 = self.GuiObject.AbsoluteSize.Y
    self.GuiObject.Size = guiObjectSize

    local num1 = math.min(1, math.abs(absoluteSizeY2 - absoluteSizeY) * (1 / self.TweenPixelsPerSecond))

    if not pcall(function()
        self.GuiObject:TweenSize(uDim2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, num1, true)
    end) then
        self.GuiObject.Size = uDim2
    end
end

function tbl1:SetTextSize(textSize)
    if self:IsInCustomState() then
        return
    end

    if self.TextBox then
        self.TextBox.TextSize = textSize
    end
    if self.TextLabel then
        self.TextLabel.TextSize = textSize
    end
end

function tbl1:GetDefaultChannelNameColor()
    if ChatSettings.DefaultChannelNameColor then
        return ChatSettings.DefaultChannelNameColor
    end
    return Color3.fromRGB(35, 76, 142)
end

function tbl1:SetChannelTarget(targetChannel)
    local messageModeTextButton = self.GuiObjects.MessageModeTextButton
    local textBox = self.TextBox
    local textLabel = self.TextLabel

    self.TargetChannel = targetChannel

    if self:IsInCustomState() then
        return
    end

    if targetChannel == ChatSettings.GeneralChannelName then
        messageModeTextButton.Text = ""
        messageModeTextButton.Size = UDim2.new(0, 0, 0, 0)
        textBox.Size = UDim2.new(1, 0, 1, 0)
        textBox.Position = UDim2.new(0, 0, 0, 0)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Position = UDim2.new(0, 0, 0, 0)
        return
    end

    messageModeTextButton.Size = UDim2.new(0, 1000, 1, 0)
    local var2 = if var1.tryLocalize then var1:tryLocalize(targetChannel) else targetChannel
    messageModeTextButton.Text = string.format("[%s] ", var2)

    local textColor3 = self:GetChannelNameColor(targetChannel)
    if textColor3 then
        messageModeTextButton.TextColor3 = textColor3
    else
        messageModeTextButton.TextColor3 = self:GetDefaultChannelNameColor()
    end

    local textBoundsX = messageModeTextButton.TextBounds.X
    messageModeTextButton.Size = UDim2.new(0, textBoundsX, 1, 0)
    textBox.Size = UDim2.new(1, -textBoundsX, 1, 0)
    textBox.Position = UDim2.new(0, textBoundsX, 0, 0)
    textLabel.Size = UDim2.new(1, -textBoundsX, 1, 0)
    textLabel.Position = UDim2.new(0, textBoundsX, 0, 0)
end

function tbl1:IsInCustomState()
    return self.InCustomState
end

function tbl1:ResetCustomState()
    if not self.InCustomState then
        return
    end

    self.CustomState:Destroy()
    self.CustomState = nil
    self.InCustomState = false

    self.ChatBarParentFrame:ClearAllChildren()
    self:CreateGuiObjects(self.ChatBarParentFrame)
    self:SetTextLabelText(var1:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
end

function tbl1:EnterWhisperState(arg1)
    self:ResetCustomState()
    if Whisper.CustomStateCreator then
        self.CustomState = Whisper.CustomStateCreator(arg1, self.ChatWindow, self, ChatSettings)

        self.InCustomState = true
    else
        local var2 = if ChatSettings.PlayerDisplayNamesEnabled then arg1.DisplayName else arg1.Name
        self:SetText("/w " .. var2)
    end
    self:CaptureFocus()
end

function tbl1:GetCustomMessage()
    if self.InCustomState then
        return self.CustomState:GetMessage()
    end
    return nil
end

function tbl1:CustomStateProcessCompletedMessage(_)
    if self.InCustomState then
        return self.CustomState:ProcessCompletedMessage()
    end
    return false
end

function tbl1:FadeOutBackground(arg1)
    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
    self:FadeOutText(arg1)
end

function tbl1:FadeInBackground(arg1)
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
    self:FadeInText(arg1)
end

function tbl1:FadeOutText(arg1)
    self.AnimParams.Text_TargetTransparency = 1
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeInText(arg1)
    self.AnimParams.Text_TargetTransparency = 0.4
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:AnimGuiObjects()
    self.GuiObject.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.TextBoxFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency

    self.GuiObjects.TextLabel.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.GuiObjects.TextBox.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.GuiObjects.MessageModeTextButton.TextTransparency = self.AnimParams.Text_CurrentTransparency
end

function tbl1:InitializeAnimParams()
    self.AnimParams.Text_TargetTransparency = 0.4
    self.AnimParams.Text_CurrentTransparency = 0.4
    self.AnimParams.Text_NormalizedExptValue = 1

    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = 1
end

function tbl1:Update(arg1)
    self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Text_CurrentTransparency,
        self.AnimParams.Text_TargetTransparency,
        self.AnimParams.Text_NormalizedExptValue,
        arg1
    )

    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Background_CurrentTransparency,
        self.AnimParams.Background_TargetTransparency,
        self.AnimParams.Background_NormalizedExptValue,
        arg1
    )

    self:AnimGuiObjects()
end

function tbl1:SetChannelNameColor(text, textColor3)
    self.ChannelNameColors[text] = textColor3
    if self.GuiObjects.MessageModeTextButton.Text == text then
        self.GuiObjects.MessageModeTextButton.TextColor3 = textColor3
    end
end

function tbl1:GetChannelNameColor(arg1)
    return self.ChannelNameColors[arg1]
end

function module.new(commandProcessor, chatWindow)
    local self = setmetatable({}, tbl1)

    self.GuiObject = nil
    self.ChatBarParentFrame = nil
    self.TextBox = nil
    self.TextLabel = nil
    self.GuiObjects = {}
    self.eGuiObjectsChanged = Instance.new("BindableEvent")
    self.GuiObjectsChanged = self.eGuiObjectsChanged.Event
    self.TextBoxConnections = {}
    self.PreviousText = ""

    self.InCustomState = false
    self.CustomState = nil

    self.TargetChannel = nil
    self.CommandProcessor = commandProcessor
    self.ChatWindow = chatWindow

    self.TweenPixelsPerSecond = 500
    self.TargetYSize = 0

    self.AnimParams = {}
    self.CalculatingSizeLock = false

    self.ChannelNameColors = {}

    self.UserHasChatOff = false

    self:InitializeAnimParams()

    ChatSettings.SettingsChanged:connect(function(arg1, arg2)
        if arg1 == "ChatBarTextSize" then
            self:SetTextSize(arg2)
        end
    end)

    coroutine.wrap(function()
        local success, result = pcall(function(): boolean
            return Chat:CanUserChatAsync(LocalPlayer.UserId)
        end)
        if (success and (RunService:IsStudio() or result)) == false then
            self.UserHasChatOff = true
            self:DoLockChatBar()
        end
    end)()

    return self
end

return module
