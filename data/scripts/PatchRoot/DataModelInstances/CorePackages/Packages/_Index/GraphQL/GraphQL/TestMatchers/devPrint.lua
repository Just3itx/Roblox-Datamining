-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local inspect = require(scriptParentParentParent.LuauPolyfill).util.inspect

local function devPrint(...)
    local tbl1 = ({})
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        tbl1[i] = inspect(var1)
    end
    print(table.unpack(tbl1))
end

return devPrint
