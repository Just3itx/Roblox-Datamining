-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Util = require(script.Parent:WaitForChild("Util"))
local RunService = game:GetService("RunService")

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

if var1 == nil then
    var1 = {}

    function var1.Get<T>(_, _, arg1: T): T
        return arg1
    end
end

function ProcessMessage(_, arg1, _): boolean
    local localPlayer = game:GetService("Players").LocalPlayer
    if not localPlayer or not (localPlayer.UserId < 0) or RunService:IsStudio() then
        return false
    end

    local currentChannel = arg1:GetCurrentChannel()
    if currentChannel then
        Util:SendSystemMessageToSelf(
            var1:Get("GameChat_SwallowGuestChat_Message", "Create a free account to get access to chat permissions!"),
            currentChannel,
            {}
        )
    end

    return true
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}
