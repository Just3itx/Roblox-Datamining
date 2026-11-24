-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local LoggingProtocol = require(InExperienceShopParent.LoggingProtocol)

local function logCounter(arg1, num1: number?)
    LoggingProtocol.default:logRobloxTelemetryCounter(arg1, num1 or 1, {})
end

return logCounter
