-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(arg1)
    return (setmetatable({ _privateValues = table.clone(arg1) }, module))
end

function module:GetItem(arg1)
    return self._privateValues[arg1]
end

function module:SetItem(arg1, arg2)
    self._privateValues[arg1] = arg2
end

function module.Flush(_) end

function module:_DeepEquals(arg1)
    for value, value2 in arg1 do
        if self._privateValues[value] ~= value2 then
            return false
        end
    end

    return true
end

return module
