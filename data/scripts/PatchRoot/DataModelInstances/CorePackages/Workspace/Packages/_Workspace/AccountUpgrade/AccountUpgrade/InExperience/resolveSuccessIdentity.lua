-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isBlank(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return str1 == nil or str1 == ""
end

local function resolveSuccessIdentity(tbl1, tbl2)
    local username = if tbl1 and not isBlank(tbl1.username) then tbl1.username else nil
    local var1 = username or tbl2.username or ""
    local didUsernameChange = not (username == nil) and username ~= tbl2.username
    local displayName = if tbl1 then tbl1.displayName else nil

    if isBlank(displayName) then
        if didUsernameChange then
            displayName = var1
        else
            displayName = tbl2.displayName
        end
    end
    return { username = var1, displayName = displayName, didUsernameChange = didUsernameChange }
end

return resolveSuccessIdentity
