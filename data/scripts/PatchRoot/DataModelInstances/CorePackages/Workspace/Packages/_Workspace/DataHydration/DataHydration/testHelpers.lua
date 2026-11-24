-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local HttpService = game:GetService("HttpService")

local DataStatus = require(DataHydration.DataHydrationTypes).DataStatus

return {
    jsonOk = function(input)
        return {
            statusCode = 200,
            responseBody = HttpService:JSONEncode(input)
        }
    end,
    awaitReady = function(arg1, num1: number?)
        local num2 = os.clock() + (num1 or 3)

        while arg1.status(false) == DataStatus.NotReady and not (num2 < os.clock()) do
            task.wait()
        end
    end
}
