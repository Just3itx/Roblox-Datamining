-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

return function(predicate)
    assert(type(predicate) == "function", "Mock Error: Mock.predicate must be given a function")

    return (setmetatable({
        [symbols.isPredicate] = true,
        predicate = predicate
    }, {
        __tostring = function(): string
            return "<Predicate>"
        end
    }))
end
