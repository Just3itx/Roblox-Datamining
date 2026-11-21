-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function checkAndFormatPossibleLink(str1: string?, str2: string?, str3: string?, str4: string?, str5: string?)
    if str1 == nil or str1 == "" or typeof(str1) ~= "string" then
        return false, str1
    end
    assert(str1 ~= nil, "Text can't be nil")
    assert(typeof(str1) == "string", "Text must be a string")

    local str6 = str2 or "{linkStart}"
    local str7 = str3 or "{linkEnd}"
    local str8 = str4 or "<u><b>"
    local str9 = str5 or "</b></u>"
    local bool1 = not (string.find(str1, str6) == nil) and string.find(str1, str7) ~= nil

    if bool1 then
        return bool1, (string.gsub(str1, str6, str8):gsub(str7, str9))
    end
    return bool1, str1
end

return checkAndFormatPossibleLink
