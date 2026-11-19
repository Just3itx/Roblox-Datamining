-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
end)
local var1 = success and result

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var2 = success2 and result2

local module = { ScrollBarThickness = 4 }

local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local scriptParent = script.Parent
local MessageLabelCreator = require(scriptParent:WaitForChild("MessageLabelCreator"))
local CurveUtil = require(scriptParent:WaitForChild("CurveUtil"))

local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local messageLabelCreator = MessageLabelCreator.new()

local tbl1 = {}
tbl1.__index = tbl1

local function CreateGuiObjects(): (Frame, ScrollingFrame, UIListLayout)
    local frame = Instance.new("Frame")
    frame.Selectable = false
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1

    local scroller = Instance.new("ScrollingFrame")
    scroller.Selectable = ChatSettings.GamepadNavigationEnabled
    scroller.Name = "Scroller"
    scroller.BackgroundTransparency = 1
    scroller.BorderSizePixel = 0
    scroller.Position = UDim2.new(0, 0, 0, 3)
    scroller.Size = UDim2.new(1, -4, 1, -6)
    scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroller.ScrollBarThickness = module.ScrollBarThickness
    scroller.Active = true
    scroller.Parent = frame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = scroller

    return frame, scroller, uiListLayout
end

function tbl1:Destroy()
    self.GuiObject:Destroy()
    self.Destroyed = true
end

function tbl1:SetActive(visible)
    self.GuiObject.Visible = visible
end

function tbl1:UpdateMessageFiltered(arg1)
    local messageObjectLog = self.MessageObjectLog
    local num1 = 1
    local var3 = nil
    local var4

    while true do
        if not (num1 <= #messageObjectLog) then
            var4 = var3
            break
        end

        var4 = messageObjectLog[num1]

        if var4.ID == arg1.ID then
            break
        end

        num1 += 1
    end

    if not var4 then
        return
    end

    if not var1 then
        var4.UpdateTextFunction(arg1)
        self:PositionMessageLabelInWindow(var4, num1)
        return
    end

    if arg1.Message == "" then
        self:RemoveMessageAtIndex(num1)
        return
    end
    var4.UpdateTextFunction(arg1)
    self:PositionMessageLabelInWindow(var4, num1)
end

function tbl1:RefreshMessagePlacement(arg1)
    local messageObjectLog = self.MessageObjectLog
    local num1 = 1
    local var3 = nil
    local var4

    while true do
        if not (num1 <= #messageObjectLog) then
            var4 = var3
            break
        end

        var4 = messageObjectLog[num1]

        if var4.ID == arg1.ID then
            break
        end

        num1 += 1
    end

    if var4 then
        self:PositionMessageLabelInWindow(var4, num1)
    end
end

function tbl1:AddMessage(arg1)
    self:WaitUntilParentedCorrectly()

    local var3 = if var2 then messageLabelCreator:CreateMessageLabel_Chat(arg1, self.CurrentChannelName, function()
        self:RefreshMessagePlacement(arg1)
    end) else messageLabelCreator:CreateMessageLabel(arg1, self.CurrentChannelName)

    if var3 == nil then
        return
    end

    table.insert(self.MessageObjectLog, var3)
    self:PositionMessageLabelInWindow(var3, #self.MessageObjectLog)
end

function tbl1:RemoveMessageAtIndex(num1: number?)
    self:WaitUntilParentedCorrectly()

    local var3 = self.MessageObjectLog[num1]

    if var3 then
        var3:Destroy()
        table.remove(self.MessageObjectLog, num1)
    end
end

function tbl1:AddMessageAtIndex(arg1, num1: number)
    local var3 = if var2 then messageLabelCreator:CreateMessageLabel_Chat(arg1, self.CurrentChannelName, function()
        self:RefreshMessagePlacement(arg1)
    end) else messageLabelCreator:CreateMessageLabel(arg1, self.CurrentChannelName)

    if var3 == nil then
        return
    end

    table.insert(self.MessageObjectLog, num1, var3)

    self:PositionMessageLabelInWindow(var3, num1)
end

function tbl1:RemoveLastMessage()
    self:WaitUntilParentedCorrectly()

    self.MessageObjectLog[1]:Destroy()
    table.remove(self.MessageObjectLog, 1)
end

function tbl1:IsScrolledDown(): boolean
    local offset = self.Scroller.CanvasSize.Y.Offset
    local absoluteWindowSizeY = self.Scroller.AbsoluteWindowSize.Y
    local canvasPositionY = self.Scroller.CanvasPosition.Y

    return offset < absoluteWindowSizeY or offset - canvasPositionY <= absoluteWindowSizeY + 5
end

function tbl1:UpdateMessageTextHeight(arg1)
    local baseFrame = arg1.BaseFrame
    for i = 1, 10 do
        if arg1.BaseMessage.TextFits then
            break
        end

        local var3 = self.Scroller.AbsoluteSize.X - i
        baseFrame.Size = UDim2.new(1, 0, 0, arg1.GetHeightFunction(var3))
    end
end

function tbl1:PositionMessageLabelInWindow(arg1, arg2)
    self:WaitUntilParentedCorrectly()

    local isScrolledDown = self:IsScrolledDown()

    local baseFrame = arg1.BaseFrame

    baseFrame.LayoutOrder = if self.MessageObjectLog[arg2 - 1] then if arg2 == #self.MessageObjectLog then self.MessageObjectLog[arg2 - 1].BaseFrame.LayoutOrder + 1 else self.MessageObjectLog[arg2 - 1].BaseFrame.LayoutOrder else 1

    baseFrame.Size = UDim2.new(1, 0, 0, arg1.GetHeightFunction(self.Scroller.AbsoluteSize.X))
    baseFrame.Parent = self.Scroller

    if arg1.BaseMessage then
        self:UpdateMessageTextHeight(arg1)
    end

    if isScrolledDown then
        local scroller = self.Scroller
        scroller.CanvasPosition = Vector2.new(0, math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y))
    end
end

function tbl1:ReorderAllMessages()
    self:WaitUntilParentedCorrectly()

    if self.GuiObject.AbsoluteSize.Y < 1 then
        return
    end
    local canvasPosition = self.Scroller.CanvasPosition
    local isScrolledDown = self:IsScrolledDown()

    for _, value in pairs(self.MessageObjectLog) do
        self:UpdateMessageTextHeight(value)
    end

    if not isScrolledDown then
        self.Scroller.CanvasPosition = canvasPosition
        return
    end
    local scroller = self.Scroller
    scroller.CanvasPosition = Vector2.new(0, math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y))
end

function tbl1:Clear()
    for _, value in pairs(self.MessageObjectLog) do
        value:Destroy()
    end
    self.MessageObjectLog = {}
end

function tbl1:SetCurrentChannelName(currentChannelName)
    self.CurrentChannelName = currentChannelName
end

function tbl1.FadeOutBackground(_, _) end

function tbl1.FadeInBackground(_, _) end

function tbl1:FadeOutText(arg1)
    for i = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[i].FadeOutFunction then
            self.MessageObjectLog[i].FadeOutFunction(arg1, CurveUtil)
        end
    end
end

function tbl1:FadeInText(arg1)
    for i = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[i].FadeInFunction then
            self.MessageObjectLog[i].FadeInFunction(arg1, CurveUtil)
        end
    end
end

function tbl1:Update(arg1)
    for i = 1, #self.MessageObjectLog do
        if self.MessageObjectLog[i].UpdateAnimFunction then
            self.MessageObjectLog[i].UpdateAnimFunction(arg1, CurveUtil)
        end
    end
end

function tbl1:WaitUntilParentedCorrectly()
    while not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer) do
        self.GuiObject.AncestryChanged:wait()
    end
end

function module.new()
    local self = setmetatable({}, tbl1)
    self.Destroyed = false

    local frame, scrollingFrame, uiListLayout = CreateGuiObjects()
    self.GuiObject = frame
    self.Scroller = scrollingFrame
    self.Layout = uiListLayout

    self.MessageObjectLog = {}

    self.Name = "MessageLogDisplay"
    self.GuiObject.Name = "Frame_" .. self.Name

    self.CurrentChannelName = ""

    self.GuiObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        spawn(function()
            self:ReorderAllMessages()
        end)
    end)
    local isScrolledDown = true

    self.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local absoluteContentSize = self.Layout.AbsoluteContentSize
        self.Scroller.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSize.Y)
        if isScrolledDown then
            local absoluteWindowSize = self.Scroller.AbsoluteWindowSize
            self.Scroller.CanvasPosition = Vector2.new(0, absoluteContentSize.Y - absoluteWindowSize.Y)
        end
    end)

    self.Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        isScrolledDown = self:IsScrolledDown()
    end)

    return self
end

return module
