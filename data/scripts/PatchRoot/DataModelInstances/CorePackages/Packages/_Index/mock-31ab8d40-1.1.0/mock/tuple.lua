-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

return function(...)
    local values = { ... }
    assert(#values > 1, "Mock Error: tuple only accepts more than 1 value.")

    return (setmetatable({
        [symbols.isTuple] = true,
        values = values
    }, {
        __tostring = function(_): string
            local tbl2 = {}
            for _, value in ipairs(values) do
                table.insert(tbl2, tostring(value))
            end
            return "<Tuple values=[" .. table.concat(tbl2, ", ") .. "]>"
        end
    }))
end
