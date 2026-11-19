-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local tbl1 = {}
tbl1.__index = tbl1

local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local CommandModules = ClientChatModules:WaitForChild("CommandModules")
local Util = require(CommandModules:WaitForChild("Util"))
local _scriptParent = script.Parent
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

function tbl1:SetupCommandProcessors()
    local children = CommandModules:GetChildren()
    for i = 1, #children do
        if not children[i]:IsA("ModuleScript") or children[i].Name == "Util" then
            continue
        end

        local var1 = require(children[i])
        local var2 = var1[Util.KEY_COMMAND_PROCESSOR_TYPE]
        local var3 = var1[Util.KEY_PROCESSOR_FUNCTION]
        if var2 == Util.IN_PROGRESS_MESSAGE_PROCESSOR then
            table.insert(self.InProgressMessageProcessors, var3)
        elseif var2 == Util.COMPLETED_MESSAGE_PROCESSOR then
            table.insert(self.CompletedMessageProcessors, var3)
        end
    end
end

function tbl1:ProcessCompletedChatMessage(arg1, arg2)
    for i = 1, #self.CompletedMessageProcessors do
        if self.CompletedMessageProcessors[i](arg1, arg2, ChatSettings) then
            return true
        end
    end
    return false
end

function tbl1:ProcessInProgressChatMessage(arg1, arg2, arg3)
    for i = 1, #self.InProgressMessageProcessors do
        local var1 = self.InProgressMessageProcessors[i](arg1, arg2, arg3, ChatSettings)
        if var1 then
            return var1
        end
    end
    return nil
end

function module.new()
    local self = setmetatable({}, tbl1)

    self.CompletedMessageProcessors = {}
    self.InProgressMessageProcessors = {}

    self:SetupCommandProcessors()

    return self
end

return module
