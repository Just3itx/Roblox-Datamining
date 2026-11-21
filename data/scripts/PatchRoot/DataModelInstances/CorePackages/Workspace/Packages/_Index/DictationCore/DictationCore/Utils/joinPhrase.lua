-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isSpaceByte(num1: number?): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return num1 == 32 or not (num1 == nil or not (num1 >= 9)) and num1 <= 13
end

local function isBlank(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.find(str1, "%S") == nil
end

local function trim(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if isSpaceByte((string.byte(str1, 1))) or isSpaceByte((string.byte(str1, -1))) then
        if isBlank(str1) then
            return ""
        end

        return string.match(str1, "^%s*(.*%S)") or ""
    end

    return str1
end

local function joinPhrase(str1: string, str2: string)
    local var1 = trim(str2)

    if var1 == "" then
        return str1
    end

    if str1 == "" or isSpaceByte((string.byte(str1, -1))) then
        return str1 .. var1
    end

    return str1 .. " " .. var1
end

return joinPhrase
