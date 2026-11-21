-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = { Invalid = "Invalid", CollectibleItem = "CollectibleItem" }

local tbl1 = ({})
for _, value in pairs(module) do
    tbl1[value] = true
end

function module.fromValue(str1: string?): string?
    return if str1 == nil or not tbl1[str1] then nil else str1
end

return module
