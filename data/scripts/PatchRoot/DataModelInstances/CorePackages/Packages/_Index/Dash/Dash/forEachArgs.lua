-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function forEachArgs(callback: (...any) -> (...any), ...)
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        callback(select(i, ...), i)
    end
end

return forEachArgs
