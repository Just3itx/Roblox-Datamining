-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    seedConversationStore = function(arg1, tbl1, arg2)
        arg1.clear()

        for _, value in pairs(tbl1 or {}) do
            arg1.upsertConversation(value)
        end

        if arg2 ~= nil then
            arg1.setListStatus(arg2)
        end
    end
}
