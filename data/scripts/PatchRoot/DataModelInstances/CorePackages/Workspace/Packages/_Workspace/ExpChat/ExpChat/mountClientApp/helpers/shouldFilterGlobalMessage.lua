-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2, userId: number?)
    local textSource = arg1.TextSource
    if not textSource then
        return false
    end

    if userId and textSource.UserId == userId then
        return false
    end

    local str1 = string.lower(textSource.Username or "")
    local str2 = string.lower(textSource.DisplayName or "")
    return str1 ~= "" and arg2.isUsernameMuted(str1)
        or str2 ~= "" and arg2.isDisplayNameMuted(str2)
        or arg2.isUserIdMuted(textSource.UserId)
end
