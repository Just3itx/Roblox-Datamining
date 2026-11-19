-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local scriptParentParent = script.Parent.Parent
local FFlagAXIaBSinglePurchaseUnifiedEvents = require(scriptParentParent.Flags.FFlagAXIaBSinglePurchaseUnifiedEvents)

return makeActionCreator(script.Name, function(itemId, itemType, resalePrice)
    local tbl1 = { itemId = itemId, itemType = itemType, resalePrice = 0 }
    if not FFlagAXIaBSinglePurchaseUnifiedEvents then
        resalePrice = nil
    end

    tbl1.resalePrice = resalePrice
    return tbl1
end)
