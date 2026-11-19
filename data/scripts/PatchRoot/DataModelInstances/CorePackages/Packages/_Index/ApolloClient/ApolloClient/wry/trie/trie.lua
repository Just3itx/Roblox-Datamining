-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local tbl1 = {}

local function defaultMakeData()
    return {}
end

local Trie = {}
Trie.__index = Trie

function Trie.new(weakness: boolean?, makeData: ((...any) -> (...any))?)
    if weakness == nil then
        weakness = true
    end

    if makeData == nil then
        makeData = defaultMakeData
    end
    local self = setmetatable({}, Trie)

    self.weakness = weakness
    self.makeData = makeData

    return self
end

function Trie.lookup(arg1, ...)
    return arg1:lookupArray({ ... })
end

function Trie.lookupArray(arg1, arg2)
    local var1 = arg1

    for _, value in arg2 do
        arg1 = arg1:getChildTrie(value)
    end

    if not arg1.data then
        arg1.data = var1.makeData(table.clone(arg2))
    end

    return arg1.data
end

function Trie:getChildTrie(arg1)
    local var1

    if self.weakness then
        if self.weak == nil then
            self.weak = setmetatable({}, { __mode = "k" })
        end
        var1 = self.weak
    else
        if self.strong == nil then
            self.strong = {}
        end
        var1 = self.strong
    end
    local var2 = var1[arg1]

    if not var2 then
        var2 = Trie.new(self.weakness, self.makeData)
        var1[arg1] = var2
    end
    return var2
end

tbl1.Trie = Trie

return tbl1
