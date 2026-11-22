-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = setmetatable({}, {
    __index = function(_, arg1)
        error(("Invalid TimeZone \"%s\""):format(tostring(arg1)), 2)
    end
})

var1.UTC = -2
var1.Current = -1

return var1
