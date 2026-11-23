-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function getAccountUpgradeErrorCode(arg1)
    local success, result = pcall(function()
        return HttpService:JSONDecode(arg1.Body)
    end)

    if success and type(result) == "table" then
        return result.errors and result.errors[1] and result.errors[1].code
    end

    return nil
end

return getAccountUpgradeErrorCode
