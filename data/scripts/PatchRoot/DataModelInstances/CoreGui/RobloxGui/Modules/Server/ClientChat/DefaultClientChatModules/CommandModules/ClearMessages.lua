-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Util = require(script.Parent:WaitForChild("Util"))

function ProcessMessage(arg1, arg2, _): boolean
    if string.sub(arg1, 1, 4):lower() ~= "/cls" and string.sub(arg1, 1, 6):lower() ~= "/clear" then
        return false
    end

    local currentChannel = arg2:GetCurrentChannel()
    if currentChannel then
        currentChannel:ClearMessageLog()
    end
    return true
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}
