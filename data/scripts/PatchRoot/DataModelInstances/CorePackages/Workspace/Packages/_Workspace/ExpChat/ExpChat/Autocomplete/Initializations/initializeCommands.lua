-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local initialCommands = require(script.Parent.initialCommands)

local tbl1 = {}

local function getCommandKeys()
    local commandKeys = {}
    local descendants = TextChatService:GetDescendants()
    for _, descendant in ipairs(descendants) do
        if descendant.ClassName ~= "TextChatCommand" or string.sub(descendant.PrimaryAlias, 1, 1) ~= "/" then
            continue
        end

        if descendant.AutocompleteVisible then
            table.insert(commandKeys, descendant.PrimaryAlias)
        end
        table.insert(tbl1, descendant)
    end

    return commandKeys
end

return function(arg1)
    local commandKeys = getCommandKeys()
    List.map(commandKeys, function(arg2)
        arg1.trie:insert(arg2)
    end)

    for _, value in ExpChatShared.Commands.getVirtualLocalEnabledCommands() do
        for _, alia in value.alias do
            arg1.trie:insert(alia)
        end
    end

    initialCommands(tbl1)
    return arg1.trie
end
