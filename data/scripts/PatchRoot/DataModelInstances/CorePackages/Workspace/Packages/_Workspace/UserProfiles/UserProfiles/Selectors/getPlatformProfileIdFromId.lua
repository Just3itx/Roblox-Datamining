-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getUserProfileFromId = require(script.Parent.getUserProfileFromId)

return function(arg1, arg2)
    return getUserProfileFromId(arg1, arg2).platformProfileId
end
