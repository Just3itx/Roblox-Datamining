-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local findLocalTextSource = require(script.Parent.findLocalTextSource)

local function isLocalUserInTextChannel(arg1, str1: string): boolean
    return findLocalTextSource(arg1, str1) ~= nil
end

return isLocalUserInTextChannel
