-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

game:DefineFastFlag("ExpChatGlobalCommandAutocompletePrimaryAliasOnly", false)

return function(arg1)
    for _, value in ExpChatShared.GlobalCommands.getGlobalEnabledCommands() do
        if game:GetFastFlag("ExpChatGlobalCommandAutocompletePrimaryAliasOnly") then
            arg1.trie:insert(value.alias[1])
        else
            for _, alia in value.alias do
                arg1.trie:insert(alia)
            end
        end
    end
    return arg1.trie
end
