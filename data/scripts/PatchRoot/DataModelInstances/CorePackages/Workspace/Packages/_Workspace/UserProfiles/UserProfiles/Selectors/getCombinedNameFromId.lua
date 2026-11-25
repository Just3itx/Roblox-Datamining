-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getUserProfileFromId = require(script.Parent.getUserProfileFromId)

return function(arg1, arg2)
    local userProfileFromId = getUserProfileFromId(arg1, arg2)

    return if userProfileFromId.names then userProfileFromId.names.combinedName else nil
end
