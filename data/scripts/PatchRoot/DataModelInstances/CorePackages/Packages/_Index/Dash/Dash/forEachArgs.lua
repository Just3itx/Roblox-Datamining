-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function forEachArgs(callback: (...any) -> (...any), ...)
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        callback(select(i, ...), i)
    end
end

return forEachArgs
