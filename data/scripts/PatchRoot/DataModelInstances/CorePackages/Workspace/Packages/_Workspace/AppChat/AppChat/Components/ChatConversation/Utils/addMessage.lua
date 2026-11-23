-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local ArgCheck = require(AppChatParent.ArgCheck)

return function(tbl1: {any}, arg1, bool1: boolean?)
    ArgCheck.isType(tbl1, "table", "addMessage.messages")
    ArgCheck.isType(arg1, "string", "addMessage.value")

    if arg1 ~= "" then
        table.insert(tbl1, if bool1 then { placeId = arg1 } or { content = arg1 } else { content = arg1 })
    end
    return tbl1
end
