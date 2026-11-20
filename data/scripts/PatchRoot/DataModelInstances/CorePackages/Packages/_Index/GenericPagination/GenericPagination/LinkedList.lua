-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.createNode(value)
    local tbl1 = { previous = nil, next = nil, value = value }

    setmetatable(tbl1, module)

    return tbl1
end

function module:CreateNext(value)
    local tbl1 = {
        previous = self,
        next = self.next,
        value = value or {}
    }

    if self.next then
        self.next.previous = tbl1
    end

    setmetatable(tbl1, module)
    self.next = tbl1
    return tbl1
end

function module:CreatePrevious(value)
    local tbl1 = {
        previous = self.previous,
        next = self,
        value = value or {}
    }

    if self.previous then
        self.previous.next = tbl1
    end

    setmetatable(tbl1, module)
    self.previous = tbl1
    return tbl1
end

return module
