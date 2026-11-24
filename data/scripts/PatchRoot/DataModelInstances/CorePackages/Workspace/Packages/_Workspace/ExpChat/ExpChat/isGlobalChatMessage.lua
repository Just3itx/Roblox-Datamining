-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isGlobalChatMessage(tbl1): boolean
    return tbl1.isUniverseChat == true or tbl1.channelNameOverride == "RBXGlobal"
end

return isGlobalChatMessage
