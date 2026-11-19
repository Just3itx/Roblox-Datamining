-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Util = require(script.Parent:WaitForChild("Util"))
local ChatConstants = require(script.Parent.Parent:WaitForChild("ChatConstants"))

local module = {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR
}

module[Util.KEY_PROCESSOR_FUNCTION] = function(arg1, arg2, _): boolean -- name: ProcessMessage
    if string.sub(arg1, 1, 8):lower() ~= "/version" and string.sub(arg1, 1, 9):lower() ~= "/version " then
        return false
    end

    Util:SendSystemMessageToSelf(
        string.format(
            "This experience is running chat version [%d.%d.%s].",
            ChatConstants.MajorVersion,
            ChatConstants.MinorVersion,
            ChatConstants.BuildVersion
        ),
        arg2:GetCurrentChannel(),
        {}
    )
    return true
end

return module
