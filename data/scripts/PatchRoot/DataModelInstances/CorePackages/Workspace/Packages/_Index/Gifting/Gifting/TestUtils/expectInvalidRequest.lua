-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")

local FailureReason = require(Gifting.Enums.FailureReason)

local function expectInvalidRequest(arg1, arg2)
    local success, result = pcall(function()
        arg2:expect()
    end)

    arg1(success).toBe(false)
    assert(type(result) == "table", `expected a formatted gift error, got {typeof(result)}`)
    arg1(result.failureReason).toBe(FailureReason.InvalidInput)
    arg1(type(result.errorMessage)).toBe("string")
end

return expectInvalidRequest
