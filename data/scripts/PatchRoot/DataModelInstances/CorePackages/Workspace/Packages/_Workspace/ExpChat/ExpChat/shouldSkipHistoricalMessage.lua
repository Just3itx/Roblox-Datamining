-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local FFlagExpChatIgnoreHistoricalMessages = require(ExpChat.Flags.FFlagExpChatIgnoreHistoricalMessages)

return function(arg1)
    return FFlagExpChatIgnoreHistoricalMessages and arg1.IsHistorical == true
end
