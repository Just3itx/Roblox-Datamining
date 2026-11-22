-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getImageUri(str1: string?): string
    if str1 == nil or str1 == "" then
        return ""
    end

    local var1 = string.find(str1, "http://www.roblox.com/asset/?id=", 1, true)
    if var1 and var1 == 1 then
        return `rbxthumb://type=Asset&id={string.sub(str1, 33)}&w=768&h=432`
    elseif tonumber(str1) then
        return `rbxthumb://type=Asset&id={str1}&w=768&h=432`
    end
    return str1
end

return getImageUri
