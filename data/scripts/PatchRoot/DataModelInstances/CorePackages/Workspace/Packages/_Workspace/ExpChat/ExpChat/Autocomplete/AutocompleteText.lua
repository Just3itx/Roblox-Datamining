-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Autocomplete = script:FindFirstAncestor("Autocomplete")
local Trie = require(Autocomplete.Trie.Trie)

local module = {}
module.__index = module

function module.new(func1: (...any) -> (...any))
    local result = {}
    setmetatable(result, module)

    result.trie = Trie.new()
    result.trie = func1(result)

    return result
end

function module:getResults(str1: string, func1: ((...any) -> (...any))?)
    local var1 = self.trie:autocomplete(str1)
    if func1 then
        return func1(var1)
    end

    return var1
end

return module
