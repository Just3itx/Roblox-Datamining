-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List
local Dictionary = require(ExpChatParent.llama).Dictionary
local EmojiList = require(ExpChatParent.EmojiList)

local var1 = Dictionary.keys(EmojiList)

return function(arg1)
    List.map(var1, function(arg2)
        arg1.trie:insert(arg2)
    end)

    return arg1.trie
end
