-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function exitCreationFlow(callback: ((...any) -> (...any))?)
    if callback then
        callback()
    end
end

return exitCreationFlow
