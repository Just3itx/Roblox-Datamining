-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getServerTimeNowMillis(): number
    return workspace:GetServerTimeNow() * 1000
end

return getServerTimeNowMillis
