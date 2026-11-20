-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

local function resetMock(arg1, arg2)
    local var1 = getmetatable(arg1)
    var1[symbols.Calls] = {}

    for _, value in pairs(var1[symbols.Children]) do
        if not arg2[value] then
            arg2[value] = true
            resetMock(value, arg2)
        end
    end
end

return function(arg1)
    resetMock(arg1, {})
end
