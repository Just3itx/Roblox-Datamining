-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffersParent = script:FindFirstAncestor("InExperienceOffers").Parent

local LoggingProtocol = require(InExperienceOffersParent.LoggingProtocol)

local function logCounter(arg1, num1: number?, tbl1)
    LoggingProtocol.default:logRobloxTelemetryCounter(arg1, num1 or 1, tbl1 or {})
end

return logCounter
