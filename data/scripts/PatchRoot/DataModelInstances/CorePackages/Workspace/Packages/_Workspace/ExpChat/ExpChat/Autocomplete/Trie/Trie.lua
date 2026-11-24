-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Autocomplete = script:FindFirstAncestor("Autocomplete")
local List = require(ExpChatParent.llama).List

local TrieNode = require(Autocomplete.Trie.TrieNode)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)
    result.root = TrieNode.new("")
    return result
end

function module:insert(str1: string)
    local root = self.root
    for i = 1, #str1 do
        local str2 = string.sub(str1, i, i)
        if not root.children[str2] then
            root.children[str2] = TrieNode.new(str2)
        end
        root = root.children[str2]
    end
    root.isEndOfWord = true
end

function module:autocomplete(str1: string)
    local tbl1 = {}
    local root = self.root
    for i = 1, #str1 do
        local str2 = string.sub(str1, i, i)
        if not root.children[str2] then
            return tbl1
        end

        root = root.children[str2]
    end

    local num1 = #str1 - 1
    return (self:helper(root, tbl1, string.sub(str1, 1, num1)))
end

function module:helper(arg1, tbl1, str1: string)
    if arg1.isEndOfWord then
        tbl1 = List.push(tbl1, str1 .. arg1.data)
    end
    for _, child in pairs(arg1.children) do
        tbl1 = self:helper(child, tbl1, str1 .. arg1.data)
    end
    return tbl1
end

return module
