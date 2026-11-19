-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))

local tbl1 = {}
local tbl2 = {}
tbl2.__index = tbl2

function tbl2.SendSystemMessageToSelf(_, message, arg1, extraData)
    arg1:AddMessageToChannel({
        ID = -1,
        FromSpeaker = nil,
        SpeakerUserId = 0,
        OriginalChannel = arg1.Name,
        IsFiltered = true,
        MessageLength = string.len(message),
        MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(message)),
        Message = message,
        MessageType = ChatConstants.MessageTypeSystem,
        Time = os.time(),
        ExtraData = extraData
    })
end

function tbl1.new()
    local self = setmetatable({}, tbl2)

    self.COMMAND_MODULES_VERSION = 1

    self.KEY_COMMAND_PROCESSOR_TYPE = "ProcessorType"
    self.KEY_PROCESSOR_FUNCTION = "ProcessorFunction"

    self.IN_PROGRESS_MESSAGE_PROCESSOR = 0
    self.COMPLETED_MESSAGE_PROCESSOR = 1

    return self
end

return tbl1.new()
