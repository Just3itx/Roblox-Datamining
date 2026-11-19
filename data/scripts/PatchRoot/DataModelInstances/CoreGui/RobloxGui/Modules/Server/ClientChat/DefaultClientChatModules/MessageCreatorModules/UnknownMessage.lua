-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateUnknownMessageLabel(arg1)
    print("No message creator for message: " .. arg1.Message)
end

return {
    [Util.KEY_MESSAGE_TYPE] = "UnknownMessage",
    [Util.KEY_CREATOR_FUNCTION] = CreateUnknownMessageLabel
}
