-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetItemBeingPurchased = require(scriptParentParent.Actions.SetItemBeingPurchased)
local FFlagAXIaBSinglePurchaseUnifiedEvents = require(scriptParentParent.Flags.FFlagAXIaBSinglePurchaseUnifiedEvents)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetItemBeingPurchased.name] = function(_, arg1)
    return {
        itemType = arg1.itemType,
        itemId = arg1.itemId,
        resalePrice = if FFlagAXIaBSinglePurchaseUnifiedEvents then arg1.resalePrice else nil
    }
end

return createReducer({ itemType = nil, itemId = nil, resalePrice = nil }, tbl1)
