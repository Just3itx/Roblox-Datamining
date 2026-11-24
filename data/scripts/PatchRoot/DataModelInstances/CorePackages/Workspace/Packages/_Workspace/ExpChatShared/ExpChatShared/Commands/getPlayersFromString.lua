-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local Dictionary = require(ExpChatSharedParent.llama).Dictionary

local function getPlayersFromCommand(arg1, str1: string?)
    if not str1 then
        return {}
    end
    assert(str1, "will exist")

    str1 = string.lower(str1)
    if str1 and string.sub(str1, 1, 1) == "@" then
        local str2 = string.sub(str1, 2)
        local var1 = arg1.byUsername[str2]
        if var1 then
            return { Dictionary.join(arg1.byUserId[var1], { nameToDisplay = "@" .. arg1.byUserId[var1].username }) }
        end
    end

    return Dictionary.map(arg1.byDisplayName[str1] or {}, function(arg2)
        return Dictionary.join(arg1.byUserId[arg2], { nameToDisplay = arg1.byUserId[arg2].displayName })
    end)
end

return getPlayersFromCommand
