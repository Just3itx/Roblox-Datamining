-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local utf8Range = require(script.Parent.utf8Range)

local function byteIndexAt(text: string, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if utf8.len(text) == nil then
        return nil
    end
    return utf8.offset(text, num1)
end

local function characterIndexAt(text: string, cursorPosition: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if cursorPosition < 1 then
        return nil
    end
    local var1 = utf8.len(string.sub(text, 1, cursorPosition - 1))
    return if var1 == nil then nil else var1 + 1
end

local function placeCursor(arg1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local cursorPosition = byteIndexAt(arg1.Text, num1)
    if cursorPosition ~= nil then
        arg1.CursorPosition = cursorPosition
    end
end

return {
    readCursor = function(arg1)
        return characterIndexAt(arg1.Text, arg1.CursorPosition)
    end,
    placeCursor = placeCursor,
    splice = function(arg1, num1: number, num2: number, str1: string)
        local var1, var2 = utf8Range.splice(arg1.Text, num1, num2, str1)
        if var1 == nil or var2 == nil then
            return false, nil
        end
        arg1.Text = var1
        placeCursor(arg1, var2)
        return true, var2
    end
}
