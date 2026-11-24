-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List
local EmojiList = require(ExpChatParent.EmojiList)

return function(arg1)
    return List.sort(arg1, function(str1: string, str2: string): boolean
        if EmojiList[str1].popularity == EmojiList[str2].popularity then
            return str1 < str2
        end

        return EmojiList[str1].popularity < EmojiList[str2].popularity
    end)
end
