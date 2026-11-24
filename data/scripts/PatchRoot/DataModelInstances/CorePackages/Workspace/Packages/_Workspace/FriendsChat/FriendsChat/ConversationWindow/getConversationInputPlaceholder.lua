-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getConversationInputPlaceholder(tbl1, arg1, func1: (...any) -> (...any), arg2)
    if tbl1.isTouch then
        return func1("CoreScripts.TextChat.InputBar.Hint.Touch")
    end
    return func1("CoreScripts.TextChat.InputBar.Hint.MouseKeyboard", { KEY = arg2:GetStringForKeyCode(arg1) })
end

return getConversationInputPlaceholder
