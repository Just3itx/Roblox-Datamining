-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["\""] = "&quot;",
    ["'"] = "&apos;"
}

local function escape(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    return (string.gsub(str1, "[&<>\"']", tbl1))
end

local function findMatchStart(str1: string, str2: string)
    local var1 = string.find(str1, str2, 1, true)
    local var2 = var1

    while true do
        if var1 == nil then
            return var2
        end

        if var1 == 1 then
            break
        end

        local match = string.match

        if match(string.sub(str1, var1 - 1, var1 - 1), "%w") == nil then
            break
        end

        var1 = string.find(str1, str2, var1 + 1, true)
    end

    return var1
end

local function highlightMatchedText(str1: string, str2: string?, color3: Color3)
    if str2 == nil or str2 == "" then
        return (escape(str1))
    end

    local matchStart = findMatchStart(string.lower(str1), string.lower(str2))
    if matchStart == nil then
        return (escape(str1))
    end

    local var1 = matchStart + #str2 - 1
    local str3 = `<font color="#{color3:ToHex()}">`

    local function muted(str4: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
        if str4 == "" then
            return ""
        end

        return `{str3}{escape(str4)}</font>`
    end

    return muted(string.sub(str1, 1, matchStart - 1)) .. `<b>{escape(string.sub(str1, matchStart, var1))}</b>` .. muted(string.sub(str1, var1 + 1))
end

return highlightMatchedText
