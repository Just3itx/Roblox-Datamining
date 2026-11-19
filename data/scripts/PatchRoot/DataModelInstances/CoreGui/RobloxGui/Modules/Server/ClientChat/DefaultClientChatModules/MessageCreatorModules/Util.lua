-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = false
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFixOverlappingRtlChatMessages2")
end)
if success then
    bool1 = result
end

local TextService = game:GetService("TextService")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))

local tbl1 = {}
local tbl2 = {}
tbl2.__index = tbl2

function tbl2.GetStringTextBounds(_, string: string, font: Enum.Font, fontSize: number, frameSize): Vector2
    frameSize = frameSize or Vector2.new(10000, 10000)
    return TextService:GetTextSize(string, fontSize, font, frameSize)
end

function tbl2.GetMessageHeight(arg1, arg2, arg3, x)
    x = x or arg3.AbsoluteSize.X
    local var1 = if bool1 then arg2.ContentText else arg2.Text
    local stringTextBounds = arg1:GetStringTextBounds(var1, arg2.Font, arg2.TextSize, Vector2.new(x, 1000))
    return if stringTextBounds.Y == math.floor(stringTextBounds.Y) then stringTextBounds.Y else stringTextBounds.Y + 1
end

function tbl2.GetNumberOfSpaces(arg1, arg2, arg3, arg4): number
    local stringTextBounds = arg1:GetStringTextBounds(arg2, arg3, arg4)
    local stringTextBounds2 = arg1:GetStringTextBounds(" ", arg3, arg4)
    return math.ceil(stringTextBounds.X / stringTextBounds2.X)
end

function tbl2.CreateLeadingSpaces(_, arg1): string
    if bool1 then
        return "<font dir=\"ltr\">" .. string.rep(" ", arg1) .. "</font>"
    end
    return string.rep(" ", arg1)
end

function tbl2.SanitizeForRichText(_, arg1)
    if not bool1 then
        return arg1
    end

    return string.gsub(arg1, "%p", { ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;" })
end

function tbl2.CreateBaseMessage(arg1, fromObjectPool2Text, font, textSize, textColor3)
    local fromObjectPool = arg1:GetFromObjectPool("Frame")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(1, 0, 0, 18)
    fromObjectPool.Visible = true
    fromObjectPool.BackgroundTransparency = 1

    local fromObjectPool2 = arg1:GetFromObjectPool("TextLabel")
    fromObjectPool2.Selectable = false
    fromObjectPool2.Size = UDim2.new(1, -14, 1, 0)
    fromObjectPool2.Position = UDim2.new(0, 8, 0, 0)
    fromObjectPool2.BackgroundTransparency = 1
    fromObjectPool2.Font = font
    fromObjectPool2.TextSize = textSize
    fromObjectPool2.TextXAlignment = Enum.TextXAlignment.Left
    fromObjectPool2.TextYAlignment = Enum.TextYAlignment.Top
    fromObjectPool2.TextTransparency = 0
    fromObjectPool2.TextStrokeTransparency = 0.75
    fromObjectPool2.TextColor3 = textColor3
    fromObjectPool2.TextWrapped = true
    fromObjectPool2.ClipsDescendants = true
    fromObjectPool2.Text = fromObjectPool2Text
    fromObjectPool2.Visible = true
    fromObjectPool2.RichText = not not bool1
    fromObjectPool2.Parent = fromObjectPool

    return fromObjectPool, fromObjectPool2
end

function tbl2.AddNameButtonToBaseMessage(arg1, arg2, textColor3, fromObjectPoolText, arg3)
    local stringTextBounds = arg1:GetStringTextBounds(fromObjectPoolText, arg2.Font, arg2.TextSize)
    local fromObjectPool = arg1:GetFromObjectPool("TextButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = arg2.Font
    fromObjectPool.TextSize = arg2.TextSize
    fromObjectPool.TextXAlignment = arg2.TextXAlignment
    fromObjectPool.TextYAlignment = arg2.TextYAlignment
    fromObjectPool.TextTransparency = arg2.TextTransparency
    fromObjectPool.TextStrokeTransparency = arg2.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = fromObjectPoolText
    fromObjectPool.Visible = true
    fromObjectPool.Parent = arg2

    local connection = fromObjectPool.MouseButton1Click:connect(function()
        arg1:NameButtonClicked(fromObjectPool, arg3)
    end)

    local connection2 = nil
    connection2 = fromObjectPool.Changed:connect(function(arg4)
        if arg4 == "Parent" then
            connection:Disconnect()
            connection2:Disconnect()
        end
    end)

    return fromObjectPool
end

function tbl2.AddTranslationButtonToBaseMessage(arg1, arg2)
    local num1 = math.floor(arg2.TextSize * 0.9)
    local vector2 = Vector2.new(num1, num1)
    local fromObjectPool = arg1:GetFromObjectPool("ImageButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, vector2.X, 0, vector2.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Visible = false
    fromObjectPool.Parent = arg2
    fromObjectPool.Image = "rbxasset://textures/translateIcon.png"
    fromObjectPool.HoverImage = "rbxasset://textures/translateIconDark.png"
    fromObjectPool.PressedImage = "rbxasset://textures/translateIconDark.png"

    return fromObjectPool
end

function tbl2.AddChannelButtonToBaseMessage(arg1, arg2, textColor3, fromObjectPoolText, arg3)
    local stringTextBounds = arg1:GetStringTextBounds(fromObjectPoolText, arg2.Font, arg2.TextSize)
    local fromObjectPool = arg1:GetFromObjectPool("TextButton")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = arg2.Font
    fromObjectPool.TextSize = arg2.TextSize
    fromObjectPool.TextXAlignment = arg2.TextXAlignment
    fromObjectPool.TextYAlignment = arg2.TextYAlignment
    fromObjectPool.TextTransparency = arg2.TextTransparency
    fromObjectPool.TextStrokeTransparency = arg2.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = fromObjectPoolText
    fromObjectPool.Visible = true
    fromObjectPool.Parent = arg2

    local connection = fromObjectPool.MouseButton1Click:connect(function()
        arg1:ChannelButtonClicked(fromObjectPool, arg3)
    end)

    local connection2 = nil
    connection2 = fromObjectPool.Changed:connect(function(arg4)
        if arg4 == "Parent" then
            connection:Disconnect()
            connection2:Disconnect()
        end
    end)

    return fromObjectPool
end

function tbl2.AddTagLabelToBaseMessage(arg1, arg2, textColor3, fromObjectPoolText)
    local stringTextBounds = arg1:GetStringTextBounds(fromObjectPoolText, arg2.Font, arg2.TextSize)
    local fromObjectPool = arg1:GetFromObjectPool("TextLabel")
    fromObjectPool.Selectable = false
    fromObjectPool.Size = UDim2.new(0, stringTextBounds.X, 0, stringTextBounds.Y)
    fromObjectPool.Position = UDim2.new(0, 0, 0, 0)
    fromObjectPool.BackgroundTransparency = 1
    fromObjectPool.Font = arg2.Font
    fromObjectPool.TextSize = arg2.TextSize
    fromObjectPool.TextXAlignment = arg2.TextXAlignment
    fromObjectPool.TextYAlignment = arg2.TextYAlignment
    fromObjectPool.TextTransparency = arg2.TextTransparency
    fromObjectPool.TextStrokeTransparency = arg2.TextStrokeTransparency
    fromObjectPool.TextColor3 = textColor3
    fromObjectPool.Text = fromObjectPoolText
    fromObjectPool.Visible = true
    fromObjectPool.Parent = arg2

    return fromObjectPool
end

function GetWhisperChannelPrefix()
    return if ChatConstants.WhisperChannelPrefix then ChatConstants.WhisperChannelPrefix else "To "
end

function tbl2:NameButtonClicked(_, name)
    if not self.ChatWindow then
        return
    end

    if not ChatSettings.ClickOnPlayerNameToWhisper then
        return
    end

    local var1 = Players:FindFirstChild(name)
    if not var1 or var1 == LocalPlayer then
        return
    end

    local var2 = GetWhisperChannelPrefix() .. name
    if self.ChatWindow:GetChannel(var2) then
        self.ChatBar:ResetCustomState()
        if self.ChatWindow:GetTargetMessageChannel() ~= var2 then
            self.ChatWindow:SwitchCurrentChannel(var2)
        end

        local var3 = "/w " .. name
        self.ChatBar:SetText(var3)

        self.ChatBar:CaptureFocus()
        return
    end

    if not self.ChatBar:IsInCustomState() then
        local var3 = "/w " .. name
        self.ChatBar:SetText(var3)

        self.ChatBar:CaptureFocus()
    end
end

function tbl2:ChannelButtonClicked(_, arg1)
    if not self.ChatWindow then
        return
    end

    if not ChatSettings.ClickOnChannelNameToSetMainChannel or not self.ChatWindow:GetChannel(arg1) then
        return
    end

    self.ChatBar:ResetCustomState()
    if self.ChatWindow:GetTargetMessageChannel() ~= arg1 then
        self.ChatWindow:SwitchCurrentChannel(arg1)
    end
    self.ChatBar:ResetText()
    self.ChatBar:CaptureFocus()
end

function tbl2:RegisterChatWindow(chatWindow)
    self.ChatWindow = chatWindow
    self.ChatBar = chatWindow:GetChatBar()
end

function tbl2:GetFromObjectPool(className: string)
    if self.ObjectPool == nil then
        return Instance.new(className)
    end
    return self.ObjectPool:GetInstance(className)
end

function tbl2:RegisterObjectPool(objectPool)
    self.ObjectPool = objectPool
end

function tbl2.CreateFadeFunctions(_, arg1)
    local tbl3 = ({})
    for k, value in pairs(arg1) do
        tbl3[k] = {}
        for k2, value2 in pairs(value) do
            local var1 = tbl3[k]
            local tbl4 = {
                Target = value2.FadedIn,
                Current = k[k2],
                NormalizedExptValue = 1
            }
            var1[k2] = tbl4
        end
    end

    local function FadeInFunction(arg2, arg3)
        for k, value in pairs(tbl3) do
            for k2, value2 in pairs(value) do
                value2.Target = arg1[k][k2].FadedIn
                value2.NormalizedExptValue = arg3:NormalizedDefaultExptValueInSeconds(arg2)
            end
        end
    end

    local function FadeOutFunction(arg2, arg3)
        for k, value in pairs(tbl3) do
            for k2, value2 in pairs(value) do
                value2.Target = arg1[k][k2].FadedOut
                value2.NormalizedExptValue = arg3:NormalizedDefaultExptValueInSeconds(arg2)
            end
        end
    end

    local function AnimGuiObjects()
        for k, value in pairs(tbl3) do
            for k2, value2 in pairs(value) do
                k[k2] = value2.Current
            end
        end
    end

    local function UpdateAnimFunction(arg2, arg3)
        for _, value in pairs(tbl3) do
            for _, value2 in pairs(value) do
                value2.Current = arg3:Expt(value2.Current, value2.Target, value2.NormalizedExptValue, arg2)
            end
        end

        AnimGuiObjects()
    end

    return FadeInFunction, FadeOutFunction, UpdateAnimFunction
end

function tbl2.NewBindableEvent(_, bindableEventName): BindableEvent
    local bindableEvent = Instance.new("BindableEvent")
    bindableEvent.Name = bindableEventName
    return bindableEvent
end

function tbl2.RegisterGuiRoot(_) end

function tbl1.new()
    local self = setmetatable({}, tbl2)

    self.ObjectPool = nil
    self.ChatWindow = nil

    self.DEFAULT_MESSAGE_CREATOR = "UnknownMessage"
    self.MESSAGE_CREATOR_MODULES_VERSION = 1

    self.KEY_MESSAGE_TYPE = "MessageType"
    self.KEY_CREATOR_FUNCTION = "MessageCreatorFunc"

    self.KEY_BASE_FRAME = "BaseFrame"
    self.KEY_BASE_MESSAGE = "BaseMessage"
    self.KEY_UPDATE_TEXT_FUNC = "UpdateTextFunction"
    self.KEY_GET_HEIGHT = "GetHeightFunction"
    self.KEY_FADE_IN = "FadeInFunction"
    self.KEY_FADE_OUT = "FadeOutFunction"
    self.KEY_UPDATE_ANIMATION = "UpdateAnimFunction"

    return self
end

return tbl1.new()
