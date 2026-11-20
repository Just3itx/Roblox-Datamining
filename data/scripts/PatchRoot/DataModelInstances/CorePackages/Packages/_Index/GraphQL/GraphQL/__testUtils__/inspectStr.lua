-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function replaceLeadingQuote(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    str1 = string.gsub(str1, "\n\"", "\n`")

    if str1.sub(str1, 1, 1) == "\"" then
        return "`" .. string.sub(str1, 2)
    end

    return str1
end

local function replaceTrailingQuote(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    arg1 = string.gsub(arg1, "\"\n", "`\n")

    if arg1.sub(arg1, -1) == "\"" then
        return string.sub(arg1, 1, -2) .. "`"
    end

    return arg1
end

return {
    inspectStr = function(input: string)
        if input == nil then
            return "nil"
        end
        input = replaceTrailingQuote((replaceLeadingQuote((HttpService:JSONEncode(input)))))

        input = string.gsub(input, "\\\"", "\"")
        return (string.gsub(input, "\\\\", "\\"))
    end
}
