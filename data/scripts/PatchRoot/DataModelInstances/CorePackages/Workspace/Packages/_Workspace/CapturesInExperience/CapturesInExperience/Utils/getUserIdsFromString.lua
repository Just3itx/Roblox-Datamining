-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getUserIdsFromString(str1: string)
    local userIdsFromString = ({})

    for _, value in string.split(str1, ",") do
        if tonumber(value) then
            userIdsFromString[value] = true
        end
    end
    return userIdsFromString
end

return getUserIdsFromString
