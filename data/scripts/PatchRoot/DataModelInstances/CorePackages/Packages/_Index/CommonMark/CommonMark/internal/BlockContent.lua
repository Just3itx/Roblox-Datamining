-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:22Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _sb = {}, _lineCount = 0 }, module))
end

function module.newString(str1: string)
    return (setmetatable({ _sb = { str1 }, _lineCount = 0 }, module))
end

function module:add(str1: string)
    if self._lineCount ~= 0 then
        table.insert(self._sb, "\n")
    end
    table.insert(self._sb, str1)
    self._lineCount += 1
end

function module:getString(): string
    return table.concat(self._sb)
end

return module
