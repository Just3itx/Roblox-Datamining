-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Cryo = require(AppChatParent.Cryo)

local function getLastMessageWithFilter(tbl1, func1: (...any) -> (...any))
    if not tbl1 or #tbl1 == 0 then
        return nil
    end

    local where = Cryo.List.findWhere(tbl1, func1)
    return where and tbl1[where].messageId or nil
end

return getLastMessageWithFilter
