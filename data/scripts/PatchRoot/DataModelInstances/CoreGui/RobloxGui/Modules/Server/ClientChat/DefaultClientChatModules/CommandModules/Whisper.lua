-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Util = require(script.Parent:WaitForChild("Util"))
local ChatSettings = require(script.Parent.Parent:WaitForChild("ChatSettings"))

local Players = game:GetService("Players")

local ChatLocalization = nil

pcall(function()
    ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)
local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local tbl1 = {}
tbl1.__index = tbl1

local tbl2 = {}

function tbl1:TrimWhisperCommand(arg1)
    if string.sub(arg1, 1, 3):lower() == "/w " then
        return string.sub(arg1, 4)
    elseif string.sub(arg1, 1, 9):lower() == "/whisper " then
        return string.sub(arg1, 10)
    end
    return nil
end

function tbl1:TrimWhiteSpace(arg1)
    return string.gsub(arg1, "%s+", ""), arg1[#arg1] == " "
end

function tbl1:ShouldAutoCompleteNames()
    return ChatSettings.WhisperCommandAutoCompletePlayerNames == nil or ChatSettings.WhisperCommandAutoCompletePlayerNames
end

function tbl1:GetWhisperingPlayer(arg1)
    local var1 = self:TrimWhisperCommand((arg1:lower()))
    if var1 then
        local var2, var3 = self:TrimWhiteSpace(var1)
        local tbl3 = {}
        local tbl4 = {}
        local players = Players:GetPlayers()
        for i = 1, #players do
            if players[i] == LocalPlayer then
                continue
            end

            if string.sub(players[i].Name:lower(), 1, string.len(var2)) == var2 then
                tbl3[players[i]] = players[i].Name:lower()
            end

            if not ChatSettings.WhisperByDisplayName then
                continue
            end

            local str1 = players[i].DisplayName:lower()
            if string.sub(str1, 1, string.len(var2)) == var2 then
                tbl4[players[i]] = str1
            end
        end

        local num1 = 0
        local var4 = nil
        local var5 = nil
        for k, value in pairs(tbl3) do
            num1 += 1

            if value == var2 and var3 then
                return k
            end

            var5 = value
            var4 = k
        end

        if ChatSettings.WhisperByDisplayName then
            for k, value in pairs(tbl4) do
                if var4 ~= k then
                    num1 += 1
                    var5 = value
                    var4 = k
                end
            end
        end

        if num1 == 1 then
            if self:ShouldAutoCompleteNames() then
                return var4
            end

            if var5 == var2 then
                return var4
            end
        end
    end
    return nil
end

function tbl1:GetWhisperChanneNameColor()
    if self.ChatSettings.WhisperChannelNameColor then
        return self.ChatSettings.WhisperChannelNameColor
    end
    return Color3.fromRGB(102, 14, 102)
end

function tbl1:EnterWhisperState(arg1)
    self.PlayerNameEntered = true
    self.PlayerName = arg1.Name
    self.PlayerDisplayName = arg1.DisplayName

    self.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    local str1 = if ChatSettings.PlayerDisplayNamesEnabled and ChatSettings.WhisperByDisplayName then string.format("[To %s]", arg1.DisplayName) else string.format("[To %s]", arg1.Name)

    if ChatLocalization.tryLocalize then
        str1 = ChatLocalization:tryLocalize(str1)
    end
    self.MessageModeButton.Text = str1

    self.MessageModeButton.TextColor3 = self:GetWhisperChanneNameColor()

    local xOffset = math.ceil(self.MessageModeButton.TextBounds.X)
    self.MessageModeButton.Size = UDim2.new(0, xOffset, 1, 0)
    self.TextBox.Size = UDim2.new(1, -xOffset, 1, 0)
    self.TextBox.Position = UDim2.new(0, xOffset, 0, 0)
    self.TextBox.Text = " "
end

function tbl1:TextUpdated()
    local textBoxText = self.TextBox.Text
    if not self.PlayerNameEntered then
        local whisperingPlayer = self:GetWhisperingPlayer(textBoxText)
        if whisperingPlayer then
            self:EnterWhisperState(whisperingPlayer)
        end

        return
    end

    if textBoxText ~= "" then
        return
    end

    self.MessageModeButton.Text = ""
    self.MessageModeButton.Size = UDim2.new(0, 0, 0, 0)
    self.TextBox.Size = UDim2.new(1, 0, 1, 0)
    self.TextBox.Position = UDim2.new(0, 0, 0, 0)
    self.TextBox.Text = ""

    self.PlayerNameEntered = false

    self.ChatBar:ResetCustomState()
    self.ChatBar:CaptureFocus()
end

function tbl1:GetMessage()
    if self.PlayerNameEntered then
        return "/w " .. self.PlayerName .. " " .. self.TextBox.Text
    end

    return self.TextBox.Text
end

function tbl1.ProcessCompletedMessage(_): boolean
    return false
end

function tbl1:Destroy()
    self.MessageModeConnection:disconnect()
    self.Destroyed = true
end

function tbl2.new(chatWindow, chatBar, chatSettings, arg1)
    local self = setmetatable({}, tbl1)
    self.Destroyed = false
    self.ChatWindow = chatWindow
    self.ChatBar = chatBar
    self.ChatSettings = chatSettings
    self.TextBox = chatBar:GetTextBox()
    self.MessageModeButton = chatBar:GetMessageModeTextButton()
    self.OriginalWhisperText = ""
    self.PlayerNameEntered = false

    self.MessageModeConnection = self.MessageModeButton.MouseButton1Click:connect(function()
        local textBoxText = self.TextBox.Text
        if string.sub(textBoxText, 1, 1) == " " then
            textBoxText = string.sub(textBoxText, 2)
        end
        self.ChatBar:ResetCustomState()
        self.ChatBar:SetTextBoxText(textBoxText)
        self.ChatBar:CaptureFocus()
    end)

    if arg1 then
        self:EnterWhisperState(arg1)
    else
        self:TextUpdated()
    end

    return self
end

function ProcessMessage(arg1, chatWindow, chatBar, chatSettings)
    if string.sub(arg1, 1, 3):lower() == "/w " or string.sub(arg1, 1, 9):lower() == "/whisper " then
        return tbl2.new(chatWindow, chatBar, chatSettings)
    end
    return nil
end

function CreateCustomState(arg1, chatWindow, chatBar, chatSettings)
    return tbl2.new(chatWindow, chatBar, chatSettings, arg1)
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.IN_PROGRESS_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage,
    CustomStateCreator = CreateCustomState
}
