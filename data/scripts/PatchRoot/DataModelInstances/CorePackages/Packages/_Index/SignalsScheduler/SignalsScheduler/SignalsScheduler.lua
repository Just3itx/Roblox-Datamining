-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = false

local tbl1 = {}

local function batch(callback: (...any) -> (...any))
    if bool1 then
        callback()

        return
    end

    bool1 = true
    callback()
    for _, value in tbl1 do
        value()
    end
    table.clear(tbl1)
    bool1 = false
end
return {
    batch = batch,
    flush = function()
        batch(function() end)
    end,
    schedule = function(func1: (...any) -> (...any))
        table.insert(tbl1, func1)
    end
}
