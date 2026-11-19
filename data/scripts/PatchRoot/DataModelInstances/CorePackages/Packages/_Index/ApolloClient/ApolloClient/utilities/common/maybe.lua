-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

function module.maybe(func1: (...any) -> (...any))
    local _success, result, result2 = xpcall(function()
        return func1(), true
    end, function() end)
    return if result2 then result else nil
end

return module
