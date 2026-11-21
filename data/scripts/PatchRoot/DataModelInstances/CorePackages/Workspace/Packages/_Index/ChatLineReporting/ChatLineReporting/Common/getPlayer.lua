-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getPlayer(arg1, userId: string)
    for _, value in pairs(arg1) do
        if value.userId == userId then
            return value
        end
    end
    return nil
end

return getPlayer
