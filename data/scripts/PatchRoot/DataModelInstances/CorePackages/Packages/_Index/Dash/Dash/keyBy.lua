-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local collect = require(scriptParent.collect)

local function keyBy(tbl1, arg1)
    return collect(tbl1, function(arg2, arg3)
        return if typeof(arg1) == "function" then arg1(arg3, arg2) else arg3[arg1], arg3
    end)
end
return keyBy
