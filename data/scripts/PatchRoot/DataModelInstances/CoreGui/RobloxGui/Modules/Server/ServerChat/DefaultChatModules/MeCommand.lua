-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local function Run(arg1)
    if not ChatSettings or not ChatSettings.AllowMeCommand then
        return
    end

    arg1:RegisterFilterMessageFunction("me_command", function(_, arg2, _) -- name: MeCommandFilterFunction
        local message = arg2.Message
        if message and string.sub(message, 1, 4):lower() == "/me " then
            arg2.MessageType = ChatConstants.MessageTypeMeCommand
        end
    end)
end
return Run
