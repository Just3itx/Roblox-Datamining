-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)

return {
    pollIntervalSeconds = 30,
    quotaSummaryUrl = `{Http.Url.APIS_URL}credit-metering-service/v1/quotaSummary`,
    dailyLimitUrl = `{Http.Url.APIS_URL}credit-metering-service/v1/dailyLimit`
}
