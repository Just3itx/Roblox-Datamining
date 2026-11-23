-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local _BulkPurchaseRequestOwnedItem = require(script.Parent.Parent.BulkPurchaseRequestOwnedItem)
local getThumbnailUrl = require(BulkPurchaseApp.Utils.getThumbnailUrl)

local function createOwnedItem(arg1)
    return {
        id = arg1.id,
        name = arg1.name,
        image = getThumbnailUrl(arg1.id, arg1.type),
        ownedCount = arg1.ownedCount
    }
end

return createOwnedItem
