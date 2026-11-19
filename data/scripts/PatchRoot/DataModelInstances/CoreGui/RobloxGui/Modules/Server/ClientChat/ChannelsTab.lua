-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local scriptParent = script.Parent
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(scriptParent:WaitForChild("CurveUtil"))

local tbl1 = {}
tbl1.__index = tbl1

local function CreateGuiObjects(): (Frame, TextButton, TextButton?, TextButton?, ImageLabel, Frame, Frame)
    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1

    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Selectable = false
    backgroundFrame.Name = "BackgroundFrame"
    backgroundFrame.Size = UDim2.new(1, -2, 1, -2)
    backgroundFrame.Position = UDim2.new(0, 1, 0, 1)
    backgroundFrame.BackgroundTransparency = 1
    backgroundFrame.Parent = frame

    local unselectedFrame = Instance.new("Frame")
    unselectedFrame.Selectable = false
    unselectedFrame.Name = "UnselectedFrame"
    unselectedFrame.Size = UDim2.new(1, 0, 1, 0)
    unselectedFrame.Position = UDim2.new(0, 0, 0, 0)
    unselectedFrame.BorderSizePixel = 0
    unselectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabUnselectedColor
    unselectedFrame.BackgroundTransparency = 0.6
    unselectedFrame.Parent = backgroundFrame

    local selectedFrame = Instance.new("Frame")
    selectedFrame.Selectable = false
    selectedFrame.Name = "SelectedFrame"
    selectedFrame.Size = UDim2.new(1, 0, 1, 0)
    selectedFrame.Position = UDim2.new(0, 0, 0, 0)
    selectedFrame.BorderSizePixel = 0
    selectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabSelectedColor
    selectedFrame.BackgroundTransparency = 1
    selectedFrame.Parent = backgroundFrame

    local backgroundImage = Instance.new("ImageLabel")
    backgroundImage.Selectable = false
    backgroundImage.Name = "BackgroundImage"
    backgroundImage.BackgroundTransparency = 1
    backgroundImage.BorderSizePixel = 0
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.Position = UDim2.new(0, 0, 0, 0)
    backgroundImage.ScaleType = Enum.ScaleType.Slice
    backgroundImage.Parent = selectedFrame

    backgroundImage.BackgroundTransparency = -0.4

    backgroundImage.BackgroundColor3 = Color3.fromRGB(93.6, 100.8, 115.19999999999999)

    local blueBarLeft = Instance.new("ImageLabel")
    blueBarLeft.Selectable = false
    blueBarLeft.Size = UDim2.new(0.5, -2, 0, 4)
    blueBarLeft.BackgroundTransparency = 1
    blueBarLeft.ScaleType = Enum.ScaleType.Slice
    blueBarLeft.SliceCenter = Rect.new(3, 3, 32, 21)
    blueBarLeft.Parent = selectedFrame

    local imageLabel = blueBarLeft:Clone()
    imageLabel.Parent = selectedFrame

    blueBarLeft.Position = UDim2.new(0, 2, 1, -4)
    imageLabel.Position = UDim2.new(0.5, 0, 1, -4)
    blueBarLeft.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
    imageLabel.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"

    blueBarLeft.Name = "BlueBarLeft"
    imageLabel.Name = "BlueBarRight"

    local textButton = Instance.new("TextButton")
    textButton.Selectable = ChatSettings.GamepadNavigationEnabled
    textButton.Size = UDim2.new(1, 0, 1, 0)
    textButton.Position = UDim2.new(0, 0, 0, 0)
    textButton.BackgroundTransparency = 1
    textButton.Font = ChatSettings.DefaultFont
    textButton.TextSize = ChatSettings.ChatChannelsTabTextSize
    textButton.TextColor3 = Color3.new(1, 1, 1)
    textButton.TextStrokeTransparency = 0.75
    textButton.Parent = backgroundFrame

    local textButton2 = textButton:Clone()
    local textButton3 = textButton:Clone()
    textButton2.Parent = unselectedFrame
    textButton3.Parent = selectedFrame
    textButton2.Font = Enum.Font.SourceSans
    textButton2.Active = false
    textButton3.Active = false

    local frame2 = Instance.new("Frame")
    frame2.Selectable = false
    frame2.Size = UDim2.new(0, 18, 0, 18)
    frame2.Position = UDim2.new(0.8, -9, 0.5, -9)
    frame2.BackgroundTransparency = 1
    frame2.Parent = backgroundFrame

    local imageLabel2 = Instance.new("ImageLabel")
    imageLabel2.Selectable = false
    imageLabel2.Size = UDim2.new(1, 0, 1, 0)
    imageLabel2.BackgroundTransparency = 1
    imageLabel2.Image = "rbxasset://textures/ui/Chat/MessageCounter.png"
    imageLabel2.Visible = false
    imageLabel2.Parent = frame2

    local textLabel = Instance.new("TextLabel")
    textLabel.Selectable = false
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0, 13, 0, 9)
    textLabel.Position = UDim2.new(0.5, -7, 0.5, -7)
    textLabel.Font = ChatSettings.DefaultFont
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = ""
    textLabel.Parent = imageLabel2

    return frame, textButton, textButton2, textButton3, imageLabel2, unselectedFrame, selectedFrame
end

function tbl1:Destroy()
    self.GuiObject:Destroy()
end

function tbl1:UpdateMessagePostedInChannel(arg1)
    if self.Active and arg1 ~= true then
        return
    end
    local unreadMessageCount = self.UnreadMessageCount + 1
    self.UnreadMessageCount = unreadMessageCount

    local newMessageIcon = self.NewMessageIcon
    newMessageIcon.Visible = true
    newMessageIcon.TextLabel.Text = unreadMessageCount < 100 and tostring(unreadMessageCount) or "!"

    local uDim2 = UDim2.new(0, 0, -0.1, 0)

    local _ = newMessageIcon.Position + uDim2
    local out = Enum.EasingDirection.Out
    local quad = Enum.EasingStyle.Quad

    newMessageIcon.Position = UDim2.new(0, 0, -0.15, 0)
    newMessageIcon:TweenPosition(UDim2.new(0, 0, 0, 0), out, quad, 0.15, true)
end

function tbl1:SetActive(active)
    self.Active = active
    self.UnselectedFrame.Visible = not active
    self.SelectedFrame.Visible = active

    if active then
        self.UnreadMessageCount = 0
        self.NewMessageIcon.Visible = false

        self.NameTag.Font = Enum.Font.SourceSansBold
        return
    end
    self.NameTag.Font = Enum.Font.SourceSans
end

function tbl1:SetTextSize(textSize)
    self.NameTag.TextSize = textSize
end

function tbl1:FadeOutBackground(arg1)
    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeInBackground(arg1)
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeOutText(arg1)
    self.AnimParams.Text_TargetTransparency = 1
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
    self.AnimParams.TextStroke_TargetTransparency = 1
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeInText(arg1)
    self.AnimParams.Text_TargetTransparency = 0
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
    self.AnimParams.TextStroke_TargetTransparency = 0.75
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:AnimGuiObjects()
    self.UnselectedFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BackgroundImage.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BlueBarLeft.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.SelectedFrame.BlueBarRight.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.NameTagNonSelect.TextTransparency = self.AnimParams.Background_CurrentTransparency
    self.NameTagNonSelect.TextStrokeTransparency = self.AnimParams.Background_CurrentTransparency

    self.NameTag.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.NewMessageIcon.ImageTransparency = self.AnimParams.Text_CurrentTransparency
    self.WhiteTextNewMessageNotification.TextTransparency = self.AnimParams.Text_CurrentTransparency
    self.NameTagSelect.TextTransparency = self.AnimParams.Text_CurrentTransparency

    self.NameTag.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
    self.WhiteTextNewMessageNotification.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
    self.NameTagSelect.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
end

function tbl1:InitializeAnimParams()
    self.AnimParams.Text_TargetTransparency = 0
    self.AnimParams.Text_CurrentTransparency = 0
    self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)

    self.AnimParams.TextStroke_TargetTransparency = 0.75
    self.AnimParams.TextStroke_CurrentTransparency = 0.75
    self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)

    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function tbl1:Update(arg1)
    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Background_CurrentTransparency,
        self.AnimParams.Background_TargetTransparency,
        self.AnimParams.Background_NormalizedExptValue,
        arg1
    )

    self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Text_CurrentTransparency,
        self.AnimParams.Text_TargetTransparency,
        self.AnimParams.Text_NormalizedExptValue,
        arg1
    )

    self.AnimParams.TextStroke_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.TextStroke_CurrentTransparency,
        self.AnimParams.TextStroke_TargetTransparency,
        self.AnimParams.TextStroke_NormalizedExptValue,
        arg1
    )

    self:AnimGuiObjects()
end

function module.new(channelName)
    local self = setmetatable({}, tbl1)

    local frame, textButton, textButton2, textButton3, imageLabel, frame2, frame3 = CreateGuiObjects()
    self.GuiObject = frame
    self.NameTag = textButton
    self.NameTagNonSelect = textButton2
    self.NameTagSelect = textButton3
    self.NewMessageIcon = imageLabel
    self.UnselectedFrame = frame2
    self.SelectedFrame = frame3

    self.BlueBarLeft = frame3.BlueBarLeft
    self.BlueBarRight = frame3.BlueBarRight
    self.BackgroundImage = frame3.BackgroundImage
    self.WhiteTextNewMessageNotification = self.NewMessageIcon.TextLabel

    self.ChannelName = channelName
    self.UnreadMessageCount = 0
    self.Active = false

    self.GuiObject.Name = "Frame_" .. self.ChannelName

    if string.len(channelName) > ChatSettings.MaxChannelNameLength then
        channelName = string.sub(channelName, 1, ChatSettings.MaxChannelNameLength - 3) .. "..."
    end

    self.NameTag.Text = ""
    self.NameTagNonSelect.Text = channelName
    self.NameTagSelect.Text = channelName

    self.AnimParams = {}

    self:InitializeAnimParams()
    self:AnimGuiObjects()
    self:SetActive(false)

    return self
end

return module
