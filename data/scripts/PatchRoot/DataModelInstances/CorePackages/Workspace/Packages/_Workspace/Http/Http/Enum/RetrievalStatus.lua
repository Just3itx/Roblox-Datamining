-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local tbl2 = { NotStarted = "NotStarted", Fetching = "Fetching", Done = "Done", Failed = "Failed" }

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        assert(tbl2[arg1] ~= nil, "RetrievalStatus Enum has no value: " .. tostring(arg1))
        return tbl2[arg1]
    end
})

return tbl1
