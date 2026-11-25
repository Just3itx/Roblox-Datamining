-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

return function(tbl1)
    return function(arg1)
        tbl1:reportCounter(arg1.name, arg1.count or 1)

        return arg1
    end
end
