-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFlagRemoveMessageFromMessageLog")
end)
local var1 = success and result

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var2 = success2 and result2

local module = {}

local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local scriptParent = script.Parent

local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local var3 = nil
if var2 then
    var3 = scriptParent:FindFirstChild("ChatTranslationEnabled")
    if var3 == nil then
        local connection = nil
        connection = scriptParent.ChildAdded:Connect(function(child: Instance)
            if child.Name == "ChatTranslationEnabled" then
                var3 = child

                connection:Disconnect()
            end
        end)
    end
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:Destroy()
    self.Destroyed = true
end

function tbl1:SetActive(active)
    if active == self.Active then
        return
    end
    if active == false then
        self.MessageLogDisplay:Clear()
    else
        self.MessageLogDisplay:SetCurrentChannelName(self.Name)
        for i = 1, #self.MessageLog do
            self.MessageLogDisplay:AddMessage(self.MessageLog[i])
        end
    end
    self.Active = active
end

function tbl1:UpdateMessageFiltered(arg1)
    local messageLog = self.MessageLog
    local num1 = 1
    local var4 = nil
    local var5

    while true do
        if not (num1 <= #messageLog) then
            var5 = var4
            break
        end

        var5 = messageLog[num1]

        if var5.ID == arg1.ID then
            break
        end

        num1 += 1
    end

    if not var5 then
        self:AddMessageToChannelByTimeStamp(arg1)
        return
    end

    var5.Message = arg1.Message
    var5.IsFiltered = true
    if var2 and var3 ~= nil and var3.Value then
        var5.TranslatedMessage = arg1.TranslatedMessage
        var5.ShowTranslated = true
    end
    if not self.Active then
        return
    end

    if var1 and var5.Message == "" then
        table.remove(self.MessageLog, num1)
    end

    self.MessageLogDisplay:UpdateMessageFiltered(var5)
end

function tbl1:AddMessageToChannel(arg1)
    table.insert(self.MessageLog, arg1)
    if self.Active then
        self.MessageLogDisplay:AddMessage(arg1)
    end
    if #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel then
        self:RemoveLastMessageFromChannel()
    end
end

function tbl1:InternalAddMessageAtTimeStamp(arg1)
    for i = 1, #self.MessageLog do
        if arg1.Time < self.MessageLog[i].Time then
            table.insert(self.MessageLog, i, arg1)
            return
        end
    end
    table.insert(self.MessageLog, arg1)
end

function tbl1:AddMessagesToChannelByTimeStamp(arg1, arg2)
    for i = arg2, #arg1 do
        self:InternalAddMessageAtTimeStamp(arg1[i])
    end
    while #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel do
        table.remove(self.MessageLog, 1)
    end
    if not self.Active then
        return
    end

    self.MessageLogDisplay:Clear()
    for i = 1, #self.MessageLog do
        self.MessageLogDisplay:AddMessage(self.MessageLog[i])
    end
end

function tbl1:AddMessageToChannelByTimeStamp(arg1)
    if not (#self.MessageLog >= 1) then
        self:AddMessageToChannel(arg1)

        return
    end

    if self.MessageLog[1].Time > arg1.Time then
        return
    end
    if arg1.Time >= self.MessageLog[#self.MessageLog].Time then
        self:AddMessageToChannel(arg1)
        return
    end

    for i = 1, #self.MessageLog do
        if not (arg1.Time < self.MessageLog[i].Time) then
            continue
        end

        table.insert(self.MessageLog, i, arg1)

        if #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel then
            self:RemoveLastMessageFromChannel()
        end

        if self.Active then
            self.MessageLogDisplay:AddMessageAtIndex(arg1, i)
        end

        return
    end
end

function tbl1:RemoveLastMessageFromChannel()
    table.remove(self.MessageLog, 1)

    if self.Active then
        self.MessageLogDisplay:RemoveLastMessage()
    end
end

function tbl1:ClearMessageLog()
    self.MessageLog = {}

    if self.Active then
        self.MessageLogDisplay:Clear()
    end
end

function tbl1:RegisterChannelTab(channelTab)
    self.ChannelTab = channelTab
end

function module.new(selfName, messageLogDisplay)
    local self = setmetatable({}, tbl1)
    self.Destroyed = false
    self.Active = false

    self.MessageLog = {}
    self.MessageLogDisplay = messageLogDisplay
    self.ChannelTab = nil
    self.Name = selfName

    return self
end

return module
