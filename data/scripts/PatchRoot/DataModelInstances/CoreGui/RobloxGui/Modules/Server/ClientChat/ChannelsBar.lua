-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local scriptParent = script.Parent
local ChannelsTab = require(scriptParent:WaitForChild("ChannelsTab"))
local MessageSender = require(scriptParent:WaitForChild("MessageSender"))
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local CurveUtil = require(scriptParent:WaitForChild("CurveUtil"))

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:CreateGuiObjects(parent)
    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local scrollingBase = Instance.new("Frame")
    scrollingBase.Selectable = false
    scrollingBase.Name = "ScrollingBase"
    scrollingBase.BackgroundTransparency = 1
    scrollingBase.ClipsDescendants = true
    scrollingBase.Size = UDim2.new(1, 0, 1, 0)
    scrollingBase.Position = UDim2.new(0, 0, 0, 0)
    scrollingBase.Parent = frame

    local scrollerSizer = Instance.new("Frame")
    scrollerSizer.Selectable = false
    scrollerSizer.Name = "ScrollerSizer"
    scrollerSizer.BackgroundTransparency = 1
    scrollerSizer.Size = UDim2.new(1, 0, 1, 0)
    scrollerSizer.Position = UDim2.new(0, 0, 0, 0)
    scrollerSizer.Parent = scrollingBase

    local scrollerFrame = Instance.new("Frame")
    scrollerFrame.Selectable = false
    scrollerFrame.Name = "ScrollerFrame"
    scrollerFrame.BackgroundTransparency = 1
    scrollerFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollerFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollerFrame.Parent = scrollerSizer

    local frame2 = Instance.new("Frame")
    frame2.Selectable = false
    frame2.Size = UDim2.new(1, 0, 1, 0)
    frame2.Position = UDim2.new(0, 0, 0, 0)
    frame2.ClipsDescendants = true
    frame2.BackgroundTransparency = 1
    frame2.Parent = frame

    local leaveConfirmationFrame = Instance.new("Frame")
    leaveConfirmationFrame.Selectable = false
    leaveConfirmationFrame.Name = "LeaveConfirmationFrame"
    leaveConfirmationFrame.Size = UDim2.new(1, 0, 1, 0)
    leaveConfirmationFrame.Position = UDim2.new(0, 0, 1, 0)
    leaveConfirmationFrame.BackgroundTransparency = 0.6
    leaveConfirmationFrame.BorderSizePixel = 0
    leaveConfirmationFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    leaveConfirmationFrame.Parent = frame2

    local textButton = Instance.new("TextButton")
    textButton.Selectable = false
    textButton.Size = UDim2.new(1, 0, 1, 0)
    textButton.BackgroundTransparency = 1
    textButton.Text = ""
    textButton.Parent = leaveConfirmationFrame

    local textButton2 = Instance.new("TextButton")
    textButton2.Selectable = false
    textButton2.Size = UDim2.new(0.25, 0, 1, 0)
    textButton2.BackgroundTransparency = 1
    textButton2.Font = ChatSettings.DefaultFont
    textButton2.TextSize = 18
    textButton2.TextStrokeTransparency = 0.75
    textButton2.Position = UDim2.new(0, 0, 0, 0)
    textButton2.TextColor3 = Color3.new(0, 1, 0)
    textButton2.Text = "Confirm"
    textButton2.Parent = leaveConfirmationFrame

    local textButton3 = textButton2:Clone()
    textButton3.Parent = leaveConfirmationFrame
    textButton3.Position = UDim2.new(0.75, 0, 0, 0)
    textButton3.TextColor3 = Color3.new(1, 0, 0)
    textButton3.Text = "Cancel"

    local textLabel = Instance.new("TextLabel")
    textLabel.Selectable = false
    textLabel.Size = UDim2.new(0.5, 0, 1, 0)
    textLabel.Position = UDim2.new(0.25, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0.75
    textLabel.Text = "Leave channel <XX>?"
    textLabel.Font = ChatSettings.DefaultFont
    textLabel.TextSize = 18
    textLabel.Parent = leaveConfirmationFrame

    local leaveTarget = Instance.new("StringValue")
    leaveTarget.Name = "LeaveTarget"
    leaveTarget.Parent = leaveConfirmationFrame

    local leaveConfirmationFramePosition = leaveConfirmationFrame.Position
    textButton2.MouseButton1Click:connect(function()
        MessageSender:SendMessage(string.format("/leave %s", leaveTarget.Value), nil)
        leaveConfirmationFrame:TweenPosition(
            leaveConfirmationFramePosition,
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)

    textButton3.MouseButton1Click:connect(function()
        leaveConfirmationFrame:TweenPosition(
            leaveConfirmationFramePosition,
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)

    local pageLeftButton = Instance.new("ImageButton", frame)
    pageLeftButton.Selectable = ChatSettings.GamepadNavigationEnabled
    pageLeftButton.Name = "PageLeftButton"
    pageLeftButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    pageLeftButton.Size = UDim2.new(0.7, 0, 0.7, 0)
    pageLeftButton.BackgroundTransparency = 1
    pageLeftButton.Position = UDim2.new(0, 4, 0.15000000000000002, 0)
    pageLeftButton.Visible = false
    pageLeftButton.Image = "rbxassetid://471630199"
    local arrowLabel = Instance.new("ImageLabel", pageLeftButton)
    arrowLabel.Name = "ArrowLabel"
    arrowLabel.BackgroundTransparency = 1
    arrowLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    arrowLabel.Image = "rbxassetid://471630112"

    local positionalHelper = Instance.new("Frame", frame)
    positionalHelper.Selectable = false
    positionalHelper.BackgroundTransparency = 1
    positionalHelper.Name = "PositionalHelper"
    positionalHelper.Size = pageLeftButton.Size
    positionalHelper.SizeConstraint = pageLeftButton.SizeConstraint
    positionalHelper.Position = UDim2.new(1, 0, 0.15000000000000002, 0)

    local imageButton = pageLeftButton:Clone()
    imageButton.Parent = positionalHelper
    imageButton.Name = "PageRightButton"
    imageButton.Size = UDim2.new(1, 0, 1, 0)
    imageButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
    imageButton.Position = UDim2.new(-1, -4, 0, 0)

    local uDim2 = UDim2.new(0.05, 0, 0, 0)

    imageButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) + uDim2
    pageLeftButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) - uDim2
    pageLeftButton.ArrowLabel.Rotation = 180

    self.GuiObject = frame

    self.GuiObjects.BaseFrame = frame
    self.GuiObjects.ScrollerSizer = scrollerSizer
    self.GuiObjects.ScrollerFrame = scrollerFrame
    self.GuiObjects.PageLeftButton = pageLeftButton
    self.GuiObjects.PageRightButton = imageButton
    self.GuiObjects.LeaveConfirmationFrame = leaveConfirmationFrame
    self.GuiObjects.LeaveConfirmationNotice = textLabel

    self.GuiObjects.PageLeftButtonArrow = pageLeftButton.ArrowLabel
    self.GuiObjects.PageRightButtonArrow = imageButton.ArrowLabel
    self:AnimGuiObjects()

    pageLeftButton.MouseButton1Click:connect(function()
        self:ScrollChannelsFrame(-1)
    end)

    imageButton.MouseButton1Click:connect(function()
        self:ScrollChannelsFrame(1)
    end)
    self:ScrollChannelsFrame(0)
end

function tbl1.UpdateMessagePostedInChannel(arg1, arg2)
    local channelTab = arg1:GetChannelTab(arg2)
    if channelTab then
        channelTab:UpdateMessagePostedInChannel()
        return
    end
    warn("ChannelsTab '" .. arg2 .. "' does not exist!")
end

function tbl1:AddChannelTab(arg1)
    if self:GetChannelTab(arg1) then
        error("Channel tab '" .. arg1 .. "'already exists!")
    end

    local channelsTab = ChannelsTab.new(arg1)
    channelsTab.GuiObject.Parent = self.GuiObjects.ScrollerFrame
    self.ChannelTabs[arg1:lower()] = channelsTab

    self.NumTabs += 1
    self:OrganizeChannelTabs()

    if ChatSettings.RightClickToLeaveChannelEnabled then
        channelsTab.NameTag.MouseButton2Click:connect(function()
            self.LeaveConfirmationNotice.Text = string.format("Leave channel %s?", channelsTab.ChannelName)
            self.LeaveConfirmationFrame.LeaveTarget.Value = channelsTab.ChannelName
            self.LeaveConfirmationFrame:TweenPosition(
                UDim2.new(0, 0, 0, 0),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Quad,
                0.2,
                true
            )
        end)
    end
    return channelsTab
end

function tbl1:RemoveChannelTab(arg1)
    if not self:GetChannelTab(arg1) then
        error("Channel tab '" .. arg1 .. "'does not exist!")
    end

    local var1 = arg1:lower()
    self.ChannelTabs[var1]:Destroy()
    self.ChannelTabs[var1] = nil

    self.NumTabs -= 1
    self:OrganizeChannelTabs()
end

function tbl1:GetChannelTab(arg1)
    return self.ChannelTabs[arg1:lower()]
end

function tbl1:OrganizeChannelTabs()
    local tbl2 = {}

    local generalChannelName = ChatSettings.GeneralChannelName
    table.insert(tbl2, self:GetChannelTab(generalChannelName))
    table.insert(tbl2, self:GetChannelTab("System"))

    for _, channelTab in pairs(self.ChannelTabs) do
        if channelTab.ChannelName ~= ChatSettings.GeneralChannelName and channelTab.ChannelName ~= "System" then
            table.insert(tbl2, channelTab)
        end
    end

    for k, value in pairs(tbl2) do
        value.GuiObject.Position = UDim2.new(k - 1, 0, 0, 0)
    end

    local scrollerSizer = self.GuiObjects.ScrollerSizer
    scrollerSizer.Size = UDim2.new(1 / math.max(1, math.min(ChatSettings.ChannelsBarFullTabSize, self.NumTabs)), 0, 1, 0)

    self:ScrollChannelsFrame(0)
end

function tbl1:ResizeChannelTabText(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:SetTextSize(arg1)
    end
end

function tbl1:ScrollChannelsFrame(arg1)
    if self.ScrollChannelsFrameLock then
        return
    end

    self.ScrollChannelsFrameLock = true

    local channelsBarFullTabSize = ChatSettings.ChannelsBarFullTabSize

    local var1 = self.CurPageNum + arg1
    if var1 < 0 then
        var1 = 0
    elseif var1 > 0 and var1 + channelsBarFullTabSize > self.NumTabs then
        var1 = self.NumTabs - channelsBarFullTabSize
    end

    self.CurPageNum = var1

    local uDim2 = UDim2.new(-self.CurPageNum, 0, 0, 0)

    self.GuiObjects.PageLeftButton.Visible = self.CurPageNum > 0
    self.GuiObjects.PageRightButton.Visible = self.CurPageNum + channelsBarFullTabSize < self.NumTabs

    if arg1 == 0 then
        self.ScrollChannelsFrameLock = false
        return
    end

    self:WaitUntilParentedCorrectly()

    self.GuiObjects.ScrollerFrame:TweenPosition(
        uDim2,
        Enum.EasingDirection.InOut,
        Enum.EasingStyle.Quad,
        0.15,
        true,
        function() -- name: UnlockFunc
            self.ScrollChannelsFrameLock = false
        end
    )
end

function tbl1:FadeOutBackground(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeOutBackground(arg1)
    end

    self.AnimParams.Background_TargetTransparency = 1
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeInBackground(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeInBackground(arg1)
    end

    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(arg1)
end

function tbl1:FadeOutText(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeOutText(arg1)
    end
end

function tbl1:FadeInText(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:FadeInText(arg1)
    end
end

function tbl1:AnimGuiObjects()
    self.GuiObjects.PageLeftButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageRightButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageLeftButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
    self.GuiObjects.PageRightButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
end

function tbl1:InitializeAnimParams()
    self.AnimParams.Background_TargetTransparency = 0.6
    self.AnimParams.Background_CurrentTransparency = 0.6
    self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
end

function tbl1:Update(arg1)
    for _, channelTab in pairs(self.ChannelTabs) do
        channelTab:Update(arg1)
    end

    self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
        self.AnimParams.Background_CurrentTransparency,
        self.AnimParams.Background_TargetTransparency,
        self.AnimParams.Background_NormalizedExptValue,
        arg1
    )

    self:AnimGuiObjects()
end

function tbl1:WaitUntilParentedCorrectly()
    while not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer) do
        self.GuiObject.AncestryChanged:wait()
    end
end

function module.new()
    local self = setmetatable({}, tbl1)

    self.GuiObject = nil
    self.GuiObjects = {}

    self.ChannelTabs = {}
    self.NumTabs = 0
    self.CurPageNum = 0

    self.ScrollChannelsFrameLock = false

    self.AnimParams = {}

    self:InitializeAnimParams()

    ChatSettings.SettingsChanged:connect(function(arg1, arg2)
        if arg1 == "ChatChannelsTabTextSize" then
            self:ResizeChannelTabText(arg2)
        end
    end)

    return self
end

return module
