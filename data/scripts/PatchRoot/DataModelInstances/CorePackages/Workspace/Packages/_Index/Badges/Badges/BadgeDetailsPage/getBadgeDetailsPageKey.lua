-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getBadgeDetailsPageKey(str1: string?): string
    if str1 == nil then
        return "BadgeDetails-Unknown"
    end
    return `BadgeDetails-{str1}`
end

return getBadgeDetailsPageKey
