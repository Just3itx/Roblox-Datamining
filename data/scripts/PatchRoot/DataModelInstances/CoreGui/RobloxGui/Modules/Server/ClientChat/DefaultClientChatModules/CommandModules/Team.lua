-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local tbl1 = { "/team ", "/t ", "% " }

function IsTeamCommand(arg1)
    for i = 1, #tbl1 do
        local var1 = tbl1[i]
        if string.sub(arg1, 1, var1:len()):lower() == var1 then
            return true
        end
    end
    return false
end

local tbl2 = {}
tbl2.__index = tbl2

local Util = require(script.Parent:WaitForChild("Util"))

local tbl3 = {}

function tbl2:EnterTeamChat()
    self.TeamChatEntered = true
    self.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    self.MessageModeButton.Text = "[Team]"
    self.MessageModeButton.TextColor3 = self:GetTeamChatColor()

    local textBoundsX = self.MessageModeButton.TextBounds.X
    self.MessageModeButton.Size = UDim2.new(0, textBoundsX, 1, 0)
    self.TextBox.Size = UDim2.new(1, -textBoundsX, 1, 0)
    self.TextBox.Position = UDim2.new(0, textBoundsX, 0, 0)
    self.OriginalTeamText = self.TextBox.Text
    self.TextBox.Text = " "
end

function tbl2:TextUpdated()
    local textBoxText = self.TextBox.Text
    if not self.TeamChatEntered then
        if IsTeamCommand(textBoxText) then
            self:EnterTeamChat()
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

    self.TeamChatEntered = false

    self.ChatBar:ResetCustomState()
    self.ChatBar:CaptureFocus()
end

function tbl2:GetMessage()
    if self.TeamChatEntered then
        return "/t " .. self.TextBox.Text
    end

    return self.TextBox.Text
end

function tbl2.ProcessCompletedMessage(_): boolean
    return false
end

function tbl2:Destroy()
    self.MessageModeConnection:disconnect()
    self.Destroyed = true
end

function tbl2:GetTeamChatColor()
    local localPlayer = Players.LocalPlayer
    if localPlayer.Team then
        return localPlayer.Team.TeamColor.Color
    elseif self.ChatSettings.DefaultChannelNameColor then
        return self.ChatSettings.DefaultChannelNameColor
    end
    return Color3.fromRGB(35, 76, 142)
end

function tbl3.new(chatWindow, chatBar, chatSettings)
    local self = setmetatable({}, tbl2)
    self.Destroyed = false
    self.ChatWindow = chatWindow
    self.ChatBar = chatBar
    self.ChatSettings = chatSettings
    self.TextBox = chatBar:GetTextBox()
    self.MessageModeButton = chatBar:GetMessageModeTextButton()
    self.OriginalTeamText = ""
    self.TeamChatEntered = false

    self.MessageModeConnection = self.MessageModeButton.MouseButton1Click:connect(function()
        local textBoxText = self.TextBox.Text
        if string.sub(textBoxText, 1, 1) == " " then
            textBoxText = string.sub(textBoxText, 2)
        end
        self.ChatBar:ResetCustomState()
        self.ChatBar:SetTextBoxText(textBoxText)
        self.ChatBar:CaptureFocus()
    end)

    self:EnterTeamChat()

    return self
end

function ProcessMessage(arg1, chatWindow, chatBar, chatSettings)
    if chatBar.TargetChannel == "Team" then
        return
    elseif IsTeamCommand(arg1) then
        return tbl3.new(chatWindow, chatBar, chatSettings)
    end
    return nil
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.IN_PROGRESS_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}
