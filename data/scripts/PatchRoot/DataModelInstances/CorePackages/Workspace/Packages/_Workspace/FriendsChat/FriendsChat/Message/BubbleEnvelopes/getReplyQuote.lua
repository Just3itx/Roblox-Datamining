-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getReplyQuote(arg1, arg2)
    local var1 = arg2 or arg1
    if var1 == nil then
        return nil
    end
    if var1.type == "system" or var1.visibility == "hidden" then
        return nil
    end
    if var1.status == "Moderated" or var1.status == "Failed" then
        return nil
    end
    local content = var1.content
    return if type(content) == "string" and content ~= "" then content else nil
end

return getReplyQuote
