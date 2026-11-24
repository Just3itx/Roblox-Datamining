-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _creatorApiHttp = require(DataHydration.creatorApiHttp)

return {
    ProductStatusType = {
        Inactive = 1,
        Active = 2,
        ToBeActivated = 3,
        ToBeDeactivated = 4,
        ToBeDeleted = 5,
        Deleted = 6,
        OffSale = 7
    },
    DeveloperSubscriptionProductType = { Consumable = 1, Currency = 2, Durable = 3 },
    CurrencyType = { Robux = 1, Fiat = 2 }
}
