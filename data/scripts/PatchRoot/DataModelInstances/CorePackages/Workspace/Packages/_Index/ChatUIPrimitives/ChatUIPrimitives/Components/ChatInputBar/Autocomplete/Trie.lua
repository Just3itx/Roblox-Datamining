-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(str1: string)
    local self = setmetatable({}, tbl1)
    self.children = {}
    self.isEndOfWord = false
    self.data = str1
    return self
end

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    self.root = tbl1.new("")
    return self
end

function module:insert(str1: string)
    local root = self.root
    for i = 1, #str1 do
        local str2 = string.sub(str1, i, i)
        if not root.children[str2] then
            root.children[str2] = tbl1.new(str2)
        end
        root = root.children[str2]
    end
    root.isEndOfWord = true
end

function module:autocomplete(str1: string)
    local result = {}
    local root = self.root
    for i = 1, #str1 do
        local str2 = string.sub(str1, i, i)
        if not root.children[str2] then
            return result
        end

        root = root.children[str2]
    end

    local num1 = #str1 - 1
    self:_collect(root, result, string.sub(str1, 1, num1))
    return result
end

function module:_collect(arg1, tbl2, str1: string)
    if arg1.isEndOfWord then
        table.insert(tbl2, str1 .. arg1.data)
    end
    for _, child in pairs(arg1.children) do
        self:_collect(child, tbl2, str1 .. arg1.data)
    end
end

return module
