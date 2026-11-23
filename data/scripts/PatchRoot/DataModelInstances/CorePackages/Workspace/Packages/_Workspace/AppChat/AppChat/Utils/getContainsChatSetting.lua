-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1): boolean
    return if tbl1 then (table.find(tbl1, "WhoCanChatWithMeInApp")
        or table.find(tbl1, "WhoCanGroupChatWithMeInApp")
        or table.find(tbl1, "WhoCanOneOnOnePartyWithMe")
        or table.find(tbl1, "WhoCanGroupPartyWithMe")) ~= nil else false
end
