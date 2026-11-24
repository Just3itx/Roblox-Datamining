-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function getDecodedJSON(input: string)
    local success, result = pcall(function()
        return HttpService:JSONDecode(input)
    end)
    if success then
        return result
    end

    if not (_G.__TEST_SUITE_PACKAGE__ or _G.__TESTEZ_RUNNING_TEST__) then
        warn(debug.traceback("Failed to decode JSON: " .. input))
    end

    return nil
end

return getDecodedJSON
