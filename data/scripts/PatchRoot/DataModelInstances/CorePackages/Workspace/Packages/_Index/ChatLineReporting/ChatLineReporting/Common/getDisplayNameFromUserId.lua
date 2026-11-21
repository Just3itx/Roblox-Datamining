-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserService = game:GetService("UserService")

function getDisplayNameFromUserId(str1: string)
    local success, result = pcall(function()
        return UserService:GetUserInfosByUserIdsAsync({ tonumber(str1) })[1]
    end)
    return if success then result.DisplayName else ""
end

return getDisplayNameFromUserId
