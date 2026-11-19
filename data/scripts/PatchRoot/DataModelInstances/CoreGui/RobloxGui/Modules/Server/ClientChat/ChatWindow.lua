-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local Players = game:GetService("Players")
local _Chat = game:GetService("Chat")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local Chat = game:GetService("Chat")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local scriptParent = script.Parent
local ChatChannel = require(scriptParent:WaitForChild("ChatChannel"))
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(scriptParent:WaitForChild("CurveUtil"))

local tbl1 = {}
tbl1.__index = tbl1

function getClassicChatEnabled()
    return if ChatSettings.ClassicChatEnabled == nil then Players.ClassicChat else ChatSettings.ClassicChatEnabled
end

function getBubbleChatEnabled()
    return if ChatSettings.BubbleChatEnabled == nil then Players.BubbleChat else ChatSettings.BubbleChatEnabled
end

function bubbleChatOnly()
    return not getClassicChatEnabled() and getBubbleChatEnabled()
end

function mergeProps(arg1, chatSettings)
    if not (arg1 and chatSettings) then
        return
    end

    for k, value in pairs(arg1) do
        if chatSettings[k] ~= nil then
            chatSettings[k] = value
        end
    end
end

function tbl1:CreateGuiObjects(parent)
    local chatCallbackResult = nil
    pcall(function()
        chatCallbackResult = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, nil)
    end)

    mergeProps(chatCallbackResult, ChatSettings)

    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Active = ChatSettings.WindowDraggable
    frame.Parent = parent
    frame.AutoLocalize = false

    local chatBarParentFrame = Instance.new("Frame")
    chatBarParentFrame.Selectable = false
    chatBarParentFrame.Name = "ChatBarParentFrame"
    chatBarParentFrame.BackgroundTransparency = 1
    chatBarParentFrame.Parent = frame

    local channelsBarParentFrame = Instance.new("Frame")
    channelsBarParentFrame.Selectable = false
    channelsBarParentFrame.Name = "ChannelsBarParentFrame"
    channelsBarParentFrame.BackgroundTransparency = 1
    channelsBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
    channelsBarParentFrame.Parent = frame

    local chatChannelParentFrame = Instance.new("Frame")
    chatChannelParentFrame.Selectable = false
    chatChannelParentFrame.Name = "ChatChannelParentFrame"
    chatChannelParentFrame.BackgroundTransparency = 1
    chatChannelParentFrame.BackgroundColor3 = ChatSettings.BackGroundColor
    chatChannelParentFrame.BackgroundTransparency = 0.6
    chatChannelParentFrame.BorderSizePixel = 0
    chatChannelParentFrame.Parent = frame

    local imageButton = Instance.new("ImageButton")
    imageButton.Selectable = false
    imageButton.Image = ""
    imageButton.BackgroundTransparency = 0.6
    imageButton.BorderSizePixel = 0
    imageButton.Visible = false
    imageButton.BackgroundColor3 = ChatSettings.BackGroundColor
    imageButton.Active = true
    if bubbleChatOnly() then
        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 0, 0)
    else
        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 1, -imageButton.AbsoluteSize.Y)
    end
    imageButton.Parent = frame

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Selectable = false
    imageLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
    imageLabel.Position = UDim2.new(0.2, 0, 0.2, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "rbxassetid://261880743"
    imageLabel.Parent = imageButton

    local function GetScreenGuiParent(): Instance? -- Luacid: Inlined by compiler; 4 call sites recovered
        local frame2 = frame
        while frame2 and not frame2:IsA("ScreenGui") do
            frame2 = frame2.Parent
        end

        return frame2
    end

    local num1 = 3
    local frame2 = GetScreenGuiParent()
    num1 = if frame2.AbsoluteSize.X <= 640 then 1 elseif frame2.AbsoluteSize.X <= 1024 then 2 else num1

    local bool1 = false
    local function doCheckSizeBounds()
        if bool1 then
            return
        end

        bool1 = true

        if not frame:IsDescendantOf(PlayerGui) then
            return
        end

        local screenGuiParent = GetScreenGuiParent()
        local minimumWindowSize = ChatSettings.MinimumWindowSize
        local maximumWindowSize = ChatSettings.MaximumWindowSize

        local num2 = channelsBarParentFrame.AbsoluteSize.Y + chatBarParentFrame.AbsoluteSize.Y

        local var1 = minimumWindowSize.X.Scale * screenGuiParent.AbsoluteSize.X + minimumWindowSize.X.Offset
        local num3 = math.max(minimumWindowSize.Y.Scale * screenGuiParent.AbsoluteSize.Y + minimumWindowSize.Y.Offset, num2)

        local var2 = maximumWindowSize.X.Scale * screenGuiParent.AbsoluteSize.X + maximumWindowSize.X.Offset
        local var3 = maximumWindowSize.Y.Scale * screenGuiParent.AbsoluteSize.Y + maximumWindowSize.Y.Offset

        local absoluteSizeX = frame.AbsoluteSize.X
        local absoluteSizeY = frame.AbsoluteSize.Y

        if absoluteSizeX < var1 then
            local uDim2 = UDim2.new(0, var1 - absoluteSizeX, 0, 0)
            frame.Size += uDim2
        elseif var2 < absoluteSizeX then
            local uDim2 = UDim2.new(0, var2 - absoluteSizeX, 0, 0)
            frame.Size += uDim2
        end

        if absoluteSizeY < num3 then
            local uDim2 = UDim2.new(0, 0, 0, num3 - absoluteSizeY)
            frame.Size += uDim2
        elseif var3 < absoluteSizeY then
            local uDim2 = UDim2.new(0, 0, 0, var3 - absoluteSizeY)
            frame.Size += uDim2
        end

        local xScale = frame.AbsoluteSize.X / screenGuiParent.AbsoluteSize.X
        local yScale = frame.AbsoluteSize.Y / screenGuiParent.AbsoluteSize.Y

        frame.Size = UDim2.new(xScale, 0, yScale, 0)

        bool1 = false
    end

    frame.Changed:connect(function(property: string)
        if property == "AbsoluteSize" then
            doCheckSizeBounds()
        end
    end)

    imageButton.DragBegin:connect(function(_uDim2: UDim2)
        frame.Draggable = false
    end)

    local function UpdatePositionFromDrag(absolutePosition: Vector2)
        if ChatSettings.WindowDraggable == false and ChatSettings.WindowResizable == false then
            return
        end
        local var1 = absolutePosition - frame.AbsolutePosition + imageButton.AbsoluteSize
        frame.Size = UDim2.new(0, var1.X, 0, var1.Y)
        if bubbleChatOnly() then
            imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 0, 0)
            return
        end
        imageButton.Position = UDim2.new(1, -imageButton.AbsoluteSize.X, 1, -imageButton.AbsoluteSize.Y)
    end

    imageButton.DragStopped:connect(function(_: number, _: number)
        frame.Draggable = ChatSettings.WindowDraggable
    end)

    local bool2 = false
    imageButton.Changed:connect(function(property: string)
        if property ~= "AbsolutePosition" or frame.Draggable then
            return
        end

        if bool2 then
            return
        end

        bool2 = true

        UpdatePositionFromDrag(imageButton.AbsolutePosition)

        bool2 = false
    end)

    local function CalculateChannelsBarPixelSize(arg1): number -- Luacid: unused: defined but never referenced
        if num1 == 1 then
            arg1 = arg1 or ChatSettings.ChatChannelsTabTextSizePhone
        else
            arg1 = arg1 or ChatSettings.ChatChannelsTabTextSize
        end

        return math.max(32, arg1 + 8) + 2
    end

    local function CalculateChatBarPixelSize(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if num1 == 1 then
            arg1 = arg1 or ChatSettings.ChatBarTextSizePhone
        else
            arg1 = arg1 or ChatSettings.ChatBarTextSize
        end

        return arg1 + 14 + 10
    end

    if bubbleChatOnly() then
        chatBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
        channelsBarParentFrame.Visible = false
        channelsBarParentFrame.Active = false
        chatChannelParentFrame.Visible = false
        chatChannelParentFrame.Active = false
        GetScreenGuiParent()
        local scale, offset

        if num1 == 1 then
            scale = ChatSettings.DefaultWindowSizePhone.X.Scale
            offset = ChatSettings.DefaultWindowSizePhone.X.Offset
        elseif num1 == 2 then
            scale = ChatSettings.DefaultWindowSizeTablet.X.Scale
            offset = ChatSettings.DefaultWindowSizeTablet.X.Offset
        else
            scale = ChatSettings.DefaultWindowSizeDesktop.X.Scale
            offset = ChatSettings.DefaultWindowSizeDesktop.X.Offset
        end

        local chatBarPixelSize = CalculateChatBarPixelSize(nil)

        frame.Size = UDim2.new(scale, offset, 0, chatBarPixelSize)
        frame.Position = ChatSettings.DefaultWindowPosition
    else
        GetScreenGuiParent()

        if num1 == 1 then
            frame.Size = ChatSettings.DefaultWindowSizePhone
        elseif num1 == 2 then
            frame.Size = ChatSettings.DefaultWindowSizeTablet
        else
            frame.Size = ChatSettings.DefaultWindowSizeDesktop
        end

        frame.Position = ChatSettings.DefaultWindowPosition
    end

    if num1 == 1 then
        ChatSettings.ChatWindowTextSize = ChatSettings.ChatWindowTextSizePhone
        ChatSettings.ChatChannelsTabTextSize = ChatSettings.ChatChannelsTabTextSizePhone
        ChatSettings.ChatBarTextSize = ChatSettings.ChatBarTextSizePhone
    end

    local function UpdateDraggable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        frame.Active = arg1
        frame.Draggable = arg1
    end

    local function UpdateResizable(arg1)
        imageButton.Visible = arg1
        imageButton.Draggable = arg1

        local offset = chatBarParentFrame.Size.Y.Offset

        if arg1 then
            chatBarParentFrame.Size = UDim2.new(1, -offset - 2, 0, offset)
            if not bubbleChatOnly() then
                chatBarParentFrame.Position = UDim2.new(0, 0, 1, -offset)
            end
        else
            chatBarParentFrame.Size = UDim2.new(1, 0, 0, offset)
            if not bubbleChatOnly() then
                chatBarParentFrame.Position = UDim2.new(0, 0, 1, -offset)
            end
        end
    end

    local function UpdateChatChannelParentFrameSize()
        local var1 = nil
        local num2 = math.max(
            32,
            (if num1 == 1 then var1 or ChatSettings.ChatChannelsTabTextSizePhone else var1 or ChatSettings.ChatChannelsTabTextSize) + 8
        ) + 2

        local chatBarPixelSize = CalculateChatBarPixelSize(nil)

        if ChatSettings.ShowChannelsBar then
            chatChannelParentFrame.Size = UDim2.new(1, 0, 1, -(num2 + chatBarPixelSize + 2 + 2))
            chatChannelParentFrame.Position = UDim2.new(0, 0, 0, num2 + 2)
            return
        end

        chatChannelParentFrame.Size = UDim2.new(1, 0, 1, -(chatBarPixelSize + 2 + 2))
        chatChannelParentFrame.Position = UDim2.new(0, 0, 0, 2)
    end

    local function UpdateChatChannelsTabTextSize(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local yOffset = math.max(
            32,
            (if num1 == 1 then arg1 or ChatSettings.ChatChannelsTabTextSizePhone else arg1 or ChatSettings.ChatChannelsTabTextSize) + 8
        ) + 2

        channelsBarParentFrame.Size = UDim2.new(1, 0, 0, yOffset)

        UpdateChatChannelParentFrameSize()
    end

    local function UpdateChatBarTextSize(arg1)
        local chatBarPixelSize = CalculateChatBarPixelSize(arg1)
        chatBarParentFrame.Size = UDim2.new(1, 0, 0, chatBarPixelSize)
        if not bubbleChatOnly() then
            chatBarParentFrame.Position = UDim2.new(0, 0, 1, -chatBarPixelSize)
        end

        imageButton.Size = UDim2.new(0, chatBarPixelSize, 0, chatBarPixelSize)
        imageButton.Position = UDim2.new(1, -chatBarPixelSize, 1, -chatBarPixelSize)

        UpdateChatChannelParentFrameSize()
        UpdateResizable(ChatSettings.WindowResizable)
    end

    local function UpdateShowChannelsBar(channelsBarParentFrameVisible) -- Luacid: Inlined by compiler; 2 call sites recovered
        channelsBarParentFrame.Visible = channelsBarParentFrameVisible
        UpdateChatChannelParentFrameSize()
    end

    UpdateChatChannelsTabTextSize(ChatSettings.ChatChannelsTabTextSize)
    UpdateChatBarTextSize(ChatSettings.ChatBarTextSize)
    UpdateDraggable(ChatSettings.WindowDraggable)
    UpdateResizable(ChatSettings.WindowResizable)
    UpdateShowChannelsBar(ChatSettings.ShowChannelsBar)

    ChatSettings.SettingsChanged:connect(function(arg1, visible)
        if arg1 == "WindowDraggable" then
            UpdateDraggable(visible)
        elseif arg1 == "WindowResizable" then
            UpdateResizable(visible)
        elseif arg1 == "ChatChannelsTabTextSize" then
            UpdateChatChannelsTabTextSize(visible)
        elseif arg1 == "ChatBarTextSize" then
            UpdateChatBarTextSize(visible)
        elseif arg1 == "ShowChannelsBar" then
            UpdateShowChannelsBar(visible)
        end
    end)

    self.GuiObject = frame

    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.ChatBarParentFrame = chatBarParentFrame
    self.GuiObjects.ChannelsBarParentFrame = channelsBarParentFrame
    self.GuiObjects.ChatChannelParentFrame = chatChannelParentFrame
    self.GuiObjects.ChatResizerFrame = imageButton
    self.GuiObjects.ResizeIcon = imageLabel
    self:AnimGuiObjects()
end

function tbl1:GetChatBar()
    return self.ChatBar
end

function tbl1:RegisterChatBar(chatBar)
    self.ChatBar = chatBar
    self.ChatBar:CreateGuiObjects(self.GuiObjects.ChatBarParentFrame)
end

function tbl1:RegisterChannelsBar(channelsBar)
    self.ChannelsBar = channelsBar
    self.ChannelsBar:CreateGuiObjects(self.GuiObjects.ChannelsBarParentFrame)
end

function tbl1:RegisterMessageLogDisplay(messageLogDisplay)
    self.MessageLogDisplay = messageLogDisplay
    self.MessageLogDisplay.GuiObject.Parent = self.GuiObjects.ChatChannelParentFrame
end

function tbl1:AddChannel(arg1)
    if self:GetChannel(arg1) then
        error("Channel '" .. arg1 .. "' already exists!")
        return
    end

    local chatChannel = ChatChannel.new(arg1, self.MessageLogDisplay)
    self.Channels[arg1:lower()] = chatChannel

    chatChannel:SetActive(false)

    local var1 = self.ChannelsBar:AddChannelTab(arg1)
    var1.NameTag.MouseButton1Click:connect(function()
        self:SwitchCurrentChannel(arg1)
    end)

    chatChannel:RegisterChannelTab(var1)

    return chatChannel
end

function tbl1:GetFirstChannel()
    for _, channel in pairs(self.Channels) do
        return channel
    end
    return nil
end

function tbl1:RemoveChannel(targetChannel)
    if not self:GetChannel(targetChannel) then
        error("Channel '" .. targetChannel .. "' does not exist!")
    end

    local var1 = targetChannel:lower()
    local bool1

    if self.Channels[var1] == self:GetCurrentChannel() then
        self:SwitchCurrentChannel(nil)
        bool1 = true
    else
        bool1 = false
    end

    self.Channels[var1]:Destroy()
    self.Channels[var1] = nil

    self.ChannelsBar:RemoveChannelTab(targetChannel)

    if bool1 then
        local bool2 = self:GetChannel(ChatSettings.GeneralChannelName) ~= nil
        local bool3 = var1 == ChatSettings.GeneralChannelName:lower()
        local var2

        if bool2 and not bool3 then
            var2 = ChatSettings.GeneralChannelName
        else
            local firstChannel = self:GetFirstChannel()
            var2 = firstChannel and firstChannel.Name or nil
        end

        self:SwitchCurrentChannel(var2)
    end

    if not ChatSettings.ShowChannelsBar and self.ChatBar.TargetChannel == targetChannel then
        self.ChatBar:SetChannelTarget(ChatSettings.GeneralChannelName)
    end
end

function tbl1:GetChannel(arg1)
    return arg1 and self.Channels[arg1:lower()] or nil
end

function tbl1:GetTargetMessageChannel()
    if not ChatSettings.ShowChannelsBar then
        return self.ChatBar.TargetChannel
    end
    local currentChannel = self:GetCurrentChannel()
    return currentChannel and currentChannel.Name
end

function tbl1:GetCurrentChannel()
    return self.CurrentChannel
end

function tbl1:SwitchCurrentChannel(arg1)
    if not ChatSettings.ShowChannelsBar then
        local channel = self:GetChannel(arg1)
        if channel then
            self.ChatBar:SetChannelTarget(channel.Name)
        end

        arg1 = ChatSettings.GeneralChannelName
    end

    local currentChannel = self:GetCurrentChannel()
    local channel = self:GetChannel(arg1)
    if channel == nil then
        error(string.format("Channel '%s' does not exist.", arg1))
    end

    if channel == currentChannel then
        return
    end

    if currentChannel then
        currentChannel:SetActive(false)
        self.ChannelsBar:GetChannelTab(currentChannel.Name):SetActive(false)
    end

    if channel then
        channel:SetActive(true)
        self.ChannelsBar:GetChannelTab(channel.Name):SetActive(true)
    end

    self.CurrentChannel = channel
end

function tbl1:UpdateFrameVisibility()
    self.GuiObject.Visible = self.Visible and self.CoreGuiEnabled
end

function tbl1:GetVisible()
    return self.Visible
end

function tbl1:SetVisible(selfVisible)
    self.Visible = selfVisible
    self:UpdateFrameVisibility()
end

function tbl1:GetCoreGuiEnabled()
    return self.CoreGuiEnabled
end

function tbl1:SetCoreGuiEnabled(coreGuiEnabled)
    self.CoreGuiEnabled = coreGuiEnabled
    self:UpdateFrameVisibility()
end

function tbl1:EnableResizable()
    self.GuiObjects.ChatResizerFrame.Active = true
end

function tbl1:DisableResizable()
    self.GuiObjects.ChatResizerFrame.Active = false
end

function tbl1:FadeOutBackground(arg1)
    self.ChannelsBar:FadeOutBackground(arg1)
    self.MessageLogDisplay:FadeOutBackground(arg1)
    self.ChatBar:FadeOutBackground(arg1)

    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeInBackground(arg1)
    self.ChannelsBar:FadeInBackground(arg1)
    self.MessageLogDisplay:FadeInBackground(arg1)
    self.ChatBar:FadeInBackground(arg1)

    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeOutText(arg1)
    self.MessageLogDisplay:FadeOutText(arg1)
    self.ChannelsBar:FadeOutText(arg1)
end

function tbl1:FadeInText(arg1)
    self.MessageLogDisplay:FadeInText(arg1)
    self.ChannelsBar:FadeInText(arg1)
end

function tbl1:AnimGuiObjects()
    self.GuiObjects.ChatChannelParentFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.ChatResizerFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.ResizeIcon.ImageTransparency = self.AnimParams.Background_CurrentTransparency
end

function tbl1:InitializeAnimParams()
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function tbl1:Update(arg1)
    self.ChatBar:Update(arg1)
    self.ChannelsBar:Update(arg1)
    self.MessageLogDisplay:Update(arg1)

    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Background_CurrentTransparency,
        self.AnimParams.Background_TargetTransparency,
        self.AnimParams.Background_NormalizedExptValue,
        arg1
    )

    self:AnimGuiObjects()
end

function module.new()
    local self = setmetatable({}, tbl1)

    self.GuiObject = nil
    self.GuiObjects = {}

    self.ChatBar = nil
    self.ChannelsBar = nil
    self.MessageLogDisplay = nil

    self.Channels = {}
    self.CurrentChannel = nil

    self.Visible = true
    self.CoreGuiEnabled = true

    self.AnimParams = {}

    self:InitializeAnimParams()

    return self
end

return module
