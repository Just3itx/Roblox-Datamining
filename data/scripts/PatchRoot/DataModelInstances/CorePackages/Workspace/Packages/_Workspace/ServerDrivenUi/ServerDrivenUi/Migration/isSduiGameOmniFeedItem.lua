-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

for value in game:DefineFastString("SduiNonGameTopicIds", "300000000, 600000000, 100000010"):gmatch("(%w+)") do
    tbl1[value] = true
end

local function isSduiGameOmniFeedItem(arg1, arg2): boolean
    return arg1 == "sdui" and not (arg2 == nil) and not tbl1[tostring(arg2)]
end

return isSduiGameOmniFeedItem
