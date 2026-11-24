-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function applyBubbleChatMessagePropertiesText(str1: string?, str2: string?, arg1)
    if arg1 and arg1:IsA("TextChatMessageProperties") then
        if arg1.Text ~= "" then
            str1 = arg1.Text
        end

        if arg1.Translation ~= "" then
            return str1, arg1.Translation
        end
    end
    return str1, str2
end

return applyBubbleChatMessagePropertiesText
