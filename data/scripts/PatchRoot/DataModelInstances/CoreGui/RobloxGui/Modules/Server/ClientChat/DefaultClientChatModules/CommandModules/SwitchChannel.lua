-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Util = require(script.Parent:WaitForChild("Util"))

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var1 = var1 == nil and {
    Get = function<T>(_, _, arg1: T): T
        return arg1
    end
} or var1

function ProcessMessage(arg1, arg2, arg3): boolean
    if string.sub(arg1, 1, 3):lower() ~= "/c " then
        return false
    end

    local rbxName = string.sub(arg1, 4)

    local channel = arg2:GetChannel(rbxName)
    if channel then
        arg2:SwitchCurrentChannel(rbxName)
        if not arg3.ShowChannelsBar and arg2:GetCurrentChannel() then
            Util:SendSystemMessageToSelf(
                string.gsub(
                    var1:Get(
                        "GameChat_SwitchChannel_NowInChannel",
                        string.format("You are now chatting in channel: '%s'", rbxName),
                        { RBX_NAME = rbxName }
                    ),
                    "{RBX_NAME}",
                    rbxName
                ),
                channel,
                {}
            )
        end
    else
        local currentChannel = arg2:GetCurrentChannel()
        if currentChannel then
            Util:SendSystemMessageToSelf(
                string.gsub(
                    var1:Get(
                        "GameChat_SwitchChannel_NotInChannel",
                        string.format("You are not in channel: '%s'", rbxName),
                        { RBX_NAME = rbxName }
                    ),
                    "{RBX_NAME}",
                    rbxName
                ),
                currentChannel,
                {
                    ChatColor = Color3.fromRGB(245, 50, 50)
                }
            )
        end
    end
    return true
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}
