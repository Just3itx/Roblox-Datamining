-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local var1 = string.gsub(arg2 or "0", "%p", { ["."] = "_" })
    arg1.reportCounter(string.format("ExpChatV%sCount", var1))
end
