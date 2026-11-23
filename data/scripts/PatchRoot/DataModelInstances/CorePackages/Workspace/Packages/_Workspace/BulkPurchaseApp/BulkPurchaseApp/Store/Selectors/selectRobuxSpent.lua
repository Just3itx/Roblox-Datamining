-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)

local function selectRobuxSpent(arg1)
    local num1 = 0
    if arg1.itemData and arg1.itemStatuses then
        for _, value in arg1.itemData do
            if arg1.itemStatuses[value.id] == Enum.MarketplaceItemPurchaseStatus.Success then
                num1 += value.priceRobux
            end
        end
    end
    return num1
end

return selectRobuxSpent
