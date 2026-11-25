-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local RequestType = require(scriptParentParent.Enums.RequestType)

return function(arg1): boolean
    return arg1.promptRequest.requestType ~= RequestType.None
end
