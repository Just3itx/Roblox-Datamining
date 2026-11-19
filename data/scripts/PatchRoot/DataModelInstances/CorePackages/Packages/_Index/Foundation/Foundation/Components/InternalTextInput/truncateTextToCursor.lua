-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:32Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function charAt(text: string, num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return text:sub(num1, num1)
end

local function truncateTextToCursor(arg1): string
    local cursorPosition = arg1.CursorPosition
    if cursorPosition == -1 then
        return ""
    end

    local text = arg1.Text
    local var1 = arg1.TextSize * arg1.LineHeight / 1.4
    local var2 = cursorPosition + arg1.AbsoluteSize.X / var1
    local var3 = string.find(text, "\n", cursorPosition) or math.huge
    local var4 = string.find(text, "[ \t\f\11]", cursorPosition) or math.huge
    local num1 = math.min(var3 - 1, var4, #text)

    if charAt(text, cursorPosition):match("\n") and (charAt(text, cursorPosition - 1):match("\n") or cursorPosition == 1) then
        cursorPosition -= 1
    elseif not (var2 < num1) then
        cursorPosition = num1
    end

    return utf8.char(utf8.codepoint(text, 1, cursorPosition))
end

return truncateTextToCursor
